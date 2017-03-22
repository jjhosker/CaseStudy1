#############################################################
## Country Analysis by GDP and Income Group for 2012
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Date Created: 17-Mar-2017
## Last Update:  17-Mar-2017
## Description:  This R file is provides two functions that
##               ggplots Figure 1 and Figure 2 in our
##               RMakefile_CaseStudy1.R and CaseStudy1PDF.Rmd
##
##############################################################

###################################################
## Function PlotFig1
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Date Created: 17-Mar-2017
## Last Update:  17-Mar-2017
## Description:  This functions ggplots Figure 1 
##               for RMakefile_CaseStudy1.R and 
##               CaseStudy1PDF.Rmd
###################################################
PlotFig1 <- function(){
  ggplot(GDPFEDavg2,  aes(x=GDPFEDavg2$CntryNum, y=GDPFEDavg2$GDP_MillUSD, 
                          group = GDPFEDavg2$Income.Group))+ 
    geom_point(aes(shape=GDPFEDavg2$Income.Group, color=GDPFEDavg2$Income.Group)) + 
    geom_text(aes(label=ifelse(GDPFEDavg2$CntryNum == 150 | GDPFEDavg2$CntryNum == 100 | 
                                 GDPFEDavg2$CntryNum == 50, as.character(GDPFEDavg2$Economy),'')),
              hjust=0,vjust=-1) +
    geom_text(aes(label=ifelse(GDPFEDavg2$CntryNum == 186 | GDPFEDavg2$CntryNum == 187 | 
                                 GDPFEDavg2$CntryNum == 188,
                               as.character(GDPFEDavg2$Economy),'')),
              hjust=1,vjust=-1) +
    geom_text(aes(label=ifelse(GDPFEDavg2$CntryNum == 189,
                               as.character(GDPFEDavg2$Economy),'')),
              hjust=1,vjust=1) +
    geom_text(aes(label=ifelse(GDPFEDavg2$CntryNum == 1,
                               as.character(GDPFEDavg2$Economy),'')),
              hjust=0,vjust=-1) +
    ggtitle("Fig.1: GDPs for All Countries (Low to High) Showing Income Group") + 
    labs(x="Countries by GDP Rank", y="GDP in USD Millions", shape="Income Group", 
         color="Income Group") 
}

###################################################
## Function PlotFig1
## Create by:    James Hosker
## SMU Course:   MSDS6306-402
## Date Created: 17-Mar-2017
## Last Update:  17-Mar-2017
## Description:  This functions ggplots Figure 2 
##               for RMakefile_CaseStudy1.R and 
##               CaseStudy1PDF.Rmd
###################################################
PlotFig2 <- function(){
  ggplot(subset(GDPFEDinc, Income.Group %in% c("Low income","Lower middle income",
                                               "Upper middle income", "High income: nonOECD", 
                                               "High income: OECD")),
         aes(x=GDPFEDinc$CntryNum, y=GDPFEDinc$GDP_MillUSD, color=Income.Group))+ 
    geom_point(aes(shape=GDPFEDinc$Income.Group, color=GDPFEDinc$Income.Group)) + 
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 53 |
                                 GDPFEDinc$CntryNum == 144 |
                                 GDPFEDinc$CntryNum == 189,
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=1.3,vjust=1) +
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 1, 
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=0.5,vjust=-1) +  
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 23,
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=1,vjust=-1) +
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 24, 
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=0,vjust=1) +  
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 90,
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=1,vjust=-2) +
    geom_text(aes(label=ifelse(GDPFEDinc$CntryNum == 54 | 
                                 GDPFEDinc$CntryNum == 91 | 
                                 GDPFEDinc$CntryNum == 145,
                               as.character(GDPFEDinc$CountryCode),'')),
              hjust=0,vjust=-1) +  
    ggtitle("Fig.2: GDP by Income Group (All GDP Data Points)") + 
    labs(x="GDP within Each Income Group (Low to High)", y="GDP in USD Millions", 
         shape="Income Group", color="Income Group")  
}
