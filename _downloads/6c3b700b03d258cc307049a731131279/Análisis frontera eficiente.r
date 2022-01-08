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

library(fPortfolio)

frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)

proporciones_frontera = getWeights(frontera)
print(proporciones_frontera)

media_varianza_frontera = frontierPoints(frontera)
print(media_varianza_frontera)

Rf = 0.06916 #E.A.
Rf = log(1+(1+ Rf)^(1/250) - 1)  #Continua diaria
Rf

beta = c(1.23765583817092, 1.04762467584509, 0.696424844336778, 0.805687711895736)
print(beta)

beta_portafolios = apply(proporciones_frontera*beta, 1, sum)
print(beta_portafolios)

CAPM_portafolios = Rf + beta_portafolios*(rendimiento_esperado_mercado - Rf)
print(CAPM_portafolios)

h = 1 - media_varianza_frontera[,1]/sum(volatilidades)
print(h)

sharpe_portafolios = (media_varianza_frontera[,2] - Rf)/media_varianza_frontera[,1]
print(sharpe_portafolios)

treynor_portafolios =  (media_varianza_frontera[,2] - Rf)/beta_portafolios
print(treynor_portafolios)

jensen_portafolios = (media_varianza_frontera[,2] - Rf) - (rendimiento_esperado_mercado - Rf)*beta_portafolios
print(jensen_portafolios)
