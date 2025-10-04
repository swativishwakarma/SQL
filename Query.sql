
WITH rep_revenue AS (
    SELECT
          sales_rep,
          region,
          SUM(quantity * unit_price) AS total _revenue
    FROM dbo.sales_orders
    GROUP BY sales_rep, region
  ),
region_avg AS (
      SELECT
            region,
            AVG(total _revenue)  AS avg revenue,
            SUM(total _revenue)  AS region_total,
      FROM rep_revenue
      GROUP BY region
)
SELECT 
    r.sales_rep,
    r.region,
    r.total_revenue,
    ra.avg_revenue,
    CAST(100.0 * r.total_revenue/ra.region_total AS DECIMAL(5,2)) AS pct_of_region
  FROM rep_revenue r
  JOIN region_avg ra ON r.region= ra.region
  WHERE  r.total_revenue> ra.avg_revenue
  ORDER BY r.region, pct_of_region DESC;
