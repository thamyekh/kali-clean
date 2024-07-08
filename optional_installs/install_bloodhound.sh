#!/usr/bin/env bash

sudo -sE ./install_docker.sh
curl https://raw.githubusercontent.com/SpecterOps/BloodHound/main/examples/docker-compose/docker-compose.yml | sudo docker compose -f - up

# this will initialise 3 containers bloodhound, postgres and neo4j
# You can stop the container hitting ctrl+C and in the future if you want to restart them:
# docker ps -a
# docker start <postgres_container_id> <neo4j_container_id>
# ...
# docker start <bloodhound_container_id>
# visit http://localhost:8080
# to terminate: docker stop <bloodhound_container_id> <postgres_container_id> <neo4j_container_id>
