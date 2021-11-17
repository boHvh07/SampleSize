
#-------------------------------------------------------------------------------
# EFFECT SIZE AND SAMPLE SIZE ESTIMATION
#
# This code contains examples of using R-package sample4confidence.
#-------------------------------------------------------------------------------

# Part 1: Some examples
# Part 2: Convert various effect sizes and statistics into Cohen d and Pearson correlation r
# Part 3: Use correlations from prior research (part 1) to estimate the required sample size for the next study 

#-------------------------------------------------------------------------------
# Prepare R
#-------------------------------------------------------------------------------

# Clear workspace
rm(list=ls(all=TRUE))

# (Install and) load library
library(sample4confidence)

# Set working directory to directory where R was started from
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#===============================================================================
# Part 1: Some examples
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Example 1

# 1. Pilot study: n = 20, r = .45
# 2. Published study: n = 200, chi2 = 3.84


# Convert Chi-squared into Pearson r
convert.chi2r(chi2 = 3.84, n = 200)

# Result: Correlation is .139, p = .0504

# Combine the two correlations
 
# Result: Average sample-size weighted correlation is .166, p = .0138

# Example 1 - More Efficiently

# Convert Chi-squared into Pearson r and place results in r-object chi2r
chi2r <- convert.chi2r(chi2 = 3.84, n = 200)

# Combine the two correlations
sample4confidence(r1 = c(.45, chi2r$r), n1 = c(20, chi2r$n))

# Essentially same results, but the latter is more accurate (no rounding)

#-------------------------------------------------------------------------------
# Example 2

# Sample size of input information influences uncertainty of estimation

sample4confidence(r1=-.19, n1=1000)
sample4confidence(r1=-.19, n1=100000)

#===============================================================================
# Part 2: sample4confidence: Effect size conversion
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Chi-squared into Pearson r (= r)
convert.chi2r(chi2 = 3.84, n = 100)

# Place results in object with name 'chi2r' for later use. Do not show in console (F)
convert.chi2r(6.1, 76, F)

#-------------------------------------------------------------------------------
# Confidence Interval

# A 95% Confidence Interval very close to or overlapping zero (0) is just 
# significant at p < .05, as expected.
convert.ci2r(lcl = .0001, ucl = .50, df = 100)

# Guess what happens if the 95% CI  'just' overlaps zero?
convert.ci2r(lcl = -.001, ucl = .50, df = 100) # df = sample size minus (2 or 3)

# p > .05, as expected

#-------------------------------------------------------------------------------
# Cohen d

# Convert one Cohen d for two sample sizes, to examine the effect of sample size
convert.d2r(d = 0.2, n = c(50, 100))
# Correlation is the same for each sample size, but p-value changes, as expected.

# Convert two Cohen d for one sample size
convert.d2r(d = c(0.2, 0.5), n = 100)

#-------------------------------------------------------------------------------
# Convert F-value (df1, df2)
convert.f2r(3.83, 2, 100)

#-------------------------------------------------------------------------------
# Convert lor to r: overall n
convert.lor2r.1(lor = .50, n = 500)

convert.lor2r.2(lor = .50, n1 = 250, n2 = 250)

# lor2r.1 and lor2r.2 give the same results if n1 = n2, as they should.
# In cases, n1 and n2 differ much, estimates from lor2r.1 and lor2r.2 differ much,
# as expected.

# Same total n, but different n1 and n2
convert.lor2r.2(lor = .50, n1 = 5, n2 = 495)

#-------------------------------------------------------------------------------
# Convert means to r
convert.means2r(m1 = 0.8, sd1 = 1.5, n1 = 50, m2 = 0, sd2 = 1.5, n2 = 50)

#-------------------------------------------------------------------------------
# Convert p to r
# Single p-value, with larger n, correlation is lower, as expected (think why?)
convert.p2r(.0499, df=c(50, 100))

#-------------------------------------------------------------------------------
# Convert three correlations into their partial corr's and Cohen d
r2partial <- convert.r2partial(r_ab = .4, r_ac = .3, r_bc = .2, n = 200)

#-------------------------------------------------------------------------------
# Convert partial to r
convert.partial2r(r_ab.c = .20, r_ac = .40, r_bc = .40, n = 50)

#-------------------------------------------------------------------------------
# Convert proportions in two groups to r
convert.prop2r(p1 = .60, p2 = .40, n1 = 100, n2 = 100)

#-------------------------------------------------------------------------------
# Convert t-value (df)
convert.t2r(sqrt(3.52), 298)

#-------------------------------------------------------------------------------
# Convert 2 x 2 cross-tabulation to r, d
convert.table2r(cells = c(60, 40, 40, 60), nrow = 2, ncol = 2)

