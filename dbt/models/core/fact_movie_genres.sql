{{
    config(
        materialized='table'
    )
}}

with genres_split as (
    select title.movie_id, genre
    from {{ ref('stg_title_basics') }} as title
    cross join unnest(genres) as genre
)

select title.primary_title,
    title.start_year,
    genres_split.genre
from {{ ref('stg_title_basics') }} title
left join genres_split
on title.movie_id = genres_split.movie_id