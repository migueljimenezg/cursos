datos = read.csv("Cuatro acciones 2020 y COLCAP.csv", sep = ";", dec = ",", header = T)

head(datos)
tail(datos)

precios = datos[, 2:5]
precios = ts(precios)

COLCAP = datos[,6]
COLCAP = ts(COLCAP)

nombres = colnames(precios)
nombres

rendimientos = diff(log(precios))

rendimientos_mercado = diff(log(COLCAP))

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

volatilidad_portafolio = sd(rendimientos_portafolio)
volatilidad_portafolio

Rf = 0.06916 #E.A.
Rf = log(1 + Rf)  #Continua anual
Rf_diario = Rf/250  #Continua diario
Rf_diario

beta = c(1.23765583817092, 1.04762467584509, 0.696424844336778, 0.805687711895736)
beta

beta_portafolio = sum(proporciones*beta)
beta_portafolio

sharpe = (rendimiento_esperado_portafolio - Rf_diario)/volatilidad_portafolio
sharpe

treynor =  (rendimiento_esperado_portafolio - Rf_diario)/beta_portafolio
treynor

jensen = (rendimiento_esperado_portafolio - Rf_diario) - (rendimiento_esperado_mercado - Rf_diario)*beta_portafolio
jensen

sharpe = (rendimiento_esperado_portafolio*250 - Rf)/(volatilidad_portafolio*sqrt(250))
sharpe

treynor =  (rendimiento_esperado_portafolio*250 - Rf)/beta_portafolio
treynor

jensen = (rendimiento_esperado_portafolio*250 - Rf) - (rendimiento_esperado_mercado*250 - Rf)*beta_portafolio
jensen
