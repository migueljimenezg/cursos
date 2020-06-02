CAPM
----

Se utilizará una base de datos con los precios de cuatro acciones y los
puntos del índice COLCAP.

La base de datos es de cinco años con frecuencia mensual. Se tienen 61
precios para poder tener 60 rendimientos mensuales y así tener cinco
años en rendimientos.

Los precios fueron descargados de *Investing* , esta página entrega
precios mensuales correspondientes al último día hábil del mes.

Importar datos
~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020 y COLCAP - mensual.csv", sep = ";", dec = ",", header = T)

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
    	<tr><th scope=row>1</th><td>mar-15</td><td>1975</td><td>1165</td><td>7430</td><td>22900</td><td>1304.62</td></tr>
    	<tr><th scope=row>2</th><td>abr-15</td><td>2030</td><td>1210</td><td>8000</td><td>24760</td><td>1396.35</td></tr>
    	<tr><th scope=row>3</th><td>may-15</td><td>1815</td><td>1280</td><td>8190</td><td>22500</td><td>1306.62</td></tr>
    	<tr><th scope=row>4</th><td>jun-15</td><td>1730</td><td>1275</td><td>7350</td><td>22900</td><td>1331.35</td></tr>
    	<tr><th scope=row>5</th><td>jul-15</td><td>1610</td><td>1240</td><td>7080</td><td>22120</td><td>1317.24</td></tr>
    	<tr><th scope=row>6</th><td>ago-15</td><td>1595</td><td>1180</td><td>6640</td><td>19900</td><td>1246.59</td></tr>
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
    	<tr><th scope=row>56</th><td>oct-19</td><td>3040</td><td>1385</td><td>19500</td><td>25640</td><td>1633.15</td></tr>
    	<tr><th scope=row>57</th><td>nov-19</td><td>3290</td><td>1415</td><td>18980</td><td>25900</td><td>1611.92</td></tr>
    	<tr><th scope=row>58</th><td>dic-19</td><td>3315</td><td>1460</td><td>19600</td><td>25400</td><td>1662.42</td></tr>
    	<tr><th scope=row>59</th><td>ene-20</td><td>3180</td><td>1450</td><td>18800</td><td>24760</td><td>1623.83</td></tr>
    	<tr><th scope=row>60</th><td>feb-20</td><td>3105</td><td>1450</td><td>18600</td><td>23420</td><td>1549.61</td></tr>
    	<tr><th scope=row>61</th><td>mar-20</td><td>1900</td><td> 897</td><td>15480</td><td>19100</td><td>1129.18</td></tr>
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
    


Número de rendimientos
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_precios = nrow(datos)
    numero_precios



.. raw:: html

    61


Matriz de rendimientos
~~~~~~~~~~~~~~~~~~~~~~

Se calcularán los rendimientos aritmético o discretos.

.. figure:: FormulaRendimientoDiscretoAritmetico1.jpg
   :alt: 1

   1

Matriz de rendimientos para las acciones ``rendimientos`` y matriz de
rendimientos para el mercado ``rendimientos_mercado``.

En el numerador de la fórmula están las diferencias de los precios, esto
se hará con ``diff(precios)``. El denominador de la fórmula se tiene el
precio inicial, el último rendimiento no tiene en cuenta el último
precio. Se tienen $ n $ precios y $ n - 1$ rendimientos. Se debe
eliminar en el denominador el último precio. Esto se hace eliminando la
última fila con ``precios[-numero_rendimientos,]`` para las acciones y
con ``[-numero_rendimientos]`` para el índice.

.. code:: r

    rendimientos = diff(precios)/precios[-numero_precios,]
    
    rendimientos_mercado = diff(COLCAP)/COLCAP[-numero_precios]

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

             ECO       PFAVAL          ISA      NUTRESA 
     0.005071815 -0.001811731  0.014090848 -0.001424590 
    


.. raw:: html

    -0.000880038519399691


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
    0.10455790 0.06560819 0.06064264 0.05643824 
    


.. raw:: html

    0.0531652503176841


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

    0.010842272059957


Covarianzas entre las acciones y el mercado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se necesita la covarianza de cada acción con respecto al COLCAP.

.. code:: r

    covarianzas_mercado = cov(rendimientos, rendimientos_mercado)
    print(covarianzas_mercado)


.. parsed-literal::

                   [,1]
    ECO     0.003498288
    PFAVAL  0.002961157
    ISA     0.001968475
    NUTRESA 0.002277312
    

