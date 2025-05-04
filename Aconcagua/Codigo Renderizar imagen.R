

## carpeta de trabajo

setwd("C:/Users/Juan Lastra/Desktop/Programación/R/Proyectos/Imagenes impresionantes/Aconcagua/")



## paquetes necesarios
library(giscoR)
library(terra)
library(sf)
library(elevatr)
library(png)
library(rayshader)
library(raster)
library(rnaturalearth)


## imagen tif

monte <- rast("Aconcagua.tif")


# Paso 1: Obtener los lC-mites de Italia
Argentina <- ne_states(country = "Argentina", returnclass = "sf")


# Visualizar los lC-mites de Sicilia
plot(st_geometry(Argentina))

### filtrar por tiff

sf_tif_bbox <- terra::ext(
  monte
) |>
  sf::st_bbox(crs = 3857) |>
  sf::st_as_sfc(crs = 3857) |>
  sf::st_transform(crs = 4326) |>
  sf::st_intersection(Argentina) 


plot(sf_tif_bbox)

sf_tif_bbox <- sf_tif_bbox |> st_as_sf()

## corregir tipo de columna

sf_tif_bbox <- st_cast(sf_tif_bbox$x, "MULTIPOLYGON")

modelo_dem <- elevatr::get_elev_raster(
  locations = sf_tif_bbox |> st_as_sf(),
  z = 12, clip = "locations"
)

## cambiar la proyeccion

monte <- project(monte, "EPSG:4326")

imagen_tif_resampled <- terra::resample(
  x = monte,
  y = modelo_dem |> rast(),
  method = "bilinear"
)


img_file <- "Aconcaguaimagen.png"


terra::writeRaster(
  imagen_tif_resampled,
  img_file,
  overwrite = T,
  NAflag = 255
)



### imagen creada
imagen <- png::readPNG(
  img_file
)





# Paso 6: Convertir DEM a matriz para rayshader
elmat <- raster_to_matrix(modelo_dem)



elmat |>  height_shade(
  texture = colorRampPalette(
    c("white", "grey80")
  )(128)
)  |>
  add_overlay(
    imagen,
    alphalayer = 1
  ) |>
  plot_3d(elmat, zscale = 8,
          theta = -8.4138199 , phi = 15.7649348, 
          windowsize = c(1000, 800), zoom = 0.5568377,
          fov = 0,
          background = "#666460")


#render_camera()


render_snapshot(title_text = "Montaña Aconcagua, Argentina (6962 Metros) | Imagery: SentinelHub",
                title_bar_color = "#666460", title_color = "white",
                title_bar_alpha = 1, text_size = 40,
                clear=TRUE, filename = "Aconcagua.png", samples = 1000,
                width = 1200, height = 500)
