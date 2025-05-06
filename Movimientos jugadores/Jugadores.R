

## instalar libreria
# devtools::install_github("statsbomb/StatsBombR")
#devtools::install_github("FCrSTATS/SBpitch")

library(StatsBombR)
library(SBpitch)
library(patchwork)
library(ggimage)

## eventos
Comp <- FreeCompetitions()

Comp <- Comp[Comp$competition_name == "Copa America", ]

partidos <- FreeMatches(Comp)


final <- get.matchFree(partidos[1,])

final <- allclean(final)

## extraer datos

datos <- head(final)

player_shots = final %>%
  group_by(player.name, player.id) %>% 
  summarise(shots = sum(type.name=="Shot", na.rm = TRUE)) #


## Argentina
messi <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "Lionel Andrés Messi Cuccittini")

dimaria <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "Ángel Fabián Di María Hernández")

enzofernandez <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "Enzo Fernandez")


## Colombia
james <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "James David Rodríguez Rubio")


juanQuintero <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "Juan Fernando Quintero Paniagua")


luidiaz <- final %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & 
           player.name == "Luis Fernando Díaz Marulanda")


### grafico argentina 

plot_messi <- create_Pitch() +
  geom_segment(data = messi, aes(x = location.x, y = location.y,
                                  xend = pass.end_location.x,
                                  yend = pass.end_location.y),
               lineend = "round", size = 0.5, 
               colour = ifelse(!is.na(messi$pass.shot_assist) == T,
                               "blue", "grey"), arrow = 
                 arrow(length = unit(0.18, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de Lionel Messi",
  subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )


plot_dimaria <- create_Pitch() +
  geom_segment(data = dimaria, aes(x = location.x, y = location.y,
                                 xend = pass.end_location.x,
                                 yend = pass.end_location.y),
               lineend = "round", size = 0.5, 
               colour = "blue", arrow = 
                 arrow(length = unit(0.07, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de Ángel Di María",
       subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )



plot_enzo <- create_Pitch() +
  geom_segment(data = enzofernandez, aes(x = location.x, y = location.y,
                                   xend = pass.end_location.x,
                                   yend = pass.end_location.y),
               lineend = "round", size = 0.5, 
               colour = "blue", arrow = 
                 arrow(length = unit(0.07, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de Enzo Fernandez",
       subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )


plot_james <-  create_Pitch() +
  geom_segment(data = james, aes(x = location.x, y = location.y,
                                 xend = pass.end_location.x,
                                 yend = pass.end_location.y),
               lineend = "round", 
               size = ifelse(!is.na(james$pass.shot_assist) == T,
                                                1.4, 0.8), 
               colour = ifelse(!is.na(james$pass.shot_assist) == T,
                               "red", "grey"), arrow = 
                 arrow(length = unit(0.07, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de James Rodríguez que terminaron en un tiro al arco",
       subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )



plot_juanQuintero <- create_Pitch() +
  geom_segment(data = juanQuintero, aes(x = location.x, y = location.y,
                                 xend = pass.end_location.x,
                                 yend = pass.end_location.y),
               lineend = "round", size = 0.5, 
               colour = "red", arrow = 
                 arrow(length = unit(0.07, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de Juan Quintero",
       subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )


plot_luisdiaz <- create_Pitch() +
  geom_segment(data = luidiaz, aes(x = location.x, y = location.y,
                                        xend = pass.end_location.x,
                                        yend = pass.end_location.y),
               lineend = "round", size = 0.5, 
               colour = "red", arrow = 
                 arrow(length = unit(0.07, "inches"),
                       ends = "last", type = "open")) + #3
  labs(title = "Pases de Luis Díaz",
       subtitle = "", x = "", y = "") + #4
  scale_y_reverse() + #5
  coord_fixed(ratio = 105/100) + theme_bw() +
  theme(
    plot.title = element_text(margin = margin(b = -15)),  
    plot.margin = margin(t = 10, r = 0, b = 0, l = 0)  
  )


### grafico 



grafico <- ((plot_messi / plot_james) | (plot_dimaria / plot_juanQuintero) |
  (plot_enzo / plot_luisdiaz)) + 
  plot_annotation(title = "Pases de Jugadores Destacados - Copa América 2024",
                  caption = "Fuente: StatsBomb consulte su sitio web: https://statsbomb.com/es/",
                  theme =  theme(plot.title = element_text(size = 20, 
                                                           hjust = 0.5),
                                 plot.subtitle = element_text(size = 12),
                                 plot.caption = element_text(size = 12))) &
  theme(plot.background = element_rect(color="#F4F5F1", 
                                       fill="#F4F5F1"))


ggsave("Pases.png", plot = grafico,
       width = 12, height = 7, dpi = 300)


## analisis de poseción

posecion <- final


ggplot(final, aes(TimeInPoss, fill = final$team.name)) + 
  geom_density() + facet_wrap(~final$period)



