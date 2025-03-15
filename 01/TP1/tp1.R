setwd("/Users/federicolopez/Library/CloudStorage/OneDrive-Personal/Documents/UDESA/MAESTRIA/ECONOMETRIA-AVANAZADA/TUTORIALES/01/TP1")
rm(list=ls())
library(readxl)
library(corrplot)
library(dplyr)
library(correlation)
library(ggcorrplot)
library(stargazer)
library(openxlsx)


################################################################################
# 1.1
################################################################################
nobs<-100
for(i in 1:50) {
  set.seed(i)
  
  # armo las variables
  x1 <- runif(nobs, min = 0, max = 200) # x uniforme
  x2 <- runif(nobs, min = 0, max = 200) # x uniforme
  x3 <- runif(nobs, min = 0, max = 200) # x uniforme
  u <- rnorm(nobs,mean=0,sd=1100)  # los errores
  y <- (100 + 3 * x1 + 2 * x2 - 1 * x3 + u)
  
  # lo pongo todo en un dataframe
  outdf <- data.frame(y,x1,x2,x3,u)
  assign(paste0("df_", i), outdf)
  
  # los mando a un csv
  write.csv(outdf, paste0("df_", i, ".csv"),row.names = FALSE)
  
}
################################################################################
# 1.2
################################################################################
uno <- read.csv("df_1.csv",header = TRUE)
M = cor(uno)
png("corrs.png",width = 2400, height = 1800, res = 300)
p <- ggcorrplot(M,
           type = "upper",
           lab = T,
           show.diag = F)

# https://github.com/kassambara/ggcorrplot/issues/9 
p + scale_fill_gradient2(limit = c(-0.2,1), low = "blue", high =  "red", mid = "white", midpoint = 0)
dev.off()

# trece <- read.csv("df_13.csv",header = TRUE)
# M = cor(trece)
# 
# p <- ggcorrplot(M,
#                 type = "upper",
#                 lab = T,
#                 show.diag = F)
# 
# p + scale_fill_gradient2(limit =c(-0.8,0.8), low = "blue", high =  "red", mid = "white", midpoint = 0)


################################################################################
# 1.3
################################################################################
fits <- data.frame(b0=double(),
                   b1=double(),
                   b2=double(),
                   b3=double())
for(i in 1:50) {
  current <- read.csv(paste0("df_", i, ".csv"),header = TRUE)
  lm.fit <- lm(y~x1+x2+x3, data = current)
  print(summary(lm.fit))
  curr_out <- data.frame(b0=lm.fit$coefficients[1],
             b1=lm.fit$coefficients[2],
             b2=lm.fit$coefficients[3],
             b3=lm.fit$coefficients[4])
  fits <- rbind(fits,curr_out)
}

write.xlsx(fits, "primera_estimacion.xlsx")
################################################################################
# 1.4
################################################################################
primera_estimacion <- read_excel("primera_estimacion.xlsx")

png("primera_estimacion.png", width = 2400, height = 1800, res = 300)
par(mfrow=c(1,2)) 
plot(primera_estimacion$b1, primera_estimacion$b2, xlab = "b1", ylab = "b2")
abline(v = mean(primera_estimacion$b1), col= "red")
abline(h = mean(primera_estimacion$b2), col= "blue")
plot(primera_estimacion$b1, primera_estimacion$b3, xlab = "b1", ylab = "b3")
abline(v = mean(primera_estimacion$b1), col= "red")
abline(h = mean(primera_estimacion$b3), col= "blue")
dev.off()

################################################################################
# 1.5
################################################################################

nobs<-100
for(i in 1:50) {
  set.seed(i)
  
  # armo las variables
  x1 <- runif(nobs, min = 0, max = 200) # x uniforme
  x2 <- runif(nobs, min = 0, max = 200) # x uniforme

  x2 <- scale (matrix (rnorm(100), ncol=1))
  xs <- cbind(scale (x1),x2)
  c1 <- var (xs)
  chol1 <- solve (chol (c1))
  newx <- xs
  newc <- matrix(c(1, 0.987, 0.987, 1), ncol=2)
  eigen(newc)
  chol2 <- chol (newc)
  xm2 <- newx%*% chol2 * sd(x1) + mean (x1)
  x2 <- xm2[, 2]
  

  x3 <- runif(nobs, min = 0, max = 200) # x uniforme
  u <- rnorm(nobs,mean=0,sd=1100)  # los errores
  y <- (100 + 3 * x1 + 2 * x2 - x3 + u)

  
  
  # lo pongo todo en un dataframe
  outdf <- data.frame(y,x1,x2,x3,u)
  assign(paste0("df_corr_", i), outdf)
  
  # los mando a un csv
  write.csv(outdf, paste0("df_corr_", i, ".csv"),row.names = FALSE)
  
}


