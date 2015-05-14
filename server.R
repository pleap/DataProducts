
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
  