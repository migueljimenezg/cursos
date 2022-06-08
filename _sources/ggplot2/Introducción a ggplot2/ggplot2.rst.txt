ggplot2
-------

.. figure:: ggplot2.jpg
   :alt: ggplot2

   ggplot2

``ggplot2`` es un paquete con un gran conjunto de funciones con el fin
de realizar gráficos. Solo admite datos del tipo ``data.frames``

La forma en que se creó la librería es por medio de “capas”, cada capa
contiene una finalidad específica y el gráfico que queremos es la suma
de todas las capas. Esta librería es particular en cuanto a que las
capas se agregan con el signo ``+``. El ``+`` puede ir antes de la
siguiente capa en la misma línea de código o al final de la línea de
código cuando queremos agregar la siguiente cada en el siguiente
renglón. No se puede empezar una línea de código con el ``+``.

Las capas que más se usan son:

-  **Data:** Se indican cuál son los datos. Con esta capa no se logra
   ningún gráfico porque no se ha especificado lo que se quiere
   graficar. Esta primera capa es ``ggplot(data)``

-  **Aesthetics:** Es la Estética del gráfico como color, tipos de
   puntos, tipos de líneas, etc. Esta capa se agrega con ``+ aes()``.
   Con sola esta capa y la anterior (Data) no se puede graficas porque
   no se ha especificado el tipo de gráfico que se desea, para eso está
   la siguiente capa.

-  **Geometries:** En esta capa se indica qué se quiere hacer con Data y
   la Estética. Tiene muchos tipos de gráficos como de líneas, puntos,
   densidad, histogramas, mapas, etc. Esta capa se agrega con
   ``+ geo_nombreFunción()``

-  **Facets:** Divide el plot en subplots. ``+ facet_grid()`` o con
   ``+ facet_wrap()``

-  **Statistics:** Al mismo tiempo que se hace un gráfico se pueden
   mostrar algunos cálculos estadísticos.

-  **Coordinates:** Se pueden invertir los ejes del gráfico con
   ``coord_flip``

Código en R:
~~~~~~~~~~~~

Instalar la librería: ``install.packages("tidyverse")``

Alternativa: ``install.packages("ggplot2")``

.. code:: r

    library(ggplot2)

Opcional: se puede inspeccionar la versión de la librería con
``packageVersion()``

.. code:: r

    packageVersion("ggplot2")



.. parsed-literal::

    [1] '3.3.0'


**Importar datos:**

.. code:: r

    datos = read.csv("Datos.csv", sep = ";", dec = ",", header = T)
    print(datos)


.. parsed-literal::

       Nombre Edad Género  Peso Estrato
    1  Ángela   22      F  62.5       3
    2    José   10      M  75.8       4
    3   Juan    15      M  54.4       3
    4 Manuela   35      F  73.6       3
    5 Maribel   50      F  70.0       5
    6 Antonio   45      M 180.0       4
    7  Alicia    1      F  15.7       1
    8    Luis   32      M 103.5       5
    

.. code:: r

    str(datos)


.. parsed-literal::

    'data.frame':	8 obs. of  5 variables:
     $ Nombre : Factor w/ 8 levels "Alicia","Ángela",..: 2 4 5 7 8 3 1 6
     $ Edad   : int  22 10 15 35 50 45 1 32
     $ Género : Factor w/ 2 levels "F","M": 1 2 2 1 1 2 1 2
     $ Peso   : num  62.5 75.8 54.4 73.6 70 ...
     $ Estrato: int  3 4 3 3 5 4 1 5
    

Data:
~~~~~

Con la capa de data solo se están cargando los datos a la librería
``ggplot2``. Con solo esta capa no se logra graficar, por esta razón, si
se corre el código no se hace un gráfico.

.. code:: r

    ggplot(data = datos)



.. image:: output_13_0.png
   :width: 420px
   :height: 420px


Es común en esta librería crear un objeto ``p`` que almacene todas las
capas anteriores y que permita agregar más capas con el signo ``+``

.. code:: r

    p <- ggplot(data = datos)
    p



.. image:: output_15_0.png
   :width: 420px
   :height: 420px


