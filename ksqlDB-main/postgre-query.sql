CREATE TABLE customers (
	customer_id int PRIMARY KEY,
	name_customer varchar(100),
	gender varchar(50),
	age int,
	region varchar(50),
	job varchar(100),
	balance float
);

INSERT INTO customers (customer_id, name_customer, gender, age, region, job, balance)
	VALUES  (1, 'Ali', 'Male', 29, 'Wales', 'Blue Collar', 200545.08),
			(2, 'Nina', 'Female', 25, 'Ireland', 'Blue Collar', 98758.15),
	 		(3, 'Lily', 'Female', 32, 'England', 'White Collar', 302845.95);