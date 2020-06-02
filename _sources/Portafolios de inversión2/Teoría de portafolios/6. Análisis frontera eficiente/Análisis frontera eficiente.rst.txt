Análisis frontera eficiente
---------------------------

Se calcularán los indicadores de desempeño a los portafolios de la
frontera.

Se utilizará una base de datos con los precios de cuatro acciones y los
puntos del índice COLCAP con frecuencia diaria.

Importar datos
~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020 y COLCAP.csv", sep = ";", dec = ",", header = T)

.. code:: r

    head(datos)
    tail(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 6</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th><th scope=col>COLCAP</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>26/03/2018</td><td>2775</td><td>1165</td><td>13080</td><td>25720</td><td>1469.04</td></tr>
    	<tr><th scope=row>2</th><td>27/03/2018</td><td>2645</td><td>1155</td><td>13080</td><td>25700</td><td>1450.00</td></tr>
    	<tr><th scope=row>3</th><td>28/03/2018</td><td>2615</td><td>1165</td><td>13320</td><td>25980</td><td>1455.52</td></tr>
    	<tr><th scope=row>4</th><td>2/04/2018 </td><td>2690</td><td>1165</td><td>13420</td><td>25920</td><td>1470.88</td></tr>
    	<tr><th scope=row>5</th><td>3/04/2018 </td><td>2730</td><td>1175</td><td>13660</td><td>25920</td><td>1492.84</td></tr>
    	<tr><th scope=row>6</th><td>4/04/2018 </td><td>2740</td><td>1190</td><td>13560</td><td>25840</td><td>1497.59</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 6</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th><th scope=col>COLCAP</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>495</th><td>3/04/2020 </td><td>2270</td><td>906</td><td>15500</td><td>19700</td><td>1127.55</td></tr>
    	<tr><th scope=row>496</th><td>6/04/2020 </td><td>2260</td><td>955</td><td>16140</td><td>19720</td><td>1160.12</td></tr>
    	<tr><th scope=row>497</th><td>7/04/2020 </td><td>2230</td><td>932</td><td>16680</td><td>20020</td><td>1163.43</td></tr>
    	<tr><th scope=row>498</th><td>8/04/2020 </td><td>2360</td><td>936</td><td>17200</td><td>20700</td><td>1187.13</td></tr>
    	<tr><th scope=row>499</th><td>13/04/2020</td><td>2250</td><td>951</td><td>17860</td><td>21300</td><td>1193.98</td></tr>
    	<tr><th scope=row>500</th><td>14/04/2020</td><td>2220</td><td>955</td><td>18000</td><td>22500</td><td>1211.06</td></tr>
    </tbody>
    </table>
    


Matriz de precios
~~~~~~~~~~~~~~~~~

Se tendrá un objeto para los precios de las acciones ``precios`` y otro
para el mercado ``COLCAP``.

Los precios de las acciones están entre las columnas 2 y 5 de ``datos``
y el COLCAP está en la columna 6.

.. code:: r

    precios = datos[, 2:5]
    precios = ts(precios)
    
    COLCAP = datos[,6]
    COLCAP = ts(COLCAP)

Nombres de las acciones
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    nombres = colnames(precios)
    nombres



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>'ECO'</li><li>'PFAVAL'</li><li>'ISA'</li><li>'NUTRESA'</li></ol>
    


Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

Matriz de rendimientos para las acciones ``rendimientos`` y matriz de
rendimientos para el mercado ``rendimientos_mercado``.

.. code:: r

    rendimientos = diff(log(precios))
    
    rendimientos_mercado = diff(log(COLCAP))

Rendimientos esperado de cada acción y del mercado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rendimientos esperados de las acciones ``rendimientos_esperados`` y
rendimiento esperado del mercado ``rendimiento_esperado_mercado``.

.. code:: r

    rendimientos_esperados = apply(rendimientos, 2, mean)
    print(rendimientos_esperados)
    
    rendimiento_esperado_mercado = mean(rendimientos_mercado)
    rendimiento_esperado_mercado


.. parsed-literal::

              ECO        PFAVAL           ISA       NUTRESA 
    -0.0004471815 -0.0003983267  0.0006398545 -0.0002680433 
    


.. raw:: html

    -0.000387000234579747


Volatilidad de cada acción y del mercado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``volatilidades`` para las acciones y ``volatilidad_mercado`` para el
COLCAP.

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    print(volatilidades)
    
    volatilidad_mercado = sd(rendimientos_mercado)
    volatilidad_mercado


.. parsed-literal::

           ECO     PFAVAL        ISA    NUTRESA 
    0.03193244 0.02855772 0.02372920 0.01401047 
    


.. raw:: html

    0.0161376694676898


Frontera eficiente de Markowitz
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    library(fPortfolio)

.. code:: r

    frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

Gráfico de la frontera
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    frontierPlot(frontera, cex = 2, pch = 19)
    monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
    minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
    equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)