Aesthetics:
~~~~~~~~~~~

Las principales estéticas de la capa ``aes()`` son:

-  ``x``: para indicar el nombre de la columna para el eje :math:`X`.

-  ``y``: para indicar el nombre de la columna para el eje :math:`y`.

-  ``colour``: color.

-  ``size``: tamaño.

-  ``shape``: formas de los puntos o líneas.

-  ``alpha``: para trasparencias. Se usa cuando se superpone varios
   tipos de gráfico. Entre más cercano a uno, más opaco el gráfico y
   entre más cercano a cero, más transparente.

-  ``fill``: color de relleno.

``shape``:

.. figure:: shape.png
   :alt: shape

   shape

.. code:: r

    ggplot(data = datos) + aes(X = Edad, y = Peso)



.. image:: output_18_0.png
   :width: 420px
   :height: 420px


Es común ver que la capa ``aes()`` es agregada dentro de la función
inicial ``ggplot(data, aes())`` o dentro de la capa Geometries
``geo_nombreFuncion(mapping = aes())``

.. code:: r

    p <- ggplot(data = datos) + aes(x = Edad, y = Peso)
    p



.. image:: output_20_0.png
   :width: 420px
   :height: 420px


Geometries:
~~~~~~~~~~~

Al agregar esta capa sí se muestra un gráfico porque se está indicando
qué debe graficar con los datos ingresados y las estéticas definidas.

Algunos gráficos son:

**Gráficos de dos variables:**

``geom_point()``

``geom_line()``

``geom_area()``

``geom_quantile()``

``geom_smooth()``

**Gráficos de una variable:**

``geom_histogram()``

``geom_freqpoly()``

``geom_density()``

``geom_area()``

``geom_bar()``

``geom_qq()``

``geom_col()``

``geom_boxplot()``

``geom_violin()``

**Gráficos de dos variables:**

.. code:: r

    p <- ggplot(data = datos) + aes(x = Edad, y = Peso)

.. code:: r

    p + geom_point()



.. image:: output_25_0.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_line()



.. image:: output_26_0.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_area()



.. image:: output_27_0.png
   :width: 420px
   :height: 420px


**Gráficos de una variable:**

.. code:: r

    p <- ggplot(data = datos) + aes(x = Estrato)

.. code:: r

    p + geom_histogram()


.. parsed-literal::

    `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
    
    


.. image:: output_30_1.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_freqpoly()


.. parsed-literal::

    `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
    
    


.. image:: output_31_1.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_density()



.. image:: output_32_0.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_boxplot()



.. image:: output_33_0.png
   :width: 420px
   :height: 420px


.. code:: r

    p + geom_bar()



.. image:: output_34_0.png
   :width: 420px
   :height: 420px


Para cambiar la orientación se hace en ``aes()`` indicando solo ``y``

.. code:: r

    ggplot(data = datos) + aes(y = Estrato) +
        geom_bar()



.. image:: output_36_0.png
   :width: 420px
   :height: 420px


Cambiando Aesthetics:
~~~~~~~~~~~~~~~~~~~~~

Los datos en ``aes()`` se pueden agregar en cada capa en lugar de
incluirlos al principio por separado así:

``geo_nombreFunción(aes())``

**Tamaño de los puntos y líneas:**

Con ``size`` se pueden cambiar el tamaño de todos los puntos y líneas al
mismo tiempo si se agrega este argumento por fuera de la función
``aes()``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 10)



.. image:: output_41_0.png
   :width: 420px
   :height: 420px


Si se agrega la función ``size``\ por dentro de ``aes()`` se pueden
hacer una clasificación de los datos en función de una variable. Esta
clasificación se hace cambiando el tamaño de los puntos.

``size = variable`` - Variable para clasificar los datos.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, size = Estrato))



.. image:: output_43_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_line(aes(x = Edad, y = Peso, size = Estrato))



.. image:: output_44_0.png
   :width: 420px
   :height: 420px


**Color:**

Con ``color``, ``colour`` o ``col`` se agregan colores clasificando los
datos en una variable si este argumento se pone dentro de la función
``aes()``. Por ejemplo, los datos de Edad y Peso serán clasificados por
Género y cada Género tendrá un color diferente.

