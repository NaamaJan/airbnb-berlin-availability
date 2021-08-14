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

I plan to examine the occupancy of the properties, according to the variables in the model.
In general, there are variables that I expect to have a high significant influence on the outcome.
For example, price, location (neighborhood), the distance to the city center, the size of the property, room type, reviews (especially review scores rating) and etc.

After creating a model which predicts the next quarter occupancy of the property, I plan to check whether a host can optimize the price (I will check whether an increase /decrease in price will affect the occupancy of the properties).




 
