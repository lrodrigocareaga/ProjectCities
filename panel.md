---
title: 'Linear regression: Experiment 1'
author: "Ana Real"
date: "March 19, 2019"
output: 
  html_document:
    keep_md: true
---



## First Panel Data Experiment.

For this we are going to use the five years.

### Reading the data.


```r
library(xlsx)
d2014 <- read.xlsx2("best_cities.xlsx", sheetIndex = 5)
d2015 <- read.xlsx2("best_cities.xlsx", sheetIndex = 4)
d2016 <- read.xlsx2("best_cities.xlsx", sheetIndex = 3)
d2017 <- read.xlsx2("best_cities.xlsx", sheetIndex = 2)
d2018 <- read.xlsx2("best_cities.xlsx", sheetIndex = 1)
```

### Looking at the data.


```r
str(d2014)
```

```
## 'data.frame':	50 obs. of  8 variables:
##  $ rank          : Factor w/ 50 levels "1","10","11",..: 1 12 23 34 45 47 48 49 50 2 ...
##  $ city          : Factor w/ 50 levels "Adelaide","Amsterdam",..: 33 20 41 43 25 50 17 7 28 30 ...
##  $ overall       : Factor w/ 41 levels "282","283","284",..: 41 41 40 39 38 38 37 36 35 34 ...
##  $ rankings      : Factor w/ 35 levels "100","43","45",..: 33 1 23 27 29 22 32 34 26 17 ...
##  $ student_mix   : Factor w/ 37 levels "100","23","30",..: 29 36 26 34 1 24 28 27 31 18 ...
##  $ quality_living: Factor w/ 33 levels "100","36","44",..: 21 19 25 31 22 31 8 15 17 30 ...
##  $ emp_activity  : Factor w/ 35 levels "100","43","45",..: 33 33 1 31 31 27 34 31 17 18 ...
##  $ affordability : Factor w/ 37 levels "100","33","35",..: 19 6 21 4 5 23 36 14 26 32 ...
```

```r
str(d2015)
```

```
## 'data.frame':	50 obs. of  8 variables:
##  $ rank         : Factor w/ 49 levels "1","10","11",..: 1 12 23 34 44 46 47 48 49 2 ...
##  $ city         : Factor w/ 50 levels "Adelaide","Amsterdam",..: 32 24 20 43 18 7 45 27 46 39 ...
##  $ overall      : Factor w/ 46 levels "280","287","289",..: 46 45 44 43 42 41 40 39 38 37 ...
##  $ rankings     : Factor w/ 32 levels "100","28","34",..: 32 25 1 23 27 28 29 21 20 31 ...
##  $ student_mix  : Factor w/ 32 levels "100","32","42",..: 23 1 28 30 21 25 7 31 26 14 ...
##  $ desirability : Factor w/ 30 levels "100","33","46",..: 21 28 16 30 26 17 29 21 1 12 ...
##  $ emp_activity : Factor w/ 34 levels "100","39","45",..: 33 32 1 32 24 1 32 20 18 32 ...
##  $ affordability: Factor w/ 32 levels "28","31","33",..: 16 7 1 4 21 12 20 19 13 16 ...
```

```r
str(d2016)
```

```
## 'data.frame':	75 obs. of  8 variables:
##  $ rank         : Factor w/ 75 levels "1","10","11",..: 1 12 23 34 45 56 67 74 75 2 ...
##  $ city         : Factor w/ 75 levels "Adelaide","Amsterdam",..: 49 37 67 65 32 63 41 27 8 60 ...
##  $ overall      : Factor w/ 60 levels "221","223","225",..: 60 59 58 57 56 55 54 53 52 51 ...
##  $ rankings     : Factor w/ 70 levels "100","10.2","16",..: 69 60 67 55 1 58 53 64 33 68 ...
##  $ student_mix  : Factor w/ 68 levels "100","27.9","30.7",..: 49 1 14 68 63 51 67 46 40 25 ...
##  $ desirability : Factor w/ 69 levels "100","18","25.5",..: 49 63 67 1 54 60 61 56 62 33 ...
##  $ emp_activity : Factor w/ 71 levels "100","19.6","20",..: 62 67 1 63 70 64 46 58 45 68 ...
##  $ affordability: Factor w/ 70 levels "15.3","16.8",..: 47 29 48 24 1 41 44 43 67 40 ...
```

```r
str(d2017)
```

```
## 'data.frame':	100 obs. of  9 variables:
##  $ rank         : Factor w/ 100 levels "1","10","100",..: 40 31 81 65 63 22 87 55 17 25 ...
##  $ city         : Factor w/ 100 levels "Adelaide","Amsterdam",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ overall      : Factor w/ 83 levels "186","198","204",..: 48 54 17 30 31 59 12 37 62 58 ...
##  $ affordability: Factor w/ 57 levels "1","10","100",..: 11 18 36 50 9 13 46 42 40 28 ...
##  $ desirability : Factor w/ 60 levels "100","13","15",..: 48 59 8 23 31 52 27 13 40 23 ...
##  $ emp_activity : Factor w/ 63 levels "100","11","13",..: 31 33 13 24 32 40 23 38 39 61 ...
##  $ rankings     : Factor w/ 56 levels "10","100","16",..: 22 31 16 8 34 24 39 21 26 49 ...
##  $ student_mix  : Factor w/ 52 levels "100","11","19",..: 49 26 16 19 27 50 24 4 33 17 ...
##  $ student_view : Factor w/ 64 levels "1","100","12",..: 31 39 33 20 10 29 4 58 48 36 ...
```

```r
str(d2018)
```

```
## 'data.frame':	101 obs. of  9 variables:
##  $ rank         : Factor w/ 97 levels "1","10","100",..: 1 13 24 35 46 57 68 79 90 2 ...
##  $ city         : Factor w/ 101 levels "Aberdeen","Adelaide",..: 46 91 52 58 70 61 12 101 89 83 ...
##  $ overall      : Factor w/ 92 levels "217","223","224",..: 92 91 90 89 88 87 86 85 84 83 ...
##  $ affordability: Factor w/ 59 levels "1","100","11",..: 10 34 16 28 20 42 45 24 9 26 ...
##  $ emp_activity : Factor w/ 60 levels "1","10","100",..: 60 3 55 50 56 48 50 57 53 59 ...
##  $ desirability : Factor w/ 62 levels "100","14","15",..: 50 62 58 56 50 56 55 60 61 39 ...
##  $ student_mix  : Factor w/ 54 levels "100","22","26",..: 50 23 1 52 43 37 38 46 54 31 ...
##  $ rankings     : Factor w/ 54 levels "10","100","16",..: 2 52 46 37 54 35 30 41 42 54 ...
##  $ student_view : Factor w/ 64 levels "1","10","100",..: 59 56 63 3 51 64 61 49 58 53 ...
```

