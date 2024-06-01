CREATE DATABASE CineMoFie
GO
USE CineMoFie
GO
--DROP STAGING AREA
DROP DATABASE CineMoFie 
DROP TABLE MsStaff 
DROP TABLE MsCustomer
DROP TABLE MsFood 
DROP TABLE MsDrink 
DROP TABLE MsMovie 
DROP TABLE MsSupplier 
DROP TABLE TransactionHeader 
DROP TABLE TransactionDetailFood  
DROP TABLE TransactionDetailDrink 
DROP TABLE TransactionDetailTicket
DROP TABLE MsPurchase
------------------------------------------------


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
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) NOT NULL,
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
MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) NOT NULL,
TicketQuantity INT NOT NULL
)

CREATE TABLE MsPurchase (
PurchaseID CHAR(5) PRIMARY KEY CHECK(PurchaseID LIKE('PU[0-9][0-9][0-9]')) NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
SupplierID CHAR(5) FOREIGN KEY REFERENCES MsSupplier(SupplierID) NOT NULL,
PurchaseDate VARCHAR(50) NOT NULL,
) 

CREATE TABLE PurchaseDetailFood( 

) 

CREATE TABLE PurchaseDetailDrink(

)

--================================================================================================================================
--================================================================================================================================ 
--Data Insert 
INSERT INTO MsStaff VALUES 
('ST108', 'Lance Arifin', '2005-08-10', 'Jl. Sunter 5', 'Male'),
('ST012', 'Vincent Febryan', '2005-02-06', 'Jl. Mangga Besar 1', 'Male'),
('ST111', 'Alvin Febryan', '2005-02-09', 'Jl. Pluit Raya 9', 'Male'),
('ST121', 'Leonardo Dharmasetiawan', '2004-12-31', 'Jl. Jatiwaringin 10', 'Male'),
('ST028', 'Dave Reynara', '2005-08-15', 'Jl. Tomang 16', 'Male'),
('ST981', 'Angel Richard', '2002-07-27', 'Jl. Kemanggisan 1', 'Female'),
('ST999', 'Angel Gunawan', '2005-09-22', 'Jl. Batu Tulis 12', 'Female'),
('ST888', 'Marshanda Salim', '2005-08-30', 'Jl. Sunter Mas 10', 'Female'),
('ST912', 'Diogenes Fam', '2005-07-15', 'Jl. Pademangan 5', 'Male'),
('ST444', 'Bryan Fandy', '2005-04-13', 'Jl. Mangga Dua 10', 'Male')

INSERT INTO MsCustomer VALUES
('CU901', 'Marvin Chandiary', '2005-12-23', 'Male'),
('CU222', 'Putu Pramajaya', '2005-06-28', 'Male'),
('CU911', 'Edmund Setiady', '2005-04-27', 'Male'),
('CU478', 'Christopher Mulyono', '2005-10-24', 'Male'),
('CU652', 'Alexander Edward', '2005-06-19', 'Male'),
('CU823', 'Vincent Hansel', '2005-09-29', 'Male'),
('CU764', 'Jeanette Gunawan', '2005-03-28', 'Female'),
('CU827', 'Thomas Jevon', '2005-12-28', 'Male'),
('CU008', 'Daniel Budiman', '2005-10-06', 'Male'),
('CU987', 'Celine Tan', '2005-03-16', 'Female')

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
('DR217', 'Cola-cola', 'Soft Drink', '21553'),
('DR019', 'Sprite', 'Soft Drink', '11807'),
('DR981', 'Fanta', 'Soft Drink', '84387'),
('DR934', 'Banana Milk', 'Milk', '80476'),
('DR012', 'Turkish Coffee', 'Coffee', '88929'),
('DR103', 'Tobruk Coffee', 'Coffee', '65814'),
('DR021', 'Jasmine Tea', 'Herbal', '40542'),
('DR812', 'Charmonile Tea', 'Soft Drink', '83270'),
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
('SU825', 'PT. 51', 'Jl. Sudirman 21')
--problem
INSERT INTO TransactionHeader(TransactionID, StaffID, CustomerID, TransactionDate)  
VALUES
('TR001',	'ST108',	'CU901',	'2019-1-5'),
('TR002',	'ST108',	'CU222',	'2019-8-8'),
('TR003',	'ST012',	'CU222',	'2019-12-25'),
('TR004',	'ST121',	'CU911',	'2019-6-21'),
('TR005',	'ST111',	'CU478',	'2019-8-24'),
('TR006',	'ST111',	'CU911',	'2019-1-4'),
('TR007',	'ST028',	'CU652',	'2019-9-13'),
('TR008',	'ST981',	'CU823',	'2019-9-16'),
('TR009',	'ST981',	'CU764',	'2019-4-16'),
('TR010',	'ST912',	'CU764',	'2019-1-17'),
('TR011',	'ST444',	'CU827',	'2019-6-9'),
('TR012',	'ST444',	'CU008',	'2019-12-29'),
('TR013',	'ST999',	'CU987',	'2019-2-9'),
('TR014',	'ST888',	'CU008',	'2019-9-3'),
('TR015',	'ST888',	'CU827',	'2019-7-24'),
('TR016',	'ST111',	'CU478',	'2019-10-9'),
('TR017',	'ST028',	'CU911',	'2019-8-2'),
('TR018',	'ST981',	'CU652',	'2019-12-2'),
('TR019',	'ST981',	'CU823',	'2019-6-19'),
('TR020',	'ST912',	'CU764',	'2019-10-9'),
('TR021',	'ST444',	'CU764',	'2019-11-1'),
('TR022',	'ST444',	'CU827',	'2019-12-23'),
('TR023',	'ST999',	'CU008',	'2019-6-22'),
('TR024',	'ST888',	'CU987',	'2019-10-23'),
('TR025',	'ST108',	'CU008',	'2019-4-21')

