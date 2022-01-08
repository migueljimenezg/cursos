datos = read.csv("Tres acciones.csv", sep = ";", header = T)

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

NC = 0.95
proporciones = c(0.25, 0.4, 0.35)
valor_portafolio = 100000000
valor_mercado_acciones = proporciones*valor_portafolio

VaR_individuales_SH_percentil = vector()

for(i in 1:acciones){
    
  VaR_individuales_SH_percentil[i] = abs(quantile(rendimientos[,i], 1 - NC)*valor_mercado_acciones[i])
}

VaR_individuales_SH_percentil

rendimientos_portafolio = vector()

for(i in 1:numero_rendimientos){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
}

VaR_portafolio_SH_percentil = abs(quantile(rendimientos_portafolio, 1 - NC)*valor_portafolio)
VaR_portafolio_SH_percentil
