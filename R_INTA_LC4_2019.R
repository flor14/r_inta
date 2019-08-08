
# web apps, graficos interactivos, mapas en pocas lineas

library(ggplot2)
library(dplyr)

# Elimino los datos hago esto para no usar todos los datos 
# y que no tarde tanto en cargar es solo un ejemplo

diam_1500 <- diamonds %>%
  filter(cut == "Ideal" & price > 15000)

# Realizo un gr�fico con ggplot2 

ggplot(diam_1500)+
  geom_point(aes(x = carat, y = price, color = clarity))

#### PLOTLY: Graficos interactivos ####
# uso la funcion ggplotly() en el gr�fico anterior

library(plotly)

ggplotly(ggplot(diam_1500)+
         geom_point(aes(x = carat, y = price, color = clarity)))

#### MAPA con ggplot2 ####

# bajo datos
mapa <- ggplot2::map_data("world")

# grafico
ggplot(data = mapa)+
  geom_polygon(aes(x = long, y = lat, group = group))+ # capa de mapa
  geom_point(aes(x = -65, y = -33), color = "red", size = 10) # punto

#### SHINY: Web apps con R ####

# NEW FILE > SHINY WEB APP... > 

# Tocar "Run App" en el editor para correr el ejemplo predeterminado


