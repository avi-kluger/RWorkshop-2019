rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")

# regression with a continous predictor, dummy code, and their interaction
fit <- lm(support ~ PAIR*gender, data = l_scale_df)
summary(fit)
confint(fit)

# test mean  and SD of original variable
mean(l_scale_df$PAIR); sd(l_scale_df$PAIR)

# centering continous predictor
l_scale_df$centeredPAIR <- scale(l_scale_df$PAIR, scale = FALSE)

# test mean  and SD of centered variable
mean(l_scale_df$centeredPAIR); sd(l_scale_df$centeredPAIR)

# round to understand what -4 * 10 to the power of -16 means practically
round(mean(l_scale_df$centeredPAIR), 10)

# Standardized PAIR.  Same function as for centering without the scale = FALSE
l_scale_df$zPAIR <- scale(l_scale_df$PAIR)
mean(l_scale_df$zPAIR); sd(l_scale_df$zPAIR) 

# Regression with centered continous predictor 
fitCentered <- lm(support ~ centeredPAIR*gender, data = l_scale_df)
summary(fitCentered)
confint(fitCentered)

# Regression with standardized variables 
fitStandardized <- lm(scale(support) ~ scale(gender)*scale(PAIR), 
                      data = l_scale_df)
summary(fitStandardized)
confint(fitStandardized)

# drop the intercept from the model with 0 
fitStandardized <- lm(scale(support) ~ 0 + scale(gender)*scale(PAIR), 
                      data = l_scale_df)
summary(fitStandardized)
confint(fitStandardized)

# Run all the above + diagnostics with a package
if (!require('pequod')) install.packages('pequod'); library('pequod')

# Note that this is a very bad model (beta is out of bounds, VIFs > 10)
mod <- lmres(support ~ PAIR*gender, center = c("PAIR"), data = l_scale_df)
summary(mod)

################################################################################
# plots (the interaction)
################################################################################
browseURL("https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf")
if (!require('ggplot2')) install.packages('ggplot2'); library('ggplot2')

# set white rather than gray background
theme_set(theme_bw())
# Build a plot with layers (first line creates the grid)
# the stuff after the '+' sign adds the graph
# you can add more '+'s and add additional layers

ggplot(l_scale_df, aes(PAIR, support, linetype = genderChar)) 

ggplot(l_scale_df, aes(PAIR, support, linetype = genderChar)) +
  geom_smooth(method = "lm", se = FALSE)

ggplot(l_scale_df, aes(PAIR, support, linetype = genderChar)) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "The effect of intimacy (PAIR) on support by Gender",
       subtitle = "with confidence intervals")

# Interaction between two continous predictors

fitStandardized <- lm(scale(support) ~ 0 + scale(tenure)*scale(PAIR), 
                      data = l_scale_df)
summary(fitStandardized)

mod <- lmres(support ~ PAIR*tenure, center = c("PAIR", "tenure"), 
             data = l_scale_df)
summary(mod)
S_slopes <- simpleSlope(mod, pred = "PAIR", mod1 = "tenure")
S_slopes
PlotSlope(S_slopes) 

png("Fig1(support by PAIR & Tenure.png")
PlotSlope(S_slopes)
dev.off()

png("Fig2(support by PAIR & Tenure.png", height = 4, 
    width = 4, units = 'in', res = 300)
PlotSlope(S_slopes) 
dev.off()
