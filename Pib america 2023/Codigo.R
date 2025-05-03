
setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Proyectos de investigación/Crecimiento del PIB/")


### graficos de caminos

library(sf)
library(tidyverse)
library(readxl)
library(rnaturalearth)
library(ggrepel)
library(ggthemes)
library(cowplot)

## cargar datos

datos <- read_excel("Crecimiento del PIB.xls", sheet = "Data",
                    range = "A4:BP270")

datos <- datos[, -c(3:67)]

colnames(datos) <- c("Country", "code country", "Año 2023")

datos$`Año 2023` <- datos$`Año 2023` |> round(2)

# paises de america


paisesamerica <- c(
  "ARG", "BLZ", "BOL", "BRA", "CAN", "CHL", "COL", "CRI", "CUB", "DOM", 
  "ECU", "GRD", "GTM", "GUY", "HND", "HTI", "JAM", "MEX", "NIC", "PAN", 
  "PER", "PRY", "SLV", "SUR", "TTO", "URY", "USA", "VEN"
)

datos <- datos[datos$`code country` %in% paisesamerica, ]

## grafico 

datos$Country <- c(
  "Argentina", "Belize", "Bolivia", "Brazil", "Canada", "Chile", 
  "Colombia", "Costa Rica", "Cuba", "Dominican Rep.", "Ecuador", 
  "Grenada", "Guatemala", "Guyana", "Honduras", "Haiti", "Jamaica", 
  "Mexico", "Nicaragua", "Panama", "Peru", "Paraguay", "El Salvador", 
  "Suriname", "Trinidad and Tobago", "Uruguay", "United States", 
  "Venezuela"
)


# Obtener los datos de los países seleccionados
mundo <- ne_countries(scale = "medium", returnclass = "sf")

# Filtrar los países de América
america <- mundo[mundo$name %in% datos$Country, ]

america <- america[, c(9, 18)]

colnames(america) <- c("admin", "Country", "geometry")

america <- merge(america, datos, by = "Country")

america[15, 4] <- NA

## grafico

graficobase <- ggplot(america, aes(fill = `Año 2023`)) + geom_sf() +
  coord_sf(xlim = c(-120, 0), ylim = c(-50, 60)) +
  geom_label_repel(
    data = america[america$Country %in% c("Argentina", "Bolivia", "Brazil", "Canada", "Chile", 
                                          "Colombia", "Ecuador", 
                                          "Mexico", "Paraguay", "Peru", 
                                          "Suriname", "United States", 
                                          "Uruguay")
                   , ],
    aes(label = paste(Country, `Año 2023`, "%"),
        geometry = geometry),
    stat = "sf_coordinates",
    min.segment.length = 0, size = 5.8) +
  labs(x= "", y = "", title = "Crecimiento % del PIB en América informe Banco Mundial 2023") +
  scale_fill_gradient2(low = "red", high = "green", mid = "#FBECEA") + 
  theme_bw() +
  theme(legend.position = "none",
        plot.title = element_text(size =  24, hjust = 0.5,
                                  margin = margin(b = 10, t = 10)),
        plot.margin = margin(),
        axis.title = element_blank(),
        axis.text = element_text(size = 14))


### datos de centro america

paises_c_america <- c("Belize", "Costa Rica", "Cuba", "Dominican Rep.", "Grenada", 
                      "Guatemala", "Honduras", "Haiti", "Jamaica", 
                      "Nicaragua", "Panama", "El Salvador", "Trinidad and Tobago")


centro_america <- mundo[mundo$name %in% paises_c_america, ]

# Filtrar los países de centro América

centro_america <- centro_america[, c(9, 18)]

colnames(centro_america) <- c("admin", "Country", "geometry")

centro_america <- merge(centro_america, datos, by = "Country")


### grafico de centro america

centroamerica <- ggplot(centro_america, aes(fill = `Año 2023`)) + geom_sf() +
  geom_label_repel(
    data = centro_america,
    aes(label = paste(`Año 2023`, "%"),
        geometry = geometry),
    stat = "sf_coordinates",
    min.segment.length = 0, size = 4.8) +
  scale_fill_gradient2(low = "red", high = "green", mid = "#FBECEA") + 
  labs(x = "", y = "") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.margin = margin(),
        axis.title = element_blank())


graficofinal <- ggdraw() +
  draw_plot(graficobase) +
  draw_plot(centroamerica, x = 0.5, y = 0.33, width = 0.42, height = 0.8)



ggsave("graficopibamerica2023.png", plot = graficofinal,
       width = 11.5, height = 10, dpi = 300)
