install.packages("usethis")
library(usethis)
install.packages("sf")
library(sf)
install.packages("ggplot2")
library(ggplot2)
install.packages("ggspatial")
library(ggspatial)

#getting files
download.file(url = "https://geo.fbds.org.br/SP/EMBU_DAS_ARTES/USO/SP_3515004_USO.dbf", 
              destfile = "SP_3515004_USO.dbf", mode = "wb")
download.file(url = "http://geo.fbds.org.br/SP/EMBU_DAS_ARTES/USO/SP_3515004_USO.prj", 
              destfile = "SP_3515004_USO.prj", mode = "wb")
download.file(url = "http://geo.fbds.org.br/SP/EMBU_DAS_ARTES/USO/SP_3515004_USO.shp", 
              destfile = "SP_3515004_USO.shp", mode = "wb")
download.file(url = "http://geo.fbds.org.br/SP/EMBU_DAS_ARTES/USO/SP_3515004_USO.shx", 
              destfile = "SP_3515004_USO.shx", mode = "wb")


# import geospatial data --------------------------------------------------
# land use
polygons_land_use <- sf::st_read("SP_3515004_USO.shp")
polygons_land_use
plot(polygons_land_use$geometry)

# embu das artes limit
embu_das_artes_limit <- geobr::read_municipality(code_muni = 3515004, year = 2022)
embu_das_artes_limit
plot(embu_das_artes_limit$geom, col = "gray")

# export
sf::write_sf(embu_das_artes_limit, "embu_das_artes_limit.shp")



# maps --------------------------------------------------------------------
# embu das artes limit
ggplot() +
  geom_sf(data = embu_das_artes_limit)

# embu das artes limit land use with colors

map <- ggplot() +
  geom_sf(data = polygons_land_use, aes(fill = CLASSE_USO), color = NA) +
  geom_sf(data = embu_das_artes_limit, color = "black", fill = NA) +
  coord_sf(datum = sf::st_crs(polygons_land_use)) +
  annotation_scale(location = "br", width_hint = .3) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         style = north_arrow_fancy_orienteering) +
  labs(title = "Embu das Artes",
       subtitle = "Uso do Solo",
       caption = "Fonte: FBDS") +
  theme(
         plot.title = element_text(hjust = 0.5),
         plot.subtitle = element_text(hjust = 0.5)
       )

map 

