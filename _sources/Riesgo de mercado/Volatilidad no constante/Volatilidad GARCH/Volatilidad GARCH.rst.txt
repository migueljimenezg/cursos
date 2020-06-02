Volatilidad GARCH
-----------------

Importar datos
~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Tres acciones.csv", sep=";", dec=",", header = T)

Matriz de precios
~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]
    
    head(precios)
    tail(precios)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 3</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFBCOLOM</th><th scope=col>ISA</th></tr>
    	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>1995</td><td>16800</td><td>7000</td></tr>
    	<tr><th scope=row>2</th><td>1960</td><td>16380</td><td>6810</td></tr>
    	<tr><th scope=row>3</th><td>1905</td><td>15880</td><td>6890</td></tr>
    	<tr><th scope=row>4</th><td>1860</td><td>15980</td><td>6710</td></tr>
    	<tr><th scope=row>5</th><td>1755</td><td>15900</td><td>6590</td></tr>
    	<tr><th scope=row>6</th><td>1725</td><td>15340</td><td>6320</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 3</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFBCOLOM</th><th scope=col>ISA</th></tr>
    	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>2811</th><td>3030</td><td>41260</td><td>19000</td></tr>
    	<tr><th scope=row>2812</th><td>3015</td><td>42020</td><td>19160</td></tr>
    	<tr><th scope=row>2813</th><td>3000</td><td>41280</td><td>19300</td></tr>
    	<tr><th scope=row>2814</th><td>3000</td><td>41300</td><td>19800</td></tr>
    	<tr><th scope=row>2815</th><td>2980</td><td>41160</td><td>19200</td></tr>
    	<tr><th scope=row>2816</th><td>2980</td><td>41300</td><td>18960</td></tr>
    </tbody>
    </table>
    


.. code:: r

    nombres = colnames(precios)
    nombres



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>'ECO'</li><li>'PFBCOLOM'</li><li>'ISA'</li></ol>
    


.. code:: r

    acciones = ncol(precios)
    acciones



.. raw:: html

    3


.. code:: r

    precios = ts(precios)

Matriz de rendimientos
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Gráfico de los rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(rendimientos, main = "Rendimientos")



.. image:: output_11_0.png
   :width: 420px
   :height: 420px


Volatilidad de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~

Esta forma de calcular la volatilidad también se llama **volatilidad
histórica**. Cada uno de los rendimientos tiene igual peso para la
volatilidad.

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    print(volatilidades)


.. parsed-literal::

           ECO   PFBCOLOM        ISA 
    0.01862871 0.01583774 0.01556859 
    

Volatilidad GARCH (1,1)
~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_t=\sqrt{\omega+\alpha r^2_{t-1}+\beta \sigma^2_{t-1}}

Donde;

.. math:: \omega=\gamma V_L

.. math:: \sigma_t=\sqrt{\gamma V_L+\alpha r^2_{t-1}+\beta \sigma^2_{t-1}}

:math:`V_L:` Es la volatilidad a largo plazo.

:math:`\gamma:` Peso asignado a la volatilidad a largo plazo.

:math:`\alpha:` Peso asignado al rendimiento al cuadrado del período
anterior (:math:`r^2_{t-1}`).

:math:`\beta:` Peso asignado a la varianza del período anterior
(:math:`\sigma^2_{t-1}`).

Al igual que en la fórmula de la volatilidad EWMA, la fórmula de la
volatilidad GARCH es recursida, el resultado del período actual depende
de los resultados del período anterior.

La volatilida GARCH (1,1) es similar a la volatilidad EWMA si
:math:`\alpha=(1-\lambda)` y :math:`\beta=\lambda`, solo que GARCH tiene
un término adicional que es la volatilidad a largo plazo, :math:`V_L` y
su correspondiente peso :math:`\gamma`.

.. math:: \gamma=1-\alpha-\beta

.. math:: V_L=\frac{\omega}{\gamma}

Entonces,

.. math:: V_L=\frac{\omega}{1-\alpha-\beta}

