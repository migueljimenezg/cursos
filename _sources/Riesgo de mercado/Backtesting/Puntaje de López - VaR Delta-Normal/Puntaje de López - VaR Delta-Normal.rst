Puntaje de López - VaR Delta-Normal
-----------------------------------

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

Backtesting método VaR Delta-Normal (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95

Ventana para Backtesting
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    ventana_backtesting = 250
    
    rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
    rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)), i]  
    }
    
    #Para el portafolio de Inversión
    
    rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

Volatilidad histórica y rendimiento medio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_historica = matrix(, ventana_backtesting, ncol(rendimientos))
    
    rendimiento_medio = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        volatilidad_historica[i,j] = sd(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
          
        rendimiento_medio[i,j] = mean(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
     }
    }

VaR Delta-Normal para Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
        
        VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
    }

Excepciones VaR Delta-Normal (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios = vector()
    
    excepciones_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
     excepciones_sin_promedios[i] = sum(ifelse(-VaR_sin_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
     excepciones_con_promedios[i] = sum(ifelse(-VaR_con_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
    }
    
    p.gorro_sin_promedios = excepciones_sin_promedios/ventana_backtesting
    
    p.gorro_con_promedios = excepciones_con_promedios/ventana_backtesting
    
    excepciones_sin_promedios
    
    excepciones_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17</li><li>6</li><li>15</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17</li><li>7</li><li>16</li></ol>
    


Prueba de Kupiec VaR Delta-Normal (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios = (p.gorro_sin_promedios-(1-NC))/sqrt(p.gorro_sin_promedios*(1-p.gorro_sin_promedios)/ventana_backtesting)
    
    tu_con_promedios = (p.gorro_con_promedios-(1-NC))/sqrt(p.gorro_con_promedios*(1-p.gorro_con_promedios)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_sin_promedios = vector()
    
    aprobados_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_sin_promedios[i] = ifelse(abs(tu_sin_promedios[i]) < tu_critico,aprobados_sin_promedios[i] <- 1, aprobados_sin_promedios[i] <- 0)
        
        aprobados_con_promedios[i] = ifelse(abs(tu_con_promedios[i]) < tu_critico,aprobados_con_promedios[i] <- 1, aprobados_con_promedios[i] <- 0)
      }
    
    aprobados_sin_promedios 
    
    aprobados_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Volatilidad y rendimiento medio del portafolio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_historica_portafolio = vector()
    
    rendimiento_medio_portafolio = vector()
    
    for(i in 1:ventana_backtesting){
        
        volatilidad_historica_portafolio[i] = sd(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
        
        rendimiento_medio_portafolio[i] = mean(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
    }

VaR Delta-Normal del portafolio de inversión para Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_sin_promedios = vector()
    
    VaR_portafolio_con_promedios = vector()
    
    for(i in 1:ventana_backtesting){
        
        VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
        
        VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
        
    }

Excepciones VaR Delta-Normal del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting
    
    p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting
    
    excepciones_sin_promedios_portafolio
    
    excepciones_con_promedios_portafolio



.. raw:: html

    8



.. raw:: html

    8


Prueba de Kupiec VaR Delta-Normal del portafolio de inversión (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)
    
    tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
        
    aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)
    
    aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)
    
    aprobados_sin_promedios_portafolio
    
    aprobados_con_promedios_portafolio



.. raw:: html

    1



.. raw:: html

    1


Puntaje de López
~~~~~~~~~~~~~~~~

Compara los métodos del VaR utilizados y escoge el modelo más adecuado.

Utiliza una función de pérdidas (:math:`C_t`) para asignar puntaje a
cada observación dependiendo si la pérdida del día excede el VaR o no.

**Los métodos de VaR con mayor puntaje serán considerados como los de
cobertura más débiles.**

.. figure:: Formula1LopezVaR.jpg
   :alt: 1

   1

:math:`𝐶_𝑡:` Puntaje asignado a la pérdida que excede el VaR.

:math:`𝐿_𝑡:` Valor de la pérdida real del día :math:`t` en valor
absoluto.

:math:`𝑉𝑎𝑅_𝑡:` Valor en Riesgo del día :math:`t`.

.. figure:: Formula2LopezVaR.jpg
   :alt: 2

   2

**El método que minimice esta sumatoria proveerá la mejor cobertura
condicionada.**

Puntaje de López - VaR Delta-Normal (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    lopez_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_sin_promedios[i,j] > rendimientos_backtesting[i,j], lopez_sin_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_sin_promedios[i,j])^2, lopez_sin_promedios[i,j] <- 0)
        
        ifelse(-VaR_con_promedios[i,j] > rendimientos_backtesting[i,j], lopez_con_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_con_promedios[i,j])^2, lopez_con_promedios[i,j] <- 0)
        
        
      }
    }
    
    puntaje_lopez_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_sin_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_sin_promedios)^2, puntaje_lopez_sin_promedios_portafolio <- 0))
    
    puntaje_lopez_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_con_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_con_promedios)^2, puntaje_lopez_con_promedios_portafolio <- 0))
    
    puntaje_lopez_sin_promedios = apply(lopez_sin_promedios, 2, sum)
    
    puntaje_lopez_con_promedios = apply(lopez_con_promedios, 2, sum)
    
    puntaje_lopez_sin_promedios
    
    puntaje_lopez_con_promedios
    
    puntaje_lopez_sin_promedios_portafolio
    
    puntaje_lopez_con_promedios_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17.008975741454</li><li>6.00019579925925</li><li>15.0021205275282</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17.0090693230293</li><li>7.00021210746552</li><li>16.0021880560683</li></ol>
    



