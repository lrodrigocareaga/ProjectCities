---
title: "Cross Validation"
author: "Ana Real"
date: "March 20, 2019"
output: 
  html_document:
    keep_md: true
---



## This part of the project makes cross validation.

The idea is to have a set of trainning years and then a test set in the remaining year.

We are going to try holding four years and test in the remaining year. First leaving 2018 all the way to 2014 and try to guess a country in particular. In this case Toronto sice it appears all years.

We are using Mexico City as reference.

### Holdout : 2018

Training


```r
library(xlsx)
data <- read.xlsx2("cityData.xlsx", sheetIndex = 1)
for(i in c(1,3:9)){
    data[,i] <- as.numeric(as.character(data[,i]))
}
str(data)
```

```
## 'data.frame':	376 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Removing 2018


data1 <- data[data$year!=2018,]

str(data1)
```

```
## 'data.frame':	275 obs. of  9 variables:
##  $ year         : num  2017 2017 2017 2017 2017 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 2 3 4 5 6 7 8 9 10 11 ...
##  $ overall      : num  343 356 237 271 272 367 228 302 384 363 ...
##  $ rankings     : num  25 34 56 76 23 28 7 64 61 45 ...
##  $ student_mix  : num  52 54 30 43 53 64 42 61 62 92 ...
##  $ desirability : num  82 97 21 46 57 87 53 28 71 46 ...
##  $ emp_activity : num  91 57 43 47 61 93 53 21 69 44 ...
##  $ affordability: num  40 51 31 20 54 43 60 38 45 77 ...
##  $ student_view : num  54 63 57 39 24 51 14 90 75 60 ...
```

```r
# Fitting the model

mexico <- relevel(data1$city, "Mexico City")
fit <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data1)
summary(fit)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data1)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -20.329  -2.299   0.000   2.848  17.202 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                75.11988   13.13464   5.719 5.08e-08 ***
## rankings                    0.96412    0.06148  15.682  < 2e-16 ***
## student_view                1.03398    0.03984  25.955  < 2e-16 ***
## desirability                0.87113    0.07901  11.026  < 2e-16 ***
## emp_activity                1.18545    0.13963   8.490 1.30e-14 ***
## affordability               1.10246    0.14675   7.512 3.78e-12 ***
## mexicoAdelaide            -27.08992   10.10448  -2.681 0.008105 ** 
## mexicoAmsterdam           -19.59791    8.10123  -2.419 0.016672 *  
## mexicoAnkara              -50.46101    8.38315  -6.019 1.14e-08 ***
## mexicoAthens              -31.52486    8.97607  -3.512 0.000577 ***
## mexicoAtlanta             -30.45657    8.18486  -3.721 0.000274 ***
## mexicoAuckland             -9.35814   10.47790  -0.893 0.373120    
## mexicoBaltimore           -40.77147    8.03051  -5.077 1.05e-06 ***
## mexicoBangkok             -15.03073    7.95589  -1.889 0.060655 .  
## mexicoBarcelona           -14.57422    8.13180  -1.792 0.074971 .  
## mexicoBeijing               8.40205    7.01636   1.197 0.232874    
## mexicoBerlin               -6.17344    8.93363  -0.691 0.490539    
## mexicoBirmingham          -31.46528    8.57922  -3.668 0.000332 ***
## mexicoBogota               -9.00737    7.85115  -1.147 0.252973    
## mexicoBoston                5.69395   11.42642   0.498 0.618942    
## mexicoBrisbane            -21.55475   10.69035  -2.016 0.045433 *  
## mexicoBrno                -52.76889   10.46368  -5.043 1.22e-06 ***
## mexicoBrussels            -39.97154    8.79399  -4.545 1.07e-05 ***
## mexicoBudapest            -31.24876    9.62582  -3.246 0.001422 ** 
## mexicoBuenos Aires         -2.80871    8.06730  -0.348 0.728174    
## mexicoCairo               -44.50379   10.00560  -4.448 1.61e-05 ***
## mexicoCanberra            -16.44356    9.63348  -1.707 0.089765 .  
## mexicoChicago             -10.37445    9.65964  -1.074 0.284430    
## mexicoChristchurch        -37.14349    8.80547  -4.218 4.10e-05 ***
## mexicoCopenhagen          -14.01363    9.53710  -1.469 0.143681    
## mexicoCoventry            -25.11181   10.60489  -2.368 0.019074 *  
## mexicoDaejeon             -11.95792    6.18870  -1.932 0.055088 .  
## mexicoDublin              -25.24469   10.56347  -2.390 0.018013 *  
## mexicoEdinburgh           -24.02512   10.52274  -2.283 0.023729 *  
## mexicoGlasgow             -42.05712    9.33592  -4.505 1.27e-05 ***
## mexicoGold Coast          -53.79761    9.71303  -5.539 1.22e-07 ***
## mexicoGothenburg          -28.57521    8.79573  -3.249 0.001411 ** 
## mexicoHelsinki            -33.49309    6.97511  -4.802 3.57e-06 ***
## mexicoHong Kong            -2.04887   10.42829  -0.196 0.844488    
## mexicoHouston             -49.50974    8.81805  -5.615 8.45e-08 ***
## mexicoHsinchu             -36.11573    6.70526  -5.386 2.51e-07 ***
## mexicoIstanbul            -31.27884    8.20048  -3.814 0.000194 ***
## mexicoJohannesburg        -52.04158    9.02208  -5.768 3.99e-08 ***
## mexicoKiev                -38.20167   10.04909  -3.802 0.000204 ***
## mexicoKuala Lumpur        -32.30010    6.26449  -5.156 7.32e-07 ***
## mexicoKyoto                -8.52312    8.99448  -0.948 0.344756    
## mexicoKyoto-Osaka-Kobe      2.51625    7.97552   0.315 0.752793    
## mexicoLille               -42.19641   10.02728  -4.208 4.27e-05 ***
## mexicoLima                -19.48139    9.38632  -2.076 0.039530 *  
## mexicoLisbon              -32.48791    8.17599  -3.974 0.000107 ***
## mexicoLondon                4.80850   13.61372   0.353 0.724393    
## mexicoLos Angeles          -8.19520    8.43893  -0.971 0.332946    
## mexicoLyon                -40.68147    8.13800  -4.999 1.49e-06 ***
## mexicoMadrid              -17.56078    7.87616  -2.230 0.027157 *  
## mexicoManchester          -16.36337   10.00707  -1.635 0.103965    
## mexicoManila              -48.16937    8.43223  -5.713 5.25e-08 ***
## mexicoMelbourne             1.82343   12.71182   0.143 0.886119    
## mexicoMilan                 5.84568    7.47785   0.782 0.435520    
## mexicoMonterrey            -3.28955    6.96502  -0.472 0.637356    
## mexicoMontpellier         -57.89568   10.29538  -5.623 8.09e-08 ***
## mexicoMontreal            -10.61238   11.44759  -0.927 0.355293    
## mexicoMoscow              -14.50406    6.46760  -2.243 0.026290 *  
## mexicoMumbai              -10.25835    8.82321  -1.163 0.246690    
## mexicoMunich               -5.18454    9.01047  -0.575 0.565830    
## mexicoNanjing             -45.80259    8.37656  -5.468 1.71e-07 ***
## mexicoNewcastle Upon Tyne -65.74127   10.02767  -6.556 7.15e-10 ***
## mexicoNew Delhi           -13.07127    8.84481  -1.478 0.141403    
## mexicoNew York             -4.87652   10.37223  -0.470 0.638883    
## mexicoNottingham          -39.28700    9.42786  -4.167 5.02e-05 ***
## mexicoNovosibirsk         -34.64784    8.66095  -4.000 9.62e-05 ***
## mexicoOsaka               -29.81815    8.61792  -3.460 0.000692 ***
## mexicoOslo                -32.53780    7.92429  -4.106 6.38e-05 ***
## mexicoOttawa              -54.05889   10.34594  -5.225 5.33e-07 ***
## mexicoParis                 3.81836   12.17907   0.314 0.754293    
## mexicoPerth               -34.65273    9.90201  -3.500 0.000603 ***
## mexicoPhiladelphia        -14.76268    8.09752  -1.823 0.070141 .  
## mexicoPittsburgh          -33.88917    8.13748  -4.165 5.07e-05 ***
## mexicoPrague              -24.23039    8.52859  -2.841 0.005078 ** 
## mexicoQuebec              -45.55707    9.58880  -4.751 4.45e-06 ***
## mexicoRio de Janeiro      -29.52203    8.53101  -3.461 0.000690 ***
## mexicoRiyadh              -50.33699    8.82201  -5.706 5.42e-08 ***
## mexicoRome                -59.53152    8.11634  -7.335 1.03e-11 ***
## mexicoSan Diego           -54.94607    7.87138  -6.980 7.29e-11 ***
## mexicoSan Francisco        -1.03021    9.73314  -0.106 0.915837    
## mexicoSantiago              4.23231    5.26836   0.803 0.422960    
## mexicoSao Paulo            -0.69389    6.10470  -0.114 0.909645    
## mexicoSeoul                 5.81205   10.04952   0.578 0.563842    
## mexicoShanghai              1.66363    5.97117   0.279 0.780902    
## mexicoSharjah             -42.52634   10.42914  -4.078 7.13e-05 ***
## mexicoSingapore             5.28436   10.07561   0.524 0.600673    
## mexicoStockholm            -0.61766    8.71371  -0.071 0.943578    
## mexicoSt. Petersburg      -44.50182    8.23879  -5.401 2.34e-07 ***
## mexicoSydney                3.28441   12.16834   0.270 0.787572    
## mexicoTaipei              -15.47701    6.54594  -2.364 0.019253 *  
## mexicoTampere             -59.36969    9.85040  -6.027 1.10e-08 ***
## mexicoTokyo                16.71635    9.03594   1.850 0.066149 .  
## mexicoTomsk               -50.97822    9.38991  -5.429 2.05e-07 ***
## mexicoToronto             -13.39420   10.95024  -1.223 0.223046    
## mexicoToulouse            -61.30598    9.20294  -6.662 4.08e-10 ***
## mexicoValencia            -52.60635    8.89616  -5.913 1.95e-08 ***
## mexicoVancouver           -14.17742   10.73514  -1.321 0.188491    
## mexicoVienna              -20.85376   10.51769  -1.983 0.049099 *  
## mexicoVilnius             -35.14298    9.99478  -3.516 0.000569 ***
## mexicoWarsaw              -28.47529    7.76234  -3.668 0.000331 ***
## mexicoWashington DC       -22.80615    8.07489  -2.824 0.005337 ** 
## mexicoWuhan               -52.25991    8.52436  -6.131 6.51e-09 ***
## mexicoZurich               -0.82497   10.48335  -0.079 0.937374    
## factor(year)2015            1.56827    2.67128   0.587 0.557968    
## factor(year)2016           -0.58948    2.79952  -0.211 0.833492    
## factor(year)2017           -4.03126    3.71490  -1.085 0.279474    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.743 on 161 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9928,	Adjusted R-squared:  0.9878 
## F-statistic: 202.4 on 109 and 161 DF,  p-value: < 2.2e-16
```

