import os
import pandas as pd
import dask.dataframe as dd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    """
    Template code for loading data from any source.

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your data loading logic here
    filename = '/home/src/title.basics.tsv'
    # selected_cols = ['tconst', 'titleType', 'primaryTitle', 'startYear', 'runtimeMinutes', 'genres']
    chunksize = 10 ** 6
    list_df = []
    with pd.read_csv(filename, chunksize=chunksize, sep='\t', low_memory=False) as reader:
        for chunk in reader:
            list_df.append(chunk)
    return pd.concat(list_df)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
