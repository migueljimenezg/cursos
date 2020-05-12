datos = read.csv("Bono 2020.csv", sep = ";", dec = ",")

precio = 110.315

tasas = datos[,-1]

variaciones = diff(tasas)/100

vol_tasas = sd(variaciones)
vol_tasas

hist(variaciones,breaks=40,col="gray",xlab="Variaciones",ylab="Frecuencia",main="",freq=F,ylim=c(0,1500))
curve(dnorm(x,mean=0,sd=vol_tasas),add=T,lwd=3,col="darkgreen")
lines(density(variaciones),lwd=3,col="darkblue")
legend("topleft",c("Distribución Normal","Distribución empírica"),lty=c(1,1),col=c("darkgreen","darkblue"),bty="n",lwd=c(3,3))

NC = 0.95

library(jrvFinance)

duracion_modificada = bond.durations(settle = "2020-03-31", mature = "2022-05-04", coupon = 0.07, freq = 1,yield = 0.0495, convention = "ACT/ACT", modified = T, redemption_value = 100)
duracion_modificada

VaR_bono_parametrico = precio*duracion_modificada*vol_tasas*qnorm(NC)/100
VaR_bono_parametrico

VaR_bono_parametrico*500000000

VaR_bono_no_parametrico = precio*duracion_modificada*quantile(variaciones,NC)/100
VaR_bono_no_parametrico

VaR_bono_no_parametrico*500000000

hist(variaciones, breaks = 40, col = "gray", xlab = "Variaciones", ylab = "Frecuencia", main = "", freq = F, ylim = c(0,1500))
curve(dnorm(x, mean = 0, sd = vol_tasas), add = T, lwd = 3, col = "darkgreen")
lines(density(variaciones), lwd = 3, col = "darkblue")
abline(v = VaR_bono_parametrico, lwd = 3, col = "darkred")
abline(v = VaR_bono_no_parametrico, lwd = 3, col = "purple")
legend("topleft", c("Distribución Normal", "Distribución empírica", "Var no paramétrico", "VaR paramétrico"), lty = c(1,1,1,1), col = c("darkgreen", "darkblue", "purple", "darkred"), bty = "n", lwd = c(3,3,3,3))
