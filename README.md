# Terraform Glue ETL workflow

Terraform for creating a simple Scheduled workflow that runs the ETL job and then the crawler.

User can supply ETL script or can use Module provided ETL script if compaction of data aggregated over month is the use case.

If user doesn't supply `script_location` then module provided Compaction ETL script is used.
It does compaction of all input data (orc or parquet) at end of month.

If module supplied compaction ETL script is to used,  It needs:
- `datalake_bucket` and `datalake_prefix` if any.
- `datalake_format`, it can be either 'orc' or 'parquet'
- Optional partition size
- The script expects the datasets under 'year=yyyy/month=mm'