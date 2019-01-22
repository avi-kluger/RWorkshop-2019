rm(list = ls()) # Clean the Global Environment.
cat ("\014")    # Clean the R console.
dev.off()       # Clean graphs, only if present.

# Find (get) working directory (wd). Note that the address has forward slashes 
# a backslash leans backwards ( \ ), while a forward slash leans forward ( \ )
getwd()

# Change (set) working directory (wd)
# if you copy from windows, either revrese the slashes or use double slash
setwd("C:/Users/owner/Dropbox/Files/Courses/RWorkshop-2019/Read & Clean Data")
getwd()
setwd("C:\\Users\\owner\\Dropbox\\Files\\Courses\\RWorkshop-2019\\Read & Clean Data")
getwd()
# If you want to break a long line of address, use paste0
setwd(paste0("C:\\Users\\owner\\Dropbox\\Files\\Courses\\RWo",
             "rkshop-2019\\Read & Clean Data"))
getwd()

# read a file that has comma-separated values
listen_df <- read.csv("listenSurvey.csv")

# read the same file from Dropbox so everyone can use the same file
# Go the the folder with the data.  Choose Copy Dropbox Link, paste
# the address into read.csv function AND change the 0 in the end to 1.

# https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=0
listen_df <- read.csv(
             "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1")
# read (the same) data from the internet
# paste the internet address
# https://raw.githubusercontent.com/avi-kluger/RWorkshop-2019/master/Read%20%26%20Clean%20Data/listenSurvey.csv
# To improve readability, break the pasted address to short section, wrap 
# sections with "", separate them with commas, wrap with paste0, and wrap with
# read.csv
listen_df <- read.csv(paste0("https://raw.githubusercontent.com/avi-kluger/",
                             "RWorkshop-2019/master/Read%20%26%20Clean%20Data/",
                             "listenSurvey.csv"))
# read diffrent data from the internet in SPSS format.  This can cause problems
# *.csv files are easy for R. If you run into problems with your data, consider
# saving your *.sav file to *.csv in SPSS.

# Read (in SPSS format) from Kenny's book site and replicate Table 9.1
if (!require('foreign')) install.packages('foreign'); library('foreign')
table9.1_df <- read.spss("http://davidakenny.net/kkc/c9/4person.sav", 
                         to.data.frame = TRUE, use.value.labels = FALSE)
