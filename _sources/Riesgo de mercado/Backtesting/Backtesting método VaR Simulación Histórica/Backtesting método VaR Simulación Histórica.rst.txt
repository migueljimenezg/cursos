Backtesting método VaR Simulación Histórica
-------------------------------------------

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Tres acciones.csv", sep = ";")

Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]

Proporciones de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.25,0.5,0.25)

Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = matrix(, nrow(precios)-1, ncol(precios))
    
    for(i in 1:ncol(precios)){
        
      rendimientos[,i] = diff(log(precios[,i]))
    }

Rendimientos portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
    }

Ventana para Backtesting
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ventana_backtesting = 250
    
    rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
    rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)),i]  
        
    }
    
    #Para el portafolio de Inversión
    
    rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

Horizonte de tiempo de un día
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    t = 1

Backtesting método VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se realizará el Backtesting con una ventana de 250 y nivel de confianza
del 95%.

.. code:: r

    NC = 0.95

VaR Simulación Histórica para Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En este método solo se debe calcular el VaR para cada uno de los 250
rendimientos más recientes.

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
        
     }
    }

.. code:: r

    plot(rendimientos_backtesting[,1], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "ECO")
    lines(-VaR_SH_percentil[,1], t = "l", col = "darkred")
    legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")



.. image:: output_21_0.png
   :width: 420px
   :height: 420px


.. code:: r

    plot(rendimientos_backtesting[,2], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "PFBCOLOM")
    lines(-VaR_SH_percentil[,2], t = "l", col = "darkred")
    legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")



.. image:: output_22_0.png
   :width: 420px
   :height: 420px


.. code:: r

    plot(rendimientos_backtesting[,3], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "ISA")
    lines(-VaR_SH_percentil[,3], t = "l", col = "darkred")
    legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")



.. image:: output_23_0.png
   :width: 420px
   :height: 420px


Excepciones VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil
    
    p.gorro_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>20</li><li>10</li><li>17</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.08</li><li>0.04</li><li>0.068</li></ol>
    


En el método VaR Simulación Histórica se hallaron 20 exepciones en la
acción de ECO, 10 en PFBCOLOM y 17 en ISA. Que corresponde a un 8%, 4% y
6,8%, respectivamente.

Prueba de Kupiec VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil=vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
    }
    
    aprobados_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>1</li><li>1</li></ol>
    


Con con una ventana de 250 y nivel de confianza del 95% el método de VaR
Simulación Histórica se acepta para las tres acciones.

VaR Simulación Histórica para Backtesting del portafolio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil_portafolio = vector()
    
      for(i in 1:ventana_backtesting){
        
        VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
    }

.. code:: r

    plot(rendimientos_backtesting_portafolio, t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "Portafolio de inversión")
    lines(-VaR_SH_percentil_portafolio, t = "l", col = "darkred")
    legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")



.. image:: output_32_0.png
   :width: 420px
   :height: 420px


Excepciones VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting
    
    excepciones_SH_percentil_portafolio
    
    p.gorro_SH_percentil_portafolio



.. raw:: html

    11



.. raw:: html

    0.044


Prueba de Kupiec VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Conclusión:
~~~~~~~~~~~

**Con con una ventana de 250 y nivel de confianza del 95%, el método de
VaR Simulación Histórica es aceptado para las tres acciones y el
portafolio de inversión.**

Backtesting método VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Igualmente, se realizará el Backtesting con una ventana de 250 y 99% de
nivel de confianza.

.. code:: r

    NC = 0.99

VaR Simulación Histórica para Backtesting (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j], 1-NC))
        
     }
    }

Excepciones VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil
    
    p.gorro_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>4</li><li>0</li><li>2</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.016</li><li>0</li><li>0.008</li></ol>
    


En el método VaR Simulación Histórica se hallaron 4 exepciones en la
acción de ECO, 0 en PFBCOLOM y 2 en ISA. Que corresponde a un 1,6%, 0% y
0,8%, respectivamente.

Prueba de Kupiec VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
    }
    
    aprobados_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Con con una ventana de 250 y nivel de confianza del 95% el método de VaR
Simulación Histórica se acepta para las acciones ECO e ISA y se rechaza
para PFBCOLOM

VaR Simulación Histórica para Backtesting del portafolio de inversión (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil_portafolio = vector()
    
      for(i in 1:ventana_backtesting){
        
        VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
    }

Excepciones VaR Simulación Histórica del portafolio de inversión (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting
    
    excepciones_SH_percentil_portafolio
    
    p.gorro_SH_percentil_portafolio



.. raw:: html

    2



.. raw:: html

    0.008


Prueba de Kupiec VaR Simulación Histórica del portafolio de inversión (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Conclusión:
~~~~~~~~~~~

**Con con una ventana de 250 y nivel de confianza del 99%, el método de
VaR Simulación Histórica es aceptado para las acciones ECO e ISA y el
portafolio de inversión, pero es rechazado para PFBCOLOM.**

Backtesting método VaR Simulación Histórica (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se realizará el Backtesting con una ventana de 500 y nivel de confianza
del 99%.

.. code:: r

    NC = 0.99

Ventana para Backtesting
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ventana_backtesting = 500
    
    rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
    rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)), i]  
    }
    
    #Para el portafolio de Inversión
    
    rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

VaR Simulación Histórica para Backtesting (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
        
     }
    }

Excepciones VaR Simulación Histórica (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil
    
    p.gorro_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>5</li><li>1</li><li>3</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.01</li><li>0.002</li><li>0.006</li></ol>
    


En el método VaR Simulación Histórica se hallaron 5 exepciones en la
acción de ECO, 1 en PFBCOLOM y 3 en ISA. Que corresponde a un 1%, 0,2% y
0,6%, respectivamente.

Prueba de Kupiec VaR Simulación Histórica (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico, aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
    }
    
    aprobados_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Con con una ventana de 250 y nivel de confianza del 95% el método de VaR
Simulación Histórica se acepta para las acciones ECO e ISA y se rechaza
para PFBCOLOM

VaR Simulación Histórica para Backtesting del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil_portafolio = vector()
    
      for(i in 1:ventana_backtesting){
        
        VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
    }

Excepciones VaR Simulación Histórica del portafolio de inversión (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting
    
    excepciones_SH_percentil_portafolio
    
    p.gorro_SH_percentil_portafolio



.. raw:: html

    4



.. raw:: html

    0.008


Prueba de Kupiec VaR Simulación Histórica del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Conclusión:
~~~~~~~~~~~

**Con con una ventana de 500 y nivel de confianza del 99%, el método de
VaR Simulación Histórica es aceptado para las acciones ECO e ISA y el
portafolio de inversión, pero es rechazado para PFBCOLOM.**

Backtesting método VaR Simulación Histórica (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se realizará el Backtesting con una ventana de 500 y nivel de confianza
del 95%.

.. code:: r

    NC=0.95

VaR Simulación Histórica para Backtesting (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
        
     }
    }

Excepciones VaR Simulación Histórica (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil
    
    p.gorro_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>32</li><li>17</li><li>25</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.064</li><li>0.034</li><li>0.05</li></ol>
    


En el método VaR Simulación Histórica se hallaron 32 exepciones en la
acción de ECO, 17 en PFBCOLOM y 25 en ISA. Que corresponde a un 6,4%,
3,4% y 5%, respectivamente.

Prueba de Kupiec VaR Simulación Histórica (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
    }
    
    aprobados_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Con con una ventana de 500 y nivel de confianza del 95% el método de VaR
Simulación Histórica se acepta para las acciones ECO e ISA y se rechaza
para PFBCOLOM

VaR Simulación Histórica para Backtesting del portafolio (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil_portafolio = vector()
    
      for(i in 1:ventana_backtesting){
        
        VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
    }

Excepciones VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting
    
    excepciones_SH_percentil_portafolio
    
    p.gorro_SH_percentil_portafolio



.. raw:: html

    19



.. raw:: html

    0.038


Prueba de Kupiec VaR Simulación Histórica del portafolio (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2,ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Conclusión:
~~~~~~~~~~~

**Con con una ventana de 500 y nivel de confianza del 95%, el método de
VaR Simulación Histórica es aceptado para las acciones ECO e ISA y el
portafolio de inversión, pero es rechazado para PFBCOLOM.**

Conclusión general:
~~~~~~~~~~~~~~~~~~~

================== ======== ============= ======== ==============
\                  **ECO**  **PFBCOLOMB** **ISA**  **Portafolio**
================== ======== ============= ======== ==============
NC = 95% y H = 250 Aceptado Aceptado      Aceptado Aceptado
NC = 95% y H = 500 Aceptado Rechazado     Aceptado Aceptado
NC = 99% y H = 250 Aceptado Rechazado     Aceptado Aceptado
NC = 99% y H = 500 Aceptado Rechazado     Aceptado Aceptado
================== ======== ============= ======== ==============
