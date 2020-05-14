Puntaje de López - VaR Simulación Monte Carlo
---------------------------------------------

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

Backtesting método VaR Simulación Monte Carlo (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Rendimientos simulados de cada acción para ventana Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    iteraciones = 50000
    
    dt = 1
    
    
    st = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        st[,i] = tail(precios[,i], ventana_backtesting)
    }
    
    
    
    rend_backtesting = array(dim = c(ventana_backtesting, iteraciones, ncol(rendimientos)))
    
    aleatorio_corr = vector()
    
    for(k in 1:ncol(rendimientos)){
        
        for(i in 1:ventana_backtesting){
            
            correlacion = cor(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),])
            
            cholesky = chol(correlacion)
                                 
        for(j in 1:iteraciones){
            
            aleatorio = rnorm(ncol(rendimientos))
            
            aleatorio_corr = colSums(aleatorio*cholesky)
                   
            rend_backtesting[i,j,k] = st[i,k]*exp((rendimiento_medio[i,k]-volatilidad_historica[i,k]^2/2)*dt+volatilidad_historica[k]*sqrt(dt)*aleatorio_corr[k])/st[i,k]-1
               
    }}}

VaR Simulación Monte Carlo para Backtesting (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
      }
    }

Excepciones VaR Simulación Monte Carlo (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil = vector()
    
    for(j in 1:ncol(rendimientos)){
        
      excepciones_SM_percentil[j] = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
    }}
    
    p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting
    
    excepciones_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17</li><li>4</li><li>9</li></ol>
    


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SM_percentil=vector()
    
    for(i in 1:ncol(rendimientos)){
        
      aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico, aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)
    
    }
    
    aprobados_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Rendimientos mensuales simulados para Backtesting del portafolio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend_port_backtesting = matrix(, ventana_backtesting, iteraciones)
    
    for(j in 1:iteraciones){
        
        for(i in 1:ventana_backtesting){
        
        rend_port_backtesting[i,j] = sum(rend_backtesting[i,j,]*proporciones)
            
    }}

VaR Simulación Monte Carlo para Backtesting del portafolio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = vector()
        
      for(i in 1:ventana_backtesting){
          
        VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
    }

Excepciones VaR Simulación Monte Carlo del portafolio (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil_portafolio = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
    }
    
    p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting
    
    excepciones_SM_percentil_portafolio



.. raw:: html

    11


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
       
    aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <-1 , aprobados_SM_percentil_portafolio <- 0)
    
    aprobados_SM_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Monte Carlo (NC = 95% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SM_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_individuales_SM_percentil[i,j])^2, lopez_SM_percentil[i,j] <- 0)
      
      }
    }
    
    puntaje_lopez_SM_percentil = apply(lopez_SM_percentil, 2, sum)
     
    puntaje_lopez_portafolio_SM_percentil = sum(ifelse(-VaR_portafolio_SM_percentil>rendimientos_backtesting_portafolio, lopez_portafolio_SM_percentil <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_SM_percentil)^2, lopez_portafolio_SM_percentil <- 0))
    
    puntaje_lopez_SM_percentil
    
    puntaje_lopez_portafolio_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>17.0094021536635</li><li>4.00006174559227</li><li>9.00136136877022</li></ol>
    



.. raw:: html

    11.0010630307369


Backtesting método VaR Simulación Monte Carlo (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.99

VaR Simulación Monte Carlo para Backtesting (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
      }
    }

Excepciones VaR Simulación Monte Carlo (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil = vector()
    
    for(j in 1:ncol(rendimientos)){
        
      excepciones_SM_percentil[j] = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
    }}
    
    p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting
    
    excepciones_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>8</li><li>0</li><li>2</li></ol>
    


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico, aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)
    
    }
    
    aprobados_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


