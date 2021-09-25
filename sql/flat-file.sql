
-- Content
--The datasets were scraped on November 07th, 2018 untill November 06th, 2019 and contain detailed listings data, review data and calendar data of current Airbnb listings in Berlin.
--The tables on the datasets:

select * from dbo.listings_summary$

select * from dbo.reviews_summary$

select * from dbo.listings$

select * from dbo.calendar_summary

select * from dbo.neighbourhoods

select * from dbo.reviews

select * from db01.train_test_all

-------------------------------------------------------------------------------------------------------------------------

--reviews_summary
--grouping the comments of the properties

select * from dbo.reviews_summary$


SELECT
     listing_id,
     STUFF(
         (SELECT DISTINCT '###' + comments
          FROM dbo.reviews_summary$
          WHERE listing_id = a.listing_id
          FOR XML PATH (''))
          , 1, 1, '')  AS concat_comments
into db01.comments
FROM dbo.reviews_summary$  AS a
GROUP BY listing_id ORDER BY listing_id


select * from db01.comments

-------------------------------------------------------------------------------------------------------------------------


--FINAL TABLE


SELECT 
t.listing_id, a.[name],
t.target_start_date_period, t.target_end_date_period, 
t.target_num_of_day_in_period, t.target_num_of_booked_days,
CASE
WHEN t.target_num_of_booked_days/t.target_num_of_day_in_period >0.833 THEN 1 ELSE 0 END AS booked_up_target,
t.target_avg_dollar_price_in_period,
t.start_date_period as start_date_previous_period , t.end_date_period as end_date_previous_period, t.num_of_day_in_period as num_of_day_in_previous_period, t.num_of_booked_days as num_of_booked_days_in_previous_period,
round(CAST((t.num_of_booked_days) AS FLOAT)/CAST((t.num_of_day_in_period) AS FLOAT),2) AS occupancy_last_period,
t.avg_dollar_price_in_period as avg_dollar_price_in_previous_period,
a.host_id, a.host_name, a.neighbourhood_group, a.neighbourhood,
a.latitude, a.longitude, a.room_type,
a.price, a.minimum_nights, a.number_of_reviews, a.last_review,
DATEDIFF(DAY,a.last_review,GETDATE()) AS DaysPassed_last_review,
a.reviews_per_month, a.calculated_host_listings_count, a.availability_365,
c.listing_url, c.scrape_id, c.last_scraped,		
c.summary,
c.[space],
c.description,
c.experiences_offered,
c.notes,
c.transit,
c.access,
c.interaction,
c.house_rules,
c.neighborhood_overview,
c.host_about,
c.host_since,
DATEDIFF(DAY,c.host_since ,GETDATE()) AS DaysPassed_host_since,
c.picture_url, c.host_url, 
c.host_location, 
c.host_response_time,
c.host_response_rate, 	
c.host_is_superhost,
c.host_thumbnail_url,
c.host_picture_url,
c.host_neighbourhood,
c.host_total_listings_count,
c.host_verifications,
c.host_has_profile_pic,
c.host_identity_verified,
c.street,
c.neighbourhood_cleansed, c.neighbourhood_group_cleansed,	
c.city, c.[state], c.zipcode, 
c.smart_location,
c.market,c.country_code, c.country, 
c.is_location_exact,
c.property_type,
c.accommodates, c.bathrooms, c.bedrooms, c.beds,
c.bed_type,
c.amenities, c.square_feet, c.weekly_price,
c.monthly_price,
c.security_deposit,
c.cleaning_fee,
c.guests_included, c.extra_people,
c.maximum_nights, c.calendar_updated, 
c.availability_30, c.availability_60, c.availability_90, 
c.first_review, 
DATEDIFF(DAY,c.first_review ,GETDATE()) AS DaysPassed_first_review,
c.calendar_last_scraped, 
c.review_scores_rating, c.review_scores_accuracy, c.review_scores_cleanliness,
c.review_scores_checkin, c.review_scores_communication, c.review_scores_location,
c.review_scores_value,
c.license,
c.instant_bookable,
c.is_business_travel_ready,
c.require_guest_profile_picture,
c.require_guest_phone_verification,
c.cancellation_policy,
e.concat_comments
INTO db01.FINAL_TABLE
FROM
db01.train_test_all as t
LEFT JOIN
dbo.listings$ as a
ON
t.listing_id=a.id
LEFT JOIN
db01.full_booked as b
ON 
a.id=b.listing_id
LEFT JOIN
dbo.listings_summary$ as c
ON
a.id=c.id
LEFT JOIN 
db01.booked_values as d
ON
a.id=d.listing_id
LEFT JOIN
db01.comments as e
ON
a.id=e.listing_id
ORDER BY a.id

select * from db01.FINAL_TABLE



DROP TABLE db01.FINAL_TABLE
