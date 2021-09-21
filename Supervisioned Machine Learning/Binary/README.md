# Binary:

Para estudar este modelo de problema utilizei um data-set de crédito disponibilizado pela UCI.

Após o desenvolvimento do modelo atingi uma área da curva ROC de aproximadamente 83%.

Curva ROC somente de sensitividade para avaliar quanto do fenômeno estudado foi explicado pelo modelo:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242201517_4677342132310848_7116730349597887237_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF6201gPCEVZyH_IM9Vq-Dv2mmekVnSIc3aaZ6RWdIhzTADKSDUnOu3r-PvWGlr5t0wcfOhACN8oeDEwFLb9Hoc&_nc_ohc=kgPMhptmSqAAX_oMbYL&_nc_ht=scontent.fcgh16-1.fna&oh=3b0e7d29939b22beee0e009e58104ec9&oe=616DDF28)

A partir desta curva ROC gerei duas linhas, uma para especificidade e uma para sensitividade, desta forma, fica a critério da área de negócio escolher a métrica que se adequa melhor ao problema estudado.

Curva ROC para definir cutoff avaliando especificidade e sensitividade:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242367540_4676016415776753_8686378322359018609_n.jpg?_nc_cat=107&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeGcz5b4fqltca2o7oRBfvr-04P0pgDCsA3Tg_SmAMKwDc8vrJ1kj4LwusHtViSAQ-pPHr_98Ss0TatdRQkKvsJl&_nc_ohc=lgalGTgRFs4AX-BwKxu&_nc_ht=scontent.fcgh16-1.fna&oh=a01a746415ad9b893763e0be7bc6a9bf&oe=616ECF01)

Para atingir a Acurácia (precisão geral do modelo) otimizada, optei por um cutoff de 0.45, que deu origem a seguinte matriz de confusão:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242321278_4677395448972183_8695501780341339304_n.jpg?_nc_cat=104&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeEiWN5jvUbyBFMxX2MXbrnasp3gQ5r9I3yyneBDmv0jfFchVC_04VH6lLW47yKbHeknWEqcKF9aRWvy2Dk-a9tP&_nc_ohc=d7ZH1LmzgpUAX-yzkmT&_nc_ht=scontent.fcgh16-1.fna&oh=50d4c8a6fc0610595470220cfb206c56&oe=617097BE)
