resource "aws_s3_bucket" "ecs_state" {
  bucket = "terraform-ecs-state"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "state_public_access" {
  bucket = aws_s3_bucket.ecs_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "state_locks" {
  name           = "ecs-state-locks"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