INSERT INTO TransactionDetailFood VALUES
('TR001',	'FO012',	'2'),
('TR001',	'FO213',	'2'),
('TR001',	'FO234',	'3'),
('TR002',	'FO912',	'5'),
('TR003',	'FO221',	'2'),
('TR003',	'FO094',	'4'),
('TR004',	'FO921',	'1'),
('TR005',	'FO920',	'3'),
('TR005',	'FO100',	'2'),
('TR006',	'FO182',	'1'),
('TR007',	'FO094',	'1'),
('TR008',	'FO012',	'2'),
('TR009',	'FO100',	'4'),
('TR010',	'FO234',	'2'),
('TR010',	'FO182',	'3'),
('TR010',	'FO921',	'1'),
('TR010',	'FO012',	'1'),
('TR011',	'FO221',	'1'),
('TR012',	'FO920',	'1'),
('TR013',	'FO912',	'2'),
('TR014',	'FO213',	'2'),
('TR015',   'FO094',	'2'),
('TR015',	'FO100',	'1'),
('TR015',	'FO921',	'1'),
('TR015',	'FO234',	'1'),
('TR016',	'FO100',	'2'),
('TR016',	'FO234',	'2'),
('TR017',	'FO182',	'3'),
('TR018',	'FO921',	'5'),
('TR018',	'FO012',	'2'),
('TR018',	'FO221',	'4'),
('TR019',	'FO920',	'1'),
('TR020',	'FO912',	'3'),
('TR021',	'FO213',	'2'),
('TR021',	'FO094',	'1'),
('TR022',	'FO100',	'1'),
('TR022',	'FO921',	'2'),
('TR022',	'FO234',	'4'),
('TR022',	'FO012',	'1'),
('TR023',	'FO213',	'1'),
('TR023',	'FO234',	'2'),
('TR024',	'FO912',	'2'),
('TR025',	'FO221',	'2'),
('TR025',	'FO094',	'1') 

INSERT INTO TransactionDetailDrink VALUES
('TR001', 'DR217', '3'),
('TR002', 'DR019', '1'),
('TR002', 'DR021', '2'),
('TR002', 'DR812', '3'),
('TR003', 'DR981', '2'),
('TR003', 'DR021', '2'),
('TR004', 'DR934', '2'),
('TR004', 'DR923', '3'),
('TR004', 'DR013', '4'),
('TR004', 'DR012', '1'),
('TR004', 'DR981', '3'),
('TR005', 'DR012', '4'),
('TR006', 'DR103', '2'),
('TR007', 'DR021', '2'),
('TR008', 'DR812', '3'),
('TR009', 'DR923', '5'),
('TR009', 'DR981', '2'),
('TR009', 'DR012', '2'),
('TR010', 'DR013', '3'),
('TR011', 'DR012', '2'),
('TR012', 'DR103', '1'),
('TR013', 'DR217', '1'),
('TR014', 'DR019', '4'),
('TR015', 'DR981', '2'),
('TR015', 'DR103', '1'),
('TR016', 'DR934', '2'),
('TR017', 'DR923', '3'),
('TR017', 'DR013', '4'),
('TR017', 'DR012', '1'),
('TR018', 'DR981', '3'),
('TR018', 'DR012', '4'),
('TR019', 'DR103', '2'),
('TR019', 'DR021', '2'),
('TR020', 'DR812', '3'),
('TR021', 'DR923', '5'),
('TR021', 'DR981', '2'),
('TR022', 'DR012', '2'),
('TR022', 'DR013', '3'),
('TR022', 'DR012', '2'),
('TR023', 'DR103', '1'),
('TR024', 'DR217', '1'),
('TR024', 'DR019', '1'),
('TR025', 'DR217', '1'),
('TR025', 'DR019', '4')

