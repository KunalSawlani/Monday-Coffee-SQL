#  Monday Coffee SQL Analysis Project

##  Project Overview

This project is a SQL-based exploratory data analysis (EDA) built using a dataset representing a fictional coffee retail business — **Monday Coffee**. The goal is to extract business insights such as revenue trends, customer distribution, product performance, and city-based statistics from raw transactional and demographic data.

##  Dataset Description

The project uses four primary tables:

- **`city.csv`**: Contains data on city ID, name, population, rent, and rank.
- **`customers.csv`**: Customer details with references to city ID.
- **`products.csv`**: Product catalog including names and prices.
- **`sales.csv`**: Sales transactions with product and customer references, total amount, and customer rating.


##  SQL Analysis Performed

The project answers key business questions through a series of SQL queries:

1. **Estimated Coffee Consumers Per City**  
   Calculates the 25% coffee-consuming population across cities.

2. **Revenue by City in Q4 2023**  
   Aggregates sales by city during the last quarter of 2023.

3. **Product Order Volume**  
   Counts how many times each product was ordered.

4. **Average Sales Per Customer by City**  
   Computes average customer billing per city.

5. **Customer Demographics and Coffee Consumers**  
   Compares actual unique buyers with estimated consumer base.

6. **Top 3 Products Per City**  
   Ranks top-selling products in each city by sales volume.

7. **Monthly Sales Growth Trend**  
   Measures month-over-month sales growth percentage per city.

8. **Unique Customers Buying Coffee**  
   Counts unique customers who purchased coffee products in each city.


##  Key Insights (Conclusion)

- Cities with larger populations and higher estimated rent tend to generate higher sales revenue, indicating higher spending capacity.
- Product performance varies significantly by region, highlighting the need for city-targeted inventory planning.
- The average bill per customer is a useful metric for identifying high-value customer segments.
- Sales growth trends show seasonality and fluctuations, helping in planning marketing strategies for peak months.
- Despite high estimated consumer bases, some cities underperform in actual customer engagement, suggesting room for targeted promotions or outreach.

