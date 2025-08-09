# ---
# `Case Studies on Event Study Analysis (ESA)`
# ---

###################################################
# Installing and Loading required Libraries
###################################################

install.packages(c("quantmod", "PerformanceAnalytics", "tidyverse", "tseries"))
library(quantmod)
library(PerformanceAnalytics)
library(tidyverse)
library(tseries)

##################################################################
# Defining the Event and estimation window and collecting required data
##################################################################

covid_event_date <- as.Date("2020-03-24")  # Merger announcemnet by Reliance Industry

# Eastimation and event windows
estimation_start <- covid_event_date - 60
estimation_end <- covid_event_date - 1

event_start <- covid_event_date - 10
event_end <- covid_event_date + 10

# Fetch NIFTY 50 ane IT Index data
getSymbols(c("^NSEI", "^CNXIT"), src = "yahoo", from = "2019-01-01", to = "2020-12-31")

##################################################################
# Data transformation
##################################################################

# Adjusted prices 
nifty_prices <- Ad(NSEI)
it_prices <- Ad(CNXIT)
chart_Series(nifty_prices)
# in march 2020 it seen drastic change due to lockdown
chart_Series(it_prices)

# Compute daily returns 
nifty_returns <- dailyReturn(nifty_prices)
it_returns <- dailyReturn(it_prices)

plot(nifty_returns)
plot(it_returns)

chart_Series(nifty_returns)
chart_Series(it_returns)

##################################################################
# Calculating Normal and Abnormal returns
##################################################################

# Subset returns
estimation_it <- it_returns[index(it_returns) >= estimation_start & index(it_returns) <= estimation_end]
event_it <- it_returns[index(it_returns) >= event_start & index(it_returns) <= event_end]

# Market returns
estimation_nifty <- nifty_returns[index(nifty_returns) >= estimation_start & index(nifty_returns) <= estimation_end]
event_nifty <- nifty_returns[index(nifty_returns) >= event_start & index(nifty_returns) <= event_end]

# Fit data for estimation period
market_model <- lm(estimation_it ~ estimation_nifty)

# Get alpha and beta from the model 
alpha <- coef(market_model)[1]
beta <- coef(market_model)[2]

# Calculating ARs and CARs
expected_returns <- alpha + beta * event_nifty
abnormal_returns <- event_it - expected_returns

##################################################################
# Calculating cumulative Abnormal returns
##################################################################

# Calculate cumulative abnormal returns (CAR)
cumulative_abnormal_returns <- cumsum(abnormal_returns)


##################################################################
# Visualizing Abnormal and Cumulative Abnormal returns
##################################################################

# plot ARs and CARs
plot(index(abnormal_returns), abnormal_returns, type = "h", col = "blue",
     main = "Abnormal Returns for IT Index (COVID-19)",
     xlab = "Date", ylab = "Abnormal Returns")
abline(h = 0, col = "red", lty = 2)

plot(index(cumulative_abnormal_returns), cumulative_abnormal_returns, type = "l", col = "green",
     main = "Cumulative Abnormal Returns (CAR)",
     xlab = "Date", ylab = "Cumulative Abnormal Returns")
abline(h = 0, col = "red", lty = 2)


##################################################################
# Significance testing / Null Hypothesis testing for abnormal returns
##################################################################

# now we test whether these returns are sig or not

# Mean and sd of abnormal returns
mean_ar <- mean(abnormal_returns, na.rm = TRUE)
sd_ar <- sd(abnormal_returns, na.rm = TRUE)
n_ar <- length(abnormal_returns)

# T-Statistic calculation
t_stat <- mean_ar / (sd_ar / sqrt(n_ar))

# Perform one sample test
t_test_result <- t.test(abnormal_returns, mu = 0)

# Print results
cat("Mean of ARs:", mean_ar, "\n")
cat("Standard Deviation of ARs:", sd_ar, "\n")
cat("T-Statistic:", t_stat, "\n")
cat("P-value:", t_test_result$p.value, "\n")

# Check the significance
# H0: AR=0
if (t_test_result$p.value < 0.05) {
  cat("Reject the nul hypothesis: AR are significantly different from zero.\n")
} else {
  cat("Fail to reject the null hypothesis: AR are significantly different from zero.\n")
} 

# ---- Interpretation ----
# if we are relying on the abnormal return it shows no sig impact

##################################################################
# Significance testing / Null Hypothesis testing for  cumulative abnormal returns
##################################################################

# Mean and sd of abnormal returns
mean_car <- mean(cumulative_abnormal_returns, na.rm = TRUE)
sd_car <- sd(cumulative_abnormal_returns, na.rm = TRUE)
n_car <- length(cumulative_abnormal_returns)

# T-Statistic calculation
t_stat_car <- mean_car / (sd_car / sqrt(n_car))

# Performance one-sample t-test
t_test_result_car <- t.test(cumulative_abnormal_returns, mu = 0)

# Print results
cat("Mean of CARs:", mean_car, "\n")
cat("Standard Deviation of CARs:", sd_car, "\n")
cat("T-statistic (CAR):", t_stat_car, "\n")
cat("P-value (CAR):", t_test_result_car$p.value, "\n")

# Check significance
if (t_test_result_car$p.value < 0.05) {
  cat("Reject the nul hypothesis: CAR are significantly different from zero.\n")
} else {
  cat("Fail to reject the null hypothesis: CAR are significantly different from zero.\n")
}
# ----- Interpretation -----
# - since the p-val < 0.05, CAR are significantly different from zero
# - conclude that event has significant effect on cumulative abnormal returns
# - positive effct (mean of CARs =0.04174716)
# - When there was a Announcement of lockdown has positive impact on the stock returns of IT industry
# - it's prices has jump