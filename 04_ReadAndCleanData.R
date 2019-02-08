rm(list = ls())
if(is.null(dev.list()) == FALSE) dev.off()
cat ("\014")

listen_df <- read.csv(
             "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
             stringsAsFactors = FALSE)

# Exploring a single variable.  Three ways to index a variable
listen_df$filter1
listen_df[, "filter1"]
listen_df[, 1]

# test for missing data (NAs) on one column
is.na(listen_df$filter1)

# count number of missing data
sum(is.na(listen_df$filter1))

# print to console the record with the missing datum on filter1
listen_df[which(is.na(listen_df$filter1)), ]

# transpose the output above for easy reading. (Note that output is character).
t(listen_df[which(is.na(listen_df$filter1)), ])

# test for missing data (NAs) on all columns
# first, let's understand the apply function on small data set
# let's create demo data set from listen_df with 10 observations and 5 columns
# subseting rows by numbers, and columns by names.
demo_df <- listen_df[1:10, 
                     c("trust_1", "trust_2", "trust_3", "trust_4", "trust_5")]
demo_df

# apply function 1 = rows, 2 = columns
apply(demo_df, 1, mean)
apply(demo_df, 2, mean)

# move from the demo with means to the real data with two functions
# explore problem rows (participants).  The logic of functions is explained
# later
apply(listen_df, 1, function(x) sum(is.na(x)))

# add this array to the listen_df as a new column
listen_df$naCount <- apply(listen_df, 1, function(x) sum(is.na(x)))

# explore the frequency of missing data by row
table(listen_df$naCount)

# explore problem columns (variables)
apply(listen_df, 2, function(x) sum(is.na(x)))
as.data.frame(apply(listen_df, 2, function(x) sum(is.na(x))))

# What to do with NAs: delete, substitute, keep?
# delete variables with too many missing values (SWL)
# find the column numbers of SWL items, the primitive way
names(listen_df)

# delete SWL and create new dataframes
listenCleanPrimitive_df <- listen_df[, -c(279:283)]

# Introduction to grep
myString <- c("a", "b", "c", "a")
grep("a", myString)

# find the column numbers with grep
grep("SWL", names(listen_df))
listenClean_df <- listen_df[, -c(grep("SWL", names(listen_df)))]
listenCleanPrimitive_df == listenClean_df
all.equal(listenCleanPrimitive_df, listenClean_df)

#clean the Global Environment from all unnecesary objects
rm(list=setdiff(ls(), "listenClean_df"))

# test the remaining row problems
naCount <- apply(listenClean_df, 1, function(x) sum(is.na(x)))

# explore the frequency of missing data by row
table(naCount)

# delete records with 10 or more missing data
listenClean_df <- listenClean_df[which(naCount < 10), ]
names(listenClean_df)
table(listenClean_df$naCount)

# mean subsitution 
colNA <- as.data.frame(apply(listenClean_df, 2, function(x) sum(is.na(x))))
table(colNA)
which(t(colNA) == 7)
names(listen_df[, which(t(colNA) == 7)])
mean(listenClean_df$tenure)
mean(listenClean_df$tenure, na.rm = TRUE)
listenClean_df$tenure[is.na(listenClean_df$tenure)]  <- 
                       mean(listenClean_df$tenure, na.rm = TRUE)
listenClean_df$tenure

# get rid of unnecessary columns
junk           <- grep("filter", names(listenClean_df))
listenClean_df <- listenClean_df[, -junk]

if (!require('psych')) {
  install.packages('psych')
}

library('psych')
describe(listenClean_df)

# repeat without the demographics
demographics <- 270:ncol(listenClean_df)
describe(listenClean_df[, -demographics])
# print all output
options(max.print = 100000)
describe(listenClean_df[, -demographics])

# change the values of all non-demographics to range between 0 and 10
listenClean_df[, -demographics] <- listenClean_df[, -demographics] - 1

# test previous step
describe(listenClean_df[, -demographics])

# Explore demographics
apply(listenClean_df[, demographics], 2, table)

# explore distributions
trust <- grep("trust", names(listenClean_df))
boxplot(listenClean_df[, trust])
stem(listenClean_df[, trust])
class(listenClean_df[, trust])
stem(listenClean_df[, "trust_1"])
apply(listenClean_df[, trust], 2, stem)

cor(listenClean_df[, trust])
round(cor(listenClean_df[, trust]), 2)
as.dist(round(cor(listenClean_df[, trust]), 2))

# Prepare APA 6th Style output
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
apa.cor.table(listenClean_df[, trust])
apa.cor.table(listenClean_df[, trust], 
              filename = "MyFirstTable.doc", 
              table.number = 5)
# Homework
# Produce a correlation matrix with your data
