# email html output to myself
# author: Andreas Chmielowski
# purpose: joe_bonusclub assessment
#--------------------------------------
 

library(usethis) #only needed for the first time

gm_auth_configure(path = "gmailfromR.json")
# usethis::edit_r_environ("user")            #only needed for the first time

gm_auth()





# to be included in the actual script

corpus <- "<b>Hi,</b> <br>
               Regressionfile ist durchgelaufen. 
               Anbei ein fertig-kompiliertes <i>html-File</i> <br>
               LG, dein R"

addressees <- c("hannah.greber@live.at")

email <- gm_mime() |>
  gm_to(addressees) |>
  gm_from("andreaschmielowski@gmail.com") |>
  gm_subject("R Script durchgelaufen") |>
  gm_html_body(corpus) |>
  gm_attach_file("./04_final_doc.html")
 
gm_send_message(email)
