variable "credentials" {
  description = "My Credentials"
  default     = "./key/my-creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./key/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "big-cargo-412019"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "us-east5-a"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "imdb_new_yuyuan"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "imdb-bucket-new-yuyuan"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
