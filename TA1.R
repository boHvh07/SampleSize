library(sample4confidence)
library(compute.es)

#Input1
n1 <- 29
r1 <- 0.469

#Input2
n2 <- 98
r2 <- 0.212

#Input3
n3 <- 248
r3 <- 0.219

#Input 4
m4.1 <- 2.635
sd4.1 <- 0.792
n4.1 <- 64
m4.2 <- 1.956
sd4.2 <- 1.158
n4.2 <- 64

r4 <- convert.means2r(m1=m4.1, sd1=sd4.1, n1=n4.1, m2=m4.2, sd2=sd4.2, n2=n4.2)


#Input 5
chi2r5 <- 2.165
n5 <- 131

r5 <-convert.chi2r(chi2=chi2r5, n=n5)


### Estimate Sample size
sample4confidence(r1 = c(r1, r2, r3, r4$r, r5$r), 
                      n1 = c(n1, n2, n3, r4$n, r5$n),
                      weight1 = c(20, 10, 15, 10, 10))

sample4confidence(r1 = c(0.469, 0.212, 0.219, 0.324, 0.129), 
                  n1 = c(n1, n2, n3, r4$n, r5$n),
                  weight1 = c(100, 50, 75, 50, 50))

