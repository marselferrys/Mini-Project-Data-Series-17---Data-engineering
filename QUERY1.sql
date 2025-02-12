WITH trip_data AS (
  SELECT
    trip_seconds,
    EXTRACT(DAYOFWEEK FROM TIMESTAMP(trip_start_timestamp)) AS day_of_week
  FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE trip_seconds IS NOT NULL
)
SELECT
  CASE
    WHEN day_of_week = 2 THEN 'Monday'
    WHEN day_of_week = 7 THEN 'Saturday'
  END AS day_name,
  COUNT(*) AS trip_count,
  ROUND(AVG(trip_seconds), 2) AS avg_duration,
  ROUND(APPROX_QUANTILES(trip_seconds, 2)[OFFSET(1)], 2) AS median_duration,
  ROUND(STDDEV(trip_seconds), 2) AS stddev_duration
FROM trip_data
WHERE day_of_week IN (2, 7)
GROUP BY day_of_week
ORDER BY day_of_week;
