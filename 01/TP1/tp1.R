setwd("/Users/federicolopez/Library/CloudStorage/OneDrive-Personal/Documents/UDESA/MAESTRIA/ECONOMETRIA-AVANAZADA/TUTORIALES/01/TP1")
rm(list=ls())
library(readxl)
library(corrplot)
library(dplyr)
library(correlation)
library(ggcorrplot)

nobs<-100
for(i in 1:50) {
  set.seed(i)
  
  # armo las variables
  x1 <- runif(nobs, min = 0, max = 200) # x uniforme
  x2 <- runif(nobs, min = 0, max = 200) # x uniforme
  x3 <- runif(nobs, min = 0, max = 200) # x uniforme
  u <- rnorm(nobs,mean=0,sd=1100)  # los errores
  
  # lo pongo todo en un dataframe
  outdf <- data.frame(x1,x2,x3,u)
  assign(paste0("df_", i), outdf)
  
  # los mando a un csv
  write.csv(outdf, paste0("df_", i, ".csv"),row.names = FALSE)
  
}
################################################################################
# 2.
################################################################################
uno <- read.csv("df_1.csv",header = TRUE)
M = cor(uno)

p <- ggcorrplot(M,
           type = "upper",
           lab = T,
           show.diag = F)

# https://github.com/kassambara/ggcorrplot/issues/9 
p + scale_fill_gradient2(limit = c(-0.2,0.2), low = "blue", high =  "red", mid = "white", midpoint = 0)


# trece <- read.csv("df_13.csv",header = TRUE)
# M = cor(trece)
# 
# p <- ggcorrplot(M,
#                 type = "upper",
#                 lab = T,
#                 show.diag = F)
# 
# p + scale_fill_gradient2(limit = c(-0.2,0.2), low = "blue", high =  "red", mid = "white", midpoint = 0)

################################################################################
# 3.
################################################################################