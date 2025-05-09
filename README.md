# Silent Scaler — Serverless Data Pipeline

![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC?style=for-the-badge&logo=terraform)
![Cloud](https://img.shields.io/badge/Cloud-AWS-232F3E?style=for-the-badge&logo=amazonaws)
![AWS S3](https://img.shields.io/badge/AWS%20S3-Storage-569A31?style=for-the-badge&logo=amazonaws)
![AWS Lambda](https://img.shields.io/badge/AWS%20Lambda-Serverless-F58536?style=for-the-badge&logo=awslambda)
![AWS DynamoDB](https://img.shields.io/badge/AWS%20DynamoDB-NoSQL-4053D6?style=for-the-badge&logo=amazonaws)
![AWS SNS](https://img.shields.io/badge/AWS%20SNS-Notifications-F09135?style=for-the-badge&logo=amazonaws)
![Serverless Architecture](https://img.shields.io/badge/Architecture-Serverless-4B5563?style=for-the-badge)


Silent Scaler is a fully serverless, infrastructure-as-code data pipeline built entirely with AWS and Terraform. This project automates file validation, storage, quarantine of invalid files, and real-time error notifications via SNS, demonstrating modular design, scalability, and operational resilience.

---

## Demo

🎥 **Watch the full demo on YouTube**  


[Watch the YouTube demo](https://youtu.be/uDiRmnwWhkM)

> 📃 **Note:** This service is currently turned off to reduce AWS costs, but all resources can be reproduced from this repository.

---

## Architecture

This diagram summarizes the AWS serverless architecture of Silent Scaler:

![Silent Scaler Architecture](screenshots/silent-scaler-main.png)

- Files uploaded to **S3 Main Bucket**.
- **Lambda Function** validates files:
  - **Good files** → Metadata saved to **DynamoDB** and **SNS email notification sent**.
  - **Bad files** → Moved to **Quarantine Bucket** and **SNS email notification sent**.
- **CloudWatch Logs** for monitoring Lambda behavior.

---

## Technologies Used

- **AWS S3**: File storage and event triggers.
- **AWS Lambda**: Serverless file validation and quarantine handler.
- **AWS DynamoDB**: Metadata storage.
- **AWS SNS**: Real-time error notifications.
- **AWS CloudWatch**: Monitoring and error tracking.
- **Terraform**: Infrastructure as code (IaC) deployment.

---

## Project Setup

1. Clone the repo:
```bash
git clone https://github.com/fkv747/terraform-silent-scaler.git
cd terraform-silent-scaler
```

2. Initialize Terraform:
```bash
terraform init
```

3. Plan the deployment:
```bash
terraform plan
```

4. Apply the infrastructure:
```bash
terraform apply
```

---

## Folder Structure

![Folder Structure](screenshots/1-folder-structure.png)

---

## Module Breakdown

| Module | Purpose |
|:---|:---|
| **S3 Bucket** | Main upload bucket + quarantine bucket creation |
| **Lambda Function** | Processes uploaded files, validates CSV format, handles quarantine |
| **DynamoDB Table** | Stores file metadata for valid uploads |
| **SNS Topic** | Sends notifications on critical errors |
| **CloudWatch** | Logs Lambda activities and failures |

---

## Terraform Apply Screenshots

**Deploying S3 Buckets:**

![Terraform Apply S3](screenshots/2-terraform-apply-s3.png)

**Deploying DynamoDB Table:**

![Terraform Apply DynamoDB](screenshots/3-terraform-apply-dynamodb.png)

**Deploying Lambda Function:**

![Terraform Lambda Deploy](screenshots/4-terraform-lambda.png)

**Deploying SNS Topic:**

![Terraform SNS Deploy](screenshots/5-terraform-sns.png)

**Deploying S3 Trigger Notification:**

![Terraform S3 Trigger Deploy](screenshots/6-terraform-s3trigger.png)

**Lambda Handler Deployment Update:**

![Terraform Apply Lambda Handler](screenshots/6.1-terraform-apply-handler.png)

**Final Lambda Deployment:**

![Final Lambda](screenshots/8-terraform-final-lambda.png)

---

## Testing & Validation

**Lambda Test – Good File (CSV)**

![Lambda Test Good File](screenshots/lambda-test-good-file.png)

**CloudWatch Logs – Good File Processing**

![CloudWatch Good File](screenshots/cloudwatch-log-good-file.png)

**Lambda Test – Bad File (Non-CSV)**

![Lambda Test Bad File](screenshots/lambda-test-bad-file.png)

**CloudWatch Logs – Bad File Processing**

![CloudWatch Bad File](screenshots/cloudwatch-log-bad-file.png)


---

## Challenges Faced & Lessons Learned

Building Silent Scaler was not without obstacles. Here are some real-world issues faced during development:

**1. Environment Variables Missing**

![Error 1](screenshots/errors/1-error.png)
- Missing environment variable `QUARANTINE_BUCKET` caused Lambda failures.
- Lesson: Always validate environment variable injection into Lambda functions during deployment.

**2. IAM Permissions Errors**

![Error 2](screenshots/errors/2-error.png)
- Lambda initially lacked permission to publish to SNS.
- Lesson: Ensuring correct IAM Role permissions is critical for event-driven pipelines.

**3. SNS Publishing Authorization Error**

![IAM Role Error](screenshots/errors/3-error-iam-role-sns.png)
- AccessDenied when trying to publish SNS notifications.
- Lesson: Explicitly attach SNS publish policies to Lambda execution roles.

> **Key Takeaway:** Real-world AWS projects require frequent debugging, permission tuning, and error handling mastery.

---

## Future Improvements

- Add a simple frontend powered by API Gateway and AWS Amplify to allow users to upload files through a web page.


---


## Connect with Me

📫 [LinkedIn](https://www.linkedin.com/in/franc-kevin-v-07108b111/)