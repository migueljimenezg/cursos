Estadística aplicada a los activos bursátiles
---------------------------------------------

Utilizar el archivo Cuatro acciones 2020.csv.

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020.csv", sep = ";", dec = ",", header = T)

.. code:: r

    head(datos)



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
    


Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]

.. code:: r

    head(precios)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 4</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>2775</td><td>1165</td><td>13080</td><td>25720</td></tr>
    	<tr><th scope=row>2</th><td>2645</td><td>1155</td><td>13080</td><td>25700</td></tr>
    	<tr><th scope=row>3</th><td>2615</td><td>1165</td><td>13320</td><td>25980</td></tr>
    	<tr><th scope=row>4</th><td>2690</td><td>1165</td><td>13420</td><td>25920</td></tr>
    	<tr><th scope=row>5</th><td>2730</td><td>1175</td><td>13660</td><td>25920</td></tr>
    	<tr><th scope=row>6</th><td>2740</td><td>1190</td><td>13560</td><td>25840</td></tr>
    </tbody>
    </table>
    


Nombres de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~

``colnames`` extrae los nombres de los encabezados.

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
    


``ncol`` cuanta cuántas columnas tiene las matrices.

.. code:: r

    acciones = ncol(precios)
    acciones



.. raw:: html

    4


Conversión de la base de datos como serie de tiempo.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La función ``ts`` hace una conversión a los precios como series de
tiempo. Este paso puede ser opcional.

.. code:: r

    precios = ts(precios)

Gráfica de los precios de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(precios, t = "l", xlab = "Tiempo")



.. image:: output_17_0.png
   :width: 420px
   :height: 420px


Rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Rendimiento discreto:**

.. math:: Rendimiento_t=\frac{Precio_t-Precio_{t-1}}{Precio_{t-1}}=\frac{Precio_t}{Precio_{t-1}}-1

**Conversión de tasas discretas a continuas:**

.. math:: log(1+r)

**Rendimiento continuo o logarítmico o geométrico:**

.. math:: Rendimiento_t=log(1+Rendimiento_{discreto})

.. math:: Rendimiento_t=log\frac{Precio_t}{Precio_{t-1}}

--------------------------------------------------------

Los rendimientos discretos y continuos se aproximan cuando el
rendimiento es pequeño, y los rendimientos serán pequeños si se trara de
un horizonte de tiempo corto.

En adelante, usaremos los rendimientos continuos.

De las propiedades de los logaritmos tenemos:

.. math:: log\frac{Precio_t}{Precio_{t-1}}=log(Precio_t)-log(Precio_{t-1})

Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

