# Linear Model: 

Para estudar este modelo de problema utilizei um data-set de despesas médicas disponibilizado pelo Kaggle.

Inicialmente notei alta quantidade de valores exclusivos em algumas variáveis, desta forma optei por converter variáveis Quantitativas (métricas) para Qualitativas que funcionariam como ranges.
Ex.: Idade de 20 a 30 anos.

Ao modelar, após o step-wise notei que havia muita dispersão nos resíduos, então optei por aplicar box-cox na variável Y (dependente) para que os dados se tornem mais aderentes a distribuição normal.

Gráficos de resíduos ajustados com box-cox para modelos lineares:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242405995_4676012222443839_4573273404806404936_n.jpg?_nc_cat=110&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF36oYD2iiQswFo2uSQm1jpuOMU3aDnhvO44xTdoOeG8xGheiZXSxyOur9hF8rdAM8swr7nJWfBcfgN5O7PKqLN&_nc_ohc=-6-AOXr-5eIAX-jS43p&_nc_ht=scontent.fcgh16-1.fna&oh=677d42a4d706223936e4f9b6269a6524&oe=616E8AD4)

Após a transformação de box-cox, o modelo apresentou grande crescimento de R2 ajustado, chegando a 0.90.

Scatter-Plots utilizando o modelo desenvolvido:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242325407_4677674158944312_5584879766830696017_n.jpg?_nc_cat=101&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeHtJyTHEi6z7MK5xrGw9crM4FYKT2P-sYfgVgpPY_6xh37jPh6_y2tMCC5rbZZ3gnS6sitdYpdmi-VrVUtdPRxG&_nc_ohc=7iRfdOs-BbcAX-RTOSi&tn=izXvqEPPHYaBl4Ql&_nc_ht=scontent.fcgh16-1.fna&oh=35a95a2456d20187b42fe0acfa0651de&oe=616DD097)
