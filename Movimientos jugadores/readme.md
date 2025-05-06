# ⚽ Análisis de Pases - Jugadores Destacados en la Copa América 2024
Este proyecto visualiza los patrones de pase de seis jugadores clave (tres de Argentina y tres de Colombia) durante un partido de la Copa América 2024. Utilizando datos proporcionados por StatsBomb, se grafican los pases exitosos en un campo de juego, permitiendo interpretar visualmente las zonas de influencia y estilo de juego de cada jugador.

## 🧠 Objetivo
Analizar y comparar la distribución y dirección de los pases entre jugadores creativos y ofensivos de Argentina y Colombia. ¿Desde dónde distribuyen el juego? ¿Qué zonas del campo dominan? ¿Quién genera más ocasiones de gol?

## 📁 Archivos
Pases.png: Gráfico combinado con los mapas de pase de seis jugadores.

Jugadores.R: Script en R que descarga, filtra y visualiza los datos de pase desde la API pública de StatsBomb.

🛠️ Tecnologías utilizadas
StatsBombR: Para acceder a los datos abiertos de la Copa América 2024.

SBpitch: Para generar representaciones de campos de fútbol.

ggplot2, patchwork, ggimage: Para construir, combinar y personalizar las visualizaciones.

dplyr: Para manipulación de datos.

## 📈 Resultados
La visualización muestra, entre otros:

Messi: Distribución central y hacia la derecha, con algunos pases claves (asistencias esperadas).

Di María: Participación intensa por las bandas, con pases largos cruzados.

Enzo Fernández: Gran actividad en la mitad del campo, distribución multidireccional.

James y Quintero: Dominio del último tercio ofensivo, muchos pases hacia zonas de remate.

Luis Díaz: Participación ofensiva intensa por izquierda, con tendencia hacia el centro del área.

Este tipo de análisis visual permite a analistas, entrenadores y aficionados comprender mejor las decisiones y estilos de juego de cada futbolista.