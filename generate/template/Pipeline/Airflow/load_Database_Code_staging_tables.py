from datetime import datetime, timedelta

from airflow.models import DAG
from apache_airflow_microsoft_fabric_plugin.operators.fabric import FabricRunItemOperator

def run_staging_pipeline(SchemaName, TableName):
    
    fabric_run_staging_pipeline = FabricRunItemOperator(
        task_id = "stage" + SchemaName + "." + TableName,
        # The item_id is the identifier of the Fabric Copy Data Pipeline.
        item_id = "46c3f42f-2989-4ad0-adda-82e6571df11e",
        job_type = "Pipeline",

        job_params = {
            "schema_name" : SchemaName,
            "table_name" : TableName
        },

        wait_for_termination=True,
        deferrable=False,
    )

    fabric_run_staging_pipeline

    return 

with DAG(
    dag_id="load_Database_Code_staging_tables",
    start_date=datetime(2022, 5, 14),
    schedule_interval="@daily",
    catchup=False,
    default_args={
        "retries": 1,
        "retry_delay": timedelta(minutes=3),
        "workspace_id" : "d0c41506-a12c-449a-9923-f1165de14193",
        "fabric_conn_id": "xb-fabric-connection", #This is a connection created on Airflow UI
    },
    default_view="graph",
) as dag:
    # @XGenTextSection(name="Table")
    run_staging_pipeline("Schema_Code", "Table_Name")
