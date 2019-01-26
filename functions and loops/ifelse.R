rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("Listen.RData")
l_df <- listenClean_df
rm(list=setdiff(ls(), c("l_df", "demographics")))

# ifelse Section ---------------------------------------------------------------

# Recode the gender variables. The survey had 1 - male; 2 - female; 3 - other

names(l_df[, demographics])

table(l_df$gender)
table(l_df$supervisor_gender)
l_df$genderName  <- ifelse(l_df$gender == 1, "Male", "Female")
l_df$SgenderName <- ifelse(l_df$supervisor_gender == 1, "Male", "Female")

table(l_df$years_together_1)
stem(l_df$years_together_1)

l_df$yearsCategory <- ifelse(l_df$years_together_1 < 1, 1,
                             ifelse(l_df$years_together_1 < 2, 2, 3))
table(l_df$yearsCategory)

l_df$yearsCategoryCharacter <- ifelse(l_df$years_together_1 < 1, "Under a year",
                                  ifelse(l_df$years_together_1 < 2, "1-2 years", 
                                         "More than two years"))
table(l_df$yearsCategoryCharacter)

# A note on *if* in R -- VERY IMPORTANT! if operates only on a atomic vector
