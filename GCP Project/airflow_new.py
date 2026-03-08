from airflow import models
from datetime import datetime
from airflow.providers.apache.beam.operators.beam import BeamRunPythonPipelineOperator

with models.DAG(
    dag_id="food_orders_dag",
    start_date=datetime(2026, 3, 7),
    schedule_interval="@daily",
    catchup=False,
) as dag:

    run_beam = BeamRunPythonPipelineOperator(
        task_id="beam_pipeline",
        py_file="gs://us-central1-demo-food-order-667b04a9-bucket/code_written_python_3.py",
        runner="DataflowRunner",
        pipeline_options={
            "project": "gcp-cloud-learn-babu",
            "region": "us-central1",
            "input": "gs://daily_food_ordeers/food_daily.csv",
            "temp_location": "gs://df-test-clud-storage"
        },
    )