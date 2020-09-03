resource "aws_glue_workflow" "compaction_etl" {
  name = "${var.prefix}-compaction-etl"
}

resource "aws_glue_trigger" "compaction_etl_start" {
  name          = "${var.prefix}-scheduled-trigger"
  workflow_name = aws_glue_workflow.compaction_etl.name

  schedule = var.cron_schedule
  type     = "SCHEDULED"

  actions {
    job_name = aws_glue_job.compaction_etl_job.name
  }

  tags = var.tags
}

resource "aws_glue_trigger" "compaction_etl_end" {
  name          = "${var.prefix}-trigger-crawler"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.compaction_etl.name

  predicate {
    conditions {
      job_name = aws_glue_job.compaction_etl_job.name
      state    = "SUCCEEDED"
    }
  }

  actions {
    crawler_name = var.crawler_name
  }

  tags = var.tags
}

## ETL Job ##
resource "aws_glue_job" "compaction_etl_job" {
  command {
    script_location = local.script_location
    python_version  = 3
  }

  default_arguments = {
    "--job-language"        = "python"
    "--job-bookmark-option" = "job-bookmark-disable"
  }

  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  glue_version      = var.glue_version
  max_retries       = var.max_retries
  timeout           = var.job_timeout
  name              = "${var.prefix}-compaction-etl-job"
  number_of_workers = var.number_of_workers
  worker_type       = var.worker_type
  role_arn          = var.role_arn
  tags              = var.tags
}
