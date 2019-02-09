#------------- House Keeping ---------------------------------------------------
# Clean the Global Environment
rm(list = ls())

# Clean the R console
cat ("\014")

# Clean graphs, if present
if(is.null(dev.list()) == FALSE) dev.off()
#------------- End of House Keeping --------------------------------------------

# Try to read the csv file, and fail
listen_df <- read.csv("listenSurvey.csv", stringsAsFactors = FALSE)


# Find (get) working directory (wd). Note that the address has forward slashes 
# a backslash leans backwards ( \ ), while a forward slash leans forward ( / )
getwd()

# Change (set) working directory (wd)
# if you copy from windows, either revrese the slashes or use double slash
setwd("C:/Users/owner/Dropbox/Files/Courses/RWorkshop-2019")
getwd()
setwd("C:\\Users\\owner\\Dropbox\\Files\\Courses\\RWorkshop-2019")
getwd()

# read a file that has comma-separated values
listen_df <- read.csv("listenSurvey.csv", stringsAsFactors = FALSE)

# read the same file from Dropbox so everyone can use the same file
# Go the the folder with the data.  Choose Copy Dropbox Link, paste
# the address into read.csv function AND change the 0 in the end to 1.

# https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=0
listen_df <- read.csv(
             "https://www.dropbox.com/s/modnpbbqjrmuodr/listenSurvey.csv?dl=1",
             stringsAsFactors = FALSE)
# read (the same) data from the internet
# paste the internet address
# https://raw.githubusercontent.com/avi-kluger/RWorkshop-2019/master/Read%20%26%20Clean%20Data/listenSurvey.csv
# To improve readability, break the pasted address to short section, wrap 
# sections with "", separate them with commas, wrap with paste0, and wrap with
# read.csv
listen_df <- read.csv(paste0("https://raw.githubusercontent.com/avi-kluger/",
                             "RWorkshop-2019/master/Read%20%26%20Clean%20Data/",
                             "listenSurvey.csv"), stringsAsFactors = FALSE)
# read diffrent data from the internet in SPSS format.  This can cause problems
# *.csv files are easy for R. If you run into problems with your data, consider
# saving your *.sav file to *.csv in SPSS.

# Read (in SPSS format) from Kenny's book site and replicate Table 9.1
if (!require('foreign')) install.packages('foreign'); library('foreign')
table9.1_df <- read.spss("http://davidakenny.net/kkc/c9/4person.sav", 
                         to.data.frame = TRUE, use.value.labels = FALSE)

# Read (in EXCEL format) from local file located in current directory
if (!require('readxl')) install.packages('readxl'); library('readxl')
listenTalk_df <- read_excel("listenTalk.xlsx")
listenTalk_df
listenTalk_df <- as.data.frame(listenTalk_df)
listenTalk_df


# Read Qualtics data:

# Qualtrics user name
USER.name <- "yourUsername@emailServer" 
# Qualtrics API. See account setting.
API.token <- "ReplaceThisWithYourAPIToken"
# Qualtrics survey ID (See tail of distribution code starting with SV_, and 
# change the ID below).
SURVEY.id <- "SV_cwoOmM3eZZp4slv"                       

Link      <- paste0("https://survey.Qualtrics.com//WRAPI/ControlPanel/api.php?",
                    "API_SELECT=ControlPanel&Version=2.5&Request=getLegacy",
                    "ResponseData&User=", USER.name, "&Token=", API.token, 
                    "&Format=CSV&Labels=0&ExportTags=1&SurveyID=",SURVEY.id) 
# Remove # from the indented commands after replacing USER.name, 
# API.token & SURVEY.id

#infomration
    # all_content <- readLines(Link)
# Drop the second header line created by Qualtrics
    # skip_second <- all_content[-2]
# textConnection: reads the data from skip_second 
    # df      <- read.csv(textConnection(skip_second), 
    #            header = TRUE, stringsAsFactors = FALSE)
# Drop test rows and Qualtrics columns and the first Text message
    # df      <- psych_df [, -c(1:10)]

#--------------------------- End of reading data -------------------------------
# Cleaning the environment and keeping only one object (dataframe)

rm(list=setdiff(ls(), "listen_df"))

# Let's see what is inside the data frame
names(listen_df)
as.data.frame(names(listen_df))
head(listen_df)
tail(listen_df)

# View dataframe beyond the first 100 columns
utils::View(listen_df)