Si el ``color`` va por fuera de ``aes()``, los datos no se clasifican,
solo cambian de color todos los puntos o líneas.

.. code:: r

    ggplot(data = datos) + 
        aes(x = Edad, y = Peso, color = Género) + 
        geom_point(size = 5)



.. image:: output_47_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        aes(x = Edad, y = Peso, color = Nombre)  + 
        geom_point(size = 5)



.. image:: output_48_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_line(aes(x = Edad, y = Peso, color = Estrato))



.. image:: output_49_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) +
        geom_bar(aes(x = Estrato, color = Género))



.. image:: output_50_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) +
        geom_bar(aes(x = Estrato, fill = Género))



.. image:: output_51_0.png
   :width: 420px
   :height: 420px


Note que aparecen unos colores por defecto, pero podemos crear nuestra
propia paleta de colores e ingresarlos manualmente.

Cuando clasificamos los datos por colores podemos cambiar los colores
que la librería muestra por defecto.

Primero, se crea una variable con los colores:
``colores <- c("darkgreen", "darkblue")``.

Luego, se agregan en el gráfico como una capa adicional así:
``+ scale_color_manual(values = colores)``

.. code:: r

    colores <- c("darkgreen", "darkblue") 

.. code:: r

    ggplot(data = datos) + 
        aes(x = Edad, y = Peso, color = Género) + 
        geom_point(size = 5) +
        scale_color_manual(values = colores)



.. image:: output_54_0.png
   :width: 420px
   :height: 420px


**Tipos Líneas:**

Se usa el argumento ``linetype`` igual a un número y por fuera de
``aes()``

.. code:: r

    ggplot(data = datos) + 
        geom_line(aes(x = Edad, y = Peso), linetype = 2, size = 1)



.. image:: output_56_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_line(aes(x = Edad, y = Peso), linetype = 10, size = 2)



.. image:: output_57_0.png
   :width: 420px
   :height: 420px


**Forma de los puntos:**

Con ``shape`` se pueden cambiar todos los puntos al mismo tiempo si se
agrega este argumento por fuera de la función ``aes()``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), shape = 10, size = 10)



.. image:: output_60_0.png
   :width: 420px
   :height: 420px


Si se agrega la función ``shape``\ por dentro de ``aes()`` se pueden
hacer una clasificación de los datos en función de una variable
cambiando la forma de los puntos o líneas.

``shape = variable`` - Se pone la variable para clasificar los datos.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, shape = Género), size = 5)



.. image:: output_62_0.png
   :width: 420px
   :height: 420px


**Transparencias:**

``alpha`` - Entre más cercano a uno, más opaco el gráfico y entre más
cercano a cero, más transparente.

El siguiente ejemplo tiene dos gráficos superpuestos, con los valores
que se dan en ``alpha`` se puede visualizar el gráfico del atrás.

.. code:: r

    ggplot(data = datos) + 
        geom_histogram(aes(x = Peso), 
                       color = "black",   # Color del borde.
                       fill = "darkred",  # Color del rectángulo. 
                       bins = 10,
                       alpha = 0.6) +     # Transparencia de 0,6.
        geom_histogram(aes(x = Edad), 
                       color = "black",
                       fill = "darkblue",
                       bins = 10, 
                       alpha = 0.3)       # Transparencia de 0,3. Más transparente que el anterior.



.. image:: output_65_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_density(aes(x = Peso), 
                       color = "darkred",   # Color del borde.
                       fill = "darkred",  # Color del rectángulo. 
                       alpha = 0.5) +     # Transparencia de 0,6.
        geom_density(aes(x = Edad), 
                       color = "darkblue",
                       fill = "darkblue",
                       alpha = 0.5)       # Transparencia de 0,3. Más transparente que el anterior.



.. image:: output_66_0.png
   :width: 420px
   :height: 420px


Facets:
~~~~~~~

Para crear subplots clasificando los datos.

**``facet_wrap()``:**

Para clasificar en función de variables discretas. Se crean varios
gráficos para clasificar los datos.

