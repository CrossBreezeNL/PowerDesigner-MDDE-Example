from datetime import datetime, timedelta

from airflow.models import DAG
from apache_airflow_microsoft_fabric_plugin.operators.fabric import FabricRunItemOperator

def run_adfpipelines(SchemaName, TableName):
    
    run_adf_pipeline = FabricRunItemOperator(
        task_id = "stage" + SchemaName + "." + TableName,
        item_id = "46c3f42f-2989-4ad0-adda-82e6571df11e",
        job_type="Pipeline",

        job_params = {
            "schema_name" : SchemaName,
            "table_name" : TableName
        },

        wait_for_termination=True,
        deferrable=False,
    )

    run_adf_pipeline

    return 

with DAG(
    dag_id="run_fabric_item",
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
    ##-- @XGenTextSection(name="Table")
    run_adfpipelines("Schema_Code", "Table_Name")
