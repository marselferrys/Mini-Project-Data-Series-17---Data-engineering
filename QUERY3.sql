SELECT
  payment_type,
  AVG(fare) AS average_fare,
  AVG(tips) AS average_tips,
  AVG(tolls) AS average_tolls
FROM
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE EXTRACT(YEAR FROM trip_start_timestamp) = 2019
GROUP BY
  payment_type
ORDER BY
  payment_type
