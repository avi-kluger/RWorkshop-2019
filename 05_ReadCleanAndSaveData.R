#--------------
rm(list = ls())
if(is.null(dev.list()) == FALSE) dev.off()
cat ("\014")

listen_df <- read.csv(
             "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
             stringsAsFactors = FALSE)
################ Getting rid of problem rows (participants) ####################

# Create a new column *naCount* containing number of missing data per row
listen_df$naCount <- apply(listen_df, 1, function(x) sum(is.na(x)))

# explore the frequency of missing data by row
table(listen_df$naCount)

# delete rows with 10 or more missing data
listen_df <- listen_df[which(listen_df$naCount < 10), ]

# explore the frequency of missing data by row AFTER removing rows above 
table(listen_df$naCount)

################ Getting rid of problem columns (variables) ####################

# explore the frequency of missing data by columns (variables).  Note that the
# results are sent to a new vector.  Just be aware of what is being created.
naColumns <- apply(listen_df, 2, function(x) sum(is.na(x)))
which(naColumns > 0)                           # which columns
naColumns[which(naColumns > 0)]                # the content of selected columns
as.data.frame(naColumns[which(naColumns > 0)]) # the content rearrangged

# create a new *df* without the SWL columns
listen_df <- listen_df[, -c(grep("SWL", names(listen_df)))]

# get rid of unnecessary columns
junk      <- grep("filter", names(listen_df))
listen_df <- listen_df[, -junk]

############################### mean subsitution ###############################
# calculate the mean of years in the profession. Produces NA
mean(listen_df$profession_overall_1)

# find out how to force mean to work with NA with help().  Note for function
# that are in packages, search for help with ??functionYouWant
help(mean)

# Use the argument found in help
mean(listen_df$profession_overall_1, na.rm = TRUE)

listen_df$profession_overall_1[is.na(listen_df$profession_overall_1)]  <- 
                       mean(listen_df$profession_overall_1, na.rm = TRUE)
mean(listen_df$profession_overall_1)

# clean the Global Environment from all unnecesary objects
rm(list=setdiff(ls(), "listen_df"))


######################### Explore all data numerically #########################
if (!require('psych')) {
  install.packages('psych')
}

library('psych')
describe(listen_df)

# repeat without the demographics
demographics <- 270:ncol(listen_df)
describe(listen_df[, -demographics])

# print all output
options(max.print = 100000)
describe(listen_df[, -demographics])

# change the values of all non-demographics to range between 0 and 10
listen_df[, -demographics] <- listen_df[, -demographics] - 1

# test previous step
describe(listen_df[, -demographics])

# Explore demographics
apply(listen_df[, demographics], 2, table)

######################### Explore all data graphically #########################
# choose a set of variables
trust <- grep("trust", names(listen_df))

# run boxplot
boxplot(listen_df[, trust])

# attempt stem.  Fails!
stem(listen_df[, trust])

# Understand the failure
class(listen_df[, trust])

# use stem with numeric input
stem(listen_df[, "trust_1"])

# use apply to cycle all columns, one at a time
apply(listen_df[, trust], 2, stem)

# inspect correlation matrix
cor(listen_df[, trust])

# round the correlation matrix
round(cor(listen_df[, trust]), 2)

# produce only the below diagonal results
as.dist(round(cor(listen_df[, trust]), 2))

# Prepare APA 6th Style output
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
apa.cor.table(listen_df[, trust])
apa.cor.table(listen_df[, trust], 
              filename = "MyFirstTable.doc", 
              table.number = 5)

# Section Two ===============================

# write listen_df to a new *csv* file in the working directory
write.csv(listen_df, "listenClean.csv")

# Section Three #############################

# save the Global Environment into .RData file
save.image("Listen.RData")