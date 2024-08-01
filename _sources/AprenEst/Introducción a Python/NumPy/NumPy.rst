NumPy
-----

``NumPy`` (Numerical Python) es una librería de Python para trabajar con
arrays y hacer operaciones matemáticas. Tiene la ventaja en que las
operaciones se realizan mucho más rápido con esta librería.

Los objetos array de ``numpy`` se llaman ``ndarray``.

Instalar: ``pip install numpy``

Lo común es importar la librería como ``np``.

.. code:: ipython3

    import numpy as np

Creación de Arrays:
~~~~~~~~~~~~~~~~~~~

Los Arrays se crean con la función ``array()``

**Array a partir de una lista:**

.. code:: ipython3

    arr = np.array([1, 2, 3, 4, 5])
    print(arr)


.. parsed-literal::

    [1 2 3 4 5]
    

.. code:: ipython3

    type(arr)




.. parsed-literal::

    numpy.ndarray



**Array a partir de una tupla:**

.. code:: ipython3

    arr = np.array((1, 2, 3, 4, 5))
    print(arr)


.. parsed-literal::

    [1 2 3 4 5]
    

.. code:: ipython3

    type(arr)




.. parsed-literal::

    numpy.ndarray



**0-D Arrays:**

Estos son los escalares.

.. code:: ipython3

    escalar = np.array(42)
    print(escalar)


.. parsed-literal::

    42
    

**1-D Arrays:**

Estos son los vectores.

.. code:: ipython3

    vector = np.array([1, 2, 3, 4, 5])
    print(vector)


.. parsed-literal::

    [1 2 3 4 5]
    

**2-D Arrays:**

Estas son las matrices.

.. code:: ipython3

    matriz = np.array([[1, 2, 3], [4, 5, 6]])
    print(matriz)


.. parsed-literal::

    [[1 2 3]
     [4 5 6]]
    

**3-D Arrays:**

.. code:: ipython3

    arr = np.array([[[1, 2, 3], [4, 5, 6]], [[1, 2, 3], [4, 5, 6]]])
    print(arr)


.. parsed-literal::

    [[[1 2 3]
      [4 5 6]]
    
     [[1 2 3]
      [4 5 6]]]
    

**Dimensiones de los Arrays:**

Se usa el atributo ``ndim``

.. code:: ipython3

    escalar.ndim




.. parsed-literal::

    0



.. code:: ipython3

    vector.ndim




.. parsed-literal::

    1



.. code:: ipython3

    matriz.ndim




.. parsed-literal::

    2



Acceder a los elementos de un Array:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Podemos acceder a los elementos mediante el index. Recordemos que
empieza en ``0``.

.. code:: ipython3

    vector = np.array([1, 2, 3, 4])
    vector[0]




.. parsed-literal::

    1



.. code:: ipython3

    vector[3]




.. parsed-literal::

    4



.. code:: ipython3

    matriz = np.array([[1, 2, 3], [4, 5, 6]])
    print(matriz)


.. parsed-literal::

    [[1 2 3]
     [4 5 6]]
    

.. code:: ipython3

    matriz[1, 1]




.. parsed-literal::

    5



.. code:: ipython3

    matriz[0, 1]




.. parsed-literal::

    2



.. code:: ipython3

    matriz[0]  # Todas las columnas de la fila cero.




.. parsed-literal::

    array([1, 2, 3])



.. code:: ipython3

    matriz[:, 0]  # Todas las filas de la columna cero.




.. parsed-literal::

    array([1, 4])



.. code:: ipython3

    arr = np.array([[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]])
    print(arr)


.. parsed-literal::

    [[[ 1  2  3]
      [ 4  5  6]]
    
     [[ 7  8  9]
      [10 11 12]]]
    

``[dim,fila,columna]``

.. code:: ipython3

    arr[0, 1, 2]




.. parsed-literal::

    6



.. code:: ipython3

    arr[1, 0, 1]




.. parsed-literal::

    8



**Index negativo:**

.. code:: ipython3

    vector[-1]  # Último valor




.. parsed-literal::

    4



.. code:: ipython3

    vector[-2]  # Penúlltimo valor




.. parsed-literal::

    3



.. code:: ipython3

    matriz[-1]  # Última fila




.. parsed-literal::

    array([4, 5, 6])



.. code:: ipython3

    matriz[-1, 1]  # Última fila de la columna 1.




.. parsed-literal::

    5



.. code:: ipython3

    arr[0, 1, -1]  # El valor de la última columna, segunda fila de la primera dimensión.




.. parsed-literal::

    6



.. code:: ipython3

    arr[0, :, -1]  # Todas las filas de la última columna de la primera dimensión.




.. parsed-literal::

    array([3, 6])



Tipos de datos en NumPy:
~~~~~~~~~~~~~~~~~~~~~~~~

``i`` - integer.

``b`` - boolean.

``u`` - unsigned integer.

``f`` - float.

``c`` - complex float.

``m`` - timedelta.

``M`` - datetime.

``O`` - object.

``S`` - string.

``U`` - unicode string.

Se usa el atributo ``dtype`` para saber el tipo de dato.

.. code:: ipython3

    vector = np.array([1, 2, 3, 4, 5])
    vector.dtype




.. parsed-literal::

    dtype('int32')



.. code:: ipython3

    vector = np.array([1, 2.0, 3, 4, 5])
    vector.dtype




.. parsed-literal::

    dtype('float64')



Shape de un Array:
~~~~~~~~~~~~~~~~~~

