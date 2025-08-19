Taller VaR y CVaR método de simulación Monte Carlo
--------------------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Datos primer examen 01-2020.csv", sep = ";")

Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]

Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = matrix(, nrow(precios)-1, ncol(precios))
    
    for(i in 1:ncol(precios)){
        
      rendimientos[,i] = diff(log(precios[,i]))
        
    }

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
    <ol class=list-inline><li>3180</li><li>18800</li><li>24760</li><li>44700</li></ol>
    


Número de acciones del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_acciones = c(180000,5000,12000,20000)
    numero_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>180000</li><li>5000</li><li>12000</li><li>20000</li></ol>
    


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
    <ol class=list-inline><li>572400000</li><li>9.4e+07</li><li>297120000</li><li>8.94e+08</li></ol>
    


Valor de mercado del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_portafolio = sum(valor_mercado_acciones)
    valor_portafolio



.. raw:: html

    1857520000


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
    <ol class=list-inline><li>0.308152805891727</li><li>0.0506051078857832</li><li>0.159955209095999</li><li>0.481286877126491</li></ol>
    


:math:`\mu:` Rendimiento esperado de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    mu = apply(rendimientos, 2, mean)
    mu



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.00052818024892044</li><li>0.000817437518458556</li><li>0.000411972791855423</li><li>0.00146604550819807</li></ol>
    


:math:`\sigma:`\ Volatilidad de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    volatilidades



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.0384381803599016</li><li>0.030438809306807</li><li>0.0239949256781827</li><li>0.0292898506777494</li></ol>
    


Matriz de coeficientes de correlación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    correlacion = cor(rendimientos)
    correlacion



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <tbody>
    	<tr><td>1.0000000</td><td>0.3150607</td><td>0.2960306</td><td>0.3571087</td></tr>
    	<tr><td>0.3150607</td><td>1.0000000</td><td>0.4015795</td><td>0.3706462</td></tr>
    	<tr><td>0.2960306</td><td>0.4015795</td><td>1.0000000</td><td>0.3298657</td></tr>
    	<tr><td>0.3571087</td><td>0.3706462</td><td>0.3298657</td><td>1.0000000</td></tr>
    </tbody>
    </table>
    


Descomposición de Cholesky
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    cholesky = chol(correlacion)
    cholesky



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <tbody>
    	<tr><td>1</td><td>0.3150607</td><td>0.2960306</td><td>0.3571087</td></tr>
    	<tr><td>0</td><td>0.9490715</td><td>0.3248564</td><td>0.2719872</td></tr>
    	<tr><td>0</td><td>0.0000000</td><td>0.8982395</td><td>0.1511777</td></tr>
    	<tr><td>0</td><td>0.0000000</td><td>0.0000000</td><td>0.8807052</td></tr>
    </tbody>
    </table>
    


Preguntas
~~~~~~~~~

¿Cuál es el VaR y CVaR semanal con un nivel de confianza del 90% de cada una de las acciones y del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La frecuencia temporal de los rendimientos es semanal. Se usará
``dt=1/5`` porque se recomienda que :math:`\Delta t` sea pequeño. Así se
podrá realizar saltos diarios en el tiempo debido a que una semana tiene
cinco días bursátiles.

Así con saltos diarios de tiempo, para el **VaR semanal**, ``n=5``.

.. code:: r

    n = 5
    dt = 1/5
    NC = 0.90

SImulación de precios diarios
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    iteraciones = 50000
    
    st = array(dim = c(iteraciones, n+1, ncol(rendimientos)))
    
    for(i in 1:ncol(rendimientos)){
        
        st[,1,i] = s[i] # Con este for se está almacenando el precio actual de cada acción en la columna 1 de las matrices del array.
    }
    
    aleatorio_corr = vector()
    
    for(k in 1:ncol(precios)){
        
        for(i in 1:iteraciones){
            
               
        for(j in 2:(n+1)){
            
        aleatorio = rnorm(ncol(precios))
        aleatorio_corr = colSums(aleatorio*cholesky)
         
        st[i,j,k] = st[i,j-1,k]*exp((mu[k]-volatilidades[k]^2/2)*dt+volatilidades[k]*sqrt(dt)*aleatorio_corr[k])
               
      }
    }
    }

Rendimientos semanales simulados de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El array ``st``\ tiene seis columnas (``n+1``), la última columna tiene
los precios simulados para una semana. Con esta columna se calcularán
los rendimientos **semanales** simulados.

.. code:: r

    rend = matrix(,iteraciones,ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        rend[,i] = st[,n+1,i]/s[i]-1 #Rendimientos semanales simulados de cada acción.
    }

