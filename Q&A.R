rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

listen_df <- read.csv(
  "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
  stringsAsFactors = FALSE)

myString <- c("a", "b", "c", "a")
grep("d", myString)

listen_df$meanSurvey <- apply(listen_df[, 1:270], 1, mean)
sum(is.na(listen_df[, 1:270]))

clean_df <- na.omit(listen_df)
is.numeric(clean_df)

sum(is.na(clean_df))
apply(clean_df[, 1:270], 1, mean)
length(apply(listen_df, 2, na.omit))

# rm(listen_df)
# rm(support_1)
support_1
with(listen_df, support_1)
with(listen_df, mean(support_1))


attach(listen_df)
mean(support_1)
rm(list = ls())
mean(support_1)

myString <- c("a", "b", "c", "a")
grep("a", myString)

apply(listen_df, 1, mean)
