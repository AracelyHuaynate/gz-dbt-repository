WITH aggregated_campaigns AS (
    SELECT
        date_date,
        SUM(ads_cost) AS ads_cost,
        SUM(impression) AS ads_impressions,
        SUM(click) AS ads_clicks
    FROM {{ ref('int_campaigns') }}
    GROUP BY
        date_date

)

SELECT
    date_date,
    ads_cost,
    ads_impressions,
    ads_clicks
FROM aggregated_campaigns