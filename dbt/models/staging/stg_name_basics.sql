{{
    config(
        materialized='view'
    )
}}

select 
    nconst as name_id,
    primaryName as primary_name,
    case when birthYear = '\\N' then null 
        else {{ dbt.safe_cast("birthYear", api.Column.translate_type("integer")) }} 
        end as birth_year,
from {{ source('staging', 'name_basics') }}

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}