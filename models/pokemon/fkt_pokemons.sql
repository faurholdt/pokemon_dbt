{{ config(materialized='table') }}

with types as (
    select * FROM {{ ref('pokemon_types') }}
),

games as (
    select distinct id FROM {{ ref('pokemons_in_games') }}
    where game_name in ('red', 'blue', 'leafgreen', 'white')
)

select 
INITCAP(base.name) as name,
base.id,
base.base_experience,
base.weight,
base.height,
ROUND((cast(base.weight as decimal) / 10) / ((cast(base.height as decimal) / 10) * (cast(base.height as decimal) / 10)), 2) as bmi,
base.order,
types.primary_type_name,
types.secondary_type_name,
cast(base.sprites.front_default as varchar) as front_default_sprite
from {{ ref("stg_pokemons") }} base
join games on games.id = base.id
join types on types.id = base.id
order by base.id asc