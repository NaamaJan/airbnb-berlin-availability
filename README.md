# airbnb-berlin-availability
## Introduction

For this project, I decided to choose the Airbnb Berlin dataset. The dataset can be found on Kaggle:
https://www.kaggle.com/brittabettendorf/berlin-airbnb-data

Airbnb is an online marketplace where people can offer and rent out their houses and apartments (properties).
Airbnb became extremely successful for tourists and business people, who are looking for overnight accommodation.

The datasets are based on properties list with description (features) and information whether the properties are being rented in each day from November 2018 until November 2019.

The project goal is predicting the probability of the properties to be rented in the next 3 months. Defining the outcome variable as booked if there are at least 70 rented days in the 3 months following every month.

The outcome variable is the "booked up" state of the following 3 months for each month starting in March until August (the first prediction starts in March since I'm using November-February for training. August is the last month since the last prediction is from August until November).
I define the booked-up variable as a binary variable where it's set to 1 if at least 70 out of 90 days are booked and 0 otherwise.

I examine the occupancy of the properties, according to the variables in the model.
In general, there are variables that I expect to have a high significant influence on the outcome.
For example, price, location (neighborhood), the distance to the city center, the size of the property, room type, reviews (especially review scores rating) and etc.

## Data

The main datasets are based on properties list with description (features) and information whether a property is being rented in each day from November 2018 until November 2019 (every record describes property in a day).

As mentioned in the introduction, our target is predicting whether a property will be rented in the next 3 months (defining the booked_up_target base on occupancy of the property).  

These datasets are taken from Kaggle and ensembled from 6 different csv files:

•	Calendar Summary

•	Listings Detailed

•	Listings Summary

•	Neighborhoods

•	Reviews Detailed

•	Reviews Summary

For enrichening the main data sources, I used climatestotravel website for getting average weather data. Assuming that weather info can influence on tourism in Berlin which can directly influence the demand for properties. 

Importing the following datasets from this website:

•	Sunshine hours

•	Average precipitation

•	Average temperatures


## SQL (prepparing the data):

Using SQL for creating flat table in SQL Server:

•	sql/train-target.sql

•	sql/flat-file.sql

## Notebooks:

### 1- Addition to Flat file.ipynb
Most of the variables have been added in the SQL section, but for adding some variables we need python. 

I add these variables in this section, that these variables will be available in EDA and Data cleansing.
 
This pre-EDA section.

 
