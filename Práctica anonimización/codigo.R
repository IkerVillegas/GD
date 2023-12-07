#Carga de paquetes necesarios
library(dplyr)
library(readxl)

#Carga de los datos a un dataset
data <- read_excel("C:/Users/Lenovo/Desktop/Master UAM/GD/Práctica anonimización/data.xlsx")

#Tratamiento de los datos
data<-select(data,-starts_with(c("cod_","lat_","lon_")))
data<-data[which(data$des_genero=="Hombre" & data$des_unidad_responsable=="Departamento de Ingeniería Informática" ),]

#Inferencia bloque de coherencia 1
data_1 <- select(data,c(des_universidad,anio))
#Inferencia bloque de coherencia 2
data_2 <- select(data,c(des_pais_nacionalidad,des_continente_nacionalidad, des_agregacion_paises_nacionalidad))
count(data_2,des_pais_nacionalidad)
#Inferencia bloque de coherencia 3
data_3 <- select(data,c(des_comunidad_residencia,des_provincia_residencia,des_municipio_residencia))
count(data_3,des_municipio_residencia)
#Inferencia bloque de coherencia 4
data_4 <- select(data,anio_nacimiento)
count(data_4,anio_nacimiento)
#Inferencia bloque de coherencia 5
data_5 <- select(data,c(des_tipo_personal,des_categoria_cuerpo_escala,des_tipo_contrato,des_dedicacion,num_horas_semanales_tiempo_parcial,des_situacion_administrativa))
#Inferencia bloque de coherencia 6
data_6 <- select(data, ind_cargo_remunerado)
count(data_6, ind_cargo_remunerado)
#Inferencia bloque de coherencia 7
data_7 <- select(data, c(des_titulo_doctorado,des_pais_doctorado,des_continente_doctorado,des_agregacion_paises_doctorado,des_universidad_doctorado,anio_lectura_tesis,anio_expedicion_titulo_doctor,des_mencion_europea))
data_7 <- data_7[which(data_7$des_titulo_doctorado == "Uno" & data_7$des_universidad_doctorado == "Universidad Autónoma de Madrid" & data_7$anio_lectura_tesis==2000),]
#Inferencia bloque de coherencia 8
data_8 <- select(data, c(des_tipo_unidad_responsable,des_area_conocimiento))
data_8 <- data_8[which(data_8$des_tipo_unidad_responsable == "Departamento" & data_8$des_area_conocimiento == "Lenguajes y Sistemas Informáticos"),]
#Inferencia bloque de coherencia 9
data_9 <- select(data, c(anio_incorporacion_ap,anio_incorpora_cuerpo_docente,num_trienios,num_quinquenios,num_sexenios))
data_9 <- data_9[which(data_9$anio_incorporacion_ap == 1995 & data_9$anio_incorpora_cuerpo_docente == 2001),]
#Inferencia bloque de coherencia 10
data_10 <- select(data, num_tesis)
count(data_10, num_tesis)
#Inferencia bloque de coherencia 11
data_11 <- select(data, ind_investigador_principal)
count(data_11, ind_investigador_principal)

