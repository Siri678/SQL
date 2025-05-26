
Insights Generated:
Identifying top selling product types by region, analyzing high-performance (i7) device sales by region, and flagging delayed dispatches compared to the average delay.

Aggregations & Data Quality Checks:
Performed aggregations like SUM, AVG, and RANK, and check for nulls in Dispatch_Date, Inward_Date, or invalid core specifications like N/A.

Handling Bad Data:
Yes, rows with NULL or N/A in date or key spec fields will be filtered out using WHERE conditions before aggregation.

Handling Duplicates:
If duplicate entries exist, we will handle them by applying DISTINCT, GROUP BY, or using ROW_NUMBER() to deal only with unique record.



--This below query identifies the top selling product type Mobile or Laptop in each region based on total quantity sold.

SELECT DISTINCT t.Region, t.Product, sales.Total_Quantity
FROM Mobiles_and_Laptop_Sales_Data t
JOIN (SELECT Region, Product, SUM(Quantity_Sold) AS Total_Quantity, RANK() OVER (PARTITION BY Region ORDER BY SUM(Quantity_Sold) DESC) AS rnk
    FROM Mobiles_and_Laptop_Sales_Data GROUP BY Region, Product) sales ON t.Region = sales.Region AND t.Product = sales.Product WHERE sales.rnk = 1;



--This below query shows the total units sold and total revenue for i7 products, grouped by region, 
--to identify which regions generate the most sales from high performance devices.

SELECT d.Region,
    SUM(v.Quantity_Sold) AS Total_Units_Sold,
    SUM(v.Price * v.Quantity_Sold) AS Total_Revenue
FROM Mobiles_and_Laptop_Sales_Data_VW1 v JOIN Mobiles_and_Laptop_Sales_Data d ON v.Product_Code = d.Product_Code GROUP BY d.Region ORDER BY Total_Revenue DESC;




--This query retrieves products whose dispatch delay is greater than or equal to the average delay

SELECT Product_Code, Brand, Inward_Date, Dispatch_Date,
    DATEDIFF(Dispatch_Date, Inward_Date) AS Dispatch_Delay_Days FROM Mobiles_and_Laptop_Sales_Data
WHERE DATEDIFF(Dispatch_Date, Inward_Date) >= (SELECT AVG(DATEDIFF(Dispatch_Date, Inward_Date)) FROM Mobiles_and_Laptop_Sales_Data WHERE Dispatch_Date IS NOT NULL AND Inward_Date IS NOT NULL);