#### Ejercicio Analítica Financiera: Tipos de Datos
library(dygraphs)
library(xts)
library(quantmod)
library(dplyr)
options(warn = - 1)  
######################################################
###Primero, generemos una función que ayude a simplificar los tipos de datos que deseamos de la fuente de 
#información financiera.
#En este ejemplo, los datos de Cierre y Volúmenes, que dependerán del simbolo o ticker 
#del activo y a partir de qué año se consultan:
##Datos:

.year = 2015
# start<-format(as.Date(paste0(.year,"-01-01"),"%Y-%m-%d")) ## cambiar
start <- "2015-01-01"

# end<-format(as.Date("2020-07-01"),"%Y-%m-%d")

end <- "2020-12-31"

precios_volumenes <- function(simbolo)
{
  # Obtener precios stocks de Yahoo Finance
  datos <- getSymbols(simbolo, auto.assign = FALSE, from=start, to=end)
  # Eliminando valores faltantes
  datos <- na.omit(datos)
  # Mantenemos columnas con Precios de Cierre y Volúmenes, columnas 4 y 5 de cada stock:
  datos <- datos[, 5:6]
  # Para hacer los datos accesibles, asignamos a Global Environment:
  assign(simbolo, datos, envir = .GlobalEnv)
}

# Lista de símbolos a procesar
simbolos <- c("IBM", "ORCL", "INTC", "MSFT")

# Aplicamos la función a cada símbolo en la lista
lapply(simbolos, precios_volumenes)

datos_xts <- mget(simbolos)

PyV <- do.call(merge, datos_xts)

# Juntamos los datos y renombramos las columnas:
# PyV <- merge.xts()

colnames(PyV)
# colnames(PyV) <- c("Amazon P.Cierre","Amazon Vol", "Netflix P.Cierre","Netflix Vol", 
                   # "IBM P.Cierre", "IBM Vol", "SP500 P.Cierre", "SP500 Vol")

##Serie De Tiempo:
# Podemos generar una gráfica interactiva las variables, en este caso de los precios:

# Seleccionar solo las columnas que contienen "Adjusted" en su nombre
adjusted_cols <- grep("Adjusted", colnames(PyV))
Volume_cols <- grep("Volume", colnames(PyV))

# Crear el gráfico dygraph usando solo las columnas "Adjusted"
Precios <- dygraph(PyV[, c(2,4,6,8)], main = paste0("Precios-", paste(simbolos, collapse = ", "))) %>%
  dyAxis("y", label = "Precios") %>%
  dyRangeSelector(dateWindow = c(start, end)) %>%
  dyOptions(colors = RColorBrewer::brewer.pal(length(adjusted_cols), "Set1")) 

Precios

# Podemos ver los 5 ultimos datos redondeando hasta 3 decimales:
round(tail(PyV, n = 5), 3)

#########################################################################################################
# Ejemplo de Panel Data, generemos una list de objetos dygraphs, y para imprimirlos usamos htmltools:
library(dygraphs)
library(htmltools)

dy_graficos <- list(
  dygraphs::dygraph(PyV[,c(2,4,6,8)], main = paste0("Precios-", paste(simbolos, collapse = ", "))), 
  dygraphs::dygraph(PyV[,c(1,3,5,7)], main = paste0("Volumnenes-", paste(simbolos, collapse = ", ")))
  )

# Representemos los objetos dygraphs usando htmltools
htmltools::browsable(htmltools::tagList(dy_graficos))


#-------------------------------------------------------------------
#-------Datos tipo Transversales o Cross Sectional
# Seleccionaremos los datos de AMZN del 2014 y del 2020. 
# Empecemos seleccionando los aqos 2014 de AMZN que es la 1ra columna.

MSFT_2015<-subset(PyV[,8], index(PyV)>="2015-01-01"& index(PyV)<="2015-12-31")
MSFT_2015[c(1:5, nrow(MSFT_2015))]
#Para el aqo 2020:
MSFT_2020<-subset(PyV[,8], index(PyV)>="2020-01-01"& index(PyV)<="2020-12-31")
MSFT_2020[c(1:5, nrow(MSFT_2020))]

# Ahora, podemos tambien visualizarlo, elegimos un histograma  
par(mfrow=c(2,1))

hist(MSFT_2015, freq = FALSE, col="yellow", border="blue",main= "Dansidades de los Precios MSFT en 2015", xlab = "Precios Cierre")
lines(density(MSFT_2015), lwd = 2, col = 'red')
hist(MSFT_2020, freq = FALSE, col="blue", border="blue",main= "Dansidades de los Precios MSFT en 2020", xlab = "Precios Cierre")
lines(density(MSFT_2020), lwd = 2, col = 'red')
