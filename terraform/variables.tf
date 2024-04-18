
variable "project" {
  description = "Project ID"
  default     = "<CHANGE VALUE HERE>"  #"big-cargo-412019"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "<CHANGE VALUE HERE>"  #"us-east5-a"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "<CHANGE VALUE HERE>"  #"US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "<CHANGE VALUE HERE>"  #"imdb_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "<CHANGE VALUE HERE>"  #"imdb-bucket-412019"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
