# 📊 Event Study: COVID-19 Pandemic Lockdown Impact on Nifty 50 & IT Sector (India)

## 📝 Short Description

Event study analysis of the COVID-19 lockdown (March 2020) on India’s Nifty 50 index and IT sector using a market model. Abnormal returns for IT stocks are not statistically significant during the event window, but cumulative abnormal returns show a significant *positive* impact—implying the market anticipated benefits for the IT sector amid the pandemic.

---

## 📚 Topics Covered

- Global event study methodology
- Data retrieval: Nifty 50 & CNX IT Index (2019–2020)
- Estimation and event window setup for pandemic shock
- Market model regression for abnormal return analysis
- AR/CAR (Abnormal/Cumulative Abnormal Returns) computation
- Hypothesis testing for statistical significance
- Sectoral (IT) interpretation and visualization
- Analysis summary and practical insights

---

## 🧭 Case Study Summary

This analysis investigates the stock market’s response to India’s March 2020 COVID-19 lockdown. Using ±10 trading days around the March 24, 2020 lockdown announcement, we compute abnormal returns for the Nifty IT sector index based on a standard market model estimated from the Nifty 50 benchmark.

**Key findings:**
- **Abnormal returns (AR):** No statistically significant effect for IT stocks around the lockdown—immediate market impact not detected on a day-by-day basis.
- **Cumulative abnormal returns (CAR):** Show a significant *positive* effect, meaning the IT sector benefitted overall during the event window, likely reflecting digital transformation and increased demand for tech during lockdown.

---

## ⚙️ How It Works

### Methodology Steps:

1. **Data Collection** — Download daily Nifty 50 (`^NSEI`) and Nifty IT (`^CNXIT`) prices.
2. **Defining Windows**  
   - **Event Date:** March 24, 2020 (lockdown announced).
   - **Estimation Window:** 60 days before event window.
   - **Event Window:** 10 days before to 10 after (March 10–April 7, 2020).
3. **Return Computation** — Convert prices to daily returns.
4. **Market Model Estimation**  
   - Model IT sector returns with market index returns over estimation window.
5. **AR & CAR Calculation**  
   - Calculate abnormal and cumulative abnormal returns in event window.
6. **Statistical Testing**  
   - Use t-tests to determine if AR and CAR differ significantly from zero.
7. **Result Visualization**  
   - Plot AR and CAR over time for intuitive understanding.

---

## 🛠 Required R Packages

install.packages(c("quantmod", "PerformanceAnalytics", "tidyverse", "tseries"))


---

## ▶️ Usage

1. Run `Case-studies-ESA_Global-Event.R` script in R.
2. Choose/modifiy event date and estimation/event window parameters as needed.
3. Inspect AR and CAR plots and statistical test outputs in console.

---


---

## 📊 Interpretation & Conclusion

- The results reveal that while the COVID-19 lockdown was not associated with statistically significant daily abnormal returns for the IT sector, the **cumulative abnormal return (CAR) was both positive and significant**.
- This suggests that the IT sector in India ultimately *benefited* from the digitization trends and operational reliance on technology that were accelerated by the pandemic and lockdown conditions.

---

## 📖 References

- MacKinlay, A.C. (1997), "Event Studies in Economics and Finance." *Journal of Economic Literature*.
- Yahoo Finance: Nifty 50 (`^NSEI`), Nifty IT (`^CNXIT`)
- R Packages: `quantmod`, `PerformanceAnalytics`, `tidyverse`, `tseries`

---

*For questions, open an issue or discussion!*


