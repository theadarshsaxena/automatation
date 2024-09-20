#!/bin/bash

# Get the cluster name and region from command line arguments
cluster_name=$1
region=$2

# Fetch the list of services in the ECS cluster
services=$(aws ecs list-services --cluster $cluster_name --query 'serviceArns' --region $region --output json)
# services="Service1,Service2,Service3"

# Output the result in JSON format
# echo "{\"services\": [\"s1\"]}"

jq -n --arg services "$services" '{"services":$services}'