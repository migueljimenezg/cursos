Pandas
------

Pandas es una librería para manipulación y análisis de datos.

Instalación: ``pip install pandas``

Las librerías se importan en Python con ``import``.

.. code:: ipython3

    import pandas

Con pandas podemos convertir variables en ``Data Frames``. Estos son un
conjunto de vectores con un index asociado. Cada columna tiene un nombre
al igual que las filas.

.. code:: ipython3

    x = [28, 25, 10]
    x = pandas.DataFrame(x)

Usualmente cada librería se importa y se le asigna un alias para que sea
más fácil de usar, por ejemplo, pandas se importa como ``pd``. Para
utilizar pandas ya no sería necesario escribir la palabra ``panda``, en
su lugar se escribe ``pd``.

.. code:: ipython3

    import pandas as pd

.. code:: ipython3

    x = pd.DataFrame(x)

Pandas Series:
~~~~~~~~~~~~~~

Un ``Panda Series`` es un matriz unidimensional que contiene cualquier
tipo de datos, es decir, es una colummna en un tabla.

.. code:: ipython3

    x = [28, 25, 10]
    serie = pd.Series(x)
    print(serie)


.. parsed-literal::

    0    28
    1    25
    2    10
    dtype: int64
    

Si no se especifica, el index aparecerá desde el valor del cero ``[0]``.
Para acceder al primer valor se usa lo siguiente:

.. code:: ipython3

    serie[0]




.. parsed-literal::

    28



El segundo elemento se puede extraer así:

.. code:: ipython3

    serie[1]




.. parsed-literal::

    25



Para que el index tenga un nombre se usa el argumento ``index =``.

.. code:: ipython3

    serie = pd.Series(x, index=["Primera fila", "Segunda fila", "Tercera fila"])
    print(serie)


.. parsed-literal::

    Primera fila    28
    Segunda fila    25
    Tercera fila    10
    dtype: int64
    

Con estas etiquetas creadas en el index se puede acceder a los elementos
por el nombre del index así:

.. code:: ipython3

    serie["Tercera fila"]




.. parsed-literal::

    10



DataFrames:
~~~~~~~~~~~

Las ``Series`` son una columna de una tabla, un ``DataFrame`` es una
tabla completa de 2 dimensiones.

**Dataframe:** Es una estructura bidimensional mutable de datos con los
ejes etiquetados donde:

-  Cada fila representa una observación diferente.

-  Cada columna representa una variable diferente.

Vamos a crear un DataFrame de 5 filas y 2 columnas a partir de un
diccionario.

Para ello, primero creamos un diccionario donde las claves serán los
nombres de las columnas y los valores serán listas, con tantos elementos
como número de filas queramos.

Finalmente, convertimos ese diccionario a DataDrame con la función
``DataFrame()`` de ``pandas``.

.. code:: ipython3

    data = {"x": [1, 2, 3, 4, 5], "y": [2, 4, 6, 8, 10]}
    df = pd.DataFrame(data)
    print(df)


.. parsed-literal::

       x   y
    0  1   2
    1  2   4
    2  3   6
    3  4   8
    4  5  10
    

Ahora vamos a crear un DataFrame a partir de una lista de listas.

.. code:: ipython3

    y = [[51, 21, 54], [1, 2, 3]]  # Esta es la lista de listas
    y




.. parsed-literal::

    [[51, 21, 54], [1, 2, 3]]



.. code:: ipython3

    type(y)




.. parsed-literal::

    list



.. code:: ipython3

    df = pd.DataFrame(y)
    print(df)


.. parsed-literal::

        0   1   2
    0  51  21  54
    1   1   2   3
    

.. code:: ipython3

    type(df)




.. parsed-literal::

    pandas.core.frame.DataFrame



Podemos crear también el DataFrame a partir de una lista de lista
indicando el nombre de las columnas con ``columns``.

.. code:: ipython3

    df = pd.DataFrame([[51, 21, 54], [1, 2, 3]], columns=["x", "y", "z"])
    print(df)


.. parsed-literal::

        x   y   z
    0  51  21  54
    1   1   2   3
    

Para asignar los nombres a las filas lo hacemos con ´index´.

.. code:: ipython3

    df = pd.DataFrame(
        [[51, 21, 54], [1, 2, 3]],
        columns=["x", "y", "z"],
        index=["Observación 1", "Observación 2"],
    )
    print(df)


.. parsed-literal::

                    x   y   z
    Observación 1  51  21  54
    Observación 2   1   2   3
    

**Dimensiones del DataFrame:**

Con el método ``.shape`` podemos calcular las dimensiones (número de
filas y columnas) del DataFrame.

.. code:: ipython3

    df.shape




.. parsed-literal::

    (2, 3)



Con el método ``.size`` calculamos el número total de elementos que
tiene el DataFrame (número de filas por número de columnas).

