-- 取新渠道订单均价P50、P80、P90 
with ord as (
select 
sales_channel_name,
shop_abbr,
currency,
sku,
round(sum(sales_amt)/sum(sales_cnt),2) as avg_price
from dwd_sales_order_report 
where purchase_date_local >='2026-01-01'
and purchase_date_local <='2026-04-30'
and sales_country ='US'
group by 1,2,3,4
)
SELECT
    sales_channel_name,
    shop_abbr,
    currency,
    PERCENTILE(avg_price, 0.5) AS p50_price,
    PERCENTILE(avg_price, 0.8) AS p80_price,
    PERCENTILE(avg_price, 0.9) AS p90_price
FROM ord
group by 1,2,3