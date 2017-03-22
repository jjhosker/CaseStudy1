# Client Project:  Country Analysis by GDP and Income Group for 2012
# Introduction
### This repository creates a report that examines data from the World Bank in 2012 by country on Gross Domestic Product (GDP) combined with country specific Federal Statistics.   

# Running R Code
### 1. To run this R-code, download and clone this GitHub directory:  [\textcolor{blue}{https://github.com/jjhosker/CaseStudy1}](https://github.com/jjhosker/CaseStudy1).  Check to insure the following files are downloaded and located in the directories indicated.  
####     - RMakefile_CaseStudy1.R found in the Analysis sub-directory.
####     - Makefile_GatherData.R found in the Analysis/Data sub-directory.
####     - PlotFunctions_CaseStudy1.R found in the Analysis sub-directory.
####     - CaseStudy1PDF.Rmd found in the main GitHub repository.

### 2. The output files are also included in the repository can be downloaded and are provide as reference for the client.
####     - Raw:      FEDSTATS_Country.csv found in the Analysis/Data sub-directory.
####     - Raw:      GDP_Country.csv found in the Analysis/Data sub-directory.
####     - Cleaned:  GDPFEDclean.csv found in the Analysis/Data sub-directory.
####     - PDF Report:  CaseStudy1PDF.pfd found in the main GitHub repository.
####     - R version:  SessionInfo.txt (for reference of libraries and R-version).  Found in the Analysis/Data sub-directory.

### 3.  Execute RMakefile_CaseStudy1.R in R studio to run all the R code. RMakefile_CaseStudy1.R loads all the libraries, read the raw data, create the cleaned data and perform the analysis for this client study.  The csv files will be created in the same directory as the project that you created on your computer.  In addition, we save the R session information that provided the version of R and all the library and packages being utilized.  
####     - The RMakefile_CaseStudy.R executes the makefile GatherData_CaseStudy1.R, which installs the packages and load the libraries.  A message indicating that the libraries loaded may appear after executing the R code.  If a failure occurs, please check both the function "packagelibrary.check" in the makefile GatherData_CaseStudy1.R and SessionInfo.txt file in the GitHub directory referenced above.

### 4.  Execute CaseStudy1PDF.Rmd to generate the PDF file in this repository (installation of MikTex is required as detailed in point 6 in the Repository Description below).

# Repository Description
### Below is a listing of all the files in this repository: [\textcolor{blue}{https://github.com/jjhosker/CaseStudy1}](https://github.com/jjhosker/CaseStudy1).  It contains the following important files:

###   1.  README:  This file provides information in detail of each of the files in the GitHub repository and instructions on how to run the R code for this analysis. 
  
###   2.  RMakefile_CaseStudy1.R:  This file can be found in the Analysis sub-directory under this GitHub repository.   It is the main R makefile that takes the cleaned data and performs all the analysis required for this project and in this report. In cleaning the data, we read in the csv files and in some cases re-name variables and reset data types.  In addition, we remove NAs and blanks in the data.  Finally, we merge the data by the unique country code in both datasets and create and output one cleaned and merged dataset (GDPFEDclean).
  
###   3. Makefile_GatherData.R:  This file can be found in the Analysis/Data sub-directory under this GitHub repository and yhis R makefile is called by RMakefile_CaseStudy1.R above.  This R makefile installs all required R-libraries and then loads the R-libraries.  Second, this R makefile downloads in the csv data files from the World Bank websites using URLs, reads the downloaded csv files, creates the raw data, and creates the cleaned datasets.   This R makefile merges the GDP with the Federal Statistical dataset and creates one a clean data set.  Finally, this makefile saves the sessionInfo for the R version, libraries and packages used to a file called SessionInfo.txt.   This makefile then saves all these dataset to the Analysis/Data sub-directory.

###   4. PlotFunctions_CaseStudy1.R:  In the Anlaysis subdirectory of this GitHub repository, this R Makefile loads plot functions to plot Figures 1 and 2 used in RMakefile_CaseStudy1.R and CaseStudy1PDF.Rmd.

###   5. There are three data files created below:  two raw datsets downloaded from the World Bank URLs and one cleaned dataset.   In addition, we provide a text file (SessionsInfo.txt) containing all the R session information including the current R version and all the libraries and packages being utilized.  All of the files below can be found in the Analysis/Data sub-directory under this GitHub repository. 
####     - Raw:  FEDSTATS_Country.csv
####     - Raw:  GDP_Country.csv
####     - Cleaned:  GDPFEDclean.csv
####     - R version:  SessionInfo.txt

###   6. Finally the CaseStudy1PDF.Rmd file runs the main RMakefile_CaseStudy1.R and extracts code to generates this "CaseStudy1PDF.pdf"" report. This report uses code that that is extracted from the main RMakefile_CaseStudy1.R and then run.
####      - To use this Rmd file to create a PDF, the user has to install MikTex (the non-basic version).  The URL with instructions to install MikTex is [\textcolor{blue}{MikText Install website}](https://miktex.org/howto/install-miktex).