VaR Simulación Monte Carlo para Backtesting del portafolio (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = vector()
        
      for(i in 1:ventana_backtesting){
          
        VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
    }

Excepciones VaR Simulación Monte Carlo del portafolio (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil_portafolio = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
    }
    
    p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting
    
    excepciones_SM_percentil_portafolio
    
    p.gorro_SM_percentil_portafolio



.. raw:: html

    5



.. raw:: html

    0.02


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
       
    aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)
    
    aprobados_SM_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Monte Carlo (NC = 99% y H = 250)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SM_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_individuales_SM_percentil[i,j])^2, lopez_SM_percentil[i,j] <- 0)
      
      }
    }
    
    puntaje_lopez_SM_percentil = apply(lopez_SM_percentil, 2, sum)
     
    puntaje_lopez_portafolio_SM_percentil = sum(ifelse(-VaR_portafolio_SM_percentil > rendimientos_backtesting_portafolio, lopez_portafolio_SM_percentil <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_SM_percentil)^2, lopez_portafolio_SM_percentil <- 0))
    
    puntaje_lopez_SM_percentil
    
    puntaje_lopez_portafolio_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>8.00434793976893</li><li>0</li><li>2.00031955919326</li></ol>
    



.. raw:: html

    5.00029792823143


Backtesting método VaR Simulación Monte Carlo (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Rendimientos simulados de cada acción para ventana Backtesting (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    iteraciones = 50000
    
    dt = 1
    
    
    st = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(i in 1:ncol(rendimientos)){
        
        st[,i] = tail(precios[,i], ventana_backtesting)
    }
    
    
    rend_backtesting = array(dim = c(ventana_backtesting, iteraciones, ncol(rendimientos)))
    
    aleatorio_corr = vector()
    
    for(k in 1:ncol(rendimientos)){
        
        for(i in 1:ventana_backtesting){
            
            correlacion = cor(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),])
            
            cholesky = chol(correlacion)
                                 
        for(j in 1:iteraciones){
            
            aleatorio = rnorm(ncol(rendimientos))
            
            aleatorio_corr = colSums(aleatorio*cholesky)
                   
            rend_backtesting[i,j,k] = st[i,k]*exp((rendimiento_medio[i,k]-volatilidad_historica[i,k]^2/2)*dt+volatilidad_historica[k]*sqrt(dt)*aleatorio_corr[k])/st[i,k]-1
               
    }}}

VaR Simulación Monte Carlo para Backtesting (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
      }
    }

Excepciones VaR Simulación Monte Carlo (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil = vector()
    
    for(j in 1:ncol(rendimientos)){
        
      excepciones_SM_percentil[j] = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
    }}
    
    p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting
    
    excepciones_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>13</li><li>1</li><li>3</li></ol>
    


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico,aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)
    }
    
    aprobados_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>1</li></ol>
    


Rendimientos mensuales simulados para Backtesting del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rend_port_backtesting = matrix(, ventana_backtesting, iteraciones)
    
    for(j in 1:iteraciones){
        
        for(i in 1:ventana_backtesting){
        
        rend_port_backtesting[i,j] = sum(rend_backtesting[i,j,]*proporciones)
    }}

VaR Simulación Monte Carlo para Backtesting del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = vector()
        
      for(i in 1:ventana_backtesting){
          
        VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
    }

Excepciones VaR Simulación Monte Carlo del portafolio (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil_portafolio = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
    }
    
    p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting
    
    excepciones_SM_percentil_portafolio
    
    p.gorro_SM_percentil_portafolio



.. raw:: html

    10



.. raw:: html

    0.02


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
       
    aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)
    
    aprobados_SM_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Monte Carlo (NC = 99% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SM_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_individuales_SM_percentil[i,j])^2, lopez_SM_percentil[i,j] <- 0)
      
      }
    }
    
    puntaje_lopez_SM_percentil = apply(lopez_SM_percentil, 2, sum)
     
    puntaje_lopez_portafolio_SM_percentil = sum(ifelse(-VaR_portafolio_SM_percentil > rendimientos_backtesting_portafolio, lopez_portafolio_SM_percentil <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_SM_percentil)^2, lopez_portafolio_SM_percentil <- 0))
    
    puntaje_lopez_SM_percentil
    
    puntaje_lopez_portafolio_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>13.0054947287503</li><li>1.00093945557016</li><li>3.00036467457536</li></ol>
    



.. raw:: html

    10.0006725508696


Backtesting método VaR Simulación Monte Carlo (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    NC = 0.95

VaR Simulación Monte Carlo para Backtesting (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
          
        VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
      }
    }

