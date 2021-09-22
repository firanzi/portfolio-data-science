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
wine <- read.table(file = "https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", sep = ",",header = FALSE, stringsAsFactors = TRUE)
head(wine)

colnames(wine)<-c("alcohol",
                  "malic_acid",
                  "ash",
                  "alcalinity_of_ash",
                  "magnesium",
                  "total_phenols",
                  "flavanoids",
                  "nonflavanoid_phenols",
                  "proanthocyanins",
                  "color_intensity",
                  "hue",
                  "od_diluted",
                  "proline")
wine <- wine[,-14]

wine.padronizado <- scale(wine)

#calcular as distancias da matriz utilizando a distancia euclidiana
distancia <- dist(wine.padronizado, method = "euclidean")

#Calcular o Cluster: metodos disponiveis "average", "single", "complete" e "ward.D"
cluster.hierarquico <- hclust(distancia, method = "single" )

# Dendrograma
plot(cluster.hierarquico, cex = 0.6, hang = -1)

#Criar o grafico e destacar os grupos
rect.hclust(cluster.hierarquico, k = 2)

#VERIFICANDO ELBOW 
fviz_nbclust(wine.padronizado, FUN = hcut, method = "wss")

#criando 4 grupos de lanches
grupo_wine3 <- cutree(cluster.hierarquico, k = 4)
table(grupo_wine3)

wine_grupos <- data.frame(grupo_wine3)


Base_wine_fim <- cbind(wine, wine_grupos)

#FAZENDO ANALISE DESCRITIVA
#MEDIAS das variaveis por grupo
mediagrupo <- Base_wine_fim %>% 
  group_by(grupo_wine3) %>% 
  summarise(n = n(),
            alcohol = mean(alcohol), 
            malic_acid = mean(malic_acid), 
            ash = mean(ash),
            alcalinity_of_ash = mean(alcalinity_of_ash), 
            magnesium = mean(magnesium), 
            total_phenols = mean(total_phenols),
            flavanoids = mean(flavanoids), 
            nonflavanoid_phenols = mean(nonflavanoid_phenols), 
            proanthocyanins = mean(proanthocyanins),
            color_intensity = mean(color_intensity), 
            hue = mean(hue),
            od_diluted = mean(od_diluted))
mediagrupo

#Rodar o modelo
wine.k2 <- kmeans(wine.padronizado, centers = 2)

#Visualizar os clusters
fviz_cluster(wine.k2, data = wine.padronizado, main = "Cluster K2")

#Criar clusters
wine.k3 <- kmeans(wine.padronizado, centers = 3)
wine.k4 <- kmeans(wine.padronizado, centers = 4)
wine.k5 <- kmeans(wine.padronizado, centers = 5)

#Criar graficos
G1 <- fviz_cluster(wine.k2, geom = "point", data = wine.padronizado) + ggtitle("k = 2")
G2 <- fviz_cluster(wine.k3, geom = "point",  data = wine.padronizado) + ggtitle("k = 3")
G3 <- fviz_cluster(wine.k4, geom = "point",  data = wine.padronizado) + ggtitle("k = 4")
G4 <- fviz_cluster(wine.k5, geom = "point",  data = wine.padronizado) + ggtitle("k = 5")

#Imprimir graficos na mesma tela
grid.arrange(G1, G2, G3, G4, nrow = 2)

fviz_nbclust(wine.padronizado, kmeans, method = "wss")
