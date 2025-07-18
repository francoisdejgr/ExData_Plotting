#https://github.com/francoisdejgr/ExData_Plotting/
#Our overall goal here is simply to examine how household energy usage varies 
#over a 2-day period in February, 2007
#We will only be using data from the dates 2007-02-01 and 2007-02-02
#Note that in this dataset missing values are coded as ??
setwd("D:/learn/code/code_r/2025-07/ExData_Plotting")
library(tidyverse)

#read data set
household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          delim = ";", escape_double = FALSE, trim_ws = TRUE,na = "?")


graph_data <- household_power_consumption %>% 
    mutate(Date = dmy(Date))%>% 
    mutate(Time = hms(Date))%>% 
    filter(Date > as.Date("2007/01/31") & Date < as.Date("2007/02/03") )



ggplot(graph_data, aes(x=Global_active_power)) +
    geom_histogram( fill="red", col="grey")+
    labs(title = "Global Active Power", x = "Global Active Power (kilowats)", y = "Frequency")
ggsave("plot1.png", width = 480 , height = 480 , units = "px")
ggsave("plot1-B.png")
