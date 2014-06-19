library(shiny)

# Define UI for application that clusters mtcars dataset 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Clustering cars!"),
  
  # Sidebar with a slider input for number of observations and checkboxes
  sidebarPanel(
    sliderInput("clusters", "Number of clusters:", 
                min = 2,        # 1 cluster is pointless
                max = 10,       # too many is too crowded
                value = 4) ,    # sensible start
    helpText("Note: This Shiny app runs Ward hierarchical clustering",
             "on the mtcars dataset, using a Euclidean distance metric" ,
             "and standardised versions of the variables" ,
             "(i.e. with mean=0 sd=1) you select in the checkboxes below.",
             "You can choose the number of clusters with the slider above.") ,
    checkboxInput("mpg",  "miles per gallon",   TRUE) , # as in regression project
    checkboxInput("disp", "displacement",      FALSE) ,
    checkboxInput("hp",   "gross horsepower",  FALSE) ,
    checkboxInput("drat", "rear axle ratio",   FALSE) ,
    checkboxInput("wt",   "weight",             TRUE) , 
    checkboxInput("qsec", "quarter-mile time", FALSE) 
    
  ),
  
  
  # Show a plot of the generated cluster dendrogram
  mainPanel(
    plotOutput("distPlot")
  )
))