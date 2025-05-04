
# Grafico en ggplot2 sobre regiones en america

Este proyecto presenta un análisis espacial del índice de vegetación NDVI promedio en regiones subnacionales de América para el año 2025. El NDVI (Normalized Difference Vegetation Index) es un indicador satelital que permite medir la densidad y salud de la vegetación en una zona determinada, con valores que van de -1 (agua o nubes) a 1 (selva muy densa).

## Descripción del gráfico
El mapa generado muestra el valor promedio del NDVI por región administrativa en América, utilizando una escala de color que varía de marrón (bajo NDVI) a azul (alto NDVI). La clasificación es la siguiente:

-1 a 0: Agua / Nubes

0 a 0.2: Suelo desnudo

0.2 a 0.4: Vegetación rala

0.4 a 0.6: Pastizal

0.6 a 0.8: Cultivos / media

0.8 a 1: Vegetación densa

1: Selva / muy densa


## Datos y procesamiento
Los datos provienen de una imagen satelital TIFF del índice NDVI mensual (marzo 2025).

Se utilizó una máscara geográfica para recortar la región de América.

La media del NDVI se calculó por región administrativa (subnacional), utilizando shapefiles del paquete rnaturalearth.

El procesamiento y la visualización se realizaron en R, con paquetes como sf, terra, ggplot2, scico y otros.

## Uso
Este proyecto es útil para visualizar la distribución espacial de la vegetación en América y puede ser base para análisis ambientales, agrícolas o de cambio climático.

