# I thank Nadav Kluger for help with streamlining the functions.
rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("Listen.RData")
l_df <- listenClean_df
rm(list=setdiff(ls(), c("l_df", "demographics")))

if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
if (!require('psych')) install.packages('psych'); library('psych')

# function to build scales
buildScale <- function(scaleName, df = l_df){
  items <- grep(scaleName, names(df))
  scale_df <- df[, items]
  print(describe(scale_df))
  boxplot(scale_df)
  apply(scale_df, 2, stem)
  print(as.dist(round(cor(scale_df), 2)))
  apa.cor.table(scale_df)
  print(psych::alpha(scale_df))
  df[, scaleName] <- rowMeans(scale_df)
  assign("l_df", df, envir = .GlobalEnv)
}

# Use for loop to automate scale buildScale
scaleVector <- c("trust", "Empathy", "PAIR", "support")

for (i in 1:length(scaleVector)) {
  l_df  <- buildScale(scaleVector[i])
}

scaleColumns <- which(colnames(l_df) %in%  scaleVector)

l_scale_df <- l_df[, c(demographics, scaleColumns)]

demoJunk   <- c("DemographicsIntro", "na_count", "naCount")
junkColumn <- which(colnames(l_scale_df) %in%  demoJunk)
l_scale_df <- l_scale_df[, -junkColumn]

rm(list=setdiff(ls(), "l_scale_df"))         

save.image("ListeningFinal.RData")
