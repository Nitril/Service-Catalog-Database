USE [master]
GO
/****** Object:  Database [KATALOGUSLUGIT]    Script Date: 23-Jun-18 11:11:13 ******/
CREATE DATABASE [KATALOGUSLUGIT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KATALOGUSLUGIT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\KATALOGUSLUGIT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KATALOGUSLUGIT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\KATALOGUSLUGIT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KATALOGUSLUGIT] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KATALOGUSLUGIT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ARITHABORT OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET  ENABLE_BROKER 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET RECOVERY FULL 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET  MULTI_USER 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KATALOGUSLUGIT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KATALOGUSLUGIT] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KATALOGUSLUGIT', N'ON'
GO
ALTER DATABASE [KATALOGUSLUGIT] SET QUERY_STORE = OFF
GO
USE [KATALOGUSLUGIT]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [KATALOGUSLUGIT]
GO
/****** Object:  UserDefinedFunction [dbo].[CenaZamowienia]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--funkcja przyjmuje za parametr numer zamówienia(ID) i zwraca koszt danego zamówienia
CREATE FUNCTION [dbo].[CenaZamowienia]
	(@ZamowienieID INT)
RETURNS NVARCHAR (300)
AS
BEGIN
			
	DECLARE @CenaZamowienia decimal(8,2)
	SET @CenaZamowienia =	(
					SELECT Cena*Ilosc AS CenaZamowienia 
					FROM Zamowienia
					JOIN Uslugi ON Zamowienia.UslugaID = Uslugi.ID 
					WHERE Zamowienia.ID = @ZamowienieID
					)
	RETURN @CenaZamowienia

END
GO
/****** Object:  Table [dbo].[Uzytkownicy]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Uzytkownicy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [nvarchar](50) NOT NULL,
	[Nazwisko] [nvarchar](100) NOT NULL,
	[PESEL] [nvarchar](20) NOT NULL,
	[email] [nvarchar](250) NOT NULL,
	[Telefon] [nvarchar](20) NULL,
	[FirmaID] [int] NULL,
	[Rola] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GrupyRobocze]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupyRobocze](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](250) NOT NULL,
	[WlascicielGrupyID] [int] NULL,
	[FirmaID] [int] NULL,
	[Opis] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Uslugi]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Uslugi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](250) NOT NULL,
	[Kategoria] [int] NULL,
	[Opis] [nvarchar](1000) NULL,
	[WlascicielUslugiID] [int] NULL,
	[KatalogID] [int] NULL,
	[Cena] [decimal](8, 2) NULL,
	[GrupaRoboczaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UslugaID] [int] NULL,
	[OtwartePrzez] [int] NULL,
	[DataUtworzenia] [datetime] NOT NULL,
	[DataRozpoczecia] [datetime] NULL,
	[DataZakonczenia] [datetime] NULL,
	[StatusID] [int] NULL,
	[Ilosc] [int] NOT NULL,
	[GrupaRoboczaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_OtwarteZamowienia]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_OtwarteZamowienia]
AS

SELECT Zamowienia.ID AS NumerZamowienia,Uslugi.Nazwa AS NazwaUslugi, otwarte.Imie + ' ' + otwarte.Nazwisko AS Zamawiajacy,
		GrupyRobocze.Nazwa AS GrupaWykonujaca,  wlasciciele.Imie + ' ' + wlasciciele.Nazwisko AS OsobaKontaktowa,
		DataUtworzenia, DataRozpoczecia
FROM
 	Zamowienia
	INNER JOIN GrupyRobocze ON (Zamowienia.GrupaRoboczaID = GrupyRobocze.ID)
	INNER JOIN Uslugi ON (Zamowienia.UslugaID = Uslugi.ID)
	INNER JOIN Uzytkownicy otwarte ON (Zamowienia.OtwartePrzez = otwarte.ID)
	INNER JOIN Uslugi usl ON (Zamowienia.UslugaID = usl.ID)
	INNER JOIN Uzytkownicy wlasciciele ON (Uslugi.WlascicielUslugiID = wlasciciele.ID)

WHERE Zamowienia.DataZakonczenia IS NULL
GO
/****** Object:  View [dbo].[v_UslugaPlatnosc]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Widok podsumowania zamówienia. Zawiera informacje o numerze zamówienia, nazwie usługi, dacie zakończenia, ilości oraz całkowity koszt usługi


CREATE VIEW [dbo].[v_UslugaPlatnosc]
AS

SELECT Zamowienia.ID AS NumerZamowienia, Uslugi.Nazwa AS NazwaUslugi, Uzytkownicy.Imie + ' ' + Uzytkownicy.Nazwisko AS Zamawiajacy, DataZakonczenia, Ilosc, Zamowienia.Ilosc * Uslugi.Cena AS DoZaplaty

FROM Zamowienia
		INNER JOIN Uzytkownicy ON (Zamowienia.OtwartePrzez = Uzytkownicy.ID)
		INNER JOIN Uslugi ON (Zamowienia.UslugaID = Uslugi.ID)

WHERE Zamowienia.DataZakonczenia IS NOT NULL
GO
/****** Object:  View [dbo].[v_ZyskiGrup]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- pokaz przychód wygenerowany przez poszczególne grupy robocze
CREATE VIEW [dbo].[v_ZyskiGrup]
		AS
		
		SELECT GrupyRobocze.Nazwa AS NazwaGrupyRoboczej, 
			   SUM(Uslugi.Cena * Zamowienia.Ilosc) AS Zysk 
		FROM
			Zamowienia
			LEFT JOIN GrupyRobocze ON Zamowienia.GrupaRoboczaID = GrupyRobocze.ID
			LEFT JOIN Uslugi ON Zamowienia.UslugaID = Uslugi.ID
			
		WHERE Zamowienia.GrupaRoboczaID IS NOT NULL
		
		GROUP BY GrupyRobocze.Nazwa
GO
/****** Object:  UserDefinedFunction [dbo].[OpisUslugi]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- utworzenie funkcji

-- funkcja przyjmuje za parametr numer ID usługi i zwraca podstawowe dane o usłudze: nazwę, właściciela, Opis

CREATE FUNCTION [dbo].[OpisUslugi]
	(@UslugaID INT)
RETURNS TABLE 
AS
RETURN

SELECT  GrupyRobocze.Nazwa,
			Uzytkownicy.Imie + ' ' + Uzytkownicy.Nazwisko AS WlascicielUslugi,
			Uslugi.Opis
FROM Uslugi 
	JOIN GrupyRobocze ON Uslugi.GrupaRoboczaID = GrupyRobocze.ID
	JOIN Uzytkownicy ON Uslugi.WlascicielUslugiID = Uzytkownicy.ID 
WHERE
	Uslugi.ID = @UslugaID
GO
/****** Object:  UserDefinedFunction [dbo].[PokazZamowieniaUzytkownika]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--funkcja przyjmmuje za parametr numer ID uzytkownika i zwraca numery zamówień jakie zostały złożone przez danego użytkownika
CREATE FUNCTION [dbo].[PokazZamowieniaUzytkownika]
	(@UzytkownikID INT)
RETURNS TABLE 
AS
RETURN

SELECT DISTINCT Zamowienia.ID AS NumerZamowienia

FROM Zamowienia 
	JOIN Uslugi ON Zamowienia.OtwartePrzez = Uslugi.WlascicielUslugiID
	
WHERE Uslugi.WlascicielUslugiID = @UzytkownikID
GO
/****** Object:  UserDefinedFunction [dbo].[SprawdzZyskGrupy]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Funkcja przyjmuje za parametr nazwę grupy i zwraca zysk wygenerowany przez wybraną grupę

CREATE FUNCTION [dbo].[SprawdzZyskGrupy]
(  @NazwaGrupy VARCHAR(250) )
RETURNS TABLE
AS
RETURN 

SELECT Zysk FROM v_ZyskiGrup
WHERE NazwaGrupyRoboczej = @NazwaGrupy
GO
/****** Object:  Table [dbo].[Zadania]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zadania](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UslugaID] [int] NULL,
	[Nazwa] [nvarchar](250) NOT NULL,
	[GrupaRoboczaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ZadaniaUslugi]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Funkcja przyjmuje parametr ID uslugi i zwraca zadania związane z wykonaniem danej usługi

CREATE FUNCTION [dbo].[ZadaniaUslugi]
(  @UslugaID INT )
RETURNS TABLE
AS
RETURN 

SELECT Uslugi.Nazwa 
FROM Zadania
	 JOIN Uslugi ON Zadania.UslugaID = Uslugi.ID
WHERE Zadania.UslugaID = @UslugaID
GO
/****** Object:  Table [dbo].[Firmy]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Firmy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](500) NOT NULL,
	[NIP] [nvarchar](20) NOT NULL,
	[KodPocztowy] [nvarchar](20) NULL,
	[Miasto] [nvarchar](250) NULL,
	[Adres] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunkcjeUzytkownikow]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunkcjeUzytkownikow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Katalogi]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Katalogi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](100) NOT NULL,
	[Opis] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategorie]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategorie](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](250) NOT NULL,
	[KatalogID] [int] NULL,
	[Opis] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statusy]    Script Date: 23-Jun-18 11:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statusy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Firmy] ON 

INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (1, N'Acer', N'12356789', N'95110', N'San Jose', N'333 W. San Carlos St.,Ste. 1500')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (2, N'Adobe Systems', N'12356790', N'92406', N'San Jose', N'345 Park Avenue')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (3, N'Adtran', N'12356791', N'32999', N'Huntsville', N'901 Explorer Boulevard')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (4, N'Altiris', N'12356792', N'94043', N'Mountain View', N'350 Ellis Street')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (5, N'Amazon', N'12356793', N'95410', N'Seattle', N'1200 12th Ave. South, Ste. 1200')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (6, N'America Online', N'12356794', N'10003', N'New York, NY 10003', N'770 Broadway')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (7, N'Apache Software Foundation', N'12356795', N'72656', N'Houston', N'2000 Post Oak Boulevard, Suite 100')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (8, N'APC', N'12356796', N'10018', N'New York', N'520 8th Ave., 21st Floor')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (9, N'Apple', N'12356797', N'95014', N'Cupertino', N'1 Infinite Loop')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (10, N'Asus', N'12356798', N'94539', N'Fremont', N'800 Corporate Way')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (11, N'AT&T', N'12356799', N'75202', N'Dallas', N'208 South Akard Street')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (12, N'Autodesk Inc.', N'12356800', N'94903', N'San Rafael', N'111 McInnis Parkway')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (13, N'Backweb', N'12356801', N'48092', N'Park Afek', N'10 Haamal Street')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (14, N'Bradbury', N'12356802', N'67107', N'Moundridge', N'1200 E.Cole / PO Box 667')
INSERT [dbo].[Firmy] ([ID], [Nazwa], [NIP], [KodPocztowy], [Miasto], [Adres]) VALUES (15, N'Broadcom', N'12356803', N'89579', N'Irvine', N'5300 California Avenue')
SET IDENTITY_INSERT [dbo].[Firmy] OFF
SET IDENTITY_INSERT [dbo].[FunkcjeUzytkownikow] ON 

INSERT [dbo].[FunkcjeUzytkownikow] ([ID], [Nazwa]) VALUES (3, N'Admin')
INSERT [dbo].[FunkcjeUzytkownikow] ([ID], [Nazwa]) VALUES (4, N'Klient')
INSERT [dbo].[FunkcjeUzytkownikow] ([ID], [Nazwa]) VALUES (5, N'Kontraktowy Pracownik')
INSERT [dbo].[FunkcjeUzytkownikow] ([ID], [Nazwa]) VALUES (2, N'Manager')
INSERT [dbo].[FunkcjeUzytkownikow] ([ID], [Nazwa]) VALUES (1, N'Standardowy Pracownik')
SET IDENTITY_INSERT [dbo].[FunkcjeUzytkownikow] OFF
SET IDENTITY_INSERT [dbo].[GrupyRobocze] ON 

INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (1, N'CAB Approval', 137, 1, N'CAB approvers')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (2, N'Capacity Mgmt', 142, 2, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (3, N'Change Management', 147, 3, N'Change Management Group')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (4, N'Database', 152, 4, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (5, N'Database Atlanta', 157, 5, N'Manages databases hosted in Atlanta')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (6, N'Database San Diego', 162, 6, N'Manages databases hosted in San Diego')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (7, N'eCAB Approval', 167, 7, N'eCAB Approvers')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (8, N'Field Services', 172, 8, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (9, N'Hardware', 177, 9, N'IT department responsible for all hardware requests including installation and repair')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (10, N'Incident Management', 182, 10, N'Incident Management Group')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (11, N'IT Finance CAB', 187, 11, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (12, N'IT Securities', 192, 12, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (13, N'ITSM Engineering', 197, 13, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (14, N'LDAP Admins', 202, 14, N'LDAP admins group')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (15, N'Network', 207, 15, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (16, N'Network CAB Managers', 212, 1, N'Group to represent the CAB Managers for Network related
   changes')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (17, N'NY DB', 217, 2, N'Manages databases hosted in New York')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (18, N'Procurement', 222, 3, N'Responsible for ordering catalog items, or moving them
   from inventory that are In Stock')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (19, N'Project Mgmt', 227, 4, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (20, N'RMA Approvers', 232, 5, N'Responsible for Return Material Authorization approvals
   and RMA number allocations in Inventory Management')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (21, N'Service Desk', 237, 6, N'')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (22, N'Software', 242, 7, N'IT department responsible for all software requests including installation and repair')
INSERT [dbo].[GrupyRobocze] ([ID], [Nazwa], [WlascicielGrupyID], [FirmaID], [Opis]) VALUES (23, N'Team Development Code Reviewers', 77, 8, N'Review, approve and/or reject the code pushed to parent instance.')
SET IDENTITY_INSERT [dbo].[GrupyRobocze] OFF
SET IDENTITY_INSERT [dbo].[Katalogi] ON 

INSERT [dbo].[Katalogi] ([ID], [Nazwa], [Opis]) VALUES (1, N'KatalogUsług', N'GłównyKatalog')
INSERT [dbo].[Katalogi] ([ID], [Nazwa], [Opis]) VALUES (2, N'KatalogTechniczny', N'')
SET IDENTITY_INSERT [dbo].[Katalogi] OFF
SET IDENTITY_INSERT [dbo].[Kategorie] ON 

INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (1, N'Facilities', 1, N'Offers facilities management services including moving
and relocation as well as location improvement, furniture and
decorative services on a company wide basis')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (2, N'Hardware', 1, N'Order from a variety of hardware to meet your business
needs, including phones, tablets and laptops.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (3, N'Accessories', 2, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (4, N'Furniture and Decor', 1, N'Order new furniture, and fixtures, or request for
furniture to be repaired. Cubicle modifications can also be ordered
here')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (5, N'Information', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (6, N'Local Business Support', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (7, N'Moves', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (8, N'Security and Access', 1, N'Security related services including badge and keys requisitions')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (9, N'Top Requests', 1, N'The most commonly requested items from the service catalog over the previous 7 days. ')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (10, N'Tablets', 1, N'A range of tablet devices for employees in the field.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (11, N'Standard Changes', 1, N'Standard Change Template Library')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (12, N'Server Standard Changes', 1, N'Standard change templates related to servers and attached storage. Reboot server, increase size of storage LUN etc')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (13, N'Health, Environment, and Safety', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (14, N'Janitorial', 1, N'Request for cleaning services to be performed
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (15, N'Can We Help You?', 1, N'Your IT gateway. Report issues and submit requests.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (16, N'Mobiles', 1, N'Cell phones to meet your business needs.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (17, N'Maintenance and Repair', 1, N'Request for a shared office equipment to be repaired
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (18, N'Remodeling and Space Planning', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (19, N'Lab Services Request (Richmond)', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (20, N'Carpentry', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (21, N'Electrical', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (22, N'Painting', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (23, N'Machine / Glass / Welding', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (24, N'Services', 2, N'Request for IT services to be performed')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (25, N'Role Delegation', 1, N'Delegate your roles to another user or group
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (26, N'Emergency Changes', 2, N'Request a priority change in the event of failure or
degradation of business systems.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (27, N'Virtual Resources', 1, N'Lorem Ipsum')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (28, N'Peripherals', 1, N'End user peripherals such as mobile phone cases, dongles,
and cables
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (29, N'Template Management', 1, N'Propose a new Standard Change Template. Modify or Retire an existingStandard Change Template.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (30, N'Office', 1, N'Office services such as printing, supplies requisition
and document shipping and delivery.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (31, N'Software', 1, N'A range of software products available for installation
on your corporate laptop or desktop computer.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (32, N'Laptops', 1, N'Laptop computers for mobile workers.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (33, N'Printers', 1, N'A range of printers for office installation, providing
different feature sets.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (34, N'Network Standard Changes', 1, N'Standard change templates relating to network related changes: Adding new switches, upgrading IOS etc')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (35, N'Desktops', 1, N'Desktop computers for your work area.')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (36, N'Quick Links', 1, N'Quick access to other company information and portals.
')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (37, N'Departmental Services', 1, N'Services offered by different departments in the organization')
INSERT [dbo].[Kategorie] ([ID], [Nazwa], [KatalogID], [Opis]) VALUES (38, N'Infrastructure', 2, N'Datacenter hardware and services to the support business
systems.
')
SET IDENTITY_INSERT [dbo].[Kategorie] OFF
SET IDENTITY_INSERT [dbo].[Statusy] ON 

INSERT [dbo].[Statusy] ([ID], [Nazwa]) VALUES (2, N'Closed Complete')
INSERT [dbo].[Statusy] ([ID], [Nazwa]) VALUES (5, N'Closed Incomplete')
INSERT [dbo].[Statusy] ([ID], [Nazwa]) VALUES (1, N'Open')
INSERT [dbo].[Statusy] ([ID], [Nazwa]) VALUES (3, N'Pending')
INSERT [dbo].[Statusy] ([ID], [Nazwa]) VALUES (4, N'Work in progress')
SET IDENTITY_INSERT [dbo].[Statusy] OFF
SET IDENTITY_INSERT [dbo].[Uslugi] ON 

INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (1, N'Service Category Request', 28, N'Start managing your own service requests', 2, 1, CAST(0.00 AS Decimal(8, 2)), 10)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (2, N'Database Server & Oracle License', 37, N'Dell 6850 (4U) Rack Mount Server
  ', 7, 2, CAST(27000.00 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (3, N'Application Server (Large)', 25, N'Dell 2950 (2U) Rack Mount Server
  ', 12, 2, CAST(5600.00 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (4, N'Microsoft Visio Professional', 35, N'For PC, Compatible with Win 7 & 8
  ', 17, 1, CAST(0.00 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (5, N'Lotus Notes', 2, N'IBM Lotus Notes', 22, 1, CAST(50.00 AS Decimal(8, 2)), 17)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (6, N'Microsoft Project', 3, N'Manage projects, Organize tasks, Collaborate
  ', 27, 1, CAST(0.00 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (7, N'Adobe Creative Cloud', 8, N'More connected ways of creating and sharing
  ', 32, 1, CAST(0.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (8, N'OmniGraffle Professional', 3, N'Diagramming and drawing application
  ', 42, 1, CAST(0.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (9, N'iPhone 6s', 7, N'iPhone 6s', 47, 1, CAST(450.00 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (10, N'Snagit', 2, N'Image capture software for Mac & PC
  ', 52, 1, CAST(25.00 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (11, N'Application Server (Standard)', 1, N'Dell 1950 (1U) Rack Mount Server
  ', 57, 2, CAST(5600.00 AS Decimal(8, 2)), 17)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (12, N'Dreamweaver', 13, N'NULL', 62, 1, CAST(20.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (13, N'Change VLAN on a Cisco switchport', 28, N'NULL', 67, 1, CAST(0.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (14, N'Fireworks', 32, N'Adobe Systems Fireworks', 72, 1, CAST(20.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (15, N'QuickTime Pro', 6, N'Apple QuickTime Pro 7', 77, 1, CAST(0.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (16, N'Samsung Galaxy S7', 2, N'Samsung Galaxy S7', 82, 1, CAST(569.99 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (17, N'Request Knowledge Base', 12, N'Request for a Knowledge Base', 87, 1, CAST(0.00 AS Decimal(8, 2)), 5)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (18, N'SSL Certification', 24, N'Do you need to update your SSL Certification?
  ', 92, 1, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (19, N'Developer Laptop (Mac)', 30, N'Macbook Pro', 97, 1, CAST(1499.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (20, N'Acrobat', 14, N'Adobe Acrobat', 102, 1, CAST(0.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (21, N'Canon imageCLASS Laser Printer', 18, N'Canon - imageCLASS LBP-6650DN Laser Printer - Monochrome - 2400 x 600dpi Print - Plain Paper Print -', 107, 1, CAST(499.99 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (22, N'VMware Fusion', 11, N'The Best Way to Run Windows on a Mac
  ', 117, 1, CAST(0.00 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (23, N'Decommission local office Domain Controller', 35, N'NULL', 2, 1, CAST(0.00 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (24, N'Add network switch to datacenter cabinet', 34, N'NULL', 7, 1, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (25, N'Belkin iPad Mini Case', 25, N'Belkin iPad Mini 2 Case', 17, 1, CAST(50.00 AS Decimal(8, 2)), 5)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (26, N'OS X Yosemite', 37, N'OS X Yosemite (version 10.10.x) is apples eleventh
   major release of OS X, for Macs
  ', 22, 1, CAST(0.00 AS Decimal(8, 2)), 22)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (27, N'Corp VPN', 8, N'Remote access to Internal Corporate Systems
  ', 27, 1, CAST(0.00 AS Decimal(8, 2)), 11)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (28, N'Reboot Windows Server', 6, N'NULL', 32, 1, CAST(0.00 AS Decimal(8, 2)), 10)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (29, N'Packaging and Shipping', 33, N'Package and Ship inter-office or to external
   addresses
  ', 37, 1, CAST(0.00 AS Decimal(8, 2)), 12)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (30, N'Cubicle Modifications', 12, N'Cubicle creation, modification, and repair services
  ', 42, 1, CAST(0.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (31, N'Office Keys', 31, N'Request to get a new one', 47, 1, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (32, N'Request Security Escort', 12, N'Request a security escort', 52, 1, CAST(0.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (33, N'Brother Network-Ready Color Laser Printer', 26, N'Brother - Network-Ready Color Laser Printer', 62, 1, CAST(399.50 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (34, N'Report an Incident', 6, N'Report an Incident', 67, 1, CAST(0.00 AS Decimal(8, 2)), 14)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (35, N'New Email Account', 11, N'New Email Creation', 72, 1, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (36, N'Conference Room Reservations', 28, N'Reserve conference rooms and notify participants
  ', 77, 1, CAST(0.00 AS Decimal(8, 2)), 19)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (37, N'Videoconferencing', 33, N'Setup inter-office or external videoconferencing
  ', 82, 1, CAST(0.00 AS Decimal(8, 2)), 14)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (38, N'Paper and Supplies', 9, N'Order office supplies such as paper, stationery and
   computer supplies
  ', 87, 1, CAST(0.00 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (39, N'Access', 13, N'Microsoft Access', 92, 1, CAST(139.99 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (40, N'Standard Laptop', 37, N'Lenovo - Carbon x1', 97, 1, CAST(1100.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (41, N'Apple iPad 3', 34, N'Apple iPad 3', 102, 1, CAST(600.00 AS Decimal(8, 2)), 5)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (42, N'Cisco Jabber 10.5', 28, N'Collaborate Anywhere on Any Device with Cisco
   Jabber
  ', 107, 1, CAST(0.00 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (43, N'Samsung Galaxy S7 Edge', 8, N'Samsung Galaxy S7 Edge', 112, 1, CAST(669.99 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (44, N'OS X Mavericks', 32, N'OS X Mavericks (version 10.9.x) is apples tenth
   major release of OS X, for Macs
  ', 117, 1, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (45, N'Adobe Acrobat Pro', 27, N'Create, edit or convert PDF files
  ', 127, 1, CAST(0.00 AS Decimal(8, 2)), 4)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (46, N'Druva inSync, for Mac & PC', 1, N'High-speed, lightweight backups with Global
   deduplication
  ', 132, 1, CAST(0.00 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (47, N'Event Planning', 36, N'Event planning for 50 people', 137, 1, CAST(0.00 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (48, N'Assign Office Space', 17, N'Works in conjunction with the space planning area
  ', 142, 1, CAST(0.00 AS Decimal(8, 2)), 12)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (49, N'Clear BGP sessions on a Cisco router', 3, N'NULL', 147, 1, CAST(0.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (50, N'Repair Office Equipment', 12, N'Report malfunctions with a shared piece of office
   equipment such as a copier or network printer
  ', 152, 1, CAST(0.00 AS Decimal(8, 2)), 5)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (51, N'Carpet Cleaning', 6, N'Spot removal to large areas, we do it all
  ', 162, 1, CAST(0.00 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (52, N'User Facade', 23, N'User Facade', 167, 1, CAST(0.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (53, N'Sales Laptop', 11, N'Acer Aspire NX', 172, 1, CAST(1100.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (54, N'Belkin Neoprene Sleeve ', 37, N'For Notebooks up to 15.6', 177, 1, CAST(29.48 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (55, N'Email Account (old)', 27, N'Standard email service with Outlook and Outlook Web
  ', 182, 1, CAST(0.00 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (56, N'Office Printer', 33, N'HP Laserjet 4240n', 187, 1, CAST(999.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (57, N'Google Nexus 7', 25, N'Google Nexus 7', 192, 1, CAST(199.99 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (58, N'Telephone Extension', 15, N'IP 560 Phone', 197, 1, CAST(195.00 AS Decimal(8, 2)), 4)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (59, N'Apple iPhone 5', 33, N'Apple iPhone 5', 202, 1, CAST(599.99 AS Decimal(8, 2)), 4)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (60, N'Apple Watch Series 2', 34, N'Apple Watch Series 2', 207, 1, CAST(369.99 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (61, N'Apple Watch', 14, N'Apple Watch - Their most personal device ever', 212, 1, CAST(349.99 AS Decimal(8, 2)), 1)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (62, N'Propose a new Standard Change Template', 20, N'NULL', 217, 1, CAST(0.00 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (63, N'Microsoft Surface Pro 3', 26, N'Microsoft Surface Pro 3', 222, 1, CAST(1399.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (64, N'Apple iPhone 6s Plus', 29, N'Apple iPhone 6s Plus', 227, 1, CAST(799.99 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (65, N'Apple iPhone 6s', 30, N'Apple iPhone 6s', 232, 1, CAST(799.99 AS Decimal(8, 2)), 22)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (66, N'Modify a Standard Change Template', 30, N'NULL', 237, 1, CAST(0.00 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (67, N'Retire a Standard Change Template', 30, N'NULL', 77, 1, CAST(0.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (68, N'Blackberry', 23, N'A Blackberry Wireless Device', 82, 1, CAST(500.00 AS Decimal(8, 2)), 14)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (69, N'BlackBerry Z10', 35, N'A 4.2 touch screen BlackBerry cell phone. 4G ready
   and contains 16GB internal storage.
  ', 87, 1, CAST(700.00 AS Decimal(8, 2)), 22)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (70, N'Google Droid Razr Maxx', 6, N'Motorola Droid Razr Maxx 2', 92, 1, CAST(99.99 AS Decimal(8, 2)), 5)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (71, N'Windows Surface Pro 4', 33, N'Microsoft Surface Pro 4', 97, 1, CAST(1699.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (72, N'Ask a Question', 14, N'Ask a Question', 102, 1, CAST(0.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (73, N'Server Reboot', 17, N'Schedule a Server Reboot', 107, 2, CAST(0.00 AS Decimal(8, 2)), 10)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (74, N'Apple MacBook Pro 15', 4, N'Apple MacBook Pro', 112, 1, CAST(1099.99 AS Decimal(8, 2)), 4)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (75, N'Grant role delegation rights within a group', 6, N'NULL', 117, 1, CAST(0.00 AS Decimal(8, 2)), 10)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (76, N'Big Data Analysis', 12, N'Request big data analysis environment
  ', 122, 1, CAST(0.00 AS Decimal(8, 2)), 1)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (77, N'Dell 24 UltraSharp Monitor ', 17, N'24 UltraSharp Monitor', 127, 1, CAST(300.00 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (78, N'External Monitor', 25, N'LG IPS 27 Monitor', 132, 1, CAST(0.00 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (79, N'Ilyama 24', 30, N'ilyama ProLite 24 Monitor', 137, 1, CAST(139.84 AS Decimal(8, 2)), 10)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (80, N'LG 22 LCD Monitor', 5, N'22 LCD Widescreen Monitor', 142, 1, CAST(200.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (81, N'Planar 24 LED Monitor', 24, N'24 Widescreen LED', 147, 1, CAST(140.00 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (82, N'Password Reset', 22, N'Request a reset of a password for a service or an
   application.', 152, 1, CAST(0.00 AS Decimal(8, 2)), 19)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (83, N'Samsung 24 HDMI', 30, N'Samsung 24'' monitor', 157, 1, CAST(292.28 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (84, N'Asus G Series', 21, N'ASUS G Series', 162, 1, CAST(839.99 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (85, N'Logitech Wireless Mouse', 22, N'PC / Mac Compatible', 167, 1, CAST(35.88 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (86, N'International Plan Request', 2, N'International Plan Request', 172, 1, CAST(0.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (87, N'Report Performance Problem', 15, N'Request assistance with a performance issue you are
   having with a service or an application.', 177, 1, CAST(0.00 AS Decimal(8, 2)), 22)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (88, N'Create Incident', 12, N'Create an Incident record to report and request
   assistance with an issue you are having', 182, 1, CAST(0.00 AS Decimal(8, 2)), 11)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (89, N'Delegate roles to group member', 6, N'NULL', 187, 1, CAST(0.00 AS Decimal(8, 2)), 7)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (90, N'Consulting Request ', 24, N'Have a question for another engineering group?
  ', 192, 1, CAST(0.00 AS Decimal(8, 2)), 14)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (91, N'Database Restore', 24, N'Database Restore', 197, 2, CAST(0.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (92, N'Logitech USB Headset for PC & Mac', 24, N'PC/Mac Compatible Headset', 202, 1, CAST(29.99 AS Decimal(8, 2)), 6)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (93, N'Plantronics Wideband Headset', 8, N'Wired, Over-the-head headset', 207, 1, CAST(79.67 AS Decimal(8, 2)), 16)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (94, N'Microsoft Wired Keyboard', 16, N'PC / Mac Compatible', 212, 1, CAST(11.92 AS Decimal(8, 2)), 20)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (95, N'Emergency Change', 20, N'Open an Emergency Change', 217, 1, CAST(0.00 AS Decimal(8, 2)), 20)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (96, N'Development Laptop (PC)', 25, N'Dell XPS 13', 222, 1, CAST(1100.00 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (97, N'Endpoint Security', 30, N'Sophos endpoint security', 227, 1, CAST(0.00 AS Decimal(8, 2)), 15)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (98, N'Report Outage', 24, N'Report an outage of a service or an application.
  ', 232, 1, CAST(0.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (99, N'Apple USB Ethernet Adapter', 17, N'Macbook Air Ethernet Adapter', 237, 1, CAST(28.13 AS Decimal(8, 2)), 20)
GO
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (100, N'Apple Thunderbolt to Ethernet Adapter', 16, N'For Macbook Air/Pro', 242, 1, CAST(30.89 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (101, N'MacBook Air Power Adapter', 17, N'Power Adapter', 247, 1, CAST(75.84 AS Decimal(8, 2)), 18)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (102, N'MacBook Pro Power Adapter', 29, N'MagSafe 2, for Macbook Pro ', 2, 1, CAST(75.84 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (103, N'3M Privacy Filter - Macbook Pro Retina', 38, N'Privacy Filter', 7, 1, CAST(40.31 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (104, N'3M Privacy Filter - MacBook Pro', 9, N'Privacy Filter', 12, 1, CAST(42.23 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (105, N'STM MacBook Pro Sleeve ', 27, N'STM Mac Sleeve – S­15', 17, 1, CAST(25.78 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (106, N'STM MacBook Air Sleeve', 23, N'STM Mac Sleeve – S­13', 22, 1, CAST(24.26 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (107, N'Executive Desktop', 27, N'Dell Precision 690', 27, 1, CAST(1875.00 AS Decimal(8, 2)), 19)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (108, N'Firewall Rule Change', 21, N'Cisco Firewall Appliance', 32, 1, CAST(0.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (109, N'Lenovo ThinkPad Power Adapter - 135W', 24, N'For Lenovo Thinkpad, AC Adapter, 135W
  ', 37, 1, CAST(99.99 AS Decimal(8, 2)), 11)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (110, N'Lenovo Thinkpad Power Adapter - 90W', 13, N'For Lenovo Thinkpad, T-Series, 90W
  ', 42, 1, CAST(60.00 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (111, N'Lenovo USB Ethernet Adapter', 28, N'For Lenovo X1 Carbon', 47, 1, CAST(28.79 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (112, N'Lenovo X1 Carbon Power Adapter', 27, N'For Lenovo X1 Carbon', 52, 1, CAST(60.00 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (113, N'3M Privacy Filter - Lenovo X1 Carbon', 16, N'Privacy Filter - X1 Carbon', 2, 1, CAST(43.19 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (114, N'Group Modifications', 23, N'Modify an Active Directory Group
  ', 7, 1, CAST(0.00 AS Decimal(8, 2)), 12)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (115, N'Spigen iPhone 6 Case', 12, N'For iPhone 6', 12, 1, CAST(35.00 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (116, N'Notebook Computer Loaner', 5, N'Loaner Laptop', 17, 1, CAST(0.00 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (117, N'Spigen Samsung GS5 Case', 10, N'Samsung Galaxy S5', 22, 1, CAST(35.00 AS Decimal(8, 2)), 16)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (118, N'Spigen iPhone 5/5s Case', 33, N'iPhone 5 and 5s', 27, 1, CAST(35.00 AS Decimal(8, 2)), 23)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (119, N'Apple iPhone 5 Cable ', 4, N'Apple iPhone 5 Cable', 32, 1, CAST(19.00 AS Decimal(8, 2)), 21)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (120, N'Apple iPhone 4 Cable', 1, N'For Apple iPhone 4/4S', 37, 1, CAST(19.00 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (121, N'Install Software', 10, N'Request for software installation service
  ', 42, 1, CAST(0.00 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (122, N'StarTech Mini Display Port to VGA Adapter', 25, N'PC / Mac Compatible', 47, 1, CAST(24.50 AS Decimal(8, 2)), 3)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (123, N'Office Desktop', 12, N'Dell Desktop', 52, 1, CAST(1200.00 AS Decimal(8, 2)), 16)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (124, N'StarTech USB Mini Hub', 30, N'4 Port, USB 2.0', 2, 1, CAST(11.55 AS Decimal(8, 2)), 2)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (125, N'StarTech USB to DVI Adapter', 21, N'Multi Monitor Adapter', 7, 1, CAST(49.99 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (126, N'StarTech Mini Display Port to DVI Adapter', 35, N'PC / Mac Compatible', 12, 1, CAST(17.23 AS Decimal(8, 2)), 8)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (127, N'Request for Backup', 35, N'Backup system, data files or database
  ', 17, 1, CAST(0.00 AS Decimal(8, 2)), 11)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (128, N'Item Designer Category Request', 23, N'Request a category that you can use to create your own catalog items', 22, 1, CAST(0.00 AS Decimal(8, 2)), 11)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (129, N'Server Tuning', 1, N'Request virtual server tuning', 27, 1, CAST(0.00 AS Decimal(8, 2)), 14)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (130, N'Table Index', 33, N'Do you need to index a database table?
  ', 32, 1, CAST(0.00 AS Decimal(8, 2)), 13)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (131, N'VM Provisioning', 1, N'Do you need a Virtual Machine?', 37, 2, CAST(0.00 AS Decimal(8, 2)), 20)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (132, N'Whitelist IP', 4, N'Need to whitelist an IP address?
  ', 42, 1, CAST(0.00 AS Decimal(8, 2)), 9)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (133, N'Finishing Services', 6, N'Professional binding and finishing for documents
  ', 47, 1, CAST(0.00 AS Decimal(8, 2)), 12)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (134, N'Document Creation', 20, N'Document creation and design services
  ', 52, 1, CAST(0.00 AS Decimal(8, 2)), 1)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (135, N'Web Conferencing', 8, N'Request to setup web conferencing
  ', 57, 1, CAST(0.00 AS Decimal(8, 2)), 1)
INSERT [dbo].[Uslugi] ([ID], [Nazwa], [Kategoria], [Opis], [WlascicielUslugiID], [KatalogID], [Cena], [GrupaRoboczaID]) VALUES (136, N'Provision a Database', 11, N'Request to provison a new database
  ', 62, 1, CAST(0.00 AS Decimal(8, 2)), 12)
SET IDENTITY_INSERT [dbo].[Uslugi] OFF
SET IDENTITY_INSERT [dbo].[Uzytkownicy] ON 

INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (1, N'Abel', N'Tuter', N'89916779839', N'abel.tuter@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (2, N'Abraham', N'Lincoln', N'89550384699', N'abraham.lincoln@example.com', N'(555) 555-0004', 15, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (3, N'Adela', N'Cervantsz', N'6983544172', N'adela.cervantsz@example.com', N'', 1, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (4, N'Aileen', N'Mottern', N'40929733182', N'aileen.mottern@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (5, N'Alejandra', N'Prenatt', N'95757139452', N'alejandra.prenatt@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (6, N'Alejandro', N'Mascall', N'6680911140', N'alejandro.mascall@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (7, N'Alene', N'Rabeck', N'49255519967', N'alene.rabeck@example.com', N'', 12, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (8, N'Alfonso', N'Griglen', N'47508977593', N'alfonso.griglen@example.com', N'', 12, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (9, N'Alissa', N'Mountjoy', N'43564420961', N'alissa.mountjoy@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (10, N'Allan', N'Schwantd', N'951280368', N'allan.schwantd@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (11, N'Allie', N'Pumphrey', N'90138870989', N'allie.pumphrey@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (12, N'Allyson', N'Gillispie', N'5040662233', N'allyson.gillispie@example.com', N'', 13, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (13, N'Alva', N'Pennigton', N'72107656831', N'alva.pennigton@example.com', N'', 3, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (14, N'Alyssa', N'Biasotti', N'68855149152', N'alyssa.biasotti@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (15, N'Amelia', N'Caputo', N'93761499314', N'amelia.caputo@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (16, N'Amos', N'Linnan', N'8913927577', N'amos.linnan@example.com', N'', 13, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (17, N'Andrew', N'Jackson', N'82753723130', N'andrew.jackson@example.com', N'(555) 555-0005', 2, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (18, N'Angelique', N'Schermerhorn', N'40823905581', N'angelique.schermerhorn@example.com', N'', 15, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (19, N'Angelo', N'Ferentz', N'69316102356', N'angelo.ferentz@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (20, N'Annabelle', N'Coger', N'66396111847', N'annabelle.coger@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (21, N'Annette', N'Frietas', N'40466461131', N'annette.frietas@example.com', N'', 3, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (22, N'Annie', N'Approver', N'43498969772', N'annie.approver@example.com', N'', 6, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (23, N'Antione', N'Mccleary', N'68265523418', N'antione.mccleary@example.com', N'', 12, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (24, N'Antony', N'Thierauf', N'70542328260', N'antony.thierauf@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (25, N'Approver', N'User', N'6272544214', N'approver@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (26, N'Armando', N'Kolm', N'5517382652', N'armando.kolm@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (27, N'Armando', N'Papik', N'6996850336', N'armando.papik@example.com', N'', 15, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (28, N'Ashley', N'Leonesio', N'90255127598', N'ashley.leonesio@example.com', N'', 8, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (29, N'Asset', N'Manager', N'9244810345', N'itam@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (30, N'ATF', N'User', N'63769682439', N'ATF.User@now.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (31, N'Athena', N'Fontanilla', N'98283147278', N'athena.fontanilla@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (32, N'Audra', N'Cantu', N'55927778554', N'audra.cantu@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (33, N'Avery', N'Parbol', N'99969354822', N'avery.parbol@example.com', N'', 12, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (34, N'Barbara', N'Hindley', N'85215129628', N'barbara.hindley@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (35, N'Bart', N'Hachey', N'9096759315', N'bart.hachey@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (36, N'Barton', N'Friesner', N'42468136185', N'barton.friesner@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (37, N'Benchmark', N'Scheduler', N'5336495219', N'', N'', 10, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (38, N'Benjamin', N'Schkade', N'76870986520', N'benjamin.schkade@example.com', N'', 8, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (39, N'Bernard', N'Laboy', N'93110458273', N'bernard.laboy@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (40, N'Bert', N'Schadle', N'70478196521', N'bert.schadle@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (41, N'Berta', N'Karczewski', N'99634971953', N'berta.karczewski@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (42, N'Bertie', N'Luby', N'80601258595', N'bertie.luby@example.com', N'', 7, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (43, N'Bertram', N'Quertermous', N'5796681616', N'bertram.quertermous@example.com', N'', 5, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (44, N'Bess', N'Marso', N'951367189', N'bess.marso@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (45, N'Beth', N'Anglin', N'97120430472', N'beth.anglin@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (46, N'Bette', N'Barcelona', N'87910571730', N'bette.barcelona@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (47, N'Beverley', N'Bunche', N'58960359790', N'beverley.bunche@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (48, N'Beverly', N'Cambel', N'90499195367', N'beverly.cambel@example.com', N'', 1, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (49, N'Billie', N'Cowley', N'84976186679', N'billie.cowley@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (50, N'Billie', N'Tinnes', N'85533783810', N'billie.tinnes@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (51, N'Boris', N'Catino', N'8591196100', N'boris.catino@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (52, N'Bow', N'Ruggeri', N'79405106825', N'bow.ruggeri@example.com', N'', 3, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (53, N'Bradly', N'Hasselvander', N'7551629753', N'bradly.hasselvander@example.com', N'', 9, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (54, N'Brant', N'Darnel', N'832103632', N'brant.darnel@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (55, N'Brendan', N'Qin', N'8090527882', N'brendan.qin@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (56, N'Brent', N'Vaidya', N'98186541618', N'brent.vaidya@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (57, N'Brice', N'Hedglin', N'6875733507', N'brice.hedglin@example.com', N'', 1, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (58, N'Bridget', N'Bottella', N'84728829596', N'bridget.bottella@example.com', N'', 11, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (59, N'Bridget', N'Knightly', N'85486406134', N'bridget.knightly@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (60, N'Bridgett', N'Retort', N'4666296379', N'bridgett.retort@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (61, N'Bryan', N'Rovell', N'93568952921', N'bryan.rovell@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (62, N'Bryant', N'Bouliouris', N'8576614993', N'bryant.bouliouris@example.com', N'', 11, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (63, N'Bud', N'Richman', N'97226811214', N'bud.richman@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (64, N'Burton', N'Brining', N'97723894360', N'burton.brining@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (65, N'Buster', N'Wubbel', N'44459893182', N'buster.wubbel@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (66, N'Byron', N'Fortuna', N'67918373232', N'byron.fortuna@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (67, N'Caitlin', N'Reiniger', N'77735180385', N'caitlin.reiniger@example.com', N'', 2, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (68, N'Callie', N'Leboeuf', N'85523653219', N'callie.leboeuf@example.com', N'', 6, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (69, N'Candice', N'Bruckman', N'426625335', N'candice.bruckman@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (70, N'Carla', N'Humble', N'51762597522', N'carla.humble@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (71, N'Carla', N'Sirbaugh', N'71838891499', N'carla.sirbaugh@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (72, N'Carmel', N'Overfelt', N'73159672545', N'carmel.overfelt@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (73, N'Carmella', N'Wishman', N'41607730338', N'carmella.wishman@example.com', N'', 3, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (74, N'Carol', N'Coughlin', N'76627968987', N'carol.coughlin@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (75, N'Carol', N'Krisman', N'86492120837', N'carol.krisman@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (76, N'Carolina', N'Kinlaw', N'66860804446', N'carolina.kinlaw@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (77, N'Cary', N'Mccamey', N'7082889859', N'cary.mccamey@example.com', N'', 9, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (78, N'Cathryn', N'Nicolaus', N'77657422267', N'cathryn.nicolaus@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (79, N'Celia', N'Slavin', N'61983516856', N'celia.slavin@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (80, N'Certification', N'Admin', N'91716786909', N'certification.admin@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (81, N'Certification', N'User', N'5949979243', N'certification@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (82, N'Chad', N'Araiza', N'64899529251', N'chad.araiza@example.com', N'', 5, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (83, N'Chad', N'Miklas', N'53287927966', N'chad.miklas@example.com', N'', 2, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (84, N'Change', N'Manager', N'5034991690', N'change.manager@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (85, N'Charity', N'Dyckman', N'53149904611', N'charity.dyckman@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (86, N'Charles', N'Beckley', N'82275507796', N'charles.beckley@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (87, N'Charlie', N'Whitherspoon', N'41686382176', N'charlie.whitherspoon@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (88, N'Chase', N'Furler', N'42757116143', N'chase.furler@example.com', N'', 9, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (89, N'Cherie', N'Fuhri', N'68629189774', N'cherie.fuhri@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (90, N'Cherie', N'Schronce', N'46246163', N'cherie.schronce@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (91, N'Chi', N'Greenlaw', N'59749226890', N'chi.greenlaw@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (92, N'Christa', N'Bodenschatz', N'45821931442', N'christa.bodenschatz@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (93, N'Christen', N'Mitchell', N'7615443284', N'christen.mitchell@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (94, N'Christian', N'Marnell', N'94866776926', N'christian.marnell@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (95, N'Chuck', N'Farley', N'6595240240', N'chuck.farley@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (96, N'Claire', N'Moyerman', N'63382440963', N'claire.moyerman@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (97, N'Clarice', N'Knower', N'41753230498', N'clarice.knower@example.com', N'', 13, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (98, N'Claudio', N'Loose', N'49899395827', N'claudio.loose@example.com', N'', 7, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (99, N'Coleman', N'Cuneo', N'51701470225', N'coleman.cuneo@example.com', N'', 6, 4)
GO
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (100, N'Colin', N'Altonen', N'9178447330', N'colin.altonen@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (101, N'Concetta', N'Sarchett', N'71138227543', N'concetta.sarchett@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (102, N'Conrad', N'Lanfear', N'634634966', N'conrad.lanfear@example.com', N'', 13, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (103, N'Corinne', N'Cowan', N'4312780377', N'corinne.cowan@example.com', N'', 6, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (104, N'Courtney', N'Shishido', N'51312404647', N'courtney.shishido@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (105, N'Credential', N'Admin', N'56366859833', N'cred.admin@example.com', N'(555) 555-5557', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (106, N'Cristina', N'Sharper', N'48629115186', N'cristina.sharper@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (107, N'Cristopher', N'Wiget', N'82740701971', N'cristopher.wiget@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (108, N'Cruz', N'Roudabush', N'52296989124', N'cruz.roudabush@example.com', N'', 9, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (109, N'Curt', N'Menedez', N'97847886902', N'curt.menedez@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (110, N'Cyril', N'Behen', N'7128745684', N'cyril.behen@example.com', N'', 12, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (111, N'Damion', N'Matkin', N'98662591359', N'damion.matkin@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (112, N'Danette', N'Fostervold', N'633130582', N'danette.fostervold@example.com', N'', 15, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (113, N'Daniel', N'Zill', N'54899615521', N'daniel.zill@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (114, N'Danny', N'Dales', N'74327709870', N'danny.dales@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (115, N'Darrel', N'Ruffins', N'6555319527', N'darrel.ruffins@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (116, N'Darrel', N'Tork', N'96824762150', N'darrel.tork@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (117, N'Darrell', N'Amrich', N'65594139602', N'darrell.amrich@example.com', N'', 13, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (118, N'Darren', N'Merlin', N'88148287251', N'darren.merlin@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (119, N'Darrin', N'Neiss', N'79405964599', N'darrin.neiss@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (120, N'David', N'Dan', N'79401334163', N'david.dan@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (121, N'David', N'Loo', N'85287635935', N'david.loo@example.com', N'', 3, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (122, N'Davin', N'Czukowski', N'91601871777', N'davin.czukowski@example.com', N'', 2, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (123, N'Davis', N'Brevard', N'80850334634', N'davis.brevard@example.com', N'', 12, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (124, N'Davis', N'Heideman', N'49638325632', N'davis.heideman@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (125, N'Deandre', N'Resendiz', N'618924227', N'deandre.resendiz@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (126, N'Deanna', N'Gerbi', N'51997140752', N'deanna.gerbi@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (127, N'Deepa', N'Shah', N'6141091270', N'deepa.shah@example.com', N'', 3, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (128, N'Delmer', N'Delucas', N'9861637815', N'delmer.delucas@example.com', N'', 8, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (129, N'Delphine', N'Helmich', N'73272375869', N'delphine.helmich@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (130, N'Denice', N'Nordlinger', N'5550618940', N'denice.nordlinger@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (131, N'Denise', N'Speegle', N'8165647743', N'denise.speegle@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (132, N'Dennis', N'Millar', N'85339365892', N'dennis.millar@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (133, N'Denver', N'Topete', N'89381420617', N'denver.topete@example.com', N'', 8, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (134, N'Derek', N'Kreutzbender', N'79435858322', N'derek.kreutzbender@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (135, N'Deshawn', N'Inafuku', N'58329985185', N'deshawn.inafuku@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (136, N'Devon', N'Samrah', N'80416323363', N'devon.samrah@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (137, N'Devon', N'Teston', N'6797255098', N'devon.teston@example.com', N'', 2, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (138, N'Diana', N'Temple', N'9633018551', N'diana.temple@example.com', N'', 1, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (139, N'Diann', N'Burigsay', N'62194636699', N'diann.burigsay@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (140, N'Dionne', N'Borycz', N'4713385161', N'dionne.borycz@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (141, N'Dollie', N'Daquino', N'5849189524', N'dollie.daquino@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (142, N'Dollie', N'Pillitteri', N'99763410980', N'dollie.pillitteri@example.com', N'', 12, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (143, N'Don', N'Goodliffe', N'48981783639', N'don.goodliffe@example.com', N'', 5, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (144, N'Don', N'Mestler', N'67542672289', N'don.mestler@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (145, N'Donald', N'Sherretts', N'41565116852', N'donald.sherretts@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (146, N'Doreen', N'Sakurai', N'74417789905', N'doreen.sakurai@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (147, N'Dorothea', N'Sweem', N'46277749244', N'dorothea.sweem@example.com', N'', 9, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (148, N'Dorthy', N'Alexy', N'9236278315', N'dorthy.alexy@example.com', N'', 4, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (149, N'Doug', N'Matrisciano', N'70153905928', N'doug.matrisciano@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (150, N'Dude', N'Lewbowskie', N'7531455934', N'dude.lewbowskie@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (151, N'Dwain', N'Agricola', N'74573444340', N'dwain.agricola@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (152, N'Dwain', N'Cuttitta', N'88422965891', N'dwain.cuttitta@example.com', N'', 11, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (153, N'Dwayne', N'Maddalena', N'54351898719', N'dwayne.maddalena@example.com', N'', 10, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (154, N'Ed', N'Gompf', N'83157955567', N'ed.gompf@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (155, N'Eddie', N'Gauer', N'44999179180', N'eddie.gauer@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (156, N'Edgardo', N'Prudente', N'72925968997', N'edgardo.prudente@example.com', N'', 3, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (157, N'Eduardo', N'Bellendir', N'54936863676', N'eduardo.bellendir@example.com', N'', 6, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (158, N'Edwin', N'Lavelli', N'45481472210', N'edwin.lavelli@example.com', N'', 1, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (159, N'Efren', N'Baucher', N'47529195900', N'efren.baucher@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (160, N'Elaine', N'Renzi', N'43866232215', N'elaine.renzi@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (161, N'Eldon', N'Sutch', N'7523395528', N'eldon.sutch@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (162, N'Eli', N'Bettner', N'56478451663', N'eli.bettner@example.com', N'', 1, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (163, N'Elisa', N'Gracely', N'86171252175', N'elisa.gracely@example.com', N'', 9, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (164, N'Eliseo', N'Wice', N'64505308812', N'eliseo.wice@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (165, N'Ella', N'Pahnke', N'80830759476', N'ella.pahnke@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (166, N'Elmo', N'Dagenais', N'47442586908', N'elmo.dagenais@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (167, N'Elmo', N'Gabouer', N'66642717100', N'elmo.gabouer@example.com', N'', 7, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (168, N'Elvira', N'Blumenthal', N'98231657494', N'elvira.blumenthal@example.com', N'', 13, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (169, N'Emery', N'Reek', N'40251741904', N'emery.reek@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (170, N'Emilia', N'Oxley', N'8543644875', N'emilia.oxley@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (171, N'Emilio', N'Lampkin', N'6266994043', N'emilio.lampkin@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (172, N'Enrique', N'Oroark', N'44352904551', N'enrique.oroark@example.com', N'', 14, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (173, N'Eric', N'Schroeder', N'46296848284', N'eric.schroeder@example.com', N'', 3, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (174, N'Erica', N'Eyrich', N'49468997995', N'erica.eyrich@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (175, N'Essie', N'Vaill', N'60654560650', N'essie.vaill@example.com', N'', 10, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (176, N'Eva', N'Seahorn', N'99378948946', N'eva.seahorn@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (177, N'Evan', N'Pyfrom', N'77380643829', N'evan.pyfrom@example.com', N'', 15, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (178, N'Ezekiel', N'Mildon', N'60293466963', N'ezekiel.mildon@example.com', N'', 6, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (179, N'Fabian', N'Mcshaw', N'49831865318', N'fabian.mcshaw@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (180, N'Fannie', N'Steese', N'5762481275', N'fannie.steese@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (181, N'Fausto', N'Marks', N'71439380402', N'fausto.marks@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (182, N'Felecia', N'Riedl', N'75910473939', N'felecia.riedl@example.com', N'', 14, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (183, N'Felipe', N'Gould', N'4854399422', N'felipe.gould@example.com', N'', 4, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (184, N'Felipe', N'Mahone', N'66654405832', N'felipe.mahone@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (185, N'Florine', N'Willardson', N'61899883114', N'florine.willardson@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (186, N'Floyd', N'Veazey', N'68390852225', N'floyd.veazey@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (187, N'Forest', N'Orea', N'60964254624', N'forest.orea@example.com', N'', 9, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (188, N'Fran', N'Zanders', N'91107877487', N'fran.zanders@example.com', N'', 12, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (189, N'Francis', N'Soo', N'58379944733', N'francis.soo@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (190, N'Frankie', N'Morein', N'91438587709', N'frankie.morein@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (191, N'Fred', N'Kunde', N'42236128644', N'fred.kunde@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (192, N'Fred', N'Luddy', N'49465129521', N'fred.luddy@example.com', N'', 5, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (193, N'Freeman', N'Soula', N'63541846859', N'freeman.soula@example.com', N'', 15, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (194, N'Freida', N'Michelfelder', N'73516492127', N'freida.michelfelder@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (195, N'Gale', N'Nolau', N'54264468498', N'gale.nolau@example.com', N'', 12, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (196, N'Garfield', N'Lijewski', N'83190376440', N'garfield.lijewski@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (197, N'Garth', N'Skiffington', N'59274315507', N'garth.skiffington@example.com', N'', 13, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (198, N'Gaston', N'Cieloszyk', N'76458389499', N'gaston.cieloszyk@example.com', N'', 10, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (199, N'Gayla', N'Geimer', N'60317210127', N'gayla.geimer@example.com', N'', 13, 4)
GO
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (200, N'Genevieve', N'Kekiwi', N'5433286504', N'genevieve.kekiwi@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (201, N'George', N'Grey', N'90628239229', N'george.grey@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (202, N'George', N'Tukis', N'83880807883', N'george.tukis@example.com', N'', 6, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (203, N'George', N'Washington', N'73897520612', N'george.washington@example.com', N'(555) 555-0001', 11, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (204, N'Georgette', N'Bandyk', N'86403680427', N'georgette.bandyk@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (205, N'Geri', N'Forness', N'41189969359', N'geri.forness@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (206, N'Germaine', N'Bruski', N'9730779230', N'germaine.bruski@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (207, N'Gil', N'Scarpa', N'81803920256', N'gil.scarpa@example.com', N'', 6, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (208, N'Gisela', N'Kosicki', N'87441302820', N'gisela.kosicki@example.com', N'', 15, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (209, N'Gracie', N'Ehn', N'41369665977', N'gracie.ehn@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (210, N'Gregg', N'Guevarra', N'80406378716', N'gregg.guevarra@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (211, N'', N'Guest', N'9466801187', N'guest@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (212, N'Guillermo', N'Tsang', N'8421930375', N'guillermo.tsang@example.com', N'', 10, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (213, N'Haley', N'Rocheford', N'6839290577', N'haley.rocheford@example.com', N'', 9, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (214, N'Hanna', N'Cinkan', N'59102774180', N'hanna.cinkan@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (215, N'Hannah', N'Facio', N'89147140838', N'hannah.facio@example.com', N'', 12, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (216, N'Hans', N'Carlan', N'87139125675', N'hans.carlan@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (217, N'Heath', N'Vanalphen', N'55846473714', N'heath.vanalphen@example.com', N'', 6, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (218, N'Helena', N'Suermann', N'6312841279', N'helena.suermann@example.com', N'', 4, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (219, N'Helene', N'Iberg', N'83365864429', N'helene.iberg@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (220, N'Helga', N'Windle', N'6723072877', N'helga.windle@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (221, N'Henrietta', N'Cintora', N'5038976352', N'henrietta.cintora@example.com', N'', 3, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (222, N'Heriberto', N'Tivis', N'98703478519', N'heriberto.tivis@example.com', N'', 4, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (223, N'Hilario', N'Cassa', N'49981376124', N'hilario.cassa@example.com', N'', 10, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (224, N'Hillary', N'Holmes', N'45280869411', N'hillary.holmes@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (225, N'Howard', N'Johnson', N'98470901791', N'howard.johnson@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (226, N'Ike', N'Benthin', N'8440234254', N'ike.benthin@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (227, N'Ike', N'Zeolla', N'68452733132', N'ike.zeolla@example.com', N'', 11, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (228, N'Incident', N'Manager', N'7617866887', N'incident.manager@example.com', N'', 11, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (229, N'Inventory', N'Admin', N'8356830758', N'Inventory.Admin@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (230, N'Ione', N'Kucera', N'43692616439', N'ione.kucera@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (231, N'Isaac', N'Davensizer', N'48180406297', N'isaac.davensizer@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (232, N'Isaac', N'Zackery', N'85294415632', N'isaac.zackery@example.com', N'', 15, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (233, N'Isabell', N'Armout', N'71940686467', N'isabell.armout@example.com', N'', 14, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (234, N'Isiah', N'Phernetton', N'62559271597', N'isiah.phernetton@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (235, N'ITIL', N'User', N'93673342312', N'itil@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (236, N'Jacinto', N'Gawron', N'7025374431', N'jacinto.gawron@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (237, N'Jacklyn', N'Emayo', N'48460595536', N'jacklyn.emayo@example.com', N'', 10, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (238, N'Jade', N'Erlebach', N'90640550291', N'jade.erlebach@example.com', N'', 4, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (239, N'Jake', N'Throgmorton', N'43877700675', N'jake.throgmorton@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (240, N'James', N'Vittolo', N'89879923273', N'jvittolo@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (241, N'Janet', N'Rathrock', N'76994898377', N'janet.rathrock@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (242, N'Janet', N'Schaffter', N'66755359100', N'janet.schaffter@example.com', N'', 2, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (243, N'Janice', N'Twiet', N'89693421180', N'janice.twiet@example.com', N'', 5, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (244, N'Jannie', N'Bowditch', N'62178416333', N'jannie.bowditch@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (245, N'Jarrett', N'Kenzie', N'6551322702', N'jarrett.kenzie@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (246, N'Jarvis', N'Galas', N'88131998650', N'jarvis.galas@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (247, N'Jasmin', N'Gum', N'49717424619', N'jasmin.gum@example.com', N'', 9, 2)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (248, N'Jeanie', N'Dalen', N'49927510233', N'jeanie.dalen@example.com', N'', 10, 3)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (249, N'Jeremy', N'Lampi', N'91273930960', N'jeremy.lampi@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (250, N'Jeri', N'Farstvedt', N'74975290696', N'jeri.farstvedt@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (251, N'Jerrod', N'Bennett', N'65574344819', N'jerrod.bennett@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (252, N'Jess', N'Assad', N'7855437280', N'jess.assad@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (253, N'Jessie', N'Barkle', N'6972478735', N'jessie.barkle@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (254, N'Jewel', N'Agresta', N'98427797289', N'jewel.agresta@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (255, N'Jim', N'Ranzetti', N'91883894403', N'jim.ranzetti@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (256, N'Jimmie', N'Barninger', N'9357333386', N'jimmie.barninger@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (257, N'Jimmie', N'Hardgrove', N'6073740458', N'jimmie.hardgrove@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (258, N'Jimmie', N'Kertzman', N'70994280907', N'jimmie.kertzman@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (259, N'Jimmie', N'Zarzycki', N'55336102203', N'jimmie.zarzycki@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (260, N'Jimmy', N'Hrobsky', N'986735754', N'jimmy.hrobsky@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (261, N'Joe', N'Employee', N'88179341914', N'employee@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (262, N'Joel', N'Nardo', N'4447210873', N'joel.nardo@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (263, N'Joey', N'Bolick', N'8246578380', N'joey.bolick@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (264, N'Joey', N'Sedore', N'45411599660', N'joey.sedore@example.com', N'', 3, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (265, N'John', N'Adams', N'45345143520', N'john.adams@example.com', N'(555) 555-0002', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (266, N'John', N'Bohnhamn', N'89274507481', N'john.bohnhamn@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (267, N'John', N'Chipley', N'58220675568', N'john.chipley@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (268, N'John', N'Kennedy', N'68572809297', N'jfk@example.com', N'(555) 555-0006', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (269, N'John', N'Retak', N'63680102508', N'john.retak@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (270, N'Johnie', N'Minaai', N'66732142222', N'johnie.minaai@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (271, N'Johnnie', N'Rheaves', N'47133387140', N'johnnie.rheaves@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (272, N'Jonathon', N'Waldall', N'6336566820', N'jonathon.waldall@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (273, N'Josephine', N'Sotlar', N'4631185434', N'josephine.sotlar@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (274, N'Jude', N'Haza', N'45172150504', N'jude.haza@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (275, N'Judi', N'Kivel', N'98314884890', N'judi.kivel@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (276, N'Judy', N'Gartenmayer', N'81572829669', N'judy.gartenmayer@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (277, N'Junior', N'Wadlinger', N'8347438444', N'junior.wadlinger@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (278, N'Justina', N'Dragaj', N'60349242528', N'justina.dragaj@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (279, N'Karen', N'Flierl', N'87324294663', N'karen.flierl@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (280, N'Karen', N'Zombo', N'83906110122', N'karen.zombo@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (281, N'Karla', N'Ken', N'93237473788', N'karla.ken@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (282, N'Karyn', N'Jinks', N'96528447967', N'karyn.jinks@example.com', N'', 13, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (283, N'Kasey', N'Nguyen', N'664365163', N'kasey.nguyen@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (284, N'Kathie', N'Argenti', N'6054944125', N'kathie.argenti@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (285, N'Kathleen', N'Beresnyak', N'70310221923', N'kathleen.beresnyak@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (286, N'Katina', N'Ramano', N'49550721948', N'katina.ramano@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (287, N'Katina', N'Survant', N'88566790761', N'katina.survant@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (288, N'Kay', N'Ganguli', N'51767662475', N'kay.ganguli@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (289, N'Keisha', N'Ransonet', N'57662967945', N'keisha.ransonet@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (290, N'Kelli', N'Varrato', N'95365526765', N'kelli.varrato@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (291, N'Kennith', N'Kirklin', N'60188997549', N'kennith.kirklin@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (292, N'Kennith', N'Peto', N'51680955353', N'kennith.peto@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (293, N'Kenya', N'Bruni', N'65244746295', N'kenya.bruni@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (294, N'Kerry', N'Evertt', N'5584611718', N'kerry.evertt@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (295, N'Kevin', N'Edd', N'92501258596', N'kevin.edd@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (296, N'Kira', N'Papen', N'99494128479', N'kira.papen@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (297, N'Kira', N'Staffon', N'40864867891', N'kira.staffon@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (298, N'Kory', N'Wooldridge', N'6477090320', N'kory.wooldridge@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (299, N'Kris', N'Persson', N'90281272257', N'kris.persson@example.com', N'', 13, 1)
GO
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (300, N'Kris', N'Stanzak', N'66415660768', N'kris.stanzak@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (301, N'Kristine', N'Paker', N'6221095762', N'kristine.paker@example.com', N'', 5, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (302, N'Krystle', N'Stika', N'79771524255', N'krystle.stika@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (303, N'Kurtis', N'Asberry', N'94528632741', N'kurtis.asberry@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (304, N'Kurtis', N'Mcbay', N'59161764291', N'kurtis.mcbay@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (305, N'Kyle', N'Ferri', N'92323798884', N'kyle.ferri@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (306, N'Kyle', N'Lindauer', N'75255996614', N'kyle.lindauer@example.com', N'', 10, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (307, N'Kylie', N'Bridgeman', N'57343423430', N'kylie.bridgeman@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (308, N'Lacy', N'Belmont', N'95246418440', N'lacy.belmont@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (309, N'Lacy', N'Hyten', N'46413462888', N'lacy.hyten@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (310, N'Lacy', N'Woodfin', N'66863204378', N'lacy.woodfin@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (311, N'Lamar', N'Mckibben', N'63763681413', N'lamar.mckibben@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (312, N'Lana', N'Garrigus', N'63137414705', N'lana.garrigus@example.com', N'', 9, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (313, N'Lana', N'Keels', N'43514265628', N'lana.keels@example.com', N'', 12, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (314, N'Lane', N'Brantz', N'8857943757', N'lane.brantz@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (315, N'Lashawn', N'Hasty', N'97866706458', N'lashawn.hasty@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (316, N'Lashonda', N'Derouen', N'5336964432', N'lashonda.derouen@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (317, N'Lashonda', N'Enote', N'5919093178', N'lashonda.enote@example.com', N'', 6, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (318, N'Latisha', N'Bahls', N'73646467979', N'latisha.bahls@example.com', N'', 5, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (319, N'Laurie', N'Bibbs', N'6249145523', N'laurie.bibbs@example.com', N'', 7, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (320, N'Laurie', N'Bigg', N'52321558709', N'laurie.bigg@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (321, N'Lee', N'Javens', N'60214552234', N'lee.javens@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (322, N'Leif', N'Arguin', N'85754960560', N'leif.arguin@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (323, N'Leif', N'Bachta', N'78495496376', N'leif.bachta@example.com', N'', 1, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (324, N'Lesa', N'Chantry', N'5221786101', N'lesa.chantry@example.com', N'', 11, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (325, N'Leslie', N'Cackowski', N'74995865314', N'leslie.cackowski@example.com', N'', 4, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (326, N'Lina', N'Hybarger', N'70407609364', N'lina.hybarger@example.com', N'', 15, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (327, N'Lizzie', N'Torregrossa', N'86774576896', N'lizzie.torregrossa@example.com', N'', 8, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (328, N'Logan', N'Muhl', N'46305382399', N'logan.muhl@example.com', N'', 14, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (329, N'Lona', N'Scronce', N'71108360931', N'lona.scronce@example.com', N'', 2, 1)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (330, N'Lora', N'Lendor', N'5581363218', N'lora.lendor@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (331, N'Lottie', N'Voll', N'62186709694', N'lottie.voll@example.com', N'', 10, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (332, N'Lucas', N'Santellana', N'71725363347', N'lucas.santellana@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (333, N'Luciano', N'Truiolo', N'45460984936', N'luciano.truiolo@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (334, N'Lucien', N'Iurato', N'927925425', N'lucien.iurato@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (335, N'Lucius', N'Bagnoli', N'82949695212', N'lucius.bagnoli@example.com', N'', 12, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (336, N'Lucius', N'Winchester', N'9523279487', N'lucius.winchester@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (337, N'Luella', N'Pliner', N'99361889818', N'luella.pliner@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (338, N'Luke', N'Wilson', N'43882132919', N'luke.wilson@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (339, N'Lyman', N'Whittley', N'95457213147', N'lyman.whittley@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (340, N'Lynda', N'Caraway', N'5250775691', N'lynda.caraway@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (341, N'Lynda', N'Youtsey', N'99278865378', N'lynda.youtsey@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (342, N'Lyndon', N'Bellerdine', N'40446518605', N'lyndon.bellerdine@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (343, N'Lynette', N'Setlock', N'64599119695', N'lynette.setlock@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (344, N'Lynn', N'Saulsberry', N'79584510929', N'lynn.saulsberry@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (345, N'Mabel', N'Weeden', N'972068535', N'mabel.weeden@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (346, N'Mac', N'Marksberry', N'57742680354', N'mac.marksberry@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (347, N'Mack', N'Jurasin', N'78669668458', N'mack.jurasin@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (348, N'Madonna', N'Cosby', N'94875862794', N'madonna.cosby@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (349, N'Malissa', N'Ziesemer', N'6782658319', N'malissa.ziesemer@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (350, N'Mamie', N'Mcintee', N'99403841251', N'mamie.mcintee@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (351, N'Mandy', N'Mcdonnell', N'5696277072', N'mandy.mcdonnell@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (352, N'Manuel', N'Dienhart', N'49492679704', N'manuel.dienhart@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (353, N'Mara', N'Rineheart', N'82584335378', N'mara.rineheart@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (354, N'Mara', N'Vanderzwaag', N'7914521271', N'mara.vanderzwaag@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (355, N'Marc', N'Wanger', N'50125491841', N'marc.wanger@example.com', N'', 10, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (356, N'Marcelino', N'Maggs', N'49493554106', N'marcelino.maggs@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (357, N'Marcelo', N'Arostegui', N'94379879538', N'marcelo.arostegui@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (358, N'Marcie', N'Shulz', N'42961170985', N'marcie.shulz@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (359, N'Margaret', N'Grey', N'77158905506', N'margaret.gray@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (360, N'Margarito', N'Kornbau', N'71584106333', N'margarito.kornbau@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (361, N'Margot', N'Arenburg', N'53930405114', N'margot.arenburg@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (362, N'Mari', N'Hwang', N'62940656375', N'mari.hwang@example.com', N'', 10, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (363, N'Marianne', N'Earman', N'68491104834', N'marianne.earman@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (364, N'Mariano', N'Maury', N'40246352467', N'mariano.maury@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (365, N'Marietta', N'Bjornberg', N'77871843380', N'marietta.bjornberg@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (366, N'Marion', N'Gaulden', N'71432946328', N'marion.gaulden@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (367, N'Marisa', N'Smiler', N'69196343672', N'marisa.smiler@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (368, N'Marisa', N'Woldridge', N'7846498383', N'marisa.woldridge@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (369, N'Marla', N'Folz', N'9740983226', N'marla.folz@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (370, N'Marlene', N'Hammeren', N'96477438551', N'marlene.hammeren@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (371, N'Marquita', N'Bousman', N'48526483995', N'marquita.bousman@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (372, N'Marscha', N'Gilles-Piecukonis', N'9363755675', N'marscha.gilles@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (373, N'Marshall', N'Hutch', N'57528873185', N'marshall.hutch@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (374, N'Marta', N'Horner', N'78262392403', N'marta.horner@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (375, N'Marta', N'Warran', N'5724854825', N'marta.warran@example.com', N'', 12, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (376, N'Martin', N'Carley', N'87257673145', N'martin.carley@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (377, N'Mary', N'Cruse', N'647024930', N'mary.cruse@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (378, N'Mary', N'Maurizio', N'7912278369', N'mary.maurizio@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (379, N'Maryann', N'Garnette', N'8680643270', N'maryann.garnette@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (380, N'Maryanne', N'Whyman', N'94830752980', N'maryanne.whyman@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (381, N'Maryjane', N'Arata', N'93344325676', N'maryjane.arata@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (382, N'Maurine', N'Monroy', N'7476759332', N'maurine.monroy@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (383, N'Mayme', N'Staub', N'61228967241', N'mayme.staub@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (384, N'Maynard', N'Kaewprasert', N'78825404491', N'maynard.kaewprasert@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (385, N'Megan', N'Burke', N'94331456967', N'megan.burke@example.com', N'', 14, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (386, N'Melinda', N'Carleton', N'81632834837', N'melinda.carleton@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (387, N'Mellissa', N'Sule', N'8865911770', N'mellissa.sule@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (388, N'Melody', N'Saddat', N'79782645417', N'melody.saddat@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (389, N'Melvin', N'Auteri', N'8370179262', N'melvin.auteri@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (390, N'Meredith', N'Ivrin', N'9066826809', N'meredith.ivrin@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (391, N'Merle', N'Wyrosdick', N'58745317968', N'merle.wyrosdick@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (392, N'Michael', N'Hoefer', N'66226687294', N'michael.hoefer@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (393, N'Mildred', N'Gallegas', N'93180522287', N'mildred.gallegas@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (394, N'Millicent', N'Ekstrom', N'9493212944', N'millicent.ekstrom@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (395, N'Milton', N'Kuhlman', N'73819982457', N'milton.kuhlman@example.com', N'', 5, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (396, N'Minh', N'Leclare', N'93930980445', N'minh.leclare@example.com', N'', 10, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (397, N'Miquel', N'Demicco', N'9548539811', N'miquel.demicco@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (398, N'Miranda', N'Hammitt', N'4053487566', N'miranda.hammitt@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (399, N'Misty', N'Ericksen', N'97290930734', N'misty.ericksen@example.com', N'', 7, 5)
GO
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (400, N'Mitch', N'Schattner', N'566285764', N'mitch.schattner@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (401, N'Mitchel', N'Harnar', N'78398403125', N'mitchel.harnar@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (402, N'Mitzi', N'Ihenyen', N'8525446902', N'mitzi.ihenyen@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (403, N'Model', N'Manager', N'54359395520', N'model.manager@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (404, N'Modesto', N'Scroggie', N'56187979883', N'modesto.scroggie@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (405, N'Morton', N'Crummell', N'96517963567', N'morton.crummell@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (406, N'Nadia', N'Wilshire', N'69871537213', N'nadia.wilshire@example.com', N'', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (407, N'Nanette', N'Turansky', N'89139164333', N'nanette.turansky@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (408, N'Naomi', N'Caetano', N'59782665', N'naomi.caetano@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (409, N'Naomi', N'Greenly', N'633615480', N'naomi.greenly@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (410, N'Naomi', N'Mcraven', N'72997763522', N'naomi.mcraven@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (411, N'Natasha', N'Ingram', N'8324770564', N'natasha.ingram@example.com', N'', 1, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (412, N'Nathanial', N'Phoenix', N'86125648124', N'nathanial.phoenix@example.com', N'', 15, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (413, N'Neil', N'Backus', N'64597872588', N'neil.backus@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (414, N'Nelly', N'Jakuboski', N'9255626685', N'nelly.jakuboski@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (415, N'Neva', N'Marsell', N'88143759561', N'neva.marsell@example.com', N'', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (416, N'Nickolas', N'Khosravi', N'86518754986', N'nickolas.khosravi@example.com', N'', 13, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (417, N'Norman', N'Betance', N'49820783560', N'norman.betance@example.com', N'', 11, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (418, N'Ofelia', N'Sheffler', N'7937734992', N'ofelia.sheffler@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (419, N'Olga', N'Yarovenko', N'6394591603', N'olga.yarovenko@example.com', N'', 9, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (420, N'Oma', N'Duffy', N'6931040385', N'oma.duffy@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (421, N'Owen', N'Sparacino', N'57469766836', N'owen.sparacino@example.com', N'', 7, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (422, N'Pamala', N'Brodtmann', N'642704210', N'pamala.brodtmann@example.com', N'', 4, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (423, N'Password', N'Admin', N'58781825343', N'pwd.admin@example.com', N'(555) 555-5556', 3, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (424, N'Password', N'User', N'7911176284', N'pwd.user@example.com', N'(555) 555-5555', 2, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (425, N'Pat', N'Hoshaw', N'9440225689', N'pat.hoshaw@example.com', N'', 8, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (426, N'Patty', N'Bernasconi', N'86869235241', N'patty.bernasconi@example.com', N'', 6, 5)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (427, N'Paul', N'Shafer', N'88485419597', N'paul.shafer@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (428, N'Peggy', N'Hohlstein', N'78906245782', N'peggy.hohlstein@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (429, N'Petra', N'Clemmens', N'8738677294', N'petra.clemmens@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (430, N'Petra', N'Mcnichol', N'62460434653', N'petra.mcnichol@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (431, N'Phil', N'Hendrie', N'45617776205', N'phil.hendrie@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (432, N'Pierre', N'Salera', N'88244874835', N'pierre.salera@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (433, N'Pilar', N'Suddeth', N'65867879351', N'pilar.suddeth@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (434, N'Praveen', N'Vootkuri', N'43106839813', N'praveen.vootkuri@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (435, N'Prince', N'Kauk', N'7092871314', N'prince.kauk@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (436, N'Quintin', N'Isacson', N'94973995682', N'quintin.isacson@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (437, N'Rachel', N'Larrison', N'54114975563', N'rachel.larrison@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (438, N'Ramon', N'Amaral', N'59409133290', N'ramon.amaral@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (439, N'Randal', N'Gansen', N'40670153321', N'randal.gansen@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (440, N'Randall', N'Kluemper', N'58322653879', N'randall.kluemper@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (441, N'Raphael', N'Bickel', N'80458995251', N'raphael.bickel@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (442, N'Ray', N'Srock', N'95769859540', N'ray.srock@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (443, N'Rebeca', N'Brumet', N'4564143663', N'rebeca.brumet@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (444, N'Rebekah', N'Lindboe', N'60373412345', N'rebekah.lindboe@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (445, N'Rebekah', N'Padley', N'87493373855', N'rebekah.padley@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (446, N'Reggie', N'Streu', N'68574951661', N'reggie.streu@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (447, N'Reginald', N'Humes', N'52833728354', N'reginald.humes@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (448, N'Reginald', N'Lunan', N'96490208413', N'reginald.lunan@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (449, N'Reina', N'Reisenauer', N'69899230307', N'reina.reisenauer@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (450, N'Reina', N'Wolchesky', N'79544361442', N'reina.wolchesky@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (451, N'Rena', N'Griffeth', N'76774270527', N'rena.griffeth@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (452, N'Renae', N'Eldrige', N'5693694621', N'renae.eldrige@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (453, N'Rene', N'Dummermuth', N'67720644611', N'rene.dummermuth@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (454, N'Reva', N'Bayer', N'496816920', N'reva.bayer@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (455, N'Reva', N'Lecates', N'78855561561', N'reva.lecates@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (456, N'Reyna', N'Bangle', N'46593263888', N'reyna.bangle@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (457, N'Rich', N'Gleave', N'59439993799', N'rich.gleave@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (458, N'Rick', N'Berzle', N'61224482936', N'rick.berzle@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (459, N'Rita', N'Center', N'44991978168', N'rita.center@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (460, N'Rob', N'Phillips', N'8088184539', N'rob.phillips@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (461, N'Rob', N'Woodbyrne', N'56858328337', N'rob.woodbyrne@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (462, N'Robbie', N'Deshay', N'47657124622', N'robbie.deshay@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (463, N'Robin', N'Grotz', N'48773212784', N'robin.grotz@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (464, N'Robin', N'Schartz', N'94677150709', N'robin.schartz@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (465, N'Robt', N'Braithwaite', N'65926748543', N'robt.braithwaite@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (466, N'Robyn', N'Christophel', N'55585328613', N'robyn.christophel@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (467, N'Rodrigo', N'Wildrick', N'97287360917', N'rodrigo.wildrick@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (468, N'Roger', N'Rasmussen', N'4395432467', N'roger.rasmussen@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (469, N'Roger', N'Seid', N'75138456464', N'roger.seid@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (470, N'Rolando', N'Baumann', N'57228939551', N'rolando.baumann@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (471, N'Roman', N'Simone', N'5679696876', N'roman.simone@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (472, N'Ron', N'Kettering', N'73284311458', N'ron.kettering@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (473, N'Rosalia', N'Kennemur', N'7241419601', N'rosalia.kennemur@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (474, N'Rosalie', N'Krigger', N'52970537461', N'rosalie.krigger@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (475, N'Rosalind', N'Krenzke', N'85656529241', N'rosalind.krenzke@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (476, N'Rosalyn', N'Daulton', N'44657938446', N'rosalyn.daulton@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (477, N'Rosanna', N'Sandrock', N'9965482446', N'rosanna.sandrock@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (478, N'Roseann', N'Jerko', N'87989773709', N'roseann.jerko@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (479, N'Rosemarie', N'Fifield', N'92481451237', N'rosemarie.fifield@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (480, N'Ross', N'Spurger', N'60817752241', N'ross.spurger@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (481, N'Roxie', N'Varenhorst', N'6058894569', N'roxie.varenhorst@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (482, N'Rubin', N'Crotts', N'86648337255', N'rubin.crotts@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (483, N'Rudy', N'Kuhle', N'45328208429', N'rudy.kuhle@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (484, N'Ruthie', N'Zortman', N'97505215832', N'ruthie.zortman@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (485, N'Sabrina', N'Deppert', N'48856173565', N'sabrina.deppert@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (486, N'Sadie', N'Rowlett', N'9236940187', N'sadie.rowlett@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (487, N'Sal', N'Pindell', N'48790859724', N'sal.pindell@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (488, N'Sam', N'Sorokin', N'73755945538', N'sam.sorokin@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (489, N'Samantha', N'Bordwell', N'5421985706', N'samantha.bordwell@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (490, N'Sandra', N'Graen', N'60149796411', N'sandra.graen@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (491, N'Saundra', N'Mcaulay', N'96236833455', N'saundra.mcaulay@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (492, N'Savannah', N'Kesich', N'85726995451', N'savannah.kesich@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (493, N'Savannah', N'Loffier', N'89681792126', N'savannah.loffier@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (494, N'Scott', N'Seixas', N'54846515433', N'scott.seixas@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (495, N'Sean', N'Bonnet', N'74241163966', N'sean.bonnet@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (496, N'Service', N'Desk', N'57194176116', N'svc.desk@example.com', N'(555) 555-5558', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (497, N'Shanna', N'Neundorfer', N'88772835780', N'shanna.neundorfer@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (498, N'Shanna', N'Numkena', N'6927861505', N'shanna.numkena@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (499, N'Sharlene', N'Circelli', N'95673298817', N'sharlene.circelli@example.com', N'', 4, 4)
GO
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (500, N'Sheila', N'Holloran', N'50110737531', N'sheila.holloran@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (501, N'Shelley', N'Groden', N'9849829974', N'shelley.groden@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (502, N'Sherwood', N'Detillier', N'68479190787', N'sherwood.detillier@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (503, N'Sheryl', N'Sisofo', N'79672333872', N'sheryl.sisofo@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (504, N'Simone', N'Lundie', N'76859519816', N'simone.lundie@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (505, N'SLA', N'Admin', N'8147890794', N'sla.admin@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (506, N'SLA', N'Manager', N'88370353955', N'sla.manager@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (507, N'SOAP', N'Guest', N'7783343399', N'', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (508, N'Socorro', N'Balandran', N'56980680589', N'socorro.balandran@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (509, N'Software', N'Manager', N'85312586127', N'', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (510, N'Son', N'Marschke', N'59243373654', N'son.marschke@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (511, N'Sophie', N'Langner', N'864767919', N'sophie.langner@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (512, N'Stacey', N'Blow', N'63109909266', N'stacey.blow@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (513, N'Stephen', N'Seiters', N'8220814104', N'stephen.seiters@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (514, N'Steve', N'Schorr', N'47170927186', N'steve.schorr@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (515, N'Sue', N'Haakinson', N'4452723457', N'sue.haakinson@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (516, N'Suresh', N'Yekollu', N'67157740794', N'suresh.yekollu@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (517, N'Suzette', N'Devaughan', N'98631305446', N'suzette.devaughan@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (518, N'Sybil', N'Marmerchant', N'52282443179', N'sybil.marmerchant@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (519, N'System', N'Administrator', N'41214941911', N'admin@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (520, N'Tamara', N'Declue', N'7664520467', N'tamara.declue@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (521, N'Tami', N'Trybus', N'48854183606', N'tami.trybus@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (522, N'Tammie', N'Schwartzwalde', N'5728981259', N'tammie.schwartzwalde@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (523, N'Taylor', N'Fogerty', N'85215772763', N'taylor.fogerty@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (524, N'Taylor', N'Vreeland', N'82166766513', N'taylor.vreeland@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (525, N'Ted', N'Bozelle', N'71577372459', N'ted.bozelle@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (526, N'Ted', N'Keppel', N'57519436367', N'ted.keppel@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (527, N'Teodoro', N'Gaboury', N'8655931027', N'teodoro.gaboury@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (528, N'Teri', N'Erlewine', N'65967258583', N'teri.erlewine@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (529, N'Terra', N'Plagge', N'84310384540', N'terra.plagge@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (530, N'Terrance', N'Nimmer', N'8177354330', N'terrance.nimmer@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (531, N'Terrell', N'Rodda', N'79264941788', N'terrell.rodda@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (532, N'Theron', N'Hambright', N'5498678859', N'theron.hambright@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (533, N'Thomas', N'Jefferson', N'49376741233', N'thomas.jefferson@example.com', N'(555) 555-0003', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (534, N'Tia', N'Lino', N'45297336576', N'tia.lino@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (535, N'Tia', N'Neumaier', N'5151108742', N'tia.neumaier@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (536, N'Tiffany', N'Knust', N'72564962363', N'tiffany.knust@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (537, N'Timothy', N'Janski', N'91457475418', N'timothy.janski@example.com', N'', 3, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (538, N'Tisha', N'Gorder', N'727276295', N'tisha.gorder@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (539, N'Titus', N'Rodreguez', N'485912565', N'titus.rodreguez@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (540, N'Tommie', N'Reuland', N'96516680768', N'tommie.reuland@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (541, N'Tori', N'Villaescusa', N'94453826521', N'tori.villaescusa@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (542, N'Traci', N'Toomey', N'40973470665', N'traci.toomey@example.com', N'', 12, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (543, N'Travis', N'Brockert', N'4918535454', N'travis.brockert@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (544, N'Trey', N'Tout', N'60660120633', N'trey.tout@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (545, N'Tricia', N'Kruss', N'9563963736', N'tricia.kruss@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (546, N'Trudy', N'Worlds', N'90310315763', N'trudy.worlds@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (547, N'Tyree', N'Courrege', N'65713898693', N'tyree.courrege@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (548, N'Tyron', N'Quillman', N'79830360543', N'tyron.quillman@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (549, N'Val', N'Oborne', N'63450344666', N'val.oborne@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (550, N'Valentine', N'Granberry', N'90479832807', N'valentine.granberry@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (551, N'Valeria', N'Lingbeek', N'72942302262', N'valeria.lingbeek@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (552, N'Valerie', N'Pou', N'60444615311', N'valerie.pou@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (553, N'Van', N'Leanen', N'4681494537', N'van.leanen@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (554, N'Vanessa', N'Lewallen', N'42115207798', N'vanessa.lewallen@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (555, N'Vernice', N'Resendes', N'88577160617', N'vernice.resendes@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (556, N'Vernon', N'Engelman', N'45566858400', N'vernon.engelman@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (557, N'Veronica', N'Achorn', N'5493712851', N'veronica.achorn@example.com', N'', 9, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (558, N'Veronica', N'Radman', N'73528590933', N'veronica.radman@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (559, N'Vince', N'Ettel', N'87138136234', N'vince.ettel@example.com', N'', 10, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (560, N'Viola', N'Mcsorley', N'53209122351', N'viola.mcsorley@example.com', N'', 5, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (561, N'Virgil', N'Chinni', N'62468706982', N'virgil.chinni@example.com', N'', 11, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (562, N'Vivian', N'Brzostowski', N'6034521017', N'vivian.brzostowski@example.com', N'', 4, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (563, N'Waldo', N'Edberg', N'91387724538', N'waldo.edberg@example.com', N'', 2, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (564, N'Waldo', N'Sisk', N'6747435196', N'waldo.sisk@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (565, N'Walton', N'Schwallie', N'40958591315', N'walton.schwallie@example.com', N'', 14, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (566, N'Warren', N'Hacher', N'45593917623', N'warren.hacher@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (567, N'Warren', N'Speach', N'5132654136', N'warren.speach@example.com', N'', 7, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (568, N'Wayne', N'Webb', N'81100181679', N'wayne.webb@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (569, N'Wes', N'Fontanella', N'59725496186', N'wes.fontanella@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (570, N'Wilfredo', N'Gidley', N'62925471252', N'wilfredo.gidley@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (571, N'Willa', N'Dutt', N'81406894839', N'willa.dutt@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (572, N'Willard', N'Roughen', N'5958510679', N'willard.roughen@example.com', N'', 15, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (573, N'William', N'Mahmud', N'6422656905', N'william.mahmud@example.com', N'', 13, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (574, N'Wilmer', N'Constantineau', N'62807149622', N'wilmer.constantineau@example.com', N'', 8, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (575, N'Winnie', N'Reich', N'79358686917', N'winnie.reich@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (576, N'Yvette', N'Kokoska', N'52456984247', N'yvette.kokoska@example.com', N'', 6, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (577, N'Zackary', N'Mockus', N'88537448979', N'zackary.mockus@example.com', N'', 1, 4)
INSERT [dbo].[Uzytkownicy] ([ID], [Imie], [Nazwisko], [PESEL], [email], [Telefon], [FirmaID], [Rola]) VALUES (578, N'Zane', N'Sulikowski', N'43993267481', N'zane.sulikowski@example.com', N'', 11, 4)
SET IDENTITY_INSERT [dbo].[Uzytkownicy] OFF
SET IDENTITY_INSERT [dbo].[Zadania] ON 

INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (1, 101, N'Zadanie 1', 22)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (2, 79, N'Zadanie 2', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (3, 54, N'Zadanie 3', 7)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (4, 95, N'Zadanie 4', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (5, 32, N'Zadanie 5', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (6, 68, N'Zadanie 6', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (7, 75, N'Zadanie 7', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (8, 21, N'Zadanie 8', 8)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (9, 47, N'Zadanie 9', 23)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (10, 5, N'Zadanie 10', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (11, 48, N'Zadanie 11', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (12, 68, N'Zadanie 12', 22)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (13, 21, N'Zadanie 13', 1)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (14, 22, N'Zadanie 14', 23)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (15, 13, N'Zadanie 15', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (16, 69, N'Zadanie 16', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (17, 1, N'Zadanie 17', 12)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (18, 50, N'Zadanie 18', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (19, 26, N'Zadanie 19', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (20, 89, N'Zadanie 20', 18)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (21, 111, N'Zadanie 21', 16)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (22, 115, N'Zadanie 22', 3)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (23, 45, N'Zadanie 23', 11)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (24, 19, N'Zadanie 24', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (25, 92, N'Zadanie 25', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (26, 99, N'Zadanie 26', 13)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (27, 8, N'Zadanie 27', 19)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (28, 119, N'Zadanie 28', 17)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (29, 96, N'Zadanie 29', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (30, 82, N'Zadanie 30', 3)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (31, 19, N'Zadanie 31', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (32, 61, N'Zadanie 32', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (33, 101, N'Zadanie 33', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (34, 104, N'Zadanie 34', 4)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (35, 30, N'Zadanie 35', 1)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (36, 97, N'Zadanie 36', 8)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (37, 38, N'Zadanie 37', 16)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (38, 17, N'Zadanie 38', 16)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (39, 4, N'Zadanie 39', 21)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (40, 1, N'Zadanie 40', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (41, 97, N'Zadanie 41', 19)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (42, 5, N'Zadanie 42', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (43, 20, N'Zadanie 43', 23)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (44, 78, N'Zadanie 44', 12)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (45, 123, N'Zadanie 45', 11)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (46, 126, N'Zadanie 46', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (47, 59, N'Zadanie 47', 16)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (48, 89, N'Zadanie 48', 19)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (49, 42, N'Zadanie 49', 14)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (50, 24, N'Zadanie 50', 8)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (51, 104, N'Zadanie 51', 3)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (52, 21, N'Zadanie 52', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (53, 82, N'Zadanie 53', 21)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (54, 20, N'Zadanie 54', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (55, 91, N'Zadanie 55', 3)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (56, 9, N'Zadanie 56', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (57, 17, N'Zadanie 57', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (58, 73, N'Zadanie 58', 18)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (59, 41, N'Zadanie 59', 19)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (60, 101, N'Zadanie 60', 13)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (61, 116, N'Zadanie 61', 14)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (62, 99, N'Zadanie 62', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (63, 74, N'Zadanie 63', 8)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (64, 42, N'Zadanie 64', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (65, 99, N'Zadanie 65', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (66, 125, N'Zadanie 66', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (67, 65, N'Zadanie 67', 6)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (68, 35, N'Zadanie 68', 19)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (69, 118, N'Zadanie 69', 1)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (70, 85, N'Zadanie 70', 11)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (71, 44, N'Zadanie 71', 12)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (72, 51, N'Zadanie 72', 22)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (73, 68, N'Zadanie 73', 7)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (74, 15, N'Zadanie 74', 18)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (75, 76, N'Zadanie 75', 23)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (76, 30, N'Zadanie 76', 4)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (77, 119, N'Zadanie 77', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (78, 7, N'Zadanie 78', 20)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (79, 126, N'Zadanie 79', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (80, 116, N'Zadanie 80', 18)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (81, 15, N'Zadanie 81', 12)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (82, 7, N'Zadanie 82', 1)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (83, 67, N'Zadanie 83', 21)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (84, 94, N'Zadanie 84', 15)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (85, 27, N'Zadanie 85', 21)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (86, 37, N'Zadanie 86', 5)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (87, 70, N'Zadanie 87', 8)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (88, 62, N'Zadanie 88', 1)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (89, 106, N'Zadanie 89', 10)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (90, 44, N'Zadanie 90', 9)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (91, 116, N'Zadanie 91', 14)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (92, 13, N'Zadanie 92', 2)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (93, 123, N'Zadanie 93', 12)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (94, 102, N'Zadanie 94', 11)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (95, 87, N'Zadanie 95', 22)
INSERT [dbo].[Zadania] ([ID], [UslugaID], [Nazwa], [GrupaRoboczaID]) VALUES (96, 78, N'Zadanie 96', 15)
SET IDENTITY_INSERT [dbo].[Zadania] OFF
SET IDENTITY_INSERT [dbo].[Zamowienia] ON 

INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (1, 97, 335, CAST(N'2015-01-03T00:00:00.000' AS DateTime), CAST(N'2015-01-03T00:00:00.000' AS DateTime), NULL, 1, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (2, 85, 163, CAST(N'2016-05-25T00:00:00.000' AS DateTime), CAST(N'2016-05-28T00:00:00.000' AS DateTime), NULL, 1, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (3, 92, 542, CAST(N'2017-05-26T00:00:00.000' AS DateTime), CAST(N'2017-05-27T00:00:00.000' AS DateTime), NULL, 1, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (4, 24, 77, CAST(N'2015-07-30T00:00:00.000' AS DateTime), CAST(N'2015-08-02T00:00:00.000' AS DateTime), NULL, 1, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (5, 67, 348, CAST(N'2017-01-16T00:00:00.000' AS DateTime), CAST(N'2017-01-18T00:00:00.000' AS DateTime), NULL, 1, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (6, 94, 480, CAST(N'2016-03-13T00:00:00.000' AS DateTime), CAST(N'2016-03-20T00:00:00.000' AS DateTime), NULL, 1, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (7, 78, 227, CAST(N'2017-11-14T00:00:00.000' AS DateTime), CAST(N'2017-11-14T00:00:00.000' AS DateTime), NULL, 1, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (8, 68, 116, CAST(N'2017-09-23T00:00:00.000' AS DateTime), CAST(N'2017-09-25T00:00:00.000' AS DateTime), NULL, 2, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (9, 56, 112, CAST(N'2017-11-10T00:00:00.000' AS DateTime), CAST(N'2017-11-15T00:00:00.000' AS DateTime), NULL, 2, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (10, 82, 132, CAST(N'2016-07-04T00:00:00.000' AS DateTime), CAST(N'2016-07-07T00:00:00.000' AS DateTime), NULL, 2, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (11, 94, 175, CAST(N'2017-10-28T00:00:00.000' AS DateTime), CAST(N'2017-10-28T00:00:00.000' AS DateTime), NULL, 2, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (12, 51, 271, CAST(N'2016-02-25T00:00:00.000' AS DateTime), CAST(N'2016-03-01T00:00:00.000' AS DateTime), NULL, 2, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (13, 68, 12, CAST(N'2017-01-04T00:00:00.000' AS DateTime), CAST(N'2017-01-07T00:00:00.000' AS DateTime), NULL, 2, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (14, 56, 196, CAST(N'2016-01-11T00:00:00.000' AS DateTime), CAST(N'2016-01-17T00:00:00.000' AS DateTime), NULL, 4, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (15, 73, 242, CAST(N'2016-07-21T00:00:00.000' AS DateTime), CAST(N'2016-07-22T00:00:00.000' AS DateTime), NULL, 4, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (16, 44, 1, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-01-18T00:00:00.000' AS DateTime), NULL, 4, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (17, 80, 253, CAST(N'2016-09-17T00:00:00.000' AS DateTime), CAST(N'2016-09-18T00:00:00.000' AS DateTime), NULL, 4, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (18, 34, 515, CAST(N'2017-01-30T00:00:00.000' AS DateTime), CAST(N'2017-02-01T00:00:00.000' AS DateTime), NULL, 4, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (19, 39, 29, CAST(N'2017-01-17T00:00:00.000' AS DateTime), CAST(N'2017-01-23T00:00:00.000' AS DateTime), NULL, 4, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (20, 49, 225, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-01-02T00:00:00.000' AS DateTime), NULL, 4, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (21, 28, 393, CAST(N'2016-07-23T00:00:00.000' AS DateTime), CAST(N'2016-07-28T00:00:00.000' AS DateTime), NULL, 4, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (22, 41, 338, CAST(N'2015-01-09T00:00:00.000' AS DateTime), CAST(N'2015-01-12T00:00:00.000' AS DateTime), NULL, 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (23, 97, 533, CAST(N'2015-10-31T00:00:00.000' AS DateTime), CAST(N'2015-11-04T00:00:00.000' AS DateTime), NULL, 4, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (24, 46, 440, CAST(N'2016-08-30T00:00:00.000' AS DateTime), CAST(N'2016-09-04T00:00:00.000' AS DateTime), NULL, 4, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (25, 39, 567, CAST(N'2017-07-09T00:00:00.000' AS DateTime), CAST(N'2017-07-10T00:00:00.000' AS DateTime), NULL, 4, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (26, 25, 466, CAST(N'2017-11-24T00:00:00.000' AS DateTime), CAST(N'2017-11-30T00:00:00.000' AS DateTime), NULL, 4, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (27, 38, 120, CAST(N'2016-11-19T00:00:00.000' AS DateTime), CAST(N'2016-11-23T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (28, 21, 231, CAST(N'2016-10-16T00:00:00.000' AS DateTime), CAST(N'2016-10-19T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (29, 70, 190, CAST(N'2015-03-27T00:00:00.000' AS DateTime), CAST(N'2015-04-01T00:00:00.000' AS DateTime), NULL, 4, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (30, 34, 182, CAST(N'2015-01-15T00:00:00.000' AS DateTime), CAST(N'2015-01-18T00:00:00.000' AS DateTime), NULL, 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (31, 39, 232, CAST(N'2016-07-16T00:00:00.000' AS DateTime), CAST(N'2016-07-21T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (32, 44, 519, CAST(N'2015-07-24T00:00:00.000' AS DateTime), CAST(N'2015-07-26T00:00:00.000' AS DateTime), NULL, 4, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (33, 92, 477, CAST(N'2015-12-16T00:00:00.000' AS DateTime), CAST(N'2015-12-17T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (34, 50, 485, CAST(N'2015-03-27T00:00:00.000' AS DateTime), CAST(N'2015-03-29T00:00:00.000' AS DateTime), NULL, 4, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (35, 45, 429, CAST(N'2017-01-09T00:00:00.000' AS DateTime), CAST(N'2017-01-12T00:00:00.000' AS DateTime), NULL, 4, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (36, 78, 523, CAST(N'2016-12-22T00:00:00.000' AS DateTime), CAST(N'2016-12-22T00:00:00.000' AS DateTime), NULL, 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (37, 61, 101, CAST(N'2016-02-15T00:00:00.000' AS DateTime), CAST(N'2016-02-16T00:00:00.000' AS DateTime), NULL, 4, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (38, 40, 315, CAST(N'2016-03-26T00:00:00.000' AS DateTime), CAST(N'2016-03-27T00:00:00.000' AS DateTime), NULL, 4, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (39, 59, 389, CAST(N'2015-12-10T00:00:00.000' AS DateTime), CAST(N'2015-12-11T00:00:00.000' AS DateTime), NULL, 4, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (40, 29, 129, CAST(N'2017-01-16T00:00:00.000' AS DateTime), CAST(N'2017-01-23T00:00:00.000' AS DateTime), NULL, 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (41, 85, 287, CAST(N'2016-11-14T00:00:00.000' AS DateTime), CAST(N'2016-11-14T00:00:00.000' AS DateTime), NULL, 4, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (42, 33, 205, CAST(N'2016-07-18T00:00:00.000' AS DateTime), CAST(N'2016-07-19T00:00:00.000' AS DateTime), NULL, 4, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (43, 78, 424, CAST(N'2015-05-27T00:00:00.000' AS DateTime), CAST(N'2015-06-02T00:00:00.000' AS DateTime), NULL, 4, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (44, 25, 163, CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-15T00:00:00.000' AS DateTime), NULL, 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (45, 91, 575, CAST(N'2016-12-01T00:00:00.000' AS DateTime), CAST(N'2016-12-01T00:00:00.000' AS DateTime), NULL, 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (46, 34, 365, CAST(N'2015-11-24T00:00:00.000' AS DateTime), CAST(N'2015-11-28T00:00:00.000' AS DateTime), NULL, 4, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (47, 55, 21, CAST(N'2016-06-22T00:00:00.000' AS DateTime), CAST(N'2016-06-29T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (48, 30, 166, CAST(N'2015-09-13T00:00:00.000' AS DateTime), CAST(N'2015-09-13T00:00:00.000' AS DateTime), NULL, 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (49, 50, 408, CAST(N'2015-06-28T00:00:00.000' AS DateTime), CAST(N'2015-06-29T00:00:00.000' AS DateTime), NULL, 4, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (50, 53, 71, CAST(N'2015-05-07T00:00:00.000' AS DateTime), CAST(N'2015-05-10T00:00:00.000' AS DateTime), NULL, 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (51, 82, 514, CAST(N'2016-01-30T00:00:00.000' AS DateTime), CAST(N'2016-01-30T00:00:00.000' AS DateTime), NULL, 4, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (52, 73, 143, CAST(N'2016-01-31T00:00:00.000' AS DateTime), CAST(N'2016-02-01T00:00:00.000' AS DateTime), NULL, 4, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (53, 75, 426, CAST(N'2015-08-08T00:00:00.000' AS DateTime), CAST(N'2015-08-09T00:00:00.000' AS DateTime), NULL, 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (54, 72, 11, CAST(N'2016-12-31T00:00:00.000' AS DateTime), CAST(N'2016-12-31T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (55, 28, 212, CAST(N'2017-09-26T00:00:00.000' AS DateTime), CAST(N'2017-09-28T00:00:00.000' AS DateTime), NULL, 4, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (56, 68, 554, CAST(N'2017-05-29T00:00:00.000' AS DateTime), CAST(N'2017-05-30T00:00:00.000' AS DateTime), NULL, 4, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (57, 43, 311, CAST(N'2018-04-07T00:00:00.000' AS DateTime), CAST(N'2018-04-14T00:00:00.000' AS DateTime), NULL, 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (58, 50, 168, CAST(N'2017-07-31T00:00:00.000' AS DateTime), CAST(N'2017-07-31T00:00:00.000' AS DateTime), NULL, 4, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (59, 85, 133, CAST(N'2018-04-20T00:00:00.000' AS DateTime), CAST(N'2018-04-20T00:00:00.000' AS DateTime), NULL, 4, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (60, 33, 453, CAST(N'2016-06-02T00:00:00.000' AS DateTime), CAST(N'2016-06-05T00:00:00.000' AS DateTime), NULL, 4, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (61, 71, 74, CAST(N'2016-02-29T00:00:00.000' AS DateTime), CAST(N'2016-03-02T00:00:00.000' AS DateTime), NULL, 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (62, 27, 212, CAST(N'2015-11-27T00:00:00.000' AS DateTime), CAST(N'2015-12-01T00:00:00.000' AS DateTime), NULL, 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (63, 57, 463, CAST(N'2016-03-08T00:00:00.000' AS DateTime), CAST(N'2016-03-12T00:00:00.000' AS DateTime), NULL, 4, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (64, 54, 28, CAST(N'2017-04-09T00:00:00.000' AS DateTime), CAST(N'2017-04-09T00:00:00.000' AS DateTime), NULL, 4, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (65, 61, 112, CAST(N'2017-04-25T00:00:00.000' AS DateTime), CAST(N'2017-04-28T00:00:00.000' AS DateTime), NULL, 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (66, 88, 525, CAST(N'2015-04-09T00:00:00.000' AS DateTime), CAST(N'2015-04-10T00:00:00.000' AS DateTime), NULL, 4, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (67, 20, 207, CAST(N'2016-11-25T00:00:00.000' AS DateTime), CAST(N'2016-12-04T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (68, 63, 72, CAST(N'2015-09-12T00:00:00.000' AS DateTime), CAST(N'2015-09-15T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (69, 29, 273, CAST(N'2016-04-04T00:00:00.000' AS DateTime), CAST(N'2016-04-07T00:00:00.000' AS DateTime), NULL, 4, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (70, 56, 334, CAST(N'2017-10-27T00:00:00.000' AS DateTime), CAST(N'2017-10-29T00:00:00.000' AS DateTime), NULL, 4, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (71, 84, 364, CAST(N'2015-12-19T00:00:00.000' AS DateTime), CAST(N'2015-12-22T00:00:00.000' AS DateTime), NULL, 4, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (72, 28, 394, CAST(N'2017-09-11T00:00:00.000' AS DateTime), CAST(N'2017-09-11T00:00:00.000' AS DateTime), NULL, 4, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (73, 30, 522, CAST(N'2017-12-25T00:00:00.000' AS DateTime), CAST(N'2017-12-26T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (74, 58, 64, CAST(N'2016-05-12T00:00:00.000' AS DateTime), CAST(N'2016-05-15T00:00:00.000' AS DateTime), NULL, 4, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (75, 25, 573, CAST(N'2016-01-22T00:00:00.000' AS DateTime), CAST(N'2016-01-24T00:00:00.000' AS DateTime), NULL, 4, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (76, 23, 369, CAST(N'2015-11-17T00:00:00.000' AS DateTime), CAST(N'2015-11-25T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (77, 40, 576, CAST(N'2017-04-27T00:00:00.000' AS DateTime), CAST(N'2017-05-02T00:00:00.000' AS DateTime), NULL, 4, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (78, 97, 469, CAST(N'2016-07-19T00:00:00.000' AS DateTime), CAST(N'2016-07-20T00:00:00.000' AS DateTime), NULL, 4, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (79, 72, 394, CAST(N'2017-08-04T00:00:00.000' AS DateTime), CAST(N'2017-08-06T00:00:00.000' AS DateTime), NULL, 4, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (80, 61, 94, CAST(N'2018-02-03T00:00:00.000' AS DateTime), CAST(N'2018-02-05T00:00:00.000' AS DateTime), CAST(N'2018-02-11T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (81, 74, 391, CAST(N'2017-08-20T00:00:00.000' AS DateTime), CAST(N'2017-08-21T00:00:00.000' AS DateTime), CAST(N'2017-08-22T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (82, 89, 273, CAST(N'2017-12-18T00:00:00.000' AS DateTime), CAST(N'2017-12-19T00:00:00.000' AS DateTime), CAST(N'2017-12-24T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (83, 75, 391, CAST(N'2017-03-21T00:00:00.000' AS DateTime), CAST(N'2017-03-21T00:00:00.000' AS DateTime), CAST(N'2017-03-22T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (84, 96, 374, CAST(N'2018-02-20T00:00:00.000' AS DateTime), CAST(N'2018-02-21T00:00:00.000' AS DateTime), CAST(N'2018-02-22T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (85, 84, 555, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2017-04-26T00:00:00.000' AS DateTime), CAST(N'2017-04-30T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (86, 35, 334, CAST(N'2015-02-19T00:00:00.000' AS DateTime), CAST(N'2015-02-21T00:00:00.000' AS DateTime), CAST(N'2015-03-03T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (87, 77, 430, CAST(N'2016-11-23T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), CAST(N'2016-11-25T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (88, 43, 94, CAST(N'2015-06-10T00:00:00.000' AS DateTime), CAST(N'2015-06-11T00:00:00.000' AS DateTime), CAST(N'2015-06-20T00:00:00.000' AS DateTime), 5, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (89, 90, 66, CAST(N'2017-09-23T00:00:00.000' AS DateTime), CAST(N'2017-09-25T00:00:00.000' AS DateTime), CAST(N'2017-09-26T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (90, 45, 399, CAST(N'2015-05-01T00:00:00.000' AS DateTime), CAST(N'2015-05-02T00:00:00.000' AS DateTime), CAST(N'2015-05-03T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (91, 43, 145, CAST(N'2017-10-22T00:00:00.000' AS DateTime), CAST(N'2017-10-31T00:00:00.000' AS DateTime), CAST(N'2017-11-01T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (92, 72, 193, CAST(N'2016-09-02T00:00:00.000' AS DateTime), CAST(N'2016-09-04T00:00:00.000' AS DateTime), CAST(N'2016-09-06T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (93, 43, 11, CAST(N'2016-06-24T00:00:00.000' AS DateTime), CAST(N'2016-06-26T00:00:00.000' AS DateTime), CAST(N'2016-06-26T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (94, 32, 339, CAST(N'2017-10-08T00:00:00.000' AS DateTime), CAST(N'2017-10-10T00:00:00.000' AS DateTime), CAST(N'2017-10-19T00:00:00.000' AS DateTime), 5, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (95, 83, 368, CAST(N'2018-02-19T00:00:00.000' AS DateTime), CAST(N'2018-02-21T00:00:00.000' AS DateTime), CAST(N'2018-02-26T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (96, 89, 548, CAST(N'2016-02-13T00:00:00.000' AS DateTime), CAST(N'2016-02-13T00:00:00.000' AS DateTime), CAST(N'2016-02-15T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (97, 78, 304, CAST(N'2016-07-04T00:00:00.000' AS DateTime), CAST(N'2016-07-09T00:00:00.000' AS DateTime), CAST(N'2016-07-16T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (98, 21, 18, CAST(N'2017-09-30T00:00:00.000' AS DateTime), CAST(N'2017-10-04T00:00:00.000' AS DateTime), CAST(N'2017-10-05T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (99, 81, 381, CAST(N'2017-07-16T00:00:00.000' AS DateTime), CAST(N'2017-07-19T00:00:00.000' AS DateTime), CAST(N'2017-07-22T00:00:00.000' AS DateTime), 5, 1, 17)
GO
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (100, 35, 275, CAST(N'2017-05-01T00:00:00.000' AS DateTime), CAST(N'2017-05-07T00:00:00.000' AS DateTime), CAST(N'2017-05-07T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (101, 74, 15, CAST(N'2016-10-24T00:00:00.000' AS DateTime), CAST(N'2016-10-28T00:00:00.000' AS DateTime), CAST(N'2016-11-03T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (102, 63, 345, CAST(N'2017-09-14T00:00:00.000' AS DateTime), CAST(N'2017-09-14T00:00:00.000' AS DateTime), CAST(N'2017-09-23T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (103, 84, 203, CAST(N'2016-03-27T00:00:00.000' AS DateTime), CAST(N'2016-04-01T00:00:00.000' AS DateTime), CAST(N'2016-04-01T00:00:00.000' AS DateTime), 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (104, 74, 458, CAST(N'2016-08-07T00:00:00.000' AS DateTime), CAST(N'2016-08-07T00:00:00.000' AS DateTime), CAST(N'2016-08-14T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (105, 94, 272, CAST(N'2016-05-11T00:00:00.000' AS DateTime), CAST(N'2016-05-13T00:00:00.000' AS DateTime), CAST(N'2016-05-15T00:00:00.000' AS DateTime), 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (106, 54, 409, CAST(N'2018-03-02T00:00:00.000' AS DateTime), CAST(N'2018-03-07T00:00:00.000' AS DateTime), CAST(N'2018-03-09T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (107, 37, 327, CAST(N'2017-10-21T00:00:00.000' AS DateTime), CAST(N'2017-10-22T00:00:00.000' AS DateTime), CAST(N'2017-10-22T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (108, 95, 465, CAST(N'2015-05-05T00:00:00.000' AS DateTime), CAST(N'2015-05-12T00:00:00.000' AS DateTime), CAST(N'2015-05-13T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (109, 58, 242, CAST(N'2015-01-03T00:00:00.000' AS DateTime), CAST(N'2015-01-04T00:00:00.000' AS DateTime), CAST(N'2015-01-06T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (110, 94, 193, CAST(N'2015-11-03T00:00:00.000' AS DateTime), CAST(N'2015-11-06T00:00:00.000' AS DateTime), CAST(N'2015-11-08T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (111, 24, 410, CAST(N'2015-09-27T00:00:00.000' AS DateTime), CAST(N'2015-09-29T00:00:00.000' AS DateTime), CAST(N'2015-10-02T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (112, 79, 267, CAST(N'2016-04-04T00:00:00.000' AS DateTime), CAST(N'2016-04-07T00:00:00.000' AS DateTime), CAST(N'2016-04-09T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (113, 51, 539, CAST(N'2017-01-19T00:00:00.000' AS DateTime), CAST(N'2017-01-23T00:00:00.000' AS DateTime), CAST(N'2017-01-29T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (114, 21, 463, CAST(N'2018-06-08T00:00:00.000' AS DateTime), CAST(N'2018-06-11T00:00:00.000' AS DateTime), CAST(N'2018-06-19T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (115, 52, 55, CAST(N'2017-02-17T00:00:00.000' AS DateTime), CAST(N'2017-02-20T00:00:00.000' AS DateTime), CAST(N'2017-02-20T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (116, 63, 226, CAST(N'2017-05-09T00:00:00.000' AS DateTime), CAST(N'2017-05-09T00:00:00.000' AS DateTime), CAST(N'2017-05-11T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (117, 31, 241, CAST(N'2018-01-09T00:00:00.000' AS DateTime), CAST(N'2018-01-14T00:00:00.000' AS DateTime), CAST(N'2018-01-14T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (118, 76, 18, CAST(N'2018-02-05T00:00:00.000' AS DateTime), CAST(N'2018-02-08T00:00:00.000' AS DateTime), CAST(N'2018-02-09T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (119, 31, 476, CAST(N'2017-08-16T00:00:00.000' AS DateTime), CAST(N'2017-08-16T00:00:00.000' AS DateTime), CAST(N'2017-08-29T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (120, 41, 442, CAST(N'2017-02-21T00:00:00.000' AS DateTime), CAST(N'2017-02-26T00:00:00.000' AS DateTime), CAST(N'2017-03-06T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (121, 25, 149, CAST(N'2015-08-09T00:00:00.000' AS DateTime), CAST(N'2015-08-12T00:00:00.000' AS DateTime), CAST(N'2015-08-16T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (122, 45, 61, CAST(N'2018-01-06T00:00:00.000' AS DateTime), CAST(N'2018-01-07T00:00:00.000' AS DateTime), CAST(N'2018-01-19T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (123, 90, 312, CAST(N'2015-01-14T00:00:00.000' AS DateTime), CAST(N'2015-01-20T00:00:00.000' AS DateTime), CAST(N'2015-01-24T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (124, 93, 41, CAST(N'2018-03-09T00:00:00.000' AS DateTime), CAST(N'2018-03-17T00:00:00.000' AS DateTime), CAST(N'2018-03-18T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (125, 41, 399, CAST(N'2016-01-29T00:00:00.000' AS DateTime), CAST(N'2016-01-30T00:00:00.000' AS DateTime), CAST(N'2016-01-31T00:00:00.000' AS DateTime), 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (126, 84, 391, CAST(N'2017-03-18T00:00:00.000' AS DateTime), CAST(N'2017-03-25T00:00:00.000' AS DateTime), CAST(N'2017-03-26T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (127, 94, 302, CAST(N'2017-01-25T00:00:00.000' AS DateTime), CAST(N'2017-02-01T00:00:00.000' AS DateTime), CAST(N'2017-02-05T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (128, 67, 131, CAST(N'2016-05-15T00:00:00.000' AS DateTime), CAST(N'2016-05-15T00:00:00.000' AS DateTime), CAST(N'2016-05-27T00:00:00.000' AS DateTime), 5, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (129, 80, 298, CAST(N'2016-08-15T00:00:00.000' AS DateTime), CAST(N'2016-08-16T00:00:00.000' AS DateTime), CAST(N'2016-08-17T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (130, 61, 477, CAST(N'2017-08-23T00:00:00.000' AS DateTime), CAST(N'2017-08-23T00:00:00.000' AS DateTime), CAST(N'2017-09-02T00:00:00.000' AS DateTime), 5, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (131, 73, 344, CAST(N'2015-06-12T00:00:00.000' AS DateTime), CAST(N'2015-06-14T00:00:00.000' AS DateTime), CAST(N'2015-06-26T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (132, 75, 227, CAST(N'2017-03-29T00:00:00.000' AS DateTime), CAST(N'2017-03-30T00:00:00.000' AS DateTime), CAST(N'2017-03-30T00:00:00.000' AS DateTime), 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (133, 46, 491, CAST(N'2017-11-02T00:00:00.000' AS DateTime), CAST(N'2017-11-03T00:00:00.000' AS DateTime), CAST(N'2017-11-04T00:00:00.000' AS DateTime), 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (134, 26, 243, CAST(N'2018-05-15T00:00:00.000' AS DateTime), CAST(N'2018-05-17T00:00:00.000' AS DateTime), CAST(N'2018-05-18T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (135, 98, 565, CAST(N'2016-05-11T00:00:00.000' AS DateTime), CAST(N'2016-05-15T00:00:00.000' AS DateTime), CAST(N'2016-05-22T00:00:00.000' AS DateTime), 5, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (136, 47, 415, CAST(N'2015-01-14T00:00:00.000' AS DateTime), CAST(N'2015-01-22T00:00:00.000' AS DateTime), CAST(N'2015-01-22T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (137, 79, 572, CAST(N'2017-03-08T00:00:00.000' AS DateTime), CAST(N'2017-03-13T00:00:00.000' AS DateTime), CAST(N'2017-03-13T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (138, 96, 530, CAST(N'2016-04-11T00:00:00.000' AS DateTime), CAST(N'2016-04-11T00:00:00.000' AS DateTime), CAST(N'2016-04-12T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (139, 50, 321, CAST(N'2017-09-06T00:00:00.000' AS DateTime), CAST(N'2017-09-07T00:00:00.000' AS DateTime), CAST(N'2017-09-08T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (140, 52, 513, CAST(N'2015-04-05T00:00:00.000' AS DateTime), CAST(N'2015-04-11T00:00:00.000' AS DateTime), CAST(N'2015-04-19T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (141, 25, 9, CAST(N'2017-08-17T00:00:00.000' AS DateTime), CAST(N'2017-08-20T00:00:00.000' AS DateTime), CAST(N'2017-08-22T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (142, 61, 355, CAST(N'2016-04-23T00:00:00.000' AS DateTime), CAST(N'2016-04-24T00:00:00.000' AS DateTime), CAST(N'2016-04-27T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (143, 69, 197, CAST(N'2015-09-08T00:00:00.000' AS DateTime), CAST(N'2015-09-08T00:00:00.000' AS DateTime), CAST(N'2015-09-10T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (144, 93, 133, CAST(N'2016-12-10T00:00:00.000' AS DateTime), CAST(N'2016-12-10T00:00:00.000' AS DateTime), CAST(N'2016-12-15T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (145, 82, 568, CAST(N'2016-07-25T00:00:00.000' AS DateTime), CAST(N'2016-07-27T00:00:00.000' AS DateTime), CAST(N'2016-07-29T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (146, 60, 212, CAST(N'2017-10-27T00:00:00.000' AS DateTime), CAST(N'2017-10-28T00:00:00.000' AS DateTime), CAST(N'2017-10-29T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (147, 64, 420, CAST(N'2017-08-18T00:00:00.000' AS DateTime), CAST(N'2017-08-18T00:00:00.000' AS DateTime), CAST(N'2017-08-18T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (148, 48, 255, CAST(N'2018-04-15T00:00:00.000' AS DateTime), CAST(N'2018-04-16T00:00:00.000' AS DateTime), CAST(N'2018-04-18T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (149, 42, 453, CAST(N'2015-12-01T00:00:00.000' AS DateTime), CAST(N'2015-12-08T00:00:00.000' AS DateTime), CAST(N'2015-12-13T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (150, 74, 402, CAST(N'2017-07-18T00:00:00.000' AS DateTime), CAST(N'2017-07-27T00:00:00.000' AS DateTime), CAST(N'2017-07-29T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (151, 58, 142, CAST(N'2016-11-03T00:00:00.000' AS DateTime), CAST(N'2016-11-04T00:00:00.000' AS DateTime), CAST(N'2016-11-12T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (152, 90, 529, CAST(N'2017-11-11T00:00:00.000' AS DateTime), CAST(N'2017-11-12T00:00:00.000' AS DateTime), CAST(N'2017-11-18T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (153, 19, 76, CAST(N'2016-09-08T00:00:00.000' AS DateTime), CAST(N'2016-09-09T00:00:00.000' AS DateTime), CAST(N'2016-09-12T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (154, 60, 329, CAST(N'2018-04-24T00:00:00.000' AS DateTime), CAST(N'2018-04-24T00:00:00.000' AS DateTime), CAST(N'2018-04-25T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (155, 87, 202, CAST(N'2017-06-13T00:00:00.000' AS DateTime), CAST(N'2017-06-15T00:00:00.000' AS DateTime), CAST(N'2017-06-16T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (156, 23, 371, CAST(N'2017-03-05T00:00:00.000' AS DateTime), CAST(N'2017-03-09T00:00:00.000' AS DateTime), CAST(N'2017-03-13T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (157, 20, 48, CAST(N'2017-08-26T00:00:00.000' AS DateTime), CAST(N'2017-09-04T00:00:00.000' AS DateTime), CAST(N'2017-09-14T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (158, 30, 461, CAST(N'2016-10-05T00:00:00.000' AS DateTime), CAST(N'2016-10-06T00:00:00.000' AS DateTime), CAST(N'2016-10-09T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (159, 90, 285, CAST(N'2017-10-28T00:00:00.000' AS DateTime), CAST(N'2017-10-31T00:00:00.000' AS DateTime), CAST(N'2017-11-03T00:00:00.000' AS DateTime), 5, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (160, 56, 566, CAST(N'2016-11-15T00:00:00.000' AS DateTime), CAST(N'2016-11-16T00:00:00.000' AS DateTime), CAST(N'2016-11-21T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (161, 82, 182, CAST(N'2016-08-28T00:00:00.000' AS DateTime), CAST(N'2016-08-29T00:00:00.000' AS DateTime), CAST(N'2016-08-29T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (162, 27, 290, CAST(N'2016-05-08T00:00:00.000' AS DateTime), CAST(N'2016-05-10T00:00:00.000' AS DateTime), CAST(N'2016-05-11T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (163, 33, 63, CAST(N'2015-08-23T00:00:00.000' AS DateTime), CAST(N'2015-08-23T00:00:00.000' AS DateTime), CAST(N'2015-08-29T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (164, 78, 357, CAST(N'2015-10-07T00:00:00.000' AS DateTime), CAST(N'2015-10-07T00:00:00.000' AS DateTime), CAST(N'2015-10-11T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (165, 91, 69, CAST(N'2015-03-18T00:00:00.000' AS DateTime), CAST(N'2015-03-19T00:00:00.000' AS DateTime), CAST(N'2015-03-20T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (166, 65, 498, CAST(N'2016-09-19T00:00:00.000' AS DateTime), CAST(N'2016-09-24T00:00:00.000' AS DateTime), CAST(N'2016-09-25T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (167, 28, 194, CAST(N'2016-03-25T00:00:00.000' AS DateTime), CAST(N'2016-03-26T00:00:00.000' AS DateTime), CAST(N'2016-04-07T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (168, 80, 561, CAST(N'2016-09-28T00:00:00.000' AS DateTime), CAST(N'2016-10-01T00:00:00.000' AS DateTime), CAST(N'2016-10-07T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (169, 57, 563, CAST(N'2018-01-12T00:00:00.000' AS DateTime), CAST(N'2018-01-12T00:00:00.000' AS DateTime), CAST(N'2018-01-13T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (170, 81, 513, CAST(N'2015-12-24T00:00:00.000' AS DateTime), CAST(N'2015-12-27T00:00:00.000' AS DateTime), CAST(N'2015-12-31T00:00:00.000' AS DateTime), 5, 22, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (171, 81, 53, CAST(N'2017-08-19T00:00:00.000' AS DateTime), CAST(N'2017-08-26T00:00:00.000' AS DateTime), CAST(N'2017-09-05T00:00:00.000' AS DateTime), 5, 2, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (172, 66, 464, CAST(N'2015-09-21T00:00:00.000' AS DateTime), CAST(N'2015-09-27T00:00:00.000' AS DateTime), CAST(N'2015-10-03T00:00:00.000' AS DateTime), 5, 2, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (173, 27, 565, CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2015-09-22T00:00:00.000' AS DateTime), CAST(N'2015-09-23T00:00:00.000' AS DateTime), 5, 2, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (174, 88, 60, CAST(N'2018-05-26T00:00:00.000' AS DateTime), CAST(N'2018-05-26T00:00:00.000' AS DateTime), CAST(N'2018-05-27T00:00:00.000' AS DateTime), 5, 2, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (175, 95, 103, CAST(N'2016-03-22T00:00:00.000' AS DateTime), CAST(N'2016-03-26T00:00:00.000' AS DateTime), CAST(N'2016-03-26T00:00:00.000' AS DateTime), 5, 24, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (176, 57, 393, CAST(N'2016-11-05T00:00:00.000' AS DateTime), CAST(N'2016-11-10T00:00:00.000' AS DateTime), CAST(N'2016-11-12T00:00:00.000' AS DateTime), 5, 4, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (177, 25, 275, CAST(N'2016-12-02T00:00:00.000' AS DateTime), CAST(N'2016-12-02T00:00:00.000' AS DateTime), CAST(N'2016-12-04T00:00:00.000' AS DateTime), 5, 5, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (178, 19, 363, CAST(N'2015-07-28T00:00:00.000' AS DateTime), CAST(N'2015-08-01T00:00:00.000' AS DateTime), CAST(N'2015-08-03T00:00:00.000' AS DateTime), 5, 5, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (179, 93, 87, CAST(N'2016-08-24T00:00:00.000' AS DateTime), CAST(N'2016-08-30T00:00:00.000' AS DateTime), CAST(N'2016-08-30T00:00:00.000' AS DateTime), 5, 5, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (180, 84, 457, CAST(N'2017-03-18T00:00:00.000' AS DateTime), CAST(N'2017-03-18T00:00:00.000' AS DateTime), CAST(N'2017-03-20T00:00:00.000' AS DateTime), 5, 6, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (181, 92, 151, CAST(N'2017-04-12T00:00:00.000' AS DateTime), CAST(N'2017-04-13T00:00:00.000' AS DateTime), CAST(N'2017-04-15T00:00:00.000' AS DateTime), 5, 7, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (182, 60, 89, CAST(N'2015-06-10T00:00:00.000' AS DateTime), CAST(N'2015-06-12T00:00:00.000' AS DateTime), CAST(N'2015-06-14T00:00:00.000' AS DateTime), 5, 8, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (183, 25, 9, CAST(N'2016-08-05T00:00:00.000' AS DateTime), CAST(N'2016-08-05T00:00:00.000' AS DateTime), CAST(N'2016-08-08T00:00:00.000' AS DateTime), 5, 9, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (184, 61, 229, CAST(N'2015-05-03T00:00:00.000' AS DateTime), CAST(N'2015-05-03T00:00:00.000' AS DateTime), CAST(N'2015-05-04T00:00:00.000' AS DateTime), 5, 65, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (185, 32, 485, CAST(N'2015-02-05T00:00:00.000' AS DateTime), CAST(N'2015-02-08T00:00:00.000' AS DateTime), CAST(N'2015-02-12T00:00:00.000' AS DateTime), 5, 4, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (186, 64, 189, CAST(N'2016-09-06T00:00:00.000' AS DateTime), CAST(N'2016-09-11T00:00:00.000' AS DateTime), CAST(N'2016-09-11T00:00:00.000' AS DateTime), 5, 54, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (187, 92, 538, CAST(N'2016-05-15T00:00:00.000' AS DateTime), CAST(N'2016-05-18T00:00:00.000' AS DateTime), CAST(N'2016-05-25T00:00:00.000' AS DateTime), 5, 564, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (188, 46, 443, CAST(N'2017-03-01T00:00:00.000' AS DateTime), CAST(N'2017-03-10T00:00:00.000' AS DateTime), CAST(N'2017-03-10T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (189, 60, 514, CAST(N'2016-03-19T00:00:00.000' AS DateTime), CAST(N'2016-03-21T00:00:00.000' AS DateTime), CAST(N'2016-03-22T00:00:00.000' AS DateTime), 5, 4, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (190, 70, 167, CAST(N'2015-03-31T00:00:00.000' AS DateTime), CAST(N'2015-04-01T00:00:00.000' AS DateTime), CAST(N'2015-04-11T00:00:00.000' AS DateTime), 5, 4, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (191, 19, 112, CAST(N'2016-09-21T00:00:00.000' AS DateTime), CAST(N'2016-09-25T00:00:00.000' AS DateTime), CAST(N'2016-09-28T00:00:00.000' AS DateTime), 5, 3, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (192, 25, 505, CAST(N'2017-07-15T00:00:00.000' AS DateTime), CAST(N'2017-07-16T00:00:00.000' AS DateTime), CAST(N'2017-07-16T00:00:00.000' AS DateTime), 5, 4, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (193, 62, 574, CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-19T00:00:00.000' AS DateTime), 5, 4, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (194, 64, 510, CAST(N'2016-04-11T00:00:00.000' AS DateTime), CAST(N'2016-04-13T00:00:00.000' AS DateTime), CAST(N'2016-04-24T00:00:00.000' AS DateTime), 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (195, 38, 3, CAST(N'2016-06-06T00:00:00.000' AS DateTime), CAST(N'2016-06-15T00:00:00.000' AS DateTime), CAST(N'2016-06-20T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (196, 96, 559, CAST(N'2015-04-28T00:00:00.000' AS DateTime), CAST(N'2015-04-28T00:00:00.000' AS DateTime), CAST(N'2015-04-29T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (197, 82, 464, CAST(N'2015-10-05T00:00:00.000' AS DateTime), CAST(N'2015-10-06T00:00:00.000' AS DateTime), CAST(N'2015-10-06T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (198, 88, 162, CAST(N'2018-04-16T00:00:00.000' AS DateTime), CAST(N'2018-04-21T00:00:00.000' AS DateTime), CAST(N'2018-04-21T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (199, 77, 58, CAST(N'2018-02-24T00:00:00.000' AS DateTime), CAST(N'2018-02-25T00:00:00.000' AS DateTime), CAST(N'2018-02-26T00:00:00.000' AS DateTime), 5, 1, 1)
GO
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (200, 65, 420, CAST(N'2015-06-19T00:00:00.000' AS DateTime), CAST(N'2015-06-29T00:00:00.000' AS DateTime), CAST(N'2015-06-30T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (201, 51, 175, CAST(N'2017-06-03T00:00:00.000' AS DateTime), CAST(N'2017-06-08T00:00:00.000' AS DateTime), CAST(N'2017-06-11T00:00:00.000' AS DateTime), 5, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (202, 29, 492, CAST(N'2015-06-03T00:00:00.000' AS DateTime), CAST(N'2015-06-10T00:00:00.000' AS DateTime), CAST(N'2015-06-14T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (203, 44, 182, CAST(N'2017-12-03T00:00:00.000' AS DateTime), CAST(N'2017-12-09T00:00:00.000' AS DateTime), CAST(N'2017-12-11T00:00:00.000' AS DateTime), 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (204, 43, 42, CAST(N'2017-02-28T00:00:00.000' AS DateTime), CAST(N'2017-03-04T00:00:00.000' AS DateTime), CAST(N'2017-03-05T00:00:00.000' AS DateTime), 5, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (205, 76, 73, CAST(N'2017-05-08T00:00:00.000' AS DateTime), CAST(N'2017-05-12T00:00:00.000' AS DateTime), CAST(N'2017-05-15T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (206, 19, 207, CAST(N'2017-06-10T00:00:00.000' AS DateTime), CAST(N'2017-06-11T00:00:00.000' AS DateTime), CAST(N'2017-06-21T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (207, 91, 102, CAST(N'2015-10-21T00:00:00.000' AS DateTime), CAST(N'2015-10-24T00:00:00.000' AS DateTime), CAST(N'2015-11-01T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (208, 69, 248, CAST(N'2017-06-24T00:00:00.000' AS DateTime), CAST(N'2017-06-24T00:00:00.000' AS DateTime), CAST(N'2017-06-30T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (209, 86, 559, CAST(N'2018-03-05T00:00:00.000' AS DateTime), CAST(N'2018-03-14T00:00:00.000' AS DateTime), CAST(N'2018-03-16T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (210, 30, 12, CAST(N'2017-05-16T00:00:00.000' AS DateTime), CAST(N'2017-05-20T00:00:00.000' AS DateTime), CAST(N'2017-05-26T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (211, 28, 414, CAST(N'2017-10-02T00:00:00.000' AS DateTime), CAST(N'2017-10-05T00:00:00.000' AS DateTime), CAST(N'2017-10-05T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (212, 47, 417, CAST(N'2015-09-11T00:00:00.000' AS DateTime), CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-16T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (213, 53, 262, CAST(N'2017-06-03T00:00:00.000' AS DateTime), CAST(N'2017-06-06T00:00:00.000' AS DateTime), CAST(N'2017-06-06T00:00:00.000' AS DateTime), 5, 2, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (214, 45, 384, CAST(N'2017-01-22T00:00:00.000' AS DateTime), CAST(N'2017-01-23T00:00:00.000' AS DateTime), CAST(N'2017-01-25T00:00:00.000' AS DateTime), 5, 2, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (215, 49, 85, CAST(N'2018-02-23T00:00:00.000' AS DateTime), CAST(N'2018-02-27T00:00:00.000' AS DateTime), CAST(N'2018-03-06T00:00:00.000' AS DateTime), 5, 2, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (216, 21, 343, CAST(N'2017-05-25T00:00:00.000' AS DateTime), CAST(N'2017-05-28T00:00:00.000' AS DateTime), CAST(N'2017-05-29T00:00:00.000' AS DateTime), 5, 2, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (217, 85, 148, CAST(N'2015-09-05T00:00:00.000' AS DateTime), CAST(N'2015-09-05T00:00:00.000' AS DateTime), CAST(N'2015-09-12T00:00:00.000' AS DateTime), 5, 3, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (218, 91, 168, CAST(N'2016-02-14T00:00:00.000' AS DateTime), CAST(N'2016-02-23T00:00:00.000' AS DateTime), CAST(N'2016-02-23T00:00:00.000' AS DateTime), 5, 4, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (219, 92, 506, CAST(N'2015-02-11T00:00:00.000' AS DateTime), CAST(N'2015-02-12T00:00:00.000' AS DateTime), CAST(N'2015-02-15T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (220, 87, 357, CAST(N'2017-02-04T00:00:00.000' AS DateTime), CAST(N'2017-02-05T00:00:00.000' AS DateTime), CAST(N'2017-02-07T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (221, 66, 167, CAST(N'2017-05-01T00:00:00.000' AS DateTime), CAST(N'2017-05-01T00:00:00.000' AS DateTime), CAST(N'2017-05-03T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (222, 66, 471, CAST(N'2017-08-19T00:00:00.000' AS DateTime), CAST(N'2017-08-23T00:00:00.000' AS DateTime), CAST(N'2017-08-25T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (223, 21, 139, CAST(N'2017-12-26T00:00:00.000' AS DateTime), CAST(N'2018-01-04T00:00:00.000' AS DateTime), CAST(N'2018-01-04T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (224, 98, 254, CAST(N'2015-05-25T00:00:00.000' AS DateTime), CAST(N'2015-05-25T00:00:00.000' AS DateTime), CAST(N'2015-05-29T00:00:00.000' AS DateTime), 5, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (225, 73, 133, CAST(N'2016-08-11T00:00:00.000' AS DateTime), CAST(N'2016-08-11T00:00:00.000' AS DateTime), CAST(N'2016-08-16T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (226, 21, 173, CAST(N'2017-08-02T00:00:00.000' AS DateTime), CAST(N'2017-08-05T00:00:00.000' AS DateTime), CAST(N'2017-08-09T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (227, 80, 328, CAST(N'2016-12-17T00:00:00.000' AS DateTime), CAST(N'2016-12-20T00:00:00.000' AS DateTime), CAST(N'2016-12-22T00:00:00.000' AS DateTime), 5, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (228, 48, 36, CAST(N'2018-05-25T00:00:00.000' AS DateTime), CAST(N'2018-05-27T00:00:00.000' AS DateTime), CAST(N'2018-05-29T00:00:00.000' AS DateTime), 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (229, 71, 329, CAST(N'2015-06-20T00:00:00.000' AS DateTime), CAST(N'2015-06-23T00:00:00.000' AS DateTime), CAST(N'2015-06-23T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (230, 92, 90, CAST(N'2017-09-06T00:00:00.000' AS DateTime), CAST(N'2017-09-10T00:00:00.000' AS DateTime), CAST(N'2017-09-17T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (231, 25, 63, CAST(N'2015-04-11T00:00:00.000' AS DateTime), CAST(N'2015-04-12T00:00:00.000' AS DateTime), CAST(N'2015-04-17T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (232, 31, 369, CAST(N'2015-03-23T00:00:00.000' AS DateTime), CAST(N'2015-03-28T00:00:00.000' AS DateTime), CAST(N'2015-04-03T00:00:00.000' AS DateTime), 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (233, 50, 402, CAST(N'2016-12-23T00:00:00.000' AS DateTime), CAST(N'2016-12-26T00:00:00.000' AS DateTime), CAST(N'2016-12-28T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (234, 60, 32, CAST(N'2017-04-02T00:00:00.000' AS DateTime), CAST(N'2017-04-02T00:00:00.000' AS DateTime), CAST(N'2017-04-05T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (235, 96, 328, CAST(N'2018-04-25T00:00:00.000' AS DateTime), CAST(N'2018-05-02T00:00:00.000' AS DateTime), CAST(N'2018-05-03T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (236, 21, 209, CAST(N'2016-10-02T00:00:00.000' AS DateTime), CAST(N'2016-10-03T00:00:00.000' AS DateTime), CAST(N'2016-10-06T00:00:00.000' AS DateTime), 5, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (237, 67, 275, CAST(N'2015-03-26T00:00:00.000' AS DateTime), CAST(N'2015-03-28T00:00:00.000' AS DateTime), CAST(N'2015-03-28T00:00:00.000' AS DateTime), 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (238, 42, 361, CAST(N'2016-12-23T00:00:00.000' AS DateTime), CAST(N'2016-12-24T00:00:00.000' AS DateTime), CAST(N'2016-12-24T00:00:00.000' AS DateTime), 5, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (239, 60, 371, CAST(N'2016-07-10T00:00:00.000' AS DateTime), CAST(N'2016-07-11T00:00:00.000' AS DateTime), CAST(N'2016-07-15T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (240, 53, 454, CAST(N'2016-02-28T00:00:00.000' AS DateTime), CAST(N'2016-03-02T00:00:00.000' AS DateTime), CAST(N'2016-03-09T00:00:00.000' AS DateTime), 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (241, 98, 109, CAST(N'2015-10-24T00:00:00.000' AS DateTime), CAST(N'2015-10-25T00:00:00.000' AS DateTime), CAST(N'2015-10-26T00:00:00.000' AS DateTime), 5, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (242, 46, 315, CAST(N'2018-03-04T00:00:00.000' AS DateTime), CAST(N'2018-03-05T00:00:00.000' AS DateTime), CAST(N'2018-03-09T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (243, 54, 252, CAST(N'2015-01-16T00:00:00.000' AS DateTime), CAST(N'2015-01-22T00:00:00.000' AS DateTime), CAST(N'2015-01-24T00:00:00.000' AS DateTime), 5, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (244, 75, 87, CAST(N'2017-05-19T00:00:00.000' AS DateTime), CAST(N'2017-05-19T00:00:00.000' AS DateTime), CAST(N'2017-05-22T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (245, 97, 502, CAST(N'2018-05-12T00:00:00.000' AS DateTime), CAST(N'2018-05-13T00:00:00.000' AS DateTime), CAST(N'2018-05-17T00:00:00.000' AS DateTime), 5, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (246, 31, 406, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2017-01-07T00:00:00.000' AS DateTime), CAST(N'2017-01-08T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (247, 74, 170, CAST(N'2016-09-02T00:00:00.000' AS DateTime), CAST(N'2016-09-09T00:00:00.000' AS DateTime), CAST(N'2016-09-12T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (248, 59, 253, CAST(N'2016-07-28T00:00:00.000' AS DateTime), CAST(N'2016-07-29T00:00:00.000' AS DateTime), CAST(N'2016-08-09T00:00:00.000' AS DateTime), 5, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (249, 75, 64, CAST(N'2015-01-24T00:00:00.000' AS DateTime), CAST(N'2015-01-26T00:00:00.000' AS DateTime), CAST(N'2015-02-01T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (250, 50, 384, CAST(N'2017-09-03T00:00:00.000' AS DateTime), CAST(N'2017-09-07T00:00:00.000' AS DateTime), CAST(N'2017-09-13T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (251, 36, 107, CAST(N'2015-03-24T00:00:00.000' AS DateTime), CAST(N'2015-03-27T00:00:00.000' AS DateTime), CAST(N'2015-03-29T00:00:00.000' AS DateTime), 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (252, 85, 343, CAST(N'2016-07-21T00:00:00.000' AS DateTime), CAST(N'2016-07-31T00:00:00.000' AS DateTime), CAST(N'2016-08-09T00:00:00.000' AS DateTime), 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (253, 81, 382, CAST(N'2017-05-16T00:00:00.000' AS DateTime), CAST(N'2017-05-24T00:00:00.000' AS DateTime), CAST(N'2017-05-26T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (254, 52, 263, CAST(N'2017-09-01T00:00:00.000' AS DateTime), CAST(N'2017-09-01T00:00:00.000' AS DateTime), CAST(N'2017-09-03T00:00:00.000' AS DateTime), 5, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (255, 60, 508, CAST(N'2015-05-12T00:00:00.000' AS DateTime), CAST(N'2015-05-14T00:00:00.000' AS DateTime), CAST(N'2015-05-19T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (256, 78, 438, CAST(N'2017-11-19T00:00:00.000' AS DateTime), CAST(N'2017-11-24T00:00:00.000' AS DateTime), CAST(N'2017-11-28T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (257, 87, 467, CAST(N'2017-05-13T00:00:00.000' AS DateTime), CAST(N'2017-05-14T00:00:00.000' AS DateTime), CAST(N'2017-05-23T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (258, 50, 9, CAST(N'2018-04-01T00:00:00.000' AS DateTime), CAST(N'2018-04-04T00:00:00.000' AS DateTime), CAST(N'2018-04-10T00:00:00.000' AS DateTime), 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (259, 37, 38, CAST(N'2018-04-24T00:00:00.000' AS DateTime), CAST(N'2018-04-27T00:00:00.000' AS DateTime), CAST(N'2018-04-28T00:00:00.000' AS DateTime), 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (260, 48, 165, CAST(N'2017-02-03T00:00:00.000' AS DateTime), CAST(N'2017-02-03T00:00:00.000' AS DateTime), CAST(N'2017-02-04T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (261, 75, 187, CAST(N'2015-11-26T00:00:00.000' AS DateTime), CAST(N'2015-11-27T00:00:00.000' AS DateTime), CAST(N'2015-11-29T00:00:00.000' AS DateTime), 5, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (262, 21, 69, CAST(N'2017-12-09T00:00:00.000' AS DateTime), CAST(N'2017-12-10T00:00:00.000' AS DateTime), CAST(N'2017-12-23T00:00:00.000' AS DateTime), 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (263, 93, 57, CAST(N'2016-01-21T00:00:00.000' AS DateTime), CAST(N'2016-01-24T00:00:00.000' AS DateTime), CAST(N'2016-01-27T00:00:00.000' AS DateTime), 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (264, 67, 106, CAST(N'2016-03-03T00:00:00.000' AS DateTime), CAST(N'2016-03-04T00:00:00.000' AS DateTime), CAST(N'2016-03-07T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (265, 87, 491, CAST(N'2015-09-01T00:00:00.000' AS DateTime), CAST(N'2015-09-01T00:00:00.000' AS DateTime), CAST(N'2015-09-12T00:00:00.000' AS DateTime), 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (266, 38, 280, CAST(N'2015-07-11T00:00:00.000' AS DateTime), CAST(N'2015-07-13T00:00:00.000' AS DateTime), CAST(N'2015-07-16T00:00:00.000' AS DateTime), 5, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (267, 51, 463, CAST(N'2017-01-31T00:00:00.000' AS DateTime), CAST(N'2017-02-02T00:00:00.000' AS DateTime), NULL, 5, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (268, 43, 575, CAST(N'2015-09-10T00:00:00.000' AS DateTime), CAST(N'2015-09-18T00:00:00.000' AS DateTime), CAST(N'2015-09-18T00:00:00.000' AS DateTime), 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (269, 56, 367, CAST(N'2016-07-02T00:00:00.000' AS DateTime), CAST(N'2016-07-03T00:00:00.000' AS DateTime), NULL, 2, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (270, 83, 14, CAST(N'2018-01-09T00:00:00.000' AS DateTime), CAST(N'2018-01-10T00:00:00.000' AS DateTime), CAST(N'2018-01-17T00:00:00.000' AS DateTime), 1, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (271, 62, 339, CAST(N'2015-11-17T00:00:00.000' AS DateTime), CAST(N'2015-11-17T00:00:00.000' AS DateTime), NULL, 1, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (272, 93, 407, CAST(N'2018-04-27T00:00:00.000' AS DateTime), CAST(N'2018-04-29T00:00:00.000' AS DateTime), NULL, 4, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (273, 81, 383, CAST(N'2015-09-12T00:00:00.000' AS DateTime), CAST(N'2015-09-12T00:00:00.000' AS DateTime), NULL, 4, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (274, 43, 445, CAST(N'2016-11-21T00:00:00.000' AS DateTime), CAST(N'2016-11-21T00:00:00.000' AS DateTime), CAST(N'2016-11-24T00:00:00.000' AS DateTime), 2, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (275, 75, 281, CAST(N'2017-12-28T00:00:00.000' AS DateTime), CAST(N'2017-12-30T00:00:00.000' AS DateTime), NULL, 2, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (276, 62, 6, CAST(N'2016-08-16T00:00:00.000' AS DateTime), CAST(N'2016-08-17T00:00:00.000' AS DateTime), NULL, 3, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (277, 32, 57, CAST(N'2015-03-06T00:00:00.000' AS DateTime), CAST(N'2015-03-06T00:00:00.000' AS DateTime), NULL, 5, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (278, 98, 446, CAST(N'2015-09-19T00:00:00.000' AS DateTime), CAST(N'2015-09-20T00:00:00.000' AS DateTime), NULL, 1, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (279, 58, 360, CAST(N'2015-07-13T00:00:00.000' AS DateTime), CAST(N'2015-07-15T00:00:00.000' AS DateTime), CAST(N'2015-07-15T00:00:00.000' AS DateTime), 4, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (280, 69, 321, CAST(N'2016-08-07T00:00:00.000' AS DateTime), CAST(N'2016-08-11T00:00:00.000' AS DateTime), NULL, 5, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (281, 44, 3, CAST(N'2016-01-23T00:00:00.000' AS DateTime), CAST(N'2016-01-30T00:00:00.000' AS DateTime), NULL, 1, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (282, 38, 222, CAST(N'2016-03-04T00:00:00.000' AS DateTime), CAST(N'2016-03-05T00:00:00.000' AS DateTime), NULL, 1, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (283, 77, 366, CAST(N'2015-07-21T00:00:00.000' AS DateTime), CAST(N'2015-07-23T00:00:00.000' AS DateTime), NULL, 1, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (284, 57, 535, CAST(N'2017-04-06T00:00:00.000' AS DateTime), CAST(N'2017-04-06T00:00:00.000' AS DateTime), NULL, 1, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (285, 93, 251, CAST(N'2016-11-12T00:00:00.000' AS DateTime), CAST(N'2016-11-14T00:00:00.000' AS DateTime), NULL, 1, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (286, 25, 192, CAST(N'2016-09-16T00:00:00.000' AS DateTime), CAST(N'2016-09-17T00:00:00.000' AS DateTime), NULL, 2, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (287, 71, 568, CAST(N'2015-10-24T00:00:00.000' AS DateTime), CAST(N'2015-10-26T00:00:00.000' AS DateTime), NULL, 1, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (288, 60, 113, CAST(N'2016-09-04T00:00:00.000' AS DateTime), CAST(N'2016-09-07T00:00:00.000' AS DateTime), NULL, 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (289, 87, 97, CAST(N'2016-10-24T00:00:00.000' AS DateTime), CAST(N'2016-10-29T00:00:00.000' AS DateTime), CAST(N'2016-11-04T00:00:00.000' AS DateTime), 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (290, 42, 14, CAST(N'2018-06-01T00:00:00.000' AS DateTime), CAST(N'2018-06-09T00:00:00.000' AS DateTime), NULL, 1, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (291, 55, 444, CAST(N'2016-07-17T00:00:00.000' AS DateTime), CAST(N'2016-07-24T00:00:00.000' AS DateTime), CAST(N'2016-07-27T00:00:00.000' AS DateTime), 5, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (292, 65, 521, CAST(N'2018-05-12T00:00:00.000' AS DateTime), CAST(N'2018-05-14T00:00:00.000' AS DateTime), NULL, 2, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (293, 28, 429, CAST(N'2016-10-01T00:00:00.000' AS DateTime), CAST(N'2016-10-02T00:00:00.000' AS DateTime), NULL, 1, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (294, 32, 491, CAST(N'2018-04-13T00:00:00.000' AS DateTime), CAST(N'2018-04-17T00:00:00.000' AS DateTime), NULL, 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (295, 44, 133, CAST(N'2017-04-15T00:00:00.000' AS DateTime), CAST(N'2017-04-21T00:00:00.000' AS DateTime), NULL, 4, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (296, 26, 132, CAST(N'2015-12-30T00:00:00.000' AS DateTime), CAST(N'2016-01-04T00:00:00.000' AS DateTime), NULL, 5, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (297, 79, 75, CAST(N'2017-09-15T00:00:00.000' AS DateTime), CAST(N'2017-09-17T00:00:00.000' AS DateTime), NULL, 1, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (298, 38, 558, CAST(N'2018-02-11T00:00:00.000' AS DateTime), CAST(N'2018-02-14T00:00:00.000' AS DateTime), CAST(N'2018-02-25T00:00:00.000' AS DateTime), 2, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (299, 91, 2, CAST(N'2015-11-01T00:00:00.000' AS DateTime), CAST(N'2015-11-01T00:00:00.000' AS DateTime), NULL, 3, 1, 5)
GO
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (300, 58, 463, CAST(N'2015-05-14T00:00:00.000' AS DateTime), CAST(N'2015-05-16T00:00:00.000' AS DateTime), NULL, 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (301, 43, 147, CAST(N'2017-06-17T00:00:00.000' AS DateTime), CAST(N'2017-06-17T00:00:00.000' AS DateTime), NULL, 5, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (302, 93, 71, CAST(N'2017-07-26T00:00:00.000' AS DateTime), CAST(N'2017-08-02T00:00:00.000' AS DateTime), NULL, 4, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (303, 25, 396, CAST(N'2018-01-19T00:00:00.000' AS DateTime), CAST(N'2018-01-23T00:00:00.000' AS DateTime), NULL, 5, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (304, 39, 3, CAST(N'2015-04-28T00:00:00.000' AS DateTime), CAST(N'2015-05-03T00:00:00.000' AS DateTime), NULL, 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (305, 69, 318, CAST(N'2015-11-25T00:00:00.000' AS DateTime), CAST(N'2015-11-30T00:00:00.000' AS DateTime), NULL, 2, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (306, 98, 374, CAST(N'2016-05-16T00:00:00.000' AS DateTime), CAST(N'2016-05-21T00:00:00.000' AS DateTime), NULL, 4, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (307, 55, 461, CAST(N'2016-04-02T00:00:00.000' AS DateTime), CAST(N'2016-04-02T00:00:00.000' AS DateTime), NULL, 2, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (308, 69, 106, CAST(N'2018-05-27T00:00:00.000' AS DateTime), CAST(N'2018-05-27T00:00:00.000' AS DateTime), NULL, 3, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (309, 32, 476, CAST(N'2017-07-22T00:00:00.000' AS DateTime), CAST(N'2017-07-23T00:00:00.000' AS DateTime), NULL, 5, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (310, 78, 222, CAST(N'2015-10-22T00:00:00.000' AS DateTime), CAST(N'2015-10-26T00:00:00.000' AS DateTime), NULL, 3, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (311, 35, 430, CAST(N'2018-01-18T00:00:00.000' AS DateTime), CAST(N'2018-01-19T00:00:00.000' AS DateTime), NULL, 4, 1, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (312, 57, 130, CAST(N'2017-07-03T00:00:00.000' AS DateTime), CAST(N'2017-07-05T00:00:00.000' AS DateTime), CAST(N'2017-07-12T00:00:00.000' AS DateTime), 4, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (313, 49, 34, CAST(N'2018-04-22T00:00:00.000' AS DateTime), CAST(N'2018-04-27T00:00:00.000' AS DateTime), NULL, 1, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (314, 80, 361, CAST(N'2016-09-05T00:00:00.000' AS DateTime), CAST(N'2016-09-06T00:00:00.000' AS DateTime), NULL, 2, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (315, 74, 177, CAST(N'2015-07-06T00:00:00.000' AS DateTime), CAST(N'2015-07-06T00:00:00.000' AS DateTime), NULL, 4, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (316, 55, 218, CAST(N'2017-10-18T00:00:00.000' AS DateTime), CAST(N'2017-10-20T00:00:00.000' AS DateTime), NULL, 2, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (317, 35, 401, CAST(N'2016-10-28T00:00:00.000' AS DateTime), CAST(N'2016-10-31T00:00:00.000' AS DateTime), CAST(N'2016-11-09T00:00:00.000' AS DateTime), 2, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (318, 84, 342, CAST(N'2017-12-22T00:00:00.000' AS DateTime), CAST(N'2017-12-24T00:00:00.000' AS DateTime), NULL, 5, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (319, 23, 527, CAST(N'2017-08-02T00:00:00.000' AS DateTime), CAST(N'2017-08-09T00:00:00.000' AS DateTime), NULL, 1, 1, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (320, 48, 408, CAST(N'2016-12-01T00:00:00.000' AS DateTime), CAST(N'2016-12-03T00:00:00.000' AS DateTime), NULL, 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (321, 65, 210, CAST(N'2017-11-29T00:00:00.000' AS DateTime), CAST(N'2017-11-30T00:00:00.000' AS DateTime), NULL, 2, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (322, 84, 185, CAST(N'2016-02-27T00:00:00.000' AS DateTime), CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, 5, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (323, 53, 383, CAST(N'2017-06-16T00:00:00.000' AS DateTime), CAST(N'2017-06-16T00:00:00.000' AS DateTime), NULL, 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (324, 94, 384, CAST(N'2015-11-24T00:00:00.000' AS DateTime), CAST(N'2015-11-30T00:00:00.000' AS DateTime), NULL, 3, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (325, 75, 157, CAST(N'2017-06-02T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), CAST(N'2017-06-06T00:00:00.000' AS DateTime), 3, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (326, 43, 249, CAST(N'2015-05-31T00:00:00.000' AS DateTime), CAST(N'2015-06-03T00:00:00.000' AS DateTime), NULL, 5, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (327, 69, 496, CAST(N'2018-01-02T00:00:00.000' AS DateTime), CAST(N'2018-01-03T00:00:00.000' AS DateTime), NULL, 1, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (328, 86, 275, CAST(N'2017-03-11T00:00:00.000' AS DateTime), CAST(N'2017-03-16T00:00:00.000' AS DateTime), NULL, 4, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (329, 49, 358, CAST(N'2017-02-02T00:00:00.000' AS DateTime), CAST(N'2017-02-09T00:00:00.000' AS DateTime), NULL, 5, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (330, 28, 326, CAST(N'2015-06-29T00:00:00.000' AS DateTime), CAST(N'2015-07-02T00:00:00.000' AS DateTime), NULL, 2, 1, 23)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (331, 30, 541, CAST(N'2017-02-20T00:00:00.000' AS DateTime), CAST(N'2017-02-26T00:00:00.000' AS DateTime), CAST(N'2017-02-26T00:00:00.000' AS DateTime), 3, 1, 1)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (332, 31, 575, CAST(N'2017-10-10T00:00:00.000' AS DateTime), CAST(N'2017-10-10T00:00:00.000' AS DateTime), CAST(N'2017-10-16T00:00:00.000' AS DateTime), 1, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (333, 39, 299, CAST(N'2017-01-03T00:00:00.000' AS DateTime), CAST(N'2017-01-04T00:00:00.000' AS DateTime), NULL, 2, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (334, 40, 221, CAST(N'2015-09-19T00:00:00.000' AS DateTime), CAST(N'2015-09-20T00:00:00.000' AS DateTime), NULL, 4, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (335, 51, 501, CAST(N'2017-03-07T00:00:00.000' AS DateTime), CAST(N'2017-03-08T00:00:00.000' AS DateTime), CAST(N'2017-03-10T00:00:00.000' AS DateTime), 1, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (336, 88, 76, CAST(N'2016-07-28T00:00:00.000' AS DateTime), CAST(N'2016-08-01T00:00:00.000' AS DateTime), NULL, 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (337, 85, 176, CAST(N'2015-12-29T00:00:00.000' AS DateTime), CAST(N'2015-12-30T00:00:00.000' AS DateTime), NULL, 3, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (338, 38, 235, CAST(N'2015-06-27T00:00:00.000' AS DateTime), CAST(N'2015-07-01T00:00:00.000' AS DateTime), CAST(N'2015-07-01T00:00:00.000' AS DateTime), 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (339, 88, 306, CAST(N'2015-12-30T00:00:00.000' AS DateTime), CAST(N'2016-01-01T00:00:00.000' AS DateTime), CAST(N'2016-01-02T00:00:00.000' AS DateTime), 5, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (340, 54, 269, CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-21T00:00:00.000' AS DateTime), NULL, 5, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (341, 41, 365, CAST(N'2016-07-16T00:00:00.000' AS DateTime), CAST(N'2016-07-20T00:00:00.000' AS DateTime), NULL, 3, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (342, 86, 52, CAST(N'2017-02-05T00:00:00.000' AS DateTime), CAST(N'2017-02-08T00:00:00.000' AS DateTime), NULL, 5, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (343, 85, 176, CAST(N'2016-09-02T00:00:00.000' AS DateTime), CAST(N'2016-09-02T00:00:00.000' AS DateTime), NULL, 1, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (344, 94, 134, CAST(N'2017-06-25T00:00:00.000' AS DateTime), CAST(N'2017-06-26T00:00:00.000' AS DateTime), NULL, 4, 1, 11)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (345, 25, 60, CAST(N'2015-03-11T00:00:00.000' AS DateTime), CAST(N'2015-03-12T00:00:00.000' AS DateTime), CAST(N'2015-03-15T00:00:00.000' AS DateTime), 4, 1, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (346, 65, 410, CAST(N'2018-04-26T00:00:00.000' AS DateTime), CAST(N'2018-04-30T00:00:00.000' AS DateTime), NULL, 1, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (347, 20, 105, CAST(N'2017-04-12T00:00:00.000' AS DateTime), CAST(N'2017-04-13T00:00:00.000' AS DateTime), NULL, 2, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (348, 87, 18, CAST(N'2015-01-06T00:00:00.000' AS DateTime), CAST(N'2015-01-10T00:00:00.000' AS DateTime), NULL, 3, 1, 12)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (349, 76, 575, CAST(N'2015-09-09T00:00:00.000' AS DateTime), CAST(N'2015-09-09T00:00:00.000' AS DateTime), CAST(N'2015-09-09T00:00:00.000' AS DateTime), 1, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (350, 90, 130, CAST(N'2015-05-22T00:00:00.000' AS DateTime), CAST(N'2015-05-24T00:00:00.000' AS DateTime), NULL, 1, 1, 19)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (351, 32, 214, CAST(N'2015-09-14T00:00:00.000' AS DateTime), CAST(N'2015-09-14T00:00:00.000' AS DateTime), NULL, 1, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (352, 56, 34, CAST(N'2015-05-31T00:00:00.000' AS DateTime), CAST(N'2015-06-01T00:00:00.000' AS DateTime), NULL, 2, 1, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (353, 92, 231, CAST(N'2015-10-25T00:00:00.000' AS DateTime), CAST(N'2015-10-25T00:00:00.000' AS DateTime), NULL, 3, 1, 18)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (354, 96, 503, CAST(N'2016-09-27T00:00:00.000' AS DateTime), CAST(N'2016-10-03T00:00:00.000' AS DateTime), NULL, 1, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (355, 23, 133, CAST(N'2015-06-18T00:00:00.000' AS DateTime), CAST(N'2015-06-19T00:00:00.000' AS DateTime), NULL, 4, 1, 16)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (356, 76, 315, CAST(N'2017-01-14T00:00:00.000' AS DateTime), CAST(N'2017-01-14T00:00:00.000' AS DateTime), NULL, 1, 1, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (357, 36, 267, CAST(N'2016-05-06T00:00:00.000' AS DateTime), CAST(N'2016-05-08T00:00:00.000' AS DateTime), NULL, 5, 1, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (358, 54, 429, CAST(N'2017-10-07T00:00:00.000' AS DateTime), CAST(N'2017-10-07T00:00:00.000' AS DateTime), NULL, 1, 1, 6)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (359, 72, 505, CAST(N'2016-04-08T00:00:00.000' AS DateTime), CAST(N'2016-04-10T00:00:00.000' AS DateTime), CAST(N'2016-04-11T00:00:00.000' AS DateTime), 4, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (360, 84, 224, CAST(N'2015-07-22T00:00:00.000' AS DateTime), CAST(N'2015-08-01T00:00:00.000' AS DateTime), NULL, 5, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (361, 59, 326, CAST(N'2016-09-17T00:00:00.000' AS DateTime), CAST(N'2016-09-17T00:00:00.000' AS DateTime), NULL, 2, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (362, 31, 303, CAST(N'2017-11-06T00:00:00.000' AS DateTime), CAST(N'2017-11-10T00:00:00.000' AS DateTime), NULL, 1, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (363, 91, 96, CAST(N'2017-07-26T00:00:00.000' AS DateTime), CAST(N'2017-07-26T00:00:00.000' AS DateTime), NULL, 2, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (364, 32, 55, CAST(N'2017-12-07T00:00:00.000' AS DateTime), CAST(N'2017-12-07T00:00:00.000' AS DateTime), NULL, 2, 1, 21)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (365, 59, 458, CAST(N'2016-12-25T00:00:00.000' AS DateTime), CAST(N'2017-01-03T00:00:00.000' AS DateTime), NULL, 1, 1, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (366, 85, 16, CAST(N'2018-05-03T00:00:00.000' AS DateTime), CAST(N'2018-05-05T00:00:00.000' AS DateTime), NULL, 3, 1, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (367, 53, 131, CAST(N'2018-03-13T00:00:00.000' AS DateTime), CAST(N'2018-03-15T00:00:00.000' AS DateTime), NULL, 5, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (368, 79, 320, CAST(N'2016-07-25T00:00:00.000' AS DateTime), CAST(N'2016-07-29T00:00:00.000' AS DateTime), NULL, 4, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (369, 99, 216, CAST(N'2017-05-03T00:00:00.000' AS DateTime), CAST(N'2017-05-05T00:00:00.000' AS DateTime), CAST(N'2017-05-05T00:00:00.000' AS DateTime), 3, 1, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (370, 55, 564, CAST(N'2015-09-15T00:00:00.000' AS DateTime), CAST(N'2015-09-16T00:00:00.000' AS DateTime), CAST(N'2015-09-16T00:00:00.000' AS DateTime), 3, 1, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (371, 70, 222, CAST(N'2015-01-28T00:00:00.000' AS DateTime), CAST(N'2015-01-29T00:00:00.000' AS DateTime), NULL, 1, 1, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (372, 40, 438, CAST(N'2017-06-19T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), NULL, 2, 1, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (373, 77, 493, CAST(N'2016-03-08T00:00:00.000' AS DateTime), CAST(N'2016-03-14T00:00:00.000' AS DateTime), NULL, 3, 1, 22)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (374, 60, 225, CAST(N'2015-07-12T00:00:00.000' AS DateTime), CAST(N'2015-07-17T00:00:00.000' AS DateTime), NULL, 1, 1, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (375, 70, 205, CAST(N'2018-06-08T00:00:00.000' AS DateTime), CAST(N'2018-06-08T00:00:00.000' AS DateTime), CAST(N'2018-06-17T00:00:00.000' AS DateTime), 4, 2, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (376, 40, 535, CAST(N'2017-09-21T00:00:00.000' AS DateTime), CAST(N'2017-09-26T00:00:00.000' AS DateTime), NULL, 4, 3, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (377, 99, 59, CAST(N'2018-05-07T00:00:00.000' AS DateTime), CAST(N'2018-05-07T00:00:00.000' AS DateTime), NULL, 2, 4, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (378, 22, 47, CAST(N'2016-09-22T00:00:00.000' AS DateTime), CAST(N'2016-09-22T00:00:00.000' AS DateTime), NULL, 4, 5, 3)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (379, 70, 512, CAST(N'2016-12-28T00:00:00.000' AS DateTime), CAST(N'2016-12-31T00:00:00.000' AS DateTime), NULL, 2, 6, 10)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (380, 40, 374, CAST(N'2018-02-21T00:00:00.000' AS DateTime), CAST(N'2018-02-23T00:00:00.000' AS DateTime), NULL, 2, 7, 15)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (381, 47, 304, CAST(N'2017-12-13T00:00:00.000' AS DateTime), CAST(N'2017-12-20T00:00:00.000' AS DateTime), NULL, 4, 8, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (382, 83, 76, CAST(N'2016-11-26T00:00:00.000' AS DateTime), CAST(N'2016-11-28T00:00:00.000' AS DateTime), NULL, 4, 9, 13)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (383, 36, 352, CAST(N'2015-12-20T00:00:00.000' AS DateTime), CAST(N'2015-12-22T00:00:00.000' AS DateTime), CAST(N'2015-12-28T00:00:00.000' AS DateTime), 3, 10, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (384, 63, 192, CAST(N'2018-05-05T00:00:00.000' AS DateTime), CAST(N'2018-05-06T00:00:00.000' AS DateTime), NULL, 5, 11, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (385, 67, 160, CAST(N'2016-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-12T00:00:00.000' AS DateTime), NULL, 3, 12, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (386, 30, 37, CAST(N'2018-04-11T00:00:00.000' AS DateTime), CAST(N'2018-04-19T00:00:00.000' AS DateTime), NULL, 5, 13, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (387, 62, 537, CAST(N'2015-07-26T00:00:00.000' AS DateTime), CAST(N'2015-08-02T00:00:00.000' AS DateTime), CAST(N'2015-08-14T00:00:00.000' AS DateTime), 5, 14, 7)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (388, 65, 225, CAST(N'2018-02-24T00:00:00.000' AS DateTime), CAST(N'2018-02-25T00:00:00.000' AS DateTime), CAST(N'2018-03-02T00:00:00.000' AS DateTime), 1, 15, 9)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (389, 30, 303, CAST(N'2018-03-29T00:00:00.000' AS DateTime), CAST(N'2018-03-30T00:00:00.000' AS DateTime), NULL, 4, 16, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (390, 59, 578, CAST(N'2018-05-09T00:00:00.000' AS DateTime), CAST(N'2018-05-14T00:00:00.000' AS DateTime), NULL, 1, 17, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (391, 78, 171, CAST(N'2016-11-29T00:00:00.000' AS DateTime), CAST(N'2016-12-06T00:00:00.000' AS DateTime), NULL, 2, 18, 14)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (392, 27, 216, CAST(N'2015-09-30T00:00:00.000' AS DateTime), CAST(N'2015-09-30T00:00:00.000' AS DateTime), NULL, 4, 19, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (393, 20, 536, CAST(N'2018-04-17T00:00:00.000' AS DateTime), CAST(N'2018-04-23T00:00:00.000' AS DateTime), NULL, 4, 20, 4)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (394, 41, 366, CAST(N'2015-04-01T00:00:00.000' AS DateTime), CAST(N'2015-04-02T00:00:00.000' AS DateTime), NULL, 3, 21, 20)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (395, 97, 144, CAST(N'2017-10-19T00:00:00.000' AS DateTime), CAST(N'2017-10-21T00:00:00.000' AS DateTime), CAST(N'2017-10-22T00:00:00.000' AS DateTime), 2, 22, 8)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (396, 36, 113, CAST(N'2016-04-21T00:00:00.000' AS DateTime), CAST(N'2016-04-27T00:00:00.000' AS DateTime), NULL, 4, 23, 17)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (397, 53, 548, CAST(N'2017-01-24T00:00:00.000' AS DateTime), CAST(N'2017-01-25T00:00:00.000' AS DateTime), NULL, 3, 24, 2)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (398, 52, 550, CAST(N'2016-02-26T00:00:00.000' AS DateTime), CAST(N'2016-02-26T00:00:00.000' AS DateTime), NULL, 2, 25, 5)
INSERT [dbo].[Zamowienia] ([ID], [UslugaID], [OtwartePrzez], [DataUtworzenia], [DataRozpoczecia], [DataZakonczenia], [StatusID], [Ilosc], [GrupaRoboczaID]) VALUES (399, 83, 69, CAST(N'2016-05-06T00:00:00.000' AS DateTime), CAST(N'2016-05-10T00:00:00.000' AS DateTime), NULL, 1, 26, 19)
GO
SET IDENTITY_INSERT [dbo].[Zamowienia] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__FunkcjeU__602223FFC7B34154]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[FunkcjeUzytkownikow] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__GrupyRob__602223FF0D64C714]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[GrupyRobocze] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Katalogi__602223FF7C325885]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[Katalogi] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Kategori__602223FFFEEBA2B1]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[Kategorie] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Statusy__602223FFE61500E9]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[Statusy] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Uslugi__602223FFF8978E6F]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[Uslugi] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Zadania__602223FFBC1FA3B4]    Script Date: 23-Jun-18 11:11:14 ******/
ALTER TABLE [dbo].[Zadania] ADD UNIQUE NONCLUSTERED 
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GrupyRobocze]  WITH CHECK ADD FOREIGN KEY([FirmaID])
REFERENCES [dbo].[Firmy] ([ID])
GO
ALTER TABLE [dbo].[GrupyRobocze]  WITH CHECK ADD FOREIGN KEY([WlascicielGrupyID])
REFERENCES [dbo].[Uzytkownicy] ([ID])
GO
ALTER TABLE [dbo].[Kategorie]  WITH CHECK ADD FOREIGN KEY([KatalogID])
REFERENCES [dbo].[Katalogi] ([ID])
GO
ALTER TABLE [dbo].[Uslugi]  WITH CHECK ADD FOREIGN KEY([GrupaRoboczaID])
REFERENCES [dbo].[GrupyRobocze] ([ID])
GO
ALTER TABLE [dbo].[Uslugi]  WITH CHECK ADD FOREIGN KEY([KatalogID])
REFERENCES [dbo].[Katalogi] ([ID])
GO
ALTER TABLE [dbo].[Uslugi]  WITH CHECK ADD FOREIGN KEY([Kategoria])
REFERENCES [dbo].[Kategorie] ([ID])
GO
ALTER TABLE [dbo].[Uslugi]  WITH CHECK ADD FOREIGN KEY([WlascicielUslugiID])
REFERENCES [dbo].[Uzytkownicy] ([ID])
GO
ALTER TABLE [dbo].[Uzytkownicy]  WITH CHECK ADD FOREIGN KEY([FirmaID])
REFERENCES [dbo].[Firmy] ([ID])
GO
ALTER TABLE [dbo].[Uzytkownicy]  WITH CHECK ADD FOREIGN KEY([Rola])
REFERENCES [dbo].[FunkcjeUzytkownikow] ([ID])
GO
ALTER TABLE [dbo].[Zadania]  WITH CHECK ADD FOREIGN KEY([GrupaRoboczaID])
REFERENCES [dbo].[GrupyRobocze] ([ID])
GO
ALTER TABLE [dbo].[Zadania]  WITH CHECK ADD FOREIGN KEY([UslugaID])
REFERENCES [dbo].[Uslugi] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([GrupaRoboczaID])
REFERENCES [dbo].[GrupyRobocze] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([OtwartePrzez])
REFERENCES [dbo].[Uzytkownicy] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [dbo].[Statusy] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD FOREIGN KEY([UslugaID])
REFERENCES [dbo].[Uslugi] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [CHK_Daty] CHECK  (([DataRozpoczecia]>=[DataUtworzenia] AND [DataZakonczenia]>=[DataRozpoczecia]))
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [CHK_Daty]
GO
/****** Object:  StoredProcedure [dbo].[DodajUsluge]    Script Date: 23-Jun-18 11:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedura na dodanie nowej uslugi do bazy



CREATE PROCEDURE [dbo].[DodajUsluge]
	@Nazwa nvarchar (250),
	@Kategoria int,
	@Opis nvarchar (1000),
	@WlascicielUslugiID int,
	@KatalogID int,
	@Cena decimal,
	@GrupaRoboczaID int
AS
BEGIN
	INSERT INTO Uslugi
	VALUES (@Nazwa, @Kategoria, @Opis, @WlascicielUslugiID, @KatalogID, @Cena, @GrupaRoboczaID)
END


GO
/****** Object:  StoredProcedure [dbo].[DodajUzytkownika]    Script Date: 23-Jun-18 11:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- utworzenie procedur

--Procedura na dodanie uzytkownika do bazy




CREATE PROCEDURE [dbo].[DodajUzytkownika]
	@Imie nvarchar (50),
	@Nazwisko nvarchar (100),
	@PESEL nvarchar (20),
	@email nvarchar (250),
	@Telefon nvarchar (20),
	@FirmaID int,
	@Rola int
AS
BEGIN
	INSERT INTO Uzytkownicy
	VALUES (@Imie, @Nazwisko, @PESEL, @email, @Telefon, @FirmaID, @Rola)
END
GO
/****** Object:  StoredProcedure [dbo].[ListaPracownikow]    Script Date: 23-Jun-18 11:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedura na wygenerowanie listy wszystkich pracowników (każdego typu)
CREATE PROCEDURE [dbo].[ListaPracownikow]
@Imie nvarchar (50),
@Nazwisko nvarchar (100),
@Liczba int OUTPUT
AS
BEGIN
	SET NOCOUNT ON 

	SET @Liczba = (SELECT COUNT(*)
					FROM Uzytkownicy
					WHERE Imie LIKE @Imie 
						AND Nazwisko LIKE @Nazwisko)
	SELECT *
	FROM Uzytkownicy
	WHERE Rola <> 4 AND Imie LIKE @Imie 
	AND Nazwisko LIKE @Nazwisko
    
END
GO
/****** Object:  StoredProcedure [dbo].[StworzZamowienie]    Script Date: 23-Jun-18 11:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedura do tworzenia nowego zamówienia
CREATE PROCEDURE [dbo].[StworzZamowienie]
	@UslugaID int,
	@OtwartePrzez int,
	@DataUtworzenia datetime = NULL,
	@DataRozpoczecia datetime = NULL,
	@DataZakonczenia datetime = NULL,
	@StatusID int,
	@Ilosc int,
	@GrupaRoboczaID int

AS
BEGIN
SET @DataUtworzenia = GETDATE()
	INSERT INTO Zamowienia
	VALUES (@UslugaID, @OtwartePrzez, @DataUtworzenia,@DataRozpoczecia,@DataZakonczenia, @StatusID, @Ilosc, @GrupaRoboczaID)
END
GO
USE [master]
GO
ALTER DATABASE [KATALOGUSLUGIT] SET  READ_WRITE 
GO
