Simulación de cobertura con opciones
------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("TRM diaria febrero 2020.csv", sep = ";", dec = ",")

.. code:: r

    head(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 2</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>TRM</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>20/04/2018</td><td>2724.47</td></tr>
    	<tr><th scope=row>2</th><td>23/04/2018</td><td>2757.96</td></tr>
    	<tr><th scope=row>3</th><td>24/04/2018</td><td>2799.45</td></tr>
    	<tr><th scope=row>4</th><td>25/04/2018</td><td>2785.22</td></tr>
    	<tr><th scope=row>5</th><td>26/04/2018</td><td>2820.29</td></tr>
    	<tr><th scope=row>6</th><td>27/04/2018</td><td>2812.83</td></tr>
    </tbody>
    </table>
    


Vector de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,2]
    precios = ts(precios)

Rendimientos continuos
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Gráfico de los precios
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(precios, main = "Precio", lwd = 3)



.. image:: output_9_0.png
   :width: 420px
   :height: 420px


Gráfico de los rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(rendimientos, main = "Rendimientos", t = "h")



.. image:: output_11_0.png
   :width: 420px
   :height: 420px


:math:`S_0:`
~~~~~~~~~~~~

.. code:: r

    s = tail(precios,1)
    s = as.numeric(s)
    s



.. raw:: html

    3401.56


:math:`\mu:` Rendimiento esperado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    mu = mean(rendimientos) #diario
    mu



.. raw:: html

    0.000504455082133001


:math:`\sigma:`\ Volatilidad
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad = sd(rendimientos) #diaria
    volatilidad



.. raw:: html

    0.00641517094088037


Estrategias de cobertura con opciones financieras
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Call.jpg
   :alt: Call

   Call

.. figure:: SpreadComprador.jpg
   :alt: Spread Comprador

   Spread Comprador

.. figure:: Put.jpg
   :alt: Put

   Put

.. figure:: SpreadVendedor.jpg
   :alt: Spread Vendedor

   Spread Vendedor

Valoración de una opción europea sobre divisas con vencimiento a un mes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Estrategias de cobertura para compradores:**

-  **Call:**

.. math::  PrecioCobertura = |-S_T + máx[S_T - K_1,0] - primaCall_1| 

-  **Spread:**

.. math::  PrecioCobertura = |-S_T + máx[S_T - K_1,0] - primaCall_1 + mín[K_2 - S_T,0] + primaCall_2| 

**Estrategias de cobertura para vendedores:**

-  **Put:**

.. math::  PrecioCobertura = S_T + máx[K_1 - S_T,0] - primaPut_1 

-  **Spread:**

.. math::  PrecioCobertura = S_T + mín[S_T - K_1,0] + primaPut_1 + máx[K_2 - S_T,0] - primaPut_2 

:math:`K_1 = 3.400`.

:math:`K_2 = 3.450`.

.. code:: r

    k1 = 3400
    k2 = 3450

.. code:: r

    # Tasas libres de riesgo
    
    r = 0.018 # E.A. (Colombia)
    
    rf = 0.003 # Nominal (USA)
    
    # Con el modelo Black-Scholes se trabaja con tasas continuas:
    
    r = log(1+r) # C.C.A.
    
    rf = log(1+rf/12)*12 # C.C.A.

.. code:: r

    T = 30 # 1 mes
    dt = 1 # saltos diarios
    iteraciones = 10000

.. code:: r

    set.seed(1) # Valor semilla para la simulación. Con esto siempre se obtendrá el mismo valor.

.. code:: r

    # Simulación del precio del activo subyacente con un mundo neutral al riesgo
    
    st_prima = matrix(, iteraciones, T+1)
    
    st_prima[,1] = s
    
    for(i in 1:iteraciones){
        
        for(j in 2:(T+1)){
            
       st_prima[i,j] = st_prima[i,j-1]*exp((r/360-rf/360-volatilidad^2/2)*dt+volatilidad*sqrt(dt)*rnorm(1)) 
            
       }
    }

