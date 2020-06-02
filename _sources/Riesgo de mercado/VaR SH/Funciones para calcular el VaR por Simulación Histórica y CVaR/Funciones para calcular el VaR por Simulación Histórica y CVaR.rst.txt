Funciones para calcular el VaR por Simulación Histórica y CVaR
--------------------------------------------------------------

Se crea un vector con los valores enteros entre el cero y el 10:

.. code:: r

    vector = c(0:10)
    vector



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0</li><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li></ol>
    


Función ``quantile()``
~~~~~~~~~~~~~~~~~~~~~~

Esta función hallar el valor que corresponde al percentil que se le
indica.

El percentil del 1% es el valor que se encuentra en el 1% de los valores
menores.

Percentil del 1%
~~~~~~~~~~~~~~~~

.. code:: r

    quantile(vector, 0.01)



.. raw:: html

    <strong>1%:</strong> 0.1


Percentil del 5%
~~~~~~~~~~~~~~~~

.. code:: r

    quantile(vector, 0.05)



.. raw:: html

    <strong>5%:</strong> 0.5


Percentil del 10%
~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(vector, 0.10)



.. raw:: html

    <strong>10%:</strong> 1


Percentil del 30%
~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(vector, 0.30)



.. raw:: html

    <strong>30%:</strong> 3


Percentil del 100%
~~~~~~~~~~~~~~~~~~

.. code:: r

    quantile(vector, 1)



.. raw:: html

    <strong>100%:</strong> 10


Función ``tail()``
~~~~~~~~~~~~~~~~~~

Esta función extrae los valores de la parte inferior de los vectores o
matrices (no los valores menores). ``vector`` está ordenado del 0 hasta
el 10 con saltos de uno en uno. En este vector el 0 es el valor de la
parte superior y el 10 es el último valor de la parte inferior.

Extraer los últimos 10 valores de la parte inferior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tail(vector, 10)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li></ol>
    


Extraer el último valor de la parte inferior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tail(vector, 1)



.. raw:: html

    10


Extraer los dos últimos valores de la parte inferior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tail(vector, 2)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>9</li><li>10</li></ol>
    


Extraer los últimos cuatro valores de la parte inferior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tail(vector, 4)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>7</li><li>8</li><li>9</li><li>10</li></ol>
    


Función ``head()``
~~~~~~~~~~~~~~~~~~

Esta función es contraria a ``tail()``, extrae los valores de la parte
superior de los vectores o matrices.

Extraer el primer valor de la parte superior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    head(vector, 1)



.. raw:: html

    0


Extraer los tres primeros valores de la parte superior del vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    head(vector, 3)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0</li><li>1</li><li>2</li></ol>
    


Combinar ``head()`` y ``tail()``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**De los últimos cinco valores de la parte inferior del vector, extraer
el valor de la parte de arriba:**

.. code:: r

    head(tail(vector, 5), 1)



.. raw:: html

    6


De los últimos cinco valores de la parte inferior del vector, extraer los dos valores de la parte de arriba:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    head(tail(vector, 5), 2)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>6</li><li>7</li></ol>
    


Función ``sort()``
~~~~~~~~~~~~~~~~~~

Esta función ordena de mayor a menor o de menor a mayor los valores en
los vectores o matrices.

Ordenar de mayor a menor el vector:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    sort(vector, decreasing = T)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>10</li><li>9</li><li>8</li><li>7</li><li>6</li><li>5</li><li>4</li><li>3</li><li>2</li><li>1</li><li>0</li></ol>
    

