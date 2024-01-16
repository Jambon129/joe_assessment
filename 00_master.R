# master script joe bonsuclub assessment
# author: Andreas Chmielowski
# purpose: joe_bonusclub assessment
#--------------------------------------

# set working directory (commented out because everything remains in that folder) 
#setwd("C:/Users/xchmia/Dropbox/Wichtige Dokumente/bewerbungen/joe_bonusclub/Assessment/joe_assessment")

# packages (loads needed packages if installed, installs and loads them if not)
packages = c("dplyr",        # data manipulation
             "tidyr",        # data cleaning
             "ggspatial",    # ggspatial
             "ggthemes",     # remove coordinates from map
             "sp",           # merge shapefiles with attributes
             "sf",           # convers sp to sf because of easier plotting
             "rgdal",        # read shapefiles
             "readxl",       # read xlsx files
             "plotrix",      # for easy std errors
             "lfe",          # FE regression
             "ggplot2",      # plotting
             "beepr",        # make beep noise when done
             "gmailr")       # send result

## Now load or install&load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)


# clear workspace
rm(list = ls())

# assess and clean if necessary
source("./01_assess.R") 

# descriptive stats
source("./02_descriptives.R") 

# regressions
source("./03_regressions.R")

# compile the document
rmarkdown::render("./04_final_doc.Rmd")

# make beep noise when done
beepr::beep(2)



# send output to myself via gmailR
#source("./05_gmailR.R")
