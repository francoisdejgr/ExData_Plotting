#https://github.com/francoisdejgr/ExData_Plotting/
#Our overall goal here is simply to examine how household energy usage varies 
#over a 2-day period in February, 2007
#We will only be using data from the dates 2007-02-01 and 2007-02-02
#Note that in this dataset missing values are coded as ??
setwd("D:/learn/code/code_r/2025-07/ExData_Plotting")
library(tidyverse)
library(patchwork)
#read data set
household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          delim = ";", escape_double = FALSE, trim_ws = TRUE,na = "?")


graph_data <- household_power_consumption %>% 
    mutate(DTG = paste(Date, Time)) %>% 
    mutate(DTG = dmy_hms(DTG)) %>% #merge date and time - easier to plot
    mutate(Date = dmy(Date))%>% 
    mutate(Time = hms(Time))%>% 
    filter(Date > as.Date("2007/01/31") & Date < as.Date("2007/02/02") )


plot1 <- ggplot(graph_data, aes(x=Global_active_power)) +
    geom_histogram( fill="red", col="grey")+
    labs(title = "Global Active Power", x = "Global Active Power (kilowats)", y = "Frequency")


plot2 <- ggplot(graph_data, aes(x=DTG, y=Global_active_power, group=1)) +
    geom_line() +
    scale_x_datetime(date_breaks = '1 day', date_labels = '%a %d') + 
    labs(title = "Global Active Power", y = "Global Active Power (kilowats)", y = "")

plot3 <- ggplot(graph_data, aes(x=DTG)) +
    geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1"))+
    geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2"))+
    geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3"))+
    theme(legend.position = c(.9, .9))+
    scale_x_datetime(date_breaks = '1 day', date_labels = '%a %d') + 
    labs( y = "Enery Sub Metering", y = "")

plot4 <- ggplot(graph_data, aes(x=DTG, y=Global_reactive_power, group=1)) +
    geom_line() +
    scale_x_datetime(date_breaks = '1 day', date_labels = '%a %d') + 
    labs(title = "Global Reactive Power", y = "Global Active Power (kilowats)", y = "")

(plot1 + plot_spacer() + plot2) / (plot3 + plot_spacer()+ plot4)

ggsave("plot4.png", width = 480 , height = 480 , units = "px")
ggsave("plot4-B.png")
