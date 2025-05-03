

## carpeta de trabajo

setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Proyectos de investigación/Bosques")

## paquetes necesarios

library(sf)
library(tidyverse)
library(rnaturalearth)
library(ggtext)
library(scico)
library(ggspatial)
library(legendry)
library(ggpmisc)
library(terra)


# cargar imagen

imagen <- rast("MOD_NDVI_M_2025-03-01_rgb_3600x1800.TIFF")

## primer recorte
america <- raster::extent(-125, -33, -60, 55)


imagen <- crop(imagen, america)

plot(imagen)

### cargar imagen tiff


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

colnames(resultados) <- c("id", "NDVI")

resultados$name <- america$name

resultados <- resultados[resultados$NDVI != 255, ]

resultados$NDVI <- (resultados$NDVI - 127) / 128

resultados <- na.omit(resultados)

datos <- merge(resultados, america, by = "name")

datos <- datos |> st_as_sf()



grafico <- ggplot(datos, aes(fill = datos$NDVI)) + geom_sf() +
  geom_sf(data = america, inherit.aes = F, fill = NA, col = "black") +
  scale_fill_gradientn(
    colours = scico::scico(14, palette = "navia"),
    breaks = seq(-0.8, 0.8, by = 0.2),
    name = "") +
  coord_sf(xlim = c(-125, -33), ylim = c(-60, 55), expand = F) +
  labs(title = "Índice promedio NDVI por región en America en 2025", 
       x = "", y = "") +
  annotate("text", x = -120, y = -42, label = 
             "Clasificación del índice NDVI:\n
           -1 a 0: Agua / Nubes\n
           0 a 0.2: Suelo desnudo\n
           0.2 a 0.4: Vegetación rala\n
           0.4 a 0.6: Pastizal\n
           0.6 a 0.8: Cultivos / media\n
           0.8 a 1: Vegetación densa\n
           1: Selva / muy densa", 
           size = 3.8, hjust = 0, vjust = 0, 
           family = "serif", fontface = "italic", 
           color = "black", 
           lineheight = 0.8) +
  guides(fill = guide_colorbar(
    barwidth = unit(170, "pt"),
    barheight = unit(8, "pt"))) +
  theme_bw() + theme(plot.title = element_text(size = 15, hjust = 0.5), 
                     axis.title = element_blank(),
                     legend.position = c(0.28, 0.08),
                     legend.box.margin = margin(),
                     legend.margin = margin(),
                     legend.direction = "horizontal")


ggsave("graficodensidadvegetación.png", plot = grafico,
       width = 6, height = 7, dpi = 300)
