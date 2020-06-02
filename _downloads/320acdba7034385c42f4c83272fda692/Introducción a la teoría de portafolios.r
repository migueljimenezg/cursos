datos = read.csv("Cuatro acciones 2020.csv", sep = ";", dec = ",", header = T)

head(datos)
tail(datos)

precios = datos[,-1]
precios = ts(precios)

nombres = colnames(precios)
nombres

rendimientos = diff(log(precios))

correlacion = cor(rendimientos)
print(correlacion)

rendimientos_esperados = apply(rendimientos, 2, mean)
print(rendimientos_esperados)

volatilidades = apply(rendimientos, 2, sd)
print(volatilidades)

proporciones = c(0.15, 0.10, 0.50, 0.25)
proporciones

sum(proporciones)

rendimientos_portafolio = vector()

for(i in 1:nrow(rendimientos)){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
  
}

rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
rendimiento_esperado_portafolio

volatilidad_portafolio = sd(rendimientos_portafolio)
volatilidad_portafolio

h = 1 - volatilidad_portafolio/sum(volatilidades)
h

plot(volatilidades, rendimientos_esperados, xlab = " Volatilidad", ylab = "Rendimiento esperado", col = c(1:4), pch = 19, cex = 2)
points(volatilidad_portafolio, rendimiento_esperado_portafolio, pch = 17, cex = 2)
legend("topleft", c(nombres, "Portafolio N°1"), pch = c(rep(19,4), 17), col = c(1:4), bty = "n")

proporciones = c(0.25, 0.20, 0.45, 0.10)
proporciones

sum(proporciones)

rendimientos_portafolio = vector()

for(i in 1:nrow(rendimientos)){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
  
}

rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
rendimiento_esperado_portafolio

volatilidad_portafolio = sd(rendimientos_portafolio)
volatilidad_portafolio

h = 1 - volatilidad_portafolio/sum(volatilidades)
h

plot(volatilidades, rendimientos_esperados, xlab = " Volatilidad", ylab = "Rendimiento esperado", col = c(1:4), pch = 19, cex = 2)
points(volatilidad_portafolio, rendimiento_esperado_portafolio, pch = 17, cex = 2)
legend("topleft", c(nombres, "Portafolio N°1"), pch = c(rep(19,4), 17), col = c(1:4), bty = "n")
