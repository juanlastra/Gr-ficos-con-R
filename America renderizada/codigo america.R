
#### Codigo america


## paquetes necesarios
library(giscoR)
library(terra)
library(sf)
library(elevatr)
library(png)
library(rayshader)
library(rnaturalearth)

## carpeta de trabajo


### extraer poligonos

conjunto_sf <- gisco_get_countries(
  region = c(
    "Americas"),
  resolution = "3"
) |> st_union()



### graficar contornos

plot(st_geometry(conjunto_sf))


### grafico base

imagen_tif <- terra::rast(
  "sur_america.tif"
)

colombia <- ne_states(country = "Colombia", returnclass = "sf")

colombia <- sf::st_transform(colombia, crs = crs(imagen_tif))

imagen_tif <- crop(imagen_tif, ext(colombia))

#imagen_tif <- mask(imagen_tif, colombia)

### mostrar imagen tif
terra::plotRGB(imagen_tif)


colombia <- ne_states(country = "Colombia", returnclass = "sf")


## organizar de acuerdo a conjunto_sf
sf_tif_bbox <- terra::ext(
  imagen_tif
) |>
  sf::st_bbox(crs = 3857) |>
  sf::st_as_sfc(crs = 3857) |>
  sf::st_transform(crs = 4326) |>
  sf::st_intersection(colombia)


plot(sf::st_geometry(sf_tif_bbox))



modelo_dem <- elevatr::get_elev_raster(
  locations = sf_tif_bbox |> sf::st_as_sf(),
  z = 5, clip = "bbox"
)



modelo_dem_3857 <- modelo_dem |>
  terra::rast() |>
  terra::project("EPSG:3857")

terra::plot(modelo_dem_3857)


imagen_tif_resampled <- terra::resample(
  x = imagen_tif,
  y = modelo_dem_3857,
  method = "bilinear"
)


img_file <- "imagen_tif_inicial.png"


terra::writeRaster(
  imagen_tif,
  img_file,
  overwrite = T,
  NAflag = 255
)



### imagen creada
imagen <- png::readPNG(
  img_file
)


h <- nrow(modelo_dem_3857)
w <- ncol(modelo_dem_3857)


#### crear una matrix apartir del archivo raster
imagen_matrix <- rayshader::raster_to_matrix(
  modelo_dem_3857
)




imagen_matrix |>
  rayshader::height_shade(
    texture = colorRampPalette(
      c("white", "grey80")
    )(128)
  ) |>
  rayshader::add_overlay(
    imagen,
    alphalayer = 1
  ) |>
  rayshader::plot_3d(
    imagen_matrix,
    zscale = 17,
    solid = F,
    shadow = T,
    shadow_darkness = 1,
    background = "white",
    windowsize = c(
      w / 5, h / 5
    ),
    zoom = .42,
    phi = 89,
    theta = 0
  )


rayshader::render_highquality(
  filename = "Colombia4k.png",
  preview = T,
  interactive = F,
  light = F,
  environment_light = "air_museum_playground_4k.hdr",
  intensity_env = .75,
  rotate_env = 90,
  parallel = T,
  width = w * 1.5,
  height = h * 1.5
)