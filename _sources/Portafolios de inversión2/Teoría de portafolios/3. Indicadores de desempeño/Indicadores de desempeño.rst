Indicadores de desempeño
------------------------

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


Proporciones de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.10, 0.05, 0.75, 0.10)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.1</li><li>0.05</li><li>0.75</li><li>0.1</li></ol>
    


Rendimientos del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

Rendimiento esperado del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    0.000388452091136383


Volatilidad del portafolio de inversión portafolio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.01982711424517


Tasa libre de riesgo
~~~~~~~~~~~~~~~~~~~~

Tasa libre de riesgo de TES colombiano a 10 año con fecha del 14 de
abril de 2020.

Esta tasa está expresada en E.A y como se está trabajando con
rendimientos continuos, se debe utilizar la :math:`R_f` en tiempo
continuo.

.. code:: r

    Rf = 0.06916 #E.A.
    Rf = log(1 + Rf)  #Continua anual
    Rf_diario = Rf/250  #Continua diario
    Rf_diario



.. raw:: html

    0.000267493173737161


Beta de cada acción
~~~~~~~~~~~~~~~~~~~

Valores calculados con precios mensuales en otro código.

.. code:: r

    beta = c(1.23765583817092, 1.04762467584509, 0.696424844336778, 0.805687711895736)
    beta



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1.23765583817092</li><li>1.04762467584509</li><li>0.696424844336778</li><li>0.805687711895736</li></ol>
    


.. code:: r

    beta_portafolio = sum(proporciones*beta)
    beta_portafolio



.. raw:: html

    0.779034222051504


Indicadores de desempeño
~~~~~~~~~~~~~~~~~~~~~~~~

**\* Ratio de Sharpe:**

.. figure:: FormulaSharpe4.jpg
   :alt: 1

   1

.. code:: r

    sharpe = (rendimiento_esperado_portafolio - Rf_diario)/volatilidad_portafolio
    sharpe



.. raw:: html

    0.00610068191989606


Por cada unidad de volatilidad, el portafolio tuvo un exceso de
rentabilidad de 0,0061 unidades por día.

**\* Ratio de Treynor:**

.. figure:: FormulaTreynorPortafolio2.jpg
   :alt: 2

   2

.. code:: r

    treynor =  (rendimiento_esperado_portafolio - Rf_diario)/beta_portafolio
    treynor



.. raw:: html

    0.000155267784104131


Por cada unidad de riesgo sistemático, el portafolio tuvo un exceso de
rentabilidad de 0,02% diario.

Por cada unidad de riesgo sistemático, el portafolio entregó una prima
de 0,02% diario.

Por cada unidad de riesgo sistemático, el portafolio generó 0,02% diario
de rendimiento por encima de la tasa libre de riesgo.

**\* Alfa de Jensen:**

.. figure:: AlfaJensenPortafolios2.jpg
   :alt: 3

   3

.. code:: r

    jensen = (rendimiento_esperado_portafolio - Rf_diario) - (rendimiento_esperado_mercado - Rf_diario)*beta_portafolio
    jensen



.. raw:: html

    0.000630831680585222


El portafolio entregó un 0,06% diario de prima de rentabilidad por
encima de la prima por riesgo del portafolio.

El rendimiento del portafolio está por encima del rendimiento estimado
por CAPM en un 0,06% diario.

Indicadores de desempeño anualizados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**\* Ratio de Sharpe:**

.. figure:: FormulaSharpe4.jpg
   :alt: 1

   1

.. code:: r

    sharpe = (rendimiento_esperado_portafolio*250 - Rf)/(volatilidad_portafolio*sqrt(250))
    sharpe



.. raw:: html

    0.0964602507354023


Por cada unidad de volatilidad, el portafolio tuvo un exceso de
rentabilidad de 0,0965 unidades por año.

**\* Ratio de Treynor:**

.. figure:: FormulaTreynorPortafolio2.jpg
   :alt: 2

   2

.. code:: r

    treynor =  (rendimiento_esperado_portafolio*250 - Rf)/beta_portafolio
    treynor



.. raw:: html

    0.0388169460260326


Por cada unidad de riesgo sistemático, el portafolio tuvo un exceso de
rentabilidad de 3,88% por año.

Por cada unidad de riesgo sistemático, el portafolio entregó una prima
de 3,88% anual.

Por cada unidad de riesgo sistemático, el portafolio generó 3,88% anual
de rendimiento por encima de la tasa libre de riesgo.

**\* Alfa de Jensen:**

.. figure:: AlfaJensenPortafolios2.jpg
   :alt: 3

   3

.. code:: r

    jensen = (rendimiento_esperado_portafolio*250 - Rf) - (rendimiento_esperado_mercado*250 - Rf)*beta_portafolio
    jensen



.. raw:: html

    0.157707920146305


El portafolio entregó un 15,77% anual de prima de rentabilidad por
encima de la prima por riesgo del portafolio.

El rendimiento del portafolio está por encima del rendimiento estimado
por CAPM en un 15,77% anual.
