library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Google knows when spiders mate"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("years", h4("Years"), 
                  min=2004, max=2014, value=c(2004, 2014), format="####"),
      checkboxGroupInput("cityGroup", 
                         h4("Cities"), 
                         choices = list("Seattle" = "Seattle",
                                        "Portland" = "Portland", 
                                        "Boston" = "Boston", 
                                        "Houston" = "Houston", 
                                        "Miami" = "Miami"
                         ),
                         selected="Seattle"),
      h4("Temperature"),
      checkboxInput("tempAdjusted",
                    "Plot against city mean weekly temperatures",
                    value = FALSE),
      selectInput("tempInput", "Temperature type", c("High", "Low", "Mean"))),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("spiderPlot")),
        tabPanel("Explanation",
                 h3("Spider searches are well-correlated with indoor spider mating season"),
                 p("This app shows the intensity of Google searches 
                 for 'spider' (and categorized as 'animal' by Google) in various American cities, collected using
                 Google Trends. As you can see, there are consistent peaks each year
                 around mid-August to mid-September (shaded in each plot). This coincides
                 with the mating season for spiders in North America. The data can also be visualized
                 as a scatter plot against mean weekly temperatures -- low, high, or mean -- using the 
                 NOAA normals for 1981-2010."), 
                 p("It is not surprising that there is generally a positive correlation
                 between temperature and spider Google searches, given that the mating season occurs
                 during warmer times of year. It is interesting to note that different cities
                 display different intensity patterns over the year. For instance, Seattle
                 shows a large dropoff during colder months as compared to all of the other cities
                 in this list, even those (such as Boston) that get much colder. This is
                 consistent with the fact that spiders seen indoors do not live outdoors. The indoor
                 spider habitat is its own place, mostly insulated from the outside weather."),
                 p("Questions that still deserve answers: 
                    it does not appear that intensity is notably higher in 
                    cities that are known to have more dangerous spiders. Why is this? 
                    What happens in other countries? 
                    (Google Trends data are pretty poor outside of the US). 
                    Does this correlate well with Twitter data? 
                   Why do different cities seem to show different responses to 
                   temperature change? Can this be related to the local spider species?"),
                 p("For more information (and a fascinating list of myths about spiders), see the", 
                   a("Burke Museum spider page", href="http://www.burkemuseum.org/spidermyth/"), ".")
        )
      )
    )
  )
)
)
