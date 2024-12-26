#Pizza Sales Analysis
#List of Tables
#pizza_order_details,pizza_orders,pizza_types,pizzas
select * from pizzas; #pizza_id,pizza_type_id,size,price
select * from pizza_types; #pizza_type_id,name,category,ingredients
select * from pizza_orders; #order_id,date,time
select * from pizza_order_details; #order_details_id,order_id,pizza_id,quantity

#Q1) Query the total number of orders placed?

SELECT 
    COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
    PIZZA_ORDERS;

#Q2) Query the total number of pizza_id types?

SELECT 
    COUNT(DISTINCT PIZZA_ID) AS TOTAL_PIZZA_IDs
FROM
    PIZZAS;

#Q3) Query the total number of pizza_types are there?

SELECT 
    COUNT(DISTINCT PIZZA_TYPE_ID) AS TOTAL_PIZZA_TYPEs
FROM
    PIZZAS;

#Q4) Query total order qunatity placed?

SELECT 
    SUM(QUANTITY) AS TOTAL_ORDER_QTY
FROM
    PIZZA_ORDER_DETAILS;

#Q5) Query the first date of transction and last date of transtcion?

SELECT 
    MIN(DATE) AS FIRST_DATE, MAX(DATE) AS LAST_DATE
FROM
    PIZZA_ORDERS;

#Q6) Query the total revenue generated ?

SELECT 
    ROUND(SUM(PRICE * QUANTITY), 2) AS TOTAL_REVENUE
FROM
    PIZZAS A
        JOIN
    PIZZA_ORDER_DETAILS B ON A.PIZZA_ID = B.PIZZA_ID;

#Q7) Query the highest priced pizza? #Display pizza name, price

SELECT 
    A.NAME AS PIZZA_NAME, B.PRICE
FROM
    PIZZA_TYPES A
        JOIN
    PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID
ORDER BY B.PRICE DESC
LIMIT 1;

#Q8) Query the lowset priced pizza? #Display pizza name, price

SELECT 
    A.NAME, B.PRICE
FROM
    PIZZA_TYPES A
        JOIN
    PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID
ORDER BY B.PRICE ASC
LIMIT 1;

#Q9) Query the pizza ordered qty by size? #Display size and Order qty

SELECT 
    A.SIZE, SUM(B.QUANTITY) AS ORDER_QTY
FROM
    PIZZAS A
        JOIN
    PIZZA_ORDER_DETAILS B ON A.PIZZA_ID = B.PIZZA_ID
GROUP BY A.SIZE
ORDER BY ORDER_QTY DESC;

#Q10) Query the pizza ordered qty by category?

SELECT 
    C.CATEGORY, SUM(D.QUANTITY) AS ORDER_QTY
FROM
    (SELECT 
        A.CATEGORY, B.PIZZA_ID
    FROM
        PIZZA_TYPES A
    JOIN PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) C
        JOIN
    PIZZA_ORDER_DETAILS D ON C.PIZZA_ID = D.PIZZA_ID
GROUP BY C.CATEGORY
ORDER BY ORDER_QTY DESC;

#Q11) Query the pizza ordered qty by pizza name?

SELECT 
    C.NAME AS PIZZA_NAME, SUM(D.QUANTITY) AS ORDER_QTY
FROM
    (SELECT 
        A.NAME, B.PIZZA_ID
    FROM
        PIZZA_TYPES A
    JOIN PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) C
        JOIN
    PIZZA_ORDER_DETAILS D ON C.PIZZA_ID = D.PIZZA_ID
GROUP BY PIZZA_NAME
ORDER BY ORDER_QTY DESC;

SELECT A.NAME,SUM(C.QUANTITY) AS ORDER_QTY
FROM PIZZA_TYPES A 
JOIN PIZZAS B 
ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID
JOIN PIZZA_ORDER_DETAILS C
ON B.PIZZA_ID=C.PIZZA_ID
GROUP BY A.NAME
ORDER BY ORDER_QTY DESC;

#Q12) Query the top 7 types based orders qty? Display pizza name, order qty

SELECT 
    C.NAME, SUM(D.QUANTITY) AS TOTAL_ORDERQTY
FROM
    (SELECT 
        A.NAME, B.PIZZA_ID
    FROM
        PIZZA_TYPES A
    JOIN PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) C
        JOIN
    PIZZA_ORDER_DETAILS D ON C.PIZZA_ID = D.PIZZA_ID