```r
coef1 <- summary(fit)$coef
```

Wtih this result we get the equation for Toronto: $0.96\times rankings + 1.03\times studentView + 0.87\times desirability + 1.19\times empActivity + 1.1\times affordability + 75.12 (Intercept)-13.39 (Toronto) = score$.
Substituting in out equation the 2018 data for Toronto.


```r
toronto2018 <- data[data$city=="Toronto"&data$year==2018,]

score <- coef1[2,1]*toronto2018$rankings + coef1[3,1]*toronto2018$student_view + coef1[4,1]*toronto2018$desirability + coef1[5,1]*toronto2018$emp_activity + coef1[6,1]*toronto2018$affordability + coef1[1,1] -13.39
score
```

```
## [1] 442.9166
```

```r
toronto2018$overall
```

```
## [1] 441
```

```r
# Calculating the error

abs((score-toronto2018$overall)/toronto2018$overall)*100
```

```
## [1] 0.4346114
```


### Holdout 2017:

Training


```r
# Removing 2017

data2 <- data[data$year!=2017,]

str(data2)
```

```
## 'data.frame':	276 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Fitting the model

mexico <- relevel(data2$city, "Mexico City")
fit1 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data2)
summary(fit1)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data2)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -23.231  -2.455   0.000   2.969  17.856 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                75.68840   12.56022   6.026 1.12e-08 ***
## rankings                    0.96091    0.06161  15.596  < 2e-16 ***
## student_view                1.03212    0.04349  23.731  < 2e-16 ***
## desirability                0.83909    0.08364  10.032  < 2e-16 ***
## emp_activity                1.15802    0.14878   7.783 8.27e-13 ***
## affordability               1.13450    0.14816   7.657 1.70e-12 ***
## mexicoAberdeen            -44.53877   10.80319  -4.123 6.00e-05 ***
## mexicoAdelaide            -24.14772   10.43431  -2.314 0.021925 *  
## mexicoAmsterdam           -15.86970    8.37930  -1.894 0.060041 .  
## mexicoAnkara              -47.85209    8.82654  -5.421 2.14e-07 ***
## mexicoAthens              -62.13799    9.41588  -6.599 5.76e-10 ***
## mexicoAtlanta             -30.26094    8.29543  -3.648 0.000357 ***
## mexicoAuckland             -7.65361   10.96500  -0.698 0.486188    
## mexicoBaltimore           -39.87498    8.32899  -4.787 3.82e-06 ***
## mexicoBangkok             -13.93923    8.19452  -1.701 0.090878 .  
## mexicoBarcelona           -12.99230    8.55854  -1.518 0.130975    
## mexicoBeijing               7.47667    7.34180   1.018 0.310039    
## mexicoBerlin               -4.59836    9.34953  -0.492 0.623515    
## mexicoBirmingham          -29.57856    8.94559  -3.306 0.001166 ** 
## mexicoBogota               -7.41266    8.24272  -0.899 0.369846    
## mexicoBoston                6.99347   11.71760   0.597 0.551462    
## mexicoBrighton            -72.85531   11.37734  -6.404 1.61e-09 ***
## mexicoBrisbane            -19.55929   11.03000  -1.773 0.078085 .  
## mexicoBrno                -48.67378   10.92872  -4.454 1.58e-05 ***
## mexicoBrussels            -34.97971    9.24337  -3.784 0.000218 ***
## mexicoBudapest            -16.80942   10.24787  -1.640 0.102911    
## mexicoBuenos Aires         -1.09716    8.35879  -0.131 0.895736    
## mexicoCairo               -40.03765   10.37007  -3.861 0.000164 ***
## mexicoCanberra            -14.17177    9.98824  -1.419 0.157889    
## mexicoCape Town           -77.23275    8.59854  -8.982 7.02e-16 ***
## mexicoChicago              -9.57234   10.08746  -0.949 0.344085    
## mexicoChristchurch        -36.37118    9.20977  -3.949 0.000117 ***
## mexicoCopenhagen          -12.93286    9.78485  -1.322 0.188147    
## mexicoCoventry            -23.02637   11.02313  -2.089 0.038299 *  
## mexicoDaejeon             -15.57336    6.35215  -2.452 0.015295 *  
## mexicoDubai-Sharjah-Ajman -52.38881   11.36342  -4.610 8.18e-06 ***
## mexicoDublin              -20.19344   11.00174  -1.835 0.068292 .  
## mexicoEdinburgh           -22.00550   11.05752  -1.990 0.048284 *  
## mexicoGlasgow             -36.41695    9.66326  -3.769 0.000230 ***
## mexicoGold Coast          -51.72357    9.82989  -5.262 4.52e-07 ***
## mexicoGothenburg          -24.69301    9.05281  -2.728 0.007091 ** 
## mexicoGraz                -32.39899   11.28782  -2.870 0.004656 ** 
## mexicoHelsinki            -31.77546    7.27755  -4.366 2.26e-05 ***
## mexicoHong Kong            -1.88186   10.63743  -0.177 0.859803    
## mexicoHouston             -51.54063    9.10448  -5.661 6.80e-08 ***
## mexicoHsinchu             -36.90805    7.14210  -5.168 6.98e-07 ***
## mexicoIstanbul            -29.09664    8.45894  -3.440 0.000743 ***
## mexicoJohannesburg        -54.17813    9.38708  -5.772 3.96e-08 ***
## mexicoKuala Lumpur        -32.66249    6.63955  -4.919 2.14e-06 ***
## mexicoKyoto                -7.26729    9.33672  -0.778 0.437509    
## mexicoKyoto-Osaka-Kobe      2.74618    8.03181   0.342 0.732865    
## mexicoLisbon              -29.54920    8.77080  -3.369 0.000945 ***
## mexicoLondon                5.46519   14.00199   0.390 0.696823    
## mexicoLos Angeles          -7.61748    8.79191  -0.866 0.387558    
## mexicoLyon                -39.11772    8.70091  -4.496 1.32e-05 ***
## mexicoMadrid              -16.02255    8.25944  -1.940 0.054149 .  
## mexicoManchester          -14.51830   10.41465  -1.394 0.165243    
## mexicoManila              -51.85381    8.69784  -5.962 1.54e-08 ***
## mexicoMelbourne             4.00853   13.04410   0.307 0.759010    
## mexicoMiami               -41.23461    9.83974  -4.191 4.59e-05 ***
## mexicoMilan                 7.43307    7.88030   0.943 0.346977    
## mexicoMonterrey            -3.84665    7.03861  -0.547 0.585479    
## mexicoMontpellier         -56.97195   11.62320  -4.902 2.31e-06 ***
## mexicoMontreal             -8.90928   11.79658  -0.755 0.451213    
## mexicoMoscow              -13.39128    6.82735  -1.961 0.051566 .  
## mexicoMumbai               -7.51559    9.50085  -0.791 0.430090    
## mexicoMunich               -4.14321    9.34733  -0.443 0.658183    
## mexicoNagoya              -42.72426    9.00694  -4.743 4.62e-06 ***
## mexicoNanjing             -44.15441    8.22249  -5.370 2.73e-07 ***
## mexicoNewcastle Upon Tyne -62.50171   10.18288  -6.138 6.34e-09 ***
## mexicoNew York             -4.43850   10.65847  -0.416 0.677654    
## mexicoNottingham          -36.39184    9.64818  -3.772 0.000228 ***
## mexicoNovosibirsk         -31.08766    9.25579  -3.359 0.000979 ***
## mexicoOsaka               -28.50268    8.95583  -3.183 0.001754 ** 
## mexicoOslo                -30.07664    8.07617  -3.724 0.000271 ***
## mexicoOttawa              -52.77142   10.77200  -4.899 2.34e-06 ***
## mexicoParis                 4.69870   12.29477   0.382 0.702842    
## mexicoPerth               -31.68777   10.41513  -3.042 0.002743 ** 
## mexicoPhiladelphia        -14.59066    8.31335  -1.755 0.081158 .  
## mexicoPittsburgh          -32.18844    8.51247  -3.781 0.000220 ***
## mexicoPrague              -20.33687    8.95537  -2.271 0.024486 *  
## mexicoQuebec              -43.74036    9.93757  -4.402 1.96e-05 ***
## mexicoRio de Janeiro      -29.68124    8.63027  -3.439 0.000744 ***
## mexicoRiyadh              -52.16566    9.39102  -5.555 1.14e-07 ***
## mexicoRome                -53.90113    8.48695  -6.351 2.12e-09 ***
## mexicoSan Diego           -53.70855    8.26556  -6.498 9.84e-10 ***
## mexicoSan Francisco        -0.01188    9.85929  -0.001 0.999040    
## mexicoSantiago              5.38192    5.44916   0.988 0.324811    
## mexicoSao Paulo            -5.19694    6.36807  -0.816 0.415660    
## mexicoSeoul                 4.44582   10.17431   0.437 0.662726    
## mexicoShanghai              1.44855    6.18150   0.234 0.815023    
## mexicoSharjah             -34.34354   12.10651  -2.837 0.005147 ** 
## mexicoSingapore             8.33553   10.42830   0.799 0.425291    
## mexicoStockholm             2.18216    8.90213   0.245 0.806672    
## mexicoSt. Petersburg      -34.91764    8.86048  -3.941 0.000121 ***
## mexicoStuttgart           -25.61256   11.12171  -2.303 0.022570 *  
## mexicoSydney                4.92044   12.58337   0.391 0.696298    
## mexicoTaipei              -13.32603    6.67912  -1.995 0.047721 *  
## mexicoTokyo                17.14174    9.27244   1.849 0.066350 .  
## mexicoTomsk               -40.60512    9.79706  -4.145 5.50e-05 ***
## mexicoToronto             -11.57838   11.36540  -1.019 0.309865    
## mexicoToulouse            -58.60091    9.87405  -5.935 1.77e-08 ***
## mexicoValencia            -50.12638    9.15251  -5.477 1.65e-07 ***
## mexicoVancouver           -11.90762   11.16305  -1.067 0.287715    
## mexicoVienna              -17.87577   11.11118  -1.609 0.109629    
## mexicoVilnius             -21.68765    9.94932  -2.180 0.030733 *  
## mexicoWarsaw              -20.23200    8.28285  -2.443 0.015669 *  
## mexicoWashington DC       -27.25396    8.28676  -3.289 0.001237 ** 
## mexicoZurich                2.00606   10.85415   0.185 0.853604    
## factor(year)2015            2.28265    2.73362   0.835 0.404947    
## factor(year)2016           -0.19957    2.79627  -0.071 0.943191    
## factor(year)2018           -2.60708    4.26222  -0.612 0.541624    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.042 on 160 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9922,	Adjusted R-squared:  0.9867 
## F-statistic: 182.8 on 111 and 160 DF,  p-value: < 2.2e-16
```

