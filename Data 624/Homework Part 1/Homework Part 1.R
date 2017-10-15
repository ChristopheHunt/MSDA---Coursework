library(fma)
library(ggfortify)
library(tidyverse)
library(psych)
library(knitr)
library(mlbench)
library(Hmisc)
library(fpp)
library(psych)
library(missForest)
library(forecast)
library(caret)
library(reshape)
library(reshape)
library(caret)
library(forecast)
library(missForest)
library(fma)
library(ggfortify)
library(tidyverse)
library(psych)
library(knitr)
library(mlbench)
library(Hmisc)
library(fpp)
library(psych)
library(fma)
library(ggfortify)
data(dole)
autoplot(dole, xlab = "Year", 
               ylab = "# of Unemployed \n", 
               main = "Monthly total of people on unemployed benefits in Australia \n (January 1956-July 1992)")
autoplot(BoxCox(dole, BoxCox.lambda(dole)), 
               xlab = "Year", 
               ylab = paste0("# of Unemployed \n", "lambda = ", round(BoxCox.lambda(dole),2), " \n"),
               main = "BoxCox Transformation \nMonthly total of people on unemployed benefits in Australia \n(January 1956-July 1992)")
data(usdeaths)
autoplot(usdeaths,
         ylab="Total Deaths Per Month",
         xlab="Year",
         main="Monthly total of accidental deaths in the United States \n(January 1973-December 1978)")
monthdays <- rep(c(31,28,31,30,31,30,31,31,30,31,30,31),6)
monthdays[38] <- 29 #Leap year adjustment

autoplot(usdeaths/monthdays, ylab="Average Deaths Per Day",
         xlab="Year",
         main="Average accidental deaths per day by Month in the United States \n(January 1973-December 1978)")
data(bricksq)
autoplot(bricksq,
         xlab = "Year", 
               ylab = paste0("# of bricks (in millions of units)"),
               main = "Quarterly production of bricks (in millions of units) \nPortland, Australia (March 1956-September 1994)")
autoplot(BoxCox(bricksq, BoxCox.lambda(bricksq)), 
               xlab = "Year", 
               ylab = paste0("# of bricks (in millions of units) \n", "lambda = ", round(BoxCox.lambda(bricksq),2), " \n"),
               main = "BoxCox Transformation \nQuarterly production of bricks (in millions of units) \nPortland, Australia (March 1956-September 1994)")
library(psych)
library(knitr)
data(ibmclose)
summary(ibmclose)
autoplot(ibmclose, 
         xlab = "\nDay", 
         ylab = "Close\n",
         main = "Daily closing IBM stock prices")
lag.plot(ibmclose, lags= 10, do.lines=FALSE)
ibmclose_train <- window(ibmclose, start=1, end=300)
ibmclose_test <- window(ibmclose, start=301)
ibmclosefit1 <- meanf(ibmclose_train, h = 69)
ibmclosefit2 <- rwf(ibmclose_train, h = 69)
ibmclosefit3 <- snaive(ibmclose_train, h = 69)

plot(ibmclosefit1, col = 1, main="Forecasts for IBM Close")
lines(ibmclosefit2$mean, col=2)
lines(ibmclosefit3$mean, col=3)
lines(ibmclose)
legend("topright", 
       cex = .75,
       lty=1, 
       col=c(4,2,3), 
       legend=c("Mean method", 
                "Naive method", 
                "Seasonal naive method"))
kable(accuracy(ibmclosefit1, ibmclose_test))
kable(accuracy(ibmclosefit2, ibmclose_test))
kable(accuracy(ibmclosefit3, ibmclose_test))
library(fma)
plastics
library(ggfortify)
autoplot(plastics, xlab = "Year", ylab = "monthly sales (in thousands) \n")
fit <- decompose(plastics, type="multiplicative")
plot(fit)
fit <- stl(plastics, t.window = 7, s.window="periodic", robust=TRUE)
autoplot(seasadj(fit), xlab = "Year", ylab = "seasonally adjusted data monthly sales(in thousands) \n")
outlier_plastics <- plastics
outlier_plastics[34] <- outlier_plastics[30] + 600
fit <- stl(outlier_plastics, t.window = 7, s.window="periodic", robust=TRUE)
autoplot(seasadj(fit), xlab = "Year", ylab = "seasonally adjusted data monthly sales \n with outlier (in thousands)  \n")
outlier_plastics <- plastics
outlier_plastics[2] <- outlier_plastics[2] + 600
fit <- stl(outlier_plastics, t.window = 7, s.window="periodic", robust=TRUE)
autoplot(seasadj(fit), xlab = "Year", ylab = "seasonally adjusted data monthly sales \n with outlier (in thousands)  \n")
fc <- stlf(plastics, method="naive")
plot(fc)
fit <- stl(plastics, s.window="periodic", robust=TRUE)
fitadj <- seasadj(fit)
plot(naive(fitadj))
library(mlbench)
library(Hmisc)
data(Glass)
describe(Glass)
library(corrplot)
library(PerformanceAnalytics)
Glass %>% dplyr::select(-(Type)) %>% cor() %>% chart.Correlation(histogram=TRUE, pch=19)
library(ggplot2)
ggplot(stack(Glass), aes(x = ind, y = values)) +
      facet_wrap(~ind, scales = "free", nrow = 1) + 
      geom_boxplot()