Con ``log(precios[,i]`` se aplica la función de logaritmo natural a
todos los precios y con la función ``diff`` se calcula la diferencia de
los logaritmos que de las propiedades de los logaritmo mencionada
anteriormente, se llega a los rendimientos por período de cada acción

.. code:: r

    rendimientos <- matrix(0, nrow(precios) -1, acciones)
    
    for(i in 1:acciones){
        
      rendimientos[,i] = diff(log(precios[,i]))
        
    }

Cuando se aplica la función ``ts`` a los precios, no es necesario
utilizar el código anterior para calcular los rendimientos. Se puede
hacer de la siguiente manera:

.. code:: r

    rendimientos = diff(log(precios))

.. code:: r

    head(rendimientos)



.. raw:: html

    <table>
    <caption>A matrix: 6 × 4 of type dbl</caption>
    <thead>
    	<tr><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    </thead>
    <tbody>
    	<tr><td>-0.047979682</td><td>-0.008620743</td><td> 0.000000000</td><td>-0.0007779075</td></tr>
    	<tr><td>-0.011406968</td><td> 0.008620743</td><td> 0.018182319</td><td> 0.0108360193</td></tr>
    	<tr><td> 0.028277096</td><td> 0.000000000</td><td> 0.007479466</td><td>-0.0023121398</td></tr>
    	<tr><td> 0.014760416</td><td> 0.008547061</td><td> 0.017725723</td><td> 0.0000000000</td></tr>
    	<tr><td> 0.003656311</td><td> 0.012685160</td><td>-0.007347572</td><td>-0.0030911926</td></tr>
    	<tr><td> 0.000000000</td><td> 0.020790770</td><td> 0.023324673</td><td> 0.0153612852</td></tr>
    </tbody>
    </table>
    


Si se tiene :math:`n` cantidad de precios, se tendrá :math:`n-1`
rendimientos. Cada acción acción tiene 500 precios, entonces, se tendrán
499 rendimientos.

El tamaño de un vector o columna se calcula con ``dim``.

.. code:: r

    dim(precios)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>500</li><li>4</li></ol>
    


.. code:: r

    dim(rendimientos)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>499</li><li>4</li></ol>
    


Gráficas de los rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    plot(rendimientos[,1], t = "h", xlab = "Tiempo", ylab = "Rendimientos", main = nombres[1])



.. image:: output_30_0.png
   :width: 420px
   :height: 420px


.. code:: r

    plot(rendimientos[,2], t = "h", xlab = "Tiempo", ylab = "Rendimientos", main = nombres[2])



.. image:: output_31_0.png
   :width: 420px
   :height: 420px


.. code:: r

    plot(rendimientos[,3], t = "h", xlab = "Tiempo", ylab = "Rendimientos", main = nombres[3])



.. image:: output_32_0.png
   :width: 420px
   :height: 420px


.. code:: r

    plot(rendimientos[,4], t = "h", xlab = "Tiempo", ylab = "Rendimientos", main = nombres[4])



.. image:: output_33_0.png
   :width: 420px
   :height: 420px


Los cuatro gráficos anteriores se pueden juntar en uno solo. En R se
utiliza el siguiente código para dividir la ventana donde salen los
gráficos. Primero se crea una matriz con las posiciones que queremos
tener y después se muestra la matriz con ``layout.show()``.

.. code:: r

    layout(matrix(c(1:4),nrow=2,byrow=F))
    layout.show(4)



.. image:: output_35_0.png
   :width: 420px
   :height: 420px


Para quitar la partición a la ventana plot se debe correo el código
``dev.off()``. Así los gráficos saldran del tamaño de la ventana y un
solo un gráfico por ventana.

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byro w= F))
    layout.show(4)
    for(i in 1:acciones){
        
        plot(rendimientos[,i], t = "h", xlab = "Tiempo", ylab = "Rendimientos", main = nombres[i])
    }



.. image:: output_37_0.png
   :width: 420px
   :height: 420px


Estadísticas básicas de los rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    summary(rendimientos)



.. parsed-literal::

          ECO                 PFAVAL                ISA            
     Min.   :-0.4065868   Min.   :-0.4038136   Min.   :-0.2756262  
     1st Qu.:-0.0096775   1st Qu.:-0.0077671   1st Qu.:-0.0084762  
     Median : 0.0000000   Median : 0.0000000   Median : 0.0012682  
     Mean   :-0.0004472   Mean   :-0.0003983   Mean   : 0.0006398  
     3rd Qu.: 0.0117059   3rd Qu.: 0.0081301   3rd Qu.: 0.0101129  
     Max.   : 0.1498123   Max.   : 0.2058521   Max.   : 0.1386834  
        NUTRESA         
     Min.   :-0.105361  
     1st Qu.:-0.006312  
     Median : 0.000000  
     Mean   :-0.000268  
     3rd Qu.: 0.005472  
     Max.   : 0.065983  


Se debe instalar el paquete ``install.packages("fBasics")``. Utilizar el
código anterior en R para instalar el paquete. Después de instalar, se
llama la librería ``fBasics``.

.. code:: r

    library(fBasics)

.. code:: r

    basicStats(rendimientos)



