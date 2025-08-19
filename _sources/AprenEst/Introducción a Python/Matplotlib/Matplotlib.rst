Matplotlib
----------

.. code:: ipython3

    import pandas as pd
    import numpy as np

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
    

Instalar ``pip install matplotlib``

El submódulo ``pyplot`` de Matplotlib tiene muchas utilidades y lo más
común es importarlo con el alias de ``plt``.

.. code:: ipython3

    import matplotlib.pyplot as plt

Con ``pyplot`` se grafica de la siguiente manera:
``plt.tipo de gráfico``.

**General:**

Del módulo al que hemos renombrado ``plt``:

-  ``.title()`` para añadir un título al plot.

-  ``.xlabel()`` para añadir una etiqueta al eje horizontal del plot 2D.

-  ``.ylabel()`` para añadir una etiqueta al eje vertical del plot 2D.

-  ``.legend()`` para mostrar una leyenda.

Scatter plot:
~~~~~~~~~~~~~

Se usa el método ``.scatter`` del módulo ``plt``: ``plt.scatter()``

.. code:: ipython3

    plt.scatter(x=df["TRM"], y=df["Producción"])




.. parsed-literal::

    <matplotlib.collections.PathCollection at 0x1994acabdc0>




.. image:: output_11_1.png


.. code:: ipython3

    plt.scatter(x=df["TRM"], y=df["Producción"])
    plt.show()  # para eliminar el comentario <matplotlib.collections.PathCollection at...>



.. image:: output_12_0.png


.. code:: ipython3

    plt.scatter(x=df["TRM"], y=df["Producción"])
    # el ; para eliminar el comentario <matplotlib.collections.PathCollection at...>




.. parsed-literal::

    <matplotlib.collections.PathCollection at 0x1994adbe9a0>




.. image:: output_13_1.png


**Tamaño del gráfico:**

En la primera línea de código se agrega:

``plt.figure(figsize=(10,10))``: cambiar los valores 10,10 para el
tamaño que desee.

.. code:: ipython3

    plt.figure(figsize=(10, 5))
    plt.title("TRM vs Producción")
    plt.xlabel("TRM")
    plt.ylabel("Producción")
    plt.scatter(x=df["TRM"], y=df["Producción"])




.. parsed-literal::

    <matplotlib.collections.PathCollection at 0x1994adec430>




.. image:: output_15_1.png


Algunos de los parámetros son:

-  ``x``: scalar, array o lista que indica la primera coordenada de las
   observaciones.

-  ``y``: scalar, array o lista que indica la segunda coordenada de las
   observaciones.

-  ``c``: para cambiar el color de relleno.

-  ``edgecolors``: para cambiar el color del contorno.

-  ``alpha``: para cambiar la transparencia.

-  ``marker``: para cambiar la `forma del
   punto <https://matplotlib.org/3.2.1/api/markers_api.html#module-matplotlib.markers>`__

-  ``s``: para cambiar el tamaño de los puntos (se mide en puntos).

-  ``linewidths``: para cambiar el grosor del contorno.

.. code:: ipython3

    plt.figure(figsize=(10, 5))
    plt.title("TRM vs Producción")
    plt.xlabel("TRM")
    plt.ylabel("Producción")
    plt.scatter(
        x=df["TRM"],
        y=df["Producción"],
        c="lightskyblue",
        edgecolors="lightskyblue",
        marker="*",
        alpha=0.8,
        s=200,
        linewidths=2,
    )




.. parsed-literal::

    <matplotlib.collections.PathCollection at 0x1994ae723d0>




.. image:: output_17_1.png


Line Plot:
~~~~~~~~~~

Para hacer un gráfico Line plot, usamos el método ``.plot()`` del módulo
``plt``.

Algunos de los parámetros de este método son:

-  ``x``: scalar, array o lista que indica la primera coordenada de las
   observaciones.

-  ``y``: scalar, array o lista que indica la segunda coordenada de las
   observaciones.

-  ``color``: para cambiar el color de relleno. También podemos
   referirnos a este parámetro por su diminutivo ``c``.

-  ``fmt``: para establecer un formato básico rápidamente como string.
   Por ejemplo, ``"or"`` son círculos rojos. El orden recomendado para
   introducir el formato de este modo es
   ``"[marker][linestyle][color]"`` aunque también se admite
   ``"[color][marker][linestyle]"``.

-  ``linewidth``: para cambiar el grosor de la línea. También podemos
   referirnos a este parámetro por su diminutivo ``lw``.

-  ``linestyle``: para cambiar el estilo de la línea. También podemos
   referirnos a este parámetro por su diminutivo ``ls``.

-  ``alpha``: para cambiar la transparencia.

-  ``marker``: para cambiar la `forma del
   punto <https://matplotlib.org/3.2.1/api/markers_api.html#module-matplotlib.markers>`__.
   Si no indicamos este parámetro, no se dibujan los puntos..

-  ``markersize``: para cambiar el tamaño de los puntos. También podemos
   referirnos a este parámetro por su diminutivo ``ms``.

