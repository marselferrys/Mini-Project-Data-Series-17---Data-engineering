WITH trip_data AS (
  SELECT
    pickup_community_area,
    dropoff_community_area,
    COUNT(*) AS trip_count
  FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE EXTRACT(YEAR FROM TIMESTAMP(trip_start_timestamp)) = 2023
    AND pickup_community_area IS NOT NULL
    AND dropoff_community_area IS NOT NULL
  GROUP BY pickup_community_area, dropoff_community_area
)
SELECT
  pickup_community_area,
  dropoff_community_area,
  trip_count
FROM trip_data
ORDER BY trip_count DESC
LIMIT 5;