.. raw:: html

    8.00069513946404



.. raw:: html

    8.0007217329587


Backtesting método VaR Delta-Normal (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99

VaR Delta-Normal para Backtesting (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
        
        VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
    }

Excepciones VaR Delta-Normal (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios = vector()
    
    excepciones_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
     excepciones_sin_promedios[i] = sum(ifelse(-VaR_sin_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
     excepciones_con_promedios[i] = sum(ifelse(-VaR_con_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
    }
    
    p.gorro_sin_promedios = excepciones_sin_promedios/ventana_backtesting
    
    p.gorro_con_promedios = excepciones_con_promedios/ventana_backtesting
    
    excepciones_sin_promedios
    
    excepciones_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>7</li><li>0</li><li>4</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>7</li><li>1</li><li>4</li></ol>
    


Prueba de Kupiec VaR Delta-Normal (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios = (p.gorro_sin_promedios-(1-NC))/sqrt(p.gorro_sin_promedios*(1-p.gorro_sin_promedios)/ventana_backtesting)
    
    tu_con_promedios = (p.gorro_con_promedios-(1-NC))/sqrt(p.gorro_con_promedios*(1-p.gorro_con_promedios)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_sin_promedios = vector()
    
    aprobados_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_sin_promedios[i] = ifelse(abs(tu_sin_promedios[i]) < tu_critico,aprobados_sin_promedios[i] <- 1, aprobados_sin_promedios[i] <- 0)
        
        aprobados_con_promedios[i] = ifelse(abs(tu_con_promedios[i]) < tu_critico, aprobados_con_promedios[i] <- 1, aprobados_con_promedios[i] <- 0)
      }
    
    aprobados_sin_promedios
    
    aprobados_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>1</li><li>1</li></ol>
    


VaR Delta-Normal para Backtesting del portafolio de inversión (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_sin_promedios = vector()
    VaR_portafolio_con_promedios = vector()
    
    for(i in 1:ventana_backtesting){
        
        VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
        
        VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
        
    }

Excepciones VaR Delta-Normal del portafolio de inversión (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting
    
    p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting
    
    excepciones_sin_promedios_portafolio
    
    excepciones_con_promedios_portafolio



.. raw:: html

    2



.. raw:: html

    2


Prueba de Kupiec VaR Delta-Normal (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)
    
    tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
        
    aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)
    
    aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)
    
    aprobados_sin_promedios_portafolio
    
    aprobados_con_promedios_portafolio



.. raw:: html

    1



.. raw:: html

    1


Puntaje de López - VaR Delta-Normal (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    lopez_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_sin_promedios[i,j] > rendimientos_backtesting[i,j], lopez_sin_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_sin_promedios[i,j])^2, lopez_sin_promedios[i,j] <- 0)
        
        ifelse(-VaR_con_promedios[i,j] > rendimientos_backtesting[i,j], lopez_con_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_con_promedios[i,j])^2, lopez_con_promedios[i,j] <- 0)
        
        
      }
    }
    
    puntaje_lopez_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_sin_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_sin_promedios)^2, puntaje_lopez_sin_promedios_portafolio <- 0))
    
    puntaje_lopez_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_con_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_con_promedios)^2, puntaje_lopez_con_promedios_portafolio <- 0))
    
    puntaje_lopez_sin_promedios = apply(lopez_sin_promedios, 2, sum)
    puntaje_lopez_con_promedios = apply(lopez_con_promedios, 2, sum)
    
    puntaje_lopez_sin_promedios
    
    puntaje_lopez_con_promedios
    
    puntaje_lopez_sin_promedios_portafolio
    
    puntaje_lopez_con_promedios_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>7.00397064315263</li><li>0</li><li>4.00064241285639</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>7.00401163260812</li><li>1.00000000278114</li><li>4.00066428484215</li></ol>
    



