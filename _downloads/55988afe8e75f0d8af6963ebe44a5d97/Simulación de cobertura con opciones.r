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

k1 = 3400
k2 = 3450

# Tasas libres de riesgo

r = 0.018 # E.A. (Colombia)

rf = 0.003 # Nominal (USA)

# Con el modelo Black-Scholes se trabaja con tasas continuas:

r = log(1+r) # C.C.A.

rf = log(1+rf/12)*12 # C.C.A.

T = 30 # 1 mes
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

compensacionesCall1 = vector()
compensacionesCall2 = vector()
compensacionesPut1 = vector()
compensacionesPut2 = vector()

for(i in 1:iteraciones){
    
    compensacionesCall1[i] = max(st_prima[i,T+1]-k1,0)*exp(-(r-rf)*1/12)
    compensacionesCall2[i] = max(st_prima[i,T+1]-k2,0)*exp(-(r-rf)*1/12)
    
    compensacionesPut1[i] = max(k1-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
    compensacionesPut2[i] = max(k2-st_prima[i,T+1],0)*exp(-(r-rf)*1/12)
}

primaCall1 = mean(compensacionesCall1)
primaCall1

primaCall2 = mean(compensacionesCall2)
primaCall2

primaPut1 = mean(compensacionesPut1)
primaPut1

primaPut2 = mean(compensacionesPut2)
primaPut2

# Simulación del precio del activo subyacente con riesgo, se utiliza el rendimiento esperado.

st = matrix(, iteraciones, T+1)

st[,1] = s

for(i in 1:iteraciones){
    
    for(j in 2:(T+1)){
        
   st[i,j] = st[i,j-1]*exp((mu-volatilidad^2/2)*dt+volatilidad*sqrt(dt)*rnorm(1)) 
        
   }
}

# Precios con cobertura.

coberturaCall = vector()
coberturaPut = vector()
coberturaSpreadComprador = vector()
coberturaSpreadVendedor = vector()

for(i in 1:iteraciones){
    
   coberturaCall[i] = abs(-st[i,T+1]+max(st[i,T+1]-k1,0)-primaCall1)

   coberturaPut[i] = st[i,T+1]+max(k1-st[i,T+1],0)-primaPut1
        
   coberturaSpreadComprador[i] = abs(-st[i,T+1]+max(st[i,T+1]-k1,0)+min(k2-st[i,T+1],0))
        
   coberturaSpreadVendedor[i] = st[i,T+1]+min(st[i,T+1]-k1,0)+max(k2-st[i,T+1],0)    
    
}

resultados = data.frame(st[,T+1], coberturaCall, coberturaSpreadComprador, coberturaPut, coberturaSpreadVendedor)

colnames(resultados) = c("Sin cobertura", "Cobertura Call", "Cobertura Spread Comprador", "Cobertura Put", "Cobertura Spread Vendedor")
head(resultados)

library(ggplot2)

mean(resultados[,"Sin cobertura"])

quantile(resultados[,"Sin cobertura"], c(0.05, 0.95))

sd(resultados[,"Sin cobertura"])

ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
  labs(title = "Escenario sin cobertura", x = "Precio")

mean(resultados[,"Cobertura Call"])

quantile(resultados[,"Cobertura Call"], c(0.05, 0.95))

sd(resultados[,"Cobertura Call"])

ggplot(data = resultados, aes(resultados[,"Cobertura Call"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Call"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
  labs(title = "Escenario cobertura Call", x = "Precio")

mean(resultados[,"Cobertura Spread Comprador"])

quantile(resultados[,"Cobertura Spread Comprador"], c(0.05, 0.95))

sd(resultados[,"Cobertura Spread Comprador"])

ggplot(data = resultados, aes(resultados[,"Cobertura Spread Comprador"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Comprador"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
  labs(title = "Escenario cobertura Spread Comprador", x = "Precio")

ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Call"],c(0.05, 0.95)), colour="darkgreen", size=1.5)+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Comprador"],c(0.05, 0.95)), colour="darkblue", size=1.5)+
  labs(x = "Precio")

mean(resultados[,"Cobertura Put"])

quantile(resultados[,"Cobertura Put"], c(0.05, 0.95))

sd(resultados[,"Cobertura Put"])

ggplot(data = resultados, aes(resultados[,"Cobertura Put"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Put"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
  labs(title = "Escenario cobertura Put", x = "Precio")

mean(resultados[,"Cobertura Spread Vendedor"])

quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95))

sd(resultados[,"Cobertura Spread Vendedor"])

ggplot(data = resultados, aes(resultados[,"Cobertura Spread Vendedor"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
  labs(title = "Escenario cobertura Spread Vendedor", x = "Precio")

ggplot(data = resultados, aes(resultados[,"Sin cobertura"]))+
  geom_histogram(aes(y=..density..),binwidth = 50, colour = "darkgray", fill = "darkgray")+
  geom_vline(xintercept = quantile(resultados[,"Sin cobertura"], c(0.05, 0.95)), colour="black", size=1.5)+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Put"], c(0.05, 0.95)), colour="darkgreen", size=1.5)+
  geom_vline(xintercept = quantile(resultados[,"Cobertura Spread Vendedor"], c(0.05, 0.95)), colour="darkblue", size=1.5)+
  labs(x = "Precio")

ggplot(resultados, aes(resultados[,"Sin cobertura"])) + geom_histogram(binwidth = 50, alpha = 0.5, colour = "darkgray", fill = "darkgray")+
  geom_histogram(aes(resultados[,"Cobertura Call"]), alpha = 0.3, binwidth = 50, colour = "darkgreen", fill = "darkgreen")+
  geom_histogram(aes(resultados[,"Cobertura Spread Comprador"]), alpha = 0.3, binwidth = 50, colour = "darkblue", fill = "darkblue")+
  labs(title = "Histogramas", x = "Precio", y = "Frecuencia")

ggplot(resultados, aes(resultados[,"Sin cobertura"])) + geom_histogram(binwidth = 50, alpha = 0.5, colour = "darkgray", fill = "darkgray")+
  geom_histogram(aes(resultados[,"Cobertura Put"]), alpha = 0.3, binwidth = 50, colour = "darkgreen", fill = "darkgreen")+
  geom_histogram(aes(resultados[,"Cobertura Spread Vendedor"]), alpha = 0.3, binwidth = 50, colour = "darkblue", fill = "darkblue")+
  labs(title = "Histogramas", x = "Precio", y = "Frecuencia")
