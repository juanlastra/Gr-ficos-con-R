
# carpeta de trabajo

setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Proyectos de investigación/Homocidios/")

### paquetes necesarios

library(sf)
library(tidyverse)
library(rnaturalearth)
library(ggtext)
library(scico)
library(ggspatial)
library(legendry)
library(ggpmisc)


### tema

theme_fancy_map <- function() {
  theme_void(base_family = "IBM Plex Sans") +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.13, size = rel(1.4)),
      plot.subtitle = element_text(hjust = 0.13, size = rel(1.1)),
      plot.caption = element_text(hjust = 0.13, size = rel(0.8), color = "grey50"),
    )
}


municipios <- read_sf("co_2018_MGN_MPIO_POLITICO.geojson")

municipios <- municipios[, c(3, 5, 6, 8)]

colnames(municipios) <- c("Municipio", "Area",  "Codigo municipio", "Departamento",
                          colnames(municipios)[5])

datos <- readxl::read_excel("Homicidio Intensional enero a diciembre.xlsx",
                            range = "A10:H11022")

datos$`CODIGO DANE` <- substr(datos$`CODIGO DANE`, 1, 5)

datos <- aggregate(datos$CANTIDAD, list(datos$DEPARTAMENTO,
                                        datos$MUNICIPIO, datos$`CODIGO DANE`), sum)

colnames(datos) <- c("Departamento", "Municipios", "Codigo municipio", "Homocidios")


datos_mapa <- merge(municipios, datos, by = "Codigo municipio", all.x = T)

datos_mapa$tasa_homicidios_km <- (datos_mapa$Homocidios / datos_mapa$Area)

### convertir en puntos
datos_mapa <- datos_mapa |> 
  st_point_on_surface()

### mapa de colombia

colombia <- ne_states(country = "Colombia", returnclass = "sf")

## lugares con mas homicidios

homicidios <- datos_mapa[, c(5, 6,3, 7, 9)] |> st_drop_geometry()

homicidios <- homicidios %>% arrange(tasa_homicidios_km |> desc()) |> head(30)

colnames(homicidios) <- c("Departamento", "Municipio", "Area en km2", 
                          "Homicidios", "Hom. por km2")

homicidios$`Hom. por km2` <- round(homicidios$`Hom. por km2`, 2)

homicidios[homicidios == "NORTE DE SANTANDER"] <- "N. DE SANTANDER"
homicidios[homicidios == "Santander de Quilichao"] <- "S. de Quilichao"

mapa_base <- ggplot() +
  geom_sf(data = colombia, fill = "#f4f5f0")+
  geom_sf(
    data = datos_mapa, 
    aes(size = datos_mapa$Homocidios, fill = datos_mapa$tasa_homicidios_km), 
    pch = 21, color = "white", stroke = 0.25, alpha = 0.5
  ) + theme_light() +
  scale_fill_stepsn(
    colours = scico::scico(11, palette = "vik"),
    guide = guide_colorbar(direction = "horizontal", title.position = "top", title.hjust = 0.5)
  ) +
  scale_size_continuous(
    range = c(1, 18), labels = scales::label_comma(), 
    breaks = c(100, 500,1200),
    guide = guide_circles(
      text_position = "right",
      override.aes = list(
        fill = "grey30", alpha = 0.5
      )
    )
  ) + labs(title = "Densidad de homicidios en Colombia (homicidios/km²), 2024",
           size = "Numero de homicidios", fill = "(Homicidios por km²)",
           subtitle = "Fuente: Estadísticas de la Policía Nacional de Colombia, año 2024") +
  coord_sf(xlim = c(-80, -55),ylim = c(-5, 12), expand = T) +
  
  annotation_scale(location = "bl",
                   pad_x = unit(0.4, "in"),  # Mueve en X (hacia la derecha)
                   pad_y = unit(0.8, "in"),
                   width_hint = 0.2) +
  annotation_north_arrow(location = "bl",
                         pad_x = unit(0.6, "in"),  # Mueve en X (hacia la derecha)
    pad_y = unit(1.1, "in"),
    style = north_arrow_fancy_orienteering()) +   # Mueve en Y (hacia arriba))+
  
  annotate(geom = "table",
           x = -52,
           y = 12,
           label = list(homicidios)) +
  
  theme(
    legend.margin = margin(0, 0, 0, 0, "pt"),
    legendry.legend.key.margin = margin(0, 5, 0, 0, "pt"),
    legend.ticks = element_line(colour = "black", linetype = "22"),
    legend.position = "inside",
    legend.position.inside = c(0.45, 0.85),
    legend.text = element_text(size = rel(0.70)),
    legend.title = element_text(hjust = 0.5, face = "bold", size = rel(0.7), margin = margin(b = 3)),
    plot.subtitle = element_text(hjust = 0.12),
    legend.title.position = "bottom",
    
    plot.title = element_text(size = 18, hjust = 0.5, margin = margin(t = 10, b = 5)),
    axis.text = element_text(size = 14),
    axis.title.y  = element_blank(),
    plot.margin = margin(), 
    axis.ticks = element_blank()
  )


ggsave("HomocidiosColombia.png", plot = mapa_base,
       width = 12, height = 7.8, dpi = 300)

