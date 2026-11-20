# COLUMBIA-ASIA-HOSPITAL-ANALYSIS---Power-BI
**Project Overview-**
This project focuses on analysing hospital operations, patient demographics, doctor performance, departmental revenue and patient satisfaction using SQL and Microsoft Power BI.

The objective is to transform raw hospital data into meaningful insights that can help management understand operational performance, identify areas for improvement and make data-driven decisions.

**Business Objectives-**
-Analyse patient visits across different hospital departments.
-Evaluate departmental revenue and appointment fees.
-Examine doctor workload and patient distribution.
-Identify patterns in patient waiting times.
-Analyse patient satisfaction across different demographics.
-Understand monthly patient visit trends.
-Develop actionable recommendations to improve hospital operations and patient experience.

**Dataset Description-**
The project uses two datasets containing 9,216 records each.
1. Hospital ER Dataset
2. Doctor Patients Data

**Tools & Technologies-**
**Microsoft Power BI:** Dashboard development and data visualisation.
**MySQL Workbench:** SQL queries, data exploration and analysis.
**Power Query:** Data cleaning and transformation.
**DAX:** Calculated columns, measures and KPIs.
**Microsoft Excel:** Dataset inspection and preparation.

**Project Methodology-**
**Data Collection:** Imported the Hospital ER and Doctor Patients datasets.
**Data Cleaning:** Checked duplicates, missing values, data types and inconsistent categories.
**Data Transformation:** Standardised demographic fields, converted data types and created calculated columns.
**Data Modelling:** Connected both datasets using patient_id.
**SQL Analysis:** Performed aggregations, joins, CTEs and window-function analysis.
**Power BI Development:** Created DAX measures, KPIs, interactive dashboards and visualisations.
**Business Recommendations:** Interpreted findings and identified opportunities for operational improvement.

**Key Performance Indicators-**
Total Patient Visits - **9,216**
Total Hospital Revenue - **₹509 Million**
Total Appointment Fees - **₹5 Million**
Average Waiting Time - **35.26 Minutes**
Average Satisfaction Score - **4.86**
Doctors Count - **22**
Average satisfaction is calculated using recorded satisfaction scores only. Missing scores are excluded.

**Key Analysis & Findings-**
**1. Department Performance**
-General Practice recorded the highest patient volume with 7,240 visits.
-Orthopedics generated the highest departmental revenue at approximately ₹173 million.
-Renal recorded the lowest patient volume with 86 visits.

**2. Patient Demographics**
-Male patients accounted for 4,705 visits, while female patients accounted for 4,487.
-White patients represented the largest racial group across all departments.
-Middle-Aged and Senior Adults represented substantial shares of visits across departments.

**3. Doctor Workload**
-General Practice showed the highest patient workload indicator at 2,413.
-Orthopedics followed with 249.
-Staffing requirements in high-volume departments should be reviewed.

**4. Waiting Time & Satisfaction**
-Overall average patient waiting time was 35.26 minutes.
-Neurology and Physiotherapy recorded the highest average departmental waiting times at approximately 37 minutes.
-Patients waiting 0–15 minutes reported the highest average satisfaction score of 5.3.

**5. Revenue & Billing**
-Orthopedics and General Practice were the two largest revenue-generating departments.
-Neurology recorded the highest average patient bill at approximately ₹377.18K.
-Neurology also had the highest average appointment fee at ₹1,500.

**6. Monthly Patient Visit Trends**
-Patient visits fluctuated throughout the analysis period.
-August 2020 recorded the highest monthly visits at 530.
-February 2020 recorded the lowest monthly visits at 431.

**Power BI Dashboards**
The Power BI report contains three main sections:

**Main Dashboard-**
Hospital-level KPIs, patient demographics, department-wise visits and revenue, monthly visit trends and waiting-time analysis.
**Doctors' Dashboard-**
Doctor selection, department-wise workload, appointment fees and revenue analysis.
**Patients' Dashboard-**
Patient-level analysis of billing, waiting time, satisfaction and age-group patterns.

**Strategic Recommendations-**
-Review doctor allocation and staffing requirements in high-volume departments, particularly General Practice and Orthopedics.
-Improve appointment scheduling and patient flow to reduce waiting times.
-Strengthen patient feedback collection to improve the reliability of satisfaction analysis.
-Introduce targeted patient-support and discount programmes based on appropriate eligibility criteria.
-Review departmental billing patterns and operating expenses.
-Monitor patient access and service quality across demographic groups.

**Data Limitations-**
-6,699 out of 9,216 patient visits (72.69%) had missing satisfaction scores.
-Satisfaction-related findings are based only on recorded responses.
-Revenue figures alone cannot establish hospital profitability because complete operating expenses are unavailable.
-Demographic differences should be investigated further before drawing conclusions about unequal treatment.
-The analysis period covers April 2019 to October 2020.

**Conclusion-**
This project demonstrates how SQL and Power BI can be used to analyse healthcare data, evaluate hospital performance and identify operational improvement opportunities.

By combining data preparation, SQL-based analysis, DAX calculations and interactive dashboards, the project converts raw hospital records into actionable business insights that can support informed management decisions.
