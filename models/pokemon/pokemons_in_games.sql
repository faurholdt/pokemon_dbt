{{ config(materialized='view') }}

SELECT t.id, t.name, CAST(ga.version.name as varchar) as game_name
FROM {{ ref("stg_pokemons") }} t, t.game_indices ga