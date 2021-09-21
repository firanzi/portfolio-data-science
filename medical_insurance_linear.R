library(PerformanceAnalytics)
library(fastDummies)
library(nortest)
library(olsrr)
library(car)
library(ggplot2)
library(MASS)
library(dplyr)
library(egg)
library(randomForest)
library(nnet)

#Carga do arquivo
medic <- read.table(file = file.choose(), sep = ",",header = TRUE, stringsAsFactors = TRUE)
head(medic)
str(medic)

#Dummies
medic_dummies_list <- c("sex",
                        "smoker",
                        "region")

medic_dummies <- fastDummies::dummy_cols(.data = medic,
                                        select_columns = medic_dummies_list,
                                        remove_most_frequent_dummy = T,
                                        remove_selected_columns = T)

#testando o primeiro modelo usando todas variaveis
medic_model <- lm(charges ~ ., data = medic_dummies)
summary(medic_model)

#Notei muitas variaveis não significativas para meu modelo, desta forma utilizarei o stepwise utilizando o intervalo de confiança de 0.05

step_medic_model <- step(medic_model, k = qchisq(p = 0.05, df = 1, lower.tail = F))
summary(step_medic_model)

#Teste de colinearidade
sf.test(step_medic_model$residuals)
#Teste de heterodasticidade
ols_test_breusch_pagan(step_medic_model)

#O teste de heterodasticidade passou

fitted <- predict(step_medic_model, medic_dummies)

medic_dummies$predicted <- fitted

medic_dummies$fitted_step <- step_medic_model$residuals
medic_dummies$residuos_step <- step_medic_model$fitted.values

#Porém olhando o gráfico de resíduos mostrou alta dispersão
plot_out <- medic_dummies %>%
  ggplot()+
  geom_point(aes(x = fitted_step, y = residuos_step),
             size = 3, color = "#55c667ff")+
  labs(y= "fitted values", x = "residuals")
plot_out

#Testando box-cox

#Resolvendo heterodasticidade com
#BOX COX
lambda_BC <- powerTransform(medic_dummies$charges)
lambda_BC

medic_dummies$bccharges <- (((medic_dummies$charges ^ lambda_BC$lambda) -1)/lambda_BC$lambda)

modelo_bc_medic_model <- lm(bccharges ~ .  -charges, data = medic_dummies)
summary(modelo_bc_medic_model)

#Stepwise para remover variáveis não significantes
step_modelo_bc_medic <- step(modelo_bc_medic_model, k = qchisq(p = 0.05, df = 1, lower.tail = F))
summary(step_modelo_bc_medic)

sf.test(step_modelo_bc_medic$residuals)
ols_test_breusch_pagan(step_modelo_bc_medic)

medic_dummies$fitted_step_bc <- step_modelo_bc_medic$fitted.values
medic_dummies$residuos_step_bc <- step_modelo_bc_medic$residuals

#Notamos grande melhora na dispersão e o modelo apresentou grande crescimento
#no R2 ajustado!

plot_out_bc <- medic_dummies %>%
  ggplot()+
  geom_point(aes(x = fitted_step_bc, y = residuos_step_bc),
             size = 3, color = "#55c667ff")+
  labs(y= "fitted values", x = "residuals") 

ggarrange(plot_out, plot_out_bc, 
          labels = c("Without box-cox", "With box-cox"),
          ncol = 1, nrow = 2)
