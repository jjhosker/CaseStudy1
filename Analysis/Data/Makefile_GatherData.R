###################################################
## GathereData_CaseStudy1.R is a R Makefile for
##     for the Rmd file:  CaseStudy1PDF.Rmd
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Assignment:   For Case Study 1 
## Date Created: 4-Mar-2017
## Last Update:  4-Mar-2017
## Description:  MakefileFEDGDP.txt inputs two
##               csv files from two web URLs:
##               GDPsite and FEDSTATSsite 
##               (given in this Makefile).  This 
##               makefile then cleans the raw data
##               and creates two clean datasets:
##               for analysis:  GDPclean and 
##               FEDSTATSclean. 
## Output:       Finally we create or output one 
##               cleaned/merged dataset: GDPFEDclean.
##               We also save the R session_Info.
###################################################

###################################################
## Libraries and packages that need to be Installed
###################################################
packageslibs = c("devtools","repmis","downloader",
                 "ggplot2","xtable","kableExtra",
                 "knitr")

######################################################
## Function packagelibrary.check
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Date Created: 17-Mar-2017
## Last Update:  17-Mar-2017
## Description:  We use this function to check if 
##               each package is on the local machine.
##               If the package(s) is installed, 
##               it will be loaded as a library. 
##               If the package(s) is not install, 
##               the missing package(s) will be 
##               installed and libray loaded.
######################################################
packagelibrary.check <- lapply(packageslibs, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    if(x == "devtools"){
      install.packages("devtools")
      devtools::install_github("rstudio/rmarkdown")
    }
    else{
      install.packages(x, dependencies = TRUE)
      suppressPackageStartupMessages(library(x, character.only = TRUE))
    }
  }
  else{
    suppressPackageStartupMessages(library(x, character.only = TRUE))
  }
})
## Verify they are loaded and list the loaded packages
## and libraries.
search()

###################################################
## Save R Session Info for Reference
###################################################
## write R session info to file for reference
writeLines(capture.output(session_info()), "Analysis/Data/sessionInfo.txt")

###################################################
## Download all csv files from URL sites below
## 1. GDPsite and save to GDP_Country.csv
## 2. FEDSTATSsite and save to FEDSTATS_Country.csv
## 3. Read csv file and Create data frame GDPraw
## 4. Read csv file and Create FEDSTATSraw
##
## Country GDP Data:  
##   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
##   - For more information on World Bank GDP by country see: 
##   http://data.worldbank.org/data-catalog/GDP-ranking-table  
##
## Country Federal Statistical Data:  
##   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
##   - For more information World Bank Federal 
##     Statistics by Country see: 
##     http://data.worldbank.org/data-catalog/ed-stats
## 
## Relevant Information on Organization for Economic Cooperation and Development (OECD):
##  - http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.html
###################################################
## URLs and files to download
GDPsite <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FEDSTATSsite <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download(GDPsite, destfile="Analysis/Data/GDP_Country.csv")
download(FEDSTATSsite, destfile="Analysis/Data/FEDSTATS_Country.csv")
## Set or reset data frames to empty dataframes
GDPraw <- data.frame()
FEDSTATSraw <- data.frame()
## Read in raw data files, GDP_Country.csv and headers after skipping first three lines
GDPraw <- read.csv("Analysis/Data/GDP_Country.csv", header=TRUE, skip=3, sep=",")
## Read in raw data file FEDSTATS_Country.csv and headers
FEDSTATSraw <- read.csv("Analysis/Data/FEDSTATS_Country.csv", header=TRUE, sep=",")
attach(GDPraw)
attach(FEDSTATSraw)
###################################################
## Clean Data and Merge
## 1. Remove NA columns and rows from GDPraw
## 2. GDP should have 190 rows
## 3. Name or rename columns of GDPrawdata
###################################################
## head(GDPraw)       ## investigate GDPraw data
## head(FEDSTATSraw)  ## investigate FEDSTATSrasw data

## reset GDPclean and FEDSTATSclean to empty data frames
GDPclean      <- data.frame()
FEDSTATSclean <- data.frame()

## GDPraw:  rename each column and keep only the columns with data
names(GDPraw) <- c("CountryCode", "GDPRank", "NA1", "Economy", "GDP_MillUSD", "NA2", "NA3", "NA4", "NA5", "NA6")
## GDPclean:  keep columns listed below for our GDP analysis in this study
## GDPclean:  remove all blank country codes from raw data and skip blank first row of
##            data frame. We take rows 2 to 191 for our 190 rows of data  
GDPkeepcol    <- c("CountryCode", "GDPRank", "Economy", "GDP_MillUSD")
GDPclean      <- GDPraw[2:191,GDPkeepcol]

## GDPclean:  make sure cleaned column represent by the correct type: char and numeric
## Here we also use the gsub command to filter out all spaces and 
## set to digit variables GDPrank and GDP_MillUSD
GDPclean$CountryCode <- as.character(GDPclean$CountryCode)
GDPclean$Economy     <- as.character(GDPclean$Economy)
GDPclean$GDPRank     <- as.numeric(gsub("[^[:digit:]]","", GDPclean$GDPRank))
GDPclean$GDP_MillUSD <- as.numeric(gsub("[^[:digit:]]","", GDPclean$GDP_MillUSD))

## FEDSTATSclean:  keep columns listed below for our FED Stats analysis in this study
FEDSTATkeepcol <- c("CountryCode", "Long.Name", "Income.Group", "Region")
FEDSTATSclean <- FEDSTATSraw[, FEDSTATkeepcol]

## FEDSTATSclean:  make sure cleaned column represent by the correct type: character
FEDSTATSclean$CountryCode  <- as.character(FEDSTATSclean$CountryCode)
FEDSTATSclean$Long.Name    <- as.character(FEDSTATSclean$Long.Name)
FEDSTATSclean$Income.Group <- as.character(FEDSTATSclean$Income.Group)
FEDSTATSclean$Region       <- as.character(FEDSTATSclean$Region)

## look at two clean data files before merging
## head(GDPclean)
## head(FEDSTATSclean)

## MERGE DATA FRAMES:  GDPclean and FEDSTATSclean  
## In looking at both datasets, in FEDSTATSraw there are several categories such as 
## the European Union and the Middle East that are aggregates of the GDPclean data
## by country.  In addition, there are several additional countries in the FEDSTATSraw 
## such as American Samoa and the North Korea (PRK) that are not part of the GDPclean
## dataset even though Western Samoa and South Korea are part of the GDPclean dataset.
## There are 45 country codes in the FEDSTATSraw dataset that are not in the GDPclean
## dataset.  After cleaning the data, we merge the two data frames
## below using the merge command by "CountryCode" for both data frames.
## FEDcc <- unique(FEDSTATSraw$CountryCode)
## GDPcc <- unique(GDPclean$CountryCode)
GDPFEDclean <- merge(GDPclean,FEDSTATSclean,by="CountryCode",all=TRUE)

## Write to csv file the cleaned dataset of 235 countries 
## with 190 matching the GDP sample set
write.csv(GDPFEDclean, file = "Analysis/Data/GDPFEDclean.csv",row.names=FALSE)

## look at two clean data files before merging
## head(GDPclean)
## head(FEDSTATSclean)

detach(GDPraw)
detach(FEDSTATSraw)

