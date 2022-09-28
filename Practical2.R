# Practical 2

# Name:

# Student Number:

# Data and Packages

library(readr)
library(sqldf)
library(RJDBC)
library(RH2)
library(lubridate)
library(rJava)

music_customer <- read_csv("music_customer.csv", show_col_types = FALSE)
orion_customer <- read_csv("orion_customer.csv", show_col_types = FALSE)
orion_employee_addresses <- read_csv("orion_employee_addresses.csv", show_col_types = FALSE)
orion_order_fact <- read_csv("orion_order_fact.csv", show_col_types = FALSE)
orion_sales <- read_csv("orion_sales.csv", show_col_types = FALSE)

# Question 1: 
Q1 <- sqldf("SELECT UPPER(State) AS State,Count(State) AS Number_Of_Employees 
            FROM orion_employee_addresses
            WHERE Country IN ('US') AND State IN ('PA','FL','CA')
            GROUP BY State")


# Question 2:

# The line of code below provides you a variable 'today' 
# in the Orion_customer table to assist getting the customer's ages.

orion_customer$today <- date("2022-03-15")

Q2 <- sqldf("SELECT Customer_ID, Customer_Birth_Date, FLOOR(((today - Customer_Birth_Date) / 365)) AS Age
            FROM orion_customer ")

# Question 3:
Q3 <- sqldf("SELECT Country , Count(Country) As Employees,
       SUM(Gender = 'F') AS Male,
       SUM(Gender = 'M') AS Female
       FROM orion_sales
       GROUP BY Country
       HAVING Female > 40 ")

# Question 4:
Q4 <- sqldf("SELECT CONCAT(Customer_Name, ' ', Customer_Surname) AS Customer_Full_Name,Customer_Phone,Customer_Email
            FROM music_customer
            WHERE Customer_City IN ('Pretoria','Johannesburg')
            AND Customer_Phone LIKE '011%'
            ")


# Question 5:
Q5 <- sqldf("SELECT a.Employee_ID, a.First_Name,a.Last_Name, b.Postal_Code
            FROM orion_sales AS a
            INNER JOIN orion_employee_addresses AS b
            ON a.Employee_ID = b.Employee_ID")



# Question 6:
Q6 <- sqldf("SELECT b.Employee_ID, b.Employee_Name,a.Job_Title,b.City
            FROM orion_sales AS a
            LEFT JOIN orion_employee_addresses AS b 
            ON a.Employee_ID = b.Employee_ID")


# Question 7:
Q7 <- sqldf("SELECT a.Customer_ID,a.Customer_First_Name,a.Customer_Last_Name, SUM(b.Quantity_Ordered) AS Number_Of_Items,b.Order_ID 
            FROM orion_customer as a
            INNER JOIN orion_order_fact as b
            ON a.Customer_ID = b.Customer_ID
            GROUP BY b.Order_ID ")


