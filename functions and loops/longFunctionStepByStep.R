# I thank Nadav Kluger for help with streamlining the functions.
rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListenRecoded.RData")


# function for boxplot
buildScale <- function(scaleName){
  items <- grep(scaleName, names(l_df))
  boxplot(l_df[, items])
}

buildScale("trust")
buildScale("PAIR")

# add to function stem-and-leaf display
buildScale <- function(scaleName){
  items <- grep(scaleName, names(l_df))
  boxplot(l_df[, items])
  apply(l_df[, items], 2, stem)
}
buildScale("trust")

# increase readability by creating an object of subset of dataframe

buildScale <- function(scaleName){
  items    <- grep(scaleName, names(l_df))
  scale_df <- l_df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
}
buildScale("trust")

# Add describe function from *psych* package. Note describe is wrapped w/ print


buildScale <- function(scaleName){
if (!require('psych')) install.packages('psych'); library('psych')
  items    <- grep(scaleName, names(l_df))
  scale_df <- l_df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(describe(scale_df))
}

buildScale("support")

# Add a second argument to function with defualt
buildScale <- function(scaleName = "PAIR", df = l_df){
  items <- grep(scaleName, names(df))
  scale_df <- df[, items]
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(describe(scale_df))
}
buildScale("trust", df = l_df)
buildScale("trust")
# add alpha
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')

# note that alpha is called together with the package name
# This prevents clashes between alpha and the graphics of R
buildScale <- function(scaleName, df = l_df){
  items <- grep(scaleName, names(df))
  scale_df <- df[, items]
  print(describe(scale_df))
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(psych::alpha(scale_df))
}
buildScale("trust")

# add two methods for correlation matrix

buildScale <- function(scaleName, df = l_df){
  items <- grep(scaleName, names(df))
  scale_df <- df[, items]
  print(describe(scale_df))
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(psych::alpha(scale_df))
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
}
buildScale("trust")

# function to build scales
buildScale <- function(scaleName, df = l_df,
                       out_df = "l_df"){
  items    <- grep(scaleName, names(df))
  scale_df <- df[, items]
  print(describe(scale_df))
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
  print(psych::alpha(scale_df))
  df[, scaleName] <- rowMeans(scale_df)
  assign(out_df, df, envir = .GlobalEnv)
}
buildScale("trust")
buildScale("PAIR")
