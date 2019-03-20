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
summary(fit2)$coef
```

```
##                            Estimate  Std. Error     t value     Pr(>|t|)
## (Intercept)              25.7251188 13.82719693  1.86047244 6.397894e-02
## rankings                  1.0169318  0.04790069 21.23000215 3.935084e-58
## student_view              1.0209571  0.03039215 33.59279379 3.053628e-95
## desirability              0.8605950  0.06963978 12.35780760 9.205945e-28
## emp_activity              1.1553453  0.11915459  9.69618761 4.164674e-19
## affordability             1.1443981  0.11934958  9.58862286 8.962242e-19
## cityAdelaide             20.0092203  7.54879158  2.65065211 8.540314e-03
## cityAmsterdam            28.1376974  8.23719219  3.41593309 7.403654e-04
## cityAnkara               -4.4630807  9.17776077 -0.48629299 6.271804e-01
## cityAthens               -2.8836992  9.04680058 -0.31875349 7.501764e-01
## cityAtlanta              16.5488391  8.20397984  2.01717208 4.473372e-02
## cityAuckland             35.8496588  7.76847834  4.61475945 6.260223e-06
## cityBaltimore             6.4613915  8.76808945  0.73692126 4.618530e-01
## cityBangkok              29.3108257 10.50553173  2.79003733 5.671392e-03
## cityBarcelona            30.7721880  7.55421577  4.07351193 6.200328e-05
## cityBeijing              52.0451935  9.18106466  5.66875362 3.911795e-08
## cityBerlin               39.8880071  7.93232086  5.02854181 9.368342e-07
## cityBirmingham           15.7149640  7.72488229  2.03433054 4.296132e-02
## cityBogota               35.9800113 10.42450532  3.45148381 6.532050e-04
## cityBoston               52.2396596  9.46298803  5.52041907 8.369743e-08
## cityBrighton            -27.1566318  9.31238185 -2.91618538 3.861403e-03
## cityBrisbane             24.9298592  8.04884016  3.09732318 2.172857e-03
## cityBrno                 -6.0954816  8.50495338 -0.71669783 4.742216e-01
## cityBrussels              8.3152814  7.27459643  1.14305742 2.540952e-01
## cityBudapest             19.5123268  9.79459683  1.99215212 4.742912e-02
## cityBuenos Aires         41.8026162  7.79197956  5.36482622 1.829486e-07
## cityCairo                 4.0625817  8.62527281  0.47100907 6.380401e-01
## cityCanberra             29.9019167  7.89959476  3.78524692 1.918081e-04
## cityCape Town           -33.3940034  9.94905763 -3.35649915 9.107401e-04
## cityChicago              35.8262884  8.87454656  4.03697115 7.180325e-05
## cityChristchurch          7.8391085  7.70532472  1.01736251 3.099529e-01
## cityCopenhagen           28.9387930  8.23701768  3.51326100 5.241669e-04
## cityCoventry             24.0271629  7.75362734  3.09882870 2.162253e-03
## cityDaejeon              31.6800569  9.37868394  3.37787873 8.456321e-04
## cityDubai-Sharjah-Ajman  -7.5554739  9.44370883 -0.80005367 4.244303e-01
## cityDublin               24.6008922  8.07156713  3.04784583 2.549213e-03
## cityEdinburgh            23.4038344  8.14925620  2.87189822 4.425961e-03
## cityGlasgow               7.7652227  7.73942596  1.00333316 3.166588e-01
## cityGold Coast           -7.8676789  7.77438296 -1.01200043 3.125047e-01
## cityGothenburg           20.9455509  7.89933488  2.65155881 8.518048e-03
## cityGraz                 11.7363688  9.86727365  1.18942367 2.353881e-01
## cityHelsinki             11.2581208  8.11029525  1.38812712 1.663195e-01
## cityHong Kong            42.0952051  9.01016849  4.67196647 4.850236e-06
## cityHouston              -4.6798116  8.85593354 -0.52843798 5.976586e-01
## cityHsinchu               7.2182859  8.39816454  0.85950756 3.908742e-01
## cityIstanbul             14.9455631  9.40094871  1.58979307 1.131302e-01
## cityJohannesburg         -9.3332517  9.52925845 -0.97943106 3.283027e-01
## cityKuala Lumpur         11.5209531  8.24024399  1.39813252 1.632977e-01
## cityKyoto-Osaka-Kobe     46.3190097  9.72048633  4.76509180 3.185083e-06
## cityLisbon               16.4613909  7.75386512  2.12299165 3.472573e-02
## cityLondon               50.6551654 11.04672858  4.58553544 7.125256e-06
## cityLos Angeles          38.8692057  8.09626710  4.80087987 2.705208e-06
## cityLyon                  7.6336297  7.41958347  1.02884882 3.045333e-01
## cityMadrid               28.5961114  7.38551784  3.87191691 1.375248e-04
## cityManchester           30.4452449  7.73447205  3.93630551 1.069988e-04
## cityManila               -6.4735427 10.49197745 -0.61699929 5.377900e-01
## cityMelbourne            48.3073324  9.40271541  5.13759381 5.564011e-07
## cityMexico City          44.3599942  9.30499637  4.76733063 3.152797e-06
## cityMiami                 4.5861091 10.12457650  0.45296799 6.509600e-01
## cityMilan                51.8126114  7.33437937  7.06434843 1.558706e-11
## cityMonterrey            39.7150364 10.05781330  3.94867505 1.019242e-04
## cityMontpellier         -13.2493166  8.54946409 -1.54972481 1.224576e-01
## cityMontreal             36.4395200  8.64350500  4.21582680 3.466898e-05
## cityMoscow               32.7537090  8.12346163  4.03198913 7.324842e-05
## cityMumbai               34.9852984 11.75434897  2.97637057 3.199478e-03
## cityMunich               40.3677646  8.09129235  4.98903795 1.129093e-06
## cityNagoya               -0.4696366 10.91465252 -0.04302808 9.657131e-01
## cityNanjing              -0.1422401 10.07231646 -0.01412189 9.887439e-01
## cityNewcastle Upon Tyne -17.1689581  7.93856014 -2.16272948 3.149915e-02
## cityNew York             41.3372000  9.42895767  4.38406889 1.709203e-05
## cityNottingham            7.5744418  7.69032439  0.98493138 3.255987e-01
## cityNovosibirsk          10.4627822  9.74583683  1.07356427 2.840409e-01
## cityOslo                 15.2459673  7.74301561  1.96899607 5.004490e-02
## cityOttawa               -6.5501928  7.86805731 -0.83250447 4.059094e-01
## cityParis                48.1774823 10.42608577  4.62085996 6.092860e-06
## cityPerth                13.2076769  7.63838088  1.72911997 8.500744e-02
## cityPhiladelphia         31.6592414  8.34477024  3.79390211 1.855896e-04
## cityPittsburgh           13.1854547  7.67437727  1.71811395 8.699928e-02
## cityPrague               24.3481698  7.25025494  3.35825016 9.052368e-04
## cityQuebec                0.1428836  8.14273174  0.01754738 9.860138e-01
## cityRio de Janeiro       15.2579482 10.24996263  1.48858574 1.378419e-01
## cityRiyadh               -8.0918897  9.09089577 -0.89010917 3.742529e-01
## cityRome                -14.3915407  7.68119048 -1.87360810 6.213721e-02
## citySan Diego           -12.6971027  8.29205824 -1.53123656 1.269603e-01
## citySan Francisco        45.5419759  8.78004282  5.18698790 4.382343e-07
## citySantiago             48.9464914  8.54970162  5.72493563 2.921544e-08
## citySao Paulo            40.5454425  9.53028443  4.25437906 2.953828e-05
## citySeoul                50.3259608  9.89044680  5.08834048 7.047505e-07
## cityShanghai             45.2209821  8.90705079  5.07698712 7.440319e-07
## citySingapore            51.5478331  8.54325364  6.03374724 5.662583e-09
## cityStockholm            47.1393770  8.25846179  5.70800934 3.190787e-08
## citySt. Petersburg        3.3341980  9.47452073  0.35191204 7.251972e-01
## cityStuttgart            16.5934582  9.56387017  1.73501500 8.395592e-02
## citySydney               49.6454294  9.17495954  5.41096985 1.453292e-07
## cityTaipei               28.3017092  8.80010697  3.21606422 1.468847e-03
## cityTokyo                61.9420406 10.06745965  6.15269818 2.961649e-09
## cityTomsk                -2.5147820  9.17720075 -0.27402496 7.842890e-01
## cityToronto              33.9305983  8.50243163  3.99069346 8.633940e-05
## cityToulouse            -11.6911100  7.94274361 -1.47192337 1.422844e-01
## cityValencia             -5.6313872  8.34522620 -0.67480343 5.004168e-01
## cityVancouver            33.8614151  8.12262678  4.16877643 4.208812e-05
## cityVienna               27.2863361  7.89165693  3.45761814 6.391730e-04
## cityVilnius              16.5258491 10.15283765  1.62770742 1.048316e-01
## cityWarsaw               22.5440792  8.91223816  2.52956427 1.202846e-02
## cityWashington DC        19.8264011  7.78259811  2.54752987 1.144138e-02
## cityZurich               47.0079990  8.64790438  5.43576767 1.283410e-07
## cityKiev                  5.4299055 12.45802495  0.43585605 6.633128e-01
## cityLille                 3.9121496 10.29211741  0.38011125 7.041817e-01
## cityLima                 24.5451966 12.01291168  2.04323459 4.206534e-02
## cityNew Delhi            29.5583922 12.80001811  2.30924613 2.173600e-02
## citySharjah               5.4806105  8.55769150  0.64043096 5.224721e-01
## cityTampere             -13.0408437 10.16388028 -1.28305758 2.006460e-01
## cityWuhan                -7.6367146 11.13011080 -0.68613105 4.932588e-01
## cityKyoto                36.7888820 10.00059159  3.67867057 2.864179e-04
## cityOsaka                14.9771746 10.59809348  1.41319518 1.588275e-01
## factor(year)2015          2.6387547  2.31144616  1.14160337 2.546983e-01
## factor(year)2016          0.6503127  2.33837248  0.27810484 7.811590e-01
## factor(year)2017         -1.5918132  3.01395296 -0.52814798 5.978596e-01
## factor(year)2018         -0.4669024  3.14751126 -0.14834020 8.821925e-01
```
