rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")

browseURL("https://www.statmethods.net/stats/regression.html")

# regression with dummy code (same as ANOVA)
fit <- lm(support ~ gender, data = l_scale_df)
fit
methods(class = class(fit))
summary(fit)
confint(fit)

# regression with a continous predictor
fit1 <- lm(support ~ PAIR, data = l_scale_df)
summary(fit1)
confint(fit1)

# Inspect the scatterplot of this regression
browseURL("https://www.statmethods.net/graphs/scatterplot.html")

plot(l_scale_df$support, l_scale_df$PAIR, 
     main="Scatterplot of support by intimacy",
     xlab="Intimacy (PAIR) ", ylab="Support ", pch=19)

# Add the regression line to the scatterplot

abline(fit1, col="red")

# Test quadratic effect
fit2 <- lm(support ~ PAIR + I(PAIR^2), data = l_scale_df)
summary(fit2)
confint(fit2)

plot(l_scale_df$PAIR, predict(fit2))
