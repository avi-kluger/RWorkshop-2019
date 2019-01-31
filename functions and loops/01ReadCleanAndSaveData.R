# Section One ---------------------------------

rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

listen_df <- read.csv(
             "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
             stringsAsFactors = FALSE)

# Create a variable that counts NA per row
# It is created with an *Anonymous function*. To read about it, see 
# http://adv-r.had.co.nz/Functional-programming.html#anonymous-functions
listen_df$naCount <- apply(listen_df, 1, function(x) sum(is.na(x)))

# explore the frequency of missing data by row
table(listen_df$naCount)

# explore NAs per column (variables)
as.data.frame(apply(listen_df, 2, function(x) sum(is.na(x))))

# Remove SWL items and create a clean dataframe without SWL
grep("SWL", names(listen_df))
listenClean_df <- listen_df[, -c(grep("SWL", names(listen_df)))]

#clean the Global Environment from all unnecesary objects
rm(list=setdiff(ls(), "listenClean_df"))

# test the remaining row problems
naCount <- apply(listenClean_df, 1, function(x) sum(is.na(x)))

# explore the frequency of missing data by row
table(naCount)

# delete records with 10 or more missing data
listenClean_df <- listenClean_df[which(naCount < 10), ]
table(listenClean_df$naCount)

# mean subsitution preparation
# identify columns with NAs
colNA <- as.data.frame(apply(listenClean_df, 2, function(x) sum(is.na(x))))
colNA
# Count columns with NA
table(colNA)
# find columns with 7 NAs
names(listenClean_df[, which(t(colNA) == 7)])
# mean substitution
listenClean_df$tenure[is.na(listenClean_df$tenure)]  <- 
                       mean(listenClean_df$tenure, na.rm = TRUE)

# get rid of unnecessary columns
junk           <- grep("filter", names(listenClean_df))
listenClean_df <- listenClean_df[, -junk]

# find column numbers of demographic itemss
demographics <- grep("DemographicsIntro", names(listenClean_df)):
                ncol(listenClean_df)

# change the values of all non-demographics to range between 0 and 10
listenClean_df[, -demographics] <- listenClean_df[, -demographics] - 1

# print basic statistics of non-demotraphic items
if (!require('psych'))   install.packages('psych'); library('psych')
options(max.print = 100000)
describe(listenClean_df[, -demographics])

# Explore demographics
apply(listenClean_df[, demographics], 2, table)

# explore distributions
trust <- grep("trust", names(listenClean_df))
boxplot(listenClean_df[, trust])
apply(listenClean_df[, trust], 2, stem)
as.dist(round(cor(listenClean_df[, trust]), 2))

# Prepare APA 6th Style output
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
apa.cor.table(listenClean_df[, trust])
# apa.cor.table(listenClean_df[, trust], 
#               filename = "MyFirstTable.doc", 
#               table.number = 5)
# Section Two =================================
write.csv(listenClean_df, "listenClean.csv")
# Section Three #############################

save.image("Listen.RData")

