
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
t.listing_id,
t.target_start_date_period, t.target_end_date_period, 
t.target_num_of_day_in_period, t.target_num_of_booked_days,
CASE
WHEN t.target_num_of_booked_days/t.target_num_of_day_in_period >0.833 THEN 1 ELSE 0 END AS booked_up_target,
t.target_avg_dollar_price_in_period,
t.start_date_period as start_date_previous_period , t.end_date_period as end_date_previous_period, t.num_of_day_in_period as num_of_day_in_previous_period, t.num_of_booked_days as num_of_booked_days_in_previous_period,
round(CAST((t.num_of_booked_days) AS FLOAT)/CAST((t.num_of_day_in_period) AS FLOAT),2) AS occupancy_last_period,
t.avg_dollar_price_in_period as avg_dollar_price_in_previous_period,
a.host_id,
a.neighbourhood_group,
CASE
WHEN a.neighbourhood_group='Charlottenburg-Wilm.' THEN 1
WHEN a.neighbourhood_group='Reinickendorf' THEN 2
WHEN a.neighbourhood_group='Steglitz - Zehlendorf' THEN 3
WHEN a.neighbourhood_group='Spandau' THEN 4
WHEN left(a.neighbourhood_group,9)='Tempelhof' THEN 5
WHEN left(a.neighbourhood_group,7)='Treptow' THEN 6
WHEN a.neighbourhood_group='Mitte' THEN 7
WHEN a.neighbourhood_group='Friedrichshain-Kreuzberg' THEN 8
WHEN a.neighbourhood_group='Marzahn - Hellersdorf' THEN 9
WHEN left(a.neighbourhood_group,4)='Neuk' THEN 10
WHEN a.neighbourhood_group='Pankow' THEN 11
WHEN a.neighbourhood_group='Lichtenberg' THEN 12
ELSE 0 END AS neighbourhood_group_id,
a.latitude, a.longitude, a.room_type,
CASE
WHEN a.room_type='Shared room' THEN 1
WHEN a.room_type='Private room' THEN 2
ELSE 3 END AS room_type_id,
a.price, a.minimum_nights, a.number_of_reviews, a.last_review,
DATEDIFF(DAY,a.last_review,GETDATE()) AS DaysPassed_last_review,
a.reviews_per_month, a.calculated_host_listings_count, a.availability_365,
b.full_booked,
c.summary,
CASE
WHEN c.summary is not null then 1
ELSE 0 END AS is_summary,
c.[space],
CASE
WHEN c.[space] is not null then 1
ELSE 0 END AS is_space,
c.description,
CASE
WHEN c.description is not null then 1
ELSE 0 END AS is_description,
c.notes,
CASE
WHEN c.notes is not null then 1
ELSE 0 END AS is_notes,
c.transit,
CASE
WHEN c.transit is not null then 1
ELSE 0 END AS is_transit,
c.access,
CASE
WHEN c.access is not null then 1
ELSE 0 END AS is_access,
c.interaction,
CASE
WHEN c.interaction is not null then 1
ELSE 0 END AS is_interaction,
c.house_rules,
CASE
WHEN c.house_rules is not null then 1
ELSE 0 END AS is_house_rules,
neighborhood_overview,
CASE
WHEN c.neighborhood_overview is not null then 1
ELSE 0 END AS is_neighborhood_overview,
host_about,
CASE
WHEN c.host_about is not null then 1
ELSE 0 END AS is_host_about,
c.host_since,
DATEDIFF(DAY,c.host_since ,GETDATE()) AS DaysPassed_host_since,
c.host_location, 
CASE
WHEN c.host_location ='Berlin, Berlin, Germany' then 1 else 0 end as host_location_is_berlin,
c.host_response_time,
CASE
WHEN host_response_time='within an hour' THEN 1
WHEN host_response_time='within a few hours' THEN 2
WHEN host_response_time='within a day' THEN 3
WHEN host_response_time='a few days or more' THEN 4
ELSE 5 END AS cat_host_response_time,
c.host_response_rate, c.host_acceptance_rate, c.xl_picture_url,	 c.medium_url, c.thumbnail_url,		
CASE
WHEN host_response_rate>0.8 THEN 1
WHEN host_response_rate>0.6 THEN 2
WHEN host_response_rate>0.4 THEN 3
WHEN host_response_rate>0.2 THEN 4
WHEN host_response_rate>0.01 THEN 5
ELSE 6 END AS cat_host_response_rate,
c.host_is_superhost,
CASE 
WHEN c.host_is_superhost='t' THEN 1
ELSE 0 END AS cat_host_is_superhost,
c.host_neighbourhood,
c.host_total_listings_count,
c.host_verifications,
c.host_has_profile_pic,
CASE 
WHEN c.host_has_profile_pic='t' THEN 1
ELSE 0 END AS cat_host_has_profile_pic,
c.host_identity_verified,
CASE 
WHEN c.host_identity_verified='t' THEN 1
ELSE 0 END AS cat_host_identity_verified,
c.street,
CASE
WHEN c.street ='Berlin, Berlin, Germany' then 1 else 0 end as street_is_berlin,
c.neighbourhood,c.neighbourhood_cleansed,c.city, c.[state], c.zipcode,
c.smart_location,
CASE
WHEN c.smart_location ='Berlin, Germany' then 1 else 0 end as smart_location_is_berlin,
c.market,c.country_code, c.country, 
c.is_location_exact,
CASE 
WHEN c.is_location_exact='t' THEN 1
ELSE 0 END AS cat_is_location_exact,
c.property_type,
CASE
WHEN c.property_type ='Apartment' then 1 else 0 end as is_Apartment,
c.accommodates, c.bathrooms, c.bedrooms, c.beds,
c.bed_type,
CASE
WHEN c.bed_type='Futon' THEN 1
WHEN c.bed_type='Pull-out Sofa' THEN 2
WHEN c.bed_type='Couch' THEN 3
WHEN c.bed_type='Airbed' THEN 4
ELSE 5 END AS cat_bed_type,
CASE
WHEN c.bed_type ='Real Bed' then 1 else 0 end as is_Real_Bed,
c.amenities, c.square_feet, c.weekly_price,
c.monthly_price,
c.security_deposit,
CASE 
WHEN c.security_deposit=$0.00 THEN '0'
WHEN c.security_deposit is null THEN 'missing'
ELSE '1' END AS is_security_deposit,
c.cleaning_fee,
CASE 
WHEN c.cleaning_fee=$0.00 THEN '0'
WHEN c.cleaning_fee is null THEN 'missing'
ELSE '1' END AS is_cleaning_fee,
c.guests_included, c.extra_people,
CASE 
WHEN c.extra_people=$0.00 THEN '0'
WHEN c.extra_people is null THEN 'missing'
ELSE '1' END AS is_extra_people_fee,
c.maximum_nights, c.calendar_updated,
c.availability_30, c.availability_60, c.availability_90, 
c.first_review, 
DATEDIFF(DAY,c.first_review ,GETDATE()) AS DaysPassed_first_review,
c.review_scores_rating, c.review_scores_accuracy, c.review_scores_cleanliness,
c.review_scores_checkin, c.review_scores_communication, c.review_scores_location,
c.review_scores_value,
c.license,
CASE 
WHEN c.license is null THEN 0
ELSE 1 END AS is_license,
c.jurisdiction_names,
c.instant_bookable,
CASE 
WHEN c.instant_bookable='t' THEN 1
ELSE 0 END AS cat_instant_bookable,
c.is_business_travel_ready,
CASE 
WHEN c.is_business_travel_ready='t' THEN 1
ELSE 0 END AS cat_is_business_travel_ready,
c.require_guest_profile_picture,
CASE 
WHEN c.require_guest_profile_picture='t' THEN 1
ELSE 0 END AS cat_require_guest_profile_picture,
c.require_guest_phone_verification,
CASE 
WHEN c.require_guest_phone_verification='t' THEN 1
ELSE 0 END AS cat_require_guest_phone_verification,
c.cancellation_policy,
CASE
WHEN c.cancellation_policy='flexible' THEN 1
WHEN c.cancellation_policy='moderate' THEN 2
WHEN c.cancellation_policy='strict_14_with_grace_period' THEN 3
WHEN c.cancellation_policy='super_strict_60' THEN 4
ELSE 5 END AS cat_cancellation_policy,
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



