rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")

browseURL("https://www.statmethods.net/stats/ttest.html")

# t-test basic.  Note R does not assume equal variance
t.test(support ~ genderChar, data = l_scale_df)

# plot a side-by-side boxplot
boxplot(l_scale_df$support ~ l_scale_df$genderChar)

# Embelish boxplot
boxplot(support ~ genderChar, data = l_scale_df, 
        main="Feeling supported by one's manager", 
        xlab="Gender", 
        ylab="Support",
        notch = TRUE)

# getting means and SDs with apaTables
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')

# Note that apaTable expect the IV first
apa.d.table(genderChar, support, data = l_scale_df)

# with psych
if (!require('psych')) install.packages('psych'); library('psych')
describeBy(l_scale_df[, "support"], l_scale_df$genderChar)

# Descriptive statistics for all variables in df by gender
describeBy(l_scale_df, l_scale_df$genderChar)