################################################################################
# 1.6
################################################################################
fits <- data.frame(b0=double(),
                   b1=double(),
                   b2=double(),
                   b3=double())
for(i in 1:50) {
  current <- read.csv(paste0("df_corr_", i, ".csv"),header = TRUE)
  lm.fit <- lm(y~x1+x2+x3, data = current)
  print(summary(lm.fit))
  curr_out <- data.frame(b0=lm.fit$coefficients[1],
                         b1=lm.fit$coefficients[2],
                         b2=lm.fit$coefficients[3],
                         b3=lm.fit$coefficients[4])
  fits <- rbind(fits,curr_out)
}

write.xlsx(fits, "segunda_estimacion.xlsx")

################################################################################
# 1.7
################################################################################
segunda_estimacion <- read_excel("segunda_estimacion.xlsx")

png("segunda_estimacion.png", width = 2400, height = 1800, res = 300)
par(mfrow=c(1,2)) 
plot(segunda_estimacion$b1, segunda_estimacion$b2, xlab = "b1", ylab = "b2")
abline(v = mean(segunda_estimacion$b1), col= "red")
abline(h = mean(segunda_estimacion$b2), col= "blue")
plot(segunda_estimacion$b1, segunda_estimacion$b3, xlab = "b1", ylab = "b3")
abline(v = mean(segunda_estimacion$b1), col= "red")
abline(h = mean(segunda_estimacion$b3), col= "blue")
dev.off()


################################################################################
# 2.1
################################################################################
fits <- data.frame(b0=double(),
                   b1=double(),
                   b2=double(),
                   b3=double())
for(i in 1:50) {
  current <- read.csv(paste0("df_", i, ".csv"),header = TRUE)
  lm.fit <- lm(y~x1+x3, data = current)
  print(summary(lm.fit))
  curr_out <- data.frame(b0=lm.fit$coefficients[1],
                         b1=lm.fit$coefficients[2],
                         b2=NA,
                         b3=lm.fit$coefficients[3])
  fits <- rbind(fits,curr_out)
}

write.xlsx(fits, "tercera_estimacion.xlsx")

tercera_estimacion <- read_excel("tercera_estimacion.xlsx")

png("tercera_estimacion.png", width = 2400, height = 1800, res = 300)
par(mfrow=c(1,1))
plot(tercera_estimacion$b1, tercera_estimacion$b3, xlab = "b1", ylab = "b3")
abline(v = mean(tercera_estimacion$b1), col= "red")
abline(h = mean(tercera_estimacion$b3), col= "blue")
dev.off()

################################################################################
# 2.2
################################################################################
fits <- data.frame(b0=double(),
                   b1=double(),
                   b2=double(),
                   b3=double())
for(i in 1:50) {
  current <- read.csv(paste0("df_corr_", i, ".csv"),header = TRUE)
  lm.fit <- lm(y~x1+x3, data = current)
  print(summary(lm.fit))
  curr_out <- data.frame(b0=lm.fit$coefficients[1],
                         b1=lm.fit$coefficients[2],
                         b2=NA,
                         b3=lm.fit$coefficients[3])
  fits <- rbind(fits,curr_out)
}

write.xlsx(fits, "cuarta_estimacion.xlsx")

cuarta_estimacion <- read_excel("cuarta_estimacion.xlsx")

png("cuarta_estimacion.png",width = 2400, height = 1800, res = 300)
par(mfrow=c(1,1))
plot(cuarta_estimacion$b1, cuarta_estimacion$b3, xlab = "b1", ylab = "b3")
abline(v = mean(cuarta_estimacion$b1), col= "red")
abline(h = mean(cuarta_estimacion$b3), col= "blue")
dev.off()