Excepciones VaR Simulación Monte Carlo (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil = vector()
    
    for(j in 1:ncol(rendimientos)){
        
      excepciones_SM_percentil[j] = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j]<- excepciones_SM_percentil[j])
    }}
    
    p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting
    
    excepciones_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>30</li><li>9</li><li>13</li></ol>
    


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
    aprobados_SM_percentil = vector()
    
    for(i in 1:ncol(rendimientos)){
        
      aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico,aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)
    
    }
    
    aprobados_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>1</li><li>0</li><li>0</li></ol>
    


VaR Simulación Monte Carlo para Backtesting del portafolio (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    VaR_portafolio_SM_percentil = vector()
        
      for(i in 1:ventana_backtesting){
          
        VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
    }

Excepciones VaR Simulación Monte Carlo del portafolio (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    excepciones_SM_percentil_portafolio = 0
        
      for(i in 1:ventana_backtesting){
        
          ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
    }
    
    p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting
    
    excepciones_SM_percentil_portafolio



.. raw:: html

    21


Prueba de Kupiec VaR Simulación Monte Carlo (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)
    
    tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
       
    aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)
    
    aprobados_SM_percentil_portafolio



.. raw:: html

    1


Puntaje de López - VaR Simulación Monte Carlo (NC = 95% y H = 500)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    lopez_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))
    
    for(j in 1:ncol(rendimientos)){
        
      for(i in 1:ventana_backtesting){
        
        ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], lopez_SM_percentil[i,j] <- 1+(abs(rendimientos_backtesting[i,j])-VaR_individuales_SM_percentil[i,j])^2, lopez_SM_percentil[i,j] <- 0)
      
      }
    }
    
    puntaje_lopez_SM_percentil = apply(lopez_SM_percentil, 2, sum)
     
    puntaje_lopez_portafolio_SM_percentil = sum(ifelse(-VaR_portafolio_SM_percentil > rendimientos_backtesting_portafolio, lopez_portafolio_SM_percentil <- 1+(abs(rendimientos_backtesting_portafolio)-VaR_portafolio_SM_percentil)^2, lopez_portafolio_SM_percentil <- 0))
    
    puntaje_lopez_SM_percentil
    
    puntaje_lopez_portafolio_SM_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>30.0129878948899</li><li>9.00199539972408</li><li>13.0017827373353</li></ol>
    



.. raw:: html

    21.0022595939724


Conclusión general:
~~~~~~~~~~~~~~~~~~~

================== ======== ============= ========= ==============
\                  **ECO**  **PFBCOLOMB** **ISA**   **Portafolio**
================== ======== ============= ========= ==============
NC = 95% y H = 250 Aceptado Rechazado     Aceptado  Aceptado
NC = 95% y H = 500 Aceptado Rechazado     Rechazado Aceptado
NC = 99% y H = 250 Aceptado Rechazado     Aceptado  Aceptado
NC = 99% y H = 500 Aceptado Rechazado     Aceptado  Aceptado
================== ======== ============= ========= ==============

Puntaje de López
~~~~~~~~~~~~~~~~

+------------+----------------+------------+------------+------------+
|            | **ECO**        | **P        | **ISA**    | **Po       |
|            |                | FBCOLOMB** |            | rtafolio** |
+============+================+============+============+============+
| NC = 95% y | 17             | 4,0000     | 9,0013     | 11,001     |
| H = 250    | ,0093973157008 | 6494334954 | 4932149692 | 0548080044 |
+------------+----------------+------------+------------+------------+
| NC = 95% y | 29             | 9,0019     | 13,001     | 21,002     |
| H = 500    | ,0130773712762 | 8655778621 | 8075376457 | 2414973628 |
+------------+----------------+------------+------------+------------+
| NC = 99% y | 8,             | 0          | 2,0003     | 4,0002     |
| H = 250    | 00428712139614 |            | 3108544945 | 9795823917 |
+------------+----------------+------------+------------+------------+
| NC = 99% y | 14             | 1,0009     | 3,0003     | 10,00      |
| H = 500    | ,0055367419958 | 0304479033 | 4805468623 | 0693960515 |
+------------+----------------+------------+------------+------------+
