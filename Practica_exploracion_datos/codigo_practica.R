#Cargamos los paquetes que vamos a utilizar
require(dplyr)
require(gplots)
require(qgraph)

## A)
#Leemos los datos desde la direcci?n de enlace web proporcionada, y los almacenamos en una lista
data<-read.csv(url("http://cardsorting.net/tutorials/25.csv"))


## B)
#Borramos las columnas que no vamos a necesitar de nuestro conjunto de datos
data<-select(data,-c('Uniqid','Startdate','Starttime','Endtime','QID','Comment'))


## C)
#Para poder trabajar con mayor comodidad declaramos una variable que contenga la misma informaci?n
#que data pero solo de caracteres num?ricos
data_numeric <- select(data, -c("Category"))

#Método 1: inicializamos vector
v_data_0 <- NULL
for (i in c(1:ncol(data_numeric))) {
  v_data_0 <- c(v_data_0,data_numeric[,i])
}
#Método 2:
v_data<-as.integer(unlist(data_numeric))

#Realizamos el dibujo del histograma
histograma<-hist(v_data,main="Frecuencias de aparición",xlab="Respuestas",ylab="Frecuencias")
#Numero de ceros
histograma$counts[1]
#Numero de unos
histograma$counts[20]

## D)
#Visualizacion matriz de similitud
#Obtenemos la matriz de correlaciones
data_correlation <-cor(data_numeric)
dev.off()
#Sacamos por pantalla el mapa de calor
heatmap.2(data_correlation, col=colorRampPalette(c("blue","cornsilk","#458B74"))(40*40),
           trace="none", dendrogram='none', key="true",cexRow = 0.65,cexCol = 0.65)

## E)
#Dibujamos el grafo que representa las relaciones que hay entre las tarjetas
qgraph(data_correlation,layout="spring",vsize = 7.5, theme = "Reddit",node.width = 0.75,color = "orange",details = TRUE,border.color = "red",title="Card graph",label.color = "red",labels =colnames(data_numeric))


## F)
# Solo tendran el valor uno las tarjetas relacionadas consigo mismo por lo que si restamos por 
# la matriz unidad, nos dar? los m?ximos de las tarjetas m?s relacionadas entre s? efectivamente
max(data_correlation-diag(40))
# Ahora queremos saber a que relaciones pertenecen estos maximos 
MaxInd <-  data.frame(which(data_correlation== max(data_correlation-diag(40)),arr.ind = TRUE))
VectorInd <- rownames(data_correlation)
MaxCorr <- paste(VectorInd[MaxInd$row],VectorInd[MaxInd$col],sep=" y ")

