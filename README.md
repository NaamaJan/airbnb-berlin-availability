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

### 2- Exploratory Data Analysis.ipynb

A analysis of the detailed Berlin listings data. I am using visualizing and analyzing data to extract insights from the variables in the data.

In the beginning, I use descriptive statistics to explore the data, which can help describe the data set's basic features and obtain a summary of the data. 

Then, I perform Data Visualization analysis to provide an accessible way to see and understand trends, outliers, relationships, variability, patterns in data and to notice if there is a problem with data quality.

I intend to focus on the correlations and the differences between the variables in the data set and describe the target variable "booked_up_target", his distribution and its relationships with the variables.

Exploratory data analysis also helps us deriving new variables or perform variable transformations.

### 3 -Data cleansing
The data cleansing process includes the treatment of the data to achieve completeness and reduce the bias caused by errors in the data.

Data cleansing includes:

•	Handling outliers.

•	Handling missing values.


### 4- Feature Enrichment.ipynb

There are 3 ways to enrich the data:

•	Feature Extraction: obtaining new features from existing features.

•	Feature Engineering: transformation of raw data into features suitable for modeling.

•	Feature Transformation: transformation of data to improve the accuracy of the algorithm.



### 5 - Feature Selection.ipynb

Selection of features is based on voting, using techniques of univariate and multivariate.  

Making a table with all the variables on the dataset and indicate the recommended variables for each technique. 

After that selecting a threshold for the total voting and on this basis we select the variables that will be used to train our models.


### 6 - Train-Dev-Test preparation and Model Selection

Divide the dataset to train, dev and test partition (test partition will be set aside and will not be used until the end of the notebook). 

The train dataset will be used to train the models, while the development dataset will be used for assessment of the model performance (using AUC as the performance measurement).

Running many different prediction models, without changing their parameters and checking model performance using AUC metric. 

Selecting the best performing model and fine tunining it. 

After fine tunning checking the performance on test partition. 


### 7 - Data Retrieval Protocol Helper

This notbook assists filling out "Data Retrieval Protocol.xlsx". For each source of data we get datafarme which desribe the features (and dumping the results to 'data_retrieval_protocol_helper.csv'). Using this csv for cutting results from it to "Data Retrieval Protocol.xlsx". This notbook support the following columns:

•	"Feature name"

•	"Source"

•	"Unique count"

•	"Min"

•	"Max"

•	"Notes"