### Preparing the data:

* Adding a year variable.
* Eliminating the rank variable.
* Change quality_living for desirability in 2014.
* Turning numeric variables to numeric.
* Adding student view variable to 2014-2016 data frames.
* Pasting the 5 data frames.


```r
d2014$rank <- "2014"
d2014$student_view <- "0"
colnames(d2014) <- c("rank", "city", "overall", "rankings", "student_mix", "desirability", "emp_activity", "affordability", "student_view")
d2015$rank <- "2015"
d2015$student_view <- "0"
d2016$rank <- "2016"
d2016$student_view <- "0"
d2017$rank <- "2017"
d2018$rank <- "2018"
data <- rbind(d2018,d2017,d2016,d2015,d2014)
colnames(data) <- c("year", "city", "overall", "rankings", "student_mix", "desirability", "emp_activity", "affordability", "student_view")

# Looking at the data

head(data)
```

```
##   year      city overall rankings student_mix desirability emp_activity
## 1 2018    London     482       25          93           80           92
## 2 2018     Tokyo     479       54         100           97           55
## 3 2018 Melbourne     475       33          86           91          100
## 4 2018  Montreal     465       47          80           89           94
## 5 2018     Paris     463       38          88           80           80
## 6 2018    Munich     460       67          78           89           74
##   affordability student_view
## 1           100           92
## 2            84           89
## 3            68           98
## 4            57          100
## 5            93           84
## 6            54           99
```

```r
str(data)
```

```
## 'data.frame':	376 obs. of  9 variables:
##  $ year         : chr  "2018" "2018" "2018" "2018" ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 46 91 52 58 70 61 12 101 89 83 ...
##  $ overall      : Factor w/ 203 levels "217","223","224",..: 92 91 90 89 88 87 86 85 84 83 ...
##  $ rankings     : Factor w/ 147 levels "1","100","11",..: 10 34 16 28 20 42 45 24 9 26 ...
##  $ student_mix  : Factor w/ 150 levels "1","10","100",..: 60 3 55 50 56 48 50 57 53 59 ...
##  $ desirability : Factor w/ 148 levels "100","14","15",..: 50 62 58 56 50 56 55 60 61 39 ...
##  $ emp_activity : Factor w/ 140 levels "100","22","26",..: 50 23 1 52 43 37 38 46 54 31 ...
##  $ affordability: Factor w/ 140 levels "10","100","16",..: 2 52 46 37 54 35 30 41 42 54 ...
##  $ student_view : Factor w/ 84 levels "1","10","100",..: 59 56 63 3 51 64 61 49 58 53 ...
```

```r
# Turning variables to numeric

for(i in c(1,3:9)){
    data[,i] <- as.numeric(as.character(data[,i]))
}
```

```
## Warning: NAs introduced by coercion

## Warning: NAs introduced by coercion
```

```r
str(data)
```

```
## 'data.frame':	376 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 46 91 52 58 70 61 12 101 89 83 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Checking for NA's

sum(is.na(data$year))
```

```
## [1] 0
```

```r
sum(is.na(data$city))
```

```
## [1] 0
```

```r
sum(is.na(data$overall))
```

```
## [1] 0
```

```r
sum(is.na(data$rankings))
```

```
## [1] 3
```

```r
sum(is.na(data$student_mix))
```

```
## [1] 1
```

```r
sum(is.na(data$desirability))
```

```
## [1] 2
```

```r
sum(is.na(data$emp_activity))
```

```
## [1] 1
```

```r
sum(is.na(data$affordability))
```

```
## [1] 1
```

```r
sum(is.na(data$student_view))
```

```
## [1] 0
```

```r
# Exporting a xlsx file

write.xlsx2(data, "cityData.xlsx", sheetName = "panel", row.names = FALSE)
```

### First Data regression.


```r
fit <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view, data=data)
summary(fit)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view, data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -51.200  -8.754   1.130   9.227  38.759 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   14.31297    4.66637   3.067  0.00232 ** 
## rankings       1.09375    0.04048  27.019  < 2e-16 ***
## student_view   1.02140    0.02198  46.468  < 2e-16 ***
## desirability   1.08737    0.04720  23.039  < 2e-16 ***
## emp_activity   0.95200    0.05140  18.522  < 2e-16 ***
## affordability  1.79045    0.04042  44.298  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 14.44 on 366 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.953,	Adjusted R-squared:  0.9524 
## F-statistic:  1485 on 5 and 366 DF,  p-value: < 2.2e-16
```

### Adding cities as factors.


```r
fit1 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+city, data=data)
summary(fit1)$coef
```