Esta es otra forma de calcular :math:`V_L`. Esta volatilidad de largo
plazo indica el valor al que se espera que la volatilidad de la acción
se estabilice en los siguientes períodos, es decir, se espera que la
volatilidad de los siguientes períodos tienda al valor de :math:`V_L`.

Los coeficientes de la volatilidad GARCH(1,1) se pueden hallar con la
librería ``tseries``.

Se debe instalar el paquete tseries: ``install.packages("tseries")``.

Llamar la librería ``tseries`` después de instalarla:

.. code:: r

    library(tseries)

Coeficientes de la volatilidad GARCH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La volatilidad GARCH(1,1) tiene tres coeficientes. La función
``garch()`` estima el GARCH(1,1) y la función ``coef()`` extrae solo los
tres coeficientes. De esta forma, se utilizará la función ``coef()``
sobre la función ``garch()``.

.. code:: r

    coeficientes_garch = matrix(, 3, acciones)
    
    for(i in 1:acciones){
        
      coeficientes_garch[, i] = coef(garch(rendimientos[, i]))
    }


.. parsed-literal::

    
     ***** ESTIMATION WITH ANALYTICAL GRADIENT ***** 
    
    
         I     INITIAL X(I)        D(I)
    
         1     3.123260e-04     1.000e+00
         2     5.000000e-02     1.000e+00
         3     5.000000e-02     1.000e+00
    
        IT   NF      F         RELDF    PRELDF    RELDX   STPPAR   D*STEP   NPRELDF
         0    1 -9.861e+03
         1    7 -9.864e+03  2.76e-04  4.08e-04  1.5e-04  1.8e+10  1.5e-05  3.71e+06
         2    8 -9.864e+03  2.95e-05  3.38e-05  1.3e-04  2.0e+00  1.5e-05  3.20e+01
         3    9 -9.864e+03  1.81e-06  1.85e-06  1.5e-04  2.0e+00  1.5e-05  3.18e+01
         4   16 -9.898e+03  3.43e-03  4.88e-03  3.8e-01  2.0e+00  6.1e-02  3.17e+01
         5   19 -9.939e+03  4.13e-03  3.62e-03  6.9e-01  2.0e+00  2.4e-01  1.10e+00
         6   21 -9.949e+03  9.88e-04  9.46e-04  7.6e-02  2.0e+00  4.9e-02  1.39e+02
         7   23 -1.000e+04  5.53e-03  8.04e-03  3.6e-01  2.0e+00  3.9e-01  8.73e+03
         8   33 -1.003e+04  2.84e-03  1.11e-02  1.3e-05  4.1e+00  1.8e-05  2.56e-01
         9   43 -1.004e+04  6.25e-04  3.73e-04  7.3e-03  1.9e+00  1.1e-02  3.38e-03
        10   44 -1.004e+04  2.47e-04  4.59e-04  7.2e-03  2.0e+00  1.1e-02  1.95e-01
        11   45 -1.004e+04  1.82e-04  2.33e-04  7.1e-03  2.0e+00  1.1e-02  6.72e-02
        12   46 -1.004e+04  5.07e-05  8.78e-05  7.0e-03  2.0e+00  1.1e-02  2.68e-02
        13   58 -1.004e+04  3.64e-06  9.51e-06  3.7e-07  2.7e+00  5.7e-07  8.01e-04
        14   59 -1.004e+04  9.00e-07  7.87e-07  3.5e-07  2.0e+00  5.7e-07  3.06e-04
        15   67 -1.004e+04  2.19e-05  3.71e-05  6.0e-03  1.7e+00  9.4e-03  3.09e-04
        16   70 -1.005e+04  1.05e-03  7.05e-04  5.1e-02  0.0e+00  1.1e-01  7.05e-04
        17   72 -1.006e+04  3.75e-04  6.65e-04  9.0e-03  1.7e+00  1.8e-02  1.08e-03
        18   73 -1.006e+04  1.30e-04  2.15e-04  8.8e-03  1.3e+00  1.8e-02  5.06e-04
        19   74 -1.006e+04  3.37e-06  1.39e-05  2.7e-03  0.0e+00  4.8e-03  1.39e-05
        20   75 -1.006e+04  5.11e-06  7.95e-06  2.2e-03  6.4e-01  4.8e-03  1.02e-05
        21   76 -1.006e+04  3.75e-07  2.31e-06  9.7e-04  0.0e+00  1.8e-03  2.31e-06
        22   77 -1.006e+04  7.79e-07  6.72e-07  4.7e-04  0.0e+00  9.4e-04  6.72e-07
        23   78 -1.006e+04  8.00e-10  4.34e-10  4.1e-06  0.0e+00  8.8e-06  4.34e-10
        24   79 -1.006e+04  1.72e-10  4.62e-11  2.1e-06  0.0e+00  3.8e-06  4.62e-11
        25   80 -1.006e+04  2.31e-11  8.91e-15  9.2e-08  0.0e+00  2.1e-07  8.91e-15
        26   81 -1.006e+04  1.87e-12  5.35e-17  7.5e-09  0.0e+00  1.7e-08  5.35e-17
        27   82 -1.006e+04  2.53e-15  1.39e-23  1.5e-12  0.0e+00  2.6e-12  1.39e-23
        28   83 -1.006e+04 -7.23e-16  7.08e-29  1.9e-15  0.0e+00  3.7e-15  7.08e-29
    
     ***** X- AND RELATIVE FUNCTION CONVERGENCE *****
    
     FUNCTION    -1.005976e+04   RELDX        1.935e-15
     FUNC. EVALS      83         GRAD. EVALS      28
     PRELDF       7.078e-29      NPRELDF      7.078e-29
    
         I      FINAL X(I)        D(I)          G(I)
    
         1    6.826205e-06     1.000e+00    -1.410e-06
         2    9.525933e-02     1.000e+00    -3.441e-10
         3    8.891568e-01     1.000e+00    -4.288e-10
    
    
     ***** ESTIMATION WITH ANALYTICAL GRADIENT ***** 
    
    
         I     INITIAL X(I)        D(I)
    
         1     2.257505e-04     1.000e+00
         2     5.000000e-02     1.000e+00
         3     5.000000e-02     1.000e+00
    
        IT   NF      F         RELDF    PRELDF    RELDX   STPPAR   D*STEP   NPRELDF
         0    1 -1.033e+04
         1    7 -1.034e+04  3.61e-04  4.83e-04  1.1e-04  4.3e+10  1.1e-05  1.04e+07
         2    8 -1.034e+04  8.82e-05  1.06e-04  9.8e-05  2.0e+00  1.1e-05  3.77e+01
         3    9 -1.034e+04  4.20e-06  4.54e-06  1.1e-04  2.0e+00  1.1e-05  3.73e+01
         4   16 -1.037e+04  2.72e-03  3.74e-03  3.1e-01  2.0e+00  4.4e-02  3.72e+01
         5   19 -1.039e+04  1.69e-03  1.52e-03  6.3e-01  2.0e+00  1.8e-01  3.77e-01
         6   21 -1.043e+04  4.72e-03  3.71e-03  4.4e-01  2.0e+00  3.5e-01  5.29e+01
         7   23 -1.045e+04  1.15e-03  1.14e-03  5.7e-02  2.0e+00  7.1e-02  6.36e+03
         8   24 -1.046e+04  1.57e-03  2.26e-03  9.8e-02  2.0e+00  1.4e-01  2.17e+01
         9   30 -1.046e+04  3.64e-05  1.51e-04  9.9e-07  2.3e+01  1.6e-06  2.37e-02
        10   31 -1.046e+04  1.26e-05  1.13e-05  8.5e-07  2.0e+00  1.6e-06  9.87e-05
        11   39 -1.046e+04  1.14e-04  8.29e-05  8.3e-03  0.0e+00  1.5e-02  8.29e-05
        12   42 -1.047e+04  2.74e-04  3.23e-04  3.2e-02  1.4e+00  5.8e-02  4.35e-03
        13   43 -1.047e+04  3.99e-05  1.60e-04  3.0e-02  5.1e-01  5.8e-02  1.82e-04
        14   44 -1.047e+04  1.43e-05  1.23e-04  1.7e-02  0.0e+00  3.1e-02  1.23e-04
        15   45 -1.047e+04  2.05e-05  3.87e-05  3.9e-03  0.0e+00  8.3e-03  3.87e-05
        16   47 -1.047e+04  2.04e-05  1.51e-05  6.6e-03  0.0e+00  1.3e-02  1.51e-05
        17   48 -1.047e+04  8.36e-07  7.32e-07  1.3e-03  0.0e+00  2.4e-03  7.32e-07
        18   49 -1.047e+04  2.60e-07  3.22e-07  3.1e-04  0.0e+00  6.4e-04  3.22e-07
        19   62 -1.047e+04  5.31e-11  4.12e-09  1.0e-09  6.2e+00  1.8e-09  6.37e-08
        20   76 -1.047e+04 -7.82e-15  4.65e-14  1.3e-14  2.9e+05  2.4e-14  6.15e-08
    
     ***** FALSE CONVERGENCE *****
    
     FUNCTION    -1.046832e+04   RELDX        1.334e-14
     FUNC. EVALS      76         GRAD. EVALS      20
     PRELDF       4.654e-14      NPRELDF      6.145e-08
    
         I      FINAL X(I)        D(I)          G(I)
    
         1    9.417356e-06     1.000e+00    -2.065e+04
         2    7.484815e-02     1.000e+00    -5.749e+00
         3    8.844196e-01     1.000e+00    -4.211e+00
    
    
     ***** ESTIMATION WITH ANALYTICAL GRADIENT ***** 
    
    
         I     INITIAL X(I)        D(I)
    
         1     2.181429e-04     1.000e+00
         2     5.000000e-02     1.000e+00
         3     5.000000e-02     1.000e+00
    
        IT   NF      F         RELDF    PRELDF    RELDX   STPPAR   D*STEP   NPRELDF
         0    1 -1.038e+04
         1    7 -1.038e+04  3.17e-04  4.31e-04  1.0e-04  4.5e+10  1.0e-05  9.62e+06
         2    8 -1.038e+04  7.00e-05  8.28e-05  8.4e-05  2.0e+00  1.0e-05  3.82e+01
         3    9 -1.038e+04  3.07e-06  3.24e-06  9.9e-05  2.0e+00  1.0e-05  3.78e+01
         4   17 -1.042e+04  4.34e-03  7.47e-03  4.7e-01  2.0e+00  8.8e-02  3.77e+01
         5   20 -1.050e+04  6.93e-03  6.29e-03  7.5e-01  2.0e+00  3.5e-01  1.63e+00
         6   29 -1.050e+04  1.73e-04  1.09e-03  1.8e-05  3.7e+00  1.4e-05  1.83e+01
         7   30 -1.050e+04  1.81e-04  1.51e-04  1.6e-05  2.0e+00  1.4e-05  2.33e+01
         8   31 -1.050e+04  4.68e-06  5.18e-06  1.7e-05  2.0e+00  1.4e-05  2.58e+01
         9   40 -1.055e+04  4.72e-03  4.41e-03  1.8e-01  2.0e+00  1.8e-01  2.54e+01
        10   42 -1.056e+04  6.86e-04  1.22e-03  3.0e-02  2.0e+00  3.7e-02  4.53e+02
        11   43 -1.057e+04  1.22e-03  1.32e-03  2.8e-02  2.0e+00  3.7e-02  6.03e+02
        12   45 -1.058e+04  9.20e-04  1.87e-03  6.1e-02  2.0e+00  8.6e-02  2.88e+02
        13   52 -1.058e+04  1.65e-05  4.29e-05  4.8e-07  7.7e+03  7.1e-07  1.03e+00
        14   53 -1.058e+04  7.90e-07  7.27e-07  4.6e-07  2.0e+00  7.1e-07  5.05e-04
        15   61 -1.058e+04  5.12e-05  9.02e-05  7.7e-03  1.5e+00  1.2e-02  4.99e-04
        16   62 -1.058e+04  1.19e-04  6.19e-05  6.2e-03  0.0e+00  1.2e-02  6.19e-05
        17   64 -1.059e+04  3.51e-04  3.50e-04  2.2e-02  0.0e+00  4.6e-02  6.11e-04
        18   65 -1.059e+04  1.67e-04  1.94e-04  2.2e-02  6.0e-01  4.6e-02  2.50e-04
        19   66 -1.059e+04  1.29e-05  2.32e-05  8.6e-03  0.0e+00  1.6e-02  2.32e-05
        20   67 -1.059e+04  3.85e-06  4.50e-06  2.0e-03  0.0e+00  3.7e-03  4.50e-06
        21   68 -1.059e+04  2.67e-08  1.06e-07  3.1e-04  0.0e+00  6.7e-04  1.06e-07
        22   69 -1.059e+04  4.00e-08  1.65e-08  2.3e-04  0.0e+00  4.4e-04  1.65e-08
        23   72 -1.059e+04  1.50e-10  3.07e-11  4.8e-07  1.9e+00  7.9e-07  4.14e-10
        24   75 -1.059e+04  1.28e-12  3.99e-13  9.8e-09  2.0e+00  1.6e-08  3.74e-10
        25   77 -1.059e+04  6.09e-13  1.40e-13  3.5e-09  2.0e+00  5.7e-09  3.69e-10
        26   84 -1.059e+04 -4.64e-15  3.60e-18  6.9e-15  1.5e+02  1.1e-14  3.70e-10
    
     ***** FALSE CONVERGENCE *****
    
     FUNCTION    -1.058874e+04   RELDX        6.947e-15
     FUNC. EVALS      84         GRAD. EVALS      26
     PRELDF       3.598e-18      NPRELDF      3.702e-10
    
         I      FINAL X(I)        D(I)          G(I)
    
         1    9.801076e-06     1.000e+00    -3.318e+00
         2    1.453401e-01     1.000e+00     2.359e-01
         3    8.208107e-01     1.000e+00     2.353e-01
    
    

