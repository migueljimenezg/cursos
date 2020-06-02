datos = read.csv("Tres acciones.csv", sep=";", dec=",", header = T)

precios = datos[,-1]

nombres = colnames(precios)
nombres

acciones = ncol(precios)
acciones

precios = ts(precios)

rendimientos = diff(log(precios))

plot(rendimientos, main = "Rendimientos")

volatilidades = apply(rendimientos, 2, sd)
print(volatilidades)

numero_rendimientos = nrow(rendimientos)
numero_rendimientos

lambda = 0.94

volatilidad_EWMA = matrix(, numero_rendimientos, acciones) # Matriz para calcular volatilidad EWMA para cada período por acción.

volatilidad_EWMA[1,] = 0 # La primera fila de la matriz anterior tendrá como valor semilla igual a cero.

for(j in 1:acciones){ 
    
    for(i in 2:numero_rendimientos){ 
        
        volatilidad_EWMA[i, j] = sqrt((1 - lambda)*rendimientos[i - 1, j]^2 + lambda*volatilidad_EWMA[i - 1, j]^2)
        
} 
}

head(volatilidad_EWMA)
tail(volatilidad_EWMA)

vol_EWMA = tail(volatilidad_EWMA, 1)
print(vol_EWMA)

colnames(vol_EWMA) = nombres # se renombran las columnas con los nombres de las acciones.
print(vol_EWMA)

print(volatilidades)
