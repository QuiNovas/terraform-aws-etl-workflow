data "template_file" "script" {
  count    = var.script_location == "" ? 1 : 0
  template = file("${path.module}/script/etl-py.tpl")
  vars = {
    datalake_bucket     = var.datalake_bucket
    s3_prefix           = var.datalake_prefix
    datalake_input_type = var.datalake_input_type
  }
}

resource "aws_s3_bucket_object" "script" {
  count   = var.script_location == "" ? 1 : 0
  bucket  = var.script_s3_bucket
  key     = "terraform/pyspark/compaction-etl.py"
  content = data.template_file.script.0.rendered
}