Coeficientes de correlación entre las acciones y el mercado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se necesita los coeficientes de correlación de cada acción con respecto
al COLCAP.

.. code:: r

    correlacion_mercado = cor(rendimientos, rendimientos_mercado)
    print(correlacion_mercado)


.. parsed-literal::

                 [,1]
    ECO     0.6293191
    PFAVAL  0.8489371
    ISA     0.6105540
    NUTRESA 0.7589640
    

Primera forma de calcular el Beta de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaBeta1.jpg
   :alt: 1

   1

.. code:: r

    beta = covarianzas_mercado/volatilidad_mercado^2
    print(beta)


.. parsed-literal::

                 [,1]
    ECO     1.2376558
    PFAVAL  1.0476247
    ISA     0.6964248
    NUTRESA 0.8056877
    

Segunda forma de calcular el Beta de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaBeta2.jpg
   :alt: 2

   2

.. code:: r

    beta = volatilidades/volatilidad_mercado*correlacion_mercado
    print(beta)


.. parsed-literal::

                 [,1]
    ECO     1.2376558
    PFAVAL  1.0476247
    ISA     0.6964248
    NUTRESA 0.8056877
    

Tercera forma de calcular el Beta de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La línea de tendencia entre los rendimientos del mercado y los
rendimientos de la acción se obtiene con una regresión lineal, esta
línea tendencia es estimada por mínimo cuadrados ordinarios.

En R, la función ``lm`` realiza la regresión lineal. Entre los
resultados de la regresión está el intercepto y la pendiente de la línea
recta. El coeficiente Beta es la pendiente de la línea recta.

``~`` se obtiene con alt + 126.

.. code:: r

    regresion = lm(rendimientos ~ rendimientos_mercado)
    regresion



.. parsed-literal::

    
    Call:
    lm(formula = rendimientos ~ rendimientos_mercado)
    
    Coefficients:
                          ECO         PFAVAL      ISA         NUTRESA   
    (Intercept)            0.0061610  -0.0008898   0.0147037  -0.0007156
    rendimientos_mercado   1.2376558   1.0476247   0.6964248   0.8056877
    


La segunda fila de los coeficientes de la regresión son las pendientes
de las líneas rectas estimadas, es decir, los coeficientes Betas de cada
acción.

.. code:: r

    beta = regresion$coefficients[2,]
    print(beta)


.. parsed-literal::

          ECO    PFAVAL       ISA   NUTRESA 
    1.2376558 1.0476247 0.6964248 0.8056877 
    

Primera forma de calcular el Beta del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaBeta3.jpg
   :alt: 2

   2

.. code:: r

    beta_portafolio = sum(proporciones*beta)
    beta_portafolio



.. raw:: html

    0.779034222051504


Segunda forma de calcular el Beta del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    regresion_mercado = lm(rendimientos_portafolio ~ rendimientos_mercado)
    regresion_mercado



.. parsed-literal::

    
    Call:
    lm(formula = rendimientos_portafolio ~ rendimientos_mercado)
    
    Coefficients:
             (Intercept)  rendimientos_mercado  
                 0.01153               0.77903  
    


El coeficiente Beta está en la segunda columna, en este caso no la
segunda fila porque los coeficientes no es una matriz, es un vector. La
matriz salió cuando se hicieron varias regresiones lineales al mismo
tiempo como en las acciones.

.. code:: r

    beta_portafolio = regresion_mercado$coefficients[2]
    beta_portafolio



.. raw:: html

    <strong>rendimientos_mercado:</strong> 0.779034222051504


Gráficos
~~~~~~~~

Para que en el gráfico salgan puntos se indica que los rendimientos son
numéricos con: ``as.numeric(rendimientos_mercado)`` y con
``as.numeric(rendimientos[,i])``.

.. code:: r

    for(i in 1: ncol(precios)){
       plot(as.numeric(rendimientos_mercado), as.numeric(rendimientos[,i]), xlab = "Rendimientos del mercado", ylab = "Rendimientos de la acción", main = nombres[i], pch = 19)
       abline(regresion$coefficients[,i], lwd = 3, col = "darkblue") 
    }
    
    plot(as.numeric(rendimientos_mercado), as.numeric(rendimientos_portafolio), xlab = "Rendimientos del mercado", ylab = "Rendimientos de la acción", main = "Portafolio de inversión", pch = 19)
    abline(regresion_mercado$coefficients, lwd = 3, col = "darkblue")



