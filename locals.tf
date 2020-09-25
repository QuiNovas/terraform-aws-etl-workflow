locals {
  script_location = var.script_location == "" ? "s3://${var.script_s3_bucket}/${var.script_s3_prefix}/${aws_s3_bucket_object.script.0.id}" : var.script_location
}
