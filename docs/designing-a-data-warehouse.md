# Designing a data warehouse

A data warehouse is a system used for reporting and data analysis.
It is a core component of business intelligence, [according to wikipedia.](https://en.wikipedia.org/wiki/Data_warehouse)

The steps below skim the theory in a brief way but focus more on the designing process of a specific data warehouse, for a specific business.

1. Identifying the business process
2. Identifying the grain
3. Choosing the dimensions
4. Identifying the measures

## **I. Identifying the business process**

- **In general**

A business process is a natural business activity performed in an organization that is supported by some form of data collection.
The focus should be on the **process** and **NOT the department**.

- **Specifically**

Let's design a data warehouse for a vehicle selling company.

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

> One row represents a product brought by a customer from an employee in a store on a day

**FactProductSales**

| Column Name    | Data Type     |
| -------------- | ------------- |
| **ProductSk**  | int           |
| **OrderSk**    | int           |
| **EmployeeSk** | int           |
| **CustomerSk** | int           |
| **OfficeSk**   | int           |
| SalesAmount    | numeric(10.2) |
| Quantity       | int           |
| CostAmount     | numeric(10.2) |

## **III. Choosing the dimensions**

A dimension is a structure that categorizes facts and measures in order to enable users to answer business questions.
They generally aren't too far from a relational database model.

**Surrogate Key**s are used instead of **Business key**s in order to:

- Have a unique identifier that's isolated from any changes done by the transactional system (immune to source changes such as metadata updates)
- Track and trace where the dimension comes from, in regards to the normal business keys (IDs).
- Optimize the joins in the fact tables and dimensions.
- Keep historical information in the dimensions over time.
- Keep a single source of truth between all departments (e.g. marketing and manufacturing have different names/IDs for a product)

**DimProduct**

| Column Name   | Data Type   |
| ------------- | ----------- |
| **ProductSK** | int         |
| ProductCode   | varchar(15) |
| ProductName   | varchar(70) |
| \<omitted\>   | ...         |

**DimOrders**

| Column Name | Data Type |
| ----------- | --------- |
| **OrderSk** | int       |
| OrderNumber | int(11)   |
| OrderDate   | date      |
| \<omitted\> | ...       |

**DimEmployee**

| Column Name    | Data Type   |
| -------------- | ----------- |
| **EmployeeSK** | int         |
| EmployeeNumber | int(11)     |
| LastName       | varchar(50) |
| \<omitted\>    | ...         |

**DimCustomer**

| Column Name    | Data Type   |
| -------------- | ----------- |
| **CustomerSK** | int         |
| CustomerNumber | int(11)     |
| CustomerName   | varchar(50) |
| \<omitted\>    | ...         |

**DimOffice**

| Column Name  | Data Type   |
| ------------ | ----------- |
| **OfficeSk** | int         |
| OfficeCode   | varchar(10) |
| Country      | varchar(50) |
| \<omitted\>  | ...         |

**Note:** If we need a dimension that's not identified by our grain statement later on, then we should go back to the latter and adjust it appropriately.

## **IV. Identifying the measures**

This answers the question of how does the business measure success. What are the high impact low risk metrics that we want to track in our data warehouse?

## **V. Theory vs practice**

As demonstrated above, we will ideally have one facts table with multiple dimensions table.
However, considering that we will be using Elasticsearch for data-warehousing, we chose to create [**one gigantic query**](../compose/init/logstash/conf.d/sql/pull_data.sql) that maps directly to an elasticsearch index.

_Proceed to [the elasticstack documentation](../docs/elasticstack.md) for more details._

##### [To table of contents](../README.md)