```
##                            Estimate  Std. Error    t value      Pr(>|t|)
## (Intercept)              19.9442795 12.21873199  1.6322708  1.038471e-01
## rankings                  1.0491297  0.04371387 23.9999290  1.411463e-67
## student_view              0.9987593  0.01307341 76.3962486 1.066331e-178
## desirability              0.8634707  0.06753654 12.7852376  2.670464e-29
## emp_activity              1.2458201  0.10480295 11.8872615  2.930780e-26
## affordability             1.0773861  0.06678944 16.1310841  6.517586e-41
## cityAdelaide             19.9137143  7.49501455  2.6569280  8.379350e-03
## cityAmsterdam            31.4240011  7.97444583  3.9405874  1.048095e-04
## cityAnkara               -2.4778976  9.09481155 -0.2724518  7.854934e-01
## cityAthens               -2.5687034  8.91342284 -0.2881837  7.734384e-01
## cityAtlanta              19.4378850  7.91751981  2.4550472  1.474981e-02
## cityAuckland             35.6193869  7.70444506  4.6232255  5.987645e-06
## cityBaltimore            10.2751899  8.25797398  1.2442749  2.145320e-01
## cityBangkok              34.2077101 10.18257100  3.3594374  8.995667e-04
## cityBarcelona            32.4093006  7.34102044  4.4148223  1.489726e-05
## cityBeijing              57.3211928  8.00578920  7.1599678  8.466127e-12
## cityBerlin               40.9039181  7.72669779  5.2938421  2.570384e-07
## cityBirmingham           17.2426093  7.64064542  2.2566954  2.486753e-02
## cityBogota               40.4239181 10.03510247  4.0282517  7.403995e-05
## cityBoston               55.6902821  8.33310952  6.6830133  1.445629e-10
## cityBrighton            -27.6538574  9.26772676 -2.9838879  3.120112e-03
## cityBrisbane             25.8621932  7.73465435  3.3436780  9.499647e-04
## cityBrno                 -7.9551939  7.95899802 -0.9995220  3.184820e-01
## cityBrussels              8.1153518  7.26916520  1.1164077  2.652904e-01
## cityBudapest             19.9130308  9.55923378  2.0831200  3.822889e-02
## cityBuenos Aires         44.2097692  7.33664706  6.0258820  5.803703e-09
## cityCairo                 4.0343063  8.52956171  0.4729793  6.366294e-01
## cityCanberra             31.5344434  7.57973846  4.1603604  4.336121e-05
## cityCape Town           -30.7580703  9.85861440 -3.1199182  2.015278e-03
## cityChicago              39.7080893  8.03378180  4.9426398  1.391582e-06
## cityChristchurch          7.1962234  7.66638698  0.9386721  3.487805e-01
## cityCopenhagen           31.8275114  7.93343471  4.0118199  7.905983e-05
## cityCoventry             23.9963179  7.56290474  3.1728970  1.692818e-03
## cityDaejeon              35.4242107  8.90682212  3.9771997  9.071550e-05
## cityDubai-Sharjah-Ajman  -7.9544855  9.29362636 -0.8559076  3.928462e-01
## cityDublin               26.1449442  7.71950650  3.3868673  8.177464e-04
## cityEdinburgh            24.8079903  7.66686911  3.2357394  1.372430e-03
## cityGlasgow               8.9286665  7.58611121  1.1769754  2.402942e-01
## cityGold Coast           -9.1616622  7.65570983 -1.1967097  2.325225e-01
## cityGothenburg           23.0126749  7.83283636  2.9379747  3.603670e-03
## cityGraz                 10.1783954  9.47250802  1.0745196  2.835977e-01
## cityHelsinki             14.1736372  7.86254591  1.8026778  7.261027e-02
## cityHong Kong            44.8270458  8.06276295  5.5597623  6.758920e-08
## cityHouston              -1.9444476  8.59777873 -0.2261570  8.212591e-01
## cityHsinchu               7.8930670  8.24626107  0.9571692  3.393814e-01
## cityIstanbul             18.2599875  9.23551879  1.9771480  4.909356e-02
## cityJohannesburg         -8.6655072  9.37607704 -0.9242146  3.562415e-01
## cityKuala Lumpur         12.7611967  8.18286620  1.5595021  1.201081e-01
## cityKyoto-Osaka-Kobe     51.7229513  8.76297010  5.9024453  1.127218e-08
## cityLisbon               16.2941132  7.74522957  2.1037612  3.637116e-02
## cityLondon               54.7096690  9.18899229  5.9538268  8.560764e-09
## cityLos Angeles          42.1563985  7.64433366  5.5147251  8.503461e-08
## cityLyon                  7.7274291  7.36368016  1.0493977  2.949809e-01
## cityMadrid               29.5839800  7.31770099  4.0427971  6.985069e-05
## cityManchester           31.3210983  7.42943643  4.2158108  3.450042e-05
## cityManila               -3.4508162 10.26341022 -0.3362251  7.369755e-01
## cityMelbourne            49.5603764  8.70473493  5.6934963  3.390801e-08
## cityMexico City          48.6922545  8.85297565  5.5001004  9.159022e-08
## cityMiami                 6.9421001  9.85442625  0.7044652  4.817810e-01
## cityMilan                53.5602332  7.25681943  7.3806760  2.183842e-12
## cityMonterrey            42.2479102  9.86376742  4.2831414  2.605548e-05
## cityMontpellier         -16.2110931  8.22261213 -1.9715259  4.973633e-02
## cityMontreal             37.1402279  8.12862877  4.5690643  7.611804e-06
## cityMoscow               36.2273763  7.58350246  4.7771299  2.991809e-06
## cityMumbai               39.9078088 11.21760434  3.5576053  4.455319e-04
## cityMunich               41.8015662  7.79199337  5.3646819  1.809283e-07
## cityNagoya                1.6449859 10.37772437  0.1585112  8.741785e-01
## cityNanjing               4.0813164  9.82592798  0.4153619  6.782235e-01
## cityNewcastle Upon Tyne -16.5211748  7.68290194 -2.1503821  3.245802e-02
## cityNew York             46.0212039  8.23867666  5.5859947  5.909122e-08
## cityNottingham            8.7594611  7.54868621  1.1603954  2.469646e-01
## cityNovosibirsk          11.0885492  9.54123870  1.1621708  2.462442e-01
## cityOslo                 17.0676109  7.69240128  2.2187624  2.737683e-02
## cityOttawa               -7.4259861  7.77690813 -0.9548764  3.405375e-01
## cityParis                52.1391859  8.64653074  6.0300700  5.673481e-09
## cityPerth                14.0733526  7.53222003  1.8684203  6.284125e-02
## cityPhiladelphia         35.5530757  7.78897981  4.5645356  7.765333e-06
## cityPittsburgh           15.2347305  7.45409690  2.0438063  4.199220e-02
## cityPrague               24.3122965  7.18847200  3.3821230  8.313823e-04
## cityQuebec               -1.4124920  7.91948786 -0.1783565  8.585835e-01
## cityRio de Janeiro       18.7401631  9.96374037  1.8808361  6.112485e-02
## cityRiyadh               -8.0040908  9.04287618 -0.8851267  3.769157e-01
## cityRome                -13.7675538  7.67541280 -1.7937216  7.403313e-02
## citySan Diego            -9.6723473  8.01389556 -1.2069470  2.285623e-01
## citySan Francisco        49.3544168  7.96755477  6.1944245  2.308354e-09
## citySantiago             52.9913381  8.22656684  6.4414888  5.789073e-10
## citySao Paulo            44.8954539  9.04363938  4.9643127  1.257023e-06
## citySeoul                55.3508987  8.15148549  6.7902837  7.721784e-11
## cityShanghai             50.4498185  8.08189909  6.2423223  1.770567e-09
## citySingapore            53.8217214  7.98842200  6.7374660  1.052373e-10
## cityStockholm            50.6818042  7.98054111  6.3506727  9.666838e-10
## citySt. Petersburg        4.4522392  9.31693612  0.4778652  6.331524e-01
## cityStuttgart            14.6046954  9.36068734  1.5602161  1.199394e-01
## citySydney               51.0855833  8.65793007  5.9004384  1.139358e-08
## cityTaipei               32.5381049  7.95909809  4.0881648  5.818539e-05
## cityTokyo                67.6661187  8.63928233  7.8323773  1.262276e-13
## cityTomsk                -3.3615546  9.06359032 -0.3708855  7.110283e-01
## cityToronto              34.9076001  8.19880723  4.2576437  2.899003e-05
## cityToulouse            -13.9365398  7.75575966 -1.7969278  7.352116e-02
## cityValencia             -6.9626735  8.11162329 -0.8583576  3.914949e-01
## cityVancouver            34.1079663  7.95448219  4.2878927  2.554101e-05
## cityVienna               26.1391376  7.85116931  3.3293305  9.981228e-04
## cityVilnius              17.7107438  9.82044179  1.8034569  7.248757e-02
## cityWarsaw               23.0626210  8.76096198  2.6324302  8.990823e-03
## cityWashington DC        22.8366991  7.55177349  3.0240180  2.746988e-03
## cityZurich               48.8662792  8.16645128  5.9837838  7.286263e-09
## cityKiev                  7.0011978 12.16308609  0.5756103  5.653823e-01
## cityLille                 2.7227961  9.94341163  0.2738292  7.844359e-01
## cityLima                 26.4431891 11.65902065  2.2680455  2.415674e-02
## cityNew Delhi            33.8758637 12.36344639  2.7400017  6.574475e-03
## citySharjah               3.3268274  8.19711227  0.4058536  6.851879e-01
## cityTampere             -13.5353551  9.89718324 -1.3675967  1.726331e-01
## cityWuhan                -5.3268104 10.94458678 -0.4867073  6.268806e-01
## cityKyoto                41.1926824  9.62586985  4.2793725  2.647060e-05
## cityOsaka                20.1517705 10.17128782  1.9812408  4.863005e-02
```

