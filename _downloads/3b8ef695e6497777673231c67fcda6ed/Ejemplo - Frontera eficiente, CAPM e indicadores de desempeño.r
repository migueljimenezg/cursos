library(quantmod)
library(tseries)

NFLX = get.hist.quote(instrument = "NFLX", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "AdjClose", compression  = "m")

AAPL = get.hist.quote(instrument = "AAPL", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "AdjClose", compression  = "m")

ABT = get.hist.quote(instrument = "ABT", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "AdjClose", compression  = "m")

WMT = get.hist.quote(instrument = "WMT", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "AdjClose", compression  = "m")

JNJ = get.hist.quote(instrument = "JNJ", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "AdjClose", compression  = "m")

SP = get.hist.quote(instrument = "^GSPC", start = as.Date("2015-04-01"), end = as.Date("2020-04-30"), quote = "Close", compression  = "m")

precios = merge(NFLX, AAPL, ABT, WMT, JNJ)
head(precios)
tail(precios)

dim(precios)

nombres = c("NFLX", "AAPL", "ABT", "WMT", "JNJ")
nombres

colnames(precios) = nombres # Se renombran las columnas

plot(precios)

rendimientos = diff(log(precios))

rendimientos_mercado = diff(log(SP))

numero_rendimientos = nrow(rendimientos)
numero_rendimientos

rendimientos_esperados = apply(rendimientos, 2, mean)
print(rendimientos_esperados)

rendimiento_esperado_mercado = mean(rendimientos_mercado)
rendimiento_esperado_mercado

volatilidades = apply(rendimientos, 2, sd)
print(volatilidades)

plot(volatilidades, rendimientos_esperados, pch = 19, cex = 2, xlab = "Volatilidad", ylab = "Rendimiento", col = c(1:5))
legend("topleft", colnames(precios), pch = 19, bty = "n", cex = 1.5, col = c(1:5))

correlacion = cor(rendimientos)
print(correlacion)

covarianzas = cov(rendimientos)
print(covarianzas)

rendimientos_esperados_anual = rendimientos_esperados*12
print(rendimientos_esperados_anual)

volatilidades_anual = volatilidades*sqrt(12)
print(volatilidades_anual)

rendimiento_esperado_mercado_anual = rendimiento_esperado_mercado*12
rendimiento_esperado_mercado_anual

library(fPortfolio)

frontera = portfolioFrontier(as.timeSeries(rendimientos), constraints = "longOnly")

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)

weightsPlot(frontera)

minima_varianza = minvariancePortfolio(as.timeSeries(rendimientos), constraints = "LongOnly")
minima_varianza

portafolio_minima_varianza = c(0.1039, 0, 0.1346, 0.3385, 0.4229)

rendimiento_minima_varianza = sum(portafolio_minima_varianza*rendimientos_esperados)
rendimiento_minima_varianza

volatilidad_minima_varianza = sqrt(sum(portafolio_minima_varianza%*%covarianzas*t(portafolio_minima_varianza)))
volatilidad_minima_varianza

Rf = 0.00618 #Anual.
Rf = log(1 + Rf)  #Continua anual
Rf_mensual = log(1 + Rf/12)  #Continua mensual
Rf_mensual

especificaciones = portfolioSpec()
  `setRiskFreeRate<-`(especificaciones, Rf_mensual)

frontierPlot(frontera, cex = 2, pch = 19)
monteCarloPoints(frontera, col = "blue", mcSteps = 500, cex = 0.5, pch = 19)
minvariancePoints(frontera, col = "darkred", pch = 19, cex = 2)
equalWeightsPoints(frontera, col = "darkgreen", pch = 19, cex = 2)
tangencyLines(frontera)
tangencyPoints(frontera, col = "green", cex = 2, pch = 19)

portafolio_tangente = tangencyPortfolio(as.timeSeries(rendimientos), spec = especificaciones, constraints = "LongOnly")
portafolio_tangente

portafolio_tangente = c(0.2698, 0.0382, 0.1245, 0.2911, 0.2764)

rendimiento_tangente = sum(portafolio_tangente*rendimientos_esperados)
rendimiento_tangente

volatilidad_tangente = sqrt(sum(portafolio_tangente%*%covarianzas*t(portafolio_tangente)))
volatilidad_tangente