library(ggplot2)
ggplot(stack(Glass), aes(values)) +
      facet_wrap(~ind, scales = "free") + 
      geom_histogram()
apply(Glass %>% dplyr::select(-(Type)), 2, BoxCoxTrans)
library(mlbench)
data(Soybean)
t <- melt(apply(Soybean %>% dplyr::select(-plant.stand, -precip, -temp), 2, FUN = table))  %>% 
     rename(c("Var.1" = "Value", "value" = "Count", "L1" = "Variable"))

ggplot(t %>% dplyr::filter(Variable == "Class"), aes(x = Value, y = Count, group = Variable)) +
      geom_col() +
      theme(axis.text.x = element_text(angle = 75, hjust = 1, vjust = 1))
ggplot(t %>% dplyr::filter(Variable != "Class"), aes(x = Value, y = Count, group = Variable)) +
      facet_wrap(~Variable, scales = "free") +
      geom_col()
Soybean %>%  
  summarise_each(funs(sum(is.na(.))/nrow(Soybean))) %>% 
  melt() %>% 
  ggplot(aes(x = variable, y = value)) +
              geom_col() +
             ggtitle("Missing Values") +
  theme(axis.text.x = element_text(angle = 75, hjust = 1, vjust = 1))
Soybean %>% 
  group_by(Class) %>% 
  summarise_all(funs(sum(is.na(.))/nrow(Soybean))) %>% 
  as.data.frame() %>%
  melt() %>%
  ggplot(aes(x = variable, y = value, fill = Class)) +
             geom_col() +
             #facet_grid(~variable, scales = "free") +
             ggtitle("Missing Values by Class") +
             theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .1))
library(missForest)
Soybean.imp <- missForest(Soybean)
t <- melt(apply(Soybean.imp$ximp %>% 
                  dplyr::select(-plant.stand, -precip, -temp), 2, FUN = table)) %>% 
     rename(c("Var.1" = "Value", "value" = "Count", "L1" = "Variable"))

ggplot(t %>% dplyr::filter(Variable != "Class"), aes(x = Value, y = Count, group = Variable)) +
      facet_wrap(~Variable, scales = "free") +
      geom_col()
library(fma)
library(tidyverse)
library(ggfortify)
books <- fma::books
plot(books)
autoplot(books)
paperback <- books[,1]

fit1 <- ses(paperback, alpha=0.4, initial="simple", h=3)
fit2 <- ses(paperback, alpha=0.6, initial="simple", h=3)
fit3 <- ses(paperback, alpha=0.8, h=3)

