CREATE DATABASE CineMoFie
GO
USE CineMoFie
GO
--DROP STAGING AREA
DROP DATABASE CineMoFiel 
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
DROP TABLE PurchaseDetailDrink 
DROP TABLE PurchaseDetailFood
------------------------------------------------

CREATE TABLE MsStaff (
StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE('ST[0-9][0-9][0-9]')) NOT NULL,
StaffName VARCHAR(50) NOT NULL,
StaffDateOfBirth date NOT NULL,
StaffAddress VARCHAR(50) NOT NULL,
StaffGender VARCHAR(50) NOT NULL,
CONSTRAINT StaffGenderChecker CHECK(StaffGender IN('Male' , 'Female')), 
CONSTRAINT CheckDateOfBirthStaff CHECK (DATEDIFF(Year, StaffDateOfBirth, Getdate()) > 17)
)

CREATE TABLE MsCustomer (
CustomerID CHAR(5) PRIMARY KEY CHECK(CustomerID LIKE('CU[0-9][0-9][0-9]')) NOT NULL,
CustomerName VARCHAR(50) NOT NULL,
CustomerDateOfBirth date NOT NULL,
CustomerGender VARCHAR(50) NOT NULL,
CONSTRAINT CustomerGenderChecker CHECK(CustomerGender IN('Male' , 'Female'))
)

CREATE TABLE MsFood (
FoodID CHAR(5) PRIMARY KEY CHECK(FoodID LIKE('FO[0-9][0-9][0-9]')) NOT NULL,
FoodName VARCHAR(50) NOT NULL,
FoodCategory VARCHAR(50) NOT NULL,
FoodPrice integer NOT NULL,
CONSTRAINT FCatChecker CHECK(FoodCategory IN('Pasta' , 'Salad' , 'Sandwich' , 'Snack' , 'Fried'))
)
CREATE TABLE MsDrink (
DrinkID CHAR(5) PRIMARY KEY CHECK(DrinkID LIKE('DR[0-9][0-9][0-9]')) NOT NULL,
DrinkName VARCHAR(50) NOT NULL,
DrinkCategory VARCHAR(50) NOT NULL,
DrinkPrice integer NOT NULL,
CONSTRAINT DCatChecker CHECK(DrinkCategory IN('Soft Drink' , 'Tea' , 'Coffee' , 'Milk' , 'Herbal'))
)
CREATE TABLE MsMovie (
MovieID CHAR(5) PRIMARY KEY CHECK(MovieID LIKE('MO[0-9][0-9][0-9]')) NOT NULL,
MovieName VARCHAR(50) NOT NULL,
MovieDuration Integer NOT NULL,
MovieCategory VARCHAR(50) CHECK(MovieCategory IN('U', 'PG', 'PG-13', 'R', 'NC-17')) NOT NULL,
MovieRating Integer CHECK(MovieRating IN('1', '2', '3', '4', '5')) NOT NULL,
MoviePrice integer NOT NULL
)
CREATE TABLE MsSupplier (
SupplierID CHAR(5) PRIMARY KEY CHECK(SupplierID LIKE('SU[0-9][0-9][0-9]')) NOT NULL,
SupplierName VARCHAR(50) NOT NULL,
SupplierAddress VARCHAR(50) NOT NULL
)
CREATE TABLE TransactionHeader (
TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID LIKE('TR[0-9][0-9][0-9]')) NOT NULL,
TransactionDate date NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) NOT NULL,
)
CREATE TABLE TransactionDetailFood (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
FoodQuantity INT NOT NULL,
Primary Key(TransactionID, FoodID)
)
CREATE TABLE TransactionDetailDrink (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DrinkQuantity INT NOT NULL, 
Primary Key(TransactionID, DrinkID)
)
CREATE TABLE TransactionDetailTicket (
TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) NOT NULL,
TicketQuantity INT NOT NULL, 
Primary Key(TransactionID, MovieID)
)
CREATE TABLE MsPurchase (
PurchaseID CHAR(5) PRIMARY KEY CHECK(PurchaseID LIKE('PU[0-9][0-9][0-9]')) NOT NULL,
StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) NOT NULL,
SupplierID CHAR(5) FOREIGN KEY REFERENCES MsSupplier(SupplierID) NOT NULL,
PurchaseDate date NOT NULL,
) 
CREATE TABLE PurchaseDetailFood( 
PurchaseID CHAR(5) FOREIGN KEY REFERENCES MsPurchase(PurchaseID) NOT NULL, 
FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) NOT NULL, 
FoodQuantityPurchase INTEGER NOT NULL, 
Primary Key(PurchaseID, FoodID)
) 
CREATE TABLE PurchaseDetailDrink(
PurchaseID CHAR(5) FOREIGN KEY REFERENCES MsPurchase(PurchaseID) NOT NULL, 
DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) NOT NULL, 
DrinkQuantityPurchase INTEGER NOT NULL, 
Primary Key(PurchaseID, DrinkID)
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
('FO012', 'Caramel Popcorn', 'Fried', 25),
('FO213', 'Butter Popcorn', 'Fried', 35),
('FO234', 'Siomay', 'Fried', 15),
('FO912', 'Fettucine Alfredo', 'Pasta', 40),
('FO221', 'Nachos', 'Fried', 25),
('FO094', 'Caesar Salad', 'Salad', 30),
('FO921', 'Chitato', 'Snack', 10),
('FO920', 'Spaggeti Bolognese', 'Pasta', 42),
('FO100', 'French Fries', 'Fried', 13),
('FO182', 'Club Sandwich', 'Sandwich', 24)