.. raw:: html

    2.00014445916113



.. raw:: html

    2.00015154099775


Backtesting método VaR Delta-Normal (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Volatilidad histórica y rendimiento medio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_historica = matrix(, ventana_backtesting, ncol(rendimientos))
    
    rendimiento_medio = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        volatilidad_historica[i,j] = sd(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
          
        rendimiento_medio[i,j] = mean(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
     }
    }

VaR Delta-Normal para Backtesting (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
        
        VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
    }

Excepciones VaR Delta-Normal (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios = vector()
    
    excepciones_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
     excepciones_sin_promedios[i] = sum(ifelse(-VaR_sin_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
     excepciones_con_promedios[i] = sum(ifelse(-VaR_con_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
    }
    
    p.gorro_sin_promedios = excepciones_sin_promedios/ventana_backtesting
    
    p.gorro_con_promedios = excepciones_con_promedios/ventana_backtesting
    
    excepciones_sin_promedios
    
    excepciones_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>12</li><li>2</li><li>6</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>12</li><li>3</li><li>6</li></ol>
    


Prueba de Kupiec VaR Delta-Normal (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios = (p.gorro_sin_promedios-(1-NC))/sqrt(p.gorro_sin_promedios*(1-p.gorro_sin_promedios)/ventana_backtesting)
    
    tu_con_promedios = (p.gorro_con_promedios-(1-NC))/sqrt(p.gorro_con_promedios*(1-p.gorro_con_promedios)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_sin_promedios = vector()
    
    aprobados_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_sin_promedios[i] = ifelse(abs(tu_sin_promedios[i]) < tu_critico,aprobados_sin_promedios[i] <- 1, aprobados_sin_promedios[i] <- 0)
        
        aprobados_con_promedios[i] = ifelse(abs(tu_con_promedios[i]) < tu_critico,aprobados_con_promedios[i] <- 1, aprobados_con_promedios[i] <- 0)
      }
    
    aprobados_sin_promedios 
    
    aprobados_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>1</li><li>1</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>1</li><li>1</li></ol>
    


Volatilidad y rendimiento medio del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_historica_portafolio = vector()
    
    rendimiento_medio_portafolio = vector()
    
    for(i in 1:ventana_backtesting){
        
        volatilidad_historica_portafolio[i] = sd(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
        
        rendimiento_medio_portafolio[i] = mean(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
    }

VaR Delta-Normal para Backtesting del portafolio de inversión (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_sin_promedios = vector()
    
    VaR_portafolio_con_promedios = vector()
    
    for(i in 1:ventana_backtesting){
        
        VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
        
        VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
        
    }

Excepciones VaR Delta-Normal del portafolio de inversión (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting
    
    p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting
    
    excepciones_sin_promedios_portafolio
    
    excepciones_con_promedios_portafolio



.. raw:: html

    5



.. raw:: html

    5


Prueba de Kupiec VaR Delta-Normal (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)
    
    tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
        
    aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)
    
    aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1,aprobados_con_promedios_portafolio <- 0)
    
    aprobados_sin_promedios_portafolio
    
    aprobados_con_promedios_portafolio



.. raw:: html

    1



.. raw:: html

    1


Puntaje de López - VaR Delta-Normal (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    lopez_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_sin_promedios[i,j] > rendimientos_backtesting[i,j], lopez_sin_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_sin_promedios[i,j])^2, lopez_sin_promedios[i,j] <- 0)
        
        ifelse(-VaR_con_promedios[i,j] > rendimientos_backtesting[i,j], lopez_con_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_con_promedios[i,j])^2, lopez_con_promedios[i,j] <- 0)
        
        
      }
    }
    
    puntaje_lopez_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_sin_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_sin_promedios)^2, puntaje_lopez_sin_promedios_portafolio <- 0))
    
    puntaje_lopez_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_con_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_con_promedios)^2, puntaje_lopez_con_promedios_portafolio <- 0))
    
    puntaje_lopez_sin_promedios = apply(lopez_sin_promedios, 2, sum)
    puntaje_lopez_con_promedios = apply(lopez_con_promedios, 2, sum)
    
    puntaje_lopez_sin_promedios
    
    puntaje_lopez_con_promedios
    
    puntaje_lopez_sin_promedios_portafolio
    
    puntaje_lopez_con_promedios_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>12.0048175999161</li><li>2.00116655363073</li><li>6.00073327511721</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>12.0048672309775</li><li>3.00118419466552</li><li>6.0007622227941</li></ol>
    



