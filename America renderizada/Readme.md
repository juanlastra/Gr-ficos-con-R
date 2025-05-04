# 🌎 Mapa 3D de Sudamérica con sombreado realista

Este proyecto en R genera un mapa en 3D de Sudamérica combinando datos de elevación con una imagen topográfica base, utilizando rayshader. El resultado es una visualización geográfica realista que resalta la cordillera de los Andes y otros relieves del continente.

## 🛠️ Tecnologías y paquetes utilizados

rayshader: Para la creación del modelo 3D y renderizado con sombreado.

giscoR: Para obtener geometrías de países en América.

terra: Para manipulación raster y geoespacial.

sf: Para manipulación de objetos espaciales vectoriales.

elevatr: Para descarga de datos DEM (modelo digital de elevación).

rnaturalearth: Para obtener polígonos administrativos de Colombia.

png: Para cargar y superponer imágenes PNG.

## 📁 Archivos importantes
codigo america.R: Script principal en R que construye el modelo 3D.

imagen_sur_america4k.png: Imagen final generada (vista 3D de Sudamérica).

sur_america.tif: Imagen base raster que sirve como capa visual (no incluida por tamaño).

Colombia4k.png: Archivo de salida renderizado por rayshader.

## 🔧 Pasos principales del script
Se descargan y unen los países de América con giscoR.

Se recorta la imagen base (sur_america.tif) a la región deseada.

Se obtiene el modelo de elevación con elevatr.

Se ajusta la proyección y se alinea el raster de elevación con la imagen.

Se genera una matriz de elevación y se combina con la imagen.

Se visualiza en 3D y se exporta la imagen con calidad 4K.

## 🖼️ Resultado
El resultado final es una imagen detallada en 3D de Sudamérica, con los Andes en alto relieve y sombreado ambiental que resalta el terreno.