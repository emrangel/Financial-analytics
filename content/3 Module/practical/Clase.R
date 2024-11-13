##Analítica Financiera. Tutorial Momentos Estadísticos Series Financiaras
##Instalaciones necesarias
library(fBasics)
library(PerformanceAnalytics)
library(xts)
library(quantmod)
library(ggplot2)
library(tseries)
library(dygraphs)
options(warn = - 1) 

##--------Obtención Datos (Recordar primer tutorial que empleamos una función muy similar):
start<-format(as.Date("2018-02-01"),"%Y-%m-%d")
end<-format(as.Date("2020-12-31"),"%Y-%m-%d")

#--------- Función para bajar precios y generar rendimientos:
rend<-function(simbolo,start,end) {
  ##---------Obtener precios de yahoo finance:
  datos<-getSymbols(simbolo, src = "yahoo", auto.assign = FALSE)
  ##---------eliminar datos faltantes:
  datos<-na.omit(datos)
  ##--------Mantener el precio de interés:
  datos<-datos[,4]
  ##--------Rendimientos simples:
  rend<-periodReturn(datos, period="daily", subset=paste(c(start, end), "::", sep=""), type='arithmetic')
  #--------Para hacer dtos accesibles  GLobal ENv:
  assign(simbolo, rend, envir = .GlobalEnv)
}

#--------Llamar la función para cada activo particular:
rend("FB", start, end)
str(FB)

rend("FORD", start, end)
str(FORD)
## Gráfico:
rends<-merge.xts(FB, FORD)
colnames(rends)<-c("FB", "FORD")
dygraph(rends, main = "FB & FORD Rendimientos") %>%
  dyAxis("y", label = "Rend %") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set1"))

###########################
#----------Estadisticas básicas 
basicStats(FB) ## Resumen estadísticos
mean(FB)
var(FB)
stdev(FB) # Desv Std
t.test(FB)  # Prueba que H0: mean return = 0
s3=skewness(FB)  #Sesgo
T=length(FB) # tamaño muestra
t3=s3/sqrt(6/T) # Prueba de sesgo
t3
pp=2*pt(abs(t3), T-1, lower=FALSE) # Calcula p-valor, si p valor > alfa, no se rechaza nula y por tanto sesgo de cero 
pp
s4=kurtosis(FB)
s4
t4=s4/sqrt(24/T) # Prueba de curtosis, en exceso
t4
pv=2*(1-pnorm(t4)) # p-valor,  si p valor > alfa, no se rechaza nula y por tanto exceso de curtosis de cero 
pv
normalTest(FB,method='jb') # Prueba Jaque Bera, H0: Normal


###################################################################################################
##---------- Segundo Activo
###Estadisticas básicas 
basicStats(FORD) ## Resumen estadísticos
mean(FORD)
var(FORD)
stdev(FORD) # Desv Std
t.test(FORD)  # Prueba que H0: mean return = 0
s3=skewness(FORD)  #Sesgo
T=length(FORD) # tamaño muestra
t3=s3/sqrt(6/T) # Prueba de sesgo
t3
pp=2*(1-pnorm(abs(t3))) 
pp
s4=kurtosis(FORD)
s4
t4=s4/sqrt(24/T) 
t4
pv=2*(1-pnorm(t4)) 
pv
normalTest(FORD,method='jb') 

##----------Gráfica Densidad ambos activos

library(PerformanceAnalytics)
par(mfrow=c(1,2))
chart.Histogram(FB, methods = c("add.normal", "add.density"), colorset = c("gray", "blue", "red"))
legend("topright", legend = c("Hist-FB" ,"FB dist","dnorm FB"), col=c("gray", "blue", "red"), lty=1, cex = 0.7)
chart.Histogram(FORD, methods = c("add.normal", "add.density"), colorset = c("gray", "blue", "red"))
legend("topright", legend = c("Hist-FORD" ,"FORD dist","dnorm FORD"), col=c("gray", "blue", "red"), lty=1, cex = 0.7)


