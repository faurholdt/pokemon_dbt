{{ config(materialized='table') }}
SELECT * FROM public.stg_pokemons