plot(fit1, ylab="Paperback Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit1), col="blue", type="o")
lines(fitted(fit2), col="red", type="o")
lines(fitted(fit3), col="green", type="o")
lines(fit1$mean, col="blue", type="o")
lines(fit2$mean, col="red", type="o")
lines(fit3$mean, col="green", type="o")
legend("topleft",lty=1, col=c(1,"blue","red","green"), 
  c("data", expression(alpha == 0.4), expression(alpha == 0.6),
  expression(alpha == 0.8)),pch=1)
fit_opt <- ses(paperback, initial="simple", h=4)
plot(fit_opt, ylab="Paperback Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit_opt), col="blue", type="o")
lines(fit_opt$mean, col="blue", type="o")
summary(fit_opt)
fit_opt <- ses(paperback, initial="optimal", h=4)
plot(fit_opt, ylab="Paperback Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit_opt), col="blue", type="o")
lines(fit_opt$mean, col="blue", type="o")
summary(fit_opt)
hardcover <- books[,2]

fit1 <- ses(hardcover, alpha=0.4, initial="simple", h=3)
fit2 <- ses(hardcover, alpha=0.6, initial="simple", h=3)
fit3 <- ses(hardcover, alpha=0.8, h=3)

plot(fit1, ylab="Hardcover Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit1), col="blue", type="o")
lines(fitted(fit2), col="red", type="o")
lines(fitted(fit3), col="green", type="o")
lines(fit1$mean, col="blue", type="o")
lines(fit2$mean, col="red", type="o")
lines(fit3$mean, col="green", type="o")
legend("topleft",lty=1, col=c(1,"blue","red","green"), 
  c("data", expression(alpha == 0.4), expression(alpha == 0.6),
  expression(alpha == 0.8)),pch=1)
fit_opt <- ses(hardcover, initial="simple", h=4)
plot(fit_opt, ylab="Hardcover Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit_opt), col="blue", type="o")
lines(fit_opt$mean, col="blue", type="o")
summary(fit_opt)
fit_opt <- ses(hardcover, initial="optimal", h=4)
plot(fit_opt, ylab="Paperback Books Sold",
  xlab="Time Series", main="", fcol="white", type="o")
lines(fitted(fit_opt), col="blue", type="o")
lines(fit_opt$mean, col="blue", type="o")
summary(fit_opt)
library(expsmooth)
ukcars <- expsmooth::ukcars
autoplot(ukcars)
fit_stl <- stl(ukcars, s.window = "periodic")
plot(fit_stl)
sadj <- seasadj(fit_stl)
sfactors <- fit_stl$time.series[2:11, "seasonal"] 
fit_dpd_sadj <- holt(sadj, damped = TRUE)
paste0("Additive damped RMSE : ",round(accuracy(fit_dpd_sadj)[2], 3))
rsfit_dpd_sadj <- fit_dpd_sadj$mean + sfactors 
rsfit_dpd_sadj
plot(ukcars, 
     type = "o",
     xlab = "Years", 
     ylab = "UK Cars", 
     xlim = c(1997, 2008))

lines(rsfit_dpd_sadj, type = "o", col = "blue")
fit_hl <- holt(sadj)
paste0("Holt Linear Method with seasonal adjustment RMSE: ",round(accuracy(fit_hl)[2],3))
autoplot(fit_hl, xlab = "Years", ylab = "UK Car Production")
accuracy(fit_hl)
rs_l <- fit_hl$mean + sfactors
plot(ukcars, ylab = "UK Care Production")
lines(rs_l, type = "o", col = "red")
fit_ets <- ets(ukcars, model = "ANN")
summary(fit_ets)
autoplot(forecast(fit_ets), xlab = "Years", ylab = "UK Car Production")
paste0("RMSE from Simple Exp Smoothing Method: ",round(accuracy(fit_ets)[2], 3))
paste0("Additive Damped - RMSE : ",round(accuracy(fit_dpd_sadj)[2], 3))
paste0("Holt -  RMSE: ",round(accuracy(fit_hl)[2],3))
paste0("RMSE from Simple Exp Smoothing Method: ",round(accuracy(fit_ets)[2], 3))
autoplot(forecast(fit_dpd_sadj))
autoplot(forecast(fit_hl))
autoplot(forecast(fit_ets))
library(fma)
data(ibmclose)
par(mfrow=c(1, 2))
plot(ibmclose)
plot(diff(ibmclose,1))
par(mfrow=c(1, 3))
acf(ibmclose)
acf(diff(ibmclose,1))
par(mfrow=c(1, 2))
pacf(ibmclose)
pacf(diff(ibmclose,1))
data(wmurders)
plot(wmurders)
plot(diff(wmurders, differences = 2))
par(mfrow=c(1, 2))
acf(diff(wmurders, differences = 2))
pacf(diff(wmurders, differences = 2))
arima(wmurders, order = c(1,2,0))
arima_1_2 <- arima(wmurders, order = c(1,2,0))
tsdiag(arima_1_2)
forecast(arima_1_2, h = 3)
tail(wmurders)
plot(forecast(arima_1_2, h = 3))
auto.arima(wmurders)
data(usmelec)
usmelec <- window(usmelec, start = 1985, end = 1996)
plot(usmelec)
plot(ma(usmelec, order=12))
library(forecast)
BoxCox.lambda(usmelec)
kpss.test(usmelec)
paste(nsdiffs(usmelec), "order of seasonal differences")
paste(ndiffs(nsdiffs(usmelec)), "order of differences")
par(mfrow=c(1, 2))
acf(diff(usmelec,  lag = 12, differences = 1))
pacf(diff(usmelec, lag = 12, differences = 1))
arima(usmelec, order = c(1,0,2), seasonal = c(1,1,1))
arima(usmelec, order = c(1,0,2), seasonal = c(1,1,0))
arima(usmelec, order = c(1,0,2), seasonal = c(0,1,1))
fit <- arima(usmelec, order = c(1,0,2), seasonal = c(0,1,1))
summary(fit)
tsdisplay(fit$residuals)
plot(forecast(fit, h = (15*12)))
## NA
