Línea de Mercado de Capitales (CML)
-----------------------------------

Importar datos
~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020.csv", sep=";", dec=",", header = T)

.. code:: r

    head(datos)
    tail(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>26/03/2018</td><td>2775</td><td>1165</td><td>13080</td><td>25720</td></tr>
    	<tr><th scope=row>2</th><td>27/03/2018</td><td>2645</td><td>1155</td><td>13080</td><td>25700</td></tr>
    	<tr><th scope=row>3</th><td>28/03/2018</td><td>2615</td><td>1165</td><td>13320</td><td>25980</td></tr>
    	<tr><th scope=row>4</th><td>2/04/2018 </td><td>2690</td><td>1165</td><td>13420</td><td>25920</td></tr>
    	<tr><th scope=row>5</th><td>3/04/2018 </td><td>2730</td><td>1175</td><td>13660</td><td>25920</td></tr>
    	<tr><th scope=row>6</th><td>4/04/2018 </td><td>2740</td><td>1190</td><td>13560</td><td>25840</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>495</th><td>3/04/2020 </td><td>2270</td><td>906</td><td>15500</td><td>19700</td></tr>
    	<tr><th scope=row>496</th><td>6/04/2020 </td><td>2260</td><td>955</td><td>16140</td><td>19720</td></tr>
    	<tr><th scope=row>497</th><td>7/04/2020 </td><td>2230</td><td>932</td><td>16680</td><td>20020</td></tr>
    	<tr><th scope=row>498</th><td>8/04/2020 </td><td>2360</td><td>936</td><td>17200</td><td>20700</td></tr>
    	<tr><th scope=row>499</th><td>13/04/2020</td><td>2250</td><td>951</td><td>17860</td><td>21300</td></tr>
    	<tr><th scope=row>500</th><td>14/04/2020</td><td>2220</td><td>955</td><td>18000</td><td>22500</td></tr>
    </tbody>
    </table>
    


Matriz de precios
~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]
    precios = ts(precios)

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

.. code:: r

    rendimientos = diff(log(precios))

.. code:: r

    rendimientos_esperados = apply(rendimientos, 2, mean)
    print(rendimientos_esperados)


.. parsed-literal::

              ECO        PFAVAL           ISA       NUTRESA 
    -0.0004471815 -0.0003983267  0.0006398545 -0.0002680433 
    

Frontera eficiente de Markowitz
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    library(fPortfolio)

.. code:: r

    frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

Gráfico de la frontera eficiente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    frontierPlot(frontera, cex = 2, pch = 19)
    monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
    minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
    equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)



.. image:: output_15_0.png
   :width: 420px
   :height: 420px


Gráficos de proporciones de los portafolios de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    colores = qualiPalette(ncol(rendimientos), "Dark2") # Paleta de colores
    
    weightsPlot(frontera, col = colores)



.. image:: output_17_0.png
   :width: 420px
   :height: 420px


Proporciones de inversión de la frontera
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
    

Ratio de Sharpe
~~~~~~~~~~~~~~~

.. figure:: FormulaSharpe2.jpg
   :alt: 2

   2

.. code:: r

    Rf = 0.00027 #Continua diaria

Los rendimientos esperados de los portafolios de la frontera están en la
segunda columna de ``media_varianza_frontera`` y en la primera columna
están las volatilidades.

.. code:: r

    sharpe = (media_varianza_frontera[,2] - Rf)/media_varianza_frontera[,1]
    print(sharpe)


.. parsed-literal::

                1             2             3             4             5 
    -0.0252038370 -0.0274747138 -0.0301541465 -0.0332142462 -0.0364253736 
                6             7             8             9            10 
    -0.0391468953 -0.0402613812 -0.0391601808 -0.0376844124 -0.0361487645 
               11            12            13            14            15 
    -0.0345588085 -0.0329208376 -0.0312417430 -0.0295288700 -0.0277898602 
               16            17            18            19            20 
    -0.0260324882 -0.0242644998 -0.0224934602 -0.0207266168 -0.0189707828 
               21            22            23            24            25 
    -0.0172322441 -0.0155166898 -0.0138291688 -0.0121740670 -0.0105551068 
               26            27            28            29            30 
    -0.0089753628 -0.0074372913 -0.0059427708 -0.0044931466 -0.0030892363 
               31            32            33            34            35 
    -0.0017315462 -0.0004202408  0.0008447881  0.0020639375  0.0032378600 
               36            37            38            39            40 
     0.0043674180  0.0054536428  0.0064976975  0.0075008451  0.0084644204 
               41            42            43            44            45 
     0.0093898057  0.0102784112  0.0111316575  0.0119509621  0.0127377273 
               46            47            48            49 
     0.0134933320  0.0142191236  0.0149164132  0.0155864710 
    

**Portafolio de la frontera con mayor ratio de Sharpe.**