-  ``markeredgecolor``: para cambiar el color del contorno del punto.
   También podemos referirnos a este parámetro por su diminutivo
   ``mec``.

-  ``markerfacecolor``: para cambiar el color de relleno del punto.
   También podemos referirnos a este parámetro por su diminutivo
   ``mfc``.

Para el parámetro ``fmt``, las opciones disponibles para ``marker``,
``linestyle`` y ``color`` son

+----------+----------+----------+----------+----------+----------+
| ``       | forma    | ``lin    | estilo   | `        | color    |
| marker`` |          | estyle`` | de línea | `color`` |          |
+==========+==========+==========+==========+==========+==========+
| ``"."``  | punto    | ``"-"``  | sólido   | ``"b"``  | azul     |
|          |          | o        |          | o        |          |
|          |          | ``"      |          | ``       |          |
|          |          | solid"`` |          | "blue"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``","``  | píxel    | ``"--"`` | dis      | ``"g"``  | verde    |
|          |          | o        | continuo | o        |          |
|          |          | ``"d     |          | ``"      |          |
|          |          | ashed"`` |          | green"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"o"``  | círculo  | ``"-."`` | gui      | ``"r"``  | rojo     |
|          |          | o        | ón-punto | o        |          |
|          |          | ``"da    |          | `        |          |
|          |          | shdot"`` |          | `"red"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"v"``  | t        | ``":"``  | puntos   | ``"c"``  | cian     |
|          | riángulo | o        |          | o        |          |
|          | hacia    | ``"d     |          | ``       |          |
|          | abajo    | otted"`` |          | "cyan"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"^"``  | t        | ``       | sin      | ``"m"``  | magenta  |
|          | riángulo | "None"`` | línea    | o        |          |
|          | hacia    |          |          | ``"ma    |          |
|          | arriba   |          |          | genta"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"<"``  | t        |          |          | ``"y"``  | amarillo |
|          | riángulo |          |          | o        |          |
|          | hacia    |          |          | ``"y     |          |
|          | i        |          |          | ellow"`` |          |
|          | zquierda |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``">"``  | t        |          |          | ``"k"``  | negro    |
|          | riángulo |          |          | o        |          |
|          | hacia    |          |          | ``"      |          |
|          | derecha  |          |          | black"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"1"``  | tri      |          |          | ``"w"``  | blanco   |
|          | hacia    |          |          | o        |          |
|          | abajo    |          |          | ``"      |          |
|          |          |          |          | white"`` |          |
+----------+----------+----------+----------+----------+----------+
| ``"2"``  | tri      |          |          |          |          |
|          | hacia    |          |          |          |          |
|          | arriba   |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"3"``  | tri      |          |          |          |          |
|          | hacia    |          |          |          |          |
|          | i        |          |          |          |          |
|          | zquierda |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"4"``  | tri      |          |          |          |          |
|          | hacia    |          |          |          |          |
|          | derecha  |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"s"``  | cuadrado |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"p"``  | p        |          |          |          |          |
|          | entágono |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"*"``  | estrella |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"h"``  | hexágono |          |          |          |          |
|          | 1        |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"H"``  | hexágono |          |          |          |          |
|          | 2        |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"+"``  | cruz     |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"x"``  | x        |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"D"``  | diamante |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"d"``  | diamante |          |          |          |          |
|          | fino     |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"\|"`` | barra    |          |          |          |          |
|          | vertical |          |          |          |          |
+----------+----------+----------+----------+----------+----------+
| ``"_"``  | barra    |          |          |          |          |
|          | ho       |          |          |          |          |
|          | rizontal |          |          |          |          |
+----------+----------+----------+----------+----------+----------+

**Observación:** Si no indicamos parámetro ``x``, se consideran como
primeras coordenadas los números enteros 0, 1, 2, …, :math:`n-1`, siendo
:math:`n` el número total de observaciones:

.. code:: ipython3

    plt.figure(figsize=(10, 5))
    plt.title("Evolución TRM")
    plt.ylabel("TRM")
    plt.plot(df["TRM"])




.. parsed-literal::

    [<matplotlib.lines.Line2D at 0x1994aec3ac0>]




.. image:: output_22_1.png


.. code:: ipython3

    plt.figure(figsize=(10, 5))
    plt.title("Evolución TRM")
    plt.ylabel("TRM")
    plt.plot(df["TRM"], c="darkgreen", lw=2, ls="dotted")




.. parsed-literal::

    [<matplotlib.lines.Line2D at 0x1994ae34dc0>]




.. image:: output_23_1.png


**Observación.** En un mismo plot podemos dibujar más de una línea:

.. code:: ipython3

    plt.figure(figsize=(10, 5))
    plt.title("Evolución TRM y EURO")
    plt.ylabel("TRM")
    plt.plot(df["EUR"], c="black", lw=2)
    plt.plot(df["TRM"], c="darkgreen", lw=2, ls="dotted")




.. parsed-literal::

    [<matplotlib.lines.Line2D at 0x1994ad34c10>]




.. image:: output_25_1.png


Bar Plot:
~~~~~~~~~

Para hacer un gráfico de barras, usamos el método ``.bar()`` del módulo
``plt``.

