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
library(knitr)
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
fit <- lm(overall~rankings+student_view+desirability+emp_activity+affordability+student_view+city, data=data1)
summary(fit)
```

```
## 
## Call:
## lm(formula = overall ~ rankings + student_view + desirability + 
##     emp_activity + affordability + student_view + city, data = data1)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -21.508  -2.701   0.000   3.034  18.884 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)              30.56736   15.99297   1.911 0.057669 .  
## rankings                  0.99302    0.04673  21.250  < 2e-16 ***
## student_view              1.06964    0.10647  10.047  < 2e-16 ***
## desirability              0.86469    0.07429  11.639  < 2e-16 ***
## emp_activity              1.35121    0.12699  10.641  < 2e-16 ***
## affordability             1.05862    0.07512  14.092  < 2e-16 ***
## cityAmsterdam            11.27054    6.39722   1.762 0.079924 .  
## cityAnkara              -18.22318   10.95910  -1.663 0.098210 .  
## cityAthens               -1.20734   10.86383  -0.111 0.911643    
## cityAtlanta               1.87265    7.42390   0.252 0.801159    
## cityAuckland             16.74185    4.95892   3.376 0.000913 ***
## cityBaltimore            -5.14634    8.78971  -0.585 0.559000    
## cityBangkok              18.79805   12.70112   1.480 0.140738    
## cityBarcelona            13.23383    5.73476   2.308 0.022238 *  
## cityBeijing              42.41238    7.02629   6.036 9.80e-09 ***
## cityBerlin               20.38807    6.39441   3.188 0.001707 ** 
## cityBirmingham           -0.93549    6.67443  -0.140 0.888701    
## cityBogota               27.29732   12.32623   2.215 0.028135 *  
## cityBoston               33.40798    7.05857   4.733 4.67e-06 ***
## cityBrisbane              3.47995    6.15979   0.565 0.572864    
## cityBrno                -29.26185    8.79051  -3.329 0.001072 ** 
## cityBrussels            -12.68035    5.34167  -2.374 0.018732 *  
## cityBudapest             -1.77211   11.38263  -0.156 0.876468    
## cityBuenos Aires         26.40517    5.73401   4.605 8.11e-06 ***
## cityCairo               -14.92732    9.97167  -1.497 0.136277    
## cityCanberra             10.58926    5.57183   1.900 0.059080 .  
## cityChicago              16.66714    5.72459   2.912 0.004085 ** 
## cityChristchurch         -6.13275    8.72708  -0.703 0.483198    
## cityCopenhagen           15.50941    5.81072   2.669 0.008351 ** 
## cityCoventry              0.51399    5.77747   0.089 0.929216    
## cityDaejeon              26.33235   11.39749   2.310 0.022084 *  
## cityDublin                1.39906    5.81310   0.241 0.810101    
## cityEdinburgh             1.10041    6.37763   0.173 0.863219    
## cityGlasgow             -15.79411    7.02115  -2.250 0.025779 *  
## cityGold Coast          -24.35783    7.81147  -3.118 0.002141 ** 
## cityGothenburg            0.17868    7.16883   0.025 0.980144    
## cityHelsinki              0.86253    7.42785   0.116 0.907695    
## cityHong Kong            27.83902    5.74341   4.847 2.83e-06 ***
## cityHouston             -16.14865   10.27904  -1.571 0.118058    
## cityHsinchu              -2.31512   10.48953  -0.221 0.825588    
## cityIstanbul              1.36052   11.13532   0.122 0.902902    
## cityJohannesburg        -20.12793   11.77276  -1.710 0.089167 .  
## cityKiev                 -4.53604   14.33137  -0.317 0.752008    
## cityKuala Lumpur         -2.32875    8.46522  -0.275 0.783580    
## cityKyoto                25.11099   10.00624   2.510 0.013036 *  
## cityKyoto-Osaka-Kobe     36.21107    9.15032   3.957 0.000112 ***
## cityLille               -11.33125   11.51088  -0.984 0.326337    
## cityLima                 15.11938   14.15272   1.068 0.286917    
## cityLisbon               -3.73952    7.51853  -0.497 0.619576    
## cityLondon               32.07411    7.66952   4.182 4.64e-05 ***
## cityLos Angeles          23.05955    5.54387   4.159 5.08e-05 ***
## cityLyon                -12.68615    6.09715  -2.081 0.038982 *  
## cityMadrid               11.74444    5.61436   2.092 0.037955 *  
## cityManchester            9.27580    5.66034   1.639 0.103140    
## cityManila              -15.15145   12.85408  -1.179 0.240173    
## cityMelbourne            26.48541    7.28435   3.636 0.000368 ***
## cityMexico City          36.37109   10.06480   3.614 0.000399 ***
## cityMilan                34.91666    5.87066   5.948 1.53e-08 ***
## cityMonterrey            32.22646   12.33748   2.612 0.009815 ** 
## cityMontpellier         -29.38859   11.38397  -2.582 0.010689 *  
## cityMontreal             13.90797    6.92440   2.009 0.046187 *  
## cityMoscow               16.80536    6.78683   2.476 0.014271 *  
## cityMumbai               26.47740   13.89905   1.905 0.058491 .  
## cityMunich               22.17629    6.18626   3.585 0.000442 ***
## cityNanjing             -12.50081   12.45623  -1.004 0.317025    
## cityNewcastle Upon Tyne -37.92200    6.33104  -5.990 1.24e-08 ***
## cityNew Delhi            24.01304   14.69454   1.634 0.104100    
## cityNew York             24.95013    6.81261   3.662 0.000335 ***
## cityNottingham          -13.51960    7.52267  -1.797 0.074103 .  
## cityNovosibirsk          -2.05603   12.54535  -0.164 0.870016    
## cityOsaka                 9.84731   11.90869   0.827 0.409466    
## cityOslo                 -2.38349    6.47592  -0.368 0.713296    
## cityOttawa              -30.19013    7.53127  -4.009 9.17e-05 ***
## cityParis                32.15729    6.83072   4.708 5.21e-06 ***
## cityPerth                -7.75611    5.08269  -1.526 0.128894    
## cityPhiladelphia         17.02628    6.40543   2.658 0.008617 ** 
## cityPittsburgh           -1.98017    6.64402  -0.298 0.766043    
## cityPrague                1.08528    6.94083   0.156 0.875936    
## cityQuebec              -14.75582    9.23553  -1.598 0.111984    
## cityRio de Janeiro        4.45010   12.61223   0.353 0.724651    
## cityRiyadh              -21.27665   10.82489  -1.966 0.051001 .  
## cityRome                -31.65681    7.30199  -4.335 2.50e-05 ***
## citySan Diego           -21.59101    7.72132  -2.796 0.005772 ** 
## citySan Francisco        29.64554    5.56304   5.329 3.14e-07 ***
## citySantiago             40.46043    8.93851   4.527 1.13e-05 ***
## citySao Paulo            36.03630   10.60957   3.397 0.000852 ***
## citySeoul                35.44489    7.01617   5.052 1.13e-06 ***
## cityShanghai             34.24862    8.36435   4.095 6.56e-05 ***
## citySharjah             -14.45349    8.40615  -1.719 0.087384 .  
## citySingapore            33.34906    5.72261   5.828 2.80e-08 ***
## cityStockholm            30.36219    5.91509   5.133 7.81e-07 ***
## citySt. Petersburg      -10.75420   12.10170  -0.889 0.375461    
## citySydney               29.51851    6.27110   4.707 5.23e-06 ***
## cityTaipei               16.47658    7.74563   2.127 0.034862 *  
## cityTampere             -26.56289   10.96932  -2.422 0.016518 *  
## cityTokyo                49.52815    7.62797   6.493 9.12e-10 ***
## cityTomsk               -21.19887   12.06227  -1.757 0.080662 .  
## cityToronto              13.19693    5.80720   2.273 0.024323 *  
## cityToulouse            -32.86744    8.25129  -3.983 0.000101 ***
## cityValencia            -23.29254    9.08858  -2.563 0.011259 *  
## cityVancouver            11.89791    5.40891   2.200 0.029195 *  
## cityVienna                4.57652    5.47201   0.836 0.404146    
## cityVilnius              -3.26151   12.12064  -0.269 0.788193    
## cityWarsaw                0.81014    9.48203   0.085 0.932013    
## cityWashington DC         7.62138    6.03873   1.262 0.208668    
## cityWuhan               -17.11996   12.52463  -1.367 0.173482    
## cityZurich               27.90914    5.51275   5.063 1.08e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.914 on 168 degrees of freedom
## Multiple R-squared:  0.9951,	Adjusted R-squared:  0.9921 
## F-statistic: 324.4 on 106 and 168 DF,  p-value: < 2.2e-16
```

```r
# Diagnostic of residuals.
par(mfrow=c(2,2))
plot(fit)
```

```
## Warning: not plotting observations with leverage one:
##   3, 4, 8, 13, 18, 20, 34, 36, 37, 38, 41, 42, 49, 54, 57, 59, 60, 64, 73, 74, 84, 88, 90, 96, 99, 223