.. code:: r

    max(sharpe)



.. raw:: html

    0.0155864710130294


El último portafolio de la frontera tiene el mayor ratio de Sharpe.

.. code:: r

    portafolio_sharpe = tail(media_varianza_frontera, 1)
    print(portafolio_sharpe)


.. parsed-literal::

       targetRisk targetReturn
    49  0.0237292 0.0006398545
    

El portafolio con el mayor ratio de Sharpe tiene un rendimiento esperado
diario de 0,064% y volatilidad diaria de 2,37%.

CML
~~~

.. figure:: FormulaCML2.jpg
   :alt: 3

   3

.. figure:: FormulaProporcionesLibre.jpg
   :alt: 4

   4

Se conformarán portafolios de inversión con un activo libre de riesgo y
los portafolios de la frontera.

Con la función ``sep`` creará un vector de proporciones empezando en 0
hasta 1, con saltos de 0,05.

.. code:: r

    proporciones_activo_riesgoso = seq(0, 1, 0.05)
    proporciones_activo_riesgoso



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0</li><li>0.05</li><li>0.1</li><li>0.15</li><li>0.2</li><li>0.25</li><li>0.3</li><li>0.35</li><li>0.4</li><li>0.45</li><li>0.5</li><li>0.55</li><li>0.6</li><li>0.65</li><li>0.7</li><li>0.75</li><li>0.8</li><li>0.85</li><li>0.9</li><li>0.95</li><li>1</li></ol>
    


.. code:: r

    CML = Rf + (portafolio_sharpe[2] - Rf)/(portafolio_sharpe[1])*proporciones_activo_riesgoso*portafolio_sharpe[1]
    print(CML)


.. parsed-literal::

     [1] 0.0002700000 0.0002884927 0.0003069855 0.0003254782 0.0003439709
     [6] 0.0003624636 0.0003809564 0.0003994491 0.0004179418 0.0004364345
    [11] 0.0004549273 0.0004734200 0.0004919127 0.0005104054 0.0005288982
    [16] 0.0005473909 0.0005658836 0.0005843763 0.0006028691 0.0006213618
    [21] 0.0006398545
    

.. code:: r

    frontierPlot(frontera, cex = 2, pch = 19, xlim = c(0, 0.03), ylim = c(-0.0005, 0.0007))
    lines(proporciones_activo_riesgoso*portafolio_sharpe[1], CML, col = "darkgreen", lwd = 3)



.. image:: output_38_0.png
   :width: 420px
   :height: 420px


CML también se puede graficar con la librería ``fPortfolio``.

Primero se debe indicar la tasa libre de riesgo en las especificaciones
de la librería ``portfolioSpec()``.

``Rf = 0.00027``.

.. code:: r

    especificaciones = portfolioSpec()
      `setRiskFreeRate<-`(especificaciones, Rf)



.. parsed-literal::

    
    Model List:	
     Type:                      MV
     Optimize:                  minRisk
     Estimator:                 covEstimator
     Params:                    alpha = 0.05
    
    Portfolio List:	
     Target Weights:            NULL
     Target Return:             NULL
     Target Risk:               NULL
     Risk-Free Rate:            0.00027
     Number of Frontier Points: 50
    
    Optim List:	
     Solver:                    solveRquadprog
     Objective:                 portfolioObjective portfolioReturn portfolioRisk
     Options:                   meq = 2
     Trace:                     FALSE


.. code:: r

    frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly", spec = especificaciones)

La línea CML se grafica con ``tangencyLines`` y el punto tangencial con
``tangencyPoints``.

.. code:: r

    frontierPlot(frontera, cex = 2, pch = 19)
    monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
    minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
    equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)
    tangencyLines(frontera)
    tangencyPoints(frontera, col = "green", cex = 2, pch = 19)



.. image:: output_43_0.png
   :width: 420px
   :height: 420px


Portafolio tangente
~~~~~~~~~~~~~~~~~~~

.. code:: r

    portafolio_tangente = tangencyPortfolio(as.timeSeries(rendimientos), spec = especificaciones, constraints = "LongOnly")
    portafolio_tangente



.. parsed-literal::

    
    Title:
     MV Tangency Portfolio 
     Estimator:         covEstimator 
     Solver:            solveRquadprog 
     Optimize:          minRisk 
     Constraints:       LongOnly 
    
    Portfolio Weights:
        ECO  PFAVAL     ISA NUTRESA 
          0       0       1       0 
    
    Covariance Risk Budgets:
        ECO  PFAVAL     ISA NUTRESA 
          0       0       1       0 
    
    Target Returns and Risks:
      mean    Cov   CVaR    VaR 
    0.0006 0.0237 0.0531 0.0314 
    
    Description:
     Sun May 31 20:31:29 2020 by user: migue 

