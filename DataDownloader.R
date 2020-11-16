library(lubridate)
library(data.table)
library(dplyr)
library(beepr)


#src https://data.ontario.ca/dataset/covid-alert-impact-data 

loc <- "https://data.ontario.ca/dataset/06a61019-62c1-48d8-8d4d-2267ae0f1144/resource/37cfeca2-059e-4a5f-a228-249f6ab1b771/download/covid_alert_downloads_canada.csv"
Downloads <- fread(input = loc, encoding = 'UTF-8',data.table = F)
#convert to date 
Downloads$date <- as.Date(Downloads$date)


loc <- "https://data.ontario.ca/dataset/06a61019-62c1-48d8-8d4d-2267ae0f1144/resource/b792e734-9c69-47d5-8451-40fc85c2f3c6/download/covid_alert_positive_uploads_ontario.csv"
Uploads <- fread(input = loc, encoding = 'UTF-8',data.table = F)
#convert date 
Uploads$date <- as.Date(Uploads$date)


#create .csv for each date of dataset
dirPath <- paste(getwd(), "/datasets/", sep = "")

#Delete files if exists 
do.call(file.remove, list(list.files(dirPath, full.names = TRUE)))
fileName = paste(dirPath, 'Downloads.csv',sep = '')
#Write Downloads Status File 
write.csv(Downloads, 
          file = fileName, 
          fileEncoding = 'UTF-8', 
          row.names = F)

print(paste("Downloads.csv has been dowloaded",
            nrow(Downloads), "Rows x ", ncol(Downloads), "Columns",  
            sep = " ")
)


#Write Uploads Status File

fileName = paste(dirPath, 'Uploads.csv',sep = '')

write.csv(Uploads, 
          file = fileName, 
          fileEncoding = 'UTF-8', 
          row.names = F)

print(paste("Uploads.csv has been dowloaded",
            nrow(Uploads), "Rows x ", ncol(Uploads), "Columns",  
            sep = " ")
)


beep(sound = 1, expr = NULL)

print(paste("Downloads Complete"))
remove(list = ls())

