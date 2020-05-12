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

CVaR=vector()
for(i in 1:ncol(rendimientos)){
  CVaR[i]=abs(mean(tail(sort(rendimientos[,i],decreasing = T),floor(nrow(rendimientos)*(1-NC))))*valor_mercado_acciones[i])
}
CVaR

rendimientos_portafolio=vector()
for(i in 1:nrow(rendimientos)){
  rendimientos_portafolio[i]=sum(rendimientos[i,]*proporciones)
}

CVaR_portafolio=abs(mean(tail(sort(rendimientos_portafolio,decreasing = T),floor(nrow(rendimientos)*(1-NC))))*valor_portafolio)
CVaR_portafolio
