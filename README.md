# Data Science Portfolio
Portfólio pessoal para cargos de Data Science

# Linear Model: 

Para estudar este modelo de problema utilizei um data-set de despesas médicas disponibilizados pela UCI.

Ao modelar, após o step-wise notei que havia muita dispersão nos resíduos, então optei por aplicar box-cox na variável Y (dependente) para que os dados se tornem mais aderentes a distribuição normal.

Gráficos de resíduos ajustados com box-cox para modelos lineares:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242405995_4676012222443839_4573273404806404936_n.jpg?_nc_cat=110&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF36oYD2iiQswFo2uSQm1jpuOMU3aDnhvO44xTdoOeG8xGheiZXSxyOur9hF8rdAM8swr7nJWfBcfgN5O7PKqLN&_nc_ohc=-6-AOXr-5eIAX-jS43p&_nc_ht=scontent.fcgh16-1.fna&oh=677d42a4d706223936e4f9b6269a6524&oe=616E8AD4)

Após a transformação de box-cox, o modelo apresentou grande crescimento de R2 ajustado, chegando a 0.90.

Scatter-Plots utilizando o modelo desenvolvido:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242325407_4677674158944312_5584879766830696017_n.jpg?_nc_cat=101&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeHtJyTHEi6z7MK5xrGw9crM4FYKT2P-sYfgVgpPY_6xh37jPh6_y2tMCC5rbZZ3gnS6sitdYpdmi-VrVUtdPRxG&_nc_ohc=7iRfdOs-BbcAX-RTOSi&tn=izXvqEPPHYaBl4Ql&_nc_ht=scontent.fcgh16-1.fna&oh=35a95a2456d20187b42fe0acfa0651de&oe=616DD097)

# Binary:

Curva ROC para definir cutoff avaliando especificidade e sensitividade:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242367540_4676016415776753_8686378322359018609_n.jpg?_nc_cat=107&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeGcz5b4fqltca2o7oRBfvr-04P0pgDCsA3Tg_SmAMKwDc8vrJ1kj4LwusHtViSAQ-pPHr_98Ss0TatdRQkKvsJl&_nc_ohc=lgalGTgRFs4AX-BwKxu&_nc_ht=scontent.fcgh16-1.fna&oh=a01a746415ad9b893763e0be7bc6a9bf&oe=616ECF01)

Curva ROC somente de sensitividade para avaliar quanto do fenômeno estudado foi explicado pelo modelo:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242201517_4677342132310848_7116730349597887237_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF6201gPCEVZyH_IM9Vq-Dv2mmekVnSIc3aaZ6RWdIhzTADKSDUnOu3r-PvWGlr5t0wcfOhACN8oeDEwFLb9Hoc&_nc_ohc=kgPMhptmSqAAX_oMbYL&_nc_ht=scontent.fcgh16-1.fna&oh=3b0e7d29939b22beee0e009e58104ec9&oe=616DDF28)

Matriz de confusão:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242321278_4677395448972183_8695501780341339304_n.jpg?_nc_cat=104&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEiWN5jvUbyBFMxX2MXbrnasp3gQ5r9I3yyneBDmv0jfFchVC_04VH6lLW47yKbHeknWEqcKF9aRWvy2Dk-a9tP&_nc_ohc=d7ZH1LmzgpUAX-yzkmT&_nc_ht=scontent.fcgh16-1.fna&oh=50d4c8a6fc0610595470220cfb206c56&oe=617097BE)

# Multi-class:

Matriz de confusão:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242438090_4676040112441050_47115357313311048_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEljbOZjFdb_QJqvYEEwIvZpZVneiZifaCllWd6JmJ9oNjPi15g87J21I87xZAupZSBWFyBcf1OS8fUcLAhu2jk&_nc_ohc=6r_1YDn4SXkAX9G9tBS&_nc_ht=scontent.fcgh16-1.fna&oh=c46a7bc7a1a9fd2cef3b61f6b9fc283d&oe=616F7F57)

Fonte dos dados utilizados em cada modelo e seus respectivos dicionários de dados:

- credit_binary: https://archive.ics.uci.edu/ml/datasets/statlog+(german+credit+data)
- fish_classification: https://www.kaggle.com/aungpyaeap/fish-market
- medical_insurance_linear: https://www.kaggle.com/mirichoi0218/insurance
