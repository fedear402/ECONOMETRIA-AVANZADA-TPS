library(readxl)


nobs<-100
for(i in 1:50) {
  set.seed(i)
  x1 <- runif(nobs, min = 0, max = 200) # uniforme
  x2 <- runif(nobs, min = 0, max = 200) # uniforme
  x3 <- runif(nobs, min = 0, max = 200) # uniforme
  u <- rnorm(nobs,mean=0,sd=1100) # normal indicando media y varianza
  outdf <- data.frame(x1,x2,x3,u)
  assign(paste0("df_", i), outdf)
  write.csv(outdf, paste0("df_", i, ".csv"))
  
}