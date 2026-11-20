-- BEDC Revenue Assurance Analysis - SQL (SQLite syntax, portable to PostgreSQL or SQL Server with minor changes)
-- Table: disco_quarterly (one row per DisCo per quarter) — see disco_quarterly.csv
-- Source: NERC Q1 2026 and Q2 2026 quarterly reports. 'Benin' = BEDC.

-- 1. Core KPIs per DisCo-quarter
CREATE VIEW IF NOT EXISTS kpi AS
SELECT disco, quarter,
       gwh_billed / gwh_received                         AS energy_acct_eff,
       naira_billed_bn / naira_received_bn               AS billing_eff,
       naira_collected_bn / naira_billed_bn              AS collection_eff,
       1 - (naira_billed_bn / naira_received_bn) * (naira_collected_bn / naira_billed_bn) AS atcc_calc,
       atcc_reported_pct / 100.0                         AS atcc_reported,
       naira_received_bn - naira_billed_bn               AS billing_loss_bn,
       (gwh_received - gwh_billed) * naira_received_bn / gwh_received AS volumetric_loss_bn
FROM disco_quarterly;

-- 2. Data-quality check: recomputed ATC&C vs NERC-reported (should be < 0.02pp everywhere)
SELECT quarter, ROUND(MAX(ABS(atcc_calc - atcc_reported)) * 100, 4) AS max_gap_pp
FROM kpi GROUP BY quarter ORDER BY quarter;

-- 3. BEDC: split of billing loss into unbilled energy vs. billed-below-average-tariff
SELECT quarter,
       ROUND(billing_loss_bn, 2)                                AS billing_loss_bn,
       ROUND(volumetric_loss_bn, 2)                             AS volumetric_bn,
       ROUND(billing_loss_bn - volumetric_loss_bn, 2)           AS tariff_mix_bn,
       ROUND((billing_loss_bn - volumetric_loss_bn) / billing_loss_bn, 3) AS tariff_mix_share
FROM kpi WHERE disco = 'Benin' ORDER BY quarter;

-- 4. Peer ranking, Q2 2026 (window functions)
SELECT disco,
       ROUND(billing_eff, 3)    AS be,
       ROUND(collection_eff, 3) AS ce,
       ROUND(atcc_calc, 3)      AS atcc,
       RANK() OVER (ORDER BY billing_eff DESC)    AS rank_be,
       RANK() OVER (ORDER BY collection_eff DESC) AS rank_ce,
       RANK() OVER (ORDER BY atcc_calc ASC)       AS rank_atcc
FROM kpi WHERE quarter = 'Q2-2026' ORDER BY rank_atcc;

-- 5. ATC&C bridge Q1 -> Q2 2026 for BEDC (collection vs billing effect, percentage points)
WITH b AS (
  SELECT MAX(CASE WHEN quarter='Q1-2026' THEN billing_eff END)    AS be1,
         MAX(CASE WHEN quarter='Q2-2026' THEN billing_eff END)    AS be2,
         MAX(CASE WHEN quarter='Q1-2026' THEN collection_eff END) AS ce1,
         MAX(CASE WHEN quarter='Q2-2026' THEN collection_eff END) AS ce2
  FROM kpi WHERE disco = 'Benin')
SELECT ROUND(be1*(ce2-ce1)*100, 2)            AS collection_effect_pp,
       ROUND((be2-be1)*ce2*100, 2)            AS billing_effect_pp,
       ROUND((be1*(ce2-ce1)+(be2-be1)*ce2)*100, 2) AS total_improvement_pp
FROM b;

-- 6. Revenue shortfall vs MYTO target ATC&C (naira bn), BEDC, 2026 quarters
SELECT quarter,
       ROUND(naira_received_bn * (1 - myto_2026_target_pct/100.0), 2)                          AS revenue_at_target_bn,
       naira_collected_bn                                                                      AS actual_bn,
       ROUND(naira_received_bn * (1 - myto_2026_target_pct/100.0) - naira_collected_bn, 2)     AS shortfall_bn
FROM disco_quarterly WHERE disco = 'Benin' AND myto_2026_target_pct IS NOT NULL ORDER BY quarter;
