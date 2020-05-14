s = 5000
mu = 0.00014 #Compuesto continuo diario.
volatilidad = 0.018 #Diaria
valor_mercado = 250000000

n = 1 #Un día
dt = 1
NC = 0.99

iteraciones = 50000

st = matrix(, iteraciones, n+1)

st[,1] = s

for(j in 2:(n+1)){
    
  for(i in 1:iteraciones){
    
    st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*rnorm(1)*sqrt(dt)) #Precios simulados.
  }
}

rend = st[,n+1]/s-1

VaR = abs(quantile(rend, 1-NC)*valor_mercado)
VaR

CVaR = abs(mean(tail(sort(rend, decreasing = T), floor(50000*(1-NC))))*valor_mercado)
CVaR

n = 20 #Un mes
dt = 1
NC = 0.90

iteraciones = 50000

st = matrix(, iteraciones, n+1)

st[,1] = s

for(j in 2:(n+1)){
    
  for(i in 1:iteraciones){
    
    st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*rnorm(1)*sqrt(dt)) #Precios simulados.
  }
}

rend = st[,n+1]/s-1 #Rendimientos simulados.

VaR = abs(quantile(rend, 1-NC)*valor_mercado)
VaR

CVaR = abs(mean(tail(sort(rend, decreasing = T), floor(50000*(1-NC))))*valor_mercado)
CVaR
