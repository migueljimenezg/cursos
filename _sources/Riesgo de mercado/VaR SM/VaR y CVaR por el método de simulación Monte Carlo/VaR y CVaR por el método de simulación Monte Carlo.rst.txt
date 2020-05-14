VaR y CVaR por el método de simulación Monte Carlo
--------------------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Tres acciones.csv", sep = ";")

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

    s = tail(precios, 1)
    s = as.numeric(s)
    s



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>2980</li><li>41300</li><li>18960</li></ol>
    


Número de acciones del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_acciones = c(180000,5000,12000)
    numero_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>180000</li><li>5000</li><li>12000</li></ol>
    


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
    <ol class=list-inline><li>536400000</li><li>206500000</li><li>227520000</li></ol>
    


Valor de mercado del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_portafolio = sum(valor_mercado_acciones)
    valor_portafolio



.. raw:: html

    970420000


Proporciones de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = valor_mercado_acciones/valor_portafolio
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.552750355516168</li><li>0.212794460130665</li><li>0.234455184353167</li></ol>
    


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
    <ol class=list-inline><li>0.000142550355302127</li><li>0.000319532367160843</li><li>0.000353968507201265</li></ol>
    


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
    <ol class=list-inline><li>0.0186287123700029</li><li>0.0158377375241563</li><li>0.0155685912187815</li></ol>
    


Matriz de coeficientes de correlación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    correlacion = cor(rendimientos)
    correlacion



.. raw:: html

    <table>
    <caption>A matrix: 3 × 3 of type dbl</caption>
    <tbody>
    	<tr><td>1.0000000</td><td>0.3602051</td><td>0.3218894</td></tr>
    	<tr><td>0.3602051</td><td>1.0000000</td><td>0.3299546</td></tr>
    	<tr><td>0.3218894</td><td>0.3299546</td><td>1.0000000</td></tr>
    </tbody>
    </table>
    


Descomposición de Cholesky
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    cholesky = chol(correlacion)
    cholesky



.. raw:: html

    <table>
    <caption>A matrix: 3 × 3 of type dbl</caption>
    <tbody>
    	<tr><td>1</td><td>0.3602051</td><td>0.3218894</td></tr>
    	<tr><td>0</td><td>0.9328731</td><td>0.2294079</td></tr>
    	<tr><td>0</td><td>0.0000000</td><td>0.9185637</td></tr>
    </tbody>
    </table>
    


VaR y CVaR mensual con un nivel de confianza del 99%
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para calcular el VaR por el método de Simulación Monte Carlo se realiza
el siguiente procedimiento: \* Generar los precio simulados
correlacionados con el Movimiento Browniano Geométrico (MBG) hasta el
período de análisis. \* Calcular los rendimientos simulados a partir de
los precios simulados. \* Calcular el VaR y CVaR como en el método de
Simulación Histórica.

La frecuencia de los datos cargados es diaria y se necesita llegar al
día 20 (1 mes) esto con saltos diarios, entonces, ``dt=1`` y ``n=20``
(20 saltos en el tiempo de un día cada uno).

.. code:: r

    n = 20
    dt = 1
    NC = 0.99

Precios simulados correlacionados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para simular los precios con el MBG se utilizará un ``array``. Un
``array``\ es un objeto que tendrá varias matrices.

Este es un ejemplo de ``array``:

.. figure:: Array3.jpg
   :alt: 1

   1

Los precios simulados de la primera acción estarán en la primera matriz,
la segunda acción estárá en la segunda matriz, etc.

Las ubicaciones están representadas de la siguiente manera:
``[Filas,Columnas,Matriz]``.

.. code:: r

    iteraciones = 50000
    
    st=array(dim = c(iteraciones, n+1, ncol(rendimientos)))
    
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

Rendimientos mensuales simulados de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El rendimiento relativo se calcula de la siguiente manera:

.. math:: Rendimiento_t=\frac{Precio_t}{Precio_{t-1}}-1

Con los precios simulados se calcularán los rendimientos simulados con
respecto al precio inicial ``s`` con la siguiente fórmula:

.. math::  Rendimiento_T=\frac{S_0 e^{[(\mu- \frac{\sigma ^2}{2})T+\sigma\epsilon \sqrt{T}]}}{S_0}-1

====================================================================================================

**Como se realizó una simulación con saltos diarios hasta el día 20 que
representa el mes, entonces los valores que se necesitan para el VaR
mensual son los últimos precios simulados que se ubican en la columna
``n+1`` del array ``st``.**

Estos rendimientos simulados se llamarán ``rend``. El número de columnas
de este objeto será igual a la cantidad de acciones
``ncol(rendimientos)`` y las filas igual a las ``iteraciones``.

.. code:: r

    rend = matrix(, iteraciones, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        rend[,i] = st[,n+1,i]/s[i]-1 #Rendimientos simulados de cada acción para el día 20.
    }

Rendimientos mensuales simulados del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Después de tener hallados los rendimientos simulados de cada acción, se
procede a hallar los rendimientos simulados del portafolio de inversión,
esto se hace con ``rend_port[i]=sum(rend[i,]*proporciones)``.

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
    <ol class=list-inline><li>94222055.8999856</li><li>30324933.4626248</li><li>33222220.6058242</li></ol>
    


VaR mensual portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>1%:</strong> 102852324.157052


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
    <ol class=list-inline><li>106910291.861578</li><li>34387998.1240636</li><li>37716797.8030966</li></ol>
    


CVaR mensual portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    67372469.7203024


VaR diario con un nivel de confianza del 99%
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
    <ol class=list-inline><li>22560307.8766136</li><li>7365128.50942637</li><li>8090723.16189517</li></ol>
    


VaR diario portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>1%:</strong> 25124974.4029365


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
    <ol class=list-inline><li>25945051.1791835</li><li>8432138.81193205</li><li>9238716.17716916</li></ol>
    


CVaR diario portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    15900890.5422606


VaR semanal con un nivel de confianza del 95%
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Como anteriormente se hallaron los precios simulados para 20 días (un
mes), no es necesario volverlos a calcularlos porque solo se necesitan
los precios simulados del cinco uno para obtener los rendimientos
simulados semanales. Estos valores están en la columna 6 del array
``st``.**

.. code:: r

    NC = 0.95

Rendimientos semanales simulados de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``st[,6,i]``\ son los precios simulados de cada acción para una semana.

.. code:: r

    rend = matrix(, iteraciones, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        rend[,i] = st[,6,i]/s[i]-1 #Rendimientos semanales simulados de cada acción.
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
    <ol class=list-inline><li>35557722.6874532</li><li>11346066.8430539</li><li>12413474.1995438</li></ol>
    


VaR semanal portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
    VaR_portafolio_SM_percentil



.. raw:: html

    <strong>5%:</strong> 39622449.1426242


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
    <ol class=list-inline><li>44206313.8692839</li><li>14176644.0029557</li><li>15566791.8582029</li></ol>
    


CVaR semanal portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    3896872.40903229

