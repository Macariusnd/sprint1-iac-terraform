# ─────────────────────────────────────────────
# S3 Bucket
# force_destroy = true lets terraform destroy
# remove the bucket even if it has objects in it
# ─────────────────────────────────────────────
resource "aws_s3_bucket" "bridgepoint_docs" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

# ─────────────────────────────────────────────
# Versioning
# Preserves every version of every object.
# Accidental deletes become recoverable.
# ─────────────────────────────────────────────
resource "aws_s3_bucket_versioning" "bridgepoint_docs" {
  bucket = aws_s3_bucket.bridgepoint_docs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ─────────────────────────────────────────────
# Server-side encryption (SSE-S3)
# AES-256 encryption applied automatically to
# every object written to the bucket.
# ─────────────────────────────────────────────
resource "aws_s3_bucket_server_side_encryption_configuration" "bridgepoint_docs" {
  bucket = aws_s3_bucket.bridgepoint_docs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

    # Ensures encryption is enforced even when
    # the upload request doesn't specify it
    bucket_key_enabled = true
  }
}

# ─────────────────────────────────────────────
# Lifecycle policy
# Automatically manages storage cost over time:
#   30 days  → move old versions to STANDARD_IA
#             (Infrequent Access — ~40% cheaper)
#   90 days  → permanently delete old versions
# ─────────────────────────────────────────────
resource "aws_s3_bucket_lifecycle_configuration" "bridgepoint_docs" {
  bucket = aws_s3_bucket.bridgepoint_docs.id

  # Versioning must be enabled before lifecycle rules apply
  depends_on = [aws_s3_bucket_versioning.bridgepoint_docs]

  rule {
    id     = "noncurrent-version-management"
    status = "Enabled"

    # Applies to all objects in the bucket
    filter {
      prefix = ""
    }

    # Move noncurrent versions to cheaper storage
    noncurrent_version_transition {
      noncurrent_days = var.noncurrent_transition_days
      storage_class   = "STANDARD_IA"
    }

    # Permanently delete noncurrent versions
    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_expiry_days
    }

    # Clean up incomplete multipart uploads after 7 days
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# ─────────────────────────────────────────────
# Public access block
# All four settings to true = bucket is
# completely private. No public URLs possible.
# This is the most important security control
# on any S3 bucket holding internal data.
# ─────────────────────────────────────────────
resource "aws_s3_bucket_public_access_block" "bridgepoint_docs" {
  bucket = aws_s3_bucket.bridgepoint_docs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ─────────────────────────────────────────────
# Test object
# Uploads a README.txt file into the bucket
# via Terraform so we can verify it in Console
# ─────────────────────────────────────────────
resource "aws_s3_object" "readme" {
  bucket  = aws_s3_bucket.bridgepoint_docs.id
  key     = "README.txt"
  content = <<-EOF
    BridgePoint Internal Document Store
    ====================================
    This bucket is managed by Terraform.
    Provisioned as part of Sprint 1 — IaC-003.
    
    Security controls:
    - Server-side encryption: AES-256 (SSE-S3)
    - Versioning: Enabled
    - Public access: Blocked
    - Lifecycle: Noncurrent versions → STANDARD_IA (30d) → Deleted (90d)
    
    Owner: Mac Okereke (mac-okereke)
    Environment: dev
  EOF

  content_type = "text/plain"

  tags = {
    Name = "bucket-readme"
  }
}
