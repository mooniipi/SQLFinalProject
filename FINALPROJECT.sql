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
--================================================================================================================================ 
--Data Insert 
INSERT INTO MsStaff VALUES 
('ST108', 'Lance Arifin', '10-08-2005', 'Jl. Sunter 5', 'Male'),
('ST012', 'Vincent Febryan', '06-02-2005', 'Jl. Mangga Besar 1', 'Male'),
('ST111', 'Alvin Febryan', '09-02-2005', 'Jl. Pluit Raya 9', 'Male'),
('ST121', 'Leonardo Dharmasetiawan', '31-12-2004', 'Jl. Jatiwaringin 10', 'Male'),
('ST028', 'Dave Reynara', '15-08-2005', 'Jl. Tomang 16', 'Male'),
('ST981', 'Angel Richard', '27-07-2002', 'Jl. Kemanggisan 1', 'Female'),
('ST999', 'Angel Gunawan', '01-09-2005', 'Jl. Batu Tulis 12', 'Female'),
('ST888', 'Marshanda Salim', '30-08-2005', 'Jl. Sunter Mas 10', 'Female'),
('ST912', 'Diogenes Fam', '21-07-2005', 'Jl. Pademangan 5', 'Male'),
('ST444', 'Bryan Fandy', '13-04-2005', 'Jl. Mangga Dua 10', 'Male')

INSERT INTO MsCustomer VALUES
('CU901', 'Marvin Chandiary', '23-12-2005', 'Male'),
('CU222', 'Putu Pramajaya', '28-6-2005', 'Male'),
('CU911', 'Edmund Setiady', '27-4-2005', 'Male'),
('CU478', 'Christopher Mulyono', '24-10-2005', 'Male'),
('CU652', 'Alexander Edward', '19-6-2005', 'Male'),
('CU823', 'Vincent Hansel', '29-9-2005', 'Male'),
('CU764', 'Jeanette Gunawan', '28-3-2005', 'Female'),
('CU827', 'Thomas Jevon', '28-12-2005', 'Male'),
('CU008', 'Daniel Budiman', '6-10-2005', 'Male'),
('CU987', 'Celine Tan', '16-3-2005', 'Female')

INSERT INTO MsFood VALUES
('FO012', 'Caramel Popcorn', 'Fried', '83868'),
('FO213', 'Butter Popcorn', 'Fried', '90905'),
('FO234', 'Siomay', 'Fried', '93859'),
('FO912', 'Fettucine Alfredo', 'Pasta', '11640'),
('FO221', 'Nachos', 'Fried', '27386'),
('FO094', 'Caesar Salad', 'Salad', '75328'),
('FO921', 'Chitato', 'Snack', '73192'),
('FO920', 'Spaggeti Bolognese', 'Pasta', '18411'),
('FO100', 'French Fries', 'Fried', '13446'),
('FO182', 'Club Sandwich', 'Sandwich', '24855')

INSERT INTO MsDrink VALUES
('DR217', 'Cola-cola', 'Soda', '21553'),
('DR019', 'Sprite', 'Soda', '11807'),
('DR981', 'Fanta', 'Soda', '84387'),
('DR934', 'Banana Milk', 'Milk', '80476'),
('DR012', 'Turkish Coffee', 'Coffee', '88929'),
('DR103', 'Tobruk Coffee', 'Coffee', '65814'),
('DR021', 'Jasmine Tea', 'Herbal', '40542'),
('DR812', 'Charmonile Tea', 'Soda', '83270'),
('DR923', 'Oolong Tea', 'Herbal', '65091'),
('DR013', 'English Breakfast', 'Herbal', '94055')

INSERT INTO MsMovie VALUES
('MO200', 'Godfather 1', '02:37:42', 'R','1', '96008'),
('MO821', 'Godfather 2', '02:52:33', 'R','1', '78772'),
('MO974', 'Siksa Kubur', '02:06:28', 'NC-17','3', '71791'),
('MO831', 'The Irishman', '01:36:09', 'R','5', '94409'),
('MO721', 'Desa Penari', '01:18:03', 'NC-17','3', '86106'),
('MO941', 'Godfather 3', '01:13:20', 'R','1', '98662'),
('MO874', 'The Goodfellas', '02:57:42', 'R','5', '77032'),
('MO444', 'Sing 2', '01:33:39', 'PG-13','4', '85478'),
('MO555', 'Arabian Night', '02:02:55', 'NC-17','4', '81501'),
('MO984', 'TopGun: Maverick', '02:57:28', 'PG-13','4', '98895')