.. code:: r

    print(coeficientes_garch)


.. parsed-literal::

                 [,1]         [,2]         [,3]
    [1,] 6.826205e-06 9.417356e-06 9.801076e-06
    [2,] 9.525933e-02 7.484815e-02 1.453401e-01
    [3,] 8.891568e-01 8.844196e-01 8.208107e-01
    

.. code:: r

    colnames(coeficientes_garch) = nombres # se renombran las columnas con los nombres de las acciones.
    
    rownames(coeficientes_garch) = c("Omega", "Alfa", "Beta") # se renombran las filas con los nombres de los coeficientes.
    
    print(coeficientes_garch)


.. parsed-literal::

                   ECO     PFBCOLOM          ISA
    Omega 6.826205e-06 9.417356e-06 9.801076e-06
    Alfa  9.525933e-02 7.484815e-02 1.453401e-01
    Beta  8.891568e-01 8.844196e-01 8.208107e-01
    

Acción ECO:
~~~~~~~~~~~

:math:`\omega=0,000006826205`, :math:`\alpha=0,09525933` y
:math:`\beta=0,8891568`.

Acción PFBCOLOM:
~~~~~~~~~~~~~~~~

:math:`\omega=0,000009417356`, :math:`\alpha=0,07484815` y
:math:`\beta=0,8844196`.

