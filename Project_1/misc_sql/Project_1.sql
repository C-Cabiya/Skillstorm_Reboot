-- USE NOTES -- 
--	1 = AMZN
--	4 = NFLX
--	5 = BIP
--	6 = TSLA

USE stock_project;
GO
SELECT * 
INTO forex_months
FROM( SELECT FORMAT(forex_date,'MM') forex_month, AVG(forex_open_price) forex_average
FROM forex_table
GROUP BY FORMAT(forex_date,'MM')) as forex_months

-- Questions -- 
-- Were predictions for heavy-hitters (Netflix, Amazon) correct?
-- What time of year were people buying the most (meaning the most transactions/highest volume)?
-- Is there one stock on here that looks more reliable than the others?

-- Used to make amazon_, bip_, netflix_, and tesla_interest_over_time
SELECT * 
INTO tesla_interest_over_time
FROM (SELECT dates_date, dates_month, dates_year, volume, vwap, transactions
		FROM fact_table JOIN dates_table on fact_date_id = date_id
		WHERE fact_stock_id = 6) AS tesla_interest_over_time;

-- Possible further research; which is the best indicator for price over time
-- Used to make amazon_, bip_, netflix_, and tesla_price_over_time
SELECT * 
INTO tesla_price_over_time
FROM (SELECT dates_date, open_price, close_price, highest_price, lowest_price
	FROM fact_table JOIN dates_table on date_id = fact_date_id
	WHERE fact_stock_id = 6) AS tesla_price_over_time

SELECT * 
From forex_table
WHERE FORMAT(forex_date, 'yyyy-MM-dd') = '2024-01-01'

-- Random -- -- IRRELEVANT -- -- Maybe get rid of --
-- Possible for further research; the etfs have the least fluctuation in variance compared to our stocks (which makes sense)
SELECT FORMAT(dates_date,'yyyy-MM'), VAR(vwap), STDEV(vwap) from Fact_table JOIN dates_table ON date_id = fact_date_id GROUP BY FORMAT(dates_date,'yyyy-MM'), fact_stock_id

select TOP 1 * from amazon_price_over_time ORDER BY dates_date DESC
select TOP 1 * from bip_price_over_time ORDER BY dates_date DESC
select TOP 1 * from tesla_price_over_time ORDER BY dates_date DESC
select TOP 1 * from netflix_price_over_time ORDER BY dates_date DESC
select TOP 1 * from vti_prices_over_time ORDER BY dates_date DESC
select TOP 1 * from vym_prices_over_time ORDER BY dates_date DESC

select  vol_stock_id, beta, sharpe from stock_volatility_table
WHERE forex_percent_inc = (SELECT MAX(forex_percent_inc)
							FROM forex_table)


DROP TABLE moving_averages

CREATE TABLE moving_averages(
	moving_avg_id INT PRIMARY KEY IDENTITY,
	dates_date DATETIME, 
	ten_day_amazon DECIMAL(18,2),
	hundred_day_amazon DECIMAL(18,2),
	ten_day_bip DECIMAL(18,2),
	hundred_day_bip DECIMAL(18,2),
	ten_day_tesla DECIMAL(18,2),
	hundred_day_tesla DECIMAL(18,2),
	ten_day_netflix DECIMAL(18,2),
	hundred_day_netflix DECIMAL(18,2),
	ten_day_vti DECIMAL(18,2),
	hundred_day_vti DECIMAL(18,2),
	ten_day_vym DECIMAL(18,2),
	hundred_day_vym DECIMAL(18,2),
	ten_day_market DECIMAL(18,2),
	hundred_day_market DECIMAL(18,2),
	ten_day_price DECIMAL(18,2),
	hundred_day_price DECIMAL(18,2)
)

INSERT INTO moving_averages
SELECT a.dates_date, 
AVG(a.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(a.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(b.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(b.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(t.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(t.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(n.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(n.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(vti.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING), 
AVG(vti.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(vyu.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(vyu.open_price) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(market_open_value) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(market_open_value) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING),
AVG(price_open_value) OVER (ORDER BY a.dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING),
AVG(price_open_value) OVER (ORDER BY a.dates_date ROWS BETWEEN 50 PRECEDING AND 49 FOLLOWING)
FROM 
(amazon_price_over_time a JOIN bip_price_over_time b 
ON a.dates_date = b.dates_date
JOIN tesla_price_over_time t ON a.dates_date = t.dates_date
JOIN netflix_price_over_time n ON t.dates_date = n.dates_date
JOIN vti_prices_over_time vti on vti.dates_date = n.dates_date
JOIN vym_prices_over_time vyu ON vyu.dates_date = vti.dates_date
JOIN market_index_growth m ON t.dates_date = m.market_index_date
JOIN price_index_growth p ON p.price_index_date = m.market_index_date)

SELECT * FROM investment_table


FROM 
(amazon_price_over_time a JOIN bip_price_over_time b 
ON a.dates_date = b.dates_date
JOIN tesla_price_over_time t ON a.dates_date = t.dates_date
JOIN netflix_price_over_time n ON t.dates_date = n.dates_date
JOIN vti_prices_over_time vti on vti.dates_date = n.dates_date
JOIN vym_prices_over_time vyu ON vyu.dates_date = vti.dates_date)

ALTER

SELECT dates_date FROM amazon_price_over_time 
LEFT JOIN market_index_growth on dates_date = market_index_date

SELECT dates_date, AVG(open_price) OVER (ORDER BY dates_date ROWS BETWEEN 5 PRECEDING AND 4 FOLLOWING)
FROM amazon_price_over_time

INSERT INTO moving_averages
SELECT 