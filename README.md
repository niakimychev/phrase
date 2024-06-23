# Phrase

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

- `main.tf`: The main Terraform configuration file.
- `modules/`: Contains Terraform modules for different components:
  - `alb/`: Application Load Balancer configuration.
  - `ecs/`: Elastic Container Service configuration.
  - `nginx/`: Nginx configuration with Ansible and Docker files.
  - `vpc/`: Virtual Private Cloud configuration.

## License

This project is licensed under the MIT License.
