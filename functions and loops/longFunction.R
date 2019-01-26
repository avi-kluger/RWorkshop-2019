# I thank Nadav Kluger for help with streamlining the functions.
rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("Listen.RData")
l_df <- listenClean_df
rm(list=setdiff(ls(), c("l_df", "demographics")))

if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
if (!require('psych')) install.packages('psych'); library('psych')

# Function using functions
buildScale <- function(scaleName){
  items <- grep(scaleName, names(l_df))
  boxplot(l_df[, items])
  apply(l_df[, items], 2, stem)
}
buildScale("trust")
buildScale("Empathy")

# Adding a second argument with a default

buildScale <- function(scaleName, df = l_df){
  items <- grep(scaleName, names(df))
  boxplot(df[, items])
  apply(df[, items], 2, stem)
}
buildScale("trust")

# Giving a name to the reduced dataframe 

buildScale <- function(scaleName, df = l_df){
  items    <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
}
# You can call a different df below, or drop it and the function will use the
# defined default
buildScale("trust", df = l_df)
buildScale("trust")

# Adding two types of correlation outputs 

buildScale <- function(scaleName, df = l_df){
  items    <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
}
buildScale("trust")

# Cronbach's alpha from psych package.  
# Call alpha with explicit reference
# to psych because at times it clashes with graphic design.  This format will
# prevent problems
x <- l_df[, grep("trust", names(l_df))]
psych::alpha(x)


# Add alpha to function
buildScale <- function(scaleName, df = l_df){
  items    <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
  print(psych::alpha(scale_df))
}
buildScale("trust")

# Add alpha to function
buildScale <- function(scaleName, df = l_df){
  items    <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
  print(psych::alpha(scale_df))
}
buildScale("trust")

# Add scale mean, four different ways, to a dataframe

l_df$trustA      <- rowMeans(l_df[, c("trust_1", "trust_2", "trust_3", 
                                      "trust_4", "trust_5")])
l_df$trustB      <- rowMeans(l_df[, 1:5])
l_df$trustC      <- rowMeans(l_df[, grep("trust", names(l_df))])
l_df[, "trustD"] <- rowMeans(l_df[, grep("trust", names(l_df))])

all.equal(l_df$trustA, l_df$trustB)
all.equal(l_df$trustA, l_df$trustC)     
all.equal(l_df$trustA, l_df$trustD)     

# Delete trust A-D variables
l_df <- l_df[, -c(281:284)]

# Add a scale mean to function
buildScale <- function(scaleName, df = l_df){
  items <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
  print(psych::alpha(scale_df))
  df[, scaleName] <- rowMeans(scale_df)
  assign("l_df", df, envir = .GlobalEnv)
  # return(df[,ScaleName])
}

# buildScale("PAIR")

l_final_df <- buildScale("trust")
l_final_df <- buildScale("Empathy")
l_final_df <- buildScale("support")
l_final_df <- buildScale("Communal_Strength")

# Use for loop to automate scale buildScale
scaleVector <- c("trust", "Empathy", "PAIR", "support")

for (i in 1:length(scaleVector)) {
  l_final_df  <- buildScale(scaleVector[i])
}

           