.. image:: output_57_0.png
   :width: 420px
   :height: 420px



.. image:: output_57_1.png
   :width: 420px
   :height: 420px



.. image:: output_57_2.png
   :width: 420px
   :height: 420px



.. image:: output_57_3.png
   :width: 420px
   :height: 420px



.. image:: output_57_4.png
   :width: 420px
   :height: 420px


CAPM mensual
~~~~~~~~~~~~

TES colombiano a 10 años el día 30 de abril de 2020: 6,8% E.A.

Como se está trabajando con rendimientos discretos, se puede utilizar la
:math:`R_f` en tiempo discreto.

.. code:: r

    Rf = 0.06916 #E.A.
    Rf_mensual = (1 + Rf)^(1/12)-1    #Efectivo Mensual.
    Rf_mensual



.. raw:: html

    0.00558833124514835


.. figure:: FormulaCAPM.jpg
   :alt: 3

   3

.. code:: r

    CAPM = Rf_mensual + beta*(rendimiento_esperado_mercado - Rf_mensual)
    print(CAPM)


.. parsed-literal::

              ECO        PFAVAL           ISA       NUTRESA 
    -0.0024172844 -0.0011880925  0.0010835978  0.0003768452 
    

.. code:: r

    CAPM_portafolio = Rf_mensual + beta_portafolio*(rendimiento_esperado_mercado - Rf_mensual)
    CAPM_portafolio



.. raw:: html

    <strong>rendimientos_mercado:</strong> 0.000549249837682195


CAPM diario
~~~~~~~~~~~

Se debe convertir el rendimiento esperado del mercado a diario y la tasa
libre de riesgo a Efectiva Diaria.

.. code:: r

    Rf_diaria = (1 + Rf)^(1/250)-1    #Efectivo Diaria.
    Rf_diaria



.. raw:: html

    0.000267528953226348


.. figure:: ConvertirRendimiento.jpg
   :alt: 2

   2

.. code:: r

    rendimiento_esperado_mercado_diario = rendimiento_esperado_mercado/20
    rendimiento_esperado_mercado_diario



.. raw:: html

    -4.40019259699845e-05


.. code:: r

    CAPM_portafolio = Rf_diaria + beta_portafolio*(rendimiento_esperado_mercado_diario - Rf_diaria)
    CAPM_portafolio



.. raw:: html

    <strong>rendimientos_mercado:</strong> 2.4835737106612e-05


CAPM anual
~~~~~~~~~~

Se debe convertir el rendimiento esperado del mercado a anual.

.. figure:: ConvertirRendimiento2.jpg
   :alt: 2

   2

.. code:: r

    rendimiento_esperado_mercado_anual = rendimiento_esperado_mercado*12
    rendimiento_esperado_mercado_anual



.. raw:: html

    -0.0105604622327963


.. code:: r

    CAPM_portafolio = Rf + beta_portafolio*(rendimiento_esperado_mercado_anual - Rf)
    CAPM_portafolio



.. raw:: html

    <strong>rendimientos_mercado:</strong> 0.00705503172288723


Beta ajustado
~~~~~~~~~~~~~

.. figure:: BetaAjustado.jpg
   :alt: 3

   3

.. code:: r

    beta_ajustado = 2/3*beta + 1/3
    print(beta_ajustado)


.. parsed-literal::

          ECO    PFAVAL       ISA   NUTRESA 
    1.1584372 1.0317498 0.7976166 0.8704585 
    

.. code:: r

    beta_portafolio_ajustado = 2/3*beta_portafolio + 1/3
    beta_portafolio_ajustado



.. raw:: html

    <strong>rendimientos_mercado:</strong> 0.852689481367669


CAPM con beta ajustado
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CAPM = Rf_mensual + beta_ajustado*(rendimiento_esperado_mercado - Rf_mensual)
    print(CAPM)


.. parsed-literal::

              ECO        PFAVAL           ISA       NUTRESA 
    -1.904869e-03 -1.085408e-03  4.290524e-04 -4.211603e-05 
    

.. code:: r

    CAPM_portafolio = Rf_mensual + beta_portafolio_ajustado*(rendimiento_esperado_mercado - Rf_mensual)
    CAPM_portafolio



.. raw:: html

    <strong>rendimientos_mercado:</strong> 7.28203853215675e-05