.. raw:: html

    <table>
    <caption>A data.frame: 16 × 4</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>nobs</th><td>499.000000</td><td>499.000000</td><td>499.000000</td><td>499.000000</td></tr>
    	<tr><th scope=row>NAs</th><td>  0.000000</td><td>  0.000000</td><td>  0.000000</td><td>  0.000000</td></tr>
    	<tr><th scope=row>Minimum</th><td> -0.406587</td><td> -0.403814</td><td> -0.275626</td><td> -0.105361</td></tr>
    	<tr><th scope=row>Maximum</th><td>  0.149812</td><td>  0.205852</td><td>  0.138683</td><td>  0.065983</td></tr>
    	<tr><th scope=row>1. Quartile</th><td> -0.009678</td><td> -0.007767</td><td> -0.008476</td><td> -0.006312</td></tr>
    	<tr><th scope=row>3. Quartile</th><td>  0.011706</td><td>  0.008130</td><td>  0.010113</td><td>  0.005472</td></tr>
    	<tr><th scope=row>Mean</th><td> -0.000447</td><td> -0.000398</td><td>  0.000640</td><td> -0.000268</td></tr>
    	<tr><th scope=row>Median</th><td>  0.000000</td><td>  0.000000</td><td>  0.001268</td><td>  0.000000</td></tr>
    	<tr><th scope=row>Sum</th><td> -0.223144</td><td> -0.198765</td><td>  0.319287</td><td> -0.133754</td></tr>
    	<tr><th scope=row>SE Mean</th><td>  0.001429</td><td>  0.001278</td><td>  0.001062</td><td>  0.000627</td></tr>
    	<tr><th scope=row>LCL Mean</th><td> -0.003256</td><td> -0.002910</td><td> -0.001447</td><td> -0.001500</td></tr>
    	<tr><th scope=row>UCL Mean</th><td>  0.002361</td><td>  0.002113</td><td>  0.002727</td><td>  0.000964</td></tr>
    	<tr><th scope=row>Variance</th><td>  0.001020</td><td>  0.000816</td><td>  0.000563</td><td>  0.000196</td></tr>
    	<tr><th scope=row>Stdev</th><td>  0.031932</td><td>  0.028558</td><td>  0.023729</td><td>  0.014010</td></tr>
    	<tr><th scope=row>Skewness</th><td> -4.487458</td><td> -4.641477</td><td> -2.657806</td><td> -0.908069</td></tr>
    	<tr><th scope=row>Kurtosis</th><td> 57.943763</td><td> 87.840091</td><td> 38.693818</td><td> 11.122682</td></tr>
    </tbody>
    </table>
    


Rendimientos esperados.
~~~~~~~~~~~~~~~~~~~~~~~

El rendimiento esperado es el promedio de los 499 rendimientos de cada
acción. La función ``mean`` calcula el promedio.

El rendimiento esperado de cada acción se puede calcular de dos formas:

Forma 1:
~~~~~~~~

.. code:: r

    rendimientos_esperados = vector()
    
    for(i in 1:acciones){
        
        rendimientos_esperados[i] = mean(rendimientos[,i])
        
    }
    rendimientos_esperados



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>-0.000447181465559539</li><li>-0.000398326704447035</li><li>0.000639854532799824</li><li>-0.000268043266851791</li></ol>
    


Forma 2:
~~~~~~~~

Se puede utilizar la función ``apply``. En esta función se debe indicar
el valor de ``1``\ para aplicar otra función a las filas del vector o
matriz o el valor ``2`` para aplicar otra función a las columnas. En
este caso se aplicará ``mean`` a las columnas de las matriz de
rendimientos.

.. code:: r

    rendimientos_esperados = apply(rendimientos, 2, mean)
    rendimientos_esperados



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>ECO</dt><dd>-0.000447181465559539</dd><dt>PFAVAL</dt><dd>-0.000398326704447035</dd><dt>ISA</dt><dd>0.000639854532799824</dd><dt>NUTRESA</dt><dd>-0.000268043266851791</dd></dl>
    


La frecuencia de las series de tiempo cargadas es diaria, esto implica
que los resultados tendrán la misma frecuencia temporal. Por tanto, los
rendimientos son diarios.

**Rendimiento esperado:**

**ECO:** -0,000447 :math:`=` -0,0447% diario.

**PFVAVAL:** -0,000398 :math:`=` -0,0398% diario.

**ISA:** -0,000640 :math:`=` -0,0640% diario.

**NUTRESA:** -0,000268 :math:`=` -0,0268% diario.

Volatilidad o desviación estándar
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La volatilidad de las acciones se calculan con la función\ ``sd``.

La volatilidad de cada acción se puede calcular de dos formas:

Forma 1:
~~~~~~~~

.. code:: r

    volatilidades = vector()
    
    for(i in 1:acciones){
        
        volatilidades[i ]= sd(rendimientos[,i])
        
    }
    volatilidades



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.0319324424190137</li><li>0.0285577211893029</li><li>0.0237292026947701</li><li>0.0140104740592151</li></ol>
    


Forma 2:
~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    volatilidades



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>ECO</dt><dd>0.0319324424190137</dd><dt>PFAVAL</dt><dd>0.0285577211893029</dd><dt>ISA</dt><dd>0.0237292026947701</dd><dt>NUTRESA</dt><dd>0.0140104740592151</dd></dl>
    


**Volatilidad:**

**ECO:** 0,0319 :math:`=` 3,19% diario.

**PFVAVAL:** 0,0286 :math:`=` 2,86% diario.

