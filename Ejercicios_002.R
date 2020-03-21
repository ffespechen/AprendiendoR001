library(tidyverse)
atencion_ciudadano <- read.csv("http://bitsandbricks.github.io/data/gcba_suaci_barrios.csv")

str(atencion_ciudadano)

levels(atencion_ciudadano$BARRIO)

barrios_comunas <- read.csv("http://bitsandbricks.github.io/data/barrios_comunas.csv")

atencion_ciudadano <- left_join(atencion_ciudadano, barrios_comunas)

write.csv(atencion_ciudadano, "atencion_ciudadano.csv", row.names = FALSE)

contactos_por_comuna <- atencion_ciudadano %>%
  group_by(COMUNA) %>%
  summarise(miles_contactos = sum(total)/1000)

habitantes <- read.csv("http://bitsandbricks.github.io/data/gcba_pob_comunas_17.csv")

habitantes

atencion_ciudadano <- left_join(atencion_ciudadano, habitantes)

contactos_por_comuna <- left_join(contactos_por_comuna, habitantes)

ggplot(contactos_por_comuna) +
  geom_point(aes(x=POBLACION, y=miles_contactos))

ggplot(contactos_por_comuna) +
  geom_label(aes(x=POBLACION, y=miles_contactos, label = factor(COMUNA)))

ggplot(contactos_por_comuna) + 
  geom_point(aes(x=POBLACION, y=miles_contactos, size=miles_contactos))
