--Content
--dbo.calendar_summary were scraped on November 07th, 2018 untill November 06th, 2019 review calendar data of  Airbnb listings in Berlin.

-- enrich dbo.calendar_summary table with 2 new variables: 
--1. is_day_booked (the opposite from available)
--2. dollar_price (without $ sign)

SELECT *, CASE WHEN available='f' THEN 1  WHEN available='t' THEN 0 ELSE NULL END AS is_day_booked,
		TRY_PARSE(price as money) as dollar_price INTO db01.calendar_summary_enrich FROM dbo.calendar_summary 

-- Rolling windows tables

SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_02_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-02-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_03_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-03-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_04_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-04-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_05_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-05-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_06_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-06-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_07_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-07-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_till_2019_08_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date) <  CAST('2019-08-01' as date)
GROUP BY listing_id

--target tables

SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_02_01_till_2019_05_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-02-01' as date) AND CAST([date] as date)< CAST('2019-05-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_03_01_till_2019_06_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-03-01' as date) AND CAST([date] as date)< CAST('2019-06-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_04_01_till_2019_07_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-04-01' as date) AND CAST([date] as date)< CAST('2019-07-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_05_01_till_2019_08_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-05-01' as date) AND CAST([date] as date)< CAST('2019-08-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_06_01_till_2019_09_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-06-01' as date) AND CAST([date] as date)< CAST('2019-09-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_07_01_till_2019_10_01
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-07-01' as date) AND CAST([date] as date)< CAST('2019-10-01' as date)
GROUP BY listing_id


SELECT listing_id, SUM(is_day_booked) as num_of_booked_days, 
				   MIN(CAST([date] as date)) as start_date_period, 
				   MAX(CAST([date] as date)) as end_date_period, 
				   DATEDIFF(day,MIN(CAST([date] as date)), MAX(CAST([date] as date)))+1 as num_of_day_in_period,
				   AVG(dollar_price) as avg_dollar_price_in_period
INTO db01.agg_2019_08_01_till_2019_11_09
FROM db01.calendar_summary_enrich
WHERE CAST([date] as date)>= CAST('2019-08-01' as date) AND CAST([date] as date)< CAST('2019-11-09' as date)
GROUP BY listing_id


-- creating train and test in the same tables

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_02_01_till_2019_05_01
FROM [db01].[agg_till_2019_02_01] as train
LEFT JOIN [db01].[agg_2019_02_01_till_2019_05_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_02_01_till_2019_05_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_03_01_till_2019_06_01
FROM [db01].[agg_till_2019_03_01] as train
LEFT JOIN [db01].[agg_2019_03_01_till_2019_06_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_03_01_till_2019_06_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_04_01_till_2019_07_01
FROM [db01].[agg_till_2019_04_01] as train
LEFT JOIN [db01].[agg_2019_04_01_till_2019_07_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_04_01_till_2019_07_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_05_01_till_2019_08_01
FROM [db01].[agg_till_2019_05_01] as train
LEFT JOIN [db01].[agg_2019_05_01_till_2019_08_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_05_01_till_2019_08_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_06_01_till_2019_09_01
FROM [db01].[agg_till_2019_06_01] as train
LEFT JOIN [db01].[agg_2019_06_01_till_2019_09_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_06_01_till_2019_09_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_07_01_till_2019_10_01
FROM [db01].[agg_till_2019_07_01] as train
LEFT JOIN [db01].[agg_2019_07_01_till_2019_10_01] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id

select * from db01.train_test_2019_07_01_till_2019_10_01

SELECT train.listing_id,  train.start_date_period, train.end_date_period, train.num_of_day_in_period, train.num_of_booked_days, train.avg_dollar_price_in_period,
test.start_date_period as target_start_date_period, test.end_date_period as target_end_date_period, 
test.num_of_day_in_period as target_num_of_day_in_period, test.num_of_booked_days as target_num_of_booked_days,  test.avg_dollar_price_in_period as target_avg_dollar_price_in_period
INTO db01.train_test_2019_08_01_till_2019_11_09
FROM [db01].[agg_till_2019_08_01] as train
LEFT JOIN [db01].[agg_2019_08_01_till_2019_11_09] as test
ON train.listing_id = test.listing_id
ORDER BY listing_id


select * from db01.train_test_2019_08_01_till_2019_11_09

-- union all the periods tables

SELECT * 
INTO db01.train_test_all
FROM 
[db01].[train_test_2019_02_01_till_2019_05_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_03_01_till_2019_06_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_04_01_till_2019_07_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_05_01_till_2019_08_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_06_01_till_2019_09_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_07_01_till_2019_10_01]
UNION ALL
SELECT * FROM 
[db01].[train_test_2019_08_01_till_2019_11_09]
ORDER BY listing_id

select * from db01.train_test_all

