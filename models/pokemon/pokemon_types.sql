{{ config(materialized='view') }}

SELECT *
FROM (
  SELECT 
  t.id,
  CAST(type.type.name as varchar) type_name,
  type.slot as type_slot
  FROM {{ ref("stg_pokemons") }} t, t.types type
  WHERE type.slot in (1, 2)
 ) pokemon_types
 PIVOT (max(type_name) AS name for type_slot in (1 as primary_type, 2 as secondary_type)) as pivot_table