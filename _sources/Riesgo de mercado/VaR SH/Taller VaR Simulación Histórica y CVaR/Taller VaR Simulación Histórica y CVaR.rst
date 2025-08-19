Taller VaR Simulación Histórica y CVaR
--------------------------------------

Utilizar el archivo Datos primer examen 01-2020.csv para resolver el
taller.

Importar datos
~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Datos primer examen 01-2020.csv", sep = ";", header = T)

.. code:: r

    head(datos)
    tail(datos)



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>ISA</th><th scope=col>NUTRESA</th><th scope=col>PFBCOLOM</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>1</th><td>31/01/2010</td><td>2415</td><td>12280</td><td>19977.2</td><td>20825.2</td></tr>
    	<tr><th scope=row>2</th><td>07/02/2010</td><td>2480</td><td>12540</td><td>20535.4</td><td>21024.5</td></tr>
    	<tr><th scope=row>3</th><td>14/02/2010</td><td>2495</td><td>12740</td><td>20635.1</td><td>21921.3</td></tr>
    	<tr><th scope=row>4</th><td>21/02/2010</td><td>2560</td><td>12880</td><td>20455.6</td><td>22140.5</td></tr>
    	<tr><th scope=row>5</th><td>28/02/2010</td><td>2625</td><td>12700</td><td>20834.5</td><td>21941.2</td></tr>
    	<tr><th scope=row>6</th><td>07/03/2010</td><td>2680</td><td>12600</td><td>20734.8</td><td>21961.1</td></tr>
    </tbody>
    </table>
    



.. raw:: html

    <table>
    <caption>A data.frame: 6 × 5</caption>
    <thead>
    	<tr><th></th><th scope=col>Fecha</th><th scope=col>ECO</th><th scope=col>ISA</th><th scope=col>NUTRESA</th><th scope=col>PFBCOLOM</th></tr>
    	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>517</th><td>22/12/2019</td><td>3340</td><td>19380</td><td>25100</td><td>45800</td></tr>
    	<tr><th scope=row>518</th><td>29/12/2019</td><td>3380</td><td>20300</td><td>25280</td><td>45180</td></tr>
    	<tr><th scope=row>519</th><td>05/01/2020</td><td>3400</td><td>19660</td><td>25140</td><td>44380</td></tr>
    	<tr><th scope=row>520</th><td>12/01/2020</td><td>3385</td><td>19520</td><td>25180</td><td>45880</td></tr>
    	<tr><th scope=row>521</th><td>19/01/2020</td><td>3290</td><td>19380</td><td>25220</td><td>45800</td></tr>
    	<tr><th scope=row>522</th><td>26/01/2020</td><td>3180</td><td>18800</td><td>24760</td><td>44700</td></tr>
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
    <ol class=list-inline><li>'ECO'</li><li>'ISA'</li><li>'NUTRESA'</li><li>'PFBCOLOM'</li></ol>
    


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

    4


Cantidad de rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    numero_rendimientos = nrow(rendimientos)
    numero_rendimientos



.. raw:: html

    521


Portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~

El portafolio de inversión está valorado en mil millones de pesos.

Se tiene invertido la misma proporción en cada acción.

.. code:: r

    proporciones = c(0.25, 0.25, 0.25, 0.25)
    valor_portafolio = 1000000000
    valor_mercado_acciones = proporciones*valor_portafolio
    valor_mercado_acciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>2.5e+08</li><li>2.5e+08</li><li>2.5e+08</li><li>2.5e+08</li></ol>
    


VaR Simulación Histórica y CVaR en términos porcentuales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nivel de confianza del 99% ``NC = 0.99``

Horizonte de tiempo: semanal ``t = 1``. En este método no se puede
escalar el tiempo, es decir, si la frecuencia de los rendimientos es
semanal, el VaR y CVaR quedan semanales. Para otros horizontes de tiempo
se debe utilizar otra base de datos con frecuencia en el tiempo
distinta. Por tanto, no se utiliza en el código ``t = 1``.

.. code:: r

    NC = 0.99

VaR individuales
~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i],1 - NC))
    }
    
    VaR_individuales_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.100017529037464</li><li>0.0747062638979077</li><li>0.0623792449456534</li><li>0.0746798926612424</li></ol>
    


CVaR individuales
~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR = vector()
    
    for(i in 1:acciones){
        
      CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1-NC)))))
    }
    
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.131734096471733</li><li>0.104054311101083</li><li>0.0763919471659559</li><li>0.0898571003585143</li></ol>
    


Rendimientos del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:numero_rendimientos){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
    }

VaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
    VaR_portafolio_SH_percentil



.. raw:: html

    <strong>1%:</strong> 0.0570097464552412


CVaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    CVaR_portafolio = abs(mean(tail(sort(rendimientos_portafolio, decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
    CVaR_portafolio



.. raw:: html

    0.0700265657963683


Preguntas
~~~~~~~~~

1. Con un nivel de confianza del 99%, ¿cuál es el VaR semanal de la acción de ECO?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
    }
    
    VaR_individuales_SH_percentil[1]
    
    VaR_individuales_SH_percentil[1]*valor_mercado_acciones[1]



.. raw:: html

    0.100017529037464



.. raw:: html

    25004382.259366


Respuesta en términos porcentuales: 10,00%

Respuesta en términos monetarios: $25.004.382

2. Con un nivel de confianza del 95%, ¿cuál es el VaR semanal de la acción de ECO?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    
    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
    }
    
    VaR_individuales_SH_percentil[1]
    
    VaR_individuales_SH_percentil[1]*valor_mercado_acciones[1]



.. raw:: html

    0.0636256958802113



.. raw:: html

    15906423.9700528


Respuesta en términos porcentuales: 6,36%

Respuesta en términos monetarios: $15.906.424

3. Con un nivel de confianza del 99%, ¿cuál es el VaR semanal de la acción de Nutresa?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
    }
    
    VaR_individuales_SH_percentil[3]
    
    VaR_individuales_SH_percentil[3]*valor_mercado_acciones[1]



.. raw:: html

    0.0623792449456534



.. raw:: html

    15594811.2364133


Respuesta en términos porcentuales: 6,24%

Respuesta en términos monetarios: $15.594.811

4. Con un nivel de confianza del 95%, ¿cuál es el VaR semanal de la acción de Nutresa?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    
    VaR_individuales_SH_percentil = vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
    }
    
    VaR_individuales_SH_percentil[3]
    
    VaR_individuales_SH_percentil[3]*valor_mercado_acciones[1]



.. raw:: html

    0.0370702585040465



.. raw:: html

    9267564.62601163


Respuesta en términos porcentuales: 3,71%

Respuesta en términos monetarios: $9.267.565

5. Con un nivel de confianza del 99%, ¿cuál es el CVaR semanal de la acción de ISA?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    CVaR = vector()
    
    for(i in 1:acciones){
        
      CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
    }
    
    CVaR[2]
    
    CVaR[2]*valor_mercado_acciones[2]



.. raw:: html

    0.104054311101083



.. raw:: html

    26013577.7752708


Respuesta en términos porcentuales: 10,41%

Respuesta en términos monetarios: $26.013.578

6. Con un nivel de confianza del 95%, ¿cuál es el CVaR semanal de la acción de ISA?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    
    CVaR = vector()
    
    for(i in 1:acciones){
        
      CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
    }
    
    CVaR[2]
    
    CVaR[2]*valor_mercado_acciones[2]



.. raw:: html

    0.0701004864115367



.. raw:: html

    17525121.6028842


Respuesta en términos porcentuales: 7,01%

Respuesta en términos monetarios: $17.525.122

7. Con un nivel de confianza del 99%, ¿cuál es el VaR semanal del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
    VaR_portafolio_SH_percentil
    VaR_portafolio_SH_percentil*valor_portafolio



.. raw:: html

    <strong>1%:</strong> 0.0570097464552412



.. raw:: html

    <strong>1%:</strong> 57009746.4552412


Respuesta en términos porcentuales: 5,70%

Respuesta en términos monetarios: $57.009.746

8. Con un nivel de confianza del 95%, ¿cuál es el VaR semanal del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    
    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
    VaR_portafolio_SH_percentil
    VaR_portafolio_SH_percentil*valor_portafolio



.. raw:: html

    <strong>5%:</strong> 0.0346490917710773



.. raw:: html

    <strong>5%:</strong> 34649091.7710773


Respuesta en términos porcentuales: 3,46%

Respuesta en términos monetarios: $34.649.092

9. Con un nivel de confianza del 99%, ¿cuál es el CVaR semanal del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    CVaR_portafolio = abs(mean(tail(sort(rendimientos_portafolio,decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
    CVaR_portafolio
    CVaR_portafolio*valor_portafolio



.. raw:: html

    0.0700265657963683



.. raw:: html

    70026565.7963683


Respuesta en términos porcentuales: 7,00%

Respuesta en términos monetarios: $70.026.566

10. Con un nivel de confianza del 99%, ¿cuál es el Beneficio por Diversificación semanal del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99
    
    VaR_individuales_SH_percentil=vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
    }
    
    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))*valor_portafolio
    
    BD = sum(VaR_individuales_SH_percentil) - VaR_portafolio_SH_percentil
    BD



.. raw:: html

    <strong>1%:</strong> 20935986.1803257


Respuesta: $20.935.986

11. Con un nivel de confianza del 95%, ¿cuál es el Beneficio por Diversificación semanal del portafolio de inversión?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95
    
    VaR_individuales_SH_percentil=vector()
    
    for(i in 1:acciones){
        
      VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
    }
    
    VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))*valor_portafolio
    
    BD = sum(VaR_individuales_SH_percentil) - VaR_portafolio_SH_percentil
    BD



.. raw:: html

    <strong>5%:</strong> 15479650.510801


Respuesta: $15.479.651
