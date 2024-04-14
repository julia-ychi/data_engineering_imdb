{{
    config(
        materialized='view'
    )
}}

select 
    tconst as movie_id,
    cast(averageRating as numeric) as average_rating,
    {{ dbt.safe_cast("numVotes", api.Column.translate_type("integer")) }}  as num_votes
from {{ source('staging', 'title_ratings') }}

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}