{{
    config(
        materialized='view'
    )
}}

select 
    tconst as movie_id,
    primaryTitle as primary_title,
    case when startYear = '\\N' then null 
        else {{ dbt.safe_cast("startYear", api.Column.translate_type("integer")) }} 
        end as start_year,
    case when runtimeMinutes = '\\N' then null 
        else {{ dbt.safe_cast("runtimeMinutes", api.Column.translate_type("integer")) }} 
        end as runtime_minutes,
    case when genres = '\\N' then null else SPLIT(genres, ',') end as genres
from {{ source('staging', 'title_basics') }}

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}