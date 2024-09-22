library(PNADcIBGE)
library(usethis)

dados_pnadc <- get_pnadc(year = 2024, quarter = 1, design = TRUE)
usethis::use_git_config(user.name = "Alize Leal Pereira", 
                        user.email = "alize.de.fatima@gmail.com") 

usethis::browse_github_token()
