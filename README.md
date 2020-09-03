# Terraform Glue ETL workflow

Terraform for creating a simple Scheduled workflow that runs the ETL job and then the crawler.
User can supply ETL script or can use Module provided ETL script if compaction of data aggregated over month is the use case.
It does compaction of all input data (orc or parquet) at end of month. It will be used when user supplied `script_location` is empty.

If module supplied compaction ETL script is to used,  It needs:
- `datalake_bucket` and `datalake_prefix` if any.
- `datalake_format`, it can be either 'orc' or 'parquet'
- Optional partition size
- The script excepts the datasets under 'year=yyyy/month=mm'