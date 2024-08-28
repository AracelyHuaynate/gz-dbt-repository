WITH combined_campaigns AS (
  {{ dbt_utils.union_relations(
    relations=[
      ref('stg_raw__raw_gz_adwords'),
      ref('stg_raw__raw_gz_bing'),
      ref('stg_raw__raw_gz_criteo'),
      ref('stg_raw__raw_gz_facebook')
    ]
  ) }}
)

SELECT *
FROM combined_campaigns

