# Clustering:

Para estudar este modelo de problema utilizei um data-set de vinhos disponibilizado pela UCI com objetivo de agrupar Vinhos.

A primeira abordagem pensada foram os modelos hierárquicos de agrupamento, primeiramente avaliei o elbow (cotovelo) para definir o número de grupos que se adequa ao meu caso de estudo:

ELBOW:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242700021_4679185182126543_3512743740040760858_n.jpg?_nc_cat=100&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF6LrYs5T5XGa3eNT1-R1O0679PE07g9gbrv08TTuD2BmB4cUJtJ7vf7_51AhBk4wNVTJcSHA4aNvoDDQWEF7lb&_nc_ohc=MvuulyMS-5QAX-lWSuP&_nc_ht=scontent.fcgh16-1.fna&oh=be1e26eb3ed412b90e6bae18cc2d9826&oe=616FDFDC)

A partir daí, apliquei a divisão de grupos no meu modelo hierarquico.

Divisão de grupos:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242461962_4679189345459460_8269510127269278401_n.jpg?_nc_cat=104&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeG7kaF1SNY0rL_smgR3JbGXtOuXcmc363e065dyZzfrd5et_9axc6aBus3oMniUmiDuQHfpFMswOr0811YHdwQO&_nc_ohc=yUhiqesjaWsAX9nZ5Fy&_nc_ht=scontent.fcgh16-1.fna&oh=540bf942b3cb6ff772f0dd16bc99cdb5&oe=61700209)

Logo de cara notamos que a divisão não ficou nem de perto a ideal, os grupos ficaram muito diferentes, dos três grupos, dois possuiam apenas 1 observação: 

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242532004_4679188858792842_7639171741690818525_n.jpg?_nc_cat=105&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeFVZZhkeXXekh92oW1QjBwAvV4pzTKNfDW9XinNMo18Nfihk55PZZXf3hVDbnJPgf_QPKDWkqWXJKXzt-p7nNAk&_nc_ohc=rx7IBleSIUAAX-xxP7o&_nc_ht=scontent.fcgh16-1.fna&oh=5460f5c705f632ad15f0e83c2bfe29fc&oe=6170F9A6)

A abordagem seguinte foi a de modelos não hierárquicos (k-means).
Optei por criar 4 modelos com diferentes números de centróides para que pudesse avaliar a diferença de cada um, apesar de já ter uma ideia de que 3 seria o número de centróides que apresentaria a melhor divisão pelo ELBOW estudado anteriormente:

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242491039_4679192782125783_2371432011498097557_n.jpg?_nc_cat=105&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeF2nWBIXmR_JTHcmzEf7PlQp1wu37rmrQ2nXC7fuuatDe7v67KdGHNq5wECUL-6nu0ibSSju_fsc6HdVIDG-IFg&_nc_ohc=Z-UO6xg5AzEAX9C6XWh&_nc_ht=scontent.fcgh16-1.fna&oh=df861c024376045e00eaf692bb4fda58&oe=6170948E)

Não só visualmente como ELBOW nos mostrou, a decisão de 3 grupos apresentou melhor divisão dos dados, porém isso também depende de estratégias de negócio e cabe a avaliação de cada grupo dividido.

![alt text](https://scontent.fcgh16-1.fna.fbcdn.net/v/t1.6435-9/242489214_4679215682123493_3541488769833481008_n.jpg?_nc_cat=106&_nc_rgb565=1&ccb=1-5&_nc_sid=730e14&_nc_eui2=AeGlGYV214GkRPXW6GqfF9DzJEXVILZWWPkkRdUgtlZY-WymFU0u-IsKzBqhaz2ITToqqZXrwSLVM2g73njJ6AV_&_nc_ohc=qJdCf5DeRGQAX9qBfao&_nc_ht=scontent.fcgh16-1.fna&oh=b41b910218b445fd241bac79378d3efb&oe=616EDCB0)
