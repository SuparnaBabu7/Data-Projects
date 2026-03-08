# Apache Beam End-to-End Data Engineering Project (GCP)

## Overview
This project demonstrates a complete **End-to-End Data Engineering pipeline on Google Cloud Platform (GCP)** using **Apache Beam** and **Cloud Dataflow**.

The pipeline ingests food order datasets from **Google Cloud Storage**, processes them using **Apache Beam**, loads the processed data into **BigQuery**, and finally visualizes insights using **Looker Studio** dashboards.

The workflow is automated using **Cloud Composer (Apache Airflow)**.

---

## Architecture Diagram

![Architecture Diagram](https://github.com/SuparnaBabu7/Data-Projects/blob/main/GCP%20Project/Archetecture.png)

---

## GCP Services Used

- Google Cloud Storage
- Apache Beam
- Cloud Dataflow
- BigQuery
- Cloud Composer (Apache Airflow)
- Looker Studio

---

## Datasets Used

The project uses the following datasets:

- `food_daily.csv`
- `food_daily_10_2020.csv`

These datasets contain food order data used to generate daily and monthly analytics reports.

---

## Project Workflow

### 1. Data Ingestion
- Create a **Google Cloud Storage bucket**
- Upload dataset files:
  - `food_daily.csv`
  - `food_daily_10_2020.csv`

---

### 2. Data Processing with Apache Beam
- Apache Beam pipeline written in **Python**
- Pipeline executed using **Cloud Dataflow**
- Processing includes:
  - Reading CSV files from GCS
  - Data transformation
  - Data validation
  - Preparing structured records

---

### 3. Data Warehouse (BigQuery)
- Processed data is loaded into **BigQuery**
- Dataset and tables are created
- Views and partitioned tables are used for optimized analytics

---

### 4. Data Visualization
Using **Looker Studio** dashboards.

#### Daily Sales Report
- Built using BigQuery views
- Displays daily order insights

#### Monthly Sales Report
- Month extracted from date field
- Aggregated monthly metrics

---

### 5. Workflow Automation

Automation is implemented using **Cloud Composer (Apache Airflow)**.

Steps:
1. Upload pipeline `.py` file to scheduler bucket
2. Upload **DAG file (`airflownew.py`)** to DAG folder
3. Trigger DAG execution
4. Dataflow pipeline runs automatically

---

## Pipeline Execution Flow

1. Upload dataset to **Cloud Storage**
2. Run **Apache Beam pipeline**
3. Data processed using **Cloud Dataflow**
4. Load transformed data into **BigQuery**
5. Build dashboards in **Looker Studio**
6. Automate pipeline using **Cloud Composer**

---

## Output

The pipeline produces:

- BigQuery datasets and tables
- Partitioned tables
- Daily sales dashboard
- Monthly sales dashboard

---

## Tech Stack

| Layer | Technology |
|------|-------------|
| Programming | Python |
| Data Processing | Apache Beam |
| Processing Engine | Cloud Dataflow |
| Storage | Google Cloud Storage |
| Data Warehouse | BigQuery |
| Orchestration | Cloud Composer (Airflow) |
| Visualization | Looker Studio |

---

## Project Structure

```
Apache-Beam-GCP-Project
│
├── data
│   ├── food_daily.csv
│   └── food_daily_10_2020.csv
│
├── pipeline
│   └── beam_pipeline.py
│
├── airflow
│   └── airflownew.py
│
├── architecture
│   └── Archetecture.png
│
└── README.md
```

---

## Key Learnings

- Building scalable pipelines using **Apache Beam**
- Running distributed processing with **Cloud Dataflow**
- Loading and querying analytics data in **BigQuery**
- Automating workflows using **Apache Airflow**
- Creating dashboards in **Looker Studio**

---

## Author

**Inturi Suparna Babu**

LinkedIn:  
https://www.linkedin.com/in/inturi-suparna-babu-312b59270/

---

⭐ If you found this project helpful, consider **starring the repository**.
