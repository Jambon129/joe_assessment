# assess (and clean) data
# author: Andreas Chmielowski 
# purpose: joe_bonusclub assessment
#--------------------------------------

# get data
fildat <- read_excel("../Filialdaten.xlsx")


# any missings?
sum(is.na(fildat))

# where are missings exactly?
apply(fildat, 2,  function(x) sum(is.na(x)))

#fildat <- na.omit(fildat) 

# decide to keep observations with NAs for now, since only 2 variables affected


# do shares add up to 1?
fildat |> 
  mutate(sum_shares = `Anteil Clever` + 
           `Anteil Ja!Natürlich` +
           `Anteil Feinkost` +
           `Anteil Obst&Gemüse` +
           `Anteil BILLA Marke` +
           `Anteil BILLA Corso` + 
           `Anteil BILLA Corso` + 
           `Anteil Getränke ohne Alkohol` +
           `Anteil Alkohol` +
           Aktionsanteil) |>
  select(sum_shares)

# create variable for rest
fildat <- fildat |> 
  mutate(`Anteil Rest` = 1 - (`Anteil Clever` + 
           `Anteil Ja!Natürlich` +
           `Anteil Feinkost` +
           `Anteil Obst&Gemüse` +
           `Anteil BILLA Marke` +
           `Anteil BILLA Corso` + 
           `Anteil BILLA Corso` + 
           `Anteil Getränke ohne Alkohol` +
           `Anteil Alkohol` +
           Aktionsanteil))

# note that for this I have to assume that these categories are mutually exclusive.

# create also variable for revenue per customer and revenue per m2
fildat <- fildat |>
  mutate(`Umsatz pro Kund.` = Umsatz/`Kund. Anz.`) |>
  mutate(`Umsatz pro m2` = Umsatz/VERKAUFS_M2)

# recode some BL names according to ISO codes
fildat <- fildat |>
  mutate(Bundesland = case_when(B_LAND == 1 ~ "Burgenland",
                                B_LAND == 2 ~ "Kaernten",
                                B_LAND == 3 ~ "NOE",
                                B_LAND == 4 ~ "OOE",
                                B_LAND == 5 ~ "Salzburg",
                                B_LAND == 6 ~ "Steiermark",
                                B_LAND == 7 ~ "Tirol",
                                B_LAND == 8 ~ "Vorarlberg",
                                B_LAND == 9 ~ "Wien"))


# save new dataset
save(fildat, file = "data/fildat_cleaned.RData")

# clear workspace
rm(list = ls())
