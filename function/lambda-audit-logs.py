import os
import gzip
import base64
import json
import logging
import re
from typing import Any, Dict, List, Tuple
import boto3

#######################################
### Constants #########################
#######################################
ACCOUNT_NAME = os.environ.get('ACCOUNT_NAME')
SNS_TOPIC_ARN = os.environ.get('SNS_TOPIC_ARN')

LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)
logger = logging.getLogger(__name__)

#######################################
###  Logs parsing ##############
#######################################

def process_event(event: Dict[str, Any]) -> Dict[str, Any]:
    decoded_payload = base64.b64decode(event.get("awslogs").get("data"))
    uncompressed_payload = gzip.decompress(decoded_payload)
    payload = json.loads(uncompressed_payload)
    return payload

def process_error_payload(payload: Dict[str, Any]) -> Tuple[str, str, str, List[Dict[str, Any]], str]:
    logGroup = payload.get("logGroup")
    logStream = payload.get("logStream")
    logEvents = payload.get("logEvents")
    lambda_function_name = logGroup.split("/")[-1]
    msg = "\n".join(levent["message"] for levent in logEvents)
    return logGroup, logStream, lambda_function_name, logEvents, msg

def parse_msg_fields(msg: str) -> Tuple[str, str, str, str, str]:
    msg_data = json.loads(msg)
    username = msg_data["user"]["extra"]["sessionName"][0]
    resource = msg_data["objectRef"]["resource"]
    namespace = msg_data["objectRef"].get("namespace", "None")
    verb = msg_data["verb"]
    acc = msg_data["user"]["uid"]
    match = re.search(r':(\d+):', acc)
    account = match.group(1) if match else None
    resource_name = msg_data["objectRef"].get("name", "None")
    return username, resource, namespace, verb, account, resource_name


#######################################
#########    SNS      #################
#######################################

def send_sns_alert(sns_client, account_id, account_name, event_name, initiator, resources, namespace):
    alert_message = (
        f"AWS EKS manual change detected via CLI in namespace {namespace} by user {initiator} in account {account_id}:\n"
        f"Action: {event_name}\n"
        f"Resources: {resources}\n"
    )
    subject = f"AWS EKS manual change detected: account {account_id} ({account_name})"
    
    sns_topic_arn = SNS_TOPIC_ARN
    sns_client.publish(TopicArn=sns_topic_arn, Message=alert_message, Subject=subject)


def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    try:
        payload = process_event(event)
        sns_client = boto3.client('sns')
        logGroup, logStream, lambda_function_name, logEvents, msg = process_error_payload(payload)
        parsed_msg = parse_msg_fields(msg)

        username, resource, namespace, verb, account = parsed_msg
        send_sns_alert(sns_client, account, ACCOUNT_NAME, verb, username, resource, namespace)
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Lambda function executed successfully!"}),
            "isBase64Encoded": False,
        }
    except Exception as e:
        logger.error("An error occurred: %s" % e)
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "Internal server error"}),
            "isBase64Encoded": False,
        }