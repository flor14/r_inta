#Practica de la segunda parte del taller de R para análisis científicos reproducibles
#Este capítulo del libreo R4DS tiene información sobre estas herramientas y
#algunos ejemplos más

#esta libreria me permite importar datos desde R
library(readxl)
#Esta libreria permite realizar acciones de ordenamiento y limpieza de datos
library(tidyverse)


#Descargamos los datos del formulario en formato Excel
#y lo importamos a R
encuesta <- read_excel("D:/CursoRCIRN/Reporte/Data/encuesta.xlsx", 
                       sheet = "Respuestas de formulario 1", 
                       col_names = FALSE,
                       skip = 1)

#En los nombres de las columnas vienen las preguntas
#Como no las podemos importar por inconvenientes en los juegos de caracteres
#Renombramos las variables para que los nombres indiquen su contenido y sean
#cortos y sencillos

encuesta <- encuesta %>%
  rename(Tiempo=1, Asiste=2, Instituto=3, Programa=4, 
         ComoAprendio=5, ComoUsaR=6, RStudio=7, 
         Tidyverse=8, DataFrame=9, PaqueteR=10, 
         GitHub=11, Ggplot2=12, RMarkdown=13, Python=14, 
         Excel=15, Shiny=16, PlataformaComunidad=17, 
         Comentarios=18, Mail=19)

#Vamos a visualizar el set de datos
glimpse(encuesta)


#Vamos a separar la columna del tiempo en dos columnas de fecha y hora
encuesta <- encuesta  %>%
  separate(Tiempo, sep=" ", into= c("Fecha", "Hora"))

#Si analizamos la variable Programa, tenemos como respuesta "un texto con una coma"Si, y me gustaría"
#Vamos a generar una nueva variable donde vamos a quedarnos con el No y el Si como valores
encuesta <- encuesta  %>%
  separate(Programa, sep=",", into= c("Programa", "OtrosPrograma")) %>%
  #Vamos a borrar la segunda columna porque no la vamos a utilizar
  select(-OtrosPrograma) %>%
  #Vamos a reemplazar los valores que no sean Si o No con Otro
  mutate(Programa = case_when(
    # Sintaxis: prueba lógica ~ valor a usar cuando la prueba es VERDADERA
    Programa == "Sí" ~ "Si",
    Programa == "No" ~ "No",
    # cuando ninguno de los anteriores es verdadero
    TRUE ~ "Otros"
  ))
  
#En la variable plataforma comunidad,encontramos dos respuestas relacionadas con Slack, 
# una que tiene un link y la otra que no, asi que vamos a unificar los valores
#También vemos que los valores de Asiste, las palabras si y no están en minúsculas
#Vamos a poner en mayúscula la primera letra

encuesta <- encuesta  %>%
  mutate(PlataformaComunidad = replace(PlataformaComunidad, PlataformaComunidad == "Slack (https://slack.com/intl/es-ar/features)", "Slack"),
         Asiste = case_when(
           # Sintaxis: prueba lógica ~ valor a usar cuando la prueba es VERDADERA
           Asiste == "si" ~ "Si",
           Asiste == "no" ~ "No"
         ))


#Vamos a trabajar solo con las columnas de hacen referencia a las respuestas de las herramientas  

herramientas <- encuesta %>%
  select(8:17)

#Podemos ordenar mejor esta información, colocando las respuestas como casos
#y no como columnas, para eso contamos con las funciones gather y spread
#en la nueva versión de tidyr se llaman pivot_longer y pivot_wider

Herramientas_Pivot <- herramientas %>%
  gather("Herramienta", "Uso") 

#Tenemos una serie de NA, que vamos a retirar del listado
#se puede hacer con gather agregando gather("Herramienta", "Uso" , na.rm = TRUE)

Herramientas_Pivot <- herramientas %>%
  gather("Herramienta", "Uso" , na.rm = TRUE)

#Tambien se pueden filtrar con funciones específicas
Herramientas_Pivot <- Herramientas_Pivot %>%
  drop_na()

#Vamos a utilizar las mismas herramientas para acomodar la variable comoAprendio

#Vamos a separar la columna ComoAprendio que tiene mas de una respuesta en la misma columna
#y nos vamos a quedar solo con esas variables nuevas en el data.frame nuevo llamado comoAprendio
comoAprendio <- encuesta  %>%
  separate(ComoAprendio, sep=",", into= c("Aprendio1", "Aprendio2", "Aprendio3", "Aprendio4", "Aprendio5", "Aprendio6")) %>%
  select("Aprendio1", "Aprendio2", "Aprendio3", "Aprendio4", "Aprendio5", "Aprendio6")

#Otra forma de hacer lo mismo
# comoAprendio <- encuesta  %>%
#   separate(ComoAprendio, sep=",", into=paste("Aprendio", 1:6, sep = "_"))

comoAprendio <- comoAprendio %>%
  gather(key = 'Aprendio', value = 'Herramienta', Aprendio1:Aprendio6) %>%
  drop_na(Herramienta) %>%
  select(Herramienta)
  
