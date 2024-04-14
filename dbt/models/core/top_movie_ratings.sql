{{
    config(
        materialized='table'
    )
}}

select *
from
(
    select title.primary_title as movie_title,
        title.start_year as release_year,
        ratings.average_rating, 
        ratings.num_votes,
        rank() over (partition by title.start_year order by ratings.average_rating desc, ratings.num_votes desc) as ranking_num
    from {{ ref('stg_title_basics') }} as title
    join {{ ref('stg_title_ratings') }} as ratings
    on ratings.movie_id = title.movie_id
)
where ranking_num <= 20