.. raw:: html

    5.00028956100564



.. raw:: html

    5.00030436976491


Backtesting método VaR Delta-Normal (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95

VaR Delta-Normal para Backtesting (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
        
        VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
    }

Excepciones VaR Delta-Normal (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios = vector()
    
    excepciones_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
     excepciones_sin_promedios[i] = sum(ifelse(-VaR_sin_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
     excepciones_con_promedios[i] = sum(ifelse(-VaR_con_promedios[,i] > rendimientos_backtesting[,i], 1, 0)) 
        
    }
    
    p.gorro_sin_promedios = excepciones_sin_promedios/ventana_backtesting
    
    p.gorro_con_promedios = excepciones_con_promedios/ventana_backtesting
    
    excepciones_sin_promedios
    
    excepciones_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>28</li><li>12</li><li>22</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>28</li><li>13</li><li>23</li></ol>
    


Prueba de Kupiec VaR Delta-Normal (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios = (p.gorro_sin_promedios-(1-NC))/sqrt(p.gorro_sin_promedios*(1-p.gorro_sin_promedios)/ventana_backtesting)
    
    tu_con_promedios = (p.gorro_con_promedios-(1-NC))/sqrt(p.gorro_con_promedios*(1-p.gorro_con_promedios)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_sin_promedios = vector()
    
    aprobados_con_promedios = vector()
    
    for(i in 1:ncol(rendimientos)){
        
        aprobados_sin_promedios[i] = ifelse(abs(tu_sin_promedios[i]) < tu_critico, aprobados_sin_promedios[i] <- 1, aprobados_sin_promedios[i] <- 0)
        
        aprobados_con_promedios[i] = ifelse(abs(tu_con_promedios[i]) < tu_critico, aprobados_con_promedios[i] <- 1, aprobados_con_promedios[i] <- 0)
      }
    
    aprobados_sin_promedios 
    
    aprobados_con_promedios



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


VaR Delta-Normal para Backtesting del portafolio de inversión (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_sin_promedios = vector()
    
    VaR_portafolio_con_promedios = vector()
    
    for(i in 1:ventana_backtesting){
        
        VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
        
        VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
        
    }

Excepciones VaR Delta-Normal del portafolio de inversión (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))
    
    p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting
    
    p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting
    
    excepciones_sin_promedios_portafolio
    
    excepciones_con_promedios_portafolio



.. raw:: html

    15



.. raw:: html

    15


Prueba de Kupiec VaR Delta-Normal (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)
    
    tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
        
    aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico ,aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)
    
    aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)
    
    aprobados_sin_promedios_portafolio
    
    aprobados_con_promedios_portafolio



.. raw:: html

    0



.. raw:: html

    0


Puntaje de López - VaR Delta-Normal (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    lopez_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_sin_promedios[i,j] > rendimientos_backtesting[i,j], lopez_sin_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_sin_promedios[i,j])^2, lopez_sin_promedios[i,j] <- 0)
        
        ifelse(-VaR_con_promedios[i,j] > rendimientos_backtesting[i,j], lopez_con_promedios[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_con_promedios[i,j])^2, lopez_con_promedios[i,j] <- 0)
        
        
      }
    }
    
    puntaje_lopez_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_sin_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_sin_promedios)^2, puntaje_lopez_sin_promedios_portafolio <- 0))
    
    puntaje_lopez_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, puntaje_lopez_con_promedios_portafolio <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_con_promedios)^2, puntaje_lopez_con_promedios_portafolio <- 0))
    
    puntaje_lopez_sin_promedios = apply(lopez_sin_promedios, 2, sum)
    
    puntaje_lopez_con_promedios = apply(lopez_con_promedios, 2, sum)
    
    puntaje_lopez_sin_promedios
    
    puntaje_lopez_con_promedios
    
    puntaje_lopez_sin_promedios_portafolio
    
    puntaje_lopez_con_promedios_portafolio



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>28.0121628743772</li><li>12.0024838071261</li><li>22.0028070302842</li></ol>
    



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>28.0122864992852</li><li>13.0025357660379</li><li>23.0029038116054</li></ol>
    