INSERT INTO MsSupplier VALUES 
('SU091', 'PT. Megahita', 'Jl. Permata 1'),
('SU921', 'PT. Permata', 'Jl. Jatiwaringin 4'),
('SU871', 'PT. Aneka', 'Jl. Kemanggisan 3'),
('SU827', 'PT. Rasa', 'Jl. Tujuh 7'),
('SU833', 'PT. Megayasa', 'Jl. Kelapa 1'),
('SU718', 'PT. Duta', 'Jl. Gading 2'),
('SU541', 'PT. Borneo', 'Jl. Kurnia 1'),
('SU821', 'PT. Teknologi', 'Jl. Jeruk 10'),
('SU931', 'PT. Yogyakarta', 'Jl. Jogja 12'),
('SU821', 'PT. 51', 'Jl. Sudirman 21')

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

--5 
--================================================================  
Select
TH.TransactionID, 
dateadd(year, 1, TransactionDate) as 'Drink Transaction Forecast', 
concat(DrinkQuantity, ' Cup') as 'Drink Quantity' 
from TransactionHeader TH join 
TransactionDetailDrink THD on 
TH.TransactionID = THD.TransactionID, ( 
	select DrinkCategory from MsDrink 
	where DrinkCategory in ('Soft Drink', 'Herbal')
)as MD
where DrinkQuantity > 1 
--================================================================  

--6 
--================================================================  
Select 
StaffID,
CONVERT(varchar, TransctionDate, 107) as 'Transaction Date',
REPLACE(MovieID, 'MO', 'Movie') as 'Movie ID', 
concat('Film ', MovieName) as 'Movie Name', 
MovieCategory
from MsStaff MS join 
TransactionHeader TH on 
MS.StaffID = TH.StaffID join 
TransactionDetailTicket TDT on 
TH.TransactionID = TDT.TransactionID join 
MsMovie MMT on 
MMT.MovieID = TDT.MovieID, ( 
	select --Ini Masi Experimental jujur gw belom terlalu paham kalo yang diatas rata-rata kek mana ~Lance
	CAST(SUBSTRING(MovieDuration, 1, 2) AS INT) * 3600 + 
    CAST(SUBSTRING(MovieDuration, 4, 2) AS INT) * 60 + 
    CAST(SUBSTRING(MovieDuration, 7, 2) AS INT) AS duration_in_seconds
	from MsMovie 

	WHERE
    CAST(SUBSTRING(MovieDuration, 1, 2) AS INT) * 3600 + 
    CAST(SUBSTRING(MovieDuration, 4, 2) AS INT) * 60 + 
    CAST(SUBSTRING(MovieDuration, 7, 2) AS INT) >
    (SELECT AVG(CAST(SUBSTRING(MovieDuration, 1, 2) AS INT) * 3600 + 
                  CAST(SUBSTRING(MovieDuration, 4, 2) AS INT) * 60 + 
                  CAST(SUBSTRING(MovieDuration, 7, 2) AS INT))
     FROM MsMovie)
) as MM   
where MMT.MovieID in ('MO3001') 
--================================================================  
 


--EXPERIMENTAL CODES 
--10
--=======================================================
Create View [Food Sales] as
select 
FoodName, 
SUM(FoodQuantity) as 'Total Quantity Sold' 
AVG(FoodPrice) as 'Average Food Price' 
from MsFood MF join 
TransactionDetailFood TDF on 
MF.FoodID = TDF.FoodID join 
TransactionHeader TH on 
TDF.TransactionID = TH.TransactionID
where FoodCategory in ('Sandwich') and 
Year(TransactionDate) = Year(Getdate()) 
Group by FoodName;

select * from [Food Sales]
--======================================================= 

--9 
--======================================================= 
Create View [TotalPurchase] as 
select 
Stuff(Varchar, Charindex(' ', StaffName) - 1, len(StaffName), 'Staff') as 'Staff', 
MovieName, 
MovieRating, 
AVG(TicketQuantity) as 'Average Ticket Bought', 
SUM(TicketQuantity) as 'Total Ticket Bought'
from MsStaff MS join 
TransactionHeader TH on 
MS.StaffID = TH.StaffID join 
TransactionDetailTicket TDT on 
TH.TransactionID = TDT.TransactionID join 
MsMovie MM on 
MM.MovieID = TDT.MovieID 
where MovieRating = '5'
GroupBy MovieName, MovieRating 
having SUM(TicketQuantity) > AVG(TicketQuantity);

Select * from [TotalPurchase]
--======================================================= 