El ``shape`` de un Array es el número de elementos de cada dimensión.

El atributo ``shape`` de NumPy muestra una tupla con cada índice que
tiene el número de elementos correspondientes.

.. code:: ipython3

    vector = np.array([1, 2.0, 3, 4, 5])
    vector.shape




.. parsed-literal::

    (5,)



.. code:: ipython3

    matriz = np.array([[1, 2, 3, 4], [5, 6, 7, 8]])
    matriz.shape




.. parsed-literal::

    (2, 4)



.. code:: ipython3

    arr = np.array(
        [[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]], [[13, 14, 15], [16, 17, 18]]]
    )
    arr




.. parsed-literal::

    array([[[ 1,  2,  3],
            [ 4,  5,  6]],
    
           [[ 7,  8,  9],
            [10, 11, 12]],
    
           [[13, 14, 15],
            [16, 17, 18]]])



.. code:: ipython3

    arr.shape  # 3D de 2 filas y 3 columnas.




.. parsed-literal::

    (3, 2, 3)



Reshape un Array:
~~~~~~~~~~~~~~~~~

Se puede modificar la cantidad de elementos y las dimensiones de una
Array con el atributo ``reshape``.

**Convertir un vector en una matriz de 4x3:**

.. code:: ipython3

    arr = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    arr




.. parsed-literal::

    array([ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12])



.. code:: ipython3

    newarr = arr.reshape(4, 3)  # 4 filas y 3 columnas.
    newarr




.. parsed-literal::

    array([[ 1,  2,  3],
           [ 4,  5,  6],
           [ 7,  8,  9],
           [10, 11, 12]])



**Convertir un vector en un Array de 3D:**

.. code:: ipython3

    arr = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    newarr = arr.reshape(2, 3, 2)  # 2D de 3 filas y 2 columnas.
    newarr




.. parsed-literal::

    array([[[ 1,  2],
            [ 3,  4],
            [ 5,  6]],
    
           [[ 7,  8],
            [ 9, 10],
            [11, 12]]])



**Convertir multidimensional Array en 1D:**

Se usa ``reshape(-1)``

.. code:: ipython3

    matriz = np.array([[1, 2, 3], [4, 5, 6]])
    print(matriz)


.. parsed-literal::

    [[1 2 3]
     [4 5 6]]
    

.. code:: ipython3

    matriz.reshape(-1)




.. parsed-literal::

    array([1, 2, 3, 4, 5, 6])



Estadísticas básicas con NumPy:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    import pandas as pd

.. code:: ipython3

    df = pd.read_csv("DatosCafe.csv", sep=";", decimal=",")
    print(df.head())


.. parsed-literal::

      Unnamed: 0  PrecioInterno  PrecioInternacional  Producción  Exportaciones  \
    0     ene-00       371375.0               130.12         658          517.0   
    1     feb-00       354297.0               124.72         740          642.0   
    2     mar-00       360016.0               119.51         592          404.0   
    3     abr-00       347538.0               112.67        1055          731.0   
    4     may-00       353750.0               110.31        1114          615.0   
    
           TRM     EUR  
    0  1923.57  1916.0  
    1  1950.64  1878.5  
    2  1956.25  1875.0  
    3  1986.77  1832.0  
    4  2055.69  1971.5  
    

.. code:: ipython3

    df.info()


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 264 entries, 0 to 263
    Data columns (total 7 columns):
     #   Column               Non-Null Count  Dtype  
    ---  ------               --------------  -----  
     0   Unnamed: 0           264 non-null    object 
     1   PrecioInterno        264 non-null    float64
     2   PrecioInternacional  264 non-null    float64
     3   Producción           264 non-null    int64  
     4   Exportaciones        264 non-null    float64
     5   TRM                  264 non-null    float64
     6   EUR                  264 non-null    float64
    dtypes: float64(5), int64(1), object(1)
    memory usage: 14.6+ KB
    

**Media:**

.. code:: ipython3

    np.mean(df["PrecioInterno"])




.. parsed-literal::

    642609.3825



**Mediana:**

.. code:: ipython3

    np.median(df["PrecioInterno"])




.. parsed-literal::

    627371.775



**Moda:**

Para la moda utilizar otra librería.

.. code:: ipython3

    from statistics import mode

.. code:: ipython3

    mode(df["PrecioInterno"])




.. parsed-literal::

    330000.0



**Muestra aleatoria:**

.. code:: ipython3

    muestra = np.random.choice(df["PrecioInterno"], 5)  # 5 observaciones aleatorias
    muestra




.. parsed-literal::

    array([664916.67, 307892.  , 948322.58, 476450.  , 909103.45])



**Máximo:**

.. code:: ipython3

    np.max(df["PrecioInterno"])




.. parsed-literal::

    2116483.87



**Mínimo:**

.. code:: ipython3

    np.min(df["PrecioInterno"])




.. parsed-literal::

    260185.0



**Percentiles:**

.. code:: ipython3

    np.percentile(df["PrecioInterno"], 5)




.. parsed-literal::

    290654.05



.. code:: ipython3

    np.percentile(df["PrecioInterno"], [5, 95])




.. parsed-literal::

    array([ 290654.05 , 1137928.687])



**Varianzas:**

.. code:: ipython3

    np.var(df["PrecioInterno"])




.. parsed-literal::

    92464593086.13692



**Desviación estándar:**

.. code:: ipython3

    np.std(df["PrecioInterno"])




.. parsed-literal::

    304079.9123357821


