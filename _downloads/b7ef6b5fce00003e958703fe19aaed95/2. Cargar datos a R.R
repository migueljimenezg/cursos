datos=read.csv("COLCAP.csv", dec = ",", header =T, sep= ";")

precios = datos[,2]
precios

precios = datos[,-1]
precios

precios = datos$COLCAP
precios

plot(precios, t = "l", col = "darkblue", lty = 1, lwd = 1, xlab = "Tiempo", ylab = "Precio", main="Índice COLCAP")
legend("topright", "COLCAP", col="darkblue", lty=1, lwd=1,bty="n" )

fechas = as.Date(datos[,1], format= "%d/%m/%Y")

plot(fechas,precios, t = "l", col = "darkblue", lty = 1, lwd = 1, xlab = "Tiempo", ylab = "Precio", main="Índice COLCAP")
legend("topright", "COLCAP", col="darkblue", lty=1, lwd=1,bty="n" )

precios = ts(precios)

plot(precios)

precios = ts(precios, start= c(2008,4), frequency = 244)

plot(precios)

####################################################################
datos2=read.csv("Cuatro acciones 2020.csv", header = T, sep=";", dec=",")

precios=datos2[,-1]
precios

plot(precios[,1], t = "l", col = "darkblue", lty = 1, lwd = 1, xlab = "Tiempo", ylab = "Precio", main="Acciones", ylim = c(min(precios),max(precios)))
lines(precios[,2], col="darkgreen")
lines(precios[,3], col="25")
lines(precios[,4], col= "gray")

fechas = as.Date(datos2[,1], format= "%d/%m/%Y")

plot(fechas,precios[,1], t = "l", col = "darkblue", lty = 1, lwd = 1, xlab = "Tiempo", ylab = "Precio", main="Acciones", ylim = c(min(precios),max(precios)))
lines(fechas,precios[,2], col="darkgreen")
lines(fechas,precios[,3], col="25")
lines(fechas,precios[,4], col= "gray")

precios=ts(precios)

plot(precios)




