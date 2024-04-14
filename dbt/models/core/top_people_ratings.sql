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
    movies.start_year as year,
    count(1) as movie_count, 
    round(avg(ratings.average_rating), 2) as avg_rating, 
    cast(floor(avg(ratings.num_votes)) as integer) as avg_votes
from {{ ref('stg_title_basics') }} as movies
join title_split 
on movies.movie_id = title_split.title_id
join {{ ref('stg_name_basics') }} as people 
on people.name_id = title_split.name_id
join {{ ref('stg_title_ratings') }} as ratings 
on movies.movie_id = ratings.movie_id
group by people.primary_name, movies.start_year
order by avg_rating desc, avg_votes desc