``facet_wrap(~ nombre variable)``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_wrap(~ Género)   # Divide el gráfico en función del Género



.. image:: output_71_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_wrap(~ Género, nrow = 2) # nrow = para cantidad de filas



.. image:: output_72_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_wrap(~ Estrato) # Divide el gráfico en función del Estrato



.. image:: output_73_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_wrap(~ Estrato, ncol = 4) # ncol = para cantidad de columnas



.. image:: output_74_0.png
   :width: 420px
   :height: 420px


En el siguiente gráfico se usa ``facet_wrap()`` para clasificar los
datos por Estrato en cada subplot y al mismo tiempo se clasifican por
Género al cambiar el color agregando ``color = Género`` dentro de
``aes()``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato, ncol = 4) # ncol = para cantidad de columnas



.. image:: output_76_0.png
   :width: 420px
   :height: 420px


**``facet_grid()``:**

Crea subplots para clasificar los datos en una o dos variables.

``facet_grid(nombre variable 1 ~ nombre variable 2)``

``facet_grid(y ~ X)``

-  ``nombre variable 1``: clasificación vertical.

-  ``nombre variable 2``: clasificación horizontal.

**Con dos variables:**

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) +
        facet_grid(Género ~ Estrato) # Género (y) - vertical y Estrato (X) - horizontal.



.. image:: output_82_0.png
   :width: 420px
   :height: 420px


**Con una sola variable:**

Para omitir una variable se reemplaza por un punto ``.``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_grid(Género ~ .) 



.. image:: output_85_0.png
   :width: 420px
   :height: 420px


.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso), size = 5) + 
        facet_grid(. ~ Género) # Cambia la posición al cambiar la variable



.. image:: output_86_0.png
   :width: 420px
   :height: 420px


**Combinar gráficos:**

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Estrato, y = Peso), 
                   size = 7, 
                   shape = 25,
                   fill = "darkgray") + 
        geom_line(aes(x = Estrato, y = Edad), 
                  linetype = 5, 
                  color = "darkred",
                  lwd = 2)



.. image:: output_88_0.png
   :width: 420px
   :height: 420px


Statistics:
~~~~~~~~~~~

Con la librería ggplot2 se pueden hacer cálculos estadísticos y
representarlos gráficamente. Algunas funciones empiezan con
``stat_nombre Función()``

Primero, un gráfico con los datos:

.. code:: r

    ggplot(data = datos) + aes(x = Estrato, y = Peso) +
        geom_point(size = 3)



.. image:: output_92_0.png
   :width: 420px
   :height: 420px


Segundo, con el siguiente gráfico se calculará el promedio por cada
Estrato.

Se utiliza la función ``stat_summary()``, el promedio se especifica con
``fun = mean``

.. code:: r

    ggplot(data = datos) + aes(x = Estrato, y = Peso) +
        stat_summary(fun = mean, geom = "point", color = "red", size = 3)



.. image:: output_94_0.png
   :width: 420px
   :height: 420px


El siguiente gráfico muestra los datos en color negro y el promedio por
Estrato en color rojo.

.. code:: r

    ggplot(data = datos) + aes(x = Estrato, y = Peso) +
        geom_point(size = 3) + 
        stat_summary(fun = "mean", geom = "point", color = "red", size = 3)



.. image:: output_96_0.png
   :width: 420px
   :height: 420px


El siguiente gráfico muestra los promedios por Estrato, pero en una
línea roja.

.. code:: r

    ggplot(data = datos) + aes(x = Estrato, y = Peso) +
        geom_point(size = 3) + 
        stat_summary(fun = "mean", geom = "line", color = "red", size = 1)



.. image:: output_98_0.png
   :width: 420px
   :height: 420px


Uso de los argumentos ``fun.min`` y ``fun.max``:

Se muestra el promedio por Estrato, el máximo y el mínimo.

.. code:: r

    ggplot(data = datos) + aes(x = Estrato, y = Peso) +
        stat_summary(fun = mean, fun.min = min, fun.max = max, color = "red", size = 1)



.. image:: output_100_0.png
   :width: 420px
   :height: 420px


**Proporciones:**

