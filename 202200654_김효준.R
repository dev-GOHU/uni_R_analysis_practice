install.packages('rstudioapi')
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readxl)
All_data <- read_excel('6110000_서울특별시_07_22_18_P_제과점영업.xlsx')

library(dplyr)
filter1_data <- filter(All_data, grepl("서울특별시 관악구", 소재지전체주소))

addr = strsplit(filter1_data$소재지전체주소, " ")

index = 1
for(i in addr){
  tmp <- unlist(i)[3]
  addr[[index]] <- tmp
  index = index+1
}

count <- unlist(addr) %>% table() %>% data.frame()

install.packages("treemap")
library(treemap)
treemap(count, index=".", vSize = "Freq", title = "관악구 동별 제과점 분포")