```r
coef2 <- summary(fit1)$coef
```



```r
toronto2017 <- data[data$city=="Toronto"&data$year==2017,]

score <- coef2[2,1]*toronto2017$rankings + coef2[3,1]*toronto2017$student_view + coef2[4,1]*toronto2017$desirability + coef2[5,1]*toronto2017$emp_activity + coef2[6,1]*toronto2017$affordability + coef2[1,1] -11.58
score
```

```
## [1] 426.0607
```

```r
toronto2017$overall
```

```
## [1] 429
```

```r
# Calculating the error

abs((score-toronto2017$overall)/toronto2017$overall)*100
```

```
## [1] 0.68515
```


### Holdout 2016:

Training


```r
# Removing 2017

data3 <- data[data$year!=2016,]

str(data3)
```

```
## 'data.frame':	301 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Fitting the model

mexico <- relevel(data3$city, "Mexico City")
fit3 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data3)
summary(fit3)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data3)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -17.917  -1.920   0.000   2.346  21.871 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                52.76466   11.38390   4.635 6.86e-06 ***
## rankings                    1.10105    0.05924  18.586  < 2e-16 ***
## student_view                1.01893    0.04206  24.228  < 2e-16 ***
## desirability                0.88984    0.07263  12.252  < 2e-16 ***
## emp_activity                1.13433    0.12937   8.768 1.39e-15 ***
## affordability               1.26743    0.12264  10.334  < 2e-16 ***
## mexicoAberdeen            -38.58444    9.47776  -4.071 7.02e-05 ***
## mexicoAdelaide            -18.63111    9.50391  -1.960 0.051505 .  
## mexicoAmsterdam           -12.57057    7.66983  -1.639 0.102977    
## mexicoAnkara              -43.36145    6.29462  -6.889 9.23e-11 ***
## mexicoAthens              -42.46443    6.82505  -6.222 3.38e-09 ***
## mexicoAtlanta             -21.54244    7.28282  -2.958 0.003515 ** 
## mexicoAuckland             -3.37841    9.91453  -0.341 0.733689    
## mexicoBaltimore           -31.95260    7.43935  -4.295 2.86e-05 ***
## mexicoBangkok             -12.15919    5.78875  -2.100 0.037087 *  
## mexicoBarcelona            -6.66860    7.73080  -0.863 0.389511    
## mexicoBeijing               7.00028    6.48434   1.080 0.281788    
## mexicoBerlin               -3.51706    8.25719  -0.426 0.670664    
## mexicoBirmingham          -24.03993    7.83955  -3.066 0.002502 ** 
## mexicoBogota               -4.42971    5.81425  -0.762 0.447139    
## mexicoBoston                8.83837   10.56797   0.836 0.404081    
## mexicoBrighton            -62.84460   10.06733  -6.242 3.04e-09 ***
## mexicoBrisbane            -15.74214   10.08177  -1.561 0.120185    
## mexicoBrno                -44.36771    9.67284  -4.587 8.43e-06 ***
## mexicoBrussels            -30.68965    8.08521  -3.796 0.000201 ***
## mexicoBudapest            -20.47895    7.43016  -2.756 0.006453 ** 
## mexicoBuenos Aires         -0.81957    7.62766  -0.107 0.914554    
## mexicoCairo               -31.55467    7.95826  -3.965 0.000106 ***
## mexicoCanberra            -10.66624    9.12198  -1.169 0.243841    
## mexicoCape Town           -73.82094    7.53065  -9.803  < 2e-16 ***
## mexicoChicago              -6.10953    8.89309  -0.687 0.492974    
## mexicoChristchurch        -31.86980    8.30772  -3.836 0.000173 ***
## mexicoCopenhagen          -12.22832    8.96670  -1.364 0.174359    
## mexicoCoventry            -12.84165    9.79249  -1.311 0.191410    
## mexicoDaejeon              -6.85253    5.93669  -1.154 0.249928    
## mexicoDubai-Sharjah-Ajman -44.12077    9.99610  -4.414 1.75e-05 ***
## mexicoDublin              -12.80585    9.94077  -1.288 0.199334    
## mexicoEdinburgh           -18.11705    9.85362  -1.839 0.067628 .  
## mexicoGlasgow             -30.95290    8.77053  -3.529 0.000530 ***
## mexicoGold Coast          -46.98051    9.23327  -5.088 9.08e-07 ***
## mexicoGothenburg          -14.54597    8.35180  -1.742 0.083287 .  
## mexicoGraz                -24.39072    9.81878  -2.484 0.013908 *  
## mexicoHelsinki            -31.43558    6.66983  -4.713 4.89e-06 ***
## mexicoHong Kong            -3.41731    9.40578  -0.363 0.716794    
## mexicoHouston             -43.27400    6.80946  -6.355 1.68e-09 ***
## mexicoHsinchu             -33.85592    6.37717  -5.309 3.24e-07 ***
## mexicoIstanbul            -23.77429    6.04535  -3.933 0.000120 ***
## mexicoJohannesburg        -48.70341    6.82770  -7.133 2.34e-11 ***
## mexicoKiev                -33.02149    9.09037  -3.633 0.000366 ***
## mexicoKuala Lumpur        -31.00991    5.79247  -5.353 2.62e-07 ***
## mexicoKyoto                -5.23195    8.34619  -0.627 0.531545    
## mexicoKyoto-Osaka-Kobe      1.33042    7.29885   0.182 0.855571    
## mexicoLille               -32.56842    9.04045  -3.603 0.000408 ***
## mexicoLima                -13.86397    8.52663  -1.626 0.105717    
## mexicoLisbon              -17.60796    7.54069  -2.335 0.020649 *  
## mexicoLondon                6.12062   12.33026   0.496 0.620228    
## mexicoLos Angeles          -1.77514    8.07313  -0.220 0.826213    
## mexicoLyon                -27.61930    7.51088  -3.677 0.000312 ***
## mexicoMadrid               -9.63863    7.28873  -1.322 0.187722    
## mexicoManchester          -11.25444    9.29258  -1.211 0.227446    
## mexicoManila              -46.70751    6.27406  -7.445 3.95e-12 ***
## mexicoMelbourne             5.85785   11.89185   0.493 0.622903    
## mexicoMiami               -31.13815    8.83439  -3.525 0.000538 ***
## mexicoMilan                14.12652    7.32187   1.929 0.055268 .  
## mexicoMonterrey            -1.98596    6.43876  -0.308 0.758107    
## mexicoMontpellier         -51.52430    8.64457  -5.960 1.31e-08 ***
## mexicoMontreal             -6.23331   10.56768  -0.590 0.556037    
## mexicoMoscow               -8.13720    6.16327  -1.320 0.188429    
## mexicoMumbai               -5.05212    6.94720  -0.727 0.468044    
## mexicoMunich               -3.76257    8.43080  -0.446 0.655928    
## mexicoNagoya              -42.53963    7.91009  -5.378 2.33e-07 ***
## mexicoNanjing             -39.25082    5.99042  -6.552 5.83e-10 ***
## mexicoNewcastle Upon Tyne -56.10625    8.91318  -6.295 2.31e-09 ***
## mexicoNew Delhi           -11.95298    8.21616  -1.455 0.147472    
## mexicoNew York             -1.89897    9.58545  -0.198 0.843184    
## mexicoNottingham          -33.98779    8.44729  -4.024 8.45e-05 ***
## mexicoNovosibirsk         -29.39101    6.67497  -4.403 1.83e-05 ***
## mexicoOsaka               -27.59576    7.95463  -3.469 0.000654 ***
## mexicoOslo                -22.26614    7.31303  -3.045 0.002680 ** 
## mexicoOttawa              -43.33071    9.68578  -4.474 1.36e-05 ***
## mexicoParis                 3.38203   10.89908   0.310 0.756691    
## mexicoPerth               -25.71935    9.41393  -2.732 0.006925 ** 
## mexicoPhiladelphia         -8.22970    7.47709  -1.101 0.272525    
## mexicoPittsburgh          -26.89639    7.44491  -3.613 0.000393 ***
## mexicoPrague              -12.49839    7.98084  -1.566 0.119103    
## mexicoQuebec              -38.99565    9.05190  -4.308 2.71e-05 ***
## mexicoRio de Janeiro      -22.87341    6.33756  -3.609 0.000399 ***
## mexicoRiyadh              -49.11850    6.72493  -7.304 8.87e-12 ***
## mexicoRome                -59.17147    7.29038  -8.116 7.47e-14 ***
## mexicoSan Diego           -61.68176    7.41517  -8.318 2.20e-14 ***
## mexicoSan Francisco         5.99400    8.87918   0.675 0.500507    
## mexicoSantiago              7.92099    4.87980   1.623 0.106302    
## mexicoSao Paulo            -2.65851    5.63631  -0.472 0.637733    
## mexicoSeoul                 4.68898    9.15411   0.512 0.609124    
## mexicoShanghai              0.13888    5.67950   0.024 0.980519    
## mexicoSharjah             -34.66928   10.39418  -3.335 0.001035 ** 
## mexicoSingapore             9.30148    9.37981   0.992 0.322707    
## mexicoStockholm             9.33768    8.37735   1.115 0.266501    
## mexicoSt. Petersburg      -37.78868    6.17334  -6.121 5.72e-09 ***
## mexicoStuttgart           -23.94578    9.57707  -2.500 0.013307 *  
## mexicoSydney                8.46141   11.47039   0.738 0.461679    
## mexicoTaipei              -17.32825    5.94689  -2.914 0.004026 ** 
## mexicoTampere             -50.84494    8.95961  -5.675 5.50e-08 ***
## mexicoTokyo                15.01651    8.29406   1.811 0.071893 .  
## mexicoTomsk               -42.48140    7.23758  -5.870 2.08e-08 ***
## mexicoToronto              -8.97296   10.34425  -0.867 0.386865    
## mexicoToulouse            -42.48183    8.97669  -4.732 4.49e-06 ***
## mexicoValencia            -41.79382    7.90510  -5.287 3.59e-07 ***
## mexicoVancouver            -7.33304   10.04440  -0.730 0.466306    
## mexicoVienna              -11.93692    9.86307  -1.210 0.227773    
## mexicoVilnius             -20.16500    7.45982  -2.703 0.007530 ** 
## mexicoWarsaw              -11.25109    7.08978  -1.587 0.114290    
## mexicoWashington DC       -22.79384    7.63695  -2.985 0.003236 ** 
## mexicoWuhan               -45.95886    7.77196  -5.913 1.66e-08 ***
## mexicoZurich                4.71214    9.70205   0.486 0.627784    
## factor(year)2015            4.96557    2.31494   2.145 0.033300 *  
## factor(year)2017            2.13795    3.84635   0.556 0.579015    
## factor(year)2018            3.16209    4.03476   0.784 0.434245    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.202 on 179 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9949,	Adjusted R-squared:  0.9916 
## F-statistic: 300.4 on 117 and 179 DF,  p-value: < 2.2e-16
```

