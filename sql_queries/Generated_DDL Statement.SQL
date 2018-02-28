/*
Created: 10/14/2016
Modified: 10/14/2016
Model: RE Microsoft SQL Server 2016
Database: MS SQL Server 2016
*/


-- Create schemas section -------------------------------------------------


-- Table dbo.Customer
USE model;

CREATE TABLE [dbo].[Customer]
(
 [CustomerID] Int IDENTITY(1,1) NOT NULL,
 [FirstName] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [LastName] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [BirthDate] Date NULL,
 [Gender] Nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [EmailAddress] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [Phone] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [CustomerType] Nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [Primary]
go

-- Add keys for table dbo.Customer

ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer_CustomerKey] PRIMARY KEY ([CustomerID])
go

-- Table dbo.Product

CREATE TABLE [dbo].[Product]
(
 [ProductID] Int IDENTITY(1,1) NOT NULL,
 [ProductName] Nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ProductDescription] Nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ProductSubcategoryID] Int NULL,
 [BrandName] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [UnitCost] Money NULL,
 [UnitPrice] Money NULL,
 [WishListID] Int NOT NULL
)
ON [Primary]
WITH (DATA_COMPRESSION = PAGE)
go

-- Add keys for table dbo.Product

ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK_Product_ProductID] PRIMARY KEY ([ProductID])
 WITH (DATA_COMPRESSION = PAGE)
 ON [Primary]
go

ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_WishListID] UNIQUE ([WishListID])
go

-- Table dbo.ProductCategory

CREATE TABLE [dbo].[ProductCategory]
(
 [ProductCategoryID] Int IDENTITY(1,1) NOT NULL,
 [ProductCategoryName] Nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [ProductCategoryDescription] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [Primary]
go

-- Add keys for table dbo.ProductCategory

ALTER TABLE [dbo].[ProductCategory] ADD CONSTRAINT [PK_ProductCategory_ProductCategoryKey] PRIMARY KEY ([ProductCategoryID])
go

-- Table dbo.ProductSubcategory

CREATE TABLE [dbo].[ProductSubcategory]
(
 [ProductSubcategoryID] Int IDENTITY(1,1) NOT NULL,
 [ProductSubcategoryName] Nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [ProductSubcategoryDescription] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [ProductCategoryID] Int NULL
)
ON [Primary]
go

-- Add keys for table dbo.ProductSubcategory

ALTER TABLE [dbo].[ProductSubcategory] ADD CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryKey] PRIMARY KEY ([ProductSubcategoryID])
go

-- Table dbo.Promotion

CREATE TABLE [dbo].[Promotion]
(
 [PromotionID] Int IDENTITY(1,1) NOT NULL,
 [PromotionName] Nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 [DiscountAmount] Money NULL
)
ON [Primary]
go

-- Add keys for table dbo.Promotion

ALTER TABLE [dbo].[Promotion] ADD CONSTRAINT [PK_Promotion_PromotionKey] PRIMARY KEY ([PromotionID])
go

-- Table dbo.OnlineSales

CREATE TABLE [dbo].[OnlineSales]
(
 [SalesID] Int IDENTITY(1,1) NOT NULL,
 [ProductID] Int NOT NULL,
 [PromotionID] Int NOT NULL,
 [CustomerID] Int NOT NULL,
 [SalesOrderNumber] Nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 [SalesQuantity] Int NOT NULL,
 [SalesAmount] Money NOT NULL,
 [DiscountAmount] Money NULL,
 [TotalCost] Money NOT NULL,
 [UnitCost] Money NULL,
 [UnitPrice] Money NULL,
 [VendorID] Int NOT NULL
)
ON [Primary]
WITH (DATA_COMPRESSION = PAGE)
go

-- Add keys for table dbo.OnlineSales

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [PK_OnlineSales_SalesID] PRIMARY KEY ([SalesID])
 WITH (DATA_COMPRESSION = PAGE)
go

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [OnlineSales_VendorID] UNIQUE ([VendorID])
go

-- Table dbo.ProductVendor

CREATE TABLE [dbo].[ProductVendor]
(
 [AccountNumber] Int NOT NULL,
 [VendorName] Char(50) NULL,
 [Rating] Nchar(10) NULL,
 [VendorID] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table dbo.ProductVendor

ALTER TABLE [dbo].[ProductVendor] ADD CONSTRAINT [PK_ProductVendor_VendorID] PRIMARY KEY ([VendorID])
go

ALTER TABLE [dbo].[ProductVendor] ADD CONSTRAINT [ProductVendor_AccountNumber] UNIQUE ([AccountNumber])
go

ALTER TABLE [dbo].[ProductVendor] ADD CONSTRAINT [ProductVendor_VendorName] UNIQUE ([VendorID])
go

-- Table dbo.WishListProducts

CREATE TABLE [dbo].[WishListProducts]
(
 [ProductName] Nvarchar(500) NOT NULL,
 [WishListID] Int NOT NULL,
 [CustomerID] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table dbo.WishListProducts

ALTER TABLE [dbo].[WishListProducts] ADD CONSTRAINT [PK_WishListProducts_WishListID] PRIMARY KEY ([WishListID])
go

ALTER TABLE [dbo].[WishListProducts] ADD CONSTRAINT [ProductName] UNIQUE ([WishListID])
go

-- Create relationships section ------------------------------------------------- 

ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Product_ProductSubcategory] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [dbo].[ProductSubcategory] ([ProductSubcategoryID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[ProductSubcategory] ADD CONSTRAINT [FK_ProductSubcategory_ProductCategory] FOREIGN KEY ([ProductCategoryID]) REFERENCES [dbo].[ProductCategory] ([ProductCategoryID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [FK_OnlineSales_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [FK_OnlineSales_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [FK_OnlineSales_Promotion] FOREIGN KEY ([PromotionID]) REFERENCES [dbo].[Promotion] ([PromotionID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK_Product_WishList] FOREIGN KEY ([WishListID]) REFERENCES [dbo].[WishListProducts] ([WishListID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[OnlineSales] ADD CONSTRAINT [FK_OnlineSales_ProductVendor] FOREIGN KEY ([VendorID]) REFERENCES [dbo].[ProductVendor] ([VendorID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [dbo].[WishListProducts] ADD CONSTRAINT [FK_WishListProducts_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

