# Phrase

## Description

- Ansible is used to build and deploy the Nginx Docker image to ECR. 
- It includes a sample Nginx configuration with a simple index.html file. 
- The VPC consists of three public and three private subnets. 
- Three Nginx applications are deployed in ECS Fargate, connected to an Application Load Balancer (ALB). 
- To enable ECS tasks located in private subnets to communicate with the ECR registry, VPC endpoints have been created. 
- If modifications are needed, you can adjust the corresponding local variables in the main.tf file located in the project's root directory.

## Dependencies

- Terraform >= 0.12
- AWS CLI
- Ansible (for Nginx module)
- Docker (for building and pushing Nginx images)

## Installation

### Prerequisites

1. Ensure Terraform is installed on your system. [Terraform's official site](https://www.terraform.io/downloads.html).
2. Configure AWS CLI with your credentials:
   ```sh
   aws configure
   ```
3. Install Ansible:
   ```sh
   pip install ansible
   ```
4. Install Docker from [Docker's official site](https://docs.docker.com/get-docker/).

### Steps

1. Initialize Terraform:
   ```sh
   terraform init
   ```

2. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

3. You can open the website by the cloudfront url provided in terminal.

## Project Structure

```
phrase/
├── main.tf
├── modules/
│   ├── alb/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── nginx/
│   │   ├── ansible/
│   │   │   └── build_push.yml
│   │   ├── files/
│   │   │   ├── Dockerfile
│   │   │   ├── nginx.conf
│   │   │   └── html/
│   │   │       └── index.html
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── vpc_endpoints.tf
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```



- `main.tf`: The main Terraform configuration file.
- `modules/`: Contains Terraform modules for different components:
  - `alb/`: Application Load Balancer configuration.
  - `ecs/`: Elastic Container Service configuration.
  - `nginx/`: Nginx configuration with Ansible and Docker files.
  - `vpc/`: Virtual Private Cloud configuration.

## License

This project is licensed under the MIT License.
