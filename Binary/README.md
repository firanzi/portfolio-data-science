# Binary:

Para estudar este modelo de problema utilizei um data-set de crédito disponibilizado pela UCI.

Após o desenvolvimento do modelo atingi uma área da curva ROC de aproximadamente 83%.

Curva ROC somente de sensitividade para avaliar quanto do fenômeno estudado foi explicado pelo modelo:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242201517_4677342132310848_7116730349597887237_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF6201gPCEVZyH_IM9Vq-Dv2mmekVnSIc3aaZ6RWdIhzTADKSDUnOu3r-PvWGlr5t0wcfOhACN8oeDEwFLb9Hoc&_nc_ohc=kgPMhptmSqAAX_oMbYL&_nc_ht=scontent.fcgh16-1.fna&oh=3b0e7d29939b22beee0e009e58104ec9&oe=616DDF28)

A partir desta curva ROC gerei duas linhas, uma para especificidade e uma para sensitividade, desta forma, fica a critério da área de negócio escolher a métrica que se adequa melhor ao problema estudado.