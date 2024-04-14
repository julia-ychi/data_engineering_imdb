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
    genres_split.genre,
    rating.average_rating,
    rating.num_votes
from {{ ref('stg_title_basics') }} title
left join genres_split
on title.movie_id = genres_split.movie_id
left join {{ ref('stg_title_ratings') }} rating
on title.movie_id = rating.movie_id