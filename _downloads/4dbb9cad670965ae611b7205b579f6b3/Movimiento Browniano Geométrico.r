datos = read.csv("Tres acciones.csv", sep = ";")

precios = datos[,-1]

rendimientos = matrix(, nrow(precios)-1, ncol(precios))

for(i in 1:ncol(precios)){
    
  rendimientos[,i] = diff(log(precios[,i]))
}

proporciones = c(0.25, 0.40, 0.35)

s = tail(precios,1)
s = as.numeric(s)
s

mu = apply(rendimientos, 2, mean)
mu

volatilidades = apply(rendimientos, 2, sd)
volatilidades

rnorm(15)

n = 100
dt = 1
iteraciones = 50

st_ECO = matrix(, iteraciones, n+1)

st_ECO[,1] = s[1]

for(i in 1:iteraciones){
    
    for(j in 2:(n+1)){
        
   st_ECO[i,j] = st_ECO[i,j-1]*exp((mu[1]-volatilidades[1]^2/2)*dt+volatilidades[1]*sqrt(dt)*rnorm(1))     
    }
}

matplot(t(st_ECO), t = "l")

library(fanplot)

fan0(st_ECO, ln = c(5,25,50,75,95), xlim = c(0, n+1), ylim = c(min(st_ECO), max(st_ECO)), xlab = "Tiempo en días", ylab = "Precios simulados")
abline( h = s[1], lwd = 4)

st_PFB = matrix(, iteraciones, n+1)

st_PFB[,1] = s[2]

for(i in 1:iteraciones){
    
    for(j in 2:(n+1)){
        
   st_PFB[i,j] = st_PFB[i,j-1]*exp((mu[2]-volatilidades[2]^2/2)*dt+volatilidades[2]*sqrt(dt)*rnorm(1))     
        
    }
}

matplot(t(st_PFB), t = "l")

fan0(st_PFB, ln = c(5,25,50,75,95), xlim = c(0, n+1), ylim =c (min(st_PFB), max(st_PFB)), xlab = "Tiempo en días", ylab = "Precios simulados")
abline(h = s[2], lwd = 4)

st_ISA = matrix(, iteraciones, n+1)

st_ISA[,1] = s[3]

for(i in 1:iteraciones){
    
    for(j in 2:(n+1)){
        
   st_ISA[i,j] = st_ISA[i,j-1]*exp((mu[3]-volatilidades[3]^2/2)*dt+volatilidades[3]*sqrt(dt)*rnorm(1))     
        
    }
}

matplot(t(st_ISA), t = "l")

fan0(st_ISA,ln = c(5,25,50,75,95), xlim = c(0, n+1), ylim = c(min(st_ISA), max(st_ISA)), xlab = "Tiempo en días", ylab = "Precios simulados")
abline(h = s[3], lwd = 4)

correlacion = cor(rendimientos)
correlacion

cholesky = chol(correlacion)
cholesky

dt = 1

n = 100
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

hist(st[,2,1], col = "gray", breaks = 40, xlab = "Rendimientos", ylab = "Frecuencia", main = "Histograma acción de ECO día 1", freq = F)

hist(st[,n+1,1], col = "gray", breaks = 40, xlab = "Rendimientos", ylab = "Frecuencia", main = "Histograma acción de ECO día 100", freq = F)

hist(st[,n+1,1], col = "white", border = "white", breaks = 40, xlab = "Rendimientos", ylab = "Frecuencia", main = "", freq = F, ylim = c(0,0.007))
lines(density(st[,2,1]), col = "gray55", lwd = 2)
lines(density(st[,5,1]), col = "darkgreen", lwd = 2)
lines(density(st[,21,1]), col = "darkblue", lwd = 3)
lines(density(st[,81,1]), col = "red", lwd = 3)
lines(density(st[,n+1,1]), lwd = 3)
legend(x = "topright", c("1 día","5 días","20 días","80 días","100 días"), col = c("gray55","darkgreen","darkblue","brown","black"), lwd = c(2,2,3,3,3), bty = "n")
