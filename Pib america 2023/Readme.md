# 🌎 Crecimiento del PIB en América – Informe Banco Mundial 2023

Este proyecto muestra un mapa temático con el crecimiento porcentual del Producto Interno Bruto (PIB) en países de América durante el año 2023, según datos del Banco Mundial. La visualización busca facilitar la comprensión espacial del desempeño económico en la región, diferenciando países con crecimiento, estancamiento o contracción económica.

## 📊 Visualización


Leyenda:
🟩 Verde claro: Crecimiento económico positivo.

🟥 Rojo claro: Decrecimiento del PIB.

⬛ Gris: Sin datos disponibles para el país.

Los valores se presentan como etiquetas sobre cada país, con el porcentaje de variación del PIB durante 2023.

## 🛠️ Tecnologías utilizadas
Lenguaje: R

Librerías principales:

ggplot2 – para la visualización del mapa.

sf – para el manejo de datos geoespaciales.

ggrepel – para ubicar etiquetas de texto de forma legible.

dplyr y stringr – para manipulación de datos.

## 📁 Archivos
Codigo.R: script que construye el mapa temático.

graficopibamerica2023.png: gráfico final exportado.

shapefile (no incluido): capa geográfica usada para mapear países de América.

## 🧭 Propósito
El objetivo de este gráfico es facilitar el análisis comparativo del desempeño económico en América, de forma intuitiva y visual. Puede ser útil en reportes económicos, presentaciones académicas o materiales de difusión pública.

## 📌 Notas
Los datos provienen del informe del Banco Mundial 2023.

El mapa incluye un recuadro con países de Centroamérica y el Caribe para mayor claridad visual.