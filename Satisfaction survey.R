rm(list = ls())

# Clean the R console
cat ("\014")

# Clean graphs, if present
if(is.null(dev.list()) == FALSE) dev.off()
# Read Qualtics data:

# Qualtrics user name
USER.name <- "avik@savion.huji.ac.il" 
# Qualtrics API. See account setting.
API.token <- "GWgISklc5GIeloQh8RZAZVZA2Z0yP7TKphpbxfpb"
# Qualtrics survey ID (See tail of distribution code starting with SV_, and 
# change the ID below).
SURVEY.id <- "SV_e9W83Izkp3gY9Q9"                       

Link      <- paste0("https://survey.Qualtrics.com//WRAPI/ControlPanel/api.php?",
                    "API_SELECT=ControlPanel&Version=2.5&Request=getLegacy",
                    "ResponseData&User=", USER.name, "&Token=", API.token, 
                    "&Format=CSV&Labels=0&ExportTags=1&SurveyID=",SURVEY.id) 
#Unstar the indented commands after replacing USER.name, API.token & SURVEY.id
#infomration
all_content <- readLines(Link)
# Drop the second header line created by Qualtrics
skip_second <- all_content[-2]

# textConnection: reads the data from skip_second 

df      <- read.csv(textConnection(skip_second),
           header = TRUE, stringsAsFactors = FALSE)
# Drop test rows and Qualtrics columns and the first Text message
df      <- df [, -c(1:10)]
df      <- df [, -5]

df <- na.omit(df)

temp_df <- data.frame("Course Satisfaction" = numeric(), 
                      "Lecturer Satisfaction" = numeric(),
                      "Comments" = character(),
                      "Interest in future workshops" = numeric(), 
                      check.names = FALSE)

names(df) <- names(temp_df)

library(psych)

describe(df[, 1:2]) [c("n", "mean", "sd")]

t.test(df$`Course Satisfaction`, 
       df$`Lecturer Satisfaction`, 
       paired=TRUE, 
       conf.level=0.95)
Comments <- df$Comments[which(df$Comments != "")][-c(4:5)]
Comments
df$`Interest in future workshops` <- factor(df$`Interest in future workshops`,
                                        levels = (c(0, 0.5, 1)),
                                        labels = c("Not interested",
                                                   "Perhaps",
                                                   "Interested"))
barplot(table(df$`Interest in future workshops`), main = 
   "Frequencies of levels of interest in future R workshop\nwith Avi Kluger")
