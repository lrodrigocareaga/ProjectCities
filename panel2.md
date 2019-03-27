---
title: "Regression 2"
author: "Ana Real and Rodrigo Careaga"
date: "March 26, 2019"
output: 
  html_document:
    keep_md: true
---



## Getting the regression.

For this experiment we are going to use the median of the student_view variable from years 2017 and 2018 for the rest of the years and adding it to the final score.

### Loading the data


```r
library(xlsx)
data <- read.xlsx2("./cityData.xlsx", sheetIndex = 1)
for (i in 3:9){
    data[,i] <- as.numeric(as.character(data[,i]))
}

for (j in 4:9){
    for (i in 202:276){
        data[i,j] <- ceiling(data[i,j])
    }
}

str(data)
```

```
## 'data.frame':	376 obs. of  9 variables:
##  $ year         : Factor w/ 5 levels "2014","2015",..: 5 5 5 5 5 5 5 5 5 5 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

### Calculating the median from student view and pasting it to a final data set.


```r
student <- data[data$year=="2018",c("city","student_view")]
student1 <- data[data$year=="2017",c("city","student_view")]
for (j in 1:length(student$city)){
    for(i in 1:length(student1$city)){
        if(student$city[j]==student1$city[i]){
            student$student_view[j] <- ceiling(median(student$student_view[j]:student1$student_view[i]))
        }
    }
}

for (i in 202:376){
    for (j in 1:101){
        if(student$city[j]==data$city[i]){
            data$student_view[i] <- student$student_view[j]
        }
    }
}

for (i in 1:376){
    data$overall[i] <- sum(data[i,4:9], na.rm = TRUE)
}

summary(data)
```

```
##    year            city        overall         rankings     
##  2014: 50   Adelaide :  5   Min.   : 36.0   Min.   :  1.00  
##  2015: 50   Amsterdam:  5   1st Qu.:293.0   1st Qu.: 35.00  
##  2016: 75   Auckland :  5   Median :363.5   Median : 50.00  
##  2017:100   Barcelona:  5   Mean   :355.1   Mean   : 49.52  
##  2018:101   Beijing  :  5   3rd Qu.:419.0   3rd Qu.: 65.00  
##             Berlin   :  5   Max.   :502.0   Max.   :100.00  
##             (Other)  :346                   NA's   :3       
##   student_mix      desirability     emp_activity   affordability   
##  Min.   :  1.00   Min.   :  7.00   Min.   :  3.0   Min.   :  2.00  
##  1st Qu.: 45.50   1st Qu.: 50.00   1st Qu.: 53.0   1st Qu.: 35.50  
##  Median : 65.00   Median : 66.50   Median : 71.0   Median : 51.00  
##  Mean   : 61.79   Mean   : 64.19   Mean   : 67.1   Mean   : 50.31  
##  3rd Qu.: 79.50   3rd Qu.: 82.00   3rd Qu.: 82.0   3rd Qu.: 64.50  
##  Max.   :100.00   Max.   :100.00   Max.   :100.0   Max.   :100.00  
##  NA's   :1        NA's   :2        NA's   :1       NA's   :1       
##   student_view   
##  Min.   :  0.00  
##  1st Qu.: 46.00  
##  Median : 70.00  
##  Mean   : 63.42  
##  3rd Qu.: 84.00  
##  Max.   :100.00  
## 
```

### Exporting data frame.


```r
write.xlsx2(data, "city.xlsx", sheetName = "panel", row.names = FALSE)
```
