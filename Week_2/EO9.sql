
-- EO9 -- 
USE AdventureWorks2022

SELECT * FROM Production.Product;

SELECT BusinessEntityID,JobTitle
FROM HumanResources.Employee

SELECT *
FROM Sales.SalesOrderHeader soh
WHERE soh.CustomerID = 29847

SELECT c.CustomerID, SUM(SubTotal) 
FROM Sales.Customer c JOIN Sales.SalesOrderHeader soh  ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID;

SELECT pc.ProductCategoryID, pc.Name, psc.Name FROM 
Production.ProductCategory pc JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID;

SELECT * 
FROM Production.Product p
WHERE p.SellEndDate IS NOT NULL

SELECT TOP 10 p.productid, p.name, SUM(pod.OrderQty) FROM 
Production.Product p JOIN Purchasing.PurchaseOrderDetail pod  ON p.ProductID = pod.ProductID
GROUP by P.ProductID, p.name

Select DISTINCT AddressLine1, AddressLine2, City, PostalCode, c.CustomerID From 
Sales.Customer c JOIN Person.StateProvince sp ON c.TerritoryID = sp.TerritoryID
Join Person.Address a ON a.StateProvinceID = sp.StateProvinceID
WHERE c.CustomerID = 29847;

Select TOP 10 * FROM 
Sales.SalesOrderDetail sod JOIN Production.Product p ON p.ProductID = sod.ProductID

-- NEXT SECTION -- 

SELECT *
FROM Sales.SalesOrderHeader soh
WHERE FORMAT(soh.OrderDate, ('yyyy-MM')) = '2011-06'

SELECT *, AVG(TotalPrice) OVER (Partition By DayModified) Average
FROM(
SELECT SalesOrderID,
	UnitPrice,
	OrderQty,
	UnitPrice*OrderQty TotalPrice,
	FORMAT(ModifiedDate, 'yyyy-MM-dd') DayModified
FROM Sales.SalesOrderDetail sod) as Days