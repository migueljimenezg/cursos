VaR y CVaR para un activo por Simulación Monte Carlo
----------------------------------------------------

Acción con precio actual de $5000, rendimiento esperado continuo diario
de 0,14% y desviación estándar diaria de 1,8%.

En la acción se tiene invertido 250 millones de pesos.

.. code:: r

    s = 5000
    mu = 0.00014 #Compuesto continuo diario.
    volatilidad = 0.018 #Diaria
    valor_mercado = 250000000

VaR y CVaR diarios con un nivel de confianza del 99%
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    n = 1 #Un día
    dt = 1
    NC = 0.99

Simulación de los precios diarios
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se creará una matriz llamada ``st``. Cada fila será una iteración y las
columnas representarán el tiempo. Se empezará en :math:`t=0`, que será
la primera columna de la matriz ``st``. La última columna será el
período :math:`T`. Así se tendrían ``n+1``\ columnas.

Ejemplo de matriz:
~~~~~~~~~~~~~~~~~~

.. figure:: Matriz2.jpg
   :alt: 1

   1

En las matrices, las ubicaciones se representan de la siguiente manera:
``[Filas,Columnas]``.

.. code:: r

    iteraciones = 50000
    
    st = matrix(, iteraciones, n+1)
    
    st[,1] = s
    
    for(j in 2:(n+1)){
        
      for(i in 1:iteraciones){
        
        st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*rnorm(1)*sqrt(dt)) #Precios simulados.
      }
    }

Rendimientos diarios simulados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend = st[,n+1]/s-1

VaR diario
~~~~~~~~~~

.. code:: r

    VaR = abs(quantile(rend, 1-NC)*valor_mercado)
    VaR



.. raw:: html

    <strong>1%:</strong> 10269566.2894848


CVaR diario
~~~~~~~~~~~

.. code:: r

    CVaR = abs(mean(tail(sort(rend, decreasing = T), floor(50000*(1-NC))))*valor_mercado)
    CVaR



.. raw:: html

    11764813.4162774


VaR y CVaR mensual con un nivel de confianza del 90%
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    n = 20 #Un mes
    dt = 1
    NC = 0.90

.. code:: r

    iteraciones = 50000
    
    st = matrix(, iteraciones, n+1)
    
    st[,1] = s
    
    for(j in 2:(n+1)){
        
      for(i in 1:iteraciones){
        
        st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*rnorm(1)*sqrt(dt)) #Precios simulados.
      }
    }

Rendimientos mensuales simulados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend = st[,n+1]/s-1 #Rendimientos simulados.

VaR diario
~~~~~~~~~~

.. code:: r

    VaR = abs(quantile(rend, 1-NC)*valor_mercado)
    VaR



.. raw:: html

    <strong>10%:</strong> 24501656.1986672


CVaR diario
~~~~~~~~~~~

.. code:: r

    CVaR = abs(mean(tail(sort(rend, decreasing = T), floor(50000*(1-NC))))*valor_mercado)
    CVaR



.. raw:: html

    32892117.6171894

