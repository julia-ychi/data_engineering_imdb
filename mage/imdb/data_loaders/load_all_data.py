import os
import json
import pandas as pd
import subprocess
from kaggle.api.kaggle_api_extended import KaggleApi
from zipfile import ZipFile

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    # Import Kaggle credentials
    credentials_file = "/home/src/kaggle.json"  # Update with the path to your JSON file
    with open(credentials_file, "r") as f:
        kaggle_credentials = json.load(f)
    # Set the configuration for the Kaggle API
    api = KaggleApi()
    api.authenticate()
    # Define the destination directory where you want to save the downloaded file
    destination_directory = "/home/src/"  # Update with your desired directory
    
    datasets_files = [
    ("ashirwadsangwan/imdb-dataset", "name.basics.tsv"),
    ("ashirwadsangwan/imdb-dataset", "title.basics.tsv"),
    ("ashirwadsangwan/imdb-dataset", "title.principals.tsv"),
    ("ashirwadsangwan/imdb-dataset", "title.ratings.tsv")
]
    # kaggle datasets download -d ashirwadsangwan/imdb-dataset

    # Download and unzip each file
    for dataset, file_name in datasets_files:
        # Download the file
        command = f"kaggle datasets download {dataset} -f {file_name} -p {destination_directory}"
        subprocess.run(command, shell=True)
        # Unzip the downloaded file
        zip_file_path = os.path.join(destination_directory, f"{file_name}.zip")
        with ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(destination_directory)
        # Remove the zip file after extraction
        os.remove(zip_file_path)
    return "Loaded successfully from Kaggle!"


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