INSERT INTO MsDrink VALUES
('DR217', 'Cola-cola', 'Soft Drink', 21),
('DR019', 'Sprite', 'Soft Drink', 22),
('DR981', 'Fanta', 'Soft Drink', 23),
('DR934', 'Banana Milk', 'Milk', 8),
('DR012', 'Turkish Coffee', 'Coffee', 30),
('DR103', 'Tobruk Coffee', 'Coffee', 35),
('DR021', 'Jasmine Tea', 'Herbal', 5),
('DR812', 'Charmonile Tea', 'Soft Drink', 15),
('DR923', 'Oolong Tea', 'Herbal', 25),
('DR013', 'English Breakfast Tea', 'Herbal', 27)

INSERT INTO MsMovie VALUES
('MO001', 'Godfather 1', 157, 'R', 1 , 96),
('MO002', 'Godfather 2', 172 , 'R', 1 , 78),
('MO003', 'Siksa Kubur', 199 , 'NC-17', 3 , 71),
('MO004', 'The Irishman', 96 , 'R', 5 , 94),
('MO005', 'Desa Penari',  78 , 'NC-17', 3 , 86),
('MO006', 'Godfather 3',  73 , 'R', 1 , 98),
('MO007', 'The Goodfellas', 177 , 'R', 5 , 77),
('MO008', 'Sing 2', 93 , 'PG-13', 4 , 85),
('MO009', 'Arabian Night', 122 , 'NC-17', 4 , 81),
('MO010', 'TopGun: Maverick', 178 , 'PG-13', 4 , 98)

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

INSERT INTO TransactionHeader(TransactionID, StaffID, CustomerID, TransactionDate)  
VALUES
('TR001',	'ST108',	'CU901',	'2019-01-05'),
('TR002',	'ST108',	'CU222',	'2019-08-08'),
('TR003',	'ST012',	'CU222',	'2019-12-25'),
('TR004',	'ST121',	'CU911',	'2020-06-21'),
('TR005',	'ST111',	'CU478',	'2020-08-24'),
('TR006',	'ST111',	'CU911',	'2020-01-04'),
('TR007',	'ST028',	'CU652',	'2020-09-13'),
('TR008',	'ST981',	'CU823',	'2020-09-16'),
('TR009',	'ST981',	'CU764',	'2021-04-16'),
('TR010',	'ST912',	'CU764',	'2021-01-17'),
('TR011',	'ST444',	'CU827',	'2021-06-09'),
('TR012',	'ST444',	'CU008',	'2021-12-29'),
('TR013',	'ST999',	'CU987',	'2021-02-09'),
('TR014',	'ST888',	'CU008',	'2022-09-03'),
('TR015',	'ST888',	'CU827',	'2022-07-24'),
('TR016',	'ST111',	'CU478',	'2022-10-09'),
('TR017',	'ST028',	'CU911',	'2022-08-02'),
('TR018',	'ST981',	'CU652',	'2022-12-02'),
('TR019',	'ST981',	'CU823',	'2022-06-19'),
('TR020',	'ST912',	'CU764',	'2023-10-09'),
('TR021',	'ST444',	'CU764',	'2023-11-01'),
('TR022',	'ST444',	'CU827',	'2023-12-23'),
('TR023',	'ST999',	'CU008',	'2023-06-22'),
('TR024',	'ST888',	'CU987',	'2024-10-23'),
('TR025',	'ST108',	'CU008',	'2024-04-21'),
('TR026',  'ST028',		'CU008',	'2024-02-13'),
('TR027',	'ST028',	'CU911',	'2024-05-02')

