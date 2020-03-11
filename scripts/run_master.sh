#!/bin/sh

echo "Starting flask server"
flask run --host=0.0.0.0 --port=8000 &> flask_server.log &

echo "Starting Spark master"
/spark/bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_LOCAL_IP \
    --port $SPARK_MASTER_PORT \
    --webui-port $SPARK_MASTER_WEBUI_PORT