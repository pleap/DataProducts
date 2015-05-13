
shinyUI(pageWithSidebar(
  headerPanel("Predict MPG"),
  sidebarPanel(
    sliderInput('disp', 'Enter displacement (ci)',value = 160, min = 60, max = 500, step = 10,),
    radioButtons("cyl", "Enter Number of Cylinders:", c("4" = "4", "6" = "6",  "8" = "8")),
    radioButtons("am", "Enter Transmission type:", c("Automatic" = "0",  "Manual" = "1")),
    sliderInput('wt', 'Enter weight (lbs/1000)',value = 3.1, min = 1, max = 6, step = .1,),
    p("Input variables are automatically used to predict a mpg based on the linear model derived from the mtcars dataset using these four predictors."),
    p("The predicted mpg is plotted against each of the predictors and overlayed on top of the mtcars data.") 
  ),

  mainPanel(
    h3('Results of prediction'),
    h4('You entered:'), 
    verbatimTextOutput('disp'), 
    verbatimTextOutput('wt'), 
    verbatimTextOutput('cyl'), 
    verbatimTextOutput('am'), 
    h4('The model predicted that the mpg would be:'), 
    verbatimTextOutput('mpg'), 
    h3('Prediction layered on mtcars data'),
    plotOutput('myPlot')
  )
) 
)
 