.. image:: output_24_0.png
   :width: 420px
   :height: 420px


Proporciones de inversión de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones_frontera = getWeights(frontera)
    print(proporciones_frontera)


.. parsed-literal::

                  ECO      PFAVAL        ISA    NUTRESA
     [1,] 0.627055608 0.342516126 0.00000000 0.03042827
     [2,] 0.532194109 0.302671538 0.00000000 0.16513435
     [3,] 0.437332609 0.262826950 0.00000000 0.29984044
     [4,] 0.342471109 0.222982362 0.00000000 0.43454653
     [5,] 0.247609609 0.183137774 0.00000000 0.56925262
     [6,] 0.152748109 0.143293186 0.00000000 0.70395871
     [7,] 0.057886609 0.103448598 0.00000000 0.83866479
     [8,] 0.012448495 0.082369546 0.01244463 0.89273733
     [9,] 0.012089095 0.078406404 0.03623993 0.87326458
    [10,] 0.011729696 0.074443262 0.06003522 0.85379182
    [11,] 0.011370296 0.070480121 0.08383051 0.83431907
    [12,] 0.011010897 0.066516979 0.10762581 0.81484632
    [13,] 0.010651497 0.062553837 0.13142110 0.79537357
    [14,] 0.010292098 0.058590696 0.15521639 0.77590082
    [15,] 0.009932698 0.054627554 0.17901168 0.75642806
    [16,] 0.009573299 0.050664412 0.20280698 0.73695531
    [17,] 0.009213899 0.046701271 0.22660227 0.71748256
    [18,] 0.008854500 0.042738129 0.25039756 0.69800981
    [19,] 0.008495100 0.038774987 0.27419286 0.67853706
    [20,] 0.008135701 0.034811846 0.29798815 0.65906430
    [21,] 0.007776302 0.030848704 0.32178344 0.63959155
    [22,] 0.007416902 0.026885562 0.34557874 0.62011880
    [23,] 0.007057503 0.022922421 0.36937403 0.60064605
    [24,] 0.006698103 0.018959279 0.39316932 0.58117330
    [25,] 0.006338704 0.014996137 0.41696462 0.56170054
    [26,] 0.005979304 0.011032996 0.44075991 0.54222779
    [27,] 0.005619905 0.007069854 0.46455520 0.52275504
    [28,] 0.005260505 0.003106712 0.48835049 0.50328229
    [29,] 0.004411873 0.000000000 0.51217215 0.48341597
    [30,] 0.001788542 0.000000000 0.53608946 0.46212200
    [31,] 0.000000000 0.000000000 0.56017148 0.43982852
    [32,] 0.000000000 0.000000000 0.58460640 0.41539360
    [33,] 0.000000000 0.000000000 0.60904131 0.39095869
    [34,] 0.000000000 0.000000000 0.63347623 0.36652377
    [35,] 0.000000000 0.000000000 0.65791115 0.34208885
    [36,] 0.000000000 0.000000000 0.68234607 0.31765393
    [37,] 0.000000000 0.000000000 0.70678099 0.29321901
    [38,] 0.000000000 0.000000000 0.73121590 0.26878410
    [39,] 0.000000000 0.000000000 0.75565082 0.24434918
    [40,] 0.000000000 0.000000000 0.78008574 0.21991426
    [41,] 0.000000000 0.000000000 0.80452066 0.19547934
    [42,] 0.000000000 0.000000000 0.82895558 0.17104442
    [43,] 0.000000000 0.000000000 0.85339049 0.14660951
    [44,] 0.000000000 0.000000000 0.87782541 0.12217459
    [45,] 0.000000000 0.000000000 0.90226033 0.09773967
    [46,] 0.000000000 0.000000000 0.92669525 0.07330475
    [47,] 0.000000000 0.000000000 0.95113016 0.04886984
    [48,] 0.000000000 0.000000000 0.97556508 0.02443492
    [49,] 0.000000000 0.000000000 0.99999999 0.00000000
    

