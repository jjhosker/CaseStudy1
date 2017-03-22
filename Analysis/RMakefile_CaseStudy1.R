#############################################################
## Country Analysis by GDP and Income Group for 2012
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Date Created: 4-Mar-2017
## Last Update:  4-Mar-2017
## Description:  This R file is for analysis of country 
##               GDPs globally by country income groups.
##               Here we analyze five key questions/points 
##               for our client around two sets of data:
##               the Gross Domestic Product data for 
##               190 ranked countries and Educational 
##               Data both from the World Bank on 235
##               countries. 
##
##############################################################

###################################################
## Execute GatherData_CaseStudy1.R Makefile
## 1. This R Makefile reads in the data files from 
##    World Banks websites using URLs
## 2. Creates the raw data frames
## 3. Cleans the raw data and creates a clean dataset
## 4. Merges GDP with FEDSTATS cleaned data frames 
##    to a dataset called GDPFEDdata.
## 5. Finally, this makefile install, loads and 
##    requires all the R libraries.  In addition, 
##    it save the R session information
##    to a text file called sessioninfo.txt for
##    reference.
## For more information see referenced R Makefile.
###################################################
source("Analysis/Data/Makefile_GatherData.R")

###################################################
## Load Plot Function Makefile for CaseStudy1
##    This R Makefile loads plot functions to plot
##    Figures 1 and 2 for both 
##    RMakefile_CaseStudy1.R and CaseStudy1PDF.Rmd
###################################################
source("Analysis/PlotFunctions_CaseStudy1.R")

######################################################
##  5 Key Points/Questions on Merged Data File
######################################################

######################################################
##  Key Point/Question #1:  After merging the datasets
##  into GDPFEDclean, there are 190 IDs that match 
##  and that 45 did not match between GDP and 
##  FEDSTATS datasets.
######################################################
## Number of IDs that match in GDPFEDclean
sum(!is.na(GDPFEDclean$GDP_MillUSD))
## Number of IDs that did not match and have NA
sum(is.na(GDPFEDclean$GDP_MillUSD))
## Total of variables in GDPFEDclean
length(GDPFEDclean)
## Total number of IDs in GDPFEDclean
nrow(GDPFEDclean)
## 234-45+1 = 190 IDs match

## R Code for CaseStudy1PDF.Rmd
## print(paste("Number of country code IDs that match: ",sum(!is.na(GDPFEDclean$GDP_MillUSD)),"."))
## print(paste("Number of country code IDs that do not match: ",sum(is.na(GDPFEDclean$GDP_MillUSD)),"."))
## print(paste("Total Number of Variables: ",length(GDPFEDclean),"."))
## cat(paste("Variable names are:", toString(variable.names(GDPFEDclean)[1:4]),"\n",
##          "                  ",
##          toString(variable.names(GDPFEDclean)[5:7]),"."))

###################################################
##  Key Point #2:  After sorting by GDP in Millions 
##  USD in ascending order. The 13th Country is:
##  St. Kitts and Nevis (country code KNA).
###################################################
## re-order cleaned data by ascending GDP in Million USD
GDPFEDsort <- GDPFEDclean[order(GDPFEDclean$GDP_MillUSD,decreasing = FALSE, na.last=TRUE),]
## find 13th entry into the data frame after sorting
GDPFEDsort$CountryCode[13]
GDPFEDsort$Economy[13]
GDPFEDsort$Long.Name[13]

## R Code for CaseStudy1PDF.Rmd
## print(paste("13th Ranked Country by GDP is",
##           GDPFEDsort$CountryCode[13], ", which is ", GDPFEDsort$Economy[13],"."))

