# Sprint 1 — IaC-003: S3 Bucket with Versioning, Encryption & Lifecycle

**Ticket:** IaC-003 | **Sprint:** 1 — Infrastructure as Code | **Status:** Complete

## What this provisions

A production-hardened S3 bucket for BridgePoint internal document storage:

| Feature | Configuration |
|---|---|
| Bucket name | `bridgepoint-docs-npo-7391` |
| Versioning | Enabled — every object version preserved |
| Encryption | SSE-S3 (AES-256) — all objects encrypted at rest |
| Lifecycle | Noncurrent → STANDARD_IA after 30d → Deleted after 90d |
| Public access | Fully blocked — all 4 public access block settings = true |
| Test object | `README.txt` uploaded via Terraform |

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│              S3 Bucket: bridgepoint-docs-npo-7391           │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  Public access block (all 4 settings = true)        │   │
│  │  ┌───────────────────────────────────────────────┐  │   │
│  │  │  Server-side encryption: AES-256 (SSE-S3)     │  │   │
│  │  │  ┌─────────────────────────────────────────┐  │  │   │
│  │  │  │  Versioning: Enabled                    │  │  │   │
│  │  │  │  ┌───────────────────────────────────┐  │  │  │   │
│  │  │  │  │  Objects (e.g. README.txt)        │  │  │  │   │
│  │  │  │  │  v1 (current)                     │  │  │  │   │
│  │  │  │  │  v0 (noncurrent) ──30d──► IA      │  │  │  │   │
│  │  │  │  │                  ──90d──► deleted │  │  │  │   │
│  │  │  │  └───────────────────────────────────┘  │  │  │   │
│  │  │  └─────────────────────────────────────────┘  │  │   │
│  │  └───────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## File structure

```
sprint1-s3/
├── providers.tf    # AWS provider configuration
├── variables.tf    # Bucket name, lifecycle day variables
├── main.tf         # All S3 resources
├── outputs.tf      # Bucket name, ARN, console URL
└── .gitignore      # Keeps state files out of Git
```

## Usage

```bash
cd sprint1-s3/

terraform init
terraform plan    # shows 6 resources to add
terraform apply   # type yes

terraform output  # grab the console_url and open it in browser

terraform destroy # always destroy after the lab
```

## Resources created (6 total)

1. `aws_s3_bucket` — the bucket itself
2. `aws_s3_bucket_versioning` — versioning configuration
3. `aws_s3_bucket_server_side_encryption_configuration` — AES-256 encryption
4. `aws_s3_bucket_lifecycle_configuration` — noncurrent version management
5. `aws_s3_bucket_public_access_block` — all public access blocked
6. `aws_s3_object` — README.txt test object

---
*Part of Mac Okereke's Cloud/DevOps internship simulation portfolio.*
*GitHub: [Macariusnd](https://github.com/Macariusnd)*