Algunos de los parámetros de este método son:

-  ``x``: float, array o lista que indica las categorías o coordenadas
   de las barras.

-  ``height``: float, array o lista que indica las alturas de las
   barras.

-  ``width``: para cambiar el ancho de las barras.

-  ``linewidth``: para cambiar el tamaño del borde de las barras.

-  ``bottom``: para cambiar el valor vertical mínimo de las barras.

-  ``align``: posición de la marca del eje horizontal con respecto a la
   base de las barras. Por defecto vale “center”.

-  ``color`` para cambiar los colores de las barras. Si pasamos una
   lista, podemos asignar un color diferente a cada barra.

-  ``edgecolor``: para cambiar el color del borde de las barras.

.. code:: ipython3

    valores = np.percentile(df["PrecioInterno"], [1, 25, 50, 75])
    percentiles = [1, 25, 50, 75]
    
    plt.ylabel("Precio Interno")
    plt.xlabel("Percentiles")
    plt.bar(percentiles, valores, color=["#ff7f7d", "#ffc07d", "#817dff", "#7dff86"])




.. parsed-literal::

    <BarContainer object of 4 artists>




.. image:: output_28_1.png


.. code:: ipython3

    grades = ["Perdió", "Aprobó", "Excelente"]
    count = [35, 55, 23]
    
    plt.bar(grades, count, color=["#ff7f7d", "#ffc07d", "#817dff", "#7dff86"], width=0.5)
    plt.xlabel("Notas")
    plt.ylabel("Número estudiantes")
    plt.title("Notas de los estudiantes de una clase")




.. parsed-literal::

    Text(0.5, 1.0, 'Notas de los estudiantes de una clase')




.. image:: output_29_1.png


Note que en el código anterior se cambió el orden de las líneas de
código, pero al final siempre se termina con ``;`` o podría ser
``plt.show()``.

Para barras horizontales se usa ``.barh()``.

El ancho de las barras horizontales se cambia con ``height`` y no con
``width``

.. code:: ipython3

    grades = ["Perdió", "Aprobó", "Excelente"]
    count = [35, 55, 23]
    
    plt.barh(grades, count, color=["#ff7f7d", "#ffc07d", "#817dff", "#7dff86"], height=0.5)
    plt.xlabel("Notas")
    plt.ylabel("Número estudiantes")
    plt.title("Notas de los estudiantes de una clase")




.. parsed-literal::

    Text(0.5, 1.0, 'Notas de los estudiantes de una clase')




.. image:: output_32_1.png


Pie Chart:
~~~~~~~~~~

Para hacer un gráfico de sectores, usamos el método ``.pie()`` del
módulo ``plt``.

Algunos de los parámetros de este método son:

-  ``x``: array 1D o lista.

-  ``labels``: para especificar las etiquetas.

-  ``colors``: para cambiar los colores de los sectores. Si pasamos una
   lista, podemos asignar un color diferente a cada sector circular.

-  ``autopct``: para editar el formato en que se muestra el porcentaje.

-  ``labeldistance``: para ajustar la distancia radial de las etiquetas.

-  ``radius``: para modificar el radio del gráfico.

-  ``startangle``: para cambiar el ángulo (en grados) con el que se
   empieza (por defecto es 0).

-  ``explode``: vector de distancias para indicar cómo de separado
   queremos que esté el sector correspondiente del resto.

-  ``shadow``: para añadir sombra a los sectores.

.. code:: ipython3

    options = ["Con", "Sin"]
    count = [80, 20]
    
    plt.pie(count, colors=["gold", "silver"], labels=options, autopct="%0.1f%%")
    plt.title("¿Pizza con o sin piña?")




.. parsed-literal::

    Text(0.5, 1.0, '¿Pizza con o sin piña?')




.. image:: output_35_1.png


.. code:: ipython3

    options = ["Con", "Sin"]
    count = [80, 20]
    
    plt.pie(
        count,
        colors=["gold", "silver"],
        labels=options,
        autopct="%0.1f%%",
        startangle=90,
        explode=[0.2, 0],
        shadow=True,
    )
    plt.title("¿Pizza con o sin piña?")




.. parsed-literal::

    Text(0.5, 1.0, '¿Pizza con o sin piña?')




.. image:: output_36_1.png


Histograma:
~~~~~~~~~~~

Para hacer un histograma, usamos el método ``.hist()`` del módulo
``plt``.

Algunos de los parámetros de este método son:

-  ``x``: array o lista de observaciones.

-  ``bins``: para especificar el tamaño de los intervalos.

-  ``range``: para especificar el mínimo y el máximo de las bins.

-  ``histtype``: para indicar qué tipo de histograma queremos dibujar.

-  ``align``: para configurar la alineación de las barras del
   histograma.

-  ``orientation``: para modificar la orientación del histograma
   (vertical u horizontal).

-  ``color``: para modificar el color de las barras.

-  ``edgecolor``: para modficar el color de contorno de las barras.

.. code:: ipython3

    plt.hist(df["TRM"], bins=100, color="silver", edgecolor="silver");



.. image:: output_39_0.png

