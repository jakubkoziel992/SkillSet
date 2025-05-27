import json
import boto3
import os
import sys
import logging
import argparse
from pathlib import Path

# file = Path("C:/Users/jakub.koziel/Desktop/Python/SkillSet/scripts/gl-sast-report.json")

# with open(file) as json_file:
#   report = json.load(json_file)
#   print(report)

parser = argparse.ArgumentParser(description="Execute script: ./upload_articats_to_s3.py --bucket 'example_bucket'")
parser.add_argument('--bucket', type=str, required=True, help='S3 bucket path')
args = parser.parse_args()

logging.basicConfig(
    filename='upload.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filemode="a"
)



def upload_file(file_name):  
    s3 = boto3.client(
        "s3",
        aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
        aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY"),
        region_name=os.getenv("AWS_REGION")
        
    )

    local_file = Path(file_name)
    
    if not local_file.exists():
        logging.error(f"File not found: {local_file}")
        return False
    
    remote_file = f"reports/{local_file.name}"
    bucket_name = args.bucket
    
    
    
    try:
        s3.upload_file(str(local_file), bucket_name, remote_file)
        logging.info(f"File uploaded: s3://{bucket_name}/{remote_file}")
    except Exception as e:
        logging.error(f"Upload failed: {e}")
        return True
    return True

upload_file("app/reports/coverage.xml")
upload_file("iac-scan-report.json")
upload_file("sca-scan-report.json")
upload_file("container-scanning-report.json")
upload_file("gl-sast-report.json")

log_file = Path("upload.log")

with open(log_file) as file:
  logs = file.read()
  print(logs)
