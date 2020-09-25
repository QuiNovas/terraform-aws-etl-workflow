data "template_file" "script" {
  count    = var.script_location == "" ? 1 : 0
  template = file("${path.module}/script/compaction-etl-py.tpl")
  vars = {
    datalake_bucket        = var.datalake_bucket
    s3_prefix              = var.datalake_prefix
    datalake_format        = var.datalake_format
    optimal_partition_size = var.optimal_partition_size
  }
}

resource "aws_s3_bucket_object" "script" {
  count   = var.script_location == "" ? 1 : 0
  bucket  = var.script_s3_bucket
  key     = "${var.script_s3_prefix}/compaction-etl-${var.datalake_format}.py"
  content = data.template_file.script.0.rendered
}
