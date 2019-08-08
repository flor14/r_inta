#chequeo si tengo instalados los paquetes necesarios
if(!require(pacman))install.packages("pacman")

#instalo un paquete que no está en CRAN
devtools::install_github('bbc/bbplot')

#Cargo paquetes necesarios para los gráficos
pacman::p_load('dplyr', 'tidyr', 'readxl',
               'ggplot2',  'ggalt',
               'forcats', 'R.utils', 'png', 
               'grid', 'ggpubr', 'scales',
               'bbplot', 'likert')


#Empiezo a graficar
#Vamos a utilizar la información de la encuesta que generamos 
#en la practica anterior, vamos a ver la generación de un 
#gráfico paso a paso

#Paso 1
ggplot(data = encuesta)

#Paso 2
ggplot(data = encuesta, mapping = aes(x = Instituto))

#Paso 3
ggplot(data = encuesta, mapping = aes(x = Instituto)) +
  geom_bar()  

#Paso 4

ggplot(data = encuesta, mapping = aes(x = Instituto, fill=Instituto)) +
  geom_bar()              

#Paso 5
ggplot(data = encuesta, mapping = aes(x = Instituto, fill=Instituto)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  labs(y="Cantidad de personas", x= "Institutos del CNIA")

#Paso 6
ggplot(data = encuesta, mapping = aes(x = Instituto, fill=Instituto)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  labs(y="Cantidad de personas", x= "Institutos del CNIA")+
  labs(title="Taller de R en INTA",
       subtitle = "¿En qué Instituto trabajas?")

#Paso 7
ggplot(data = encuesta, mapping = aes(x = Instituto, fill=Instituto)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  labs(y="Cantidad de personas", x= "Institutos del CNIA")+ 
  labs(title="Taller de R en INTA",
       subtitle = "¿En qué Instituto trabajas?")+
  theme(axis.text.x = element_blank())  

#Paso 8
ggplot(data = encuesta, mapping = aes(x = Instituto, fill=Instituto)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  labs(y="Cantidad de personas", x= "Institutos del CNIA")+ 
  labs(title="Taller de R en INTA",
       subtitle = "¿En qué Instituto trabajas?")+
  theme(axis.text.x = element_blank())  + 
  theme(legend.position="top", legend.text = element_text(size=10, face="bold"),
        legend.title = element_blank())
        

#Vamos a graficar otras variables

#Vamos a utilizar el estilo BBC con la variable Asiste al taller
encuesta %>% 
  drop_na(Asiste) %>%
  ggplot(mapping = aes(x = Asiste, fill=Asiste)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  bbc_style() +
  labs(title="Taller de R en INTA",
       subtitle = "¿Venis al taller?")+
  theme(axis.title = element_text(size = 14), legend.position = "none")  + 
  labs(y="Cantidad de personas")


#Vamos a graficar que Plataforma se prefiere de dos formas:
#Estilo BBC con grafico de barras
encuesta %>% 
  drop_na(PlataformaComunidad) %>%
  ggplot(mapping = aes(x = PlataformaComunidad, fill=PlataformaComunidad)) +
  geom_bar() +
  geom_hline(yintercept = 0, size = 1, colour="#333333")+
  bbc_style() +
  labs(title="Taller de R en INTA",
       subtitle = "¿Qué plataforma preferís para seguir comunicados?")+
  theme(axis.title = element_text(size = 14), axis.text.x = element_blank())  + 
  labs(y="Cantidad de personas")

#Estilo lollipop chart, para lo que tenemos que calcular la cantidad 
#de respuestas (cosa que no es necesaria para el grafico de barras)
encuesta %>% 
  drop_na(PlataformaComunidad) %>%
  group_by(PlataformaComunidad)%>%
  summarise(cantidad=n()) %>%
  ggplot(aes(x=PlataformaComunidad, y=cantidad)) +
  geom_segment(aes(x=PlataformaComunidad, xend=PlataformaComunidad, y=0, yend=cantidad), color="grey") +
  geom_point(color="orange", size=6) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("Plataforma") +
  ylab("Cantidad")+
  labs(title="Taller de R en INTA",
       subtitle = "¿Qué plataforma preferís para seguir comunicados?")

#Cómo aprendió a usar R.

#Vamos a ponerlo en orden ascendente y descendente
#De mayor a menor
comoAprendio %>% 
  group_by(Herramienta)%>%
  summarise(cantidad=n()) %>%
  mutate(CategoriaOrdenada = fct_reorder(Herramienta, cantidad)) %>%
  ggplot(aes(x=CategoriaOrdenada, y=cantidad)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip()+
  xlab("") +
  ylab("Cantidad")+
  labs(title="Taller de R en INTA",
       subtitle = "¿Cómo adquiriste tus conocimientos actuales en programación?")

# De menor a mayor
comoAprendio %>% 
  group_by(Herramienta)%>%
  summarise(cantidad=n()) %>%
  mutate(CategoriaOrdenada = fct_reorder(Herramienta, desc(cantidad))) %>%
  ggplot(aes(x=CategoriaOrdenada, y=cantidad)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() +
  xlab("") +
  ylab("Cantidad")+
  labs(title="Taller de R en INTA",
       subtitle = "¿Cómo adquiriste tus conocimientos actuales en programación?")


#Vamos a realizar un gráfico con Herramientas_Pivot
#puedo utilizar la tabla creada

Herramientas_Pivot %>%
  group_by(Herramienta, Uso) %>%
  summarise(cantidad=n()) %>%
  drop_na() %>%
  ggplot(aes(fill=Uso, y=cantidad, x=Herramienta)) +
  geom_bar( stat="identity") + 
  bbc_style()+
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  labs(title = "Conocimiento de Herramientas") +
  theme(axis.text = element_text(size = 14)) +
  labs(y = "Cantidad de participantes")

#o puedo generar el conjunto de datos y pasarlo a ggplot2 con el pipe

encuesta %>%
  select(8:17) %>% 
  gather("Herramienta", "Uso") %>%
  group_by(Herramienta, Uso) %>%
  summarise(cantidad=n()) %>%
  drop_na() %>%
  ggplot(aes(fill=Uso, y=cantidad, x=Herramienta)) +
  geom_bar( stat="identity") + 
  bbc_style()+
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  labs(title = "Conocimiento de Herramientas") +
  theme(axis.text = element_text(size = 14)) +
  labs(y = "Cantidad de participantes")


