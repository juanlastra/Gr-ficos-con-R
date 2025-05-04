# 📊 Relación entre PIB per cápita y Horas de Trabajo Semanal (2023)

Este proyecto visualiza la relación entre las horas de trabajo semanal y el PIB per cápita para distintos países en el año 2023. Cada punto en el gráfico está representado por la bandera del país correspondiente, permitiendo una lectura visual rápida e intuitiva.

## 🧠 Objetivo
Explorar la posible relación entre el desarrollo económico (medido por el PIB per cápita) y la carga laboral promedio semanal. ¿Trabajan más los países con menor PIB? ¿Se observa una correlación negativa?

## 📁 Archivos
grafico2023.png: Imagen del gráfico generado.

Horas.R: Script que contiene los datos base (PIB y horas trabajadas por país).

codigo america.R: Código fuente que genera un gráfico similar para países americanos (referencia adicional).

## 🛠️ Tecnologías utilizadas
ggplot2: Para construir el gráfico.

ggimage: Para incrustar las banderas en lugar de puntos.

countrycode: Para mapear nombres de países a códigos ISO.

dplyr: Para manipulación de datos.

## 📈 Resultados
El gráfico muestra una clara tendencia: a mayor número de horas trabajadas, menor es el PIB per cápita, lo cual sugiere que más trabajo no siempre se traduce en mayor riqueza. Destacan casos como:

Países Bajos y Suiza: alto PIB y pocas horas.

Colombia y México: muchas horas y bajo PIB.