.. raw:: html

    15.0014394129394



.. raw:: html

    15.0014909723498


Conclusión general:
~~~~~~~~~~~~~~~~~~~

+---------------+----------+---------------+----------+---------------+
|               | **ECO**  | **PFBCOLOMB** | **ISA**  | *             |
|               |          |               |          | *Portafolio** |
+===============+==========+===============+==========+===============+
| VaR sin       | Aceptado | Rechazado     | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 95% y H =   |          |               |          |               |
| 250           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR con       | Aceptado | Rechazado     | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 95% y H =   |          |               |          |               |
| 250           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR sin       | Aceptado | Rechazado     | Aceptado | Rechazado     |
| promedios, NC |          |               |          |               |
| = 95% y H =   |          |               |          |               |
| 500           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR con       | Aceptado | Rechazado     | Aceptado | Rechazado     |
| promedios, NC |          |               |          |               |
| = 95% y H =   |          |               |          |               |
| 500           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR sin       | Aceptado | Rechazado     | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 99% y H =   |          |               |          |               |
| 250           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR con       | Aceptado | Aceptado      | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 99% y H =   |          |               |          |               |
| 250           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR sin       | Aceptado | Aceptado      | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 99% y H =   |          |               |          |               |
| 500           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+
| VaR con       | Aceptado | Aceptado      | Aceptado | Aceptado      |
| promedios, NC |          |               |          |               |
| = 99% y H =   |          |               |          |               |
| 500           |          |               |          |               |
+---------------+----------+---------------+----------+---------------+

Puntaje de López
----------------

+------------+----------------+------------+------------+------------+
|            | **ECO**        | **P        | **ISA**    | **Po       |
|            |                | FBCOLOMB** |            | rtafolio** |
+============+================+============+============+============+
| VaR sin    | 1              | 6,0001     | 15,002     | 8,0006     |
| promedios, | 7,008975741454 | 9579925925 | 1205275282 | 9513946404 |
| NC = 95% y |                |            |            |            |
| H = 250    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR con    | 17             | 7,0002     | 16,002     | 8,000      |
| promedios, | ,0090693230293 | 1210746552 | 1880560683 | 7217329587 |
| NC = 95% y |                |            |            |            |
| H = 250    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR sin    | 12             | 2,001      | 6,0007     | 5,0002     |
| promedios, | ,0048175999161 | 1665536307 | 3327511721 | 8956100564 |
| NC = 95% y |                |            |            |            |
| H = 500    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR con    | 12             | 3,0011     | 6,000      | 5,0003     |
| promedios, | ,0048672309775 | 8419466552 | 7622227941 | 0436976491 |
| NC = 95% y |                |            |            |            |
| H = 500    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR sin    | 7,             | 0          | 4,0006     | 2,0001     |
| promedios, | 00397064315263 |            | 4241285639 | 4445916113 |
| NC = 99% y |                |            |            |            |
| H = 250    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR con    | 7,             | 1,0000     | 4,0006     | 2,0001     |
| promedios, | 00401163260812 | 0000278114 | 6428484215 | 5154099775 |
| NC = 99% y |                |            |            |            |
| H = 250    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR sin    | 12             | 2,0011     | 6,0007     | 5,0002     |
| promedios, | ,0048175999161 | 6655363073 | 3327511721 | 8956100564 |
| NC = 99% y |                |            |            |            |
| H = 500    |                |            |            |            |
+------------+----------------+------------+------------+------------+
| VaR con    | 12             | 3,0011     | 6,000      | 5,0003     |
| promedios, | ,0048672309775 | 8419466552 | 7622227941 | 0436976491 |
| NC = 99% y |                |            |            |            |
| H = 500    |                |            |            |            |
+------------+----------------+------------+------------+------------+
