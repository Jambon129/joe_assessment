# regression analysis
# author: Andreas Chmielowski
# purpose: joe_bonusclub assessment
#--------------------------------------

# get data
load("data/fildat_cleaned.RData")

# what are the determinants of revenue?
r1 <- felm(Umsatz ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r1)

r2 <- felm(Umsatz ~ `ANZAHL_Diskonter_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r2)

r3 <- felm(Umsatz ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `ANZAHL_Diskonter_im Umkreis von 20min` + KaufKraft_Lebensmittelhandel_KOPF + KaufKraft_Drogeriefachhandel_KOPF| Bundesland, data = fildat )
summary(r3)

# what are the determinants of revenue/customer?
r4 <- felm(`Umsatz pro Kund.` ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r4)

r5 <- felm(`Umsatz pro Kund.` ~ `ANZAHL_Diskonter_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r5)

r6 <- felm(`Umsatz pro Kund.` ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `ANZAHL_Diskonter_im Umkreis von 20min` + KaufKraft_Lebensmittelhandel_KOPF + KaufKraft_Drogeriefachhandel_KOPF| Bundesland, data = fildat )
summary(r6)

# what are the determinants of revenue/m2?
r7 <- felm(`Umsatz pro m2` ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r7)

r8 <- felm(`Umsatz pro m2` ~ `ANZAHL_Diskonter_im Umkreis von 20min` + `Kaufkraft_KOPF`| Bundesland, data = fildat )
summary(r8)

r9 <- felm(`Umsatz pro m2` ~ `ANZAHL_Verbrauchermärkte_im Umkreis von 20min` + `ANZAHL_Diskonter_im Umkreis von 20min` + KaufKraft_Lebensmittelhandel_KOPF + KaufKraft_Drogeriefachhandel_KOPF| Bundesland, data = fildat )
summary(r9)

# save and clear 
rm(fildat)
save.image("./data/regressions_data.RData")

# clear workspace
rm(list = ls())