Media-varianza de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    media_varianza_frontera = frontierPoints(frontera)
    print(media_varianza_frontera)


.. parsed-literal::

       targetRisk  targetReturn
    1  0.02757505 -4.249971e-04
    2  0.02448843 -4.028126e-04
    3  0.02157674 -3.806282e-04
    4  0.01892091 -3.584438e-04
    5  0.01664388 -3.362594e-04
    6  0.01492009 -3.140750e-04
    7  0.01395607 -2.918906e-04
    8  0.01378202 -2.697062e-04
    9  0.01373305 -2.475218e-04
    10 0.01370275 -2.253374e-04
    11 0.01369124 -2.031530e-04
    12 0.01369858 -1.809686e-04
    13 0.01372472 -1.587842e-04
    14 0.01376957 -1.365998e-04
    15 0.01383294 -1.144153e-04
    16 0.01391457 -9.223094e-05
    17 0.01401416 -7.004653e-05
    18 0.01413131 -4.786212e-05
    19 0.01426560 -2.567771e-05
    20 0.01441655 -3.493303e-06
    21 0.01458364  1.869111e-05
    22 0.01476633  4.087551e-05
    23 0.01496403  6.305992e-05
    24 0.01517617  8.524433e-05
    25 0.01540214  1.074287e-04
    26 0.01564136  1.296131e-04
    27 0.01589321  1.517976e-04
    28 0.01615712  1.739820e-04
    29 0.01643250  1.961664e-04
    30 0.01671909  2.183508e-04
    31 0.01701648  2.405352e-04
    32 0.01732437  2.627196e-04
    33 0.01764230  2.849040e-04
    34 0.01796974  3.070884e-04
    35 0.01830617  3.292728e-04
    36 0.01865112  3.514572e-04
    37 0.01900411  3.736416e-04
    38 0.01936471  3.958260e-04
    39 0.01973250  4.180105e-04
    40 0.02010709  4.401949e-04
    41 0.02048810  4.623793e-04
    42 0.02087518  4.845637e-04
    43 0.02126800  5.067481e-04
    44 0.02166625  5.289325e-04
    45 0.02206963  5.511169e-04
    46 0.02247787  5.733013e-04
    47 0.02289070  5.954857e-04
    48 0.02330789  6.176701e-04
    49 0.02372920  6.398545e-04
    attr(,"control")
      targetRisk targetReturn         auto 
           "Cov"       "mean"       "TRUE" 
    

Tasa libre de riesgo
~~~~~~~~~~~~~~~~~~~~

Tasa libre de riesgo de TES colombiano a 10 año con fecha del 14 de
abril de 2020.

.. code:: r

    Rf = 0.06916 #E.A.
    Rf = log(1+(1+ Rf)^(1/250) - 1)  #Continua diaria
    Rf



.. raw:: html

    0.000267493173736943


Beta de cada acción
~~~~~~~~~~~~~~~~~~~

Valores calculados con precios mensuales en un código anterior.

.. code:: r

    beta = c(1.23765583817092, 1.04762467584509, 0.696424844336778, 0.805687711895736)
    print(beta)


.. parsed-literal::

    [1] 1.2376558 1.0476247 0.6964248 0.8056877
    

Beta de cada portafolio de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaBetaPortaqfolio.jpg
   :alt: 1

   1

.. code:: r

    beta_portafolios = apply(proporciones_frontera*beta, 1, sum)
    print(beta_portafolios)