GROUP BY C.NAME
ORDER BY TOTAL_ORDERQTY DESC
LIMIT 7;

#Q13) Query the distribution of orders by hour of day?

SELECT 
    HOUR(TIME) AS HOUR, COUNT(ORDER_ID) AS ORDERQTY
FROM
    PIZZA_ORDERS
GROUP BY HOUR
ORDER BY ORDERQTY DESC;

#Q14) Query the pizza order qty by date and calculate the average numbers of pizzas ordered per day?

SELECT 
    ROUND(AVG(ORDEREDQTY)) AS AVGORDERPIZZAQTY
FROM
    (SELECT 
        A.DATE, SUM(B.QUANTITY) AS ORDEREDQTY
    FROM
        PIZZA_ORDERS A
    JOIN PIZZA_ORDER_DETAILS B ON A.ORDER_ID = B.ORDER_ID
    GROUP BY A.DATE
    ORDER BY ORDEREDQTY DESC) AS C;

#Q15) Query the top 7 pizza names by revenue? #Display pizza name, revnue , orderqty

SELECT 
    C.NAME,
    SUM(C.PRICE * E.QUANTITY) AS REVENUE,
    SUM(QUANTITY) AS TTLORDERQTY
FROM
    (SELECT 
        A.NAME, B.PRICE, B.PIZZA_ID
    FROM
        PIZZA_TYPES A
    JOIN PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) C
        JOIN
    PIZZA_ORDER_DETAILS E ON C.PIZZA_ID = E.PIZZA_ID
GROUP BY C.NAME
ORDER BY REVENUE DESC
LIMIT 7;

#Q16) Query the percentage contribution of each pizza category to total rvenue?

SELECT 
    A.CATEGORY,
    ROUND(SUM(A.PRICE * C.QUANTITY) / (SELECT 
                    SUM(A.PRICE * B.QUANTITY) AS TOTAL_REVENUE
                FROM
                    PIZZAS A
                        JOIN
                    PIZZA_ORDER_DETAILS B ON A.PIZZA_ID = B.PIZZA_ID) * 100,
            2) AS REVENUEPERCENTAGE
FROM
    (SELECT 
        A.CATEGORY, B.PIZZA_ID, B.PRICE
    FROM
        PIZZA_TYPES A
    JOIN PIZZAS B ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) A
        JOIN
    PIZZA_ORDER_DETAILS C ON A.PIZZA_ID = C.PIZZA_ID
GROUP BY A.CATEGORY
ORDER BY REVENUEPERCENTAGE DESC;

#Q17) Analyze the qumulative revenu generated over time?

SELECT 
  DATE, 
  ROUND(SUM(TTLREVENUE) OVER(ORDER BY DATE),2) AS CUM_REVENUE 
FROM 
  (SELECT B.DATE, SUM(REVENUE) AS TTLREVENUE 
    FROM (SELECT 
          A.ORDER_ID, 
          SUM(A.QUANTITY * B.PRICE) AS REVENUE 
        FROM 
          PIZZA_ORDER_DETAILS A 
          JOIN PIZZAS B ON A.PIZZA_ID = B.PIZZA_ID 
        GROUP BY 
          A.ORDER_ID
      ) A 
      JOIN PIZZA_ORDERS B ON A.ORDER_ID = B.ORDER_ID 
    GROUP BY 
      B.DATE
  ) AS RVN;

#Q18) Determine the top 3 most ordered pizza types based on revenue for each category?

SELECT NAME,CATEGORY,REVENUE FROM(
SELECT *, RANK() OVER(PARTITION BY CATEGORY ORDER BY REVENUE DESC) AS RNK  
FROM(
SELECT A.NAME,A.CATEGORY,SUM(B.QUANTITY * A.PRICE) AS REVENUE 
FROM (
SELECT A.NAME,A.CATEGORY,B.PIZZA_ID,B.PRICE 
FROM PIZZA_TYPES A 
JOIN PIZZAS B 
ON A.PIZZA_TYPE_ID = B.PIZZA_TYPE_ID) A 
JOIN PIZZA_ORDER_DETAILS B 
ON A.PIZZA_ID = B.PIZZA_ID 
GROUP BY A.NAME,A.CATEGORY) A) B
WHERE RNK <=3;



















































