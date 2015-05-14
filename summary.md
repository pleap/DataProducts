---
title: "Help"
author: "Peter Leap"
date: "May 13, 2015"
output: html_document
---
The mtcars data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).  This data was used to fit a simple linear model to predict the mpg of a vehicle using the vehicle weight, engine displacement, number of cylinders and the type of transmission.  By changing one of the inputs you can see what the impact on mpg holding the other three variables constant.

The application updates the predictions each time an input control is changed.

I have include charts to show the mtcars data for each of the 4 predictors plotted against mpg.  You can see where your input predictors lie on the mtcars data as you cange the data using the sliders and radio but inut controls.  I have include the code for the server and the ui below.  They are also provided in the git hub repository forund here: <https://github.com/pleap/DataProducts>.


**server.R code**
```
data(mtcars)

shinyServer(
  function(input, output) {
    fit<- lm(mpg~disp+wt+factor(am) + factor(cyl),data=mtcars)
    output$myPlot <- renderPlot({
      df<-data.frame(disp=input$disp, wt=input$wt, cyl=input$cyl, am=input$am)
      par(mfrow=c(1,4))
      plot(mtcars$wt, mtcars$mpg, col='red', pch=19, xlab="lbs/1000", ylab="MPG", main="Weight")
      points(input$wt, round(predict(fit, df, interval="prediction")[1],2), col="blue", pch = 25, lwd=6)
      plot(mtcars$disp, mtcars$mpg, col='red', pch=19, xlab="Cu. Inches", ylab="MPG", main="Displacement")
      points(input$disp, round(predict(fit, df, interval="prediction")[1],2), col="blue", pch = 25, lwd=6)
      plot(mtcars$cyl, mtcars$mpg, col='red', pch=19, xlab=" # cyl", ylab="MPG", main="Cylinders")
      points(input$cyl, round(predict(fit, df, interval="prediction")[1],2), col="blue", pch = 25, lwd=6)
      plot(mtcars$am, mtcars$mpg, col='red', pch=19, xlab="0 = Automatic", ylab="MPG", main="Transmission")
      points(input$am, round(predict(fit, df, interval="prediction")[1],2), col="blue", pch = 25, lwd=6)

      
    })
    output$disp <- renderText({paste("Engine Displacement:",input$disp, "cubic inches")}) 
    output$wt <- renderText({paste("Vehicle weight:",input$wt*1000, "pounds")}) 
    output$cyl <- renderText({paste("No. of cylinders:",input$cyl)}) 
    output$am <- renderText({if(input$am==0){"Transmission type: Automatic"} else{"Transmission type: Manual"}}) 
    output$mpg <- renderText({
      round(predict(fit, data.frame(disp=input$disp, wt=input$wt, cyl=input$cyl, am=input$am), interval="prediction")[1],2)}) 
    
  }
)
```

**ui.R code**
```


library(markdown)

shinyUI(navbarPage("Predict MPG",
                   tabPanel("Application",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput('wt', 'Enter weight (lbs/1000)',value = 3.1, min = 1, max = 6, step = .1,),
                                sliderInput('disp', 'Enter displacement (ci)',value = 160, min = 60, max = 500, step = 10,),
                                radioButtons("cyl", "Enter Number of Cylinders:", c("4" = "4", "6" = "6",  "8" = "8")),
                                radioButtons("am", "Enter Transmission type:", c("Automatic" = "0",  "Manual" = "1")),
                                p("Input variables are automatically used to predict a mpg based on the linear model derived from the mtcars dataset using these four predictors."),
                                p("The predicted mpg is plotted against each of the predictors and overlayed on top of the mtcars data.") 
                              ),
                              mainPanel(
                                h3('Results of prediction'),
                                h4('You entered:'), 
                                verbatimTextOutput('wt'), 
                                verbatimTextOutput('disp'), 
                                verbatimTextOutput('cyl'), 
                                verbatimTextOutput('am'), 
                                h4('The model predicted that the mpg would be:'), 
                                verbatimTextOutput('mpg'), 
                                h3('Prediction layered on mtcars data'),
                                plotOutput('myPlot')
                              )
                            )
                   ),
                   tabPanel("Summary",
                            includeMarkdown("summary.md")
                   ),
                   tabPanel("Help",
                            includeMarkdown("help.md")
                   )

))
```