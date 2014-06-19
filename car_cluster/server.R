library(shiny)

# Define server logic required to cluster mtcars and plot dendrogram
shinyServer(function(input, output) {
  
  data(mtcars)
  stand <- function(x){ (x-mean(x))/sd(x) }              # function to standardise
  toinclude <- c( "mpg", "disp", "hp", "wt", "drat", "qsec" ) # selected variables
  standcars <- sapply(subset(mtcars, select=toinclude), "stand")       # apply fun
  rownames(standcars) <- rownames(mtcars)                              # car names

  
  output$distPlot <- renderPlot({
    
    # checkboxes and cluster numbers mean plot redrawn so these are reactive
    tocluster <- c(input$mpg, input$disp, input$hp, input$wt, input$drat, input$qsec)
    if (sum(tocluster)==0){ 
      plot(c(0,1,3), c(1,0,2), type="l", xaxt='n', yaxt='n',       #tick shape
           main="Please choose one or more variable checkboxes",   #reminder
           xlab="It doesn't work if you don't",                    #please
           ylab="You know you want to")                            #joke
    }else{
    dmat <- dist(standcars[, tocluster], method = "euclidean")                   # distances 
    fit <- hclust(dmat, method="ward.D")                           # Hierarchical clustering
    plot(fit, main=paste("Cluster Dendrogram. Mean height (i.e. distance):", round(mean(dmat),1)),
         xlab="You can choose how many clusters and which variables")    # Display dendogram
    rect.hclust(fit, k=input$clusters, border="red")              # red boxes round clusters
    }
    
  })
})