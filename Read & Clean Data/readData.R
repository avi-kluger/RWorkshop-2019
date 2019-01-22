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
