library(shiny)
library(ggplot2)

master <- read.csv("master.csv")
master$start.dates <- as.Date(master$start.dates, format="%m/%d/%y")
master$end.dates <- as.Date(master$end.dates, format="%m/%d/%y")

shinyServer(function(input, output) { 
  output$spiderPlot <- renderPlot({
    daters <- master[master$City %in% input$cityGroup,]
    times <- format(daters$start.dates, "%Y") %in% seq(from=input$years[[1]], to=input$years[[2]], by=1)
    daters <- daters[times,]
    if (length(input$cityGroup) > 0 && input$tempAdjusted){
        qplot(switch(input$tempInput, Low=low.temp, High=high.temp, Mean=0.5*(low.temp+high.temp)), 
              Spider, 
              data=daters, 
              color=City, 
              xlab="Temperature") + stat_smooth()
    } else if (length(input$cityGroup) > 0) {
      from.year <- input$years[[1]]
      to.year <- input$years[[2]]
      xstart <- seq(from=as.Date(paste(from.year,"08","15",sep="-")),
                    to=as.Date(paste(to.year,"08","15",sep="-")),
                    by="year")
      xend <- seq(from=as.Date(paste(from.year,"09","15",sep="-")),
                    to=as.Date(paste(to.year,"09","15",sep="-")),
                    by="year")      
      rects <- data.frame(xstart=xstart, xend=xend)
      ggplot(data=daters) + geom_line(aes(x=start.dates, y=Spider, color=City, geom="line")) + xlab("Time") + 
      geom_rect(data = rects, aes(xmin = xstart, xmax = xend, 
                                  ymin = -Inf, ymax = Inf), alpha = 0.4)        
    }
  })
  
})
