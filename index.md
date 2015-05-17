---
title       : Data Products Presentation
subtitle    : Dynamic prediction of mpg using mtcars data
author      : Peter Leap
job         : 
framework   : io2012      # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
## Project Overview
1. Use the R data set `mtcars` to create a linear model for predicting miles per gallon based on 4 significant predictors in the data set:
  * Vehicle weight
  * Engine displacement
  * Number of Cylinders
  * Type of transmission 
  
2. Create a shiny application that shows the `mtcars` data and allows users to input values for the four predictors to generate a linear model prediction for mpg

3. Display that prediction on each of the individual predictor graphs to help visualize the change in prediction based on change in predictor.

4. Publish the Application to shinyapps.io  and this presentation to github/ghpages branch

---  .class #id 

## Application Overview
  * Fit the `mtcars` data to a linear model and plot
  * Use the shiny input data to compute the mpg prediction based on the linear model and plot the point as a blue triangle
  

```r
data(mtcars)
fit <- lm(mpg ~ disp + wt + factor(am) + factor(cyl), data = mtcars)
input <- data.frame(wt = 3.1, disp = 160, cyl = 4, am = 0)  #dummy input data
df <- data.frame(wt = input$wt, disp = input$disp, cyl = input$cyl, am = input$am)
plot(mtcars$wt, mtcars$mpg, col = "red", pch = 19, xlab = "lbs/1000", ylab = "MPG", 
    main = "Weight")
points(input$wt, round(predict(fit, df, interval = "prediction")[1], 2), col = "blue", 
    pch = 25, lwd = 6)
```

---  .class #id 
## Data Display

Here is sample input data **[3.1, 160, 4, 0]** used to predict mpg and plotted on the 4 predictor data.

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 

--- .class #id 

## Summary
  * Platform
    * Shiny allows a simple but elegant user interface to gather user input and display dynamic results in both text and graphical formats
    * Slidify allows the creation of slides with charts and r code directly inline with the presentation e.g. dim(mtcars) =  32, 11
    * shinyapp.io and github ghpages automate the hosting of the application and dynamic presentation with little coding from the data scientist
  * Application
    * Uses dynamic data sets to create prediction models - in this example using `mtcars`
    * Ability to use dynamic models and other r code makes it easier to help readers visualize the results of the data analysis
      * i.e. The transmission type has little impact on the mpg holding other variables constant!