```r
coef3 <- summary(fit3)$coef
```



```r
toronto2016 <- data[data$city=="Toronto"&data$year==2016,]

score <- coef3[2,1]*toronto2016$rankings + coef3[3,1]*toronto2016$student_view + coef3[4,1]*toronto2016$desirability + coef3[5,1]*toronto2016$emp_activity + coef3[6,1]*toronto2016$affordability + coef3[1,1] -8.97
score
```

```
## [1] 345.616
```

```r
toronto2016$overall
```

```
## [1] 355
```

```r
# Calculating the error

abs((score-toronto2016$overall)/toronto2016$overall)*100
```

```
## [1] 2.643386
```

### Holdout 2015:

Training


```r
# Removing 2017

data4 <- data[data$year!=2015,]

str(data4)
```

```
## 'data.frame':	326 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Fitting the model

mexico <- relevel(data4$city, "Mexico City")
fit4 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data4)
summary(fit4)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data4)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -17.640  -2.355   0.000   2.790  23.039 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                75.62662   11.55353   6.546 4.62e-10 ***
## rankings                    0.98215    0.05435  18.070  < 2e-16 ***
## student_view                1.00975    0.03267  30.908  < 2e-16 ***
## desirability                0.85871    0.07728  11.112  < 2e-16 ***
## emp_activity                1.07717    0.13528   7.962 1.12e-13 ***
## affordability               1.12818    0.13053   8.643 1.53e-15 ***
## mexicoAberdeen            -41.00066   10.06216  -4.075 6.57e-05 ***
## mexicoAdelaide            -20.83418    9.80877  -2.124 0.034860 *  
## mexicoAmsterdam           -13.49558    8.03640  -1.679 0.094608 .  
## mexicoAnkara              -47.56561    6.70958  -7.089 2.11e-11 ***
## mexicoAthens              -45.48962    7.38255  -6.162 3.72e-09 ***
## mexicoAtlanta             -26.30205    7.23249  -3.637 0.000349 ***
## mexicoAuckland             -5.54786   10.33423  -0.537 0.591956    
## mexicoBaltimore           -37.30237    7.17074  -5.202 4.75e-07 ***
## mexicoBangkok             -14.89152    6.19852  -2.402 0.017174 *  
## mexicoBarcelona           -11.71616    7.82848  -1.497 0.136026    
## mexicoBeijing               9.73287    6.80865   1.429 0.154379    
## mexicoBerlin                2.10545    8.83645   0.238 0.811909    
## mexicoBirmingham          -26.22080    7.79627  -3.363 0.000918 ***
## mexicoBogota               -8.84025    6.20456  -1.425 0.155729    
## mexicoBoston               10.94942   10.94117   1.001 0.318120    
## mexicoBrighton            -68.98079   10.54701  -6.540 4.76e-10 ***
## mexicoBrisbane            -14.39894   10.26665  -1.402 0.162272    
## mexicoBrno                -47.13013    9.75915  -4.829 2.67e-06 ***
## mexicoBrussels            -30.65110    8.64920  -3.544 0.000488 ***
## mexicoBudapest            -22.98549    8.11288  -2.833 0.005066 ** 
## mexicoBuenos Aires         -0.11022    7.88540  -0.014 0.988862    
## mexicoCairo               -38.56234    8.29343  -4.650 5.93e-06 ***
## mexicoCanberra            -10.46650    9.30666  -1.125 0.262057    
## mexicoCape Town           -75.90192    8.13208  -9.334  < 2e-16 ***
## mexicoChicago              -6.33768    9.21673  -0.688 0.492461    
## mexicoChristchurch        -34.01826    8.19268  -4.152 4.82e-05 ***
## mexicoCopenhagen          -14.63486    9.23028  -1.586 0.114381    
## mexicoCoventry            -14.79998   10.11179  -1.464 0.144818    
## mexicoDaejeon             -12.72528    5.44252  -2.338 0.020340 *  
## mexicoDubai-Sharjah-Ajman -48.99048   10.64714  -4.601 7.33e-06 ***
## mexicoDublin              -14.21029    9.95021  -1.428 0.154766    
## mexicoEdinburgh           -15.86651   10.04439  -1.580 0.115724    
## mexicoGlasgow             -33.14500    8.59672  -3.856 0.000154 ***
## mexicoGold Coast          -49.77782    8.99247  -5.536 9.38e-08 ***
## mexicoGothenburg          -21.82551    8.06698  -2.706 0.007391 ** 
## mexicoGraz                -30.85394   10.43377  -2.957 0.003468 ** 
## mexicoHelsinki            -31.78735    6.87060  -4.627 6.57e-06 ***
## mexicoHong Kong             2.27385    9.78903   0.232 0.816547    
## mexicoHouston             -48.71306    7.10777  -6.853 8.19e-11 ***
## mexicoHsinchu             -35.03143    5.99781  -5.841 2.00e-08 ***
## mexicoIstanbul            -28.95964    6.43327  -4.502 1.13e-05 ***
## mexicoJohannesburg        -52.24967    7.35215  -7.107 1.91e-11 ***
## mexicoKiev                -39.23877    9.65722  -4.063 6.88e-05 ***
## mexicoKuala Lumpur        -29.85729    5.86775  -5.088 8.11e-07 ***
## mexicoKyoto-Osaka-Kobe      3.66244    7.17365   0.511 0.610219    
## mexicoLille               -39.65955    9.59195  -4.135 5.17e-05 ***
## mexicoLima                -20.89586    9.01108  -2.319 0.021380 *  
## mexicoLisbon              -25.01056    7.63435  -3.276 0.001235 ** 
## mexicoLondon               10.86720   12.74025   0.853 0.394660    
## mexicoLos Angeles          -4.19606    8.29619  -0.506 0.613550    
## mexicoLyon                -32.77861    7.72620  -4.243 3.34e-05 ***
## mexicoMadrid              -10.48380    7.97649  -1.314 0.190194    
## mexicoManchester          -10.82195    9.58499  -1.129 0.260189    
## mexicoManila              -50.77290    6.69338  -7.586 1.12e-12 ***
## mexicoMelbourne             8.38355   12.21917   0.686 0.493423    
## mexicoMiami               -40.17503    9.30437  -4.318 2.45e-05 ***
## mexicoMilan                 9.91496    7.38034   1.343 0.180611    
## mexicoMonterrey            -4.44469    6.11317  -0.727 0.468009    
## mexicoMontpellier         -54.71948    9.08268  -6.025 7.70e-09 ***
## mexicoMontreal             -2.26887   11.07565  -0.205 0.837890    
## mexicoMoscow               -8.80858    6.22667  -1.415 0.158680    
## mexicoMumbai              -11.33320    7.35306  -1.541 0.124781    
## mexicoMunich                1.96890    8.91363   0.221 0.825400    
## mexicoNagoya              -44.69434    8.29706  -5.387 1.95e-07 ***
## mexicoNanjing             -44.58227    6.35639  -7.014 3.27e-11 ***
## mexicoNewcastle Upon Tyne -57.74082    9.00441  -6.413 9.61e-10 ***
## mexicoNew Delhi           -16.33158    8.71087  -1.875 0.062228 .  
## mexicoNew York             -0.49108    9.84835  -0.050 0.960279    
## mexicoNottingham          -33.43794    8.46871  -3.948 0.000108 ***
## mexicoNovosibirsk         -32.95351    6.99393  -4.712 4.51e-06 ***
## mexicoOslo                -27.52336    7.54018  -3.650 0.000332 ***
## mexicoOttawa              -46.96493    9.82384  -4.781 3.32e-06 ***
## mexicoParis                 7.76302   11.23708   0.691 0.490444    
## mexicoPerth               -26.91250    9.33935  -2.882 0.004375 ** 
## mexicoPhiladelphia        -11.25694    7.83181  -1.437 0.152140    
## mexicoPittsburgh          -28.17540    7.73582  -3.642 0.000342 ***
## mexicoPrague              -14.83564    8.42203  -1.762 0.079633 .  
## mexicoQuebec              -42.01568    8.98012  -4.679 5.22e-06 ***
## mexicoRio de Janeiro      -29.90740    6.71431  -4.454 1.38e-05 ***
## mexicoRiyadh              -49.80529    7.24569  -6.874 7.30e-11 ***
## mexicoRome                -56.03463    7.37189  -7.601 1.02e-12 ***
## mexicoSan Diego           -55.86812    7.18821  -7.772 3.61e-13 ***
## mexicoSan Francisco         1.07498    9.18084   0.117 0.906903    
## mexicoSantiago              3.71806    5.19337   0.716 0.474848    
## mexicoSao Paulo            -3.57268    5.35323  -0.667 0.505271    
## mexicoSeoul                 9.60051    9.40314   1.021 0.308457    
## mexicoShanghai              2.60193    5.77098   0.451 0.652561    
## mexicoSharjah             -35.91917   10.00386  -3.591 0.000413 ***
## mexicoSingapore            12.70946   10.02287   1.268 0.206213    
## mexicoStockholm             4.62347    8.47937   0.545 0.586164    
## mexicoSt. Petersburg      -39.66747    6.57832  -6.030 7.48e-09 ***
## mexicoStuttgart           -24.46898   10.20284  -2.398 0.017365 *  
## mexicoSydney                8.83888   11.81966   0.748 0.455426    
## mexicoTaipei              -12.61611    6.23625  -2.023 0.044363 *  
## mexicoTampere             -56.73924    9.54635  -5.944 1.18e-08 ***
## mexicoTokyo                21.02600    8.72998   2.408 0.016899 *  
## mexicoTomsk               -44.41300    7.68692  -5.778 2.77e-08 ***
## mexicoToronto              -6.06505   10.71791  -0.566 0.572091    
## mexicoToulouse            -52.66873    8.78497  -5.995 8.97e-09 ***
## mexicoValencia            -47.70333    8.05083  -5.925 1.29e-08 ***
## mexicoVancouver            -7.58419   10.63608  -0.713 0.476614    
## mexicoVienna               -8.98157   10.63675  -0.844 0.399431    
## mexicoVilnius             -27.66439    7.93870  -3.485 0.000602 ***
## mexicoWarsaw              -20.08373    7.14782  -2.810 0.005435 ** 
## mexicoWashington DC       -24.32660    7.91024  -3.075 0.002388 ** 
## mexicoWuhan               -52.33366    8.27938  -6.321 1.58e-09 ***
## mexicoZurich                8.73431   10.24762   0.852 0.395023    
## factor(year)2016            0.18389    2.50464   0.073 0.941543    
## factor(year)2017           -1.78811    3.19858  -0.559 0.576747    
## factor(year)2018           -0.28981    3.35055  -0.086 0.931156    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.711 on 206 degrees of freedom
##   (4 observations deleted due to missingness)
## Multiple R-squared:  0.9941,	Adjusted R-squared:  0.9907 
## F-statistic: 299.4 on 115 and 206 DF,  p-value: < 2.2e-16
```

