VaR Simulación Histórica - Método no paramétrico
------------------------------------------------

No asume que las rentabilidades siguen una distribución normal por lo
que es posible reflejar la distribución de rentabilidades.

En vez de utilizar la información histórica para calcular volatilidades
y covarianzas de los activos, con este método se utilizan las pérdidas y
ganancias que se habría experimentado durante un período de tiempo
determinado.

Se analiza cuáles habrían sido las rentabilidades hipotéticas en el
pasado si se hubiera tenido el activo o el portafolio actual. Con las
pérdidas experimentadas en el pasado se puede concluir sobre el riesgo
esperado a partir de este momento.

Con las pérdidas y ganancias hipotéticas para cada día del período de
observación, se genera la distribución esperada (distribución empírica)
y se toman los percentiles de la distribución de rentabilidades como
medida directa del VaR. **Esta distribución no se basa en la hipótesis
de normalidad.**

Lo ocurrido en el período de la muestra de rentabilidades observadas
recoge toda la información suficiente para estimar el riesgo futuro.

**Recomendación: mínimo datos de un año.**

Se parte del supuesto de que en el futuro los mercados se comportarán de
forma parecida al pasado.

Se puede considerar período de inestabilidad en los mercados.

Los resultados del análisis pueden variar considerablemente dependiendo
de la elección de la longitud de la muestra y la frecuencia de
observaciones utilizadas.

**No es posible extrapolar los resultados del análisis a otros
horizontes temporales. Es necesario volver a calcular los percentiles de
la distribución de rentabilidades y llevar a cabo el análisis de nuevo
para diferentes plazos.**

Importar datos
~~~~~~~~~~~~~~

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
    


Matriz de precios
~~~~~~~~~~~~~~~~~

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
    


Matriz de rendimientos
~~~~~~~~~~~~~~~~~~~~~~

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


VaR simulación historica
~~~~~~~~~~~~~~~~~~~~~~~~

VaR diario con un nivel de confianza del 95% ``NC = 0.95`` ####
Proporciones de inversión. ``proporciones=c(0.25, 0.4, 0.35)``

ECO: 25%

PFBCOLOM: 40%

ISA: 35%

.. code:: r

    NC = 0.95
    proporciones = c(0.25, 0.4, 0.35)
    valor_portafolio = 100000000
    valor_mercado_acciones = proporciones*valor_portafolio

Con un nivel de confianza del 95%, se debe esoger el rendimiento que se
encuentra en el 5% de los rendimientos más bajos.

Se usa la función ``quantile()`` para hallar el percentil del 95%.

.. code:: r

    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
    }
    
    VaR_individuales_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>725237.852255347</li><li>979379.265539478</li><li>862800.178664044</li></ol>
    


Rendimientos del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:numero_rendimientos){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
    }

VaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC)*valor_portafolio)
    VaR_portafolio_SH_percentil



.. raw:: html

    <strong>5%:</strong> 1892558.8139104

