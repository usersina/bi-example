-- Select all products brought by a customer from an employee in a store on a day
-- alongside all other relevant information
SELECT
	-- Primary keys
	products.productCode as "product_code",
	customers.customerNumber as "customer_number",
	employees.employeeNumber as "employee_number",
	offices.officeCode as "office_code",
	-- Aggregated values
	SUM(orderdetails.priceEach) as "total_sales_amount",
	SUM(products.buyPrice) as "total_costs_amount",
	-- All other information for dashboarding
	-- products
	products.productName as "product_name",
	products.productLine as "product_line",
	products.productVendor as "product_vendor",
	products.quantityInStock as "quantity_in_stock",
	products.buyPrice as "unit_cost_price",
	-- orderdetails
	orderdetails.quantityOrdered as "ordered_quantity",
	orderdetails.priceEach as "unit_sale_price",
	-- orders
	orders.orderDate as "order_date",
	orders.shippedDate as "shipped_date",
	orders.status as "order_status",
	-- customers
	customers.customerNumber as "customer_name",
	customers.contactLastName as "customer_contact_last_name",
	customers.contactFirstName as "customer_contact_first_name",
	customers.phone as "customer_phone",
	customers.country as "customer_country",
	customers.city as "customer_city",
	customers.creditLimit as "customer_credit_limit",
	-- employees
	employees.lastName as "employee_last_name",
	employees.firstName as "employee_first_name",
	employees.jobTitle as "employee_job_title",
	-- offices
	offices.city as "office_city",
	offices.phone as "office_phone",
	offices.country as "office_country"
FROM products products
	INNER JOIN orderdetails orderdetails ON products.productCode = orderdetails.productCode
	INNER JOIN orders orders ON orderdetails.orderNumber = orders.orderNumber
	INNER JOIN customers customers ON orders.customerNumber = customers.customerNumber
	INNER JOIN employees employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
	INNER JOIN offices offices ON employees.officeCode = offices.officeCode
GROUP BY orders.orderNumber