# convert one-sample observed frequencies to r, d
# Test is whether a 5% deviation from randomness (550/1000 vs 500/1000)
# is significant at this same size. 

convert.table2r(cells = c(5500, 4500), nrow = 2, ncol = 1, probs = c(.50,.50))

#===============================================================================
# Part 3: sample4confidence: Sample size estimation from multiple inputs
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Scenario 1: All correlation inputs
#-------------------------------------------------------------------------------

# Scenario 1a: 
# Same user-set weights and testing against zero

# Three correlations as input, with different sample sizes
# Last correlation is highest (r = .35) and from a small pilot study (n = 20)
sample4confidence(r1 = c(.15,.20,.35), 
                  n1 = c(100, 200, 20))

# Conclusion: 
# 1. Average weighted correlation is .193, with 95% CI [0.086; 0.301]
# 2. Average required sample size is 209 with 95% CI [1070; 85]
#    The 95% CI is very large due to the small sample sizes on input correlations
#    If planned survey is important, and no other information available consider 
#    a sample size considerably larger than average, potentially n = 1070 ...

# Scenario 1b: 
# Different user-set weights and testing against zero

# The pilot study is more relevant than the other two inputs that are from 
# different samples and measures
# Sensitivity analysis: What-if the pilot study receives a higher weight?

# Note: weights are between 0 (no contribution) and 100 (maximum contribution)
sample4confidence(r1 = c(.15,.20,.35), 
                  n1 = c(100, 200, 20),
                  weight1 = c(50, 50, 100))

# Conclusion:
# 1. Average required sample size is a bit lower (good news). This is obvious 
#    because the large pilot study correlation receives more weight.
# 2. The 95% Confidence of the required sample size also goes up (bad news).
#    This also obvious, because the samll sample size of the pilot study receives 
#    more weight.

# Scenario 1c: 
# Same user-set weights and testing against zero; what-if the sample of the 
# pilot-study would have been larger. For instance, n = 60

# Three correlations as input, with different sample sizes
# Last correlation is highest (r = .35) and from a small pilot study (n = 20)
sample4confidence(r1 = c(.15,.20,.35), 
                  n1 = c(100, 200, 60))

# Conclusion:
# 1. wow-wow. Required sample size is lower, and confidence interval smaller.
# 2. Perhaps, to reduce uncertainty and increase confidence, re-do the pilot study.


# Scenario 1d: 
# Same user-set weights and testing against zero: what-if we test against r2 = .05
# as a minimum benchmark
# r1 = inputs; r2 = benhhmark

sample4confidence(r1 = c(.15,.20,.35), 
                  n1 = c(100, 200, 20),
                  r2 = .05)

# Conclusion:
# 1. That hurts. We first tested against a silly r2 = 0 (how low can you go) 
# 2. If testing against a still small r2 = .05, the required sample size
#    increases from 209 to 374, and the 95% confidence interval of sample sizes
#    is from a huge 6036 to a low 121 (would we go for the 121?)


#-------------------------------------------------------------------------------
# Scenario 2: Mixed inputs with converted r's entered directly 
#-------------------------------------------------------------------------------

# Three inputs for sample size estimation.
# Step 1: convert
# Step 2: combine and estimate sample size

# Input 1: Cohen d from an experimental study
# Convert d to correlation and place output in object d2r
d2r <- convert.d2r(d = 0.3, n = 233)

# Input 2: Chi2 from an observational study
# Convert chi2 into correlation and place output in object chi2r
chi2r <- convert.chi2r(chi2 = 4.22, n = 50)

# Input 3: t-value from a two-group analysis 
# Convert t-value into correlation and place output into object t2r
t2r <- convert.t2r(t = 1.95, df = 30)

# Note: convert.t2r uses df (degrees-of-freedom), and df = n - 2 here.
# Convert df into n for t-value and add new variable n to t2r
t2r$n <- t2r$df + 2

sample4confidence(r1 = c(d2r$r, chi2r$r, t2r$r), 
                  n1 = c(d2r$n, chi2r$n, t2r$n))

# Conclusion:
# 1. Average required sample size is 218, with 95% CI [1207; 87] 
# 2. The large correlation but small sample size of the t-value, 
#    stretches the 95% CI of the sample size

# What if we ignore the t-value by assigning it weight of zero (0)?

sample4confidence(r1 = c(d2r$r, chi2r$r, t2r$r), 
                  n1 = c(d2r$n, chi2r$n, t2r$n),
                  weight1 = c(100,100,0))

# Conclusion:
# Does not help at all. Now less information, and the largest sample (input 1)
# also has the smallest converted-correlation
# We have to live with this, or search for more or better information

#-------------------------------------------------------------------------------
# Done !


