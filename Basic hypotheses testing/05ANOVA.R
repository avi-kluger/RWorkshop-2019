rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")

browseURL("https://www.statmethods.net/stats/anova.html")

# One-way ANOVA basic.  Note R tests Type I SS.  Order matters!

aov(support ~ genderChar, data = l_scale_df)
fit <- aov(support ~ genderChar, data = l_scale_df)
fit
# print the results of the assignment in one line with extra *()* 
(fit <- aov(support ~ genderChar, data = l_scale_df))

methods(class = class(fit))
summary(fit)

fit <- aov(support ~ Source, data = l_scale_df)
summary(fit)

#Inspect means with apaTables
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')
apa.1way.table(Source, support, data = l_scale_df)

# Tukey Honestly Significant Differences
TukeyHSD(fit) 

if (!require('psych')) install.packages('psych'); library('psych')
describeBy(l_scale_df$support, l_scale_df$Source)

# Two-way ANOVA. 
fit2way <- aov(support ~ Source*genderChar, data = l_scale_df)
summary(fit2way)

# Order matters! R uses Type I SS.
fit2way <- aov(support ~ genderChar*Source, data = l_scale_df)
summary(fit2way)

fit2way <- aov(support ~ genderChar*Source, data = l_scale_df)
summary(fit2way)

# This fails because lack of observations
apa.2way.table(genderChar, Source, support, data = l_scale_df)

# verify that the issue stems from low cell frequencies
table(l_scale_df$Source, l_scale_df$genderChar)

apa.2way.table(genderChar, SgenderChar, support, data = l_scale_df)
apa.2way.table(genderChar, SgenderChar, support, data = l_scale_df,
               show.conf.interval = TRUE)
apa.2way.table(genderChar, SgenderChar, support, data = l_scale_df,
               show.conf.interval = TRUE, filename = "firstANOVA.doc")
apa.2way.table(genderChar, SgenderChar, support, data = l_scale_df,
               show.marginal.means = TRUE, filename = "secondANOVA.doc")


if (!require('sciplot')) install.packages('sciplot'); library('sciplot')
bargraph.CI(SgenderChar, support, group = genderChar, data = l_scale_df,
            xlab = "Gender of employee", ylab = "Support", 
            cex.lab = 1.5, x.leg = 1,
            col = "black", angle = 45, cex.names = 1.25,
            density = c(0,20), legend = TRUE, trace.label = TRUE)

