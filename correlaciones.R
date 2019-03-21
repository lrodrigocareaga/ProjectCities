## Scrip to plot correlations

## Loading libraries

library(xlsx)
library(dplyr)
library(reshape2)
library(ggpubr)
library(DescTools)
library(xtable)

## Reading data

data2018 <- read.xlsx2("best_cities.xlsx", sheetIndex = 1)

# Changing the names of the columns

colnames(data2018) <- c("Rank", "City", "Overall", "Affordability", "Employer Activity", "Desirability", "Student Mix", "Rankings", "Student View")

data <- data2018[,-1] 

data <- melt(data, id.vars = c("City", "Overall"), value.name = "Indicators")

data$Indicators <- as.numeric(as.character(data$Indicators))

colnames(data) <- c("City", "Overall", "Indicator", "Indicators")

# Creating factors and plotting

data$Indicator <- as.factor(data$Indicator)
data$Overall <- as.numeric(data$Overall)

sp <- ggscatter(data, x = "Overall", y = "Indicators",
   color = "Indicator", palette = "jco",
   add = "reg.line", conf.int = TRUE)
sp + stat_cor(aes(color = Indicator), label.x = 3)

ggplot(data, aes(x=Overall, y=Indicators, col=Indicator)) + geom_point() +
            geom_smooth(method="lm", se=FALSE)

# Exporting

dev.copy(png, file = "Corr_Ind.png", width=1110, height=1110, res = 300)
dev.off()

# For Unis Ranked (Total universities ranked)

dat2 <- data2018
dat2$UnivRank <- 0

unis <- read.xlsx2("best_cities.xlsx", sheetIndex = 6)  

unis$unis_Ranked <- as.numeric(as.character(unis$unis_Ranked))
unis$city <- as.character(unis$city)
dat2$City <- as.character(dat2$City)

for(i in 1:109){
    for(j in 1:101){
        if(unis$city[i] == dat2$City[j]){
            dat2$UnivRank[j] <- unis$unis_Ranked[i]
        }    
    }
}

dat2$Rank <- as.numeric(as.character(dat2$Rank))

# Add Top variable

dat2$Top <- "0"

for(i in 1:101){
    if(dat2$Rank[i] <= 10){
        dat2$Top[i] <- dat2$City[i]
    } else{
        dat2$Top[i] <- "10+"
    }
}

dat2$Top <- as.factor(dat2$Top)

sp <- ggscatter(dat2, x = "Rank", y = "UnivRank",
   color = "Top", palette = "jco",
   add = "reg.line", conf.int = TRUE)
sp + stat_cor(aes(color = Top), label.x = 3)

ggplot(dat2, aes(x=Rank, y=UnivRank, col=Top)) + geom_point()

# Exporting

dev.copy(png, file = "Rank_Unis.png", width=1110, height=1110, res = 300)
dev.off()

# Bar plot

ggplot(dat2, aes(x=Rank, y=UnivRank, fill=Top)) + geom_bar(stat = "identity")

dev.copy(png, file = "Rank_Unis1.png", width=1110, height=1110, res = 300)
dev.off()


