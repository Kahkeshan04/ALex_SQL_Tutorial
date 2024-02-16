# SQL Queries Showcase

In this section, I'll briefly highlight some of the SQL concepts and queries I've practiced from the tutorial. These queries cover a range of functionalities, including both fundamental and advanced SQL topics.

### Concepts Explored:

- **Basic Retrieval:** Demonstrated the ability to fetch specific columns from tables using `SELECT`.

- **Filtering and Sorting:** Learned how to use `WHERE` for filtering and `ORDER BY` for sorting results.

- **Joins:** Explored joining tables to retrieve information from multiple sources.

- **Aggregations:** Practiced using aggregate functions like `COUNT`, `AVG`, and `GROUP BY`.

- **Advanced Joins:** Explored `INNER`, `LEFT OUTER`, `RIGHT OUTER`, and `FULL OUTER` joins for more complex data retrieval.

- **CASE Statements:** Utilized `CASE` statements to apply conditional logic in query results.

- **UNION and UNION ALL:** Combined and compared data from multiple tables using `UNION` and `UNION ALL`.

- **Window Functions (PARTITION BY):** Introduced window functions to perform calculations within specific partitions of the result set.

These queries showcase my hands-on experience with SQL, ranging from foundational concepts to advanced techniques. While the queries themselves are not included in this document, the associated SQL file provides a comprehensive view of the commands and techniques I've learned.

# COVID-19 Data Analysis Project

## Purpose:
The purpose of this project is to analyze and derive meaningful insights from the COVID-19 data, exploring key aspects such as total cases, deaths, vaccinations, and their relationships. By leveraging SQL queries and data manipulation techniques, the project aims to provide a deeper understanding of the impact of the pandemic on a global scale, offering valuable insights for informed decision-making.

## Queries Overview:

### 1. Total Cases vs Total Deaths
   - Analyzes the relationship between total COVID-19 cases and deaths, calculating the percentage of individuals who succumbed to the virus among those infected.

### 2. Total Cases vs Population
   - Explores the percentage of the population infected with COVID-19 in specific countries, shedding light on the scale of the pandemic's impact.

### 3. Global Numbers
   - Examines global COVID-19 statistics, including new cases, deaths, and the death percentage over time, providing a comprehensive view of the pandemic's progression.

### 4. Vaccination Analysis
   - Investigates the relationship between population, vaccinations, and the cumulative number of vaccinated individuals over time.

## Data Handling and Views:

- Addresses data type issues by temporarily converting columns to appropriate types.
- Implements error handling for data conversions.
- Utilizes temporary tables and views for organized data storage.

## Conclusion:
In the face of a global health crisis, data-driven insights play a crucial role in understanding the dynamics of the COVID-19 pandemic. This project harnesses the power of SQL to sift through vast datasets, unveiling patterns and trends that contribute to a more comprehensive understanding of the virus's impact on populations worldwide. By analyzing total cases, deaths, and vaccinations, we aim to empower individuals, communities, and decision-makers with valuable information to navigate these challenging times.


## SQL Data Cleaning and Enhancement

### Overview

This repository includes SQL queries demonstrating data cleaning and enhancement techniques on the [Nashville Housing Data] database. Below is a summary of the tasks performed:

### 1. Standardizing Data Format

- Extracting only the date from SaleDate using the `CONVERT(Date, SaleDate)` function.
- Setting default SaleDate values for better consistency.

### 2. Populating Missing Data

- Identifying and populating missing PropertyAddress values.
- Using a self-join on ParcelID to intelligently replace NULL values.

### 3. Address Parsing and Splitting

- Breaking down the PropertyAddress column into separate columns (Address, City).
- Demonstrating two different methods using `SUBSTRING` and `PARSENAME` functions.

### 4. Transforming Yes/No Values

- Transforming 'Y' and 'N' values in the "Sold as Vacant" field to 'Yes' and 'No' using a `CASE` statement.

### 5. Removing Duplicates

- Identifying and removing duplicate records with the `ROW_NUMBER()` function.
- Retaining necessary unique records in the dataset.

### 6. Deleting Unused Columns

- Streamlining the dataset by dropping unused columns such as OwnerAddress, TaxDistrict, and PropertyAddress.

### Conclusion

These SQL operations contribute to the overall cleanliness, consistency, and usability of the data for further analysis.

