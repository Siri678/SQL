SELECT s.student_id, s.gender, s.exam_score, m.Region, COUNT(m.Product) AS total_products_sold_in_region
FROM student_habits_performance s
JOIN mobiles_and_laptop_sales_data m ON s.gender = 'Female' AND m.Region = 'East'
GROUP BY s.student_id, s.gender, s.exam_score, m.Region;



SELECT diet_quality, AVG(exam_score) AS avg_exam_score
FROM student_habits_performance GROUP BY diet_quality;


SELECT Product, SUM(Quantity_Sold) AS total_quantity_sold
FROM mobiles_and_laptop_sales_data GROUP BY Product;


SELECT student_id, mental_health_rating, exam_score
FROM student_habits_performance
ORDER BY mental_health_rating DESC, exam_score DESC;


SELECT Region, MAX(Price * Quantity_Sold) AS max_total_sales
FROM mobiles_and_laptop_sales_data GROUP BY Region;


SELECT student_id, study_hours_per_day, exam_score
FROM student_habits_performance
WHERE study_hours_per_day > 5 AND exam_score > 85;


SELECT Product, COUNT(*) AS sales_instances, SUM(Quantity_Sold) AS total_units
FROM mobiles_and_laptop_sales_data GROUP BY Product HAVING SUM(Quantity_Sold) > 5;


SELECT student_id, exam_score,
    CASE 
        WHEN exam_score >= 90 THEN 'Excellent'
        WHEN exam_score >= 75 THEN 'Good'
        WHEN exam_score >= 50 THEN 'Average'
        ELSE 'Poor' END AS performance_category FROM student_habits_performance;
		
		
SELECT gender AS Value, 'Student' AS Source FROM student_habits_performance
UNION ALL
SELECT Region AS Value, 'Sales Region' AS Source FROM mobiles_and_laptop_sales_data;