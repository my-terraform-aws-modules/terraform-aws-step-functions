import boto3
import json

SF_CLIENT = boto3.client('stepfunctions')
SSM_CLIENT = boto3.client("ssm")
          
def lambda_handler(event, context):
    print("Starting state machine")

    SF_CLIENT.start_execution(
    stateMachineArn='arn:aws:states:eu-west-1:161233504804:stateMachine:ReportingLoansSavingsStateMachine-50kwDzw0UJyI'
    )
    
    print("State machine started")