.. parsed-literal::

     [1] 1.1594231 0.9727072 0.8304460 0.8545292 0.9569550 1.1310742 1.0022669
     [8] 0.7467365 0.8259195 1.1692025 1.0425101 0.7714271 0.8110635 1.1369404
    [15] 1.0649377 0.7961178 0.7962074 1.1046782 1.0873653 0.8208084 0.7813513
    [22] 1.0724161 1.1097929 0.8454990 0.7664952 1.0401540 1.1322205 0.8701897
    [29] 0.7516321 1.0057424 1.1540747 0.9017385 0.7391421 0.9640143 1.1726483
    [36] 0.9360647 0.7284628 0.9217939 1.1912219 0.9703908 0.7177835 0.8795735
    [43] 1.2097955 1.0047170 0.7071042 0.8373530 1.2283690 1.0390431 0.6964248
    

CAPM de cada portafolio de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaCAPM2.jpg
   :alt: 2

   2

.. code:: r

    CAPM_portafolios = Rf + beta_portafolios*(rendimiento_esperado_mercado - Rf)
    print(CAPM_portafolios)


.. parsed-literal::

     [1] -0.0004913416 -0.0003691372 -0.0002760282 -0.0002917905 -0.0003588275
     [6] -0.0004727875 -0.0003884839 -0.0002212409 -0.0002730657 -0.0004977422
    [11] -0.0004148228 -0.0002374008 -0.0002633425 -0.0004766268 -0.0004295015
    [16] -0.0002535607 -0.0002536193 -0.0004555115 -0.0004441802 -0.0002697205
    [21] -0.0002438961 -0.0004343961 -0.0004588589 -0.0002858804 -0.0002341729
    [26] -0.0004132807 -0.0004735377 -0.0003020402 -0.0002244451 -0.0003907586
    [31] -0.0004878411 -0.0003226887 -0.0002162705 -0.0003634478 -0.0004999974
    [36] -0.0003451550 -0.0002092809 -0.0003358148 -0.0005121537 -0.0003676212
    [41] -0.0002022914 -0.0003081819 -0.0005243100 -0.0003900875 -0.0001953018
    [46] -0.0002805489 -0.0005364663 -0.0004125537 -0.0001883123
    

Indicador de diversificación de cada portafolio de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    h = 1 - media_varianza_frontera[,1]/sum(volatilidades)
    print(h)


.. parsed-literal::

            1         2         3         4         5         6         7         8 
    0.7192803 0.7507027 0.7803443 0.8073812 0.8305619 0.8481105 0.8579243 0.8596962 
            9        10        11        12        13        14        15        16 
    0.8601948 0.8605032 0.8606203 0.8605457 0.8602795 0.8598230 0.8591779 0.8583468 
           17        18        19        20        21        22        23        24 
    0.8573330 0.8561403 0.8547732 0.8532365 0.8515355 0.8496758 0.8476631 0.8455035 
           25        26        27        28        29        30        31        32 
    0.8432030 0.8407678 0.8382038 0.8355172 0.8327138 0.8297962 0.8267688 0.8236344 
           33        34        35        36        37        38        39        40 
    0.8203978 0.8170644 0.8136394 0.8101278 0.8065342 0.8028632 0.7991191 0.7953057 
           41        42        43        44        45        46        47        48 
    0.7914269 0.7874864 0.7834874 0.7794331 0.7753266 0.7711707 0.7669679 0.7627209 
           49 
    0.7584318 
    

Indicadores de desempeño de cada portafolio de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Ratio de Sharpe:**

.. figure:: FormulaSharpe3.jpg
   :alt: 3

   3

.. code:: r

    sharpe_portafolios = (media_varianza_frontera[,2] - Rf)/media_varianza_frontera[,1]
    print(sharpe_portafolios)


