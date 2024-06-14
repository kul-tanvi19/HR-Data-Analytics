# HR-Data-Analytics


## Table of Content
  - [Problem Statement](#Problem-Statement)
  - [Datasource](#Datasource)
  - [Data Preparation](#Data-Preparation)
  - [Data Modeling](#Data-Modeling)
  - [Data Analysis](#Data-Analysis)
  - [Data Visualization](#Data-Visualization)
  - [Insights](#Insights)


## Problem Statement
Analyse HR Data to help an organization to improve the employee performance and identify what factors impact the retention (reduce attrition).


## Datasource
The data is in the form of excel file with `33 columns` and `1470 records`. 


## Data Preparation
  1. Create Dataset
  2. Import dataset into SQL SERVER
  3. Understanding the data :
     <br>
     After collecting the data it is very important to know the data and understanding what has to be done to get meaningful insights.

  4. Data Cleaning :
     <br>
     In this step we examine the data to check for any null or duplicate values. If it is there then we remove those values using appropriate strategies.

  5. Creation of new columns from existing ones :
     - Added new column as `age_group`.
     - Added new column as `monthly_income_group`.
     - Added new column as `perc_sal_hike_range` which contains range of percentage of salary hike given to employees.

  6. EDA :
     <br>
     Conducting exploratory data analysis to identify which factors afffect the most on the attrition using SQL.


## Data Modeling
Once EDA part is done, we connect SQL Server to Power BI for creating the dashboard. After that the data is ready for modeling.

![image](https://github.com/kul-tanvi19/HR-Data-Analytics/assets/172184420/9e1d926a-4cd0-41cf-bfbe-3bcd52455a28)


## Data Analysis
  - Possible KPIs to monitor employee performance and retention : 
     - Employee Count
     - Attrition Count
     - Attrition Rate
     - Average Percentage of Salary Hike

  - Dax measures used :
     - Total Employees = `COUNTROWS(HR_Data)`.
     - Attrition Count = `CALCULATE(COUNT(HR_Data[Employee Number]), FILTER(HR_Data, HR_Data[Attrition] = "yes"))`.
     - Attrition Rate = `DIVIDE([Attrition Count], [Total Employees],0)`.
     - Avg % Salary Hike = `AVERAGE(HR_Data[Percent Salary Hike]) / 100`.

  - Filters used :
     - Filter HR report by `Gender`.
     - Filter HR report by `Department`
   

## Data Visualization
HR Analytics Dashboard

![image](https://github.com/kul-tanvi19/HR-Data-Analytics/assets/172184420/ad7af802-4dd5-41b4-9077-21ed7ba751dc)