#####################################################
##  Key Point #3:  
##  a. The average GDP in Millions USD for
##  all High Income OECD countries is $1,483,917 mill
##  and has a mean GDP rank of 32.97.
##  The OECD is the Organization for Economic 
##  Cooperation and Development.   Larger GDP
##  economies are generally members.
##
##  b. The average GDP in Millions USD for
##  all High income non-OECD countries is 
##  $104,349.8 mill and has a mean GDP rank of 91.91.  
##  The OECD is the Organization for Economic 
##  Cooperation and Development.   Small GDP
##  economies are generally not members.
#####################################################
## a. Mean and summary statistics for GDP Rank and GDP for High Income OECD income group
GDPFEDavg    <- GDPFEDsort[!is.na(GDPFEDsort$GDP_MillUSD),]
MeanRankOECD <- mean(GDPFEDavg[GDPFEDavg$Income.Group == "High income: OECD", "GDPRank"],na.rm = TRUE)
MeanGDPOECD  <-mean(GDPFEDavg[GDPFEDavg$Income.Group == "High income: OECD", "GDP_MillUSD"],na.rm = TRUE)
## b. Mean and summary statistics GDP Rank and GDP for High Income nonOECD income group
GDPFEDavg <- GDPFEDsort[!is.na(GDPFEDsort$GDP_MillUSD),]
MeanRanknonOECD <- mean(GDPFEDavg[GDPFEDavg$Income.Group == "High income: nonOECD", "GDPRank"],na.rm = TRUE)
MeanGDPnonOECD  <- mean(GDPFEDavg[GDPFEDavg$Income.Group == "High income: nonOECD", "GDP_MillUSD"],na.rm = TRUE)
round(MeanRankOECD,1)
round(MeanGDPOECD,1)
round(MeanRanknonOECD,1)
round(MeanGDPnonOECD,1)
## R Code for CaseStudy1PDF.Rmd
## cat(paste("The mean GDP rank of the High Income:  OECD income group is",
##            round(MeanRankOECD,1),"\n       & the GDP is in", round(MeanGDPOECD,1),"USD Millions"))
## cat(paste("The mean GDP rank of the High Income: nonOECD income group is",
##            round(MeanRanknonOECD,1),"\n      & the GDP is in", round(MeanGDPnonOECD,1),"USD Millions"))

#####################################################
##  Key Point #4:  Use ggplot to color your plot by   
##  income group.
#####################################################
## Filter Income.Group out NAs and blanks and then sort
GDPFEDinc <- GDPFEDsort[GDPFEDsort$Income.Group!="" & !is.na(GDPFEDsort$Income.Group),]
GDPFEDinc <- GDPFEDinc[!is.na(GDPFEDinc$GDP_MillUSD),]
GDPFEDinc <- GDPFEDinc[order(GDPFEDinc$Income.Group,decreasing = FALSE, na.last=TRUE),]
## GDPFEDinc now has 189 countries with GDP in $Mill and a valid Income Group
## One sample gets eliminated since South Sudan (SSD) has an NA for 
## Income.Group but a valid GDP in $10,200 Million.   
## So, it gets eliminated since it has no Income Group.
## unique(GDPFEDinc$Income.Group)
GDPFEDinc[,"CntryNum"] = as.numeric(c(as.numeric(seq(1,189,by=1))))
GDPFEDavg[,"CntryNum"] = as.numeric(c(as.numeric(seq(1,190,by=1))))
GDPFEDavg2 <- GDPFEDavg[!is.na(GDPFEDavg$Income.Group),] 
GDPFEDavg2[,"CntryNum"] = as.numeric(c(as.numeric(seq(1,189,by=1))))

## R Code for CaseStudy1PDF.Rmd for plot
## Plot all GDPs
PlotFig1()
  
## R Code for CaseStudy1PDF.Rmd for plot
## Plot GDPs of each income group separately vs. GDP
PlotFig2()

## R Code for CaseStudy1PDF.Rmd for plot
## Plot GDPs of each income group separately for GDP < $2,500,000 Mill
ggplot(subset(GDPFEDinc, Income.Group %in% c("Low income","Lower middle income",
                                             "Upper middle income", "High income: nonOECD", "High income: OECD")),
       aes(x=GDPFEDinc$CntryNum, y=GDPFEDinc$GDP_MillUSD, color=Income.Group))+ 
  geom_point() + 
  ggtitle("Fig.3: GDP by Income Group (GDP < $2,500,000 Mill)") + 
  labs(x="GDP within Each Income Group (Low to High)", y="GDP in USD Millions") +
  ylim(0,2500000)

## Get GDP rank means & summary statistics of each income group
## summary(GDPFEDavg[GDPFEDavg$Income.Group == "Low income", "GDPRank"],na.rm = TRUE)
## summary(GDPFEDavg[GDPFEDavg$Income.Group == "Lower middle income", "GDPRank"],na.rm = TRUE)
## summary(GDPFEDavg[GDPFEDavg$Income.Group == "Upper middle income", "GDPRank"],na.rm = TRUE)
## summary(GDPFEDavg[GDPFEDavg$Income.Group == "High income: OECD", "GDPRank"],na.rm = TRUE)
## summary(GDPFEDavg[GDPFEDavg$Income.Group == "High income: nonOECD", "GDPRank"],na.rm = TRUE)

## Create summary statistic table for each income group
sumclass <- c("Income.Group","Min.","1st Qu.","Median","Mean","3rd Qu.","Max")
incgrps <- c("Low income", "Lower middle income", "Upper middle income" ,
             "High income: nonOECD", "High income: OECD")   
sumtable <- data.frame()
sumtable <- data.frame(incgrps, "Min."<-c(0), "1st Qu."<-c(0), "Median"<-c(0), 
                       "Mean"<-c(0), "3rd Qu."<-c(0),"Max"<-c(0))
