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

t = 1

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

VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
    
    VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
}

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

volatilidad_historica_portafolio = vector()

rendimiento_medio_portafolio = vector()

for(i in 1:ventana_backtesting){
    
    volatilidad_historica_portafolio[i] = sd(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
    
    rendimiento_medio_portafolio[i] = mean(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
}

VaR_portafolio_sin_promedios = vector()

VaR_portafolio_con_promedios = vector()

for(i in 1:ventana_backtesting){
    
    VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
    
    VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
    
}

excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))

excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting

p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting

excepciones_sin_promedios_portafolio
excepciones_con_promedios_portafolio

tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)

tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)

aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)

aprobados_sin_promedios_portafolio
aprobados_con_promedios_portafolio

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

NC = 0.99

VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
    
    VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
}

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


VaR_portafolio_sin_promedios = vector()
VaR_portafolio_con_promedios = vector()

for(i in 1:ventana_backtesting){
    
    VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
    
    VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
    
}

excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))

excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting

p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting

excepciones_sin_promedios_portafolio
excepciones_con_promedios_portafolio

tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)

tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)

aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)

aprobados_sin_promedios_portafolio
aprobados_con_promedios_portafolio

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

VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
    
    VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
}

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

volatilidad_historica_portafolio = vector()

rendimiento_medio_portafolio = vector()

for(i in 1:ventana_backtesting){
    
    volatilidad_historica_portafolio[i] = sd(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
    
    rendimiento_medio_portafolio[i] = mean(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)])
}

VaR_portafolio_sin_promedios = vector()

VaR_portafolio_con_promedios = vector()

for(i in 1:ventana_backtesting){
    
    VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
    
    VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
    
}

excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))

excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting

p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting

excepciones_sin_promedios_portafolio
excepciones_con_promedios_portafolio

tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)

tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico, aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)

aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1,aprobados_con_promedios_portafolio <- 0)

aprobados_sin_promedios_portafolio
aprobados_con_promedios_portafolio

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

NC = 0.95

VaR_sin_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

VaR_con_promedios = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    VaR_sin_promedios[,i] = volatilidad_historica[,i]*qnorm(NC)*sqrt(t)
    
    VaR_con_promedios[,i] = abs(qnorm(1-NC, mean = rendimiento_medio[,i]*t, sd = volatilidad_historica[,i]*sqrt(t)))
}

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

VaR_portafolio_sin_promedios = vector()

VaR_portafolio_con_promedios = vector()

for(i in 1:ventana_backtesting){
    
    VaR_portafolio_sin_promedios[i] = volatilidad_historica_portafolio[i]*qnorm(NC)*sqrt(t)
    
    VaR_portafolio_con_promedios[i] = abs(qnorm(1-NC, mean = rendimiento_medio_portafolio[i], sd = volatilidad_historica_portafolio[i]))
    
}

excepciones_sin_promedios_portafolio = sum(ifelse(-VaR_portafolio_sin_promedios > rendimientos_backtesting_portafolio, 1, 0))

excepciones_con_promedios_portafolio = sum(ifelse(-VaR_portafolio_con_promedios > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_sin_promedios_portafolio = excepciones_sin_promedios_portafolio/ventana_backtesting

p.gorro_con_promedios_portafolio = excepciones_con_promedios_portafolio/ventana_backtesting

excepciones_sin_promedios_portafolio
excepciones_con_promedios_portafolio

tu_sin_promedios_portafolio = (p.gorro_sin_promedios_portafolio-(1-NC))/sqrt(p.gorro_sin_promedios_portafolio*(1-p.gorro_sin_promedios_portafolio)/ventana_backtesting)

tu_con_promedios_portafolio = (p.gorro_con_promedios_portafolio-(1-NC))/sqrt(p.gorro_con_promedios_portafolio*(1-p.gorro_con_promedios_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))
    
aprobados_sin_promedios_portafolio = ifelse(abs(tu_sin_promedios_portafolio) < tu_critico ,aprobados_sin_promedios_portafolio <- 1, aprobados_sin_promedios_portafolio <- 0)

aprobados_con_promedios_portafolio = ifelse(abs(tu_con_promedios_portafolio) < tu_critico, aprobados_con_promedios_portafolio <- 1, aprobados_con_promedios_portafolio <- 0)

aprobados_sin_promedios_portafolio
aprobados_con_promedios_portafolio

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