.. code:: ipython3

    df.size




.. parsed-literal::

    6



Finalmente, con el método ``.ndim`` calculamos el número de dimensiones
que tiene el DataDrame, siempre valdrá 2, pues consta de filas y
columnas.

.. code:: ipython3

    df.ndim




.. parsed-literal::

    2



SubDataFrames:
~~~~~~~~~~~~~~

Dado un DataFrame, un subDataFrame es la selección de unas filas y
columnas en particular.

**Columnas:**

Dado un DataFrame, podemos seleccionar una columna en particular de
diversas formas:

-  Indicando el nombre de la columna entre corchetes ``[]``

-  Con el método ``.columns[]``

-  Con el método ``.loc[]`` (por nombre o etiqueta).

-  Con el método ``.iloc[]`` (por posición).

.. code:: ipython3

    data = {
        "Name": ["Alicia", "Bill", "Carlos", "Diana"],
        "Age": [22, 28, 19, 34],
        "Pet": [True, False, False, True],
        "Height": [157, 190, 175, 164],
        "Birthday": ["Mayo", "Junio", "Agosto", "Diciembre"],
    }
    df = pd.DataFrame(data=data, index=["obs1", "obs2", "obs3", "obs4"])
    print(df)


.. parsed-literal::

            Name  Age    Pet  Height   Birthday
    obs1  Alicia   22   True     157       Mayo
    obs2    Bill   28  False     190      Junio
    obs3  Carlos   19  False     175     Agosto
    obs4   Diana   34   True     164  Diciembre
    

**Selección de una columna por nombre:**

.. code:: ipython3

    df["Age"]




.. parsed-literal::

    obs1    22
    obs2    28
    obs3    19
    obs4    34
    Name: Age, dtype: int64



**Selección de una columna con** ``.columns[]``:

.. code:: ipython3

    df[df.columns[1]]




.. parsed-literal::

    obs1    22
    obs2    28
    obs3    19
    obs4    34
    Name: Age, dtype: int64



**Selección de una columna con** ``.loc[]``:

``.loc[filas:columnas]``, el símbolo ``:`` indica todas las filas o
todas las columnas.

.. code:: ipython3

    df.loc[:, "Age"]




.. parsed-literal::

    obs1    22
    obs2    28
    obs3    19
    obs4    34
    Name: Age, dtype: int64



**Selección de una columna con** ``.iloc[]``:

.. code:: ipython3

    print(df.iloc[:, 1])


.. parsed-literal::

    obs1    22
    obs2    28
    obs3    19
    obs4    34
    Name: Age, dtype: int64
    

**Selección de varias columnas por nombre:**

.. code:: ipython3

    print(df[["Name", "Age"]])


.. parsed-literal::

            Name  Age
    obs1  Alicia   22
    obs2    Bill   28
    obs3  Carlos   19
    obs4   Diana   34
    

**Selección de varias columnas con** ``.columns[]``:

.. code:: ipython3

    print(df[df.columns[[0, 1]]])


.. parsed-literal::

            Name  Age
    obs1  Alicia   22
    obs2    Bill   28
    obs3  Carlos   19
    obs4   Diana   34
    

Otra forma: podemos usar el string ``:`` para seleccionar varias
columnas que están seguidas.

Note que con ``[0:3]`` se seleccionar las columnas desde las ``0`` hasta
la ``2``, no toma la columna ``3``.

.. code:: ipython3

    print(df[df.columns[0:3]])


.. parsed-literal::

            Name  Age    Pet
    obs1  Alicia   22   True
    obs2    Bill   28  False
    obs3  Carlos   19  False
    obs4   Diana   34   True
    

.. code:: ipython3

    print(df[df.columns[2:4]])  # No selecciona la columna 4, solo hasta la 3


.. parsed-literal::

            Pet  Height
    obs1   True     157
    obs2  False     190
    obs3  False     175
    obs4   True     164
    

**Selección de varias columnas con** ``.loc[]``:

.. code:: ipython3

    print(df.loc[:, ["Name", "Age"]])


.. parsed-literal::

            Name  Age
    obs1  Alicia   22
    obs2    Bill   28
    obs3  Carlos   19
    obs4   Diana   34
    

Otra forma:

.. code:: ipython3

    print(df.loc[:, "Name":"Height"])


.. parsed-literal::

            Name  Age    Pet  Height
    obs1  Alicia   22   True     157
    obs2    Bill   28  False     190
    obs3  Carlos   19  False     175
    obs4   Diana   34   True     164
    

**Selección de varias columnas con** ``.iloc[]``:

.. code:: ipython3

    print(df.iloc[:, [0, 1]])


.. parsed-literal::

            Name  Age
    obs1  Alicia   22
    obs2    Bill   28
    obs3  Carlos   19
    obs4   Diana   34
    

