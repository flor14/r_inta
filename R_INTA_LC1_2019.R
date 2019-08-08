### LIVE CODING

# 1- Explicar RStudio

# Tiene 4 paneles,
# a la izq abajo la consola de R (corro código con control + Enter)
# por ejemplo:

# suma
2+2

# a la izq arriba el editor (uso de # para silenciar una linea)
# a la derecha arriba, Environment (donde puedo ver lo que 
# guardo cuando asigno una variable)
# a la derecha abajo puedo ver los paquetes instalados ("Packages"),
# la ayuda ("Help"), la pestaña para visualizar gráficos ("Plots"),
# y puedo visualizar los archivos que hay en la carpeta del proyecto 
# en ("Files")

# 2- Abrir un proyecto

# Ventajas: 1 - Pestaña "files" me permite ver los archivos de la 
# carpeta desde RStudio
# 2 - Todo se guarda en la misma carpeta
# 3 - Uso ubicaciones relativas de los archivos. Me permite poder correr
# el código cuando llevo la carpeta de un lugar a otro
# 4 - Parte derecha superior de RStudio tiene un menu desplegable que me 
# permite cambiar de proyecto o cerrarlo 


# 3- Abro un script y lo guardo
# FILE > NEW FILE > R SCRIPT
# Muestro que el codigo se puede guardar y que se ve en la pestaña "File"
# Asigno una variable

suma <- 2+2

# 4- Instalar un paquete y cargar la library

install.packages("dplyr")
library(dplyr)


# 5- importar archivos de Excel con RStudio ("Import Dataset")
# 6- importar archivos de Excel con R (como código). Ver panel
# code preview de la pestaña que aparece cuando quiero importar desde
# RStudio

# ventaja de escribir el código: 
# a - queda registrada la ubicacion del archivo
# b - puedo subir muchos archivos

# 7- Generar una dataframe en R con 
data.frame()

# Uso de View(). Asignarle un nombre y guardar en el Environment

datos <- data.frame(x = c(1, 4, 5), y = c(9, 2, 6))
View(datos)

# 8- Uso de la ayuda. ¿Qué son los vectores que conforman al data.frame?

?c()

#En la ayuda de c() hay vectores de ejemplo que corren bien
c(1,7:9)
c(1:5, 10.5, "next")

# 9 - Los guardo en el environment y obligo que lea al ultimo
# como numero

vector <- c(1:5, 10.5, "next")
as.numeric(vector)

# que ocurre? Como los vectores forman dataframes,
# es importante entender esta Warning! porque puede afectar 
# el tipo de datos en las columnas de mi dataset y
# al querer usar una funcion no lograr que anden.
# Ejemplo usando base de datos "muestreo dic 2012" 
