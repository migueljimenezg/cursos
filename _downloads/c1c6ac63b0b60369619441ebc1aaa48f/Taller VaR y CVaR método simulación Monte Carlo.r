datos = read.csv("Datos primer examen 01-2020.csv", sep = ";")

precios = datos[,-1]

rendimientos = matrix(, nrow(precios)-1, ncol(precios))

for(i in 1:ncol(precios)){
    
  rendimientos[,i] = diff(log(precios[,i]))
    
}

s = tail(precios,1)
s = as.numeric(s)
s

numero_acciones = c(180000,5000,12000,20000)
numero_acciones

valor_mercado_acciones = numero_acciones*s
valor_mercado_acciones

valor_portafolio = sum(valor_mercado_acciones)
valor_portafolio

proporciones = valor_mercado_acciones/valor_portafolio
proporciones

mu = apply(rendimientos, 2, mean)
mu

volatilidades = apply(rendimientos, 2, sd)
volatilidades

correlacion = cor(rendimientos)
correlacion

cholesky = chol(correlacion)
cholesky

n = 5
dt = 1/5
NC = 0.90

iteraciones = 50000

st = array(dim = c(iteraciones, n+1, ncol(rendimientos)))

for(i in 1:ncol(rendimientos)){
    
    st[,1,i] = s[i] # Con este for se está almacenando el precio actual de cada acción en la columna 1 de las matrices del array.
}

aleatorio_corr = vector()

for(k in 1:ncol(precios)){
    
    for(i in 1:iteraciones){
        
           
    for(j in 2:(n+1)){
        
    aleatorio = rnorm(ncol(precios))
    aleatorio_corr = colSums(aleatorio*cholesky)
     
    st[i,j,k] = st[i,j-1,k]*exp((mu[k]-volatilidades[k]^2/2)*dt+volatilidades[k]*sqrt(dt)*aleatorio_corr[k])
           
  }
}
}

rend = matrix(,iteraciones,ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    rend[,i] = st[,n+1,i]/s[i]-1 #Rendimientos semanales simulados de cada acción.
}

rend_port = vector()

for(i in 1:nrow(rendimientos)){
    
    rend_port[i] = sum(rend[i,]*proporciones)
    
}

VaR_individuales_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
    
}
VaR_individuales_SM_percentil

VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
VaR_portafolio_SM_percentil

CVaR = vector()

for(i in 1:ncol(rendimientos)){
    
  CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
}
CVaR

CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
CVaR_portafolio

n = 20
dt = 1/5
NC = 0.95

iteraciones = 50000

st = array(dim = c(iteraciones, n+1, ncol(rendimientos)))

for(i in 1:ncol(rendimientos)){
    
    st[,1,i] = s[i] # Con esto for se está almacenando el precio actual de cada acción en la columna 1 de las matrices del array.
}

aleatorio_corr = vector()

for(k in 1:ncol(precios)){
    
    for(i in 1:iteraciones){
        
           
    for(j in 2:(n+1)){
        
    aleatorio = rnorm(ncol(precios))
    aleatorio_corr = colSums(aleatorio*cholesky)
     
    st[i,j,k] = st[i,j-1,k]*exp((mu[k]-volatilidades[k]^2/2)*dt+volatilidades[k]*sqrt(dt)*aleatorio_corr[k])
           
  }
}
}

rend = matrix(, iteraciones, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    rend[,i] = st[,n+1,i]/s[i]-1 #Rendimientos mensuales simulados de cada acción.
}

rend_port = vector()

for(i in 1:nrow(rendimientos)){
    
    rend_port[i] = sum(rend[i,]*proporciones)
}

VaR_individuales_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
}
VaR_individuales_SM_percentil

VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
VaR_portafolio_SM_percentil

CVaR = vector()

for(i in 1:ncol(rendimientos)){
    
  CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
}
CVaR

CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
CVaR_portafolio

NC = 0.99

rend = matrix(, iteraciones, ncol(rendimientos))

for(i in 1:ncol(rendimientos)){
    
    rend[,i] = st[,2,i]/s[i]-1 #Rendimientos simulados de cada acción para el día 1.
}

rend_port = vector()

for(i in 1:nrow(rendimientos)){
    
    rend_port[i] = sum(rend[i,]*proporciones)
}

VaR_individuales_SM_percentil = vector()

for(i in 1:ncol(rendimientos)){
    
  VaR_individuales_SM_percentil[i] = abs(quantile(rend[,i], 1-NC)*valor_mercado_acciones[i])
    
}
VaR_individuales_SM_percentil

VaR_portafolio_SM_percentil = abs(quantile(rend_port, 1-NC)*valor_portafolio)
VaR_portafolio_SM_percentil

CVaR = vector()

for(i in 1:ncol(rendimientos)){
    
  CVaR[i] = abs(mean(tail(sort(rend[,i], decreasing = T), floor(nrow(rend)*(1-NC))))*valor_mercado_acciones[i])
}
CVaR

CVaR_portafolio = abs(mean(tail(sort(rend_port, decreasing = T), floor(nrow(rend)*(1-NC))))*valor_portafolio)
CVaR_portafolio
