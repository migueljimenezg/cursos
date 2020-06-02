datos = read.csv("Tres acciones.csv", sep=";", dec=",", header = T)

precios = datos[,-1]

head(precios)
tail(precios)

nombres = colnames(precios)
nombres

acciones = ncol(precios)
acciones

precios = ts(precios)

rendimientos = diff(log(precios))

plot(rendimientos, main = "Rendimientos")

volatilidades = apply(rendimientos, 2, sd)
print(volatilidades)

library(tseries)

coeficientes_garch = matrix(, 3, acciones)

for(i in 1:acciones){
    
  coeficientes_garch[, i] = coef(garch(rendimientos[, i]))
}

print(coeficientes_garch)

colnames(coeficientes_garch) = nombres # se renombran las columnas con los nombres de las acciones.

rownames(coeficientes_garch) = c("Omega", "Alfa", "Beta") # se renombran las filas con los nombres de los coeficientes.

print(coeficientes_garch)

volatilidad_largo_plazo = vector()

for(i in 1:acciones){
    
  volatilidad_largo_plazo[i] = coeficientes_garch[1, i]/(1 - coeficientes_garch[2, i] - coeficientes_garch[3, i])  
}

print(volatilidad_largo_plazo)

numero_rendimientos = nrow(rendimientos)
numero_rendimientos

volatilidad_garch = matrix(, numero_rendimientos, acciones) # Matriz para calcular volatilidad GARCH para cada período por acción.

volatilidad_garch[1,] = 0 # La primera fila de la matriz anterior tendrá como valor semilla igual a cero.

for(j in 1:acciones){
    
  for(i in 2:numero_rendimientos){
      
    volatilidad_garch[i, j] = sqrt(coeficientes_garch[1, j] + coeficientes_garch[2, j]*rendimientos[i - 1, j]^2 + coeficientes_garch[3, j]*volatilidad_garch[i - 1, j]^2)
      
  }
}

head(volatilidad_garch)
tail(volatilidad_garch)

vol_GARCH = tail(volatilidad_garch, 1)
print(vol_GARCH)

colnames(vol_GARCH) = nombres # se renombran las columnas con los nombres de las acciones.
print(vol_GARCH)

print(volatilidades)