Acción ISA:
~~~~~~~~~~~

:math:`\omega=0,000009801076`, :math:`\alpha=0,1453401` y
:math:`\beta=0,8208107`.

Volatilidades de largo plazo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: V_L=\frac{\omega}{1-\alpha-\beta}

Volatilidad de largo plazo de cada ación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_largo_plazo = vector()
    
    for(i in 1:acciones){
        
      volatilidad_largo_plazo[i] = coeficientes_garch[1, i]/(1 - coeficientes_garch[2, i] - coeficientes_garch[3, i])  
    }
    
    print(volatilidad_largo_plazo)


.. parsed-literal::

    [1] 0.0004380293 0.0002312015 0.0002895511
    

-  La volatilidad a largo plazo de ECO es de 0,0438% diaria.

-  La volatilidad a largo plazo de PFBCOLOM es de 0,0231% diaria.

-  La volatilidad a largo plazo de ISA es de 0,0290% diaria.

Volatilidad GARCH(1,1)
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_rendimientos = nrow(rendimientos)
    numero_rendimientos



.. raw:: html

    2815


Al igual que en volatilidad EWMA, se calculará la volatilidad GARCH(1,1)
para cada período. El primer período tendra un valor igual a cero. Por
tanto, en el segundo ciclo ``for`` se empezará a partir de dos, porque
en uno se especificará que será igual a cero.

