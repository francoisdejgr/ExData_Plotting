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
    filter(Date > as.Date("2007/01/31") & Date < as.Date("2007/02/02") )

ggplot(graph_data, aes(x=DTG, y=Global_active_power, group=1)) +
    geom_line() +
    scale_x_datetime(date_breaks = '1 day', date_labels = '%a %d') + 
    labs(title = "Global Active Power", y = "Global Active Power (kilowats)", y = "")
ggsave("plot2.png", width = 480 , height = 480 , units = "px")
ggsave("plot2-B.png")
