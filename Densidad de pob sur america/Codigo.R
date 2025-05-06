

## carpeta de trabajo

setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Proyectos de investigación")


## paquetes necesarios
library(raster)
library(sf)
library(ggspatial)
library(tidyverse)
library(showtext)
library(rnaturalearth)
library(sf)
library(dplyr)
library(ggspatial)

font_add_google(name = "Paytone One", family = "Paytone One")
showtext.auto() 



# cargar imagen

imagen <- rast("ppp_2020_1km_Aggregated.tif")

## primer recorte
europa <-  raster::extent(-125, -33, -60, 55)


imagen <- crop(imagen, europa)



paises <- c(
  # América del Norte
  "Canada", "United States of America", "Mexico",
  
  # América Central
  "Guatemala", "Belize", "Honduras", "El Salvador", 
  "Nicaragua", "Costa Rica", "Panama",
  
  # Caribe (solo países soberanos)
  "Cuba", "Haiti", "Dominican Republic", 
  "Bahamas", "Jamaica", "Trinidad and Tobago",
  "Barbados", "Grenada", "Saint Lucia", 
  "Saint Vincent and the Grenadines", "Saint Kitts and Nevis",
  "Antigua and Barbuda", "Dominica",
  
  # América del Sur
  "Colombia", "Venezuela", "Ecuador", "Peru", 
  "Brazil", "Bolivia", "Paraguay", "Chile", 
  "Argentina", "Uruguay", "Guyana", "Suriname"
)


america <- ne_states(country = paises, returnclass = "sf")

### resultados
resultados <- extract(imagen, vect(america), fun = mean, na.rm = TRUE)

colnames(resultados) <- c("id", "mean_p_km2")

resultados$name <- america$name

resultados <- na.omit(resultados)

datos <- merge(resultados, america, by = "name")

datos <- datos |> st_as_sf()


### grafico

ggplot(datos, aes(fill = datos$mean_p_km2)) + geom_sf() +
  geom_sf(data = america, inherit.aes = F, fill = NA, col = "black") +
  scale_fill_gradientn(
    colours = scico::scico(5, palette = "vikO"),
    trans = "pseudo_log") +
  coord_sf(xlim = c(-125, -33), ylim = c(-60, 55), expand = F)