INSERT INTO TransactionDetailFood VALUES
('TR001',	'FO012',	2),
('TR001',	'FO213',	2),
('TR001',	'FO234',	3),
('TR002',	'FO912',	5),
('TR003',	'FO221',	2),
('TR003',	'FO094',	4),
('TR004',	'FO921',	1),
('TR005',	'FO920',	3),
('TR005',	'FO100',	2),
('TR006',	'FO182',	1),
('TR007',	'FO094',	1),
('TR008',	'FO012',	2),
('TR009',	'FO100',	4),
('TR010',	'FO234',	2),
('TR010',	'FO182',	3),
('TR010',	'FO921',	1),
('TR010',	'FO012',	1),
('TR011',	'FO221',	1),
('TR012',	'FO920',	1),
('TR013',	'FO912',	2),
('TR014',	'FO213',	2),
('TR015',   'FO094',	2),
('TR015',	'FO100',	1),
('TR015',	'FO921',	1),
('TR015',	'FO234',	1),
('TR016',	'FO100',	2),
('TR016',	'FO234',	2),
('TR017',	'FO182',	3),
('TR018',	'FO921',	5),
('TR018',	'FO012',	2),
('TR018',	'FO221',	4),
('TR019',	'FO920',	1),
('TR020',	'FO912',	3),
('TR021',	'FO213',	2),
('TR021',	'FO094',	1),
('TR022',	'FO100',	1),
('TR022',	'FO921',	2),
('TR022',	'FO234',	4),
('TR022',	'FO012',	1),
('TR023',	'FO213',	1),
('TR023',	'FO234',	2),
('TR024',	'FO912',	2),
('TR025',	'FO182',	2),
('TR025',	'FO094',	1) 

INSERT INTO TransactionDetailDrink VALUES
('TR001', 'DR217', 3),
('TR002', 'DR019', 1),
('TR002', 'DR021', 2),
('TR002', 'DR812', 3),
('TR003', 'DR981', 2),
('TR003', 'DR021', 2),
('TR004', 'DR934', 2),
('TR004', 'DR923', 3),
('TR004', 'DR013', 4),
('TR004', 'DR012', 1),
('TR004', 'DR981', 3),
('TR005', 'DR012', 4),
('TR006', 'DR103', 2),
('TR007', 'DR021', 2),
('TR008', 'DR812', 3),
('TR009', 'DR923', 5),
('TR009', 'DR981', 2),
('TR009', 'DR012', 2),
('TR010', 'DR013', 3),
('TR011', 'DR012', 2),
('TR012', 'DR103', 1),
('TR013', 'DR217', 1),
('TR014', 'DR019', 4),
('TR015', 'DR981', 2),
('TR015', 'DR103', 1),
('TR016', 'DR934', 2),
('TR017', 'DR923', 3),
('TR017', 'DR013', 4),
('TR017', 'DR012', 1),
('TR018', 'DR981', 3),
('TR018', 'DR012', 4),
('TR019', 'DR103', 2),
('TR019', 'DR021', 2),
('TR020', 'DR812', 3),
('TR021', 'DR923', 5),
('TR021', 'DR981', 2),
('TR022', 'DR217', 2),
('TR022', 'DR013', 3),
('TR022', 'DR012', 2),
('TR023', 'DR103', 1),
('TR024', 'DR217', 1),
('TR024', 'DR019', 1),
('TR025', 'DR217', 1),
('TR025', 'DR019', 4)

INSERT INTO TransactionDetailTicket VALUES
('TR001', 'MO001', 5),
('TR001', 'MO002', 2),
('TR002', 'MO003', 3),
('TR002', 'MO009', 4),
('TR003', 'MO010', 2),
('TR004', 'MO002', 2),
('TR005', 'MO005', 4),
('TR005', 'MO002', 1),
('TR005', 'MO006', 1),
('TR005', 'MO008', 3),
('TR006', 'MO006', 5),
('TR007', 'MO007', 1),
('TR007', 'MO003', 4),
('TR007', 'MO008', 3),
('TR008', 'MO008', 4),
('TR009', 'MO009', 4),
('TR010', 'MO010', 4),
('TR010', 'MO006', 2),
('TR010', 'MO005', 2),
('TR010', 'MO009', 1),
('TR011', 'MO005', 2),
('TR011', 'MO006', 2),
('TR013', 'MO008', 3),
('TR014', 'MO009', 5),
('TR015', 'MO001', 2),
('TR016', 'MO003', 4),
('TR016', 'MO009', 1),
('TR016', 'MO010', 1),
('TR017', 'MO004', 3),
('TR017', 'MO005', 5),
('TR018', 'MO005', 1),
('TR018', 'MO006', 4),
('TR019', 'MO008', 3),
('TR019', 'MO006', 4),
('TR019', 'MO007', 4),
('TR020', 'MO001', 4),
('TR021', 'MO008', 2),
('TR022', 'MO008', 2),
('TR022', 'MO009', 1),
('TR023', 'MO010', 2),
('TR024', 'MO006', 5),
('TR024', 'MO005', 1),
('TR025', 'MO009', 4),
('TR025', 'MO005', 3),
('TR026', 'MO007' , 5),
('TR027', 'MO007' , 12)

