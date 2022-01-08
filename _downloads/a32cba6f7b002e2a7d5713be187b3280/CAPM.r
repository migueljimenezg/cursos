datos = read.csv("Cuatro acciones 2020 y COLCAP - mensual.csv", sep = ";", dec = ",", header = T)

head(datos)
tail(datos)

precios = datos[, 2:5]
precios = ts(precios)

COLCAP = datos[,6]
COLCAP = ts(COLCAP)

nombres = colnames(precios)
nombres

numero_precios = nrow(datos)
numero_precios

rendimientos = diff(precios)/precios[-numero_precios,]

rendimientos_mercado = diff(COLCAP)/COLCAP[-numero_precios]

rendimientos_esperados = apply(rendimientos, 2, mean)
print(rendimientos_esperados)

rendimiento_esperado_mercado = mean(rendimientos_mercado)
rendimiento_esperado_mercado

volatilidades = apply(rendimientos, 2, sd)
print(volatilidades)

volatilidad_mercado = sd(rendimientos_mercado)
volatilidad_mercado

proporciones = c(0.10, 0.05, 0.75, 0.10)
proporciones

rendimientos_portafolio = vector()

for(i in 1:nrow(rendimientos)){
    
  rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
  
}

rendimiento_esperado_portafolio = mean(rendimientos_portafolio)
rendimiento_esperado_portafolio

covarianzas_mercado = cov(rendimientos, rendimientos_mercado)
print(covarianzas_mercado)

correlacion_mercado = cor(rendimientos, rendimientos_mercado)
print(correlacion_mercado)

beta = covarianzas_mercado/volatilidad_mercado^2
print(beta)

beta = volatilidades/volatilidad_mercado*correlacion_mercado
print(beta)

regresion = lm(rendimientos ~ rendimientos_mercado)
regresion

beta = regresion$coefficients[2,]
print(beta)

beta_portafolio = sum(proporciones*beta)
beta_portafolio

regresion_mercado = lm(rendimientos_portafolio ~ rendimientos_mercado)
regresion_mercado

beta_portafolio = regresion_mercado$coefficients[2]
beta_portafolio

for(i in 1: ncol(precios)){
   plot(as.numeric(rendimientos_mercado), as.numeric(rendimientos[,i]), xlab = "Rendimientos del mercado", ylab = "Rendimientos de la acción", main = nombres[i], pch = 19)
   abline(regresion$coefficients[,i], lwd = 3, col = "darkblue") 
}

plot(as.numeric(rendimientos_mercado), as.numeric(rendimientos_portafolio), xlab = "Rendimientos del mercado", ylab = "Rendimientos de la acción", main = "Portafolio de inversión", pch = 19)
abline(regresion_mercado$coefficients, lwd = 3, col = "darkblue")

Rf = 0.06916 #E.A.
Rf_mensual = (1 + Rf)^(1/12)-1    #Efectivo Mensual.
Rf_mensual

CAPM = Rf_mensual + beta*(rendimiento_esperado_mercado - Rf_mensual)
print(CAPM)

CAPM_portafolio = Rf_mensual + beta_portafolio*(rendimiento_esperado_mercado - Rf_mensual)
CAPM_portafolio

Rf_diaria = (1 + Rf)^(1/250)-1    #Efectivo Diaria.
Rf_diaria

rendimiento_esperado_mercado_diario = rendimiento_esperado_mercado/20
rendimiento_esperado_mercado_diario

CAPM_portafolio = Rf_diaria + beta_portafolio*(rendimiento_esperado_mercado_diario - Rf_diaria)
CAPM_portafolio

rendimiento_esperado_mercado_anual = rendimiento_esperado_mercado*12
rendimiento_esperado_mercado_anual

CAPM_portafolio = Rf + beta_portafolio*(rendimiento_esperado_mercado_anual - Rf)
CAPM_portafolio

beta_ajustado = 2/3*beta + 1/3
print(beta_ajustado)

beta_portafolio_ajustado = 2/3*beta_portafolio + 1/3
beta_portafolio_ajustado

CAPM = Rf_mensual + beta_ajustado*(rendimiento_esperado_mercado - Rf_mensual)
print(CAPM)

CAPM_portafolio = Rf_mensual + beta_portafolio_ajustado*(rendimiento_esperado_mercado - Rf_mensual)
CAPM_portafolio
