# Sprint 1 — Infrastructure as Code: VPC Provisioning

**Task:** IaC-001 | **Sprint:** 1 — Infrastructure as Code | **Status:** Complete

## What this provisions

A production-ready VPC network foundation on AWS:

- 1 × VPC (`10.0.0.0/16`) with DNS enabled
- 2 × Public subnets across `eu-west-1a` and `eu-west-1b`
- 2 × Private subnets across `eu-west-1a` and `eu-west-1b`
- 1 × Internet Gateway attached to the VPC
- Public route table with default route `0.0.0.0/0 → IGW`
- Private route table with no IGW route (internal only)

## Architecture

```
                        ┌──────────────────────────────────────────┐
                        │           BridgePoint VPC                │
                        │           10.0.0.0/16                    │
  Internet              │                                          │
     │                  │  ┌───────────────┐  ┌───────────────┐   │
     │                  │  │ Public Subnet │  │ Public Subnet │   │
  [IGW]─────────────────│──│ 10.0.1.0/24  │  │ 10.0.2.0/24  │   │
                        │  │ eu-west-1a   │  │ eu-west-1b   │   │
                        │  └───────────────┘  └───────────────┘   │
                        │                                          │
                        │  ┌───────────────┐  ┌───────────────┐   │
                        │  │Private Subnet │  │Private Subnet │   │
                        │  │ 10.0.3.0/24  │  │ 10.0.4.0/24  │   │
                        │  │ eu-west-1a   │  │ eu-west-1b   │   │
                        │  └───────────────┘  └───────────────┘   │
                        └──────────────────────────────────────────┘
```

## File structure

```
sprint1-iac-terraform/
├── providers.tf    # AWS provider + Terraform version constraints
├── variables.tf    # All input variables with defaults
├── main.tf         # VPC, subnets, IGW, route tables
├── outputs.tf      # Exported resource IDs
└── .gitignore      # Keeps state files and secrets out of Git
```

## Usage

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS CLI configured: `aws configure`
- AWS Free Tier account

### Deploy

```bash
# 1. Initialise — downloads the AWS provider
terraform init

# 2. Preview what will be created (read this carefully)
terraform plan

# 3. Apply — type 'yes' when prompted
terraform apply

# 4. View outputs (VPC ID, subnet IDs, etc.)
terraform output

# 5. Destroy when done — avoids any accidental charges
terraform destroy
```

### Credential setup (never put keys in .tf files)

```bash
# Option A: AWS CLI (recommended)
aws configure

# Option B: Environment variables
export AWS_ACCESS_KEY_ID="your-key"
export AWS_SECRET_ACCESS_KEY="your-secret"
export AWS_DEFAULT_REGION="eu-west-1"
```

## Learning notes

Documented in Notion → Sprint 1 / Lab 01 — VPC Provisioning

---

*Part of Nnamdi Okereke's Cloud/DevOps internship simulation portfolio.*
*GitHub: [Macariusnd](https://github.com/Macariusnd)*