### Adding year as factor.


```r
fit2 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+city+factor(year), data=data)
summary(fit2)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + city + factor(year), 
##     data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -19.189  -2.455   0.000   3.038  21.479 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)              25.72512   13.82720   1.860 0.063979 .  
## rankings                  1.01693    0.04790  21.230  < 2e-16 ***
## student_view              1.02096    0.03039  33.593  < 2e-16 ***
## desirability              0.86059    0.06964  12.358  < 2e-16 ***
## emp_activity              1.15535    0.11915   9.696  < 2e-16 ***
## affordability             1.14440    0.11935   9.589  < 2e-16 ***
## cityAdelaide             20.00922    7.54879   2.651 0.008540 ** 
## cityAmsterdam            28.13770    8.23719   3.416 0.000740 ***
## cityAnkara               -4.46308    9.17776  -0.486 0.627180    
## cityAthens               -2.88370    9.04680  -0.319 0.750176    
## cityAtlanta              16.54884    8.20398   2.017 0.044734 *  
## cityAuckland             35.84966    7.76848   4.615 6.26e-06 ***
## cityBaltimore             6.46139    8.76809   0.737 0.461853    
## cityBangkok              29.31083   10.50553   2.790 0.005671 ** 
## cityBarcelona            30.77219    7.55422   4.074 6.20e-05 ***
## cityBeijing              52.04519    9.18106   5.669 3.91e-08 ***
## cityBerlin               39.88801    7.93232   5.029 9.37e-07 ***
## cityBirmingham           15.71496    7.72488   2.034 0.042961 *  
## cityBogota               35.98001   10.42451   3.451 0.000653 ***
## cityBoston               52.23966    9.46299   5.520 8.37e-08 ***
## cityBrighton            -27.15663    9.31238  -2.916 0.003861 ** 
## cityBrisbane             24.92986    8.04884   3.097 0.002173 ** 
## cityBrno                 -6.09548    8.50495  -0.717 0.474222    
## cityBrussels              8.31528    7.27460   1.143 0.254095    
## cityBudapest             19.51233    9.79460   1.992 0.047429 *  
## cityBuenos Aires         41.80262    7.79198   5.365 1.83e-07 ***
## cityCairo                 4.06258    8.62527   0.471 0.638040    
## cityCanberra             29.90192    7.89959   3.785 0.000192 ***
## cityCape Town           -33.39400    9.94906  -3.356 0.000911 ***
## cityChicago              35.82629    8.87455   4.037 7.18e-05 ***
## cityChristchurch          7.83911    7.70532   1.017 0.309953    
## cityCopenhagen           28.93879    8.23702   3.513 0.000524 ***
## cityCoventry             24.02716    7.75363   3.099 0.002162 ** 
## cityDaejeon              31.68006    9.37868   3.378 0.000846 ***
## cityDubai-Sharjah-Ajman  -7.55547    9.44371  -0.800 0.424430    
## cityDublin               24.60089    8.07157   3.048 0.002549 ** 
## cityEdinburgh            23.40383    8.14926   2.872 0.004426 ** 
## cityGlasgow               7.76522    7.73943   1.003 0.316659    
## cityGold Coast           -7.86768    7.77438  -1.012 0.312505    
## cityGothenburg           20.94555    7.89933   2.652 0.008518 ** 
## cityGraz                 11.73637    9.86727   1.189 0.235388    
## cityHelsinki             11.25812    8.11030   1.388 0.166319    
## cityHong Kong            42.09521    9.01017   4.672 4.85e-06 ***
## cityHouston              -4.67981    8.85593  -0.528 0.597659    
## cityHsinchu               7.21829    8.39816   0.860 0.390874    
## cityIstanbul             14.94556    9.40095   1.590 0.113130    
## cityJohannesburg         -9.33325    9.52926  -0.979 0.328303    
## cityKuala Lumpur         11.52095    8.24024   1.398 0.163298    
## cityKyoto-Osaka-Kobe     46.31901    9.72049   4.765 3.19e-06 ***
## cityLisbon               16.46139    7.75387   2.123 0.034726 *  
## cityLondon               50.65517   11.04673   4.586 7.13e-06 ***
## cityLos Angeles          38.86921    8.09627   4.801 2.71e-06 ***
## cityLyon                  7.63363    7.41958   1.029 0.304533    
## cityMadrid               28.59611    7.38552   3.872 0.000138 ***
## cityManchester           30.44524    7.73447   3.936 0.000107 ***
## cityManila               -6.47354   10.49198  -0.617 0.537790    
## cityMelbourne            48.30733    9.40272   5.138 5.56e-07 ***
## cityMexico City          44.35999    9.30500   4.767 3.15e-06 ***
## cityMiami                 4.58611   10.12458   0.453 0.650960    
## cityMilan                51.81261    7.33438   7.064 1.56e-11 ***
## cityMonterrey            39.71504   10.05781   3.949 0.000102 ***
## cityMontpellier         -13.24932    8.54946  -1.550 0.122458    
## cityMontreal             36.43952    8.64350   4.216 3.47e-05 ***
## cityMoscow               32.75371    8.12346   4.032 7.32e-05 ***
## cityMumbai               34.98530   11.75435   2.976 0.003199 ** 
## cityMunich               40.36776    8.09129   4.989 1.13e-06 ***
## cityNagoya               -0.46964   10.91465  -0.043 0.965713    
## cityNanjing              -0.14224   10.07232  -0.014 0.988744    
## cityNewcastle Upon Tyne -17.16896    7.93856  -2.163 0.031499 *  
## cityNew York             41.33720    9.42896   4.384 1.71e-05 ***
## cityNottingham            7.57444    7.69032   0.985 0.325599    
## cityNovosibirsk          10.46278    9.74584   1.074 0.284041    
## cityOslo                 15.24597    7.74302   1.969 0.050045 .  
## cityOttawa               -6.55019    7.86806  -0.833 0.405909    
## cityParis                48.17748   10.42609   4.621 6.09e-06 ***
## cityPerth                13.20768    7.63838   1.729 0.085007 .  
## cityPhiladelphia         31.65924    8.34477   3.794 0.000186 ***
## cityPittsburgh           13.18545    7.67438   1.718 0.086999 .  
## cityPrague               24.34817    7.25025   3.358 0.000905 ***
## cityQuebec                0.14288    8.14273   0.018 0.986014    
## cityRio de Janeiro       15.25795   10.24996   1.489 0.137842    
## cityRiyadh               -8.09189    9.09090  -0.890 0.374253    
## cityRome                -14.39154    7.68119  -1.874 0.062137 .  
## citySan Diego           -12.69710    8.29206  -1.531 0.126960    
## citySan Francisco        45.54198    8.78004   5.187 4.38e-07 ***
## citySantiago             48.94649    8.54970   5.725 2.92e-08 ***
## citySao Paulo            40.54544    9.53028   4.254 2.95e-05 ***
## citySeoul                50.32596    9.89045   5.088 7.05e-07 ***
## cityShanghai             45.22098    8.90705   5.077 7.44e-07 ***
## citySingapore            51.54783    8.54325   6.034 5.66e-09 ***
## cityStockholm            47.13938    8.25846   5.708 3.19e-08 ***
## citySt. Petersburg        3.33420    9.47452   0.352 0.725197    
## cityStuttgart            16.59346    9.56387   1.735 0.083956 .  
## citySydney               49.64543    9.17496   5.411 1.45e-07 ***
## cityTaipei               28.30171    8.80011   3.216 0.001469 ** 
## cityTokyo                61.94204   10.06746   6.153 2.96e-09 ***
## cityTomsk                -2.51478    9.17720  -0.274 0.784289    
## cityToronto              33.93060    8.50243   3.991 8.63e-05 ***
## cityToulouse            -11.69111    7.94274  -1.472 0.142284    
## cityValencia             -5.63139    8.34523  -0.675 0.500417    
## cityVancouver            33.86142    8.12263   4.169 4.21e-05 ***
## cityVienna               27.28634    7.89166   3.458 0.000639 ***
## cityVilnius              16.52585   10.15284   1.628 0.104832    
## cityWarsaw               22.54408    8.91224   2.530 0.012028 *  
## cityWashington DC        19.82640    7.78260   2.548 0.011441 *  
## cityZurich               47.00800    8.64790   5.436 1.28e-07 ***
## cityKiev                  5.42991   12.45802   0.436 0.663313    
## cityLille                 3.91215   10.29212   0.380 0.704182    
## cityLima                 24.54520   12.01291   2.043 0.042065 *  
## cityNew Delhi            29.55839   12.80002   2.309 0.021736 *  
## citySharjah               5.48061    8.55769   0.640 0.522472    
## cityTampere             -13.04084   10.16388  -1.283 0.200646    
## cityWuhan                -7.63671   11.13011  -0.686 0.493259    
## cityKyoto                36.78888   10.00059   3.679 0.000286 ***
## cityOsaka                14.97717   10.59809   1.413 0.158827    
## factor(year)2015          2.63875    2.31145   1.142 0.254698    
## factor(year)2016          0.65031    2.33837   0.278 0.781159    
## factor(year)2017         -1.59181    3.01395  -0.528 0.597860    
## factor(year)2018         -0.46690    3.14751  -0.148 0.882192    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.499 on 253 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9934,	Adjusted R-squared:  0.9903 
## F-statistic: 323.6 on 118 and 253 DF,  p-value: < 2.2e-16
```

