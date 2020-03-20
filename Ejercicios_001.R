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

bm_organizado %>% filter(`país.Code`=="ARG" & `serie.Code`=="SP.POP.GROW") %>%
  ggplot() + 
  geom_col(aes(x=anio, y=valores, fill=anio)) +
  coord_flip()

bm_organizado <- separate(bm_organizado, col=anio, into = c("anio.Code", "anio"), sep=c("YR") )

# Limpiando datos (Año)
for( ind in 2010:2019){
  bm_organizado$anio[bm_organizado$anio== paste(as.character(ind), ".", sep="")] <- ind
}

# Mejorando el Gráfico

bm_organizado %>% filter(`país.Code`=="ARG" & `serie.Code`=="SP.POP.GROW") %>%
  ggplot() + 
  geom_col(aes(x=anio, y=valores, fill=anio)) +
  labs(title = "Crecimiento de la Población, ARGENTINA", subtitle = "(% anual)", x="Ano", y="%") +
  coord_flip() 

# Armando Gráficos Comparativos

bm_organizado %>% filter(`país.Code`%in% c("ARG", "BRA", "RUS", "SAU") & `serie.Code`=="SP.POP.TOTL" & !is.na(valores)) %>%
  ggplot(aes(x=anio, y=valores, fill=`país.Code` )) + 
  geom_col(position = "dodge") +
  labs(title = "Población Total 2010-2019", subtitle = "Datos Banco Mundial", x="Año", y="Población")
