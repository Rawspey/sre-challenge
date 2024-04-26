## SRE Challenge Project README

## System Architecture Diagram




## Findings
Identified some improvements and errors as listed below:

1. Pass the variables in the resource block in this format: var.security_groups. There was a typo in the resource "aws_launch_template" "workers" 

2. Create a resource block for s3 and database for locking. The backend should include the storage account name and its key with the database lock.

3. The VPC id and subnets id provided is not valid. Create a new VPC or specify the default VPC ID

4. Create an instance role for the iam instance profile . This is applicable to the application and workers instances

5. refactor the code by creating separate files for variables and output for readability.


## Recommendations
Modularize the terraform code for reusability: For example, the resource block "aws_codeploy_deployment_group"
 
Implement blue-green or canary deployment strategies for the applications to minimize downtime and mitigate risks during deployments.
Utilize Terraform workspaces to manage different environments (e.g., development, staging, production) within the same Terraform configuration.
 
 
Configure monitoring and logging for your infrastructure using AWS CloudWatch, prometheus and graphana to chart it.
 
Maintain comprehensive documentation for the Terraform configurations, including module usage, input variables, output values, and environment-specific settings.

Since probably the essence of using the AMI images with the autoscaling shedule is to reduce cost. We can use spot instances instead for cost optimization.