.. code:: r

    compensacionesCall1 = vector()
    compensacionesCall2 = vector()
    compensacionesPut1 = vector()
    compensacionesPut2 = vector()
    
    for(i in 1:iteraciones){
        
        compensacionesCall1[i] = max(st_prima[i,T+1]-k1,0)*exp(-(r-rf)*1/12)
        compensacionesCall2[i] = max(st_prima[i,T+1]-k2,0)*exp(-(r-rf)*1/12)
        
        compensacionesPut1[i] = max(k1-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
        compensacionesPut2[i] = max(k2-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
    }

.. code:: r

    primaCall1 = mean(compensacionesCall1)
    primaCall1



.. raw:: html

    50.0354164730773


.. code:: r

    primaCall2 = mean(compensacionesCall2)
    primaCall2



.. raw:: html

    28.6308069043686


.. code:: r

    primaPut1 = mean(compensacionesPut1)
    primaPut1



.. raw:: html

    44.570561858486


.. code:: r

    primaPut2 = mean(compensacionesPut2)
    primaPut2



.. raw:: html

    73.1041559547008


Simulación de coberturas con opciones europeas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    # Simulación del precio del activo subyacente con riesgo, se utiliza el rendimiento esperado.
    
    st = matrix(, iteraciones, T+1)
    
    st[,1] = s
    
    for(i in 1:iteraciones){
        
        for(j in 2:(T+1)){
            
       st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*sqrt(dt)*rnorm(1)) 
            
       }
    }

.. code:: r

    # Precios con cobertura.
    
    coberturaCall = vector()
    coberturaPut = vector()
    coberturaSpreadComprador = vector()
    coberturaSpreadVendedor = vector()
    
    for(i in 1:iteraciones){
        
       coberturaCall[i] = abs(-st[i,T+1]+max(st[i,T+1]-k1,0)-primaCall1)
    
       coberturaPut[i] = st[i,T+1]+max(k1-st[i,T+1],0)-primaPut1
            
       coberturaSpreadComprador[i] = abs(-st[i,T+1]+max(st[i,T+1]-k1,0)+min(k2-st[i,T+1],0))
            
       coberturaSpreadVendedor[i] = st[i,T+1]+min(st[i,T+1]-k1,0)+max(k2-st[i,T+1],0)    
        
    }

.. code:: r

    resultados = data.frame(st[,T+1], coberturaCall, coberturaSpreadComprador, coberturaPut, coberturaSpreadVendedor)

.. code:: r

    colnames(resultados) = c("Sin cobertura", "Cobertura Call", "Cobertura Spread Comprador", "Cobertura Put", "Cobertura Spread Vendedor")
    head(resultados)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Sin cobertura</th><th scope=col>Cobertura Call</th><th scope=col>Cobertura Spread Comprador</th><th scope=col>Cobertura Put</th><th scope=col>Cobertura Spread Vendedor</th></tr>
    	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>3530.193</td><td>3450.035</td><td>3480.193</td><td>3485.622</td><td>3530.193</td></tr>
    	<tr><th scope=row>2</th><td>3439.483</td><td>3450.035</td><td>3400.000</td><td>3394.912</td><td>3450.000</td></tr>
    	<tr><th scope=row>3</th><td>3552.663</td><td>3450.035</td><td>3502.663</td><td>3508.092</td><td>3552.663</td></tr>
    	<tr><th scope=row>4</th><td>3581.864</td><td>3450.035</td><td>3531.864</td><td>3537.293</td><td>3581.864</td></tr>
    	<tr><th scope=row>5</th><td>3564.243</td><td>3450.035</td><td>3514.243</td><td>3519.672</td><td>3564.243</td></tr>
    	<tr><th scope=row>6</th><td>3777.631</td><td>3450.035</td><td>3727.631</td><td>3733.060</td><td>3777.631</td></tr>
    </tbody>
    </table>
    


Gráficos con ``ggplot2``
~~~~~~~~~~~~~~~~~~~~~~~~

Instalar la librería: ``install.packages("tidyverse")``

.. code:: r

    library(ggplot2)

1. Escenario sin cobertura: :math:`S_T`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valor esperado
~~~~~~~~~~~~~~

.. code:: r

    mean(resultados[,"Sin cobertura"])



.. raw:: html

    3452.98946373105


Percentil del 5% y 95%
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(resultados[,"Sin cobertura"], c(0.05, 0.95))



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>5%</dt><dd>3259.0653544565</dd><dt>95%</dt><dd>3653.75953422285</dd></dl>
    


Desviación estándar
~~~~~~~~~~~~~~~~~~~

.. code:: r

    sd(resultados[,"Sin cobertura"])



.. raw:: html

    121.118584544262


.. code:: r

    ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
      labs(title = "Escenario sin cobertura", x = "Precio")



.. image:: output_52_0.png
   :width: 420px
   :height: 420px


2. Escenario con cobertura: Call
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valor esperado
~~~~~~~~~~~~~~

.. code:: r

    mean(resultados[,"Cobertura Call"])



.. raw:: html

    3423.96108935102


Percentil del 5% y 95%
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(resultados[,"Cobertura Call"], c(0.05, 0.95))



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>5%</dt><dd>3309.10077092958</dd><dt>95%</dt><dd>3450.03541647308</dd></dl>
    


Desviación estándar
~~~~~~~~~~~~~~~~~~~

.. code:: r

    sd(resultados[,"Cobertura Call"])



.. raw:: html

    51.6029775705823


.. code:: r

    ggplot(data = resultados, aes(resultados[,"Cobertura Call"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Call"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
      labs(title = "Escenario cobertura Call", x = "Precio")



.. image:: output_60_0.png
   :width: 420px
   :height: 420px


3. Escenario con cobertura: Spread Comprador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valor esperado
~~~~~~~~~~~~~~

.. code:: r

    mean(resultados[,"Cobertura Spread Comprador"])



.. raw:: html

    3423.54774036469


Percentil del 5% y 95%
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(resultados[,"Cobertura Spread Comprador"], c(0.05, 0.95))



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>5%</dt><dd>3259.0653544565</dd><dt>95%</dt><dd>3603.75953422285</dd></dl>
    


Desviación estándar
~~~~~~~~~~~~~~~~~~~

.. code:: r

    sd(resultados[,"Cobertura Spread Comprador"])



.. raw:: html

    102.746807530895


.. code:: r

    ggplot(data = resultados, aes(resultados[,"Cobertura Spread Comprador"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Comprador"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
      labs(title = "Escenario cobertura Spread Comprador", x = "Precio")



.. image:: output_68_0.png
   :width: 420px
   :height: 420px


Sin cobertura, cobertura Call y cobertura Spread Comprador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Call"],c(0.05, 0.95)), colour="darkgreen", size=1.5)+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Comprador"],c(0.05, 0.95)), colour="darkblue", size=1.5)+
      labs(x = "Precio")



.. image:: output_70_0.png
   :width: 420px
   :height: 420px


4. Escenario con cobertura: Put
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valor esperado
~~~~~~~~~~~~~~

.. code:: r

    mean(resultados[,"Cobertura Put"])



.. raw:: html

    3434.49322899461


Percentil del 5% y 95%
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(resultados[,"Cobertura Put"], c(0.05, 0.95))



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>5%</dt><dd>3355.42943814151</dd><dt>95%</dt><dd>3609.18897236437</dd></dl>
    


Desviación estándar
~~~~~~~~~~~~~~~~~~~

.. code:: r

    sd(resultados[,"Cobertura Put"])



.. raw:: html

    88.788296453783


.. code:: r

    ggplot(data = resultados, aes(resultados[,"Cobertura Put"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Put"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
      labs(title = "Escenario cobertura Put", x = "Precio")



.. image:: output_78_0.png
   :width: 420px
   :height: 420px


5. Escenario con cobertura: Spread Vendedor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valor esperado
~~~~~~~~~~~~~~

.. code:: r

    mean(resultados[,"Cobertura Spread Vendedor"])



.. raw:: html

    3473.54774036469


Percentil del 5% y 95%
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95))



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>5%</dt><dd>3309.0653544565</dd><dt>95%</dt><dd>3653.75953422285</dd></dl>
    


Desviación estándar
~~~~~~~~~~~~~~~~~~~

.. code:: r

    sd(resultados[,"Cobertura Spread Vendedor"])



.. raw:: html

    102.746807530895


.. code:: r

    ggplot(data = resultados, aes(resultados[,"Cobertura Spread Vendedor"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
      labs(title = "Escenario cobertura Spread Vendedor", x = "Precio")



.. image:: output_86_0.png
   :width: 420px
   :height: 420px


Sin cobertura, cobertura Put y cobertura Spread Vendedor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
      geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
      geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Put"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
      geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
      labs(x = "Precio")



.. image:: output_88_0.png
   :width: 420px
   :height: 420px


Sin cobertura, cobertura Call y cobertura Spread Comprador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ggplot(resultados, aes(resultados[,"Sin cobertura"])) + geom_histogram(binwidth = 50, alpha = 0.5, colour = "darkgray", fill = "darkgray")+
      geom_histogram(aes(resultados[,"Cobertura Call"]), alpha = 0.3, binwidth = 50, colour = "darkgreen", fill = "darkgreen")+
      geom_histogram(aes(resultados[,"Cobertura Spread Comprador"]), alpha = 0.3, binwidth = 50, colour = "darkblue", fill = "darkblue")+
      labs(title = "Histogramas", x = "Precio", y = "Frecuencia")



.. image:: output_90_0.png
   :width: 420px
   :height: 420px


Sin cobertura, cobertura Put y cobertura Spread Vendedor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ggplot(resultados, aes(resultados[,"Sin cobertura"])) + geom_histogram(binwidth = 50, alpha = 0.5, colour = "darkgray", fill = "darkgray")+
      geom_histogram(aes(resultados[,"Cobertura Put"]), alpha = 0.3, binwidth = 50, colour = "darkgreen", fill = "darkgreen")+
      geom_histogram(aes(resultados[,"Cobertura Spread Vendedor"]), alpha = 0.3, binwidth = 50, colour = "darkblue", fill = "darkblue")+
      labs(title = "Histogramas", x = "Precio", y = "Frecuencia")



.. image:: output_92_0.png
   :width: 420px
   :height: 420px