names(sumtable) <- sumclass
sumtable$Income.Group <- incgrps
temp <- c()
for(j in 1:length(incgrps)){
    tx <- summary(GDPFEDavg[GDPFEDavg$Income.Group == incgrps[j],"GDPRank"], na.rm=TRUE)
    for(k in 2:length(sumclass)){
      sumtable[j,k] <- as.numeric(gsub("[digits]", "", tx[k-1]))
    }
}

## R Code for CaseStudy1PDF.Rmd for Summary Table output of GDP Rank vs. Income Groups in Rmd file
kable((sumtable), format="pandoc", align='c',row.names = FALSE,
      col.names = sumclass, caption = "Summary Statistics of GDP by Income Groups")  

#######################################################
##  Key Point #5:  
##  1. Cut GDP into 5 quintiles and create a table 
##     for RMarkdown.  
##  2. Find those countries that are in the 
##     "Lower Middle income" but among the top 38 
##     nations with the highest GDP using GDPRank:  
##     The Arab Republic of Egypt, Thailand, Indonesia, 
##     India and China.
#######################################################
## re-order cleaned data by ascending GDP in Million USD and remove NAs
GDPFEDsort2 <- GDPFEDsort[!is.na(GDPFEDsort$GDP_MillUSD),]
## Remove blanks and NAs from Income Group
GDPFEDsort2 <- GDPFEDsort2[GDPFEDsort2$Income.Group!="" & !is.na(GDPFEDsort2$Income.Group),]
## Order GDP_MillUSD in ascending order smallest to larger value
GDPFEDsort2 <- GDPFEDsort2[order(GDPFEDsort2$GDP_MillUSD,decreasing = FALSE, na.last=TRUE),]

## Rank order the GDP Million USD by five quintiles
GDPFEDsort2$Quintile <- with(GDPFEDsort2, factor(findInterval(GDPFEDsort2$GDP_MillUSD, 
      c(-Inf, quantile(GDPFEDsort2$GDP_MillUSD, probs=c(0.2, 0.4, 0.6, 0.8)), Inf) ), 
      labels=c("Q1","Q2","Q3","Q4", "Q5")))
GDPFEDsort2$Quintile <- as.character(GDPFEDsort2$Quintile)
colvars <- c("Quintile","GDP_MillUSD", "Income.Group", "GDPRank", "CountryCode", "Economy")
GDPFEDsort2 <- GDPFEDsort2[,colvars]

## Use kable in knitr to render table
TableColNames <- c("Quintile", "GDP ($Mill)", "Income Group", "GDP Rank", "Country Code","Country")

## R Code for CaseStudy1PDF.Rmd for Summary Table output of GDP Rank vs. Income Groups in Rmd file
kable((GDPFEDsort2[,colvars]), format="pandoc", align='c',row.names = FALSE,
      col.names = TableColNames, 
      caption = "Summary Data by Quintile Ranking of GDP ($Mill)")  

## R Code for CaseStudy1PDF.Rmd for Summary Table Income Group Count for each quintile
## Count for each quintile the number in each income category
varnameclass <- c("Income.Group","Q1", "Q2", "Q3", "Q4", "Q5")
incgrps <- c("Low income", "Lower middle income", "Upper middle income" ,
             "High income: OECD", "High income: nonOECD")   
sumquint <- data.frame()
sumquint <- data.frame(incgrps,"Q1", "Q2", "Q3", "Q4", "Q5")
names(sumquint) <- varnameclass
sumquint$Income.Group <- incgrps

quintclass <- c("Q1", "Q2", "Q3", "Q4", "Q5")
for (i in 1:length(quintclass)){
  temp <- c()
  for(j in 1:length(incgrps)){
    tx <- sum(GDPFEDsort2$Quintile == quintclass[i] & GDPFEDsort2$Income.Group == incgrps[j])
    temp <- c(temp,tx)
  }
  sumquint[,quintclass[i]] <- temp
}

## R Code for CaseStudy1PDF.Rmd for Summary Table Income Group Count for each quintile
kable((sumquint), format="pandoc", align='c',row.names = FALSE,
      col.names = varnameclass, 
      caption = "Summary Count of Income Groups in Each GDP Quintile")  

## R Code for CaseStudy1PDF.Rmd 
## Find those countries that are in the Lower Middle income but among 
## the top 38 nations with the highest GDP (using GDPRank)
Filtered <- GDPFEDsort2[GDPFEDsort2$GDPRank <= 38 & GDPFEDsort2$Income.Group == "Lower middle income",
                        c("CountryCode","Economy","GDPRank")]
## Render Table of Countries meeting the criteria
kable((Filtered), format="pandoc", align='c',row.names = FALSE,
      col.names = c("CountryCode","Economy","GDPRank"), 
      caption = "Countries in Lower Middle Income with GDPRank<=38")  