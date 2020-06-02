datos = read.csv("Cuatro acciones 2020.csv", sep=";", dec=",", header = T)

head(datos)
tail(datos)

precios = datos[,-1]
precios = ts(precios)

nombres = colnames(precios)
nombres

rendimientos = diff(log(precios))

rendimientos_esperados = apply(rendimientos, 2, mean)
print(rendimientos_esperados)

library(fPortfolio)

frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)

colores = qualiPalette(ncol(rendimientos), "Dark2") # Paleta de colores

weightsPlot(frontera, col = colores)

media_varianza_frontera = frontierPoints(frontera)
print(media_varianza_frontera)

Rf = 0.00027 #Continua diaria

sharpe = (media_varianza_frontera[,2] - Rf)/media_varianza_frontera[,1]
print(sharpe)

max(sharpe)

portafolio_sharpe = tail(media_varianza_frontera, 1)
print(portafolio_sharpe)

proporciones_activo_riesgoso = seq(0, 1, 0.05)
proporciones_activo_riesgoso

CML = Rf + (portafolio_sharpe[2] - Rf)/(portafolio_sharpe[1])*proporciones_activo_riesgoso*portafolio_sharpe[1]
print(CML)

frontierPlot(frontera, cex = 2, pch = 19, xlim = c(0, 0.03), ylim = c(-0.0005, 0.0007))
lines(proporciones_activo_riesgoso*portafolio_sharpe[1], CML, col = "darkgreen", lwd = 3)

especificaciones = portfolioSpec()
  `setRiskFreeRate<-`(especificaciones, Rf)

frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly", spec = especificaciones)

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)
tangencyLines(frontera)
tangencyPoints(frontera, col = "green", cex = 2, pch = 19)

portafolio_tangente = tangencyPortfolio(as.timeSeries(rendimientos), spec = especificaciones, constraints = "LongOnly")
portafolio_tangente