## Warning: not plotting observations with leverage one:
##   3, 4, 8, 13, 18, 20, 34, 36, 37, 38, 41, 42, 49, 54, 57, 59, 60, 64, 73, 74, 84, 88, 90, 96, 99, 223
```

![](panel2_files/figure-html/fit-1.png)<!-- -->

```r
# Prediction
test <- data[data$year==2018,]

# Removing some cities that did not appear before 2018 and the model cannot predict
data2 <- test[-grep("Aberdeen",test$city),]
data2 <- data2[-grep("Brighton",data2$city),]
data2 <- data2[-grep("Cape Town",data2$city),]
data2 <- data2[-grep("Dubai-Sharjah-Ajman",data2$city),]
data2 <- data2[-grep("Graz",data2$city),]
data2 <- data2[-grep("Miami",data2$city),]
data2 <- data2[-grep("Nagoya",data2$city),]
data2 <- data2[-grep("Stuttgart",data2$city),]
result <- predict(fit, data2)
error <- paste(abs(result-data2[,"overall"])/data2[,"overall"]*100,"%")
set <- cbind(as.character(data2[,"city"]),data2[,"overall"],result,error)
colnames(set) <- c("City", "Test", "Predicted", "Error")
summary(abs(result-data2[,"overall"])/data2[,"overall"]*100)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##  0.03579  0.49680  0.98810  1.61100  1.96300 11.52000
```

```r
kable(set)
```

      City                  Test   Predicted          Error                
----  --------------------  -----  -----------------  ---------------------
1     London                482    485.221349523243   0.668329776606459 %  
2     Tokyo                 479    476.031236531244   0.61978360516837 %   
3     Melbourne             476    480.44001215057    0.932775661884358 %  
4     Montreal              467    462.422689255206   0.980152193746046 %  
5     Paris                 463    466.031896718851   0.654837304287446 %  
6     Munich                461    459.281792080928   0.372713214549173 %  
7     Berlin                457    451.310899425311   1.24487977564303 %   
8     Zurich                454    448.017222459064   1.3177924098978 %    
9     Sydney                453    460.156481313217   1.57979719938555 %   
10    Seoul                 449    448.610277784222   0.0867978208858598 % 
11    Vienna                446    441.054007808605   1.10896685905719 %   
12    Hong Kong             443    449.946125943115   1.56797425352475 %   
13    Boston                442    442.422336118295   0.0955511579853568 % 
14    Toronto               441    441.315552814338   0.0715539261536621 % 
15    Singapore             440    441.223414230879   0.27804868883604 %   
16    Edinburgh             417    415.744323937955   0.301121357804498 %  
17    Vancouver             414    411.98226697238    0.487375127444378 %  
18    New York              414    417.311158903177   0.79979683651614 %   
19    Kyoto-Osaka-Kobe      413    414.803311648647   0.436637203062247 %  
20    Taipei                407    406.404472468027   0.146321260926916 %  
21    Brisbane              407    410.963371573979   0.973801369528087 %  
22    Canberra              405    409.374179078619   1.080044216943 %     
23    Auckland              402    416.841185645606   3.69183722527507 %   
24    Manchester            399    400.982106655583   0.4967685853592 %    
25    Buenos Aires          396    404.385198722338   2.11747442483272 %   
26    Beijing               392    394.428305061944   0.619465577026647 %  
27    Amsterdam             390    385.147059347548   1.24434375703896 %   
28    Moscow                389    375.673353460567   3.42587314638386 %   
29    Shanghai              385    389.121028078039   1.07039690338681 %   
30    Prague                382    373.998074068129   2.09474500834328 %   
31    Barcelona             382    384.475491265309   0.648034362646325 %  
32    Madrid                380    379.864015326769   0.0357854403238895 % 
33    Stockholm             377    378.928967715428   0.511662523986305 %  
34    Dublin                377    365.607393136013   3.02191163500978 %   
35    Los Angeles           369    369.864757926591   0.234351741623496 %  
36    Milan                 367    372.221848691982   1.42284705503607 %   
37    Kuala Lumpur          365    363.808734865902   0.326374009341899 %  
38    San Francisco         362    362.611069790914   0.168803809644681 %  
39    Perth                 362    360.358347635887   0.453495128207991 %  
40    Chicago               360    357.5079998414     0.692222266277851 %  
41    Adelaide              358    362.476270210443   1.25035480738624 %   
42    Lyon                  358    346.153864663585   3.3089763509538 %    
43    Glasgow               353    345.519190682673   2.11920943833639 %   
44    Coventry              348    344.561374820578   0.988110683742033 %  
45    Copenhagen            346    371.183369436707   7.27843047303657 %   
46    Ottawa                345    343.578794973322   0.411943485993515 %  
47    Nottingham            341    340.537152361817   0.135732445214958 %  
48    Brussels              336    328.074063827147   2.35890957525395 %   
49    Budapest              333    318.998724823603   4.20458714005901 %   
50    Lisbon                329    319.226711464202   2.97060441817583 %   
51    Birmingham            325    326.869026452612   0.575085062342256 %  
52    Mexico City           321    317.647385184217   1.04442829152117 %   
53    Warsaw                315    294.2787492344     6.57817484622212 %   
54    Bangkok               306    303.699579131666   0.751771525599221 %  
56    Newcastle Upon Tyne   304    298.804870608808   1.70892414183952 %   
57    Gothenburg            303    298.615446753698   1.44704727600721 %   
58    Philadelphia          302    302.518154723664   0.171574411809214 %  
60    Washington DC         301    323.904103941757   7.60933685772645 %   
62    Atlanta               296    295.366970944721   0.213861167324043 %  
63    Brno                  295    296.66567095703    0.564634222722049 %  
64    Santiago              296    299.189437114205   1.07751253858291 %   
65    Oslo                  292    291.775210192475   0.0769828107961304 % 
66    Rome                  291    292.555831164124   0.534649884578856 %  
67    Istanbul              279    277.69429408882    0.467994950243763 %  
68    Pittsburgh            278    277.243222262067   0.272222207889617 %  
69    Christchurch          276    283.671675303823   2.77959250138498 %   
70    Sao Paulo             273    282.876187902098   3.61765124618977 %   
72    Riyadh                268    269.947208241263   0.726570239277413 %  
73    Hsinchu               267    268.718527188573   0.643643141787526 %  
74    Tomsk                 264    254.78231405662    3.49154770582566 %   
75    Helsinki              263    269.180662022996   2.35006160570201 %   
76    Athens                262    292.189805288312   11.5228264459207 %   
77    St. Petersburg        258    252.934681248134   1.96330184180835 %   
78    Toulouse              257    248.996589267964   3.11416760001419 %   
79    Johannesburg          257    261.471235411534   1.73978031577187 %   
80    San Diego             256    271.031831285906   5.871809096057 %     
81    Bogota                255    250.782117712426   1.65407148532303 %   
82    Ankara                253    250.941123975516   0.813784989914633 %  
83    Monterrey             249    248.385329006004   0.246855820882128 %  
84    Vilnius               245    233.210383325366   4.81208843862611 %   
86    Daejeon               243    244.491526175168   0.613796779904347 %  
87    Gold Coast            239    245.23405422998    2.60839089120508 %   
88    Nanjing               236    233.113583373143   1.22305789273588 %   
89    Quebec                236    240.381792545249   1.85669175646138 %   
90    Baltimore             235    233.217844919418   0.758363864077441 %  
91    Valencia              234    229.423569277803   1.95573962487047 %   
94    Cairo                 229    226.137815833371   1.24986208149734 %   
95    Manila                229    230.288400730225   0.562620406211613 %  
96    Novosibirsk           225    221.433557092494   1.58508573666941 %   
97    Houston               224    226.550827576442   1.13876231091167 %   
98    Montpellier           224    226.161793936171   0.965086578647778 %  
99    Mumbai                224    216.467628558618   3.36266582204545 %   
101   Rio de Janeiro        217    216.064581275501   0.431068536635282 %  

