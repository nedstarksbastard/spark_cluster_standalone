#!/bin/sh

echo "Starting Spark worker"
/spark/bin/spark-class org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_WEBUI_PORT \
    $SPARK_MASTER