### Using Mexico City as reference.


```r
mexico <- relevel(data$city, "Mexico City")
fit3 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data)
summary(fit3)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -19.189  -2.455   0.000   3.038  21.479 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                70.08511   10.30543   6.801 7.46e-11 ***
## rankings                    1.01693    0.04790  21.230  < 2e-16 ***
## student_view                1.02096    0.03039  33.593  < 2e-16 ***
## desirability                0.86059    0.06964  12.358  < 2e-16 ***
## emp_activity                1.15535    0.11915   9.696  < 2e-16 ***
## affordability               1.14440    0.11935   9.589  < 2e-16 ***
## mexicoAberdeen            -44.35999    9.30500  -4.767 3.15e-06 ***
## mexicoAdelaide            -24.35077    8.68495  -2.804 0.005442 ** 
## mexicoAmsterdam           -16.22230    7.02626  -2.309 0.021761 *  
## mexicoAnkara              -48.82307    6.24456  -7.819 1.44e-13 ***
## mexicoAthens              -47.24369    6.82493  -6.922 3.64e-11 ***
## mexicoAtlanta             -27.81116    6.60350  -4.212 3.53e-05 ***
## mexicoAuckland             -8.51034    9.10629  -0.935 0.350909    
## mexicoBaltimore           -37.89860    6.55364  -5.783 2.16e-08 ***
## mexicoBangkok             -15.04917    5.75873  -2.613 0.009505 ** 
## mexicoBarcelona           -13.58781    6.95956  -1.952 0.051994 .  
## mexicoBeijing               7.68520    5.93190   1.296 0.196304    
## mexicoBerlin               -4.47199    7.68040  -0.582 0.560910    
## mexicoBirmingham          -28.64503    7.09264  -4.039 7.13e-05 ***
## mexicoBogota               -8.37998    5.74426  -1.459 0.145848    
## mexicoBoston                7.87967    9.57874   0.823 0.411499    
## mexicoBrighton            -71.51663    9.78428  -7.309 3.52e-12 ***
## mexicoBrisbane            -19.43013    9.05723  -2.145 0.032884 *  
## mexicoBrno                -50.45548    8.83894  -5.708 3.19e-08 ***
## mexicoBrussels            -36.04471    7.54982  -4.774 3.06e-06 ***
## mexicoBudapest            -24.84767    7.45163  -3.335 0.000982 ***
## mexicoBuenos Aires         -2.55738    6.92588  -0.369 0.712251    
## mexicoCairo               -40.29741    7.68668  -5.242 3.34e-07 ***
## mexicoCanberra            -14.45808    8.25858  -1.751 0.081214 .  
## mexicoCape Town           -77.75400    7.65505 -10.157  < 2e-16 ***
## mexicoChicago              -8.53371    8.11040  -1.052 0.293715    
## mexicoChristchurch        -36.52089    7.44567  -4.905 1.67e-06 ***
## mexicoCopenhagen          -15.42120    8.13638  -1.895 0.059187 .  
## mexicoCoventry            -20.33283    8.92477  -2.278 0.023546 *  
## mexicoDaejeon             -12.67994    5.02630  -2.523 0.012259 *  
## mexicoDubai-Sharjah-Ajman -51.91547    9.81712  -5.288 2.67e-07 ***
## mexicoDublin              -19.75910    8.86963  -2.228 0.026779 *  
## mexicoEdinburgh           -20.95616    8.89377  -2.356 0.019222 *  
## mexicoGlasgow             -36.59477    7.76735  -4.711 4.06e-06 ***
## mexicoGold Coast          -52.22767    8.17431  -6.389 7.95e-10 ***
## mexicoGothenburg          -23.41444    7.33646  -3.192 0.001594 ** 
## mexicoGraz                -32.62363    9.70920  -3.360 0.000900 ***
## mexicoHelsinki            -33.10187    6.16620  -5.368 1.80e-07 ***
## mexicoHong Kong            -2.26479    8.63741  -0.262 0.793375    
## mexicoHouston             -49.03981    6.58468  -7.448 1.50e-12 ***
## mexicoHsinchu             -37.14171    5.53596  -6.709 1.27e-10 ***
## mexicoIstanbul            -29.41443    5.99037  -4.910 1.63e-06 ***
## mexicoJohannesburg        -53.69325    6.80456  -7.891 9.08e-14 ***
## mexicoKuala Lumpur        -32.83904    5.29645  -6.200 2.28e-09 ***
## mexicoKyoto-Osaka-Kobe      1.95902    6.53987   0.300 0.764767    
## mexicoLisbon              -27.89860    6.91839  -4.033 7.31e-05 ***
## mexicoLondon                6.29517   11.30098   0.557 0.577988    
## mexicoLos Angeles          -5.49079    7.28658  -0.754 0.451821    
## mexicoLyon                -36.72636    6.91641  -5.310 2.40e-07 ***
## mexicoMadrid              -15.76388    6.86350  -2.297 0.022449 *  
## mexicoManchester          -13.91475    8.43746  -1.649 0.100355    
## mexicoManila              -50.83354    6.20358  -8.194 1.26e-14 ***
## mexicoMelbourne             3.94734   10.71176   0.369 0.712805    
## mexicoMiami               -39.77389    8.70609  -4.569 7.68e-06 ***
## mexicoMilan                 7.45262    6.50369   1.146 0.252917    
## mexicoMonterrey            -4.64496    5.61524  -0.827 0.408900    
## mexicoMontpellier         -57.60931    8.34854  -6.901 4.14e-11 ***
## mexicoMontreal             -7.92047    9.66300  -0.820 0.413176    
## mexicoMoscow              -11.60629    5.48495  -2.116 0.035320 *  
## mexicoMumbai               -9.37470    6.72180  -1.395 0.164339    
## mexicoMunich               -3.99223    7.72344  -0.517 0.605679    
## mexicoNagoya              -44.82963    7.86583  -5.699 3.34e-08 ***
## mexicoNanjing             -44.50223    5.90099  -7.541 8.33e-13 ***
## mexicoNewcastle Upon Tyne -61.52895    8.15002  -7.550 7.92e-13 ***
## mexicoNew York             -3.02279    8.71829  -0.347 0.729091    
## mexicoNottingham          -36.78555    7.66921  -4.797 2.76e-06 ***
## mexicoNovosibirsk         -33.89721    6.51137  -5.206 4.00e-07 ***
## mexicoOslo                -29.11403    6.81973  -4.269 2.78e-05 ***
## mexicoOttawa              -50.91019    8.78943  -5.792 2.05e-08 ***
## mexicoParis                 3.81749   10.02076   0.381 0.703554    
## mexicoPerth               -31.15232    8.40070  -3.708 0.000256 ***
## mexicoPhiladelphia        -12.70075    6.78171  -1.873 0.062250 .  
## mexicoPittsburgh          -31.17454    6.83196  -4.563 7.87e-06 ***
## mexicoPrague              -20.01182    7.34469  -2.725 0.006886 ** 
## mexicoQuebec              -44.21711    8.16190  -5.418 1.41e-07 ***
## mexicoRio de Janeiro      -29.10205    6.21323  -4.684 4.60e-06 ***
## mexicoRiyadh              -52.45188    6.68094  -7.851 1.17e-13 ***
## mexicoRome                -58.75153    6.70025  -8.769 2.71e-16 ***
## mexicoSan Diego           -57.05710    6.56005  -8.698 4.38e-16 ***
## mexicoSan Francisco         1.18198    8.10426   0.146 0.884158    
## mexicoSantiago              4.58650    4.53043   1.012 0.312325    
## mexicoSao Paulo            -3.81455    4.93605  -0.773 0.440366    
## mexicoSeoul                 5.96597    8.35762   0.714 0.475987    
## mexicoShanghai              0.86099    5.10482   0.169 0.866197    
## mexicoSingapore             7.18784    8.59356   0.836 0.403707    
## mexicoStockholm             2.77938    7.48640   0.371 0.710756    
## mexicoSt. Petersburg      -41.02580    6.13187  -6.691 1.42e-10 ***
## mexicoStuttgart           -27.76654    9.44221  -2.941 0.003578 ** 
## mexicoSydney                5.28544   10.34783   0.511 0.609952    
## mexicoTaipei              -16.05829    5.49993  -2.920 0.003819 ** 
## mexicoTokyo                17.58205    7.74641   2.270 0.024068 *  
## mexicoTomsk               -46.87478    7.10362  -6.599 2.41e-10 ***
## mexicoToronto             -10.42940    9.41577  -1.108 0.269064    
## mexicoToulouse            -56.05110    7.96257  -7.039 1.81e-11 ***
## mexicoValencia            -49.99138    7.34488  -6.806 7.22e-11 ***
## mexicoVancouver           -10.49858    9.25365  -1.135 0.257644    
## mexicoVienna              -17.07366    9.15900  -1.864 0.063460 .  
## mexicoVilnius             -27.83415    7.34673  -3.789 0.000189 ***
## mexicoWarsaw              -21.81592    6.53567  -3.338 0.000971 ***
## mexicoWashington DC       -24.53359    6.92898  -3.541 0.000475 ***
## mexicoZurich                2.64800    8.93327   0.296 0.767152    
## mexicoKiev                -38.93009    8.98687  -4.332 2.13e-05 ***
## mexicoLille               -40.44784    8.99262  -4.498 1.05e-05 ***
## mexicoLima                -19.81480    8.42904  -2.351 0.019502 *  
## mexicoNew Delhi           -14.80160    8.11961  -1.823 0.069492 .  
## mexicoSharjah             -38.87938    9.15238  -4.248 3.03e-05 ***
## mexicoTampere             -57.40084    8.93569  -6.424 6.55e-10 ***
## mexicoWuhan               -51.99671    7.79311  -6.672 1.58e-10 ***
## mexicoKyoto                -7.57111    8.29340  -0.913 0.362160    
## mexicoOsaka               -29.38282    8.05081  -3.650 0.000319 ***
## factor(year)2015            2.63875    2.31145   1.142 0.254698    
## factor(year)2016            0.65031    2.33837   0.278 0.781159    
## factor(year)2017           -1.59181    3.01395  -0.528 0.597860    
## factor(year)2018           -0.46690    3.14751  -0.148 0.882192    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.499 on 253 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9934,	Adjusted R-squared:  0.9903 
## F-statistic: 323.6 on 118 and 253 DF,  p-value: < 2.2e-16
```

