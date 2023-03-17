-- One row represents a product brought by a customer from an employee in a store on a day
SELECT
	-- Primary keys
	products.productCode,
    customers.customerNumber,
    employees.employeeNumber,
    offices.officeCode,
    -- Values
    orders.orderDate,
    SUM(orderdetails.priceEach) as "SalesAmount",
    orderdetails.quantityOrdered as "Quantity",
    SUM(products.buyPrice) as "CostAmount"
FROM
	products products
INNER JOIN 
	orderdetails orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN
	orders orders ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN
	customers customers ON orders.customerNumber = customers.customerNumber
INNER JOIN
	employees employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
INNER JOIN
	offices offices ON employees.officeCode = offices.officeCode
GROUP BY
	orders.orderNumber;
