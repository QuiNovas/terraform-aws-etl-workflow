variable "prefix" {
  description = "Pefix resource names"
  type        = string
}

variable "script_location" {
  description = "User supplied script path on S3"
  type        = string
  default     = ""
}

variable "script_s3_bucket" {
  description = "S3 bucket name to upload module supplied etl script"
  type        = string
  default     = ""
}

variable "datalake_bucket" {
  description = "S3 bucket name that etl job is performed upon"
  type        = string
  default     = ""
}

variable "datalake_prefix" {
  description = "S3 bucket prefix that etl job is performed upon"
  type        = string
  default     = ""
}

variable "datalake_input_type" {
  description = "The format of input data. ORC or Parquet"
  type        = string
}

variable "crawler_name" {
  description = "The name of the crawler that needs to be executed at end of the workflow"
  type        = string
}

variable "job_timeout" {
  description = "The job timeout in minutes. The default is 2880 minutes (48 hours)."
  type        = number
  default     = 2880
}

variable "role_arn" {
  description = "The glue service role arn that ETL Job assumes. Needs access to the S3 datalake"
  type        = string
}

variable "number_of_workers" {
  description = "The number of workers of a defined workerType that are allocated when a job runs."
  type        = number
  default     = "2"
}

variable "worker_type" {
  description = "The type of predefined worker that is allocated when a job runs. Accepts a value of Standard, G.1X, or G.2X"
  type        = string
  default     = "G.1X"
}

variable "glue_version" {
  description = "The version of glue to use"
  type        = string
  default     = "2.0"
}

variable "max_concurrent_runs" {
  description = "The maximum number of concurrent runs allowed for a job. The default is 1"
  type        = number
  default     = 1
}

variable "max_retries" {
  description = "The maximum number of times to retry this job if it fails"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Key-value map of resource tags"
  type        = map
  default     = {}
}

variable "cron_schedule" {
  description = "CRON for scheduling the workflow. Defaults to 12AM first of every month"
  type        = string
  default     = "cron(00 00 1 * ? *)" #First of every month at 12AM
}
