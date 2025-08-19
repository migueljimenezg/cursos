datos = read.csv("Datos primer examen 01-2020.csv", sep = ";", header = T)

head(datos)
tail(datos)

precios=datos[,-1]
precios = ts(precios)

nombres = colnames(precios)
nombres

rendimientos = diff(log(precios))

acciones = ncol(precios)
acciones

numero_rendimientos = nrow(rendimientos)
numero_rendimientos

proporciones = c(0.25, 0.25, 0.25, 0.25)
valor_portafolio = 1000000000
valor_mercado_acciones = proporciones*valor_portafolio
valor_mercado_acciones

NC = 0.99

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i],1 - NC))
}

VaR_individuales_SH_percentil

CVaR = vector()

for(i in 1:acciones){
    
  CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1-NC)))))
}

CVaR

rendimientos_portafolio = vector()

for(i in 1:numero_rendimientos){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
}

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
VaR_portafolio_SH_percentil

CVaR_portafolio = abs(mean(tail(sort(rendimientos_portafolio, decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
CVaR_portafolio

NC = 0.99

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
}

VaR_individuales_SH_percentil[1]

VaR_individuales_SH_percentil[1]*valor_mercado_acciones[1]

NC = 0.95

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
}

VaR_individuales_SH_percentil[1]

VaR_individuales_SH_percentil[1]*valor_mercado_acciones[1]

NC = 0.99

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
}

VaR_individuales_SH_percentil[3]

VaR_individuales_SH_percentil[3]*valor_mercado_acciones[1]

NC = 0.95

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC))
}

VaR_individuales_SH_percentil[3]

VaR_individuales_SH_percentil[3]*valor_mercado_acciones[1]

NC = 0.99

CVaR = vector()

for(i in 1:acciones){
    
  CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
}

CVaR[2]

CVaR[2]*valor_mercado_acciones[2]

NC = 0.95

CVaR = vector()

for(i in 1:acciones){
    
  CVaR[i] = abs(mean(tail(sort(rendimientos[,i], decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
}

CVaR[2]

CVaR[2]*valor_mercado_acciones[2]

NC = 0.99

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
VaR_portafolio_SH_percentil
VaR_portafolio_SH_percentil*valor_portafolio

NC = 0.95

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))
VaR_portafolio_SH_percentil
VaR_portafolio_SH_percentil*valor_portafolio

NC = 0.99

CVaR_portafolio = abs(mean(tail(sort(rendimientos_portafolio,decreasing = T), floor(nrow(rendimientos)*(1 - NC)))))
CVaR_portafolio
CVaR_portafolio*valor_portafolio

NC = 0.99

VaR_individuales_SH_percentil=vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
}

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))*valor_portafolio

BD = sum(VaR_individuales_SH_percentil) - VaR_portafolio_SH_percentil
BD

NC = 0.95

VaR_individuales_SH_percentil=vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
}

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC))*valor_portafolio

BD = sum(VaR_individuales_SH_percentil) - VaR_portafolio_SH_percentil
BD
