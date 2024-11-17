# Adventure Works Project

This project is dedicated to transforming and modeling data from the AdventureWorks dataset, hosted in Google BigQuery, to prepare it for insightful analysis and visualization. AdventureWorks is a sample database provided by Microsoft, which simulates a retail company's operations, including sales, product management, and customer interactions.

The transformations in this project focus on:

- Data modeling: building robust dimensions and fact tables to support various business analyses.
- Data quality: ensuring data integrity through rigorous testing and validation.
- Performance optimization: streamlining queries and models for efficient data processing and quick response times.
- Visualization readiness: structuring data in a way that facilitates easy integration with data visualization tools for reporting and dashboards.

This project serves as a foundational layer for business intelligence, enabling stakeholders to derive actionable insights from well-structured and reliable data.

For more information about the Adventure Works Data, access their data dictionary [HERE](https://dataedo.com/download/AdventureWorks.pdf).

All the schemas, tables and interactions can also be checked [HERE](https://raw.githubusercontent.com/dpavancini/analytics-engineering/main/AdventureWorks/AdventureWorksERD.jpeg).

## Tools utilized in this project:

- Google BigQuery
- dbt Cloud
- Power BI
- GitHub

## Project Structure:

- Staging (stg): in the staging layer, raw tables were refined by adjusting data types, reorganizing column positions, and renaming fields for consistency.
- Dimensions (dim): dimension tables were crafted to describe and contextualize the data within the fact table, following a star schema to support effective relationships in Power BI.
- Fact Table (fact): the fact table consolidates the core data, providing direct answers to the business questions and incorporating essential IDs for seamless future connections.
- Aggregations (aggs): aggregated tables were designed to enhance processing efficiency and facilitate deeper analytical insights for Data Science.

Each table created within this project undergoes rigorous testing to ensure the highest data quality.

Note: seed files were removed from the repository after executing dbt seed to optimize the runtime of dbt run. These files can be retrieved from [THIS](https://github.com/techindicium/academy-dbt) repository.