```r
coef4 <- summary(fit4)$coef
```



```r
toronto2015 <- data[data$city=="Toronto"&data$year==2015,]

score <- coef4[2,1]*toronto2015$rankings + coef4[3,1]*toronto2015$student_view + coef4[4,1]*toronto2015$desirability + coef4[5,1]*toronto2015$emp_activity + coef4[6,1]*toronto2015$affordability + coef4[1,1] -6.07
score
```

```
## [1] 371.2817
```

```r
toronto2015$overall
```

```
## [1] 375
```

```r
# Calculating the error

abs((score-toronto2015$overall)/toronto2015$overall)*100
```

```
## [1] 0.991557
```

### Holdout 2014:

Training


```r
# Removing 2017

data5 <- data[data$year!=2014,]

str(data5)
```

```
## 'data.frame':	326 obs. of  9 variables:
##  $ year         : num  2018 2018 2018 2018 2018 ...
##  $ city         : Factor w/ 110 levels "Aberdeen","Adelaide",..: 50 99 56 62 76 65 12 110 96 89 ...
##  $ overall      : num  482 479 475 465 463 460 455 453 452 449 ...
##  $ rankings     : num  25 54 33 47 38 67 71 42 23 44 ...
##  $ student_mix  : num  93 100 86 80 88 78 80 90 84 92 ...
##  $ desirability : num  80 97 91 89 80 89 88 94 95 67 ...
##  $ emp_activity : num  92 55 100 94 80 74 75 83 97 67 ...
##  $ affordability: num  100 84 68 57 93 54 49 63 64 93 ...
##  $ student_view : num  92 89 98 100 84 99 94 82 90 86 ...
```

