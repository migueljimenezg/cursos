Taller N° 1: VaR método Delta-Normal o varianzas-covarianzas
------------------------------------------------------------

Portafolio de inversión conformado por las siguientes acciones:

1. Facebook, Inc. (FB).

2. The Coca-Cola Company (KO).

3. Kellogg Company (K).

4. Ford Motor Company (F).

5. McDonald’s Corporation (MCD).

Utilizar una base de datos de precios diarios desde primero de abril de
2018 hasta el 21 de abril de 2020.

Importar datos desde *Yahoo Finance.*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    library(quantmod)
    library(tseries)

La fecha final debe ser el 22 de abril de 2020 para que descargue hasta
el 21 de abril de 2020.

.. code:: r

    FB = get.hist.quote(instrument = "FB", start = as.Date("2018-04-01"), end = as.Date("2020-04-22"), quote = "AdjClose")


.. parsed-literal::

    time series starts 2018-04-02
    time series ends   2020-04-21
    

.. code:: r

    KO = get.hist.quote(instrument = "KO", start = as.Date("2018-04-01"), end = as.Date("2020-04-22"), quote = "AdjClose")


.. parsed-literal::

    time series starts 2018-04-02
    time series ends   2020-04-21
    

.. code:: r

    K = get.hist.quote(instrument = "K", start = as.Date("2018-04-01"), end = as.Date("2020-04-22"), quote = "AdjClose")


.. parsed-literal::

    time series starts 2018-04-02
    time series ends   2020-04-21
    

.. code:: r

    F = get.hist.quote(instrument = "F", start = as.Date("2018-04-01"), end = as.Date("2020-04-22"), quote = "AdjClose")


.. parsed-literal::

    time series starts 2018-04-02
    time series ends   2020-04-21
    

.. code:: r

    MCD = get.hist.quote(instrument = "MCD", start = as.Date("2018-04-01"), end = as.Date("2020-04-22"), quote = "AdjClose")


.. parsed-literal::

    time series starts 2018-04-02
    time series ends   2020-04-21
    

Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = merge(FB, KO, K, F, MCD)

.. code:: r

    precios = ts(precios)

.. code:: r

    print(head(precios))


.. parsed-literal::

         Adjusted.FB Adjusted.KO Adjusted.K Adjusted.F Adjusted.MCD
    [1,]      155.39    39.61916   58.16813   9.572072     149.2148
    [2,]      156.11    40.27839   58.39851   9.827681     151.7503
    [3,]      155.10    41.07690   59.83614   9.986334     153.0085
    [4,]      159.34    41.22546   59.49516  10.003963     155.1088
    [5,]      157.20    40.77978   59.20026   9.854123     152.5544
    [6,]      157.93    40.69621   59.42144   9.915821     152.5355
    

.. code:: r

    dim(precios)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>518</li><li>5</li></ol>
    


Se cargaron cinco acciones cada una con 518 precios.

Número de acciones.
~~~~~~~~~~~~~~~~~~~

.. code:: r

    acciones = ncol(precios)
    acciones



.. raw:: html

    5


Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

.. code:: r

    dim(rendimientos)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>517</li><li>5</li></ol>
    


Hay 517 rendimientos por acción.

:math:`S_0:`\ Precio actual de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    s = tail(precios,1)
    s = as.numeric(s)
    s



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>170.800003</li><li>44.971439</li><li>64.949127</li><li>4.77</li><li>176.403854</li></ol>
    


Número de acciones del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_acciones = c(2000, 5000, 2000, 10000, 1000)
    numero_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>2000</li><li>5000</li><li>2000</li><li>10000</li><li>1000</li></ol>
    


Valor de mercado de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_mercado_acciones = numero_acciones*s
    valor_mercado_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>341600.006</li><li>224857.195</li><li>129898.254</li><li>47700</li><li>176403.854</li></ol>
    


Valor de mercado del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_portafolio = sum(valor_mercado_acciones)
    valor_portafolio



.. raw:: html

    920459.309


Proporciones de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = valor_mercado_acciones/valor_portafolio
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.371119073553745</li><li>0.244288034029758</li><li>0.141123298694348</li><li>0.0518219540327339</li><li>0.191647639689415</li></ol>
    


.. code:: r

    sum(proporciones)



.. raw:: html

    1


:math:`\mu:` Rendimiento esperado de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_esperados = apply(rendimientos,2,mean)
    print(rendimientos_esperados)