.. code:: r

    volatilidad_garch = matrix(, numero_rendimientos, acciones) # Matriz para calcular volatilidad GARCH para cada período por acción.
    
    volatilidad_garch[1,] = 0 # La primera fila de la matriz anterior tendrá como valor semilla igual a cero.
    
    for(j in 1:acciones){
        
      for(i in 2:numero_rendimientos){
          
        volatilidad_garch[i, j] = sqrt(coeficientes_garch[1, j] + coeficientes_garch[2, j]*rendimientos[i - 1, j]^2 + coeficientes_garch[3, j]*volatilidad_garch[i - 1, j]^2)
          
      }
    }

En el código anterior, debido a que la volatilidad GARCH es recursiva,
la volatilidad del período actual depende del rendimiento y de la
volatilidad GARCH del período anterior :math:`t - 1`. Por esto, se
utiliza ``[i - 1]`` para indicar que se utiliza el valor del período
anterior.

.. code:: r

    print(head(volatilidad_garch))
    print(tail(volatilidad_garch))


.. parsed-literal::

                [,1]        [,2]       [,3]
    [1,] 0.000000000 0.000000000 0.00000000
    [2,] 0.006055458 0.007575907 0.01094800
    [3,] 0.010798196 0.011493912 0.01131400
    [4,] 0.012842937 0.011366951 0.01472144
    [5,] 0.021797419 0.011206087 0.01533026
    [6,] 0.021391767 0.014720891 0.02137907
                  [,1]       [,2]       [,3]
    [2810,] 0.01397373 0.01313261 0.01473754
    [2811,] 0.01358770 0.01302408 0.01408182
    [2812,] 0.01316561 0.01357842 0.01351985
    [2813,] 0.01277953 0.01400391 0.01294363
    [2814,] 0.01233045 0.01352324 0.01556906
    [2815,] 0.01209445 0.01311569 0.01861139
    

