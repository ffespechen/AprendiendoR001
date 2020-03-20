library(tidyverse)

# Usando datos del Banco Mundial "Indicadores del Desarrollo Mundial"
# https://databank.bancomundial.org/source/world-development-indicators/
# Descargados en archivo CSV

bm <- read.csv("WB_indicadores_desarrollo_Data.csv")
names(bm)

View(bm)

# Wrangling Data

bm_organizado <- bm %>% pivot_longer(cols = c("X2010..YR2010.":"X2019..YR2019."), names_to = "anio", values_to = "valores")

# Convirtiendo datos (los valores se asumieron como factores)

bm_organizado$valores <- as.numeric(levels(bm_organizado$valores))[bm_organizado$valores]
class(bm_organizado$valores)


