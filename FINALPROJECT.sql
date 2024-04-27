CREATE DATABASE CineMoFie
GO
USE CineMoFie
GO

CREATE TABLE MsStaff (
StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE('ST[0-9][0-9][0-9]')) NOT NULL,
StaffName VARCHAR(50) NOT NULL,
StaffDateOfBirth VARCHAR(50) NOT NULL,
StaffAddress VARCHAR(50) NOT NULL,
StaffGender VARCHAR(50) NOT NULL,
CONSTRAINT StaffGenderChecker CHECK(StaffGender IN('Male' , 'Female')), 
CONSTRAINT CheckDateOfBirthStaff CHECK (DATEDIFF(Year, StaffDateOfBirth, Getdate()) > 17)
)

CREATE TABLE MsCustomer (
CustomerID CHAR(5) PRIMARY KEY CHECK(CustomerID LIKE('CU[0-9][0-9][0-9]')) NOT NULL,
CustomerName VARCHAR(50) NOT NULL,
CustomerDateOfBirth VARCHAR(50) NOT NULL,
CustomerGender VARCHAR(50) NOT NULL,
CONSTRAINT CustomerGenderChecker CHECK(CustomerGender IN('Male' , 'Female'))
)

CREATE TABLE MsFood (
FoodID CHAR(5) PRIMARY KEY CHECK(FoodID LIKE('FO[0-9][0-9][0-9]')) NOT NULL,
FoodName VARCHAR(50) NOT NULL,
FoodCategory VARCHAR(50) NOT NULL,
FoodPrice FLOAT NOT NULL,
CONSTRAINT FCatChecker CHECK(FoodCategory IN('Pasta' , 'Salad' , 'Sandwich' , 'Snack' , 'Fried'))
)

CREATE TABLE MsDrink (
DrinkID CHAR(5) PRIMARY KEY CHECK(DrinkID LIKE('DR[0-9][0-9][0-9]')) NOT NULL,
DrinkName VARCHAR(50) NOT NULL,
DrinkCategory VARCHAR(50) NOT NULL,
DrinkPrice VARCHAR(50) NOT NULL,
CONSTRAINT DCatChecker CHECK(DrinkCategory IN('Soft Drink' , 'Tea' , 'Coffee' , 'Milk' , 'Herbal'))
)

CREATE TABLE MsMovie (
MovieID CHAR(5) PRIMARY KEY CHECK(MovieID LIKE('MO[0-9][0-9][0-9]')) NOT NULL,
MovieName VARCHAR(50) NOT NULL,
MovieDuration VARCHAR(50) NOT NULL,
MovieCategory VARCHAR(50) CHECK(MovieCategory IN('U', 'PG', 'PG-13', 'R', 'NC-17')) NOT NULL,
MovieRating VARCHAR(50) CHECK(MovieRating IN('1', '2', '3', '4', '5')) NOT NULL,
MoviePrice FLOAT NOT NULL
)

CREATE TABLE MsSupplier (
SupplierID CHAR(5) PRIMARY KEY CHECK(SupplierID LIKE('SU[0-9][0-9][0-9]')) NOT NULL,
SupplierName VARCHAR(50) NOT NULL,
SupplierAddress VARCHAR(50) NOT NULL
)

CREATE TABLE TransactionHeader (
TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID LIKE('TR[0-9][0-9][0-9]')) NOT NULL,
TransactionDate VARCHAR(50) NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
)

CREATE TABLE TransactionDetailFood (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
FoodQuantity INT NOT NULL
)

CREATE TABLE TransactionDetailDrink (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DrinkQuantity INT NOT NULL
)

CREATE TABLE TransactionDetailTicket (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
TicketQuantity INT NOT NULL
)

CREATE TABLE MsPurchase (
PurchaseID CHAR(5) PRIMARY KEY CHECK(PurchaseID LIKE('PU[0-9][0-9][0-9]')) NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
SupplierID CHAR(5) FOREIGN KEY REFERENCES MsSupplier(SupplierID) NOT NULL,
PurchaseDate VARCHAR(50) NOT NULL,
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) NOT NULL
)
--================================================================================================================================
CREATE TABLE MsPurchase (
PurchaseID CHAR(5) PRIMARY KEY CHECK(PurchaseID LIKE('PU[0-9][0-9][0-9]')) NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
SupplierID CHAR(5) FOREIGN KEY REFERENCES MsSupplier(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
PurchaseDate VARCHAR(50) NOT NULL,
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
) 
--================================================================================================================================ 

--Jawaban Dari Soal 1 - 10 

--1 
--================================================================
select  
upper(StaffName) as 'Staffs', 
PurchaseDate, 
Count(TDF.TransactionID) as 'Total Food Purchase'
from MsStaff MS join 
MsPurchase MP on 
MS.StaffID = MS.StaffID join
TransactionDetailFood TDF on 
MP.TransactionID = TDF.TransactionID 
Where StaffGender Like ('Male') And Year(PurchaseDate) = 2019
group by PurchaseDate, StaffName
--================================================================

--2 
--================================================================ 
Select 
PurchaseID, 
LOWER(SupplierName) As 'Supplier Name', 
Sum(DrinkQuantity) As 'Total Drink Purchase' 
from MsPurchase MP join 
MsSupplier MSUP on
MP.SupplierID = MSUP.SupplierID join 
TransactionDetailDrink TDD on
MP.TransactionID = TDD.TransactionID 
group by PurchaseID, SupplierName
Having SUM(DrinkQuantity) < 5 and PurchaseID % 2 = 0 
--================================================================

--3 
--================================================================ 
Select 
Convert(varchar, TransactionDate, 107) as 'Transaction Date', 
MAX(FoodPrice) as 'Highest Food Price Sold', 
MIN(DrinkPrice) as 'Lowest Drink Price Sold'
from TransactionHeader TH join 
TransactionDetailFood TDF on 
TH.TransactionID = TDF.TransactionID join 
TransactionDetailDrink TDD on 
TH.TransactionID = TDD.TransactionID join 
MsFood MF on 
TDF.FoodID = MF.FoodID join 
MsDrink MD on 
TDD.DrinkID = MD.DrinkID 
where Month(TransactionDate) < 6 and 
Year(TransactionDate) < 2023 
group by FoodPrice, DrinkPrice, TransactionDate
--================================================================  

--4 
--================================================================ 
Select 
left(StaffName, Charindex(' ', StaffName)) as 'Staffs First Name', 
FoodCategory, 
AVG(FoodQuantity) as 'Average Total Food Purchased', 
SUM(FoodQuantity) as 'Total Food Purchased' 
from MsStaff MS join 
TransactionHeader TH on 
MS.StaffID = TH.StaffID join 
TransactionDetailFood TDF on 
TH.TransactionID = TDF.TransactionID join 
MsFood MF on 
TDF.FoodID = MF.FoodID  
where FoodCategory like ('Fried')
group by FoodQuantity, TH.TransactionID, FoodCategory, StaffName
Having Avg(FoodQuantity) > 2 
--================================================================ 
