{{ config(materialized="table") }}

with
    title_split as (
        select name.name_id, title_id
        from {{ ref("stg_name_basics") }} as name
        cross join unnest(known_for_titles) as title_id
    )

select *
from
    (
        select
            *,
            rank() over (
                partition by start_year order by avg_rating desc, total_votes desc
            ) as ranking_num
        from
            (
                select
                    people.primary_name as name,
                    movies.start_year as start_year,
                    count(1) as movie_count,
                    round(avg(ratings.average_rating), 2) as avg_rating,
                    sum(ratings.num_votes) as total_votes
                from title_split
                join
                    {{ ref("stg_title_basics") }} as movies
                    on movies.movie_id = title_split.title_id
                join
                    {{ ref("stg_name_basics") }} as people
                    on people.name_id = title_split.name_id
                join
                    {{ ref("stg_title_ratings") }} as ratings
                    on movies.movie_id = ratings.movie_id
                group by people.primary_name, movies.start_year
            )
    )
where ranking_num <= 20
