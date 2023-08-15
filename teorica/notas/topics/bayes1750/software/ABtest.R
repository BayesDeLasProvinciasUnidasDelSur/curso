library(bayesAB)

Tot.base<-1444 # number of base cases
Conv.base<-208 # number of base conversions
Tot.desc<-347 # number of discount cases
Conv.desc<-69 # number of conversions with discount

Vec.base <- c(rep(1,Conv.base),rep(0,Tot.base-Conv.base))
Vec.desc <- c(rep(1,Conv.desc),rep(0,Tot.desc-Conv.desc))

# Conversion Rate No Discount
Conv.base/Tot.base # NO Discount
# Conversion Rate with Discount
Conv.desc/Tot.desc # WITH Discount

AB1 <- bayesTest (Vec.desc, Vec.base,
                  priors = c ('alpha' = 1, 'beta' = 1),
                  distribution = 'bernoulli')

p <- plot(AB1)
p$posterior

# Tarea
# Hacer la integral para P(p1 < p2)

summary(AB1)
