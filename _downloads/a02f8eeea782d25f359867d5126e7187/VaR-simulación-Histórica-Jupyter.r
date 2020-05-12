datos=read.csv("Tres acciones.csv",sep = ";")

precios=datos[,-1]

rendimientos=matrix(,nrow(precios)-1,ncol(precios))
for(i in 1:ncol(precios)){
  rendimientos[,i]=diff(log(precios[,i]))
}

NC=0.95
proporciones=c(0.25,0.4,0.35)
valor_portafolio=100000000
valor_mercado_acciones=proporciones*valor_portafolio

VaR_individuales_SH_percentil=vector()
for(i in 1:ncol(rendimientos)){
  VaR_individuales_SH_percentil[i]=abs(quantile(rendimientos[,i],1-NC)*valor_mercado_acciones[i])
}
VaR_individuales_SH_percentil

rendimientos_portafolio=vector()

for(i in 1:nrow(rendimientos)){
  rendimientos_portafolio[i]=sum(rendimientos[i,]*proporciones)
}

VaR_portafolio_SH_percentil=abs(quantile(rendimientos_portafolio,1-NC)*valor_portafolio)
VaR_portafolio_SH_percentil