**ISA:** 0,0237 :math:`=` 2,37% diario.

**NUTRESA:** 0,0140 :math:`=` 1,40% diario.

Histograma de los rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byrow = F))
    
    for(i in 1:acciones){
        
        hist(rendimientos[,i], breaks = 60, col = "gray", xlab = "Rendimientos", ylab = "Frecuencia", main = nombres[i], freq = F)
    }



.. image:: output_59_0.png
   :width: 420px
   :height: 420px


Histograma y distribución normal.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byrow = F))
    
    for(i in 1:acciones){
        
        hist(rendimientos[,i], breaks = 60, col = "gray", xlab = "Rendimientos", ylab = "Frecuencia", main = nombres[i], freq = F)
        curve(dnorm(x, mean = rendimientos_esperados[i], sd = volatilidades[i]), add = T, lwd = 3)
    }



.. image:: output_61_0.png
   :width: 420px
   :height: 420px


Histograma y densidad.
~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byrow = F))
    
    for(i in 1:acciones){
        
        hist(rendimientos[,i], breaks = 60, col = "gray", xlab = "Rendimientos", ylab = "Frecuencia", main = nombres[i], freq = F)
        lines(density(rendimientos[,i]), lwd = 3, col = "darkgreen")
    }



.. image:: output_63_0.png
   :width: 420px
   :height: 420px


Histograma, distribución normal y densidad.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byrow = F))
    
    for(i in 1:acciones){
        
        hist(rendimientos[,i], breaks = 60, col = "gray", xlab = "Rendimientos", ylab = "Frecuencia", main = nombres[i], freq = F)
        curve(dnorm(x, mean = rendimientos_esperados[i], sd = volatilidades[i]), add = T, lwd = 3)
        lines(density(rendimientos[,i]), lwd = 3, col = "darkgreen")
        legend("topleft", c("Distribución Normal", "Distribución empírica"), lty = c(1,1), lwd = c(3,3), col = c("black", "darkgreen"), bty = "n")
    }



.. image:: output_65_0.png
   :width: 420px
   :height: 420px


Análisis de normalidad.
~~~~~~~~~~~~~~~~~~~~~~~

Se hace una comparación de cada cuatíl de la distribución empírica con
respecto a la distribución normal. La línea recta es una guía.

Estas gráficas se llaman Q-Q plot.

.. code:: r

    layout(matrix(c(1:4), nrow = 2, byrow = F))
    
    for(i in 1:acciones){
        
        qqnorm(rendimientos[,i], main = nombres[i])
        qqline(rendimientos[,i])
    }



.. image:: output_68_0.png
   :width: 420px
   :height: 420px


Covarianza
~~~~~~~~~~

Es una medida de relación lineal entre dos variables aleatorios
describiendo el movimiento conjunto entre éstas.

.. code:: r

    covarianza = cov(rendimientos)
    covarianza



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>ECO</th><td>0.0010196809</td><td>0.0005939468</td><td>0.0001160327</td><td>0.0001493216</td></tr>
    	<tr><th scope=row>PFAVAL</th><td>0.0005939468</td><td>0.0008155434</td><td>0.0001564360</td><td>0.0001322689</td></tr>
    	<tr><th scope=row>ISA</th><td>0.0001160327</td><td>0.0001564360</td><td>0.0005630751</td><td>0.0001519996</td></tr>
    	<tr><th scope=row>NUTRESA</th><td>0.0001493216</td><td>0.0001322689</td><td>0.0001519996</td><td>0.0001962934</td></tr>
    </tbody>
    </table>
    


Correlación
~~~~~~~~~~~

Mide el grado de movimiento conjunto entre dos variables o la relación
lineal entre ambas en un rango entre -1 y +1.

.. code:: r

    correlacion = cor(rendimientos)
    correlacion



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>ECO</th><td>1.0000000</td><td>0.6513161</td><td>0.1531317</td><td>0.3337626</td></tr>
    	<tr><th scope=row>PFAVAL</th><td>0.6513161</td><td>1.0000000</td><td>0.2308501</td><td>0.3305836</td></tr>
    	<tr><th scope=row>ISA</th><td>0.1531317</td><td>0.2308501</td><td>1.0000000</td><td>0.4572004</td></tr>
    	<tr><th scope=row>NUTRESA</th><td>0.3337626</td><td>0.3305836</td><td>0.4572004</td><td>1.0000000</td></tr>
    </tbody>
    </table>
    

