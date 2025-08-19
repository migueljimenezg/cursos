Escalado de variables
---------------------

Algunos algoritmos de Machine Learning no funcionan bien cuando las
variables numéricas de entrada tienen escalas muy diferentes.

Hay dos formas comunes de hacer que todos los atributos tengan la misma
escala: **escala min-max o normalización** y **estandarización.**

Al igual que con todas las transformaciones, es importante ajustar los
escaladores solo a los datos de entrenamiento, no al conjunto de datos
completo. De esta manera, primero debemos hallar el conjunto de train y
de test.

.. code:: ipython3

    import numpy as np
    import pandas as pd

.. code:: ipython3

    m = 1000
    X = 20 * np.random.rand(m, 1)
    y = 4 + 3 * X + np.random.randn(m, 1)

.. code:: ipython3

    from sklearn.model_selection import train_test_split

.. code:: ipython3

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

.. code:: ipython3

    X_train[0:5]




.. parsed-literal::

    array([[ 7.75194088],
           [ 3.63800972],
           [ 5.81527201],
           [ 7.93622219],
           [16.28790652]])



.. code:: ipython3

    X_test[0:5]




.. parsed-literal::

    array([[ 0.17404816],
           [17.93921422],
           [18.41994278],
           [ 2.26642643],
           [ 2.9185026 ]])



Min-Max scaler:
~~~~~~~~~~~~~~~

El min-max también es llamado normalización. Los valores se transforman
en el rango entre 0 y 1. La observación mínima será el 0 y la
observación mayor será el 1, las demás observaciones están ubicadas
entre estos dos valores de manera proporcional. La transformación se
realiza de la siguiente manera:

.. math::  x_{std} = \frac{x_i-x_{min}}{x_{max}-x_{min}}x_{scaled} 

``Scikit-Learn`` proporciona un transformador llamado ``MinMaxScaler``
para esto. Tiene un hiperparámetro ``feature_range`` que le permite
cambiar el rango si, por alguna razón, no desea 0–1. En la anterior
ecuación esto hace referencia a :math:`x_{scaled}`.

.. code:: ipython3

    from sklearn.preprocessing import MinMaxScaler

Creamos un objeto con el nombre ``scaler`` para luego aplicar la
trasnformación.

.. code:: ipython3

    sc = MinMaxScaler()
    sc.fit(X_train)
    X_train = sc.transform(X_train)
    X_test = sc.transform(X_test)

Note que se usaron los mismo parámetros del ``X_train`` para transformar
``X_test``. Recuerde que en el entrenamiento no se debe filtrar
información de un conjunto de datos a otro.

.. code:: ipython3

    X_train[0:5]




.. parsed-literal::

    array([[0.38946779],
           [0.18207437],
           [0.29183553],
           [0.39875786],
           [0.81978687]])



.. code:: ipython3

    X_test[0:5]




.. parsed-literal::

    array([[0.00744753],
           [0.90303336],
           [0.92726807],
           [0.11292947],
           [0.14580224]])



Estandarización:
~~~~~~~~~~~~~~~~

La estandarización no limita los valores a un rango específico.

Las variables estandarizadas se restan por su valor medio y se divide
por la desviación estándar. De esta manera, las variables estandarizadas
tendrán una media cero.

.. math::  x_i = \frac{x_i-\overline{x}}{\sigma_x} 

Donde :math:`\overline{x}` es la media y :math:`\sigma_x` la desviación
estándar de las muestras. La estandarización se ve mucho menos afectada
por los valores atípicos, esta es una ventaja sobre min-max scaler.

La estandarización es la más usada y en estadística es llamado z-score.

``Scikit-Learn`` proporciona un transformador llamado ``StandardScaler``
para la estandarización.

.. code:: ipython3

    m = 1000
    X = 20 * np.random.rand(m, 1)
    y = 4 + 3 * X + np.random.randn(m, 1)

.. code:: ipython3

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

.. code:: ipython3

    from sklearn.preprocessing import StandardScaler

Creamos un objeto con el nombre ``StandardScaler`` para luego aplicar la
transformación.

.. code:: ipython3

    sc = StandardScaler()
    sc.fit(X_train)
    X_train = sc.transform(X_train)
    X_test = sc.transform(X_test)

.. code:: ipython3

    X_train[0:5]




.. parsed-literal::

    array([[ 0.11556589],
           [-1.03946671],
           [-1.63582262],
           [-0.59053055],
           [-1.18490049]])



.. code:: ipython3

    X_test[0:5]




.. parsed-literal::

    array([[-0.31311157],
           [-0.89105652],
           [-0.84027324],
           [ 0.01163997],
           [-0.93034426]])



Note que en las dos transformaciones no se cambió de escala la variable
``y``.

**Otra forma:** para estandarización de las variables podemos usar el
siguiente código:

``mean = X_train.mean(axis=0)``

``X_train -= mean``

``std = X_train.std(axis=0)``

``X_train /= std``

``X_test -= mean``

``X_test /= std``
