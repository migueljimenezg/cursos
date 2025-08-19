CVaR
----

**Expected Shortfall (ES):** también llamado VaR Condicional (**CVaR –
conditional VaR**), *tail conditional expectation, conditional loss o
expected tail loss.*

Indica la pérdida potencial más allá del VaR. El **Expected Shortfall**
o CVaR es un promedio de la cola de las pérdidas (*tail loss*).

Al igual que el VaR el CVaR es una función de dos parámetros: el
horizonte de tiempo y el nivel de confianza.

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Tres acciones.csv", sep = ";", header = T)

.. code:: r

    head(datos)
    tail(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 4</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFBCOLOM</th><th scope=col>ISA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>11/01/2008</td><td>1995</td><td>16800</td><td>7000</td></tr>
    	<tr><th scope=row>2</th><td>14/01/2008</td><td>1960</td><td>16380</td><td>6810</td></tr>
    	<tr><th scope=row>3</th><td>15/01/2008</td><td>1905</td><td>15880</td><td>6890</td></tr>
    	<tr><th scope=row>4</th><td>16/01/2008</td><td>1860</td><td>15980</td><td>6710</td></tr>
    	<tr><th scope=row>5</th><td>17/01/2008</td><td>1755</td><td>15900</td><td>6590</td></tr>
    	<tr><th scope=row>6</th><td>18/01/2008</td><td>1725</td><td>15340</td><td>6320</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 4</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFBCOLOM</th><th scope=col>ISA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>2811</th><td>22/07/2019</td><td>3030</td><td>41260</td><td>19000</td></tr>
    	<tr><th scope=row>2812</th><td>23/07/2019</td><td>3015</td><td>42020</td><td>19160</td></tr>
    	<tr><th scope=row>2813</th><td>24/07/2019</td><td>3000</td><td>41280</td><td>19300</td></tr>
    	<tr><th scope=row>2814</th><td>25/07/2019</td><td>3000</td><td>41300</td><td>19800</td></tr>
    	<tr><th scope=row>2815</th><td>26/07/2019</td><td>2980</td><td>41160</td><td>19200</td></tr>
    	<tr><th scope=row>2816</th><td>29/07/2019</td><td>2980</td><td>41300</td><td>18960</td></tr>
    </tbody>
    </table>
    


Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios=datos[,-1]
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
    <ol class=list-inline><li>'ECO'</li><li>'PFBCOLOM'</li><li>'ISA'</li></ol>
    


Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Cantidad de acciones
~~~~~~~~~~~~~~~~~~~~

.. code:: r

    acciones = ncol(precios)
    acciones



.. raw:: html

    3


Cantidad de rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_rendimientos = nrow(rendimientos)
    numero_rendimientos



.. raw:: html

    2815


CVaR
~~~~

CVaR diario con un nivel de confianza del 95% ``NC = 0.95`` ####
Proporciones de inversión. ``proporciones=c(0.25, 0.4, 0.35)``

ECO: 25%

PFBCOLOM: 40%

ISA: 35%

.. code:: r

    NC = 0.95
    proporciones = c(0.25, 0.4, 0.35)
    valor_portafolio = 100000000
    valor_mercado_acciones = proporciones*valor_portafolio

El CVaR es el promedio de los valores menores de la cola de la izquierda
de la distribución empírica de los rendimientos. Con un nivel de
confianza del 95%, el CVaR es el promedio del 5% de los rendimientos más
bajos.

Se tienen 2815 rendimientos por cada acción, el 5% de los rendimientos
representa 140,75 rendimientos, se debe escoger el entero menor, es
decir, el rendimiento 140 entre los rendimientos más bajos será el VaR
en porcentaje y el CVaR en porcentaje será el promedio de estos 140
rendimientos.

Con ``sort(rendimientos[,i], decreasing = T)`` se está ordenando de
mayor a menor valor cada columna de la matriz rendimientos.
``nrow(rendimientos)*(1 - NC)`` calcula la cantidad de rendimientos que
representa el 5% del total de los rendimientos y la función ``floor()``
aproxima al entero menor. En este caso se tiene el valor de 140.

``tail()`` extrae los valores de la parte inferior de cada columna.
Dentro de la función ``tail()`` se indicó que extraiga los 140
rendimientos más bajos. De los valores que extrae, el VaR en porcentaje
corresponde al primer valor y el CVaR en porcentaje es el promedio de
los 140 rendimientos más bajos. Luego, al multiplicar por
``valor_mercado_acciones`` se obtiene el resultado en términos
monetarios.

El CVaR siempre es mayor que el VaR porque tiene en cuenta todos los
valores de la cola y obtiene un promedio.

.. code:: r

    CVaR = vector()
    
    for(i in 1:acciones){
        
      CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1 - NC))))*valor_mercado_acciones[i])
    }
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1122434.60465592</li><li>1419147.26751319</li><li>1293658.09899953</li></ol>
    


Rendimientos del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:numero_rendimientos){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
    }

CVaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rendimientos_portafolio,decreasing = T), floor(nrow(rendimientos)*(1 - NC))))*valor_portafolio)
    CVaR_portafolio



.. raw:: html

    2841126.68189997