.. parsed-literal::

                1             2             3             4             5 
    -0.0251129278 -0.0273723460 -0.0300379646 -0.0330817565 -0.0362747580 
                6             7             8             9            10 
    -0.0389788785 -0.0400817586 -0.0389782896 -0.0375018727 -0.0359658211 
               11            12            13            14            15 
    -0.0343757114 -0.0327378386 -0.0310590926 -0.0293468145 -0.0276086387 
               16            17            18            19            20 
    -0.0258523298 -0.0240856217 -0.0223160651 -0.0205508916 -0.0187968976 
               21            22            23            24            25 
    -0.0170603510 -0.0153469234 -0.0136616453 -0.0120088852 -0.0103923485 
               26            27            28            29            30 
    -0.0088150937 -0.0072795619 -0.0057876177 -0.0043405937 -0.0029392983 
               31            32            33            34            35 
    -0.0015842286 -0.0002755414  0.0009868800  0.0022034402  0.0033747989 
               36            37            38            39            40 
     0.0045018242  0.0055855525  0.0066271508  0.0076278856  0.0085890941 
               41            42            43            44            45 
     0.0095121609  0.0103984976  0.0112495260  0.0120666640  0.0128513145 
               46            47            48            49 
     0.0136048562  0.0143286365  0.0150239659  0.0156921141 
    

**\* Ratio de Treynor:**

.. figure:: FormulaTreynorPortafolio.jpg
   :alt: 4

   4

.. code:: r

    treynor_portafolios =  (media_varianza_frontera[,2] - Rf)/beta_portafolios
    print(treynor_portafolios)


.. parsed-literal::

                1             2             3             4             5 
    -5.972714e-04 -6.891137e-04 -7.804498e-04 -7.324934e-04 -6.309101e-04 
                6             7             8             9            10 
    -5.141733e-04 -5.581186e-04 -7.193962e-04 -6.235655e-04 -4.215100e-04 
               11            12            13            14            15 
    -4.514548e-04 -5.813404e-04 -5.255783e-04 -3.554214e-04 -3.586205e-04 
               16            17            18            19            20 
    -4.518479e-04 -4.239344e-04 -2.854725e-04 -2.696158e-04 -3.301458e-04 
               21            22            23            24            25 
    -3.184254e-04 -2.113150e-04 -1.842085e-04 -2.155518e-04 -2.088264e-04 
               26            27            28            29            30 
    -1.325573e-04 -1.021847e-04 -1.074607e-04 -9.489590e-05 -4.886181e-05 
               31            32            33            34            35 
    -2.335896e-05 -5.293751e-06  2.355546e-05  4.107329e-05  5.268387e-05 
               36            37            38            39            40 
     8.969899e-05  1.457157e-04  1.392208e-04  1.263554e-04  1.779713e-04 
               41            42            43            44            45 
     2.715110e-04  2.467906e-04  1.977648e-04  2.602119e-04  4.011060e-04 
               46            47            48            49 
     3.652081e-04  2.670147e-04  3.370187e-04  5.346756e-04 
    

**\* Alfa de Jensen:**

.. figure:: AlfaJensenPortafolios.jpg
   :alt: 5

   5

.. code:: r

    jensen_portafolios = (media_varianza_frontera[,2] - Rf) - (rendimiento_esperado_mercado - Rf)*beta_portafolios
    print(jensen_portafolios)


.. parsed-literal::

                1             2             3             4             5 
     6.634452e-05 -3.367540e-05 -1.046000e-04 -6.665329e-05  2.256812e-05 
                6             7             8             9            10 
     1.587124e-04  9.659328e-05 -4.846525e-05  2.554393e-05  2.724048e-04 
               11            12            13            14            15 
     2.116698e-04  5.643224e-05  1.045584e-04  3.400271e-04  3.150862e-04 
               16            17            18            19            20 
     1.613297e-04  1.835728e-04  4.076493e-04  4.185025e-04  2.662272e-04 
               21            22            23            24            25 
     2.625872e-04  4.752716e-04  5.219189e-04  3.711247e-04  3.416016e-04 
               26            27            28            29            30 
     5.428939e-04  6.253352e-04  4.760222e-04  4.206115e-04  6.091094e-04 
               31            32            33            34            35 
     7.283763e-04  5.854083e-04  5.011745e-04  6.705362e-04  8.292702e-04 
               36            37            38            39            40 
     6.966122e-04  5.829226e-04  7.316409e-04  9.301641e-04  8.078161e-04 
               41            42            43            44            45 
     6.646706e-04  7.927455e-04  1.031058e-03  9.190200e-04  7.464187e-04 
               46            47            48            49 
     8.538502e-04  1.131952e-03  1.030224e-03  8.281668e-04 
    
