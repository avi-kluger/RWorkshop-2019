rm(list = ls())
cat ("\014")
if(is.null(dev.list()) == FALSE) dev.off()

load("ListeningFinal.RData")

browseURL("https://www.statmethods.net/stats/ttest.html")

# t-test basic.  Note R does not assume equal variance
t.test(l_scale_df$support ~ l_scale_df$gender)

# same as above, but use the data arugment to separate the df from the columns
t.test(support ~ gender, data = l_scale_df)

# plot a side-by-side boxplot
boxplot(l_scale_df$support ~ l_scale_df$gender)

# Embilish boxplot
boxplot(support ~ gender, data = l_scale_df, 
        main="Feeling supported by one's manager", 
        xlab="Gender", 
        ylab="Support")

# getting means and SDs
# with apaTables
if (!require('apaTables')) install.packages('apaTables'); library('apaTables')

# Note that apaTable expect the IV first.
apa.d.table(gender, support, data = l_scale_df)

# with psych
if (!require('psych')) install.packages('psych'); library('psych')
describeBy(l_scale_df[, "support"], l_scale_df$gender)
describeBy(l_scale_df, l_scale_df$gender)
