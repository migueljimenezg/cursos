datos = read.csv("Tres acciones.csv", sep = ";")

precios = datos[,-1]

proporciones = c(0.25,0.5,0.25)

rendimientos = matrix(, nrow(precios)-1, ncol(precios))

for(i in 1:ncol(precios)){
    
  rendimientos[,i] = diff(log(precios[,i]))
}

rendimientos_portafolio = vector()

for(i in 1:nrow(rendimientos)){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
}

NC = 0.95

ventana_backtesting = 250

rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)), i]  
}

#Para el portafolio de Inversión

rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

volatilidad_historica = matrix(, ventana_backtesting, ncol(rendimientos))

rendimiento_medio = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    volatilidad_historica[i,j] = sd(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
      
    rendimiento_medio[i,j] = mean(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
 }
}

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

VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
  }
}

excepciones_SM_percentil = vector()

for(j in 1:ncol(rendimientos)){
    
  excepciones_SM_percentil[j] = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
}}

p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting

excepciones_SM_percentil

tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SM_percentil=vector()

for(i in 1:ncol(rendimientos)){
    
  aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico, aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)

}

aprobados_SM_percentil

rend_port_backtesting = matrix(, ventana_backtesting, iteraciones)

for(j in 1:iteraciones){
    
    for(i in 1:ventana_backtesting){
    
    rend_port_backtesting[i,j] = sum(rend_backtesting[i,j,]*proporciones)
        
}}

VaR_portafolio_SM_percentil = vector()
    
  for(i in 1:ventana_backtesting){
      
    VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
}

excepciones_SM_percentil_portafolio = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
}

p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting

excepciones_SM_percentil_portafolio

tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
   
aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <-1 , aprobados_SM_percentil_portafolio <- 0)

aprobados_SM_percentil_portafolio

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

NC = 0.99

VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
  }
}

excepciones_SM_percentil = vector()

for(j in 1:ncol(rendimientos)){
    
  excepciones_SM_percentil[j] = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
}}

p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting

excepciones_SM_percentil

tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico, aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)

}

aprobados_SM_percentil

VaR_portafolio_SM_percentil = vector()
    
  for(i in 1:ventana_backtesting){
      
    VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
}

excepciones_SM_percentil_portafolio = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
}

p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting

excepciones_SM_percentil_portafolio
p.gorro_SM_percentil_portafolio

tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
   
aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)

aprobados_SM_percentil_portafolio

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

NC = 0.99

ventana_backtesting = 500

rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)), i]  
}

#Para el portafolio de Inversión

rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

volatilidad_historica = matrix(, ventana_backtesting, ncol(rendimientos))

rendimiento_medio = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    volatilidad_historica[i,j] = sd(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
      
    rendimiento_medio[i,j] = mean(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j])
 }
}

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

VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
  }
}

excepciones_SM_percentil = vector()

for(j in 1:ncol(rendimientos)){
    
  excepciones_SM_percentil[j] = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j] <- excepciones_SM_percentil[j])
}}

p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting

excepciones_SM_percentil

tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico,aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)
}

aprobados_SM_percentil

rend_port_backtesting = matrix(, ventana_backtesting, iteraciones)

for(j in 1:iteraciones){
    
    for(i in 1:ventana_backtesting){
    
    rend_port_backtesting[i,j] = sum(rend_backtesting[i,j,]*proporciones)
}}

VaR_portafolio_SM_percentil = vector()
    
  for(i in 1:ventana_backtesting){
      
    VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
}

excepciones_SM_percentil_portafolio = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
}

p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting

excepciones_SM_percentil_portafolio
p.gorro_SM_percentil_portafolio

tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
   
aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)

aprobados_SM_percentil_portafolio

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

NC = 0.95

VaR_individuales_SM_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
      
    VaR_individuales_SM_percentil[i,j] = abs(quantile(rend_backtesting[i,,j], 1-NC))
  }
}

excepciones_SM_percentil = vector()

for(j in 1:ncol(rendimientos)){
    
  excepciones_SM_percentil[j] = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_individuales_SM_percentil[i,j] > rendimientos_backtesting[i,j], excepciones_SM_percentil[j] <- excepciones_SM_percentil[j]+1, excepciones_SM_percentil[j]<- excepciones_SM_percentil[j])
}}

p.gorro_SM_percentil = excepciones_SM_percentil/ventana_backtesting

excepciones_SM_percentil

tu_SM_percentil = (p.gorro_SM_percentil-(1-NC))/sqrt(p.gorro_SM_percentil*(1-p.gorro_SM_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  aprobados_SM_percentil[i] = ifelse(abs(tu_SM_percentil[i]) < tu_critico,aprobados_SM_percentil[i] <- 1, aprobados_SM_percentil[i] <- 0)

}

aprobados_SM_percentil

VaR_portafolio_SM_percentil = vector()
    
  for(i in 1:ventana_backtesting){
      
    VaR_portafolio_SM_percentil[i] = abs(quantile(rend_port_backtesting[i,], 1-NC))
}

excepciones_SM_percentil_portafolio = 0
    
  for(i in 1:ventana_backtesting){
    
      ifelse(-VaR_portafolio_SM_percentil[i] > rendimientos_backtesting_portafolio[i], excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio+1, excepciones_SM_percentil_portafolio <- excepciones_SM_percentil_portafolio)
}

p.gorro_SM_percentil_portafolio = excepciones_SM_percentil_portafolio/ventana_backtesting

excepciones_SM_percentil_portafolio

tu_SM_percentil_portafolio = (p.gorro_SM_percentil_portafolio-(1-NC))/sqrt(p.gorro_SM_percentil_portafolio*(1-p.gorro_SM_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
   
aprobados_SM_percentil_portafolio = ifelse(abs(tu_SM_percentil_portafolio) < tu_critico, aprobados_SM_percentil_portafolio <- 1, aprobados_SM_percentil_portafolio <- 0)

aprobados_SM_percentil_portafolio

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
