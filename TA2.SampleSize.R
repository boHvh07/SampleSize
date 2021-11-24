library(sample4confidence)
library(compute.es)

####    X TO Y      ####
#Input1
XYn1 <- 29
XYr1 <- 0.469

#Input2
XYn2 <- 98
XYr2 <- 0.212

sample4confidence(r1 = c(XYr1, XYr2), 
                  n1 = c(XYn1, XYn2),
                  weight1 = c(100, 100),
                  r2 = .1)

XY.final.r == 



####    X TO MED      ####
#Input1
XMn1 <- 29
XMr1 <- 0.469

#Input2
XMn2 <- 98
XMr2 <- 0.212

sample4confidence(r1 = c(XMr1, XMr2), 
                  n1 = c(XMn1, XMn2),
                  weight1 = c(100, 100),
                  r2 = .1)

XM.final.r ==


####    MED TO Y      ####
#Input1
MYn1 <- 29
MYr1 <- 0.469

#Input2
MYn2 <- 98
MYr2 <- 0.212

sample4confidence(r1 = c(MYr1, MYr2), 
                  n1 = c(MYn1, MYn2),
                  weight1 = c(100, 100),
                  r2 = .1)

MY.final.r






#===============================================================================
# R program to estimate the required sample size for common mediation models
#
# Authors: Alexander M. Schoemann (Contact), 
#          Aaron J. Boulton, & Stephen D. Short
#*******************************************************************************

# The program works with a convenient Graphical User Interface (gui)
# using a shiny.app. It very easy to use, and pretty advanced

# Step 1:  Install package "shiny"
# Already done here; if not then: delete leading-# in next line, and run
# install.packages("shiny") # be patient: takes a few seconds

# Step 2: Load shiny package
library("shiny")

# Step 3: Use runGitHub to run the code from the shiny package
runGitHub("mc_power_med", "schoam4")

# Step 4: Ensure that the shiny.app fills your whole computer screen, then
#         Enter data, then
#         Click on "Calculate Power", then
#         Inspect results. May take a while, because program uses simulations


# If using this package to estimate your sample size and/or power:
# Please cite it:
# Schoemann, A. M., Boulton, A. J., & Short, S. D. (2017). 
# Determining power and sample size for simple and complex mediation models. 
# Social Psychological and Personality Science, 8, 379-386.

# For more details check:
# http://marlab.org/power_mediation/

# That is it 




