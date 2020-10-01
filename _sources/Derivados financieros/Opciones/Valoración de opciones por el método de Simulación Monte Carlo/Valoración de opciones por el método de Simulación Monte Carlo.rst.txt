Valoración de opciones por el método de Simulación Monte Carlo
--------------------------------------------------------------

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


Simulación del precio del activo subyacente (neutral al riesgo)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La modelación se realiza con las tasas libres de riesgo :math:`r`.

.. math::  S_{t+\Delta t}=S_t e^{[(r- \frac{\sigma ^2}{2})\Delta t+\sigma\epsilon \sqrt{\Delta t}]}

===================================================================================================

Cuando el activo subyacente es una divisa se usa :math:`r - r_f`.

.. math::  S_{t+\Delta t}=S_t e^{[(r - r_{f} - \frac{\sigma ^2}{2})\Delta t+\sigma\epsilon \sqrt{\Delta t}]}

============================================================================================================

Valoración de opciones europeas por Simulación Monte Carlo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math::  Prima Call = Máx[S_T - K; 0]e^{-rT} 

===============================================

.. math::  Prima Call_{divisas} = Máx[S_T - K; 0]e^{-(r - r_f)T} 

=================================================================

.. math::  Prima Put = Máx[K - S_T; 0]e^{-rT} 

==============================================

.. math::  Prima Put_{divisas} = Máx[K - S_T; 0]e^{-(r - r_f)T} 

================================================================

Valoración de una opción europea sobre divisas con vencimiento a un mes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    # Tasas libres de riesgo
    
    r = 0.018 # E.A. (Colombia)
    
    rf = 0.003 # Nominal (USA)
    
    # Con el modelo Black-Scholes se trabaja con tasas continuas:
    
    r = log(1+r) # C.C.A.
    
    rf = log(1+rf/12)*12 # C.C.A.

.. code:: r

    T = 30 # 1 mes
    k = 3450
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

    compensacionesCall = vector()
    compensacionesPut = vector()
    
    for(i in 1:iteraciones){
        
        compensacionesCall[i] = max(st_prima[i,T+1]-k,0)*exp(-(r-rf)*1/12)
        
        compensacionesPut[i] = max(k-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
    }

.. code:: r

    primaCall = mean(compensacionesCall)
    primaCall



.. raw:: html

    28.6308069043686


.. code:: r

    primaPut = mean(compensacionesPut)
    primaPut



.. raw:: html

    73.1041559547008


Prima opción Call europea: :math:`28,63 COP`.

Prima opción Put europea: :math:`73,10 COP`.

.. code:: r

    hist(compensacionesCall, col = "gray", xlab = "Compensación", ylab = "Frecuencia", main = "Compensaciones Call")



.. image:: output_37_0.png
   :width: 420px
   :height: 420px


.. code:: r

    hist(compensacionesPut, col = "gray", xlab = "Compensación", ylab = "Frecuencia", main = "Compensaciones Put")



.. image:: output_38_0.png
   :width: 420px
   :height: 420px

