Introducción a la teoría de portafolios
---------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020.csv", sep = ";", dec = ",", header = T)

.. code:: r

    head(datos)
    tail(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>26/03/2018</td><td>2775</td><td>1165</td><td>13080</td><td>25720</td></tr>
    	<tr><th scope=row>2</th><td>27/03/2018</td><td>2645</td><td>1155</td><td>13080</td><td>25700</td></tr>
    	<tr><th scope=row>3</th><td>28/03/2018</td><td>2615</td><td>1165</td><td>13320</td><td>25980</td></tr>
    	<tr><th scope=row>4</th><td>2/04/2018 </td><td>2690</td><td>1165</td><td>13420</td><td>25920</td></tr>
    	<tr><th scope=row>5</th><td>3/04/2018 </td><td>2730</td><td>1175</td><td>13660</td><td>25920</td></tr>
    	<tr><th scope=row>6</th><td>4/04/2018 </td><td>2740</td><td>1190</td><td>13560</td><td>25840</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>495</th><td>3/04/2020 </td><td>2270</td><td>906</td><td>15500</td><td>19700</td></tr>
    	<tr><th scope=row>496</th><td>6/04/2020 </td><td>2260</td><td>955</td><td>16140</td><td>19720</td></tr>
    	<tr><th scope=row>497</th><td>7/04/2020 </td><td>2230</td><td>932</td><td>16680</td><td>20020</td></tr>
    	<tr><th scope=row>498</th><td>8/04/2020 </td><td>2360</td><td>936</td><td>17200</td><td>20700</td></tr>
    	<tr><th scope=row>499</th><td>13/04/2020</td><td>2250</td><td>951</td><td>17860</td><td>21300</td></tr>
    	<tr><th scope=row>500</th><td>14/04/2020</td><td>2220</td><td>955</td><td>18000</td><td>22500</td></tr>
    </tbody>
    </table>
    


Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]
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
    <ol class=list-inline><li>'ECO'</li><li>'PFAVAL'</li><li>'ISA'</li><li>'NUTRESA'</li></ol>
    


Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Coeficientes de correlación
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    correlacion = cor(rendimientos)
    print(correlacion)


.. parsed-literal::

                  ECO    PFAVAL       ISA   NUTRESA
    ECO     1.0000000 0.6513161 0.1531317 0.3337626
    PFAVAL  0.6513161 1.0000000 0.2308501 0.3305836
    ISA     0.1531317 0.2308501 1.0000000 0.4572004
    NUTRESA 0.3337626 0.3305836 0.4572004 1.0000000
    

Rendimientos esperado de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_esperados = apply(rendimientos, 2, mean)
    print(rendimientos_esperados)


.. parsed-literal::

              ECO        PFAVAL           ISA       NUTRESA 
    -0.0004471815 -0.0003983267  0.0006398545 -0.0002680433 
    

Volatilidad de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    print(volatilidades)


.. parsed-literal::

           ECO     PFAVAL        ISA    NUTRESA 
    0.03193244 0.02855772 0.02372920 0.01401047 
    

Portafolio N° 1
~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.15, 0.10, 0.50, 0.25)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.15</li><li>0.1</li><li>0.5</li><li>0.25</li></ol>
    


.. code:: r

    sum(proporciones)



.. raw:: html

    1


Rendimientos del portafolio de inversión N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

Rendimiento esperado del portafolio de inversión N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    0.00014600655940833


Volatilidad del portafolio de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0170532910785492


Indicador de diversificación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FormulaDiverisificación.jpg
   :alt: 3

   3

.. code:: r

    h = 1 - volatilidad_portafolio/sum(volatilidades)
    h



.. raw:: html

    0.826393985619325


Gráfico de las acciones riesgo-rendimiento portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(volatilidades, rendimientos_esperados, xlab = " Volatilidad", ylab = "Rendimiento esperado", col = c(1:4), pch = 19, cex = 2)
    points(volatilidad_portafolio, rendimiento_esperado_portafolio, pch = 17, cex = 2)
    legend("topleft", c(nombres, "Portafolio N°1"), pch = c(rep(19,4), 17), col = c(1:4), bty = "n")



.. image:: output_29_0.png
   :width: 420px
   :height: 420px


Rendimientos del portafolio de inversión N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.25, 0.20, 0.45, 0.10)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.25</li><li>0.2</li><li>0.45</li><li>0.1</li></ol>
    


.. code:: r

    sum(proporciones)



.. raw:: html

    1


Rendimientos del portafolio de inversión N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

Rendimiento esperado del portafolio de inversión N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    6.966950579545e-05


Volatilidad del portafolio de inversión portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0187732453389869


Indicador de diversificación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    h = 1 - volatilidad_portafolio/sum(volatilidades)
    h



.. raw:: html

    0.808884497116707


Gráfico de las acciones riesgo-rendimiento portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(volatilidades, rendimientos_esperados, xlab = " Volatilidad", ylab = "Rendimiento esperado", col = c(1:4), pch = 19, cex = 2)
    points(volatilidad_portafolio, rendimiento_esperado_portafolio, pch = 17, cex = 2)
    legend("topleft", c(nombres, "Portafolio N°1"), pch = c(rep(19,4), 17), col = c(1:4), bty = "n")



.. image:: output_42_0.png
   :width: 420px
   :height: 420px

