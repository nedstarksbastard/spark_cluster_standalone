# spark_cluster_standalone

### Pre-requisites
- Docker
- Docker-compose


### Playbook

cd into the source directory spark_cluster_standalone and run the following:

`docker-compose up --scale spark-worker=3`

copy your python scripts to the pysprk_jobs directory

go to the flask server at `http://localhost:8000/` and select a script from the dropdown that 
you have just added to the folder


### Dockerfile

Based on `openjdk:8-alpine`. Installed `apache spark` and `python 3.7.6` and additional python packages namely -
`pandas, numpy, pyspark and flask`. 

Available at https://hub.docker.com/repository/docker/fiziy/spark_standalone. The total size is 1.73 gb so it
could do with some pruning

### Docker-compose

Starts a spark master node that also hosts a minimal flask server to see and run all the jobs added to the 
local directory through a rest api. This is done to not manually exec into the server.

Starts worker nodes, the number of which is controlled through the up command.

Starts an internal network.

- spark url - http://localhost:8080/
- flask url - http://localhost:8000/