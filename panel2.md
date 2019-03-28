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
```

### Working with some missing values


```r
# Hong Kong 2014 had a NA for ranking, we get that value by calculating the difference between the overall and the rest of the variables.
data[333,"rankings"] <- data[333,"overall"]-sum(data[333,c(5:9)])

# Same for Chicago

data[349,"rankings"] <- data[349,"overall"]-sum(data[349,c(5:9)])

# For Philadelphia we just know the overall, to get the values of the rest of the variables we are extracting the values of the rest of the United States' cities and get an average percentage for each variable and multiplied to get the overall we know.

UScities <- data[(data$city=="Boston"|data$city=="San Francisco"|data$city=="New York"|data$city=="Washington DC"|data$city=="Los Angeles"|data$city=="Chicago")&data$year==2014,c(3:9)]

perc <- apply(UScities,1,function(x){x[2:7]/x[1]})
num <- apply(perc,1,mean)
data[370,c(4:9)] <- data[370,3]*num

# Kyoto in 2014
data[376,6] <- data[376,"overall"]-sum(data[376,c(4,5,7,8)])

for (j in 4:9){
    for (i in 1:376){
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
##  2014: 50   Adelaide :  5   Min.   :187.0   Min.   :  1.00  
##  2015: 50   Amsterdam:  5   1st Qu.:294.5   1st Qu.: 35.75  
##  2016: 75   Auckland :  5   Median :364.5   Median : 50.00  
##  2017:100   Barcelona:  5   Mean   :356.4   Mean   : 49.61  
##  2018:101   Beijing  :  5   3rd Qu.:419.2   3rd Qu.: 65.00  
##             Berlin   :  5   Max.   :502.0   Max.   :100.00  
##             (Other)  :346                                   
##   student_mix      desirability     emp_activity    affordability   
##  Min.   :  1.00   Min.   :  7.00   Min.   :  3.00   Min.   :  2.00  
##  1st Qu.: 45.75   1st Qu.: 50.00   1st Qu.: 53.00   1st Qu.: 35.75  
##  Median : 65.00   Median : 66.00   Median : 70.50   Median : 51.00  
##  Mean   : 61.79   Mean   : 64.09   Mean   : 67.07   Mean   : 50.37  
##  3rd Qu.: 79.25   3rd Qu.: 82.00   3rd Qu.: 82.00   3rd Qu.: 65.00  
##  Max.   :100.00   Max.   :100.00   Max.   :100.00   Max.   :100.00  
##                                                                     
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

### New linear regression.


```r
str(data)
```

```
## 'data.frame':	376 obs. of  9 variables:
##  $ year         : Factor w/ 5 levels "2014","2015",..: 5 5 5 5 5 5 5 5 5 5 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 476 467 463 461 457 454 453 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
sum(is.na(data))
```

```
## [1] 0
```

```r
data$city <- as.factor(data$city)
data1 <- data[data$year!=2018,]
mexico <- relevel(data1$city, "Mexico City")
fit <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+factor(year), data=data)
summary(fit)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + factor(year), 
##     data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -51.805  -8.314  -0.397   9.315  35.865 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      10.98349    6.23928   1.760  0.07918 .  
## rankings          1.04368    0.04320  24.162  < 2e-16 ***
## student_view      1.14568    0.03389  33.802  < 2e-16 ***
## desirability      1.04241    0.04587  22.726  < 2e-16 ***
## emp_activity      0.87759    0.05244  16.735  < 2e-16 ***
## affordability     1.75122    0.04604  38.039  < 2e-16 ***
## factor(year)2015 13.84868    2.88283   4.804 2.27e-06 ***
## factor(year)2016  9.04887    2.80323   3.228  0.00136 ** 
## factor(year)2017  5.89520    2.90840   2.027  0.04339 *  
## factor(year)2018  6.83597    2.84556   2.402  0.01679 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 13.85 on 366 degrees of freedom
## Multiple R-squared:   0.97,	Adjusted R-squared:  0.9693 
## F-statistic:  1315 on 9 and 366 DF,  p-value: < 2.2e-16
```

```r
# Diagnostic of residuals.
par(mfrow=c(2,2))
plot(fit)
```

![](panel2_files/figure-html/fit-1.png)<!-- -->