Para mostrar proporciones, se agrega el siguiente argumento dentro de la
función ``geom_bar()``:

``y = ..prop..``

Por defecto, el resultado que muestra es de conteo, ``y = ..count..``

.. code:: r

    ggplot(data = datos) +
        geom_bar(aes(x = Estrato, y = ..prop..))



.. image:: output_103_0.png
   :width: 420px
   :height: 420px


Las demás funciones estadísticas también están por defecto en los
gráficos.

Coordinates:
~~~~~~~~~~~~

Se usa la función ``coord_flip`` para cambiar los ejes, es decir, girar
el gráfico.

.. code:: r

    ggplot(data = datos) +
        geom_bar(aes(x = Estrato, y = ..prop..)) + 
        coord_flip()



.. image:: output_107_0.png
   :width: 420px
   :height: 420px


Theme:
~~~~~~

El siguiente gráfico tiene el tema por defecto que es el tema
``theme_gray``.

Fondo gris y líneas de cuadrícula blancas, diseñado para presentar los
datos y facilitar las comparaciones.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato)



.. image:: output_110_0.png
   :width: 420px
   :height: 420px


``theme_bw``:

Classic dark-on-light. Para usarse en proyectores.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_bw()



.. image:: output_113_0.png
   :width: 420px
   :height: 420px


``theme_linedraw``:

Fondo blanco con líneas negras.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_linedraw()



.. image:: output_116_0.png
   :width: 420px
   :height: 420px


``theme_light``:

Simular al anterior, ``theme_linedraw``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_light()



.. image:: output_119_0.png
   :width: 420px
   :height: 420px


``theme_dark``:

Similar al anterior, ``theme_light``, pero con fondo oscuro. Ideal para
resaltar líneas finas de color.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_dark()



.. image:: output_122_0.png
   :width: 420px
   :height: 420px


``theme_minimal``:

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_minimal()



.. image:: output_124_0.png
   :width: 420px
   :height: 420px


``theme_classic``:

Sin líneas de cuadrícula.

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_classic()



.. image:: output_127_0.png
   :width: 420px
   :height: 420px


``theme_void``:

Vacío

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_void()



.. image:: output_130_0.png
   :width: 420px
   :height: 420px


``theme_test``:

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Género), size = 5) + 
        facet_wrap(~ Estrato) +
        theme_test()



.. image:: output_132_0.png
   :width: 420px
   :height: 420px


Títulos y etiquetas:
~~~~~~~~~~~~~~~~~~~~

Los títulos y las etiquetas se agregan con ``labs()``.

**Argumentos de** ``labs()``:

``title`` - Título

``subtitle`` - Subtítulo

``caption`` - Viñeta

``x`` - Nombre eje :math:`X`

``y`` - Nombre eje :math:`y`

``fill`` - Nombre de la leyenda de códigos de colores creados con
``fill =``

``color`` - Nombre de la leyenda de códigos de colores creados con
``color =``

``shape`` - Nombre de la leyenda de simbología creada con ``shape =``

.. code:: r

    ggplot(data = datos) + 
        geom_point(aes(x = Edad, y = Peso, color = Nombre, shape = Género), size = 4) + 
        facet_wrap(~ Estrato) +
        theme_minimal() +
        labs(title = "Peso vs. Edad",
            subtitle = "Clasificación por Género, Estrato y Nombre",
            caption = "Fuente: Elaboración propia",
            x = "Edad",
            y = "Peso",
            shape = "Género con \n formas diferentes",  # Se personaliza la leyenda de Género
            color = "Cada nombre \n con un color")      # Se personaliza la leyenda de Nombre



.. image:: output_135_0.png
   :width: 420px
   :height: 420px


Extraer los gráficos:
~~~~~~~~~~~~~~~~~~~~~

Los gráficos se pueden extraer con la función
``ggsave("Nombre.extensión")``

Por defecto extrae el último gráfico.

Formatos: “eps”, “ps”, “tex” (pictex), “pdf”, “jpeg”, “tiff”, “png”,
“bmp”, “svg”

.. code:: r

    ggsave("Guardado.png")


.. parsed-literal::

    Saving 6.67 x 6.67 in image
    
    
