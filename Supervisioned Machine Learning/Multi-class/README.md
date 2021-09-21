# Multi-class:

Para estudar este modelo de problema utilizei um data-set FISH MARKET (mercado de peixes) disponibilizado pelo Kaggle.

Neste caso de estudo notei um cenário de falta de dados para algumas classes e alguns outliers, logo, houve a remoção de outliers e a divisão de variáveis de treino e testes dinâmicamente por cada classe. Ao inves de pegar do total geral 80% de todos os dados, foram separados 80% de cada classe, para que assim todas classes possuíssem dados para o modelo final.

Após a modelagem utilizando o método Multinom do pacote nnet, graças ao step-wise notei a queda do valor de AIC de aproximadamente 50% e a precisão atingiu 97%.

Matriz de confusão:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242438090_4676040112441050_47115357313311048_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEljbOZjFdb_QJqvYEEwIvZpZVneiZifaCllWd6JmJ9oNjPi15g87J21I87xZAupZSBWFyBcf1OS8fUcLAhu2jk&_nc_ohc=6r_1YDn4SXkAX9G9tBS&_nc_ht=scontent.fcgh16-1.fna&oh=c46a7bc7a1a9fd2cef3b61f6b9fc283d&oe=616F7F57)
