-- Select all products brought by a customer from an employee in a store on a day
SELECT -- Primary keys
	products.productCode as "product_code",
	customers.customerNumber as "customer_number",
	employees.employeeNumber as "employee_number",
	offices.officeCode as "office_code",
	-- Values
	orders.orderDate as "order_date",
	SUM(orderdetails.priceEach) as "sales_amount",
	orderdetails.quantityOrdered as "quantity",
	SUM(products.buyPrice) as "cost_amount"
FROM products products
	INNER JOIN orderdetails orderdetails ON products.productCode = orderdetails.productCode
	INNER JOIN orders orders ON orderdetails.orderNumber = orders.orderNumber
	INNER JOIN customers customers ON orders.customerNumber = customers.customerNumber
	INNER JOIN employees employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
	INNER JOIN offices offices ON employees.officeCode = offices.officeCode
GROUP BY orders.orderNumber;