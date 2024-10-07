import json
import boto3
import logging

from botocore.exceptions import ClientError

ecs_client = boto3.client('ecs')
sns_client = boto3.client('sns')
logging.basicConfig(level=logging.INFO) 

# Replace with your SNS topic ARN
SNS_TOPIC_ARN = '${sns_arn_replacement}'

def lambda_handler(event, context):
    # Extract cluster and service details from the event
    logging.info(f"Received event: {json.dumps(event)}")  # Log the full event data 
    # print(json.dumps(event))
    
    detail = event.get('detail', {})
    cluster_arn = detail.get('clusterArn')
    service_name = detail.get('group').split(':')[-1]
    # print(detail)
    # print(cluster_arn)
    # print(service_name)

    if not cluster_arn or not service_name:
        print("No cluster or service info found in the event")
        return

    # Check task failure count
    failure_count = check_task_failures(cluster_arn, service_name)
    print(f"failure_count : {failure_count}")
    if failure_count > 3:
        # Send alert via SNS
        send_alert(cluster_arn, service_name, failure_count)
        
    
def check_task_failures(cluster_arn, service_name):
    # Describe the service to get the task failures
    response = ecs_client.describe_services(
        cluster=cluster_arn,
        services=[service_name]
    )
    
    
    if 'services' in response and len(response['services']) > 0:
        service = response['services'][0]
        
        countf= service['deployments'][0].get('failedTasks', 0)
    
        return countf
    return 0

def send_alert(cluster_arn, service_name, failure_count):
    cluster_name= cluster_arn.split("/")[-1]
    message = f"The container in Service : {service_name} in N. Virginia cluster {cluster_name} has {failure_count} task failures."
    try:
        response = sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=message,
            Subject='AWS ECS Deployment Alert (Task Failing)'
        )
        print(f"Alert sent successfully: {response}")
    except ClientError as e:
        print(f"Error sending alert: {e}")
