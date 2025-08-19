Puntaje de López - VaR Simulación Histórica
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

Horizonte de tiempo de un día
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    t = 1

Backtesting método VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95

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

VaR Simulación Histórica para Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
        
     }
    }

Excepciones VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>20</li><li>10</li><li>17</li></ol>
    


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
    


VaR Simulación Histórica para Backtesting del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil_portafolio = vector()
    
      for(i in 1:ventana_backtesting){
        
        VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
    }

Excepciones VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting
    
    excepciones_SH_percentil_portafolio



.. raw:: html

    11


Prueba de Kupiec VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Histórica (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SH_percentil  =matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
           
        ifelse(-VaR_SH_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SH_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_SH_percentil[i,j])^2, lopez_SH_percentil[i,j] <- 0)  
      
      }
    }
    
    puntaje_lopez_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, puntaje_lopez_SH_percentil_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_SH_percentil_portafolio)^2, puntaje_lopez_SH_percentil_portafolio <- 0))
    
    puntaje_lopez_SH_percentil = apply(lopez_SH_percentil, 2, sum)
    
    puntaje_lopez_SH_percentil
    
    puntaje_lopez_SH_percentil_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>20.0100793900687</li><li>10.0003133762384</li><li>17.0023570764449</li></ol>
    



.. raw:: html

    11.0009070565652


Backtesting método VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99

VaR Simulación Histórica para Backtesting (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
            VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
        
     }
    }

Excepciones VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SH_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
    excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i]>rendimientos_backtesting[,i], 1, 0))
    
    }
    
    p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting
    
    excepciones_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>4</li><li>0</li><li>2</li></ol>
    


Prueba de Kupiec VaR Simulación Histórica (NC = 99% y H = 250)
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


Puntaje de López - VaR Simulación Histórica (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
           
        ifelse(-VaR_SH_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SH_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_SH_percentil[i,j])^2, lopez_SH_percentil[i,j] <- 0)  
      
      }
    }
    
    puntaje_lopez_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, puntaje_lopez_SH_percentil_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_SH_percentil_portafolio)^2, puntaje_lopez_SH_percentil_portafolio <- 0))
    
    puntaje_lopez_SH_percentil = apply(lopez_SH_percentil, 2, sum)
    
    puntaje_lopez_SH_percentil
    
    puntaje_lopez_SH_percentil_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>4.00179684593861</li><li>0</li><li>2.00024053446162</li></ol>
    



.. raw:: html

    2.00003436732289


Backtesting método VaR Simulación Histórica (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>5</li><li>1</li><li>3</li></ol>
    


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
    


VaR Simulación Histórica para Backtesting del portafolio de inversión (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



.. raw:: html

    4


Prueba de Kupiec VaR Simulación Histórica del portafolio de inversión (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Histórica (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
           
        ifelse(-VaR_SH_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SH_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_SH_percentil[i,j])^2, lopez_SH_percentil[i,j] <- 0)  
      
      }
    }
    
    puntaje_lopez_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, puntaje_lopez_SH_percentil_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_SH_percentil_portafolio)^2, puntaje_lopez_SH_percentil_portafolio <- 0))
    
    puntaje_lopez_SH_percentil = apply(lopez_SH_percentil, 2, sum)
    
    puntaje_lopez_SH_percentil
    
    puntaje_lopez_SH_percentil_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>5.00208130721835</li><li>1.00083998242338</li><li>3.0002405500786</li></ol>
    



.. raw:: html

    4.00007239002439


Backtesting método VaR Simulación Histórica (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95

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



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>32</li><li>17</li><li>25</li></ol>
    


Prueba de Kupiec VaR Simulación Histórica (NC = 95% y H = 500)
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
    


VaR Simulación Histórica para Backtesting del portafolio de inversión (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



.. raw:: html

    19


Prueba de Kupiec VaR Simulación Histórica del portafolio de inversión (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)
    
    aprobados_SH_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Histórica (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
           
        ifelse(-VaR_SH_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SH_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_SH_percentil[i,j])^2, lopez_SH_percentil[i,j] <- 0)  
      
      }
    }
    
    puntaje_lopez_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, puntaje_lopez_SH_percentil_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_SH_percentil_portafolio)^2, puntaje_lopez_SH_percentil_portafolio <- 0))
    
    puntaje_lopez_SH_percentil = apply(lopez_SH_percentil, 2, sum)
    
    puntaje_lopez_SH_percentil
    
    puntaje_lopez_SH_percentil_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>32.0139471948101</li><li>17.0028680508645</li><li>25.0031545412919</li></ol>
    



.. raw:: html

    19.0018755053324


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

Puntaje de López
~~~~~~~~~~~~~~~~

+------------+----------------+------------+------------+------------+
|            | **ECO**        | **P        | **ISA**    | **Po       |
|            |                | FBCOLOMB** |            | rtafolio** |
+============+================+============+============+============+
| NC = 95% y | 20             | 10,000     | 17,002     | 11,000     |
| H = 250    | ,0100793900687 | 3133762384 | 3570764449 | 9070565652 |
+------------+----------------+------------+------------+------------+
| NC = 95% y | 32             | 17,002     | 25,003     | 19,001     |
| H = 500    | ,0139471948101 | 8680508645 | 1545412919 | 8755053324 |
+------------+----------------+------------+------------+------------+
| NC = 99% y | 4,             | 0          | 2,0002     | 2,0000     |
| H = 250    | 00179684593861 |            | 4053446162 | 3436732289 |
+------------+----------------+------------+------------+------------+
| NC = 99% y | 5,             | 1,0008     | 3,000      | 4,0000     |
| H = 500    | 00208130721835 | 3998242338 | 2405500786 | 7239002439 |
+------------+----------------+------------+------------+------------+
