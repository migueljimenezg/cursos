datos = read.csv("TRM diaria febrero 2020.csv", sep = ";", dec = ",")

head(datos)

precios = datos[,2]
precios = ts(precios)

rendimientos = diff(log(precios))

plot(precios, main = "Precio", lwd = 3)

plot(rendimientos, main = "Rendimientos", t = "h")

s = tail(precios,1)
s = as.numeric(s)
s

mu = mean(rendimientos) #diario
mu

volatilidad = sd(rendimientos) #diaria
volatilidad

# Tasas libres de riesgo

r = 0.018 # E.A. (Colombia)

rf = 0.003 # Nominal (USA)

# Con el modelo Black-Scholes se trabaja con tasas continuas:

r = log(1+r) # C.C.A.

rf = log(1+rf/12)*12 # C.C.A.

T = 30 # 1 mes
k = 3450
dt = 1 # saltos diarios
iteraciones = 10000

set.seed(1) # Valor semilla para la simulación. Con esto siempre se obtendrá el mismo valor.

# Simulación del precio del activo subyacente con un mundo neutral al riesgo

st_prima = matrix(, iteraciones, T+1)

st_prima[,1] = s

for(i in 1:iteraciones){
    
    for(j in 2:(T+1)){
        
   st_prima[i,j] = st_prima[i,j-1]*exp((r/360-rf/360-volatilidad^2/2)*dt+volatilidad*sqrt(dt)*rnorm(1)) 
        
   }
}

compensacionesCall = vector()
compensacionesPut = vector()

for(i in 1:iteraciones){
    
    compensacionesCall[i] = max(st_prima[i,T+1]-k,0)*exp(-(r-rf)*1/12)
    
    compensacionesPut[i] = max(k-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
}

primaCall = mean(compensacionesCall)
primaCall

primaPut = mean(compensacionesPut)
primaPut

hist(compensacionesCall, col = "gray", xlab = "Compensación", ylab = "Frecuencia", main = "Compensaciones Call")

hist(compensacionesPut, col = "gray", xlab = "Compensación", ylab = "Frecuencia", main = "Compensaciones Put")
