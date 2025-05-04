# 🌄 Visualización 3D del Aconcagua con Rayshader
Este proyecto genera una imagen 3D realista del Monte Aconcagua (Argentina), la montaña más alta de América, utilizando datos satelitales y de elevación, procesados en R mediante rayshader y otros paquetes geoespaciales.


## 📂 Estructura del Proyecto

Aconcagua/
├── Aconcagua.tif              # Imagen satelital (tiff) del área
├── Aconcagua.png              # Imagen final renderizada
├── Aconcaguaimagen.png        # Imagen reproyectada y resampleada
├── Codigo Renderizar imagen.R# Código R para el procesamiento
└── README.md                  # Este archivo


## 🛠️ Paquetes usados
rayshader

terra, sf, raster, elevatr

giscoR, rnaturalearth, png

##  🚀 Cómo ejecutarlo
Ubica tu carpeta de trabajo en la línea setwd(...).

Asegúrate de tener el archivo Aconcagua.tif en la carpeta.

Ejecuta Codigo Renderizar imagen.R en R (Requiere R >= 4.0).

La imagen final Aconcagua.png será generada automáticamente.

## 🛰️ Fuente de los datos
Imagen satelital: SentinelHub

Modelo de elevación: elevatr con datos USGS

Límites geográficos: Natural Earth a través de rnaturalearth

## 📸 Resultado
Una visualización detallada y fotorrealista en 3D del Aconcagua, usando una combinación de texturizado con imágenes reales y datos de elevación digital (DEM).