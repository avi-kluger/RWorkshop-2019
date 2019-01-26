rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("Listen.RData")
l_df <- listenClean_df
rm(list=setdiff(ls(), c("l_df", "demographics")))

# 1. Simple example of the principle

calcPercent <- function (fraction) {
  percent <- paste0(fraction * 100, "%")
  percent
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  cat(percent)
}
calcPercent(5/7)
calcPercent(50/7)
calcPercent(5/70)
calcPercent(5)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  c("The final calculation is ...")
  percent
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  percent
  c("The final calculation is ...")
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  return(percent)
  return(c("The final calculation is ..."))
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  print(percent)
  print(c("The final calculation is ..."))
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  cat(percent)
  cat(c("The final calculation is ..."))
}
calcPercent(5/7)

calcPercent <- function (fraction) {
  percent <- paste0(round(fraction * 100, 1), "%")
  cat(percent, "The final calculation is ...")
}
calcPercent(5/7)

# 2. A function with multiple arguments
Cohen.s.d <- function (m1, m2, s1, s2, n1, n2) {
  diff <- m1-m2
  product1 <- (n1-1)*s1^2
  product2 <- (n2-1)*s2^2
  numerator <- product1 + product2
  denom <- n1+n2-2
  pooled <- sqrt(numerator/denom)
  d <- 1*diff/pooled
  # paste ("Cohen's d = ", round(d, digits = 3), sep ="")
  round(d, digits = 3)
}
Cohen.s.d (1, .5, 1, 1, 10, 10)
Cohen.s.d (1, .5, 2, 1, 10, 200)

for (i in 1:10){
  Cohen.s.d (1, .5, 2, 1, 10, i)
}
for (i in 1:10){
  d <- Cohen.s.d (1, .5, 2, 1, 10, i)
  print(d)
}

for (i in seq(10, 100, by = 10)) {
  d <- Cohen.s.d (1, .5, 2, 1, 10, i)
  print(c(i, d))
}

dVector <- data.frame(sampleSize = numeric(),
                      'Cohen s d' = numeric())
for (i in seq(10, 100, by = 10)) {
  d <- Cohen.s.d (1, .5, 2, 1, 10, i)
  dVector[i, ] <- c(i, d)
}

plot(dVector)
plot(dVector, main = "d value when means are 1 and 0.5, sd 2 and 1, sample
     size in group 1 is 10, by sample size in group 2" )