INSERT INTO TransactionDetailTicket VALUES
('TR001', 'MO200', '5'),
('TR001', 'MO812', '2'),
('TR003', 'MO974', '3'),
('TR003', 'MO555', '4'),
('TR003', 'MO984', '2'),
('TR004', 'MO821', '2'),
('TR005', 'MO721', '4'),
('TR005', 'MO721', '1'),
('TR005', 'MO941', '1'),
('TR005', 'MO444', '3'),
('TR006', 'MO941', '5'),
('TR007', 'MO874', '1'),
('TR007', 'MO200', '4'),
('TR007', 'MO444', '3'),
('TR008', 'MO444', '4'),
('TR009', 'MO555', '4'),
('TR010', 'MO984', '4'),
('TR010', 'MO941', '2'),
('TR010', 'MO721', '2'),
('TR010', 'MO555', '1'),
('TR011', 'MO721', '2'),
('TR011', 'MO941', '2'),
('TR013', 'MO444', '3'),
('TR014', 'MO555', '5'),
('TR015', 'MO200', '2'),
('TR016', 'MO974', '4'),
('TR016', 'MO555', '1'),
('TR016', 'MO984', '1'),
('TR017', 'MO831', '3'),
('TR017', 'MO721', '5'),
('TR018', 'MO721', '1'),
('TR018', 'MO941', '4'),
('TR019', 'MO444', '3'),
('TR019', 'MO941', '4'),
('TR019', 'MO874', '4'),
('TR020', 'MO200', '4'),
('TR021', 'MO444', '2'),
('TR022', 'MO444', '2'),
('TR022', 'MO555', '1'),
('TR023', 'MO984', '2'),
('TR024', 'MO941', '5'),
('TR024', 'MO721', '1'),
('TR025', 'MO555', '4'),
('TR025', 'MO721', '3')

INSERT INTO MsPurchase VALUES 
('PU201', 'ST108', 'SU091', '2018-12-1'), 
('PU921', 'ST012', 'SU921', '2018-12-3'), 
('PU312', 'ST012', 'SU871', '2018-12-10'), 
('PU888', 'ST108', 'SU827', '2019-4-1'), 
('PU001', 'ST108', 'SU833', '2019-4-1'), 
('PU845', 'ST108', 'SU718', '2019-5-15'), 
('PU827', 'ST111', 'SU825', '2019-6-1'), 
('PU821', 'ST111', 'SU541', '2019-7-9'), 
('PU999', 'ST012', 'SU931', '2019-9-10'), 
('PU838', 'ST108', 'SU931', '2019-10-9')
--================================================================================================================================ 


--Jawaban Dari Soal 1 - 10 

--1 (BERHASIL)
--================================================================
select  
upper(MS.StaffName) as 'Staffs', 
PurchaseDate, 
Count(TH.TransactionID) as 'Total Food Purchase'
from MsStaff MS join 
MsPurchase MP on 
MS.StaffID = MS.StaffID join
TransactionHeader TH on 
MS.StaffID = TH.StaffID 
Where StaffGender Like ('Male') And Year(PurchaseDate) = 2019
group by PurchaseDate, StaffName
order by PurchaseDate DESC
--================================================================

--2 (Masih ada problem)
--================================================================ 
Select 
PurchaseID, 
LOWER(SupplierName) As 'Supplier Name', 
Sum(DrinkQuantity) As 'Total Drink Purchase' 
from MsPurchase MP join 
MsSupplier MSUP on
MP.SupplierID = MSUP.SupplierID join 
TransactionHeader T on
MP.TransactionID = TDD.TransactionID 
group by PurchaseID, SupplierName
Having SUM(DrinkQuantity) < 5 and PurchaseID % 2 = 0 
--================================================================

--3 (BERHASIL)
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

--4 (Berhasil)
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
MS.StaffID,
CONVERT(varchar, TH.TransactionDate, 107) as 'Transaction Date',
REPLACE(MMT.MovieID, 'MO', 'Movie') as 'Movie ID', 
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