.. code:: ipython3

    print(df.iloc[:, 0:4])  # No selecciona la columna 4


.. parsed-literal::

            Name  Age    Pet  Height
    obs1  Alicia   22   True     157
    obs2    Bill   28  False     190
    obs3  Carlos   19  False     175
    obs4   Diana   34   True     164
    

.. code:: ipython3

    print(df.iloc[:, 0:5])  # Si selecciona la columna 4


.. parsed-literal::

            Name  Age    Pet  Height   Birthday
    obs1  Alicia   22   True     157       Mayo
    obs2    Bill   28  False     190      Junio
    obs3  Carlos   19  False     175     Agosto
    obs4   Diana   34   True     164  Diciembre
    

**Filas:**

Dado un DataFrame, podemos seleccionar una fila en particular de
diversas formas:

-  Con el método ``.loc[]`` (por nombre o etiqueta).

-  Con el método ``.iloc[]`` (por posición).

**Selección de filas con** ``.loc[]``:

Una fila:

.. code:: ipython3

    print(df.loc["obs1"])


.. parsed-literal::

    Name        Alicia
    Age             22
    Pet           True
    Height         157
    Birthday      Mayo
    Name: obs1, dtype: object
    

Varias filas:

.. code:: ipython3

    print(df.loc[["obs2", "obs3"]])


.. parsed-literal::

            Name  Age    Pet  Height Birthday
    obs2    Bill   28  False     190    Junio
    obs3  Carlos   19  False     175   Agosto
    

.. code:: ipython3

    print(df.loc["obs2":"obs4"])


.. parsed-literal::

            Name  Age    Pet  Height   Birthday
    obs2    Bill   28  False     190      Junio
    obs3  Carlos   19  False     175     Agosto
    obs4   Diana   34   True     164  Diciembre
    

**Selección de filas con** ``.iloc[]``:

Una fila:

.. code:: ipython3

    print(df.iloc[[1]])


.. parsed-literal::

          Name  Age    Pet  Height Birthday
    obs2  Bill   28  False     190    Junio
    

Varias filas:

.. code:: ipython3

    print(df.iloc[[1, 2]])


.. parsed-literal::

            Name  Age    Pet  Height Birthday
    obs2    Bill   28  False     190    Junio
    obs3  Carlos   19  False     175   Agosto
    

.. code:: ipython3

    print(df.iloc[1:3])  # No toma la fila 3


.. parsed-literal::

            Name  Age    Pet  Height Birthday
    obs2    Bill   28  False     190    Junio
    obs3  Carlos   19  False     175   Agosto
    

**Filas y columnas:**

Para seleccionar un elemento en concreto, hay que indicar la fila y la
columna y lo podemos hacer de dos formas:

-  Con el método ``.loc[]`` (por nombre o etiqueta).

-  Con el método ``.iloc[]`` (por índice).

.. code:: ipython3

    print(df.loc["obs2", "Age"])


.. parsed-literal::

    28
    

.. code:: ipython3

    print(df.iloc[1, 1])


.. parsed-literal::

    28
    

Si queremos seleccionar un subconjunto de filas y columnas, podemos
utilizar los dos métodos anteriores.

.. code:: ipython3

    print(df.loc["obs2":"obs3", ["Name", "Birthday"]])


.. parsed-literal::

            Name Birthday
    obs2    Bill    Junio
    obs3  Carlos   Agosto
    

.. code:: ipython3

    print(df.iloc[1:3, [0, 4]])


.. parsed-literal::

            Name Birthday
    obs2    Bill    Junio
    obs3  Carlos   Agosto
    

Cargar archivos con Pandas:
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para archivos con formato csv se usa ``pd.read_csv()``.

Guarde el archivo en el formato
``CSV UTF-8 (delimitado por comas) (*.csv)``

.. figure:: GuardarArchivos.JPG
   :alt: GuardarArchivos

   GuardarArchivos

.. code:: ipython3

    df = pd.read_csv("DatosCafe.csv", sep=";")
    print(df.head())


.. parsed-literal::

      Unnamed: 0 PrecioInterno PrecioInternacional  Producción Exportaciones  \
    0     ene-00        371375              130,12         658           517   
    1     feb-00        354297              124,72         740           642   
    2     mar-00        360016              119,51         592           404   
    3     abr-00        347538              112,67        1055           731   
    4     may-00        353750              110,31        1114           615   
    
           TRM     EUR  
    0  1923,57    1916  
    1  1950,64  1878,5  
    2  1956,25    1875  
    3  1986,77    1832  
    4  2055,69  1971,5  
    

Los decimales están separados por ``,``. Agregar ``decimal = ","``

.. code:: ipython3

    df = pd.read_csv("DatosCafe.csv", sep=";", decimal=",")
    print(df)


