---
title: "Prediction Cities"
author: "Ana Real"
date: "June 4, 2019"
output: 
  html_document:
    keep_md: true
---



## In this work we will run the prediction for cities 100 times.

## Read data


```r
library(xlsx)
library(ggpubr)
```

```
## Loading required package: ggplot2
```

```
## Loading required package: magrittr
```

```r
library(DescTools)
library(xtable)
library(caret)
```

```
## Loading required package: lattice
```

```
## 
## Attaching package: 'caret'
```

```
## The following objects are masked from 'package:DescTools':
## 
##     MAE, RMSE
```

```r
library(DMwR)
```

```
## Loading required package: grid
```

```r
library(ggcorrplot)
library(corrplot)
```

```
## corrplot 0.84 loaded
```

```r
data <- read.xlsx2("final.xlsx", sheetIndex = 1)

for(i in c(1,2,4:10)){
    data[,i] <- as.numeric(as.character(data[,i]))
}

colnames(data) <- c("Year", "Rank", "City", "Overall", "Rankings", "Student.Mix", "Desirability", "Employer.Activity", "Affordability", "Student.View")
```

## Prediction for 2019


```r
library(knitr)
data10 <- data[data$City=="London"|data$City=="Tokyo"|data$City=="Melbourne"|data$City=="Montreal"|data$City=="Paris"|data$City=="Munich"|data$City=="Berlin"|data$City=="Zurich"|data$City=="Sydney"|data$City=="Seoul",]

lm_rank <- lm(Rankings~Year+factor(City), data = data10)
lm_mix <- lm(Student.Mix~Year+factor(City), data = data10)
lm_desir <- lm(Desirability~Year+factor(City), data = data10)
lm_emp <- lm(Employer.Activity~Year+factor(City), data = data10)
lm_aff <- lm(Affordability~Year+factor(City), data = data10)
lm_view <- lm(Student.View~Year+factor(City), data = data10)

test10 <- data.frame(City=c("London", "Tokyo", "Melbourne", "Montreal", "Paris", "Munich", "Berlin", "Zurich", "Sydney", "Seoul"), Year = c(2019,2019,2019,2019,2019,2019,2019,2019,2019,2019))
rownames(test10) <- c("London", "Tokyo", "Melbourne", "Montreal", "Paris", "Munich", "Berlin", "Zurich", "Sydney", "Seoul")
pred_rank <- predict(lm_rank, test10)
pred_mix <- predict(lm_mix, test10)
pred_desir <- predict(lm_desir, test10)
pred_emp <- predict(lm_emp, test10)
pred_aff <- predict(lm_aff, test10)
pred_view <- predict(lm_view, test10)

pred_overall <- pred_rank + pred_mix + pred_desir + pred_emp + pred_aff + pred_view

pred_total <- data.frame(test10,Rankings=pred_rank, Student.Mix=pred_mix, Desirability=pred_desir, Employer.Activity=pred_emp, Affordability=pred_aff, Student.View=pred_view, Overall=pred_overall)

pred_total <- pred_total[order(-pred_total$Overall),]
write.xlsx2(pred_total, "prediction.xlsx", sheetName = "panel", row.names = FALSE)
library(xtable)
#print(xtable(pred_total, type = "latex"), file = "table1.tex")
kable(pred_total)
```

            City         Year   Rankings   Student.Mix   Desirability   Employer.Activity   Affordability   Student.View   Overall
----------  ----------  -----  ---------  ------------  -------------  ------------------  --------------  -------------  --------
Melbourne   Melbourne    2019      65.25         99.01           95.4               90.87           23.07          94.97    468.57
Paris       Paris        2019      88.25         80.61           85.4               92.27           36.87          84.97    468.37
London      London       2019      92.65         91.81           82.8               97.07           12.67          87.97    464.97
Montreal    Montreal     2019      57.65         92.81           91.0               78.27           44.07          99.97    463.77
Tokyo       Tokyo        2019      76.65         50.61           95.2               98.47           42.27          87.97    451.17
Berlin      Berlin       2019      45.85         72.81           92.2               76.47           63.67          92.97    443.97
Sydney      Sydney       2019      61.25         94.21          102.0               89.47           17.67          78.97    443.57
Munich      Munich       2019      49.85         72.01           93.4               77.07           60.27          89.97    442.57
Seoul       Seoul        2019      84.05         66.61           69.4               93.67           37.67          91.17    442.57
Zurich      Zurich       2019      58.85         80.81           99.8               85.07           34.47          68.17    427.17