INSERT INTO MsPurchase VALUES 
('PU201', 'ST999', 'SU091', '2019-12-01'), 
('PU921', 'ST981', 'SU921', '2019-12-03'), 
('PU312', 'ST888', 'SU871', '2019-12-10'), 
('PU888', 'ST888', 'SU827', '2019-04-01'), 
('PU001', 'ST999', 'SU833', '2019-04-01'), 
('PU845', 'ST981', 'SU718', '2019-05-15'), 
('PU827', 'ST981', 'SU825', '2019-06-01'), 
('PU821', 'ST108', 'SU541', '2019-07-09'), 
('PU999', 'ST012', 'SU931', '2020-09-10'), 
('PU838', 'ST981', 'SU931', '2020-10-09'), 
('PU011', 'ST999', 'SU091', '2021-11-12'), 
('PU012', 'ST888', 'SU541', '2021-11-14'), 
('PU013', 'ST981', 'SU825', '2022-11-15'), 
('PU014', 'ST999', 'SU091', '2023-12-1'), 
('PU015', 'ST108', 'SU931', '2024-01-01') 

INSERT INTO PurchaseDetailFood VALUES 
('PU201', 'FO012', 1),
('PU201', 'FO213', 2),
('PU921', 'FO234', 3),
('PU921', 'FO912', 4),
('PU312', 'FO221', 5),
('PU312', 'FO094', 1),
('PU888', 'FO921', 2),
('PU888', 'FO920', 3),
('PU888', 'FO100', 4),
('PU001', 'FO182', 5),
('PU001', 'FO012', 1),
('PU001', 'FO213', 2), 
('PU001', 'FO234', 3),
('PU845', 'FO912', 4),
('PU845', 'FO221', 5),
('PU827', 'FO094', 1),
('PU827', 'FO921', 2),
('PU827', 'FO920', 3),
('PU827', 'FO100', 4), 
('PU821', 'FO182', 5),
('PU821', 'FO012', 1),
('PU999', 'FO213', 2),
('PU999', 'FO234', 3), 
('PU838', 'FO912', 4), 
('PU838', 'FO221', 5), 
('PU011', 'FO012', 1),
('PU011', 'FO213', 2),
('PU012', 'FO234', 3),
('PU013', 'FO912', 4),
('PU013', 'FO221', 5),
('PU013', 'FO094', 1),
('PU014', 'FO921', 2),
('PU014', 'FO920', 3),
('PU014', 'FO100', 4),
('PU015', 'FO182', 5)

INSERT INTO PurchaseDetailDrink VALUES 
('PU201', 'DR217', 1),
('PU201', 'DR019', 2),
('PU921', 'DR981', 3),
('PU921', 'DR934', 4),
('PU312', 'DR012', 5),
('PU312', 'DR103', 1),
('PU888', 'DR021', 2),
('PU888', 'DR812', 3),
('PU888', 'DR923', 4),
('PU001', 'DR013', 5),
('PU001', 'DR217', 1),
('PU001', 'DR019', 2), 
('PU001', 'DR981', 3),
('PU845', 'DR934', 4),
('PU845', 'DR012', 5),
('PU827', 'DR103', 1),
('PU827', 'DR021', 2),
('PU827', 'DR812', 3),
('PU827', 'DR923', 4), 
('PU821', 'DR013', 5),
('PU821', 'DR217', 1),
('PU999', 'DR019', 2),
('PU999', 'DR981', 3), 
('PU838', 'DR934', 4), 
('PU838', 'DR012', 5),  
('PU011', 'DR217', 1),
('PU011', 'DR019', 2),
('PU012', 'DR981', 3),
('PU013', 'DR934', 4),
('PU013', 'DR012', 5),
('PU013', 'DR103', 1),
('PU014', 'DR021', 2),
('PU014', 'DR812', 3),
('PU014', 'DR923', 4),
('PU015', 'DR013', 5) 
--================================================================================================================================ 

