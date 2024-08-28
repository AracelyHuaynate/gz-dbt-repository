WITH aggregated_campaigns AS (
    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        SUM(ads_cost) AS total_ads_cost,
        SUM(impression) AS total_impressions,
        SUM(click) AS total_clicks
    FROM {{ ref('int_campaigns') }}
    GROUP BY
        date_date,
        paid_source,
        campaign_key,
        campaign_name
)

SELECT
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    total_ads_cost,
    total_impressions,
    total_clicks
FROM aggregated_campaigns