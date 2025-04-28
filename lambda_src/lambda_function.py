import boto3
import os
import json

# Load environment variables properly
TABLE_NAME = os.environ.get('TABLE_NAME')
TOPIC_ARN = os.environ.get('TOPIC_ARN')
MAIN_BUCKET = os.environ.get('MAIN_BUCKET')
QUARANTINE_BUCKET = os.environ.get('QUARANTINE_BUCKET')


dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')  
sns = boto3.client('sns')  

def handler(event, context):
    print("Lambda triggered.")
    try:
        record = event['Records'][0]
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']

        print(f"Received file: {key} from bucket: {bucket}")

        # Check if file is a .csv file
        if key.lower().endswith('.csv'):
            print("File is a CSV. Processing normally.")

            # Write to DynamoDB
            table = dynamodb.Table(TABLE_NAME)
            table.put_item(
                Item={
                    'file_id': key,
                    'bucket_name': bucket,
                    'status': 'Processed'
                }
            )

            # Publish success
            sns.publish(
                TopicArn=TOPIC_ARN,
                Subject='File Processed Successfully',
                Message=f'File {key} was successfully processed and stored.'
            )
        else:
            print("File is NOT a CSV. Moving to quarantine.")

            # Move to Quarantine Bucket
            copy_source = {
                'Bucket': bucket,
                'Key': key
            }
            s3.copy_object(
                Bucket=QUARANTINE_BUCKET,
                CopySource=copy_source,
                Key=key
            )
            s3.delete_object(
                Bucket=bucket,
                Key=key
            )

            # Record to DynamoDB as Quarantined
            table = dynamodb.Table(TABLE_NAME)
            table.put_item(
                Item={
                    'file_id': key,
                    'bucket_name': QUARANTINE_BUCKET,
                    'status': 'Quarantined'
                }
            )

            # Publish failure
            sns.publish(
                TopicArn=TOPIC_ARN,
                Subject='File Quarantined',
                Message=f'File {key} was quarantined because it was not a valid .csv file.'

            )

        return {
            'statusCode': 200,
            'body': json.dumps('Process complete!')
        }

    except Exception as e:
        print(f"Error occurred: {str(e)}")

        sns.publish(
            TopicArn=TOPIC_ARN,
            Subject='File Processing Failed',
            Message=f'Unexpected error: {str(e)}'
        )

        return {
            'statusCode': 500,
            'body': json.dumps('Error occurred.')
        }
