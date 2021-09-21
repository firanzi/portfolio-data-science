library(ggplot2)
library(dplyr)
library(egg)
library(nnet)
library(cvms)
library(tibble)
library(tidyverse)
library(outliers)

#Carregando arquivo
fish <- read.table(file = file.choose(), sep = ",",header = TRUE, stringsAsFactors = TRUE)
colnames(fish) <- c("species", "weight", "length1","length2","length3","height","width")

summary(fish)
measures <- c("height", "length1", "length2", "length3", "height", "width")
for (i in measures){
  my_plot <- ggplot(fish, aes(x=as.factor(species), y=fish[,i])) + 
    geom_boxplot(fill="slateblue", alpha=0.2) + 
    ylab(i) +
    xlab("species")
  print(my_plot)
}

#Separando as partições
#Whitefish tem 6 registros apenas e Parkki 11
#Dependendo da divisão dos dados os mesmos serão prejudicados no modelo final
#Para resolver este problema separarei 80% de cada classe para treino de forma aleatória:

#Coletando dados das classes dispoíveis de forma dinamica
class_names <- fish %>% 
  group_by(species)%>%
  slice(1)
class_names <- class_names$species

#Criando objetos vazios para receberem dados de treino e teste
fish_train <- fish[0,]
fish_test <- fish[0,]

#removing outliers
for(j in measures){
 outliers <- boxplot(fish[,j], plot=FALSE)$out
 print(j)
 print(outliers)
 if(length(outliers) > 0){
   fish <- (fish[-which(fish[,j] %in% outliers),])
 }
}

#Mecanica para dividir 80% dos dados para cada categoria
for(i in class_names){
  my_subset <- subset(fish, species == i)
  print(my_subset)
  train_ind <- sample(seq_len(nrow(my_subset)),size = floor(0.80 * nrow(my_subset)))
  fish_train <- rbind(fish_train,my_subset[train_ind,]) 
  fish_test <- rbind(fish_test,my_subset[-train_ind,])
}

#Estimacaoo do modelo - funcao multinom do pacote nnet
modelo_tipo_peixe <- multinom(formula = species ~ ., 
                              data = fish_train)

#Funcaoo qui2 para atestarmos se h?? modelo
Qui2 <- function(x) {
  maximo <- logLik(x)
  minimo <- logLik(update(x, ~1, trace = F))
  Qui.Quadrado <- -2*(minimo - maximo)
  pvalue <- pchisq(Qui.Quadrado, df = 1, lower.tail = F)
  df <- data.frame()
  df <- cbind.data.frame(Qui.Quadrado, pvalue)
  return(df)
}

#Como o P value <0.05 entao ha modelo!
Qui2(modelo_tipo_peixe)

#Parametros do modelo_tipo_peixe
summary(modelo_tipo_peixe)

#Armazenando dados para comparacao de modelos
#AIC
modelo_peixe_aic <- modelo_tipo_peixe$AIC

#Funcao para o teste de zWald
zWald_test <- function(x){
  zWald_modelo <- (summary(x)$coefficients / 
                     summary(x)$standard.errors)
  a <- t(apply(zWald_modelo, 1, function(x) {x < qnorm(0.025, lower.tail = FALSE)} ))
  b <- t(apply(zWald_modelo, 1, function(x) {x > -qnorm(0.025, lower.tail = FALSE)} ))
  ifelse(a==TRUE & b==TRUE, TRUE, FALSE)
}

#Se preferir podemos extrair os p-values com a seguinte funcao
pValue_extract <- function(x){
  z <- summary(x)$coefficients/summary(x)$standard.errors
  # 2-tailed Wald z tests to test significance of coefficients
  p <- (1 - pnorm(abs(z), 0, 1)) * 2
  p
}

# Como todos parametros que apresentam TRUE s??o estatisticamente n??o significantes
# Ou seja, stepwise ser?? necess??rio.
zWald_test(modelo_tipo_peixe)
pValue_extract(modelo_tipo_peixe)

#Utilizando stepwise para evitar overfiting e comparando valores entre modelos

step_fish <- step(modelo_tipo_peixe, k= qchisq(p = 0.05, df = 1, lower.tail = F))

#Podemos notar v??rias vari??veis removidas pelo stepwise
summary(step_fish)

#Hamodelo
Qui2(step_fish)

#A quantidade de par??metros significantes para cada classificaao
#Melhorou consider??velmente
zWald_test(step_fish)
pValue_extract(step_fish)

#Reduzimos o AIC quase que pela metade!
#Obtendo assim um modelo muito mais confiavel para dados futuros
step_fish_aic <- step_fish$AIC
step_fish_aic < modelo_peixe_aic

predictions <- predict(step_fish, 
                       newdata = fish_test, 
                       type = "class")

acuracia <- (round((sum(diag(table(fish_test$species, predictions))) / 
                      sum(table(fish_test$species, predictions))), 2))

#Chegamos a precisao de 97% com um valor baixo de AIC
acuracia

#Notamos apenas um erro em nossa amostra.

conf_mat <- confusion_matrix(targets = fish_test$species,
                             predictions = predictions)
plot_confusion_matrix(conf_mat$`Confusion Matrix`[[1]])

#Porém eliminar o vies atraves da remoção de parametros nao significantes e melhorar o AIC consideravelmente
#e utilizando uma mecanica de divisao do data-set que coleta proporcionalmente para cada categoria!
