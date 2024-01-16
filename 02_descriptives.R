# descriptive analysis
# author: Andreas Chmielowski
# purpose: joe_bonusclub assessment
#--------------------------------------

#get data
load("data/fildat_cleaned.RData")

# define variable of interest to run some of the analysis on
fildat <- fildat |>
  mutate(Zielvariable = `Umsatz pro m2`) # change here if necessary

# what is the distribution of Zielvariable over branches?
summary(fildat$Zielvariable)

(density_plot <- ggplot(fildat) +
  geom_density(aes(x = Zielvariable)) +
  theme_minimal())

# we have a pretty concentrated density but also some positive outliers

# in which state are branches most successful?
(Zielvar_nach_BL <- fildat |>
  group_by(Bundesland) |>
  summarise(`Mittlere Zielvariable` = mean(Zielvariable),
            `SE Zielvariable` = std.error(Zielvariable)))

(ggplot(Zielvar_nach_BL) +
  geom_bar(aes(x = Bundesland, y = `Mittlere Zielvariable`), stat = "identity", fill = "lightblue") +
  geom_errorbar(aes(x = Bundesland, 
                    ymin = `Mittlere Zielvariable` - 1.96*`SE Zielvariable`, 
                    ymax = `Mittlere Zielvariable` + 1.96*`SE Zielvariable`),
                width = .2) +
  theme_minimal() -> bars_plot)

# alternative plot: shapefile
austria_sp <- readOGR("../OGDEXT_NUTS_1_STATISTIK_AUSTRIA_NUTS2_20160101/STATISTIK_AUSTRIA_NUTS2_20160101.shp", stringsAsFactors = FALSE) # shapefile

Zielvar_nach_BL <- Zielvar_nach_BL |>
  mutate(ID = case_when(Bundesland == "Burgenland" ~ "AT11",
                        Bundesland == "NOE" ~ "AT12",
                        Bundesland == "Wien" ~ "AT13",
                        Bundesland == "Kaernten" ~ "AT21",
                        Bundesland == "Steiermark" ~ "AT22",
                        Bundesland == "OOE" ~ "AT31",
                        Bundesland == "Salzburg" ~ "AT32",
                        Bundesland == "Tirol" ~ "AT33",
                        Bundesland == "Vorarlberg" ~ "AT34"))

BL_map <- sp::merge(austria_sp, Zielvar_nach_BL, by = "ID")
BL_map <- sf::st_as_sf(BL_map)

(ggplot(data = BL_map) +
  geom_sf(aes(fill = `Mittlere Zielvariable`)) +
  coord_sf(datum = NA) +
  scale_fill_continuous(high = "navyblue", low = "lightblue1") +
  #guides(fill=guide_legend(title="FP vote share")) +
  #ggtitle("Austrian Freedom Party votes 2017 by municipality") +
  theme_minimal() -> map_austria)


# test for significant differences (Burgenland base)
m1 <- lm(Zielvariable ~ factor(Bundesland), data = fildat)
summary(m1)


# which ones are the positive outliers?
(outliers <- fildat |>
  filter(Zielvariable >= (quantile(Zielvariable, 0.99)))|>
    select(FILIALE, Zielvariable, Bundesland))


# how is revenue composed?
(Anteil_nach_BL <- fildat |>
  group_by(Bundesland) |>
  summarise(Anteil_Clever = mean(`Anteil Clever`),
            Anteil_JaNaturlich = mean(`Anteil Ja!Natürlich`),
            Anteil_Feinkost = mean(`Anteil Feinkost`),
            Anteil_ObstGemuse = mean(`Anteil Obst&Gemüse`),
            Anteil_BILLA = mean(`Anteil BILLA Marke`),
            Anteil_Corso = mean(`Anteil BILLA Corso`), 
            Anteil_nonAlk = mean(`Anteil Getränke ohne Alkohol`),
            Anteil_Alk = mean(`Anteil Alkohol`),
            Anteil_Aktion = mean(Aktionsanteil),
            Anteil_Rest = mean(`Anteil Rest`)))

Anteil_nach_BL_long <- gather(Anteil_nach_BL, # change into long format
                              Kategorie, 
                              Anteil, 
                              Anteil_Clever:Anteil_Rest, 
                              factor_key=TRUE)

(ggplot(Anteil_nach_BL_long) +
  aes(x = Bundesland, fill = Kategorie, y = Anteil) +
  geom_bar(position = "fill", stat = "identity") +
  theme_minimal() -> Kategorie_nach_BL)

# save stuff
rm(Anteil_nach_BL_long, austria_sp)
save.image("./data/descriptives_data.RData")

# clear workspace
rm(list = ls())