```r
# Fitting the model

mexico <- relevel(data5$city, "Mexico City")
fit5 <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+mexico+factor(year), data=data5)
summary(fit5)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + mexico + factor(year), 
##     data = data5)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -20.165  -2.117   0.000   2.364  18.626 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                78.28715   10.59773   7.387 3.57e-12 ***
## rankings                    1.05976    0.04805  22.055  < 2e-16 ***
## student_view                1.02561    0.02856  35.915  < 2e-16 ***
## desirability                0.81021    0.11079   7.313 5.56e-12 ***
## emp_activity                1.20725    0.15478   7.800 2.95e-13 ***
## affordability               1.03357    0.16106   6.417 9.21e-10 ***
## mexicoAberdeen            -50.22574   10.51376  -4.777 3.35e-06 ***
## mexicoAdelaide            -28.98291   11.44405  -2.533 0.012061 *  
## mexicoAmsterdam           -17.35010    9.26258  -1.873 0.062452 .  
## mexicoAnkara              -55.78064    6.56510  -8.497 3.75e-15 ***
## mexicoAthens              -54.94021    7.89813  -6.956 4.46e-11 ***
## mexicoAtlanta             -29.52574    7.46742  -3.954 0.000105 ***
## mexicoAuckland            -14.48252   12.05819  -1.201 0.231097    
## mexicoBaltimore           -38.35429    7.10255  -5.400 1.81e-07 ***
## mexicoBangkok             -19.91515    5.64584  -3.527 0.000516 ***
## mexicoBarcelona           -20.14019    8.52860  -2.361 0.019126 *  
## mexicoBeijing               8.19743    6.61262   1.240 0.216496    
## mexicoBerlin               -7.29142    9.93971  -0.734 0.464040    
## mexicoBirmingham          -32.21058    8.34604  -3.859 0.000152 ***
## mexicoBogota              -12.72636    5.45943  -2.331 0.020707 *  
## mexicoBoston               10.47077   11.53751   0.908 0.365171    
## mexicoBrighton            -77.64771   11.37478  -6.826 9.37e-11 ***
## mexicoBrisbane            -23.22835   11.32320  -2.051 0.041482 *  
## mexicoBrno                -60.65993   11.48607  -5.281 3.22e-07 ***
## mexicoBrussels            -42.58572    9.59768  -4.437 1.48e-05 ***
## mexicoBudapest            -33.64955    8.96848  -3.752 0.000228 ***
## mexicoBuenos Aires         -6.29041    8.33334  -0.755 0.451193    
## mexicoCairo               -48.13173    9.05806  -5.314 2.76e-07 ***
## mexicoCanberra            -17.59977   10.53646  -1.670 0.096350 .  
## mexicoCape Town           -83.63941    7.72429 -10.828  < 2e-16 ***
## mexicoChicago              -7.80449    9.57493  -0.815 0.415950    
## mexicoChristchurch        -41.68150    9.45340  -4.409 1.66e-05 ***
## mexicoCopenhagen          -21.28791   10.43456  -2.040 0.042601 *  
## mexicoCoventry            -25.45046   10.94500  -2.325 0.021020 *  
## mexicoDaejeon             -15.39644    5.00759  -3.075 0.002390 ** 
## mexicoDubai-Sharjah-Ajman -58.76228   11.77129  -4.992 1.26e-06 ***
## mexicoDublin              -24.40726   10.64611  -2.293 0.022871 *  
## mexicoEdinburgh           -22.58137   10.80667  -2.090 0.037872 *  
## mexicoGlasgow             -40.53955    9.21338  -4.400 1.73e-05 ***
## mexicoGold Coast          -58.31413   10.60531  -5.499 1.12e-07 ***
## mexicoGothenburg          -26.39328    9.00611  -2.931 0.003761 ** 
## mexicoGraz                -40.35552   11.66983  -3.458 0.000660 ***
## mexicoHelsinki            -34.15327    8.63280  -3.956 0.000104 ***
## mexicoHong Kong            -2.56308   10.39260  -0.247 0.805441    
## mexicoHouston             -51.19196    7.09158  -7.219 9.68e-12 ***
## mexicoHsinchu             -43.21462    5.96255  -7.248 8.16e-12 ***
## mexicoIstanbul            -34.79088    6.15015  -5.657 5.06e-08 ***
## mexicoJohannesburg        -62.21894    7.64353  -8.140 3.58e-14 ***
## mexicoKiev                -48.54598    9.58488  -5.065 8.99e-07 ***
## mexicoKuala Lumpur        -38.32624    5.83135  -6.572 3.91e-10 ***
## mexicoKyoto                -9.40308    8.99098  -1.046 0.296851    
## mexicoKyoto-Osaka-Kobe      2.61952    7.97811   0.328 0.742986    
## mexicoLille               -48.19933   10.27708  -4.690 4.94e-06 ***
## mexicoLima                -26.98575    8.71587  -3.096 0.002231 ** 
## mexicoLisbon              -34.26376    8.58763  -3.990 9.16e-05 ***
## mexicoLondon                9.15788   13.61565   0.673 0.501948    
## mexicoLos Angeles          -3.75071    9.00142  -0.417 0.677342    
## mexicoLyon                -42.08985    8.33074  -5.052 9.53e-07 ***
## mexicoMadrid              -23.33659    8.88895  -2.625 0.009299 ** 
## mexicoManchester          -15.27475   10.23594  -1.492 0.137144    
## mexicoManila              -57.67418    6.34881  -9.084  < 2e-16 ***
## mexicoMelbourne             3.72923   13.24073   0.282 0.778493    
## mexicoMiami               -42.98979    9.82559  -4.375 1.92e-05 ***
## mexicoMilan                 1.20155    7.91417   0.152 0.879474    
## mexicoMonterrey           -11.80903    5.85158  -2.018 0.044866 *  
## mexicoMontpellier         -66.46766   10.20642  -6.512 5.46e-10 ***
## mexicoMontreal             -8.25580   12.08895  -0.683 0.495416    
## mexicoMoscow              -11.82682    5.83203  -2.028 0.043845 *  
## mexicoMumbai              -13.78416    7.11719  -1.937 0.054132 .  
## mexicoMunich               -5.79197    9.70893  -0.597 0.551449    
## mexicoNagoya              -48.71601    8.35543  -5.830 2.09e-08 ***
## mexicoNanjing             -49.81159    5.78040  -8.617 1.73e-15 ***
## mexicoNewcastle Upon Tyne -65.29078    9.56441  -6.826 9.37e-11 ***
## mexicoNew Delhi           -19.71555    8.19038  -2.407 0.016951 *  
## mexicoNew York             -0.12241   10.61871  -0.012 0.990814    
## mexicoNottingham          -41.38847    9.06754  -4.564 8.56e-06 ***
## mexicoNovosibirsk         -41.95652    6.89961  -6.081 5.64e-09 ***
## mexicoOsaka               -30.83675    9.08991  -3.392 0.000829 ***
## mexicoOslo                -32.22545    9.35842  -3.443 0.000694 ***
## mexicoOttawa              -56.78276   11.49124  -4.941 1.59e-06 ***
## mexicoParis                 4.97583   12.17259   0.409 0.683126    
## mexicoPerth               -34.65936   10.47765  -3.308 0.001107 ** 
## mexicoPhiladelphia        -13.28522    7.72524  -1.720 0.086972 .  
## mexicoPittsburgh          -34.05163    7.97800  -4.268 2.99e-05 ***
## mexicoPrague              -27.55812    9.41332  -2.928 0.003796 ** 
## mexicoQuebec              -50.02045   10.95528  -4.566 8.51e-06 ***
## mexicoRio de Janeiro      -34.52870    6.31865  -5.465 1.32e-07 ***
## mexicoRiyadh              -61.23894    7.27468  -8.418 6.19e-15 ***
## mexicoRome                -64.64929    8.03864  -8.042 6.60e-14 ***
## mexicoSan Diego           -58.42563    7.53109  -7.758 3.81e-13 ***
## mexicoSan Francisco         2.26528    9.74943   0.232 0.816495    
## mexicoSantiago              1.81730    5.05853   0.359 0.719769    
## mexicoSao Paulo            -7.05144    4.66161  -1.513 0.131883    
## mexicoSeoul                 9.62775   10.13226   0.950 0.343109    
## mexicoShanghai             -0.04369    5.68500  -0.008 0.993876    
## mexicoSharjah             -47.82940   11.57716  -4.131 5.22e-05 ***
## mexicoSingapore             4.31868   10.60922   0.407 0.684376    
## mexicoStockholm             0.99778    9.65457   0.103 0.917787    
## mexicoSt. Petersburg      -48.25404    6.37000  -7.575 1.16e-12 ***
## mexicoStuttgart           -34.65518   11.04904  -3.136 0.001957 ** 
## mexicoSydney                4.87757   12.95967   0.376 0.707029    
## mexicoTaipei              -19.11229    6.41626  -2.979 0.003238 ** 
## mexicoTampere             -62.53673   10.57411  -5.914 1.35e-08 ***
## mexicoTokyo                22.62628   10.39266   2.177 0.030596 *  
## mexicoTomsk               -56.37393    7.98283  -7.062 2.42e-11 ***
## mexicoToronto              -9.23434   12.26870  -0.753 0.452497    
## mexicoToulouse            -64.89086   10.11692  -6.414 9.37e-10 ***
## mexicoValencia            -58.29230    9.36912  -6.222 2.66e-09 ***
## mexicoVancouver            -8.58793   12.02182  -0.714 0.475804    
## mexicoVienna              -22.92207   12.02546  -1.906 0.058012 .  
## mexicoVilnius             -36.50879    8.42638  -4.333 2.29e-05 ***
## mexicoWarsaw              -29.64527    8.05098  -3.682 0.000295 ***
## mexicoWashington DC       -24.18931    8.77724  -2.756 0.006373 ** 
## mexicoWuhan               -58.36358    7.68440  -7.595 1.03e-12 ***
## mexicoZurich                2.19971   11.27641   0.195 0.845527    
## factor(year)2016           -1.72834    1.28686  -1.343 0.180712    
## factor(year)2017           -3.41978    2.43447  -1.405 0.161593    
## factor(year)2018           -2.73382    2.53102  -1.080 0.281337    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.885 on 208 degrees of freedom
## Multiple R-squared:  0.9953,	Adjusted R-squared:  0.9926 
## F-statistic: 375.8 on 117 and 208 DF,  p-value: < 2.2e-16
```

```r
coef5 <- summary(fit5)$coef
```



```r
toronto2014 <- data[data$city=="Toronto"&data$year==2014,]

score <- coef5[2,1]*toronto2014$rankings + coef5[3,1]*toronto2014$student_view + coef5[4,1]*toronto2014$desirability + coef5[5,1]*toronto2014$emp_activity + coef5[6,1]*toronto2014$affordability + coef5[1,1] -6.07
score
```

```
## [1] 387.7309
```

```r
toronto2014$overall
```

```
## [1] 371
```

```r
# Calculating the error

abs((score-toronto2014$overall)/toronto2014$overall)*100
```

```
## [1] 4.509669
```