h_minima_varianza = 1 - volatilidad_minima_varianza/sum(volatilidades[1]+volatilidades[3:5])
h_minima_varianza

h_tangente = 1 - volatilidad_tangente/sum(volatilidades)
h_tangente

proporciones_CML = c(0.20, 0.80)

rendimiento_CML = sum(proporciones_CML*c(Rf_mensual, rendimiento_tangente))
rendimiento_CML

volatilidad_CML = proporciones_CML[2]*volatilidad_tangente
volatilidad_CML

h_CML = 1 - volatilidad_CML/sum(volatilidades)
h_CML

rendimientos_2 = diff(precios)/precios[-numero_rendimientos,]

rendimientos_mercado_2 = diff(SP)/SP[-numero_rendimientos]

colnames(rendimientos_2) = nombres # Se renombran las columnas
head(rendimientos_2)
tail(rendimientos_2)

head(rendimientos_mercado_2)
tail(rendimientos_mercado_2)

regresion = lm(rendimientos_2 ~ rendimientos_mercado_2)
beta = regresion$coefficients[2,]
print(beta)

cor(rendimientos_2, rendimientos_mercado_2)

beta_minima_varianza = sum(portafolio_minima_varianza*beta)
beta_minima_varianza

CAPM_minima_varianza = Rf + beta_minima_varianza*(rendimiento_esperado_mercado_anual - Rf)
CAPM_minima_varianza

beta_tangente = sum(portafolio_tangente*beta)
beta_tangente

CAPM_tangente = Rf + beta_tangente*(rendimiento_esperado_mercado_anual - Rf)
CAPM_tangente

beta_CML = proporciones_CML[2]*beta_tangente
beta_CML

CAPM_CML = Rf + beta_CML*(rendimiento_esperado_mercado_anual - Rf)
CAPM_CML

sharpe_minima_varianza = (rendimiento_minima_varianza*12 - Rf)/(volatilidad_minima_varianza*sqrt(12))
sharpe_minima_varianza

treynor_minima_varianza =  (rendimiento_minima_varianza*12 - Rf)/beta_minima_varianza
treynor_minima_varianza

jensen_minima_varianza = (rendimiento_minima_varianza*12 - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_minima_varianza
jensen_minima_varianza

sharpe_tangente = (rendimiento_tangente*12 - Rf)/(volatilidad_tangente*sqrt(12))
sharpe_tangente

treynor_tangente =  (rendimiento_tangente*12 - Rf)/beta_tangente
treynor_tangente

jensen_tangente = (rendimiento_tangente*12 - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_tangente
jensen_tangente

sharpe_CML = (rendimiento_CML*12 - Rf)/(volatilidad_CML*sqrt(12))
sharpe_CML

treynor_CML =  (rendimiento_CML*12 - Rf)/beta_CML
treynor_CML

jensen_CML = (rendimiento_CML*12 - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_CML
jensen_CML

sharpe_minima_varianza_CAPM = (CAPM_minima_varianza - Rf)/(volatilidad_minima_varianza*sqrt(12))
sharpe_minima_varianza_CAPM

treynor_minima_varianza_CAPM =  (CAPM_minima_varianza - Rf)/beta_minima_varianza
treynor_minima_varianza_CAPM

jensen_minima_varianza_CAPM = (CAPM_minima_varianza - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_minima_varianza
jensen_minima_varianza_CAPM

sharpe_tangente_CAPM = (CAPM_tangente - Rf)/(volatilidad_tangente*sqrt(12))
sharpe_tangente_CAPM

treynor_tangente_CAPM =  (CAPM_tangente - Rf)/beta_tangente
treynor_tangente_CAPM

jensen_tangente_CAPM = (CAPM_tangente - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_tangente
jensen_tangente_CAPM

sharpe_CML_CAPM = (CAPM_CML - Rf)/(volatilidad_CML*sqrt(12))
sharpe_CML_CAPM

treynor_CML_CAPM =  (CAPM_CML - Rf)/beta_CML
treynor_CML_CAPM

jensen_CML_CAPM = (CAPM_CML - Rf) - (rendimiento_esperado_mercado_anual - Rf)*beta_CML
jensen_CML_CAPM
