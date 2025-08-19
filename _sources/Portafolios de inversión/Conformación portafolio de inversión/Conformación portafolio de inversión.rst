Conformación portafolio de inversión
------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020.csv", sep=";", dec=",", header = T)

Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]

.. code:: r

    nombres = colnames(precios)
    nombres



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>'ECO'</li><li>'PFVAVAL'</li><li>'ISA'</li><li>'NUTRESA'</li></ol>
    


.. code:: r

    acciones = ncol(precios)
    acciones



.. raw:: html

    4


.. code:: r

    precios = ts(precios)

Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Coeficientes de correlación
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    correlacion = cor(rendimientos)
    correlacion



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFVAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>ECO</th><td>1.0000000</td><td>0.6513161</td><td>0.1531317</td><td>0.3337626</td></tr>
    	<tr><th scope=row>PFVAVAL</th><td>0.6513161</td><td>1.0000000</td><td>0.2308501</td><td>0.3305836</td></tr>
    	<tr><th scope=row>ISA</th><td>0.1531317</td><td>0.2308501</td><td>1.0000000</td><td>0.4572004</td></tr>
    	<tr><th scope=row>NUTRESA</th><td>0.3337626</td><td>0.3305836</td><td>0.4572004</td><td>1.0000000</td></tr>
    </tbody>
    </table>
    


Rendimientos esperado de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_esperados = apply(rendimientos, 2, mean)
    rendimientos_esperados



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>ECO</dt><dd>-0.000447181465559539</dd><dt>PFVAVAL</dt><dd>-0.000398326704447035</dd><dt>ISA</dt><dd>0.000639854532799824</dd><dt>NUTRESA</dt><dd>-0.000268043266851791</dd></dl>
    


Gráfico comparación rendimientos esperados de las acciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(rendimientos_esperados, horiz = T, main="Rendimientos esperados de las acciones")



.. image:: output_15_0.png
   :width: 420px
   :height: 420px


Volatilidad de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    volatilidades



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>ECO</dt><dd>0.0319324424190137</dd><dt>PFVAVAL</dt><dd>0.0285577211893029</dd><dt>ISA</dt><dd>0.0237292026947701</dd><dt>NUTRESA</dt><dd>0.0140104740592151</dd></dl>
    


Gráfico comparación volatilidades de las acciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(volatilidades,horiz = T, main="Volatilidades de las acciones")



.. image:: output_19_0.png
   :width: 420px
   :height: 420px


Portafolio N° 1
~~~~~~~~~~~~~~~

Los portafolios de inversión se conforman con la compra de acciones. Los
inversionistas invierten su dinero en adquirir cierta cantidad de
acciones. Se tendrá el supuesto que sólo se realizan operaciones de
compra y no operaciones de venta en corto.

Para determinar la composición exacta del portafolio de inversión se
debe multiplicar la cantidad de acciones compradas por el último precio
de mercado.

El número de acciones por cada activo financiera está representado por
el vector ``numero_acciones`` y el último precio de mercado por ``s``.
La letra viene del nombre precio *spot*. Para determinar el valor de
mercado de cada una de las acciones se hará la multiplicación:
``numero_acciones*s``, lo cual se llamará ``valor_mercado_acciones``.

De esta manera, el valor de mercado del portafolio,
``valor_portafolio``, será la suma del valor de mercado de cada una de
las acciones. Por último, la conformación del portafolio de inversión
estará representada por las proporciones de inversión que tenga cada una
de las acciones.

Último precio de las acciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    s = tail(precios, 1)
    s = as.numeric(s)
    s



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>2220</li><li>955</li><li>18000</li><li>22500</li></ol>
    


La acción de ECO tiene un precio 2.220 COP, PFAVAL de 955 COP, ISA de
18.000 COP y NUTRESA de 22.500 COP.

Número de acciones portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Supongamos que se en el portafolio de inversión se realizaron las
siguientes compras:

ECO: 150.000 acciones.

PFAVAL: 300.000 acciones.

ISA: 40.000 acciones.

NUTRESA: 70.000 acciones.

.. code:: r

    numero_acciones = c(150000,300000,40000,70000)
    numero_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>150000</li><li>3e+05</li><li>40000</li><li>70000</li></ol>
    


Valor de mercado de las acciones portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_mercado_acciones = numero_acciones*s
    valor_mercado_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>3.33e+08</li><li>286500000</li><li>7.2e+08</li><li>1.575e+09</li></ol>
    


Lo invertido en ECO tiene un valor de 333.000.000 COP, en PFAVAL de
286.500.000 COP, en ISA de 720.000.000 COP y NUTRESA de 157.500.000

