pacotes <- c("plotly","tidyverse","knitr","kableExtra","fastDummies","rgl","car",
             "reshape2","jtools","lmtest","caret","pROC","ROCR","nnet","magick",
             "cowplot","cvms","tibble","tidyverse")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

#Carregando dados
credit <- read.table(file = file.choose(), sep = ",",header = FALSE, stringsAsFactors = TRUE)

colnames(credit) <- c("CheckingAcctStat",
                     "Duration",
                     "CreditHistory",
                     "Purpose",
                     "CreditAmount",
                     "SavingsBonds",
                     "Employment",
                     "InstallmentRatePecnt",
                     "SexAndStatus",
                     "OtherDetorsGuarantors",
                     "PresentResidenceTime",
                     "Property",
                     "Age",
                     "OtherInstallments",
                     "Housing",
                     "ExistingCreditsAtBank",
                     "Job",
                     "NumberDependents",
                     "Telephone",
                     "ForeignWorker",
                     "CreditStatus")

#Analise exploratória
View(credit)
str(credit)
summary(credit)

#Variável que era quali porém por ser numerica foi interpretada como INT
credit$ExistingCreditsAtBank <- as.factor(credit$ExistingCreditsAtBank)

#Avaliando as métricas
measures <- c("Duration", "CreditAmount", "InstallmentRatePecnt", "PresentResidenceTime", "Age", "NumberDependents")
for (i in measures){
  my_plot <- ggplot(credit, aes(x=as.factor(CreditStatus), y=credit[,i])) + 
    geom_boxplot(fill="slateblue", alpha=0.2) + 
    ylab(i) +
    xlab("status")
  print(my_plot)
}

#Métricas muito específicas detectadas
#Criando ranges para trasnformá-las em QUALI

measures_to_qualy <- c("Age", "CreditAmount", "Duration")
for(i in measures_to_qualy){
  breaks <- quantile(ceiling(credit[,i]))
  group_tags <- cut(credit[,i], 
                    breaks=round(breaks), 
                    include.lowest=TRUE, 
                    right=FALSE,
                    dig.lab = 5)
  credit[,i] <- group_tags
}


#Dummizando colunas
factors_for_dummy <- c("CheckingAcctStat",
                       "CreditHistory",
                       "Purpose",
                       "SavingsBonds",
                       "Employment",
                       "OtherDetorsGuarantors",
                       "PresentResidenceTime",
                       "Property",
                       "OtherInstallments",
                       "Housing",
                       "Job",
                       "ForeignWorker",
                       "Age", 
                       "CreditAmount", 
                       "Duration"
                       )

credit_dummies <- fastDummies::dummy_cols(.data = credit,
                                        select_columns = factors_for_dummy,
                                        remove_most_frequent_dummy = T,
                                        remove_selected_columns = T)
#Verificando output
str(credit_dummies)

#Tratando variável target
credit_dummies$CreditStatus <- ifelse(credit_dummies$CreditStatus == 1, 0, 1)
credit_dummies$CreditStatus <- as.factor(credit_dummies$CreditStatus)

#Removendo telefone
credit_dummies$Telephone <- NULL

#Treinando primeiro modelo
modelo_credit <- glm(formula = CreditStatus ~ . , 
                      data = credit_dummies, 
                      family = "binomial")
summary(modelo_credit)

#Step Wise para manter apenas variáveis significantes para nosso modelo
modelo_credit_step <- step(modelo_credit, k = qchisq(p = 0.05, df = 1, lower.tail = F))
summary(modelo_credit_step)

#Avaliação da curva ROC
predicoes <- prediction(modelo_credit_step$fitted.values, credit_dummies$CreditStatus)

ROC <- roc(response = credit_dummies$CreditStatus, 
           predictor = modelo_credit_step$fitted.values)

dados_curva_roc <- performance(predicoes, measure = "sens") 

sensitividade <- (performance(predicoes, measure = "sens"))@y.values[[1]] 

especificidade <- (performance(predicoes, measure = "spec"))@y.values[[1]]

cutoffs <- dados_curva_roc@x.values[[1]] 

dados_plotagem <- cbind.data.frame(cutoffs, especificidade, sensitividade)

#Plot para ajudar na tomada de decisão do melhor cutoff para o problema em questão
ggplotly(dados_plotagem %>%
           ggplot(aes(x = cutoffs, y = especificidade)) +
           geom_line(aes(color = "Especificidade"),
                     size = 1) +
           geom_point(color = "#95D840FF",
                      size = 1.9) +
           geom_line(aes(x = cutoffs, y = sensitividade, color = "Sensitividade"),
                     size = 1) +
           geom_point(aes(x = cutoffs, y = sensitividade),
                      color = "#440154FF",
                      size = 1.9) +
           labs(x = "Cutoff",
                y = "Sensitividade/Especificidade") +
           scale_color_manual("Legenda:",
                              values = c("#95D840FF", "#440154FF")) +
           theme_bw())

#Cutoff com acurácia otimizada
confusionMatrix(table(predict(modelo_credit_step, type = "response") >= 0.45,
                      credit_dummies$CreditStatus == 1)[2:1, 2:1])

#Curva ROC para entendimento geral da performance do modelo
ggplotly(
  ggroc(ROC, color = "#440154FF", size = 1) +
    geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1),
                 color="grey40",
                 size = 0.2) +
    labs(x = "Especificidade",
         y = "Sensitividade",
         title = paste("Área abaixo da curva:",
                       round(ROC$auc, 3),
                       "|",
                       "Coeficiente de Gini",
                       round((ROC$auc[1] - 0.5) / 0.5, 3))) +
    theme_bw()
)

predictions <- predict(modelo_credit_step, type = "response") >= 0.45

conf_mat <- confusion_matrix(targets = ifelse(credit_dummies$CreditStatus==1, TRUE, FALSE),
                             predictions = ifelse(predictions, TRUE, FALSE))
plot_confusion_matrix(conf_mat$`Confusion Matrix`[[1]])
