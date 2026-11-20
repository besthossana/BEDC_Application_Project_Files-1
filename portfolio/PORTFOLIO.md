# Data Analytics Portfolio: Aikhaituamen Best Hossana

Data Analyst, Benin City, Nigeria | besthossana@gmail.com | 08121047160

Each project below is written the same way: the problem, what I did, what I found, and what I would recommend.

---

## 1. Energy Loss and Revenue Assurance Analysis: BEDC
**Tools:** Python, SQL, Excel | **Date:** November 2026
**Files:** `bedc_project/` (README, notebook, dashboard, workbook, SQL, charts)

**Problem.** In Q2 2026, BEDC lost 33.8% of the value of the electricity it received, against a regulator target of 17.2%. It was not clear whether the leak was in billing customers or in collecting payment.

**What I did.** Took the regulator's published quarterly reports, cleaned the figures, and checked them by recalculating the regulator's own loss numbers (all matched). Then traced where every ₦100 of electricity went: ₦66 collected, ₦5 billed but not paid, ₦29 never billed.

**Findings**
- Collection is not the problem: BEDC collected 92.7% of what it billed, the best of Nigeria's 11 distribution companies.
- Billing is the problem: only about 71% of the electricity's value reached a bill. Even with perfect collection, losses would stay at 28.6%, above the 17.2% target.
- 91% of the Q1 to Q2 loss improvement came from better collection. More than half (53%) of billing loss was electricity billed below the average price, not electricity left unbilled.
- BEDC collects about ₦12.9bn less per quarter than it would at target losses.

**Recommendations.** Fix billing first. Find which customer groups are billed below the average price. Prioritise meters, since 39% of customers are unmetered. Track collection monthly to see if the gain lasts.

**Limits.** Public data is quarterly and company-wide. The cause of the below-average billing needs BEDC's internal feeder and tariff data.

---

## 2. Customer Retention and Financial Performance Analysis: Online Retailer
**Tools:** Python, SQL (SQLite) | **Date:** [add month/year]
**Data:** UCI Online Retail II, a public dataset of a UK online retailer, 1 Dec 2009 to 9 Dec 2011
**Files:** `customer_retention_report.pdf` (9-page findings report)

**Problem.** A UK online retailer had two years of sales records (41,938 orders, 5,881 identifiable customers) but no clear view of whether customers came back, who generated the revenue, which market mattered most, or where revenue was at risk. About 15% of sales were not linked to any customer, so the data itself needed checking.

**What I did.** Cleaned the data (removed 34,335 duplicate rows, separated cancellations and credits from sales, and measured the sales with no customer ID). Then measured repeat buying over fixed time windows, grouped customers by how recently, how often and how much they buy (RFM), tracked monthly customer groups over time (cohorts), and compared countries. For every finding I wrote down the questions a sceptical manager would ask and answered them, or said clearly that the data could not answer them.

**Findings**
1. **Revenue is concentrated in a few customers.** 1,290 "Champion" customers (22% of customers) generated 68% of customer revenue, and the top 1% of customers generated 32%. A 10% fall in Champion spending would cut customer revenue by about 6.8%.
2. **"72% of customers buy again" overstates loyalty.** That figure counts anyone with two orders at any time in two years. Measured fairly, 23% of customers bought again within 30 days, 47% within 90 days, and 75% within a year (for customers with a full year of history).
3. **The UK is 85% of revenue, mainly because it has 91% of customers.** UK customers do not spend more each. Small markets look higher per customer but rest on very few customers (for example, 5 in Ireland), so those averages are unreliable.
4. **40% of customers (2,353) have been inactive for over a year, but they made only 12.9% of past revenue.** Inactive does not mean lost, so they should be tested with win-back offers, not written off.
5. **Customer activity rises and falls.** In the first monthly group (955 customers), activity rose from 33% in February to 42.5% in March 2010. Part of the rise was customers returning after a gap. March revenue was also higher than February in both years, which is consistent with a seasonal pattern but is not proof with only two years of data.
6. **15.1% of sales (3.1 million) could not be tied to any customer.** All customer results cover only the other 85%.

**Recommendations**
- Protect the top customers and watch concentration risk.
- Report retention over fixed time windows, not a single whole-period rate.
- Treat inactive customers as a group to investigate and test, not as lost.
- Make capturing customer IDs a top data-quality priority.
- Check invoice by invoice that cancellations and credits are handled correctly before quoting net sales.

**Limits stated in the report.** The data has no costs, so it shows revenue, not profit. Customer groups are rule-based labels, not proven customer states. Causes of returns, inactivity or seasonality cannot be proven without campaign, cost and registration data.

**Be ready to explain in an interview**
- Why 72% (whole period) and 75% (365-day) differ even though one window is shorter: the 365-day figure only counts customers who had a full year of history, so it is a different group.
- What RFM is and how the segments were defined.
- Why you did not call the results profit.
- Why you kept a log of removed duplicate rows.

---

## More projects
Housing data dashboard (Power BI), sales performance analysis (Excel), and AI prompt-to-chart dashboard: to be added with their findings.