.. parsed-literal::

        Unnamed: 0  PrecioInterno  PrecioInternacional  Producción  Exportaciones  \
    0       ene-00      371375.00               130.12         658         517.00   
    1       feb-00      354297.00               124.72         740         642.00   
    2       mar-00      360016.00               119.51         592         404.00   
    3       abr-00      347538.00               112.67        1055         731.00   
    4       may-00      353750.00               110.31        1114         615.00   
    ..         ...            ...                  ...         ...            ...   
    259     ago-21     1704806.45               228.95         915        1130.97   
    260     sep-21     1712138.00               248.61        1209        1089.83   
    261     oct-21     1784935.48               270.27        1012         986.83   
    262     nov-21     1999655.17               291.93        1131        1135.45   
    263     dic-21     2116483.87               302.82        1385        1167.18   
    
             TRM     EUR  
    0    1923.57  1916.0  
    1    1950.64  1878.5  
    2    1956.25  1875.0  
    3    1986.77  1832.0  
    4    2055.69  1971.5  
    ..       ...     ...  
    259  3887.68  4447.0  
    260  3820.28  4407.0  
    261  3771.68  4344.0  
    262  3900.51  4526.0  
    263  3967.77  4622.0  
    
    [264 rows x 7 columns]
    

.. code:: ipython3

    type(df)




.. parsed-literal::

    pandas.core.frame.DataFrame



.. code:: ipython3

    len(df)




.. parsed-literal::

    264



**Primera fila del DataFrame:**

.. code:: ipython3

    df.loc[0]




.. parsed-literal::

    Unnamed: 0               ene-00
    PrecioInterno          371375.0
    PrecioInternacional      130.12
    Producción                  658
    Exportaciones             517.0
    TRM                     1923.57
    EUR                      1916.0
    Name: 0, dtype: object



**Tres filas específicas del DataFrame:**

.. code:: ipython3

    print(df.loc[[1, 3, 4]])


.. parsed-literal::

      Unnamed: 0  PrecioInterno  PrecioInternacional  Producción  Exportaciones  \
    1     feb-00       354297.0               124.72         740          642.0   
    3     abr-00       347538.0               112.67        1055          731.0   
    4     may-00       353750.0               110.31        1114          615.0   
    
           TRM     EUR  
    1  1950.64  1878.5  
    3  1986.77  1832.0  
    4  2055.69  1971.5  
    

Análisis de DataFrames con Pandas:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para visualizar las primeras 5 filas del DataFrame usamos ``head()``
así:

.. code:: ipython3

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
    

Para las primeras 11 filas:

.. code:: ipython3

    print(df.head(11))


.. parsed-literal::

       Unnamed: 0  PrecioInterno  PrecioInternacional  Producción  Exportaciones  \
    0      ene-00       371375.0               130.12         658          517.0   
    1      feb-00       354297.0               124.72         740          642.0   
    2      mar-00       360016.0               119.51         592          404.0   
    3      abr-00       347538.0               112.67        1055          731.0   
    4      may-00       353750.0               110.31        1114          615.0   
    5      jun-00       341688.0               100.30        1092          869.0   
    6      jul-00       345190.0               101.67         811          721.0   
    7      ago-00       330113.0                91.87         436          938.0   
    8      sep-00       330000.0                89.97         501          674.0   
    9      oct-00       330000.0                90.25         940          831.0   
    10     nov-00       330000.0                84.01        1366         1200.0   
    
            TRM     EUR  
    0   1923.57  1916.0  
    1   1950.64  1878.5  
    2   1956.25  1875.0  
    3   1986.77  1832.0  
    4   2055.69  1971.5  
    5   2120.17  2053.5  
    6   2161.34  2014.5  
    7   2187.38  1970.5  
    8   2213.76  1954.0  
    9   2176.61  1815.0  
    10  2136.63  1889.0  
    

De la misma manera se puede visualizar las últimas filas, pero con
``tail()``.

.. code:: ipython3

    print(df.tail())


.. parsed-literal::

        Unnamed: 0  PrecioInterno  PrecioInternacional  Producción  Exportaciones  \
    259     ago-21     1704806.45               228.95         915        1130.97   
    260     sep-21     1712138.00               248.61        1209        1089.83   
    261     oct-21     1784935.48               270.27        1012         986.83   
    262     nov-21     1999655.17               291.93        1131        1135.45   
    263     dic-21     2116483.87               302.82        1385        1167.18   
    
             TRM     EUR  
    259  3887.68  4447.0  
    260  3820.28  4407.0  
    261  3771.68  4344.0  
    262  3900.51  4526.0  
    263  3967.77  4622.0  
    

Para conocer la información por cada columna del DataFrame se usa
``info()``. Muestra la cantidad de datos por columna, si hay datos vacío
y el tipo de dato.

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
    
