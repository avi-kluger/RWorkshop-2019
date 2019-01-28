rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")


# regression with a continous predictor, dummy code, and their interaction
fit <- lm(support ~ PAIR*gender, data = l_scale_df)
summary(fit)
confint(fit)

# centering continous predictor
mean(l_scale_df$PAIR)
sd(l_scale_df$PAIR)
l_scale_df$centeredPAIR <- scale(l_scale_df$PAIR, scale = FALSE)

# test mean of centered variable
mean(l_scale_df$centeredPAIR)

# round to understand what -4 * 10 to the power of -16 means practically
round(mean(l_scale_df$centeredPAIR), 10)

# test that SD was not affected
sd(l_scale_df$centeredPAIR)

# Standardized PAIR.  Same function as for centering without the scale = FALSE
l_scale_df$zPAIR <- scale(l_scale_df$PAIR)
mean(l_scale_df$zPAIR); sd(l_scale_df$zPAIR) 

fitCentered <- lm(support ~ centeredPAIR*gender, data = l_scale_df)
summary(fitCentered)
confint(fitCentered)


if (!require('pequod')) install.packages('pequod'); library('pequod')
# Note that this is a very bad model (beta is out of bounds, VIFs > 10)
mod <- lmres(support ~ PAIR*gender, center = c("PAIR"), data = l_scale_df)
summary(mod)

if (!require('ggplot2')) install.packages('ggplot2'); library('ggplot2')

theme_set(theme_bw())  ## set white rather than gray background
ggplot(l_scale_df, aes(PAIR, support, linetype = genderChar)) +
  geom_smooth(method = "lm", se = TRUE)

S_slopes<-simpleSlope(mod, pred="PAIR",mod1="gender")
S_slopes
