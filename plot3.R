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
    mutate(DTG = paste(Date, Time)) %>% 
    mutate(DTG = dmy_hms(DTG)) %>% #merge date and time - easier to plot
    mutate(Date = dmy(Date))%>% 
    mutate(Time = hms(Time))%>% 
    filter(Date > as.Date("2007/01/31") & Date < as.Date("2007/02/03") )


ggplot(graph_data, aes(x=DTG)) +
    geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1"))+
    geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2"))+
    geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3"))+
    theme(legend.position = c(.9, .9))+
    scale_x_datetime(date_breaks = '1 day', date_labels = '%a %d') + 
    labs( y = "Enery Sub Metering", y = "")
ggsave("plot3.png", width = 480 , height = 480 , units = "px")
ggsave("plot3-B.png")