.. parsed-literal::

      Adjusted.FB   Adjusted.KO    Adjusted.K    Adjusted.F  Adjusted.MCD 
     0.0001828921  0.0002450962  0.0002132818 -0.0013472019  0.0003237701 
    

:math:`\sigma:`\ Volatilidad de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos,2,sd)
    print(volatilidades)


.. parsed-literal::

     Adjusted.FB  Adjusted.KO   Adjusted.K   Adjusted.F Adjusted.MCD 
      0.02415253   0.01563877   0.01749543   0.02410755   0.01889120 
    

Matriz varianzas-covarianzas.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    covarianzas = cov(rendimientos)
    print(covarianzas)


.. parsed-literal::

                  Adjusted.FB  Adjusted.KO   Adjusted.K   Adjusted.F Adjusted.MCD
    Adjusted.FB  5.833447e-04 0.0001283637 6.003732e-05 2.767284e-04 2.073812e-04
    Adjusted.KO  1.283637e-04 0.0002445710 1.304011e-04 1.783455e-04 1.617992e-04
    Adjusted.K   6.003732e-05 0.0001304011 3.060901e-04 9.705185e-05 8.338021e-05
    Adjusted.F   2.767284e-04 0.0001783455 9.705185e-05 5.811738e-04 2.592786e-04
    Adjusted.MCD 2.073812e-04 0.0001617992 8.338021e-05 2.592786e-04 3.568773e-04
    

Coeficientes de correlación.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    correlaciones = cor(rendimientos)
    print(correlaciones)


.. parsed-literal::

                 Adjusted.FB Adjusted.KO Adjusted.K Adjusted.F Adjusted.MCD
    Adjusted.FB    1.0000000   0.3398420  0.1420804  0.4752675    0.4545139
    Adjusted.KO    0.3398420   1.0000000  0.4766003  0.4730496    0.5476644
    Adjusted.K     0.1420804   0.4766003  1.0000000  0.2301051    0.2522777
    Adjusted.F     0.4752675   0.4730496  0.2301051  1.0000000    0.5693170
    Adjusted.MCD   0.4545139   0.5476644  0.2522777  0.5693170    1.0000000
    

Rendimientos del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio=vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

Rendimiento esperado del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    0.000150083000310905


Volatilidad del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0150049023025908


Volatilidad del portafolio a partir de la matriz de varianzas-covarianzas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sqrt(sum(t(proporciones)%*%covarianzas*proporciones))
    volatilidad_portafolio



.. raw:: html

    0.0150049023025908


Preguntas
~~~~~~~~~

-  Una semana tiene 5 días bursátiles.

-  Un mes tiene 20 días bursátiles.

-  Un año tiene 250 días bursátiles.

-  Un mes tiene 4 semanas.

-  Un año tiene 52 semanas.

1. Con un nivel de confianza del 95%, ¿Cuál es el VaR (sin promedios) semanal de la acción de FB en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    t = 5

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[1]



.. raw:: html

    <strong>Adjusted.FB:</strong> 30345.3922167117


2. Con un nivel de confianza del 95%, ¿Cuál es el VaR (sin promedios) semanal de la acción de F en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    t = 5

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[4]



.. raw:: html

    <strong>Adjusted.F:</strong> 4229.44773575843


3. Con un nivel de confianza del 99%, ¿Cuál es el VaR (sin promedios) semanal de la acción de MCD en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 5

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[5]



.. raw:: html

    <strong>Adjusted.MCD:</strong> 17335.132992473


4. Con un nivel de confianza del 99%, ¿Cuál es el VaR (sin promedios) semanal de la acción de K en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 5

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[3]



.. raw:: html

    <strong>Adjusted.K:</strong> 11821.9082393174


5. Con un nivel de confianza del 99%, ¿Cuál es el VaR (sin promedios) semanal del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 5

.. code:: r

    VaR_portafolio_sin_promedios = sqrt(sum(t(VaR_individuales_sin_promedios)%*%correlaciones*VaR_individuales_sin_promedios))
    VaR_portafolio_sin_promedios



.. raw:: html

    71845.1451728881


6. Con un nivel de confianza del 99%, ¿Cuál es el VaR (sin promedios) diario de la acción F en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 1

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[1]



.. raw:: html

    <strong>Adjusted.FB:</strong> 19193.5431918965


