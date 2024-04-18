CREATE OR REPLACE EXTERNAL TABLE `<project-id>.<bq-dataset-name>.name_basics_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<gcs-bucket-name>/name.basics.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE `<project-id>.<bq-dataset-name>.title_basics_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<gcs-bucket-name>/title.basics.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE `<project-id>.<bq-dataset-name>.title_ratings_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<gcs-bucket-name>/title.ratings.parquet']
);

CREATE OR REPLACE TABLE `<project-id>.<bq-dataset-name>.name_basics`
CLUSTER BY birthYear
AS SELECT * FROM `<project-id>.<bq-dataset-name>.name_basics_external`;

CREATE OR REPLACE TABLE `<project-id>.<bq-dataset-name>.title_basics`
CLUSTER BY startYear
AS SELECT * FROM `<project-id>.<bq-dataset-name>.title_basics_external`;

CREATE OR REPLACE TABLE `<project-id>.<bq-dataset-name>.title_ratings`
AS SELECT * FROM `<project-id>.<bq-dataset-name>.title_ratings_external`;