### Using London as reference.


```r
london <- relevel(data$city, "London")
fit4 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+london+factor(year), data=data)
summary(fit4)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + london + factor(year), 
##     data = data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -19.189  -2.455   0.000   3.038  21.479 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                76.38028   18.97918   4.024 7.55e-05 ***
## rankings                    1.01693    0.04790  21.230  < 2e-16 ***
## student_view                1.02096    0.03039  33.593  < 2e-16 ***
## desirability                0.86059    0.06964  12.358  < 2e-16 ***
## emp_activity                1.15535    0.11915   9.696  < 2e-16 ***
## affordability               1.14440    0.11935   9.589  < 2e-16 ***
## londonAberdeen            -50.65517   11.04673  -4.586 7.13e-06 ***
## londonAdelaide            -30.64595    8.02976  -3.817 0.000170 ***
## londonAmsterdam           -22.51747    8.09894  -2.780 0.005839 ** 
## londonAnkara              -55.11825   12.51591  -4.404 1.57e-05 ***
## londonAthens              -53.53886   13.00493  -4.117 5.20e-05 ***
## londonAtlanta             -34.10633    8.48512  -4.020 7.70e-05 ***
## londonAuckland            -14.80551    7.87826  -1.879 0.061355 .  
## londonBaltimore           -44.19377    8.54574  -5.171 4.73e-07 ***
## londonBangkok             -21.34434   13.25231  -1.611 0.108511    
## londonBarcelona           -19.88298    7.69619  -2.583 0.010343 *  
## londonBeijing               1.39003    7.64225   0.182 0.855817    
## londonBerlin              -10.76716    7.74739  -1.390 0.165818    
## londonBirmingham          -34.94020    8.80977  -3.966 9.52e-05 ***
## londonBogota              -14.67515   12.96366  -1.132 0.258697    
## londonBoston                1.58449    4.71582   0.336 0.737153    
## londonBrighton            -77.81180   11.71928  -6.640 1.91e-10 ***
## londonBrisbane            -25.72531    6.60382  -3.896 0.000125 ***
## londonBrno                -56.75065   13.10116  -4.332 2.13e-05 ***
## londonBrussels            -42.33988    9.10165  -4.652 5.31e-06 ***
## londonBudapest            -31.14284   14.26539  -2.183 0.029947 *  
## londonBuenos Aires         -8.85255    7.24949  -1.221 0.223175    
## londonCairo               -46.59258   12.22256  -3.812 0.000173 ***
## londonCanberra            -20.75325    6.64708  -3.122 0.002004 ** 
## londonCape Town           -84.04917   12.57309  -6.685 1.47e-10 ***
## londonChicago             -14.82888    6.04269  -2.454 0.014802 *  
## londonChristchurch        -42.81606   10.24910  -4.178 4.06e-05 ***
## londonCopenhagen          -21.71637    6.86935  -3.161 0.001762 ** 
## londonCoventry            -26.62800    8.21296  -3.242 0.001345 ** 
## londonDaejeon             -18.97511   11.19778  -1.695 0.091393 .  
## londonDubai-Sharjah-Ajman -58.21064   12.42261  -4.686 4.56e-06 ***
## londonDublin              -26.05427    6.44583  -4.042 7.04e-05 ***
## londonEdinburgh           -27.25133    6.27963  -4.340 2.06e-05 ***
## londonGlasgow             -42.88994    8.30167  -5.166 4.84e-07 ***
## londonGold Coast          -58.52284   10.91208  -5.363 1.85e-07 ***
## londonGothenburg          -29.70961    9.50431  -3.126 0.001979 ** 
## londonGraz                -38.91880   13.73492  -2.834 0.004974 ** 
## londonHelsinki            -39.39704    8.83354  -4.460 1.23e-05 ***
## londonHong Kong            -8.55996    5.75912  -1.486 0.138437    
## londonHouston             -55.33498   10.27112  -5.387 1.63e-07 ***
## londonHsinchu             -43.43688   11.18045  -3.885 0.000131 ***
## londonIstanbul            -35.70960   12.49396  -2.858 0.004616 ** 
## londonJohannesburg        -59.98842   13.75967  -4.360 1.90e-05 ***
## londonKuala Lumpur        -39.13421   10.95961  -3.571 0.000426 ***
## londonKyoto-Osaka-Kobe     -4.33616    8.64822  -0.501 0.616531    
## londonLisbon              -34.19377   10.76902  -3.175 0.001683 ** 
## londonLos Angeles         -11.78596    6.81727  -1.729 0.085058 .  
## londonLyon                -43.02154    8.99316  -4.784 2.92e-06 ***
## londonMadrid              -22.05905    8.47786  -2.602 0.009816 ** 
## londonManchester          -20.20992    7.07064  -2.858 0.004614 ** 
## londonManila              -57.12871   14.16322  -4.034 7.28e-05 ***
## londonMelbourne            -2.34783    5.37711  -0.437 0.662749    
## londonMexico City          -6.29517   11.30098  -0.557 0.577988    
## londonMiami               -46.06906   12.77882  -3.605 0.000376 ***
## londonMilan                 1.15745    8.72318   0.133 0.894547    
## londonMonterrey           -10.94013   13.78533  -0.794 0.428168    
## londonMontpellier         -63.90448   12.47935  -5.121 6.03e-07 ***
## londonMontreal            -14.21565    6.08678  -2.335 0.020300 *  
## londonMoscow              -17.90146    8.26699  -2.165 0.031291 *  
## londonMumbai              -15.66987   15.10303  -1.038 0.300479    
## londonMunich              -10.28740    7.37583  -1.395 0.164316    
## londonNagoya              -51.12480   13.47454  -3.794 0.000185 ***
## londonNanjing             -50.79741   13.07349  -3.886 0.000130 ***
## londonNewcastle Upon Tyne -67.82412    7.72391  -8.781 2.48e-16 ***
## londonNew York             -9.31797    5.17768  -1.800 0.073109 .  
## londonNottingham          -43.08072    8.76589  -4.915 1.60e-06 ***
## londonNovosibirsk         -40.19238   13.64720  -2.945 0.003529 ** 
## londonOslo                -35.40920    9.60304  -3.687 0.000277 ***
## londonOttawa              -57.20536   10.18390  -5.617 5.10e-08 ***
## londonParis                -2.47768    4.49028  -0.552 0.581580    
## londonPerth               -37.44749    7.51774  -4.981 1.17e-06 ***
## londonPhiladelphia        -18.99592    7.44862  -2.550 0.011354 *  
## londonPittsburgh          -37.46971    8.02891  -4.667 4.96e-06 ***
## londonPrague              -26.30700   10.00548  -2.629 0.009081 ** 
## londonQuebec              -50.51228   11.48778  -4.397 1.62e-05 ***
## londonRio de Janeiro      -35.39722   13.70984  -2.582 0.010390 *  
## londonRiyadh              -58.74706   12.79394  -4.592 6.93e-06 ***
## londonRome                -65.04671   10.33734  -6.292 1.37e-09 ***
## londonSan Diego           -63.35227    8.69000  -7.290 3.95e-12 ***
## londonSan Francisco        -5.11319    5.76347  -0.887 0.375829    
## londonSantiago             -1.70867   10.48844  -0.163 0.870719    
## londonSao Paulo           -10.10972   11.19401  -0.903 0.367312    
## londonSeoul                -0.32920    5.40106  -0.061 0.951446    
## londonShanghai             -5.43418    8.67441  -0.626 0.531577    
## londonSingapore             0.89267    5.98951   0.149 0.881642    
## londonStockholm            -3.51579    7.66798  -0.459 0.646985    
## londonSt. Petersburg      -47.32097   13.00294  -3.639 0.000331 ***
## londonStuttgart           -34.06171   12.31833  -2.765 0.006109 ** 
## londonSydney               -1.00974    5.67016  -0.178 0.858804    
## londonTaipei              -22.35346    8.24009  -2.713 0.007130 ** 
## londonTokyo                11.28688    6.83634   1.651 0.099977 .  
## londonTomsk               -53.16995   13.15825  -4.041 7.07e-05 ***
## londonToronto             -16.72457    6.50883  -2.570 0.010758 *  
## londonToulouse            -62.34628   11.89449  -5.242 3.36e-07 ***
## londonValencia            -56.28655   12.66333  -4.445 1.32e-05 ***
## londonVancouver           -16.79375    7.11801  -2.359 0.019068 *  
## londonVienna              -23.36883    8.75317  -2.670 0.008082 ** 
## londonVilnius             -34.12932   14.80490  -2.305 0.021961 *  
## londonWarsaw              -28.11109   13.15698  -2.137 0.033591 *  
## londonWashington DC       -30.82876    7.77961  -3.963 9.64e-05 ***
## londonZurich               -3.64717    6.12041  -0.596 0.551773    
## londonKiev                -45.22526   16.93454  -2.671 0.008063 ** 
## londonLille               -46.74302   14.35931  -3.255 0.001288 ** 
## londonLima                -26.10997   16.03349  -1.628 0.104671    
## londonNew Delhi           -21.09677   15.90543  -1.326 0.185907    
## londonSharjah             -45.17455   12.48228  -3.619 0.000357 ***
## londonTampere             -63.69601   13.38669  -4.758 3.29e-06 ***
## londonWuhan               -58.29188   14.48818  -4.023 7.58e-05 ***
## londonKyoto               -13.86628   10.29900  -1.346 0.179387    
## londonOsaka               -35.67799   11.53831  -3.092 0.002210 ** 
## factor(year)2015            2.63875    2.31145   1.142 0.254698    
## factor(year)2016            0.65031    2.33837   0.278 0.781159    
## factor(year)2017           -1.59181    3.01395  -0.528 0.597860    
## factor(year)2018           -0.46690    3.14751  -0.148 0.882192    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.499 on 253 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9934,	Adjusted R-squared:  0.9903 
## F-statistic: 323.6 on 118 and 253 DF,  p-value: < 2.2e-16
```