7. Con un nivel de confianza del 99%, ¿Cuál es el VaR (sin promedios) diario de la acción KO en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 1

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    VaR_individuales_sin_promedios[2]



.. raw:: html

    <strong>Adjusted.KO:</strong> 8180.57684795557


8. Con un nivel de confianza del 97,5%, ¿Cuál es el VaR (sin promedios) diario del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.975
    t = 1

.. code:: r

    VaR_portafolio_sin_promedios = sqrt(sum(t(VaR_individuales_sin_promedios)%*%correlaciones*VaR_individuales_sin_promedios))
    VaR_portafolio_sin_promedios



.. raw:: html

    32130.1256919837


9. Con un nivel de confianza del 99%, ¿Cuál es el VaR (con promedios) semanal de la acción KO en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 5

.. code:: r

    VaR_individuales_con_promedios = valor_mercado_acciones*abs(rendimientos_esperados*t+qnorm(1-NC,sd=volatilidades*sqrt(t)))
    VaR_individuales_con_promedios[2]



.. raw:: html

    <strong>Adjusted.KO:</strong> 18016.7676540538


10. Con un nivel de confianza del 95%, ¿Cuál es el VaR (con promedios) mensual de la acción F en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    t = 20

.. code:: r

    VaR_individuales_con_promedios = valor_mercado_acciones*abs(rendimientos_esperados*t+qnorm(1-NC,sd=volatilidades*sqrt(t)))
    VaR_individuales_con_promedios[4]



.. raw:: html

    <strong>Adjusted.F:</strong> 9744.12609289399


11. Con un nivel de confianza del 99%, ¿Cuál es el VaR (con promedios) mensual del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    t = 20

.. code:: r

    VaR_portafolio_con_promedios = sqrt(sum(t(VaR_individuales_con_promedios)%*%correlaciones*VaR_individuales_con_promedios))
    VaR_portafolio_con_promedios



.. raw:: html

    99509.7001373678


12. Con un nivel de confianza del 98%, ¿Cuál es el VaR (con promedios) mensual del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.98
    t = 20

.. code:: r

    VaR_portafolio_con_promedios = sqrt(sum(t(VaR_individuales_con_promedios)%*%correlaciones*VaR_individuales_con_promedios))
    VaR_portafolio_con_promedios



.. raw:: html

    99509.7001373678


13. Con un nivel de confianza del 99%, ¿Cuál es el Beneficios por Diversificación (BD) diario del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Nota: usar el método de VaR (sin promedios).**

.. code:: r

    NC = 0.99
    t = 1

.. code:: r

    VaR_individuales_sin_promedios = valor_mercado_acciones*volatilidades*qnorm(NC)*sqrt(t)
    
    VaR_portafolio_sin_promedios = sqrt(sum(t(VaR_individuales_sin_promedios)%*%correlaciones*VaR_individuales_sin_promedios))
    
    suma_VaR_individuales_sin_promedios = sum(VaR_individuales_sin_promedios)
    
    BD_sin_promedios=suma_VaR_individuales_sin_promedios-VaR_portafolio_sin_promedios
    BD_sin_promedios



.. raw:: html

    10958.5567987463


14. Con un nivel de confianza del 99%, ¿Cuál es el Beneficios por Diversificación (BD) diario del portafolio de inversión en términos monetarios?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Nota: usar el método de VaR (con promedios).**

.. code:: r

    NC = 0.99
    t = 1

.. code:: r

    VaR_individuales_con_promedios = valor_mercado_acciones*abs(rendimientos_esperados*t+qnorm(1-NC,sd=volatilidades*sqrt(t)))
    
    VaR_portafolio_con_promedios = sqrt(sum(t(VaR_individuales_con_promedios)%*%correlaciones*VaR_individuales_con_promedios))
    
    suma_VaR_individuales_con_promedios = sum(VaR_individuales_con_promedios)
    
    BD_con_promedios = suma_VaR_individuales_con_promedios-VaR_portafolio_con_promedios
    BD_con_promedios



.. raw:: html

    10925.0841289928


Gráficos
~~~~~~~~

Precios de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(precios, col = "darkblue", lwd = 2, xlab = "Tiempo", main = "Precios")



.. image:: output_96_0.png
   :width: 420px
   :height: 420px


Rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(rendimientos, col = "darkblue", lwd = 2, xlab = "Tiempo", main = "Rendimientos")



.. image:: output_98_0.png
   :width: 420px
   :height: 420px

