
setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Proyectos de investigación/Horas de trabajo")

## paquetes necesarios

library(tidyverse)
library(gifski)
library(gganimate)
library(ggflags)
library(WDI)
library(OECD)
library(countrycode)
library(ggthemes)
library(scales)
library(sf)
library(rnaturalearth)

# Descargar datos de PIB per cápita
pib_per_capita <- WDI(
  country = "all",                # Todos los países
  indicator = "NY.GDP.PCAP.CD",   # PIB per cápita (USD)
  start = 2010,                   # Año de inicio
  end = 2023                      # Año final
)


pib_per_capita <- na.omit(pib_per_capita)


# horas trabajadas por país

horastrabajo <- readxl::read_excel("Horas de trabajo.xlsx", range = "B6:Q46")

horastrabajo <- horastrabajo[-c(1:3, 7, 40), -2]

colnames(horastrabajo) <- c("Pais", colnames(horastrabajo)[-1])


isos <- c(
  "AUS", "AUT", "BEL", "CHL", "COL", "CRI", "CZE", "DNK", "EST", "FIN",
  "FRA", "DEU", "GRC", "HUN", "ISL", "IRL", "ISR", "ITA", "LVA", "LTU",
  "LUX", "MEX", "NLD", "NZL", "NOR", "POL", "PRT", "SVK", "SVN", "ESP",
  "SWE", "CHE", "TUR", "GBR", "USA"
)

horastrabajo$Iso3 <- isos

horastrabajo <- horastrabajo |> pivot_longer(cols = colnames(horastrabajo)[c(-1, -16)],
                                             values_to = "Horas de trabajo",
                                             names_to = "Año")


horastrabajo$Año <- as.numeric(horastrabajo$Año)

pib_per_capita <- pib_per_capita[pib_per_capita$iso3c %in% isos, ]

## unir datos
pib_per_capita <- pib_per_capita[, -2]

colnames(pib_per_capita) <- c("Pais", "Iso3", "Año", "Pib percapita" )

pib_per_capita$`Pib percapita` <- round(pib_per_capita$`Pib percapita`, 2) 


datos <- merge(horastrabajo, pib_per_capita[, -1],
               by = c("Iso3", "Año"))


datos$Iso2 <- tolower(countrycode(datos$Pais,
                                  origin = "country.name",
                                  destination = "iso2c"))


datos$Año <- as.character(datos$Año)

grafico <- ggplot(datos, aes(datos$`Horas de trabajo`,
                  datos$`Pib percapita`)) + geom_point() + 
  geom_flag(aes(country = datos$Iso2), size = 14) +
  theme_solarized_2() +
  labs(title  = "Relación entre PIB per capita y horas de trabajo en el año: {closest_state}",
       y = "PIB per cápita", x= "Horas de trabajo semanal") + 
  scale_y_continuous(labels = label_number(scale = 0.001, suffix = "k"),
                     breaks = seq(0, 150000, 25000)) +
  theme(plot.title = element_text(size = 16,
                                  hjust = 0.5, colour = "black"),
        axis.title = element_text(size = 14, colour = "black"),
        axis.text = element_text(size = 12, colour = "black")) +
  transition_states(datos$Año, 
                    transition_length = 2, state_length = 0)



animate(
  grafico,
  nframes = 750,
  fps = 10,
  end_pause = 50,
  width = 600,
  height = 500
)


## mapa 

# Descarga el shapefile de los países del mundo
world <- ne_countries(scale = "medium", returnclass = "sf")

paises <- world[world$iso_a3 %in% datos$Iso3, ]

Europa <- paises[paises$continent == "Europe", ]

Europa <- Europa[, 45]

colnames(Europa) <- c("Iso3", "geometry")

Europa <- merge(Europa, datos, by = "Iso3")

## grafico europa 

ggplot(Europa, aes(fill = Europa$`Horas de trabajo`,
                   label = Europa$`Horas de trabajo` |> round(2))) + geom_sf() + 
  coord_sf(xlim = c(-22, 33), ylim = c(35, 70)) + 
  theme_solarized_2() +
  scale_fill_viridis_c() +
  geom_sf_text() +
  labs(
    fill = "Horas de trabajo",
    title = "Horas de trabajo en Europa en el año: {closest_state}",
    caption = "Fuente: Datos simulados"  # Puedes personalizarlo
  ) +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  ) + 
  transition_states(Europa$Año, 
                    transition_length = 2, state_length = 0)

  

## información del 2023

datos <- datos[datos$Año == "2023", ]


grafico2 <- ggplot(datos, aes(datos$`Horas de trabajo`,
                  datos$`Pib percapita`)) + geom_point() + 
  geom_flag(aes(country = datos$Iso2), size = 14) +
  theme_solarized_2() +
  labs(title  = "Relación entre PIB per capita y horas de trabajo en el año 2023",
       y = "PIB per cápita", x= "Horas de trabajo semanal",
       caption = "Fuente: OCDE") + 
  scale_y_continuous(labels = label_number(scale = 0.001, suffix = "k"),
                     breaks = seq(0, 150000, 25000)) +
  theme(plot.title = element_text(size = 16,
                                  hjust = 0.5, colour = "black"),
        axis.title = element_text(size = 14, colour = "black"),
        axis.text = element_text(size = 12, colour = "black"))


ggsave("grafico2023.png", plot = grafico2,
       width = 8.5, height = 6, dpi = 300)
