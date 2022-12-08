install.packages('rstudioapi')
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) #set working directory to where this R file is located

library(readxl)
All_data <- read_excel('6110000_서울특별시_07_22_18_P_제과점영업.xlsx') #read excel file

library(dplyr)
filter1_data <- filter(All_data, grepl("서울특별시 관악구", 소재지전체주소)) #find '서울특별시 관악구'

addr = strsplit(filter1_data$소재지전체주소, " ") #split '시', '구', '동'
index = 1
for(i in addr){
  tmp <- unlist(i)[3]
  addr[[index]] <- tmp
  index = index+1
} #'시', '구', '동' >>> '동'

count <- unlist(addr) %>% table() %>% data.frame() # count '동'

install.packages("treemap")
library(treemap)
treemap(count, index=".", vSize = "Freq", title = "관악구 동별 제과점 분포") #make tree map
