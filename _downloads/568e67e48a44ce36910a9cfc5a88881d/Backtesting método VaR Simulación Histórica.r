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

ventana_backtesting = 250

rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)),i]  
    
}

#Para el portafolio de Inversión

rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

t = 1

NC = 0.95

VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
    
        VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
    
 }
}

plot(rendimientos_backtesting[,1], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "ECO")
lines(-VaR_SH_percentil[,1], t = "l", col = "darkred")
legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")

plot(rendimientos_backtesting[,2], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "PFBCOLOM")
lines(-VaR_SH_percentil[,2], t = "l", col = "darkred")
legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")

plot(rendimientos_backtesting[,3], t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "ISA")
lines(-VaR_SH_percentil[,3], t = "l", col = "darkred")
legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")

excepciones_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))

}

p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting

excepciones_SH_percentil
p.gorro_SH_percentil

tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil=vector()

for(i in 1:ncol(rendimientos)){
    
    aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
}

aprobados_SH_percentil

VaR_SH_percentil_portafolio = vector()

  for(i in 1:ventana_backtesting){
    
    VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
}

plot(rendimientos_backtesting_portafolio, t = "h", xlab = "Ventana Backtesting", ylab = "Rendimientos", main = "Portafolio de inversión")
lines(-VaR_SH_percentil_portafolio, t = "l", col = "darkred")
legend("topright","VaR Simulación Histórica", lty = 1, col = "darkred")

excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting

excepciones_SH_percentil_portafolio
p.gorro_SH_percentil_portafolio

tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)

aprobados_SH_percentil_portafolio

NC = 0.99

VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
    
        VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i), j], 1-NC))
    
 }
}

excepciones_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))

}

p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting

excepciones_SH_percentil
p.gorro_SH_percentil

tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
    aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
}

aprobados_SH_percentil

VaR_SH_percentil_portafolio = vector()

  for(i in 1:ventana_backtesting){
    
    VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
}

excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting

excepciones_SH_percentil_portafolio
p.gorro_SH_percentil_portafolio

tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)

aprobados_SH_percentil_portafolio

NC = 0.99

ventana_backtesting = 500

rendimientos_backtesting = matrix(, ventana_backtesting, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
rendimientos_backtesting[,i] = rendimientos[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos)), i]  
}

#Para el portafolio de Inversión

rendimientos_backtesting_portafolio = rendimientos_portafolio[-c(nrow(rendimientos)-ventana_backtesting:nrow(rendimientos))]

VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
    
        VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
    
 }
}

excepciones_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))

}

p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting

excepciones_SH_percentil
p.gorro_SH_percentil

tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
    aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico, aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
}

aprobados_SH_percentil

VaR_SH_percentil_portafolio = vector()

  for(i in 1:ventana_backtesting){
    
    VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
}

excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting

excepciones_SH_percentil_portafolio
p.gorro_SH_percentil_portafolio

tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)

aprobados_SH_percentil_portafolio

NC=0.95

VaR_SH_percentil = matrix(, ventana_backtesting, ncol(rendimientos))

for(j in 1:ncol(rendimientos)){
    
  for(i in 1:ventana_backtesting){
    
        VaR_SH_percentil[i,j] = abs(quantile(rendimientos[1:(nrow(rendimientos)-ventana_backtesting+i),j], 1-NC))
    
 }
}

excepciones_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
excepciones_SH_percentil[i] = sum(ifelse(-VaR_SH_percentil[,i] > rendimientos_backtesting[,i], 1, 0))

}

p.gorro_SH_percentil = excepciones_SH_percentil/ventana_backtesting

excepciones_SH_percentil
p.gorro_SH_percentil

tu_SH_percentil = (p.gorro_SH_percentil-(1-NC))/sqrt(p.gorro_SH_percentil*(1-p.gorro_SH_percentil)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2, ventana_backtesting-1))

aprobados_SH_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
    aprobados_SH_percentil[i] = ifelse(abs(tu_SH_percentil[i]) < tu_critico,aprobados_SH_percentil[i] <- 1, aprobados_SH_percentil[i] <- 0)
}

aprobados_SH_percentil

VaR_SH_percentil_portafolio = vector()

  for(i in 1:ventana_backtesting){
    
    VaR_SH_percentil_portafolio[i] = abs(quantile(rendimientos_portafolio[1:(nrow(rendimientos)-ventana_backtesting+i)], 1-NC))
}

excepciones_SH_percentil_portafolio = sum(ifelse(-VaR_SH_percentil_portafolio > rendimientos_backtesting_portafolio, 1, 0))

p.gorro_SH_percentil_portafolio = excepciones_SH_percentil_portafolio/ventana_backtesting

excepciones_SH_percentil_portafolio
p.gorro_SH_percentil_portafolio

tu_SH_percentil_portafolio = (p.gorro_SH_percentil_portafolio-(1-NC))/sqrt(p.gorro_SH_percentil_portafolio*(1-p.gorro_SH_percentil_portafolio)/ventana_backtesting)

tu_critico = abs(qt((1-NC)/2,ventana_backtesting-1))

aprobados_SH_percentil_portafolio = ifelse(abs(tu_SH_percentil_portafolio) < tu_critico, aprobados_SH_percentil_portafolio <- 1, aprobados_SH_percentil_portafolio <- 0)

aprobados_SH_percentil_portafolio
