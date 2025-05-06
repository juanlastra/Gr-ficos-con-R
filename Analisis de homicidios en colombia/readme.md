# Densidad de Homicidios en Colombia (2024)
Este proyecto visualiza la distribución espacial de los homicidios en Colombia durante el año 2024. A través de un mapa temático con símbolos proporcionales, se muestra tanto el número total de homicidios por municipio como la densidad de homicidios por kilómetro cuadrado.

## 🧠 Objetivo
Explorar la intensidad y concentración espacial de los homicidios en Colombia a nivel municipal. ¿En qué municipios se cometen más homicidios? ¿Existen zonas con tasas desproporcionadas respecto a su tamaño? ¿Qué regiones destacan por su alta densidad de violencia letal?

## 📁 Archivos
HomocidiosColombia.png: Mapa generado con la distribución y densidad de homicidios por municipio en Colombia.

Codigo homicidios.R: Script completo en R que limpia, integra y visualiza los datos espaciales y estadísticos.

Base de datos homicidio intencional: Obtenida de los datos de la policia en el siguiente link: https://www.policia.gov.co/estadistica-delictiva

## 🛠️ Tecnologías utilizadas
sf y rnaturalearth: Para manejar geometrías espaciales de municipios y fronteras.

ggplot2, ggtext, ggspatial, legendry: Para personalizar y enriquecer el mapa.

scico: Para una escala cromática continua y perceptualmente efectiva.

ggpmisc: Para incluir tablas directamente dentro del gráfico.

readxl: Para cargar los datos de homicidios desde una hoja de cálculo.

## 📈 Resultados
El mapa revela importantes hallazgos, entre ellos:

Soledad (Atlántico) y Barranquilla muestran las mayores tasas de homicidio por km².

Grandes ciudades como Bogotá, Cali, y Medellín tienen altos números absolutos de homicidios, pero su densidad es menor por su gran extensión territorial.

Municipios más pequeños como Puerto Tejada y Guachené también destacan por su elevada densidad de homicidios, a pesar de su tamaño reducido.

La tabla incluida resalta los 30 municipios con mayor densidad de homicidios, lo cual facilita una lectura rápida de los casos más críticos.