Valor de mercado portafolio de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    valor_portafolio = sum(valor_mercado_acciones)
    valor_portafolio



.. raw:: html

    2914500000


El portafolio de inversión tiene un valor de mercado de 2.914.500.000
COP.

Proporciones de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = valor_mercado_acciones/valor_portafolio
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.114256304683479</li><li>0.0983015954709213</li><li>0.24704065877509</li><li>0.540401441070509</li></ol>
    


La conformación del portafolio de inversión es la siguiente,
aproximadamente:

ECO: 11,43%

PFAVAL: 9,83%

ISA: 24,70%

NUTRESA: 54,04%

La suma de las proporciones de inversión debe dar 100% porque se tiene
el supuesto que se invierte todo el dinero disponible y no se realizan
ventas en corto. Con las ventas en corto el porcentaje sería más del
100% porque se estaría apalancado.

.. code:: r

    sum(proporciones)



.. raw:: html

    1


.. math::  \sum_{i=1}^n w_i=1

-----------------------------

Gráfica de proporciones de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    pie(proporciones, nombres, main="Proporciones de inversión portafolio N° 1", col=c("darkgreen","darkblue","darkgray","darkred"))



.. image:: output_41_0.png
   :width: 420px
   :height: 420px


Rendimientos del portafolio de inversión N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El rendimiento del portafolio de inversión es el promedio ponderado de
cada uno de los rendimientos de las acciones por los porcentajes de las
proporciones de inversión.

.. math::  R_P=\sum_{i=1}^nw_iR_i

---------------------------------

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

.. code:: r

    head(rendimientos_portafolio, 10)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>-0.00674979626464658</li><li>0.00989168735951183</li><li>0.00382908516429467</li><li>0.00690563441971709</li><li>-0.00182090582806878</li><li>0.0161071689440197</li><li>0.00338501947733235</li><li>0.014328020875826</li><li>0.00356937173801299</li><li>0.0071767045753624</li></ol>
    


Rendimiento esperado del portafolio de inversión N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    -7.70303347164522e-05


El rendimiento esperado del portafolio de inversión es de -0,00007703%
diario.

Volatilidad del portafolio de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0146098313397769


La volatilidad del portafolio de inversión es de 1,46% diaria.

Gráfico comparación rendimientos esperados con portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(c(rendimientos_esperados, rendimiento_esperado_portafolio), horiz = T, main = "Rendimientos esperados de las acciones\n y del portafolio de inversión N° 1")



.. image:: output_54_0.png
   :width: 420px
   :height: 420px


Gráfico comparación volatilidades con portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(c(volatilidades,volatilidad_portafolio), horiz = T, main = "Volatilidades de las acciones\n y del portafolio de inversión N° 1")



.. image:: output_56_0.png
   :width: 420px
   :height: 420px


Portafolio N° 2
~~~~~~~~~~~~~~~

Por practicidad, se hace análisis de los portafolios de inversión a
partir de las proporciones de inversión sin tener en cuenta la cantidad
de acciones en cada activo. Esto se hace como una aproximación a los
porcentajes de inversión reales.

.. code:: r

    proporciones = c(0.20,0.30,0.15,0.35)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.2</li><li>0.3</li><li>0.15</li><li>0.35</li></ol>
    


.. code:: r

    sum(proporciones)



.. raw:: html

    1


Gráfica de proporciones de inversión portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    pie(proporciones, nombres, main="Proporciones de inversión", col = c("darkgreen","darkblue","darkgray","darkred"))



.. image:: output_62_0.png
   :width: 420px
   :height: 420px


Rendimientos del portafolio de inversión portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio=vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
      
    }

Rendimiento esperado del portafolio de inversión N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
    rendimiento_esperado_portafolio



.. raw:: html

    -0.000206771267924171


El rendimiento esperado del portafolio de inversión es de -0,0207%
diario.

Volatilidad del portafolio de inversión portafolio N° 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0175458696925969


La volatilidad del portafolio de inversión es de 1,75% diaria.

Gráfico comparación rendimientos esperados con portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(c(rendimientos_esperados,rendimiento_esperado_portafolio), horiz = T, main="Rendimientos esperados de las acciones\n y del portafolio de inversión N° 2")



.. image:: output_72_0.png
   :width: 420px
   :height: 420px


Gráfico comparación volatilidades con portafolio N° 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    barplot(c(volatilidades,volatilidad_portafolio), horiz = T, main="Volatilidades de las acciones\n y del portafolio de inversión N° 2")



.. image:: output_74_0.png
   :width: 420px
   :height: 420px