Volatilidad GARCH(1,1) de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El último valor corresponde a la volatilidad GARCH de cada acción.

.. code:: r

    vol_GARCH = tail(volatilidad_garch, 1)
    print(vol_GARCH)


.. parsed-literal::

                  [,1]       [,2]       [,3]
    [2815,] 0.01209445 0.01311569 0.01861139
    

.. code:: r

    colnames(vol_GARCH) = nombres # se renombran las columnas con los nombres de las acciones.
    print(vol_GARCH)


.. parsed-literal::

                   ECO   PFBCOLOM        ISA
    [2815,] 0.01209445 0.01311569 0.01861139
    

**Volatilidad GARCH:**

-  **ECO:** 1,21% diaria.

-  **PFBCOLOM:** 1,31% diaria.

-  **ISA:** 1,86% diaria.

Volatilidad histórica de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Anteriormente se habían calculado.

.. code:: r

    print(volatilidades)


.. parsed-literal::

           ECO   PFBCOLOM        ISA 
    0.01862871 0.01583774 0.01556859 
    

**Volatilidad histórica:**

-  **ECO:** 1,86% diaria.

-  **PFBCOLOM:** 1,58% diaria.

-  **ISA:** 1,56% diaria.

.. figure:: FiguraVolatilidadesGARCH.jpg
   :alt: 1

   1
