datos = read.csv("Cuatro acciones 2020.csv", sep=";", dec=",", header = T)

head(datos)
tail(datos)

precios = datos[,-1]
precios = ts(precios)

nombres = colnames(precios)
nombres

rendimientos = diff(log(precios))

library(fPortfolio)

frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

getType(portfolioSpec())

getOptimize(portfolioSpec())

frontierPlot(frontera)

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)

weightsPlot(frontera)

colores = qualiPalette(ncol(rendimientos), "Dark2") # Paleta de colores

weightsPlot(frontera, col = colores)

proporciones_frontera = getWeights(frontera)
print(proporciones_frontera)

media_varianza_frontera = frontierPoints(frontera)
print(media_varianza_frontera)

minima_varianza = minvariancePortfolio(as.timeSeries(rendimientos), constraints = "LongOnly")
minima_varianza
