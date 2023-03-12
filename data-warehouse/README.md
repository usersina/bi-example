# Designing a data warehouse

## **I. Identifying business process**

- **In general**

A business process is a natural business activity performed in an organization that is supported by some form of data collection.

The focus should be on the **process** and **NOT the department**.

- **Specifically**

A national product selling company with many stores.

Assuming that a transaction in this case is occurring with a product, on a day, with a customer, in a store, with a price.

We can do analysis on (to name a few):

- How many products did we sell in a store last month?
- How many products do we sell on this day?
- How many products are bought by out top 10% of customers?
- How many products are we selling by store?

## **II. Identifying the grain**

This is the most important decision in the design process and should answer the question: "What does one row in the fact table represent?"

### **Fact Table**

A fact table is a table at the center of a star schema. It contains all of the facts about the business.
Facts are measurements regarding the success/failure of the business depending on what type of business process we're going to be modeling.

The answer here is:

> One row represents a product brought by a customer from an employee in a store on a day.

**FactProductSales**

| Column Name       | Data Type     |
| ----------------- | ------------- |
| **ProductSk**     | int           |
| **DateSk**        | int           |
| **CustomerSk**    | int           |
| **StoreSk**       | int           |
| **EmployeeSk**    | int           |
| SalesDollarAmount | numeric(18,2) |
| Quantity          | int           |
| CostAmount        | numeric(18,2) |

## **III. Choosing the dimensions**

A dimension is a structure that categorizes facts and measures in order to enable users to answer business questions.

We **Surrogate Key**s instead of **Business key**s in order to:

- Have a unique identifier that's isolated from any changes done by the transactional system (immune to source changes such as metadata updates)
- Track and trace where the dimension comes from, in regards to the normal business keys (IDs).
- Optimize the joins in the fact tables and dimensions.
- Keep historical information in the dimensions over time.
- Keep a single source of truth between all departments (e.g. marketing and manufacturing have different names/IDs for a product)

Note that if we need a dimension that's not identified by our grain statement, then we should go back to the latter and adjust it.

**DimProduct**

| Column Name   | Data Type     |
| ------------- | ------------- |
| **ProductSK** | int           |
| ProductID     | varchar(50)   |
| ProductName   | varchar(100)  |
| ProductType   | varchar(25)   |
| ListPrice     | numeric(18,2) |

**DimSaleDate**

| Column Name  | Data Type   |
| ------------ | ----------- |
| **DateSK**   | int         |
| FullDate     | date        |
| CalendarYear | int         |
| MonthName    | varchar(25) |
| MonthNumber  | int         |
| FiscalYear   | int         |

**DimEmployee**

| Column Name    | Data Type   |
| -------------- | ----------- |
| **EmployeeSK** | int         |
| EmployeeID     | varchar(10) |
| EmployeeName   | varchar(50) |
| EmployeeGender | varchar(10) |

**DimCustomer**

| Column Name       | Data Type    |
| ----------------- | ------------ |
| **CustomerSK**    | int          |
| CustomerID        | varchar(50)  |
| CustomerFirstName | varchar(50)  |
| CustomerLastName  | varchar(50)  |
| StreetAddress     | varchar(250) |

**DimStore**

| Column Name | Data Type   |
| ----------- | ----------- |
| **StoreSK** | int         |
| StoreID     | varchar(50) |
| StoreName   | varchar(10) |

## **IV. Identifying the measures**

This answers the question of how does the business measure success. What are the high impact low risk metrics that we want to track in our data warehouse?