--Jawaban Dari Soal 1 - 10 

--1 (BERHASIL)
--================================================================ 
select  
upper(MS.StaffName) as 'Staffs', 
PurchaseDate, 
Count(PDF.PurchaseID) as 'Total Food Purchase'
from MsStaff Ms join 
MsPurchase MP on 
Ms.StaffID = MP.StaffID join 
PurchaseDetailFood PDF on 
MP.PurchaseID = PDF.PurchaseID 
Where StaffGender = 'Male' and Year(PurchaseDate) = 2019 
group by Ms.StaffName, PurchaseDate
--================================================================

--2 (BERHASIL)
--================================================================ 
select 
MP.PurchaseID AS 'PurchaseID',
LOWER(MS.SupplierName) as 'Supplier Name', 
SUM(PDD.DrinkQuantityPurchase) as 'Total Drink Purchase'
from MsSupplier MS join 
MsPurchase MP on 
MS.SupplierID = MP.SupplierID Join 
PurchaseDetailDrink PDD on 
PDD.PurchaseID = MP.PurchaseID 
Group By MP.PurchaseID, MS.SupplierName, MP.PurchaseID
Having SUM(PDD.DrinkQuantityPurchase) < 5 AND CAST(SUBSTRING(MP.PurchaseID, 3, LEN(MP.PurchaseID) - 2) AS INT) % 2 = 0
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
AVG(FoodQuantityPurchase) as 'Average Total Food Purchased', 
SUM(FoodQuantityPurchase) as 'Total Food Purchased' 
from MsStaff Ms join 
MsPurchase MP on 
MS.StaffID = MP.StaffID join 
PurchaseDetailFood PDF on 
MP.PurchaseID = PDF.PurchaseID join 
MsFood MF on 
PDF.FoodID = MF.FoodID  
where FoodCategory like ('Fried')
group by FoodCategory, StaffName
Having Avg(FoodQuantityPurchase) > 2 
--================================================================ 

--5 (BERHASIL)
--================================================================  
Select
TH.TransactionID, 
dateadd(year, 1, TransactionDate) as 'Drink Transaction Forecast', 
concat(DrinkQuantity, ' Cup') as 'Drink Quantity'
from TransactionHeader TH join 
TransactionDetailDrink THD on 
TH.TransactionID = THD.TransactionID, ( 
	select MD = DrinkID from MsDrink 
	where DrinkCategory in ('Soft Drink' , 'Herbal')
)as alias
where THD.DrinkID = alias.MD AND DrinkQuantity > 1 
--================================================================  

--6 (BERHASIL)
--================================================================  
Select 
s.StaffID,
CONVERT(varchar, TransactionDate, 106) as 'Transaction Date',
REPLACE(m.MovieID, 'MU', 'Movie ') as 'Movie Identification',
CONCAT('Film ', MovieName) as 'Movie Name',
MovieCategory,
MovieDuration
FROM MsStaff s
JOIN TransactionHeader h ON s.StaffID = h.StaffID
JOIN TransactionDetailTicket dt ON h.TransactionID = dt.TransactionID
JOIN MsMovie m ON dt.MovieID = m.movieID, (
SELECT AVG(MovieDuration) as 'avg' FROM MsMovie) as alias
WHERE m.MovieID LIKE('MO003') AND MovieDuration > alias.avg
--================================================================  
 
-- 7 (PROBLEM)
--================================================================  
 SELECT

--================================================================  


-- 8 (PROBLEM)
--================================================================  
 SELECT


--================================================================  

--9 (BERHASIL)
--======================================================= 
Create View [TotalPurchase] as 
select 
STUFF(Ms.StaffName, charindex(' ', Ms.StaffName) - 1, len(Ms.StaffName), 'Staff') As 'Staff', 
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
where MovieRating = 5
Group By MovieName, MovieRating, StaffName
having SUM(TicketQuantity) > AVG(TicketQuantity);
--======================================================= 

--10 (BERHASIL)
--=======================================================
Create View [Food Sales] as
select 
FoodName, 
SUM(FoodQuantity) as 'Total Quantity Sold', 
AVG(FoodPrice) as 'Average Food Price' 
from MsFood MF join 
TransactionDetailFood TDF on 
MF.FoodID = TDF.FoodID join 
TransactionHeader TH on 
TDF.TransactionID = TH.TransactionID
where FoodCategory in ('Sandwich') AND
Year(TransactionDate) = Year(GETDATE())
Group by FoodName;
--======================================================= 