Rendimientos semanales simulados del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend_port = vector()
    
    for(i in 1:nrow(rendimientos)){
        
        rend_port[i] = sum(rend[i,]*proporciones)
        
    }

VaR semanal individuales
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
        
    }
    VaR_individuales_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>27250682.5694049</li><li>3580028.41405506</li><li>8942544.84875934</li><li>32208722.325042</li></ol>
    


VaR semanal del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>10%:</strong> 43906650.7840915


CVaR semanal individuales
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
    }
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>37265944.1349686</li><li>4850952.504194</li><li>12231487.8941014</li><li>43807904.8354661</li></ol>
    


CVaR semanal del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    481061.470750188


¿Cuál es el VaR y CVaR mensual con un nivel de confianza del 95% de cada una de las acciones y del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La frecuencia temporal de los rendimientos es semanal. Se usará
``dt=1/5`` porque se recomienda que :math:`\Delta t` sea pequeño. Así se
podrá realizar saltos diarios en el tiempo debido a que una semana tiene
cinco días bursátiles.

Así con saltos diarios de tiempo, para el **VaR mensual**, ``n=20``.

.. code:: r

    n = 20
    dt = 1/5
    NC = 0.95

.. code:: r

    iteraciones = 50000
    
    st = array(dim = c(iteraciones, n+1, ncol(rendimientos)))
    
    for(i in 1:ncol(rendimientos)){
        
        st[,1,i] = s[i] # Con esto for se está almacenando el precio actual de cada acción en la columna 1 de las matrices del array.
    }
    
    aleatorio_corr = vector()
    
    for(k in 1:ncol(precios)){
        
        for(i in 1:iteraciones){
            
               
        for(j in 2:(n+1)){
            
        aleatorio = rnorm(ncol(precios))
        aleatorio_corr = colSums(aleatorio*cholesky)
         
        st[i,j,k] = st[i,j-1,k]*exp((mu[k]-volatilidades[k]^2/2)*dt+volatilidades[k]*sqrt(dt)*aleatorio_corr[k])
               
      }
    }
    }

Rendimientos mensuales simulados de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El array ``st``\ tiene 21 columanas (``n+1``), la última columna tiene
los precios simulados para un mes. Con esta columna se calcularán los
rendimientos **mensuales** simulados.

.. code:: r

    rend = matrix(, iteraciones, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        rend[,i] = st[,n+1,i]/s[i]-1 #Rendimientos mensuales simulados de cada acción.
    }

Rendimientos mensuales simulados del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend_port = vector()
    
    for(i in 1:nrow(rendimientos)){
        
        rend_port[i] = sum(rend[i,]*proporciones)
    }

VaR mensual individuales
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
    }
    VaR_individuales_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>68425768.9393525</li><li>8715863.30371035</li><li>22371602.2623771</li><li>78647023.9143117</li></ol>
    


VaR mensual del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>5%:</strong> 109628306.897354


CVaR mensual individuales
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
    }
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>84333805.7509863</li><li>10876579.5113407</li><li>27763643.9843417</li><li>98184468.4514079</li></ol>
    


CVaR mensual del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    6043185.3876385


¿Cuál es el VaR y CVaR diario con un nivel de confianza del 99% de cada una de las acciones y del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Como anteriormente se hallaron los precios simulados para 20 días (un
mes), no es necesario volverlos a calcularlos porque solo se necesitan
los precios simulados del día uno para obtener los rendimientos
simulados diarios. Estos valores están en la columna 2 del array
``st``.**

.. code:: r

    NC = 0.99

Rendimientos diarios simulados de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``st[,2,i]``\ son los precios simulados de cada acción para el día uno.

.. code:: r

    rend = matrix(, iteraciones, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        rend[,i] = st[,2,i]/s[i]-1 #Rendimientos simulados de cada acción para el día 1.
    }

Rendimientos diarios simulados del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend_port = vector()
    
    for(i in 1:nrow(rendimientos)){
        
        rend_port[i] = sum(rend[i,]*proporciones)
    }

VaR diario individuales
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
        
    }
    VaR_individuales_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>22434687.8014924</li><li>2919082.71606842</li><li>7386222.59359142</li><li>26246899.3793198</li></ol>
    


VaR diario portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>1%:</strong> 36446602.6033561


CVaR diario individuales
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
    }
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>25585202.4378887</li><li>3353496.1402176</li><li>8392179.62141718</li><li>29944435.6810667</li></ol>
    


CVaR diario portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    1322962.98293428

