CREATE OR REPLACE EXTERNAL TABLE `big-cargo-412019.imdb.name_basics_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://imdb_bucket_de_zoomcamp/name.basics.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE `big-cargo-412019.imdb.title_basics_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://imdb_bucket_de_zoomcamp/title.basics.parquet']
);

CREATE OR REPLACE EXTERNAL TABLE `big-cargo-412019.imdb.title_ratings_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://imdb_bucket_de_zoomcamp/title.ratings.parquet']
);

CREATE OR REPLACE TABLE `big-cargo-412019.imdb.name_basics`
CLUSTER BY birthYear
AS SELECT * FROM `big-cargo-412019.imdb.name_basics_external`;

CREATE OR REPLACE TABLE `big-cargo-412019.imdb.title_basics`
CLUSTER BY startYear
AS SELECT * FROM `big-cargo-412019.imdb.title_basics_external`;

CREATE OR REPLACE TABLE `big-cargo-412019.imdb.title_ratings`
AS SELECT * FROM `big-cargo-412019.imdb.title_ratings_external`;