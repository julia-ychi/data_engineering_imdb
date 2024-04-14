{{
    config(
        materialized='table'
    )
}}

with title_split as (
    select name.name_id, title_id
    from {{ ref('stg_name_basics') }} as name
    cross join unnest(known_for_titles) as title_id
)

select people.primary_name as name,
    movie.primary_title as movie_title,
    movie.start_year as year,
    rating.average_rating,
    rating.num_votes
from {{ ref('stg_title_basics') }} as movie
join title_split
on movie.movie_id = title_split.title_id
join {{ ref('stg_name_basics') }} as people
on title_split.name_id = people.name_id
join {{ ref('stg_title_ratings') }} as rating 
on movie.movie_id = rating.movie_id