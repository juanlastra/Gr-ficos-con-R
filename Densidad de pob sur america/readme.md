# 🗺️ Densidad de Población en Sur América
Este proyecto visualiza la densidad de población en América del Sur utilizando datos rasterizados de población mundial a resolución de 1 km. La visualización se presenta en forma de un mapa coloreado, lo que permite observar de manera intuitiva las zonas más densamente pobladas del continente.

## 🧠 Objetivo
Explorar cómo se distribuye la población en América del Sur a nivel geográfico. El proyecto busca responder preguntas como: ¿dónde se concentran las mayores densidades de población? ¿Qué regiones presentan baja densidad? ¿Qué patrones espaciales emergen?

## 📁 Archivos
graficodensidadamerica.png: Imagen del mapa generado que muestra la densidad de población en América del Sur.

Codigo.R: Script en R que carga, recorta y visualiza los datos de población en formato raster para los países del continente americano.

Base de datos población: Una base de datos obtenida de la pagina web: https://search.earthdata.nasa.gov/search sobre los datos de población mundiales

## 🛠️ Tecnologías utilizadas
raster: Para el manejo de datos de población en formato raster.

sf y rnaturalearth: Para la manipulación de datos espaciales vectoriales y fronteras políticas.

ggplot2 y ggspatial: Para crear y personalizar el mapa.

scico: Para aplicar paletas de color perceptualmente uniformes.

showtext: Para usar fuentes personalizadas (como Paytone One) en los gráficos.

## 📈 Resultados
El mapa permite observar claramente las zonas más densamente pobladas del continente, como:

El litoral brasileño, especialmente alrededor de São Paulo y Río de Janeiro.

El eje andino en Colombia, Perú y Ecuador.

El corredor Buenos Aires–Montevideo en el sur del continente.

A su vez, revela grandes extensiones con baja densidad de población como la Amazonía, los Andes australes y la Patagonia.

