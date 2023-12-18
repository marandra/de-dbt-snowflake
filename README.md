# Data Engineering with *Snowflake* and *dbt*

A comprehensive set of data analytics pipelines for retail data, leveraging Snowflake and dbt. The project adheres to best practices such as data quality tests and code promotion between environments.

In this project, we use a sample retail dataset (TPC-H dataset from TPC Benchmark), transforming it into a consumable orders model ready for visualization. This is a fully functional dbt project complete with testing and documentation, and it provides dedicated development and production environments.

## Architecture Overview

![Architecture](assets/architecture.png)

dbt models are organized into layers: Source, Staging, Intermediate, Marts. Tables and views in the staging and intermediate layers are stored in the "Raw" database, while objects in the Marts layer reside in the "Analytics" database.

Three roles are defined in the project: Loader, Transformer, and Reporter. Each role has specific responsibilities and access rights:

- **Loader:** Responsible for loading data into the system. This role does not have access to analytics databases.

- **Transformer:** Manages the transformation of data and populates the analytics databases. This role serves as the bridge between the raw and analytics databases.

- **Reporter:** Exclusively focused on reporting and visualization. This role does not have access to the raw database.

The analytics database is populated by the Transformer, and each role uses its own warehouse.

### Getting Started

1. Set up a Snowflake project that includes:
   - RAW and ANALYTICS databases.
   - Each database has two schemas: DEV and PROD.
   - LOADING, TRANSFORMING, REPORTING warehouses.

2. Set up a project in dbt Cloud, with:
   - a git repository for version control of dbt models.
   - a connection to Snowflake.

3. Copy the contents of this repository to the one associated with the dbt account and commit the file.
4. Run `dbt seed`, `dbt test`, `dbt docs generate`, `dbt run`.

