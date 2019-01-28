# I thank Nadav Kluger for help with streamlining the functions.
rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListenRecoded.RData")

# Integity test
l_df$noIntegrity <- 0

temp <- l_df[, grep("support", names(l_df))]
varTest <- apply(temp, 1, var)
l_df$noIntegrity <- ifelse(varTest == 0, 1, 0) + l_df$noIntegrity
l_df$noIntegrity

temp <- l_df[, grep("PAIR_", names(l_df))]
varTest <- apply(temp, 1, var)
l_df$noIntegrity <- ifelse(varTest == 0, 1, 0) + l_df$noIntegrity
l_df$noIntegrity

# Reverse coding
l_df[1:10, grep("PAIR_", names(l_df))]
reverseVector <- c(paste0("PAIR_", 6:15))
l_df[, reverseVector] <- 10 - l_df[, reverseVector]
l_df[1:10, grep("PAIR_", names(l_df))]

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

# Find the numbers of the colomuns that contain the scale scores
scaleColumns <- which(colnames(l_df) %in%  scaleVector)
scaleColumns

# Redefine demographics because, in previous steps, ifelse results of cateogries
# were added
demographics <- grep("DemographicsIntro", names(l_df)):
                grep("yearsCategoryCharacter", names(l_df))
demographics

# keep only demographics and scales (drop all items) and assign to a new df
l_scale_df <- l_df[, c(demographics, scaleColumns)]

# clean constants and unnecesary columns
demoJunk   <- c("DemographicsIntro", "na_count", "naCount")
junkColumn <- which(colnames(l_scale_df) %in%  demoJunk)
junkColumn
l_scale_df <- l_scale_df[, -junkColumn]

rm(list=setdiff(ls(), "l_scale_df"))         

save.image("ListeningFinal.RData")