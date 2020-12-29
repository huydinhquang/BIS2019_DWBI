CREATE DATABASE HBPencil
GO
USE HBPencil
GO
CREATE TABLE HBPStatus
(
    Id SMALLINT PRIMARY KEY NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPOrderStatus
(
    Id SMALLINT PRIMARY KEY NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPOrderStatusDetail
(
    Id INT PRIMARY KEY NOT NULL,
	OrderStatusId SMALLINT NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPFoodBeverageCategory
(
    Id SMALLINT PRIMARY KEY NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPFoodBeverage
(
    Id INT PRIMARY KEY NOT NULL,
    FoodBeverageCategoryId SMALLINT NOT NULL,
	Name NVARCHAR(255) NOT NULL,
	Description NVARCHAR(1000) NULL
);
GO
CREATE TABLE HBPGender
(
    Id SMALLINT PRIMARY KEY NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPCancellationReportType
(
    Id SMALLINT PRIMARY KEY NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPCancellationReportCategory
(
    Id INT PRIMARY KEY NOT NULL,
    CancellationReportTypeId SMALLINT NOT NULL,
	Name NVARCHAR(255) NOT NULL,
	Code NVARCHAR(50) NULL
);
GO
CREATE TABLE HBPCity
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
	Code NVARCHAR(255) NULL
);
GO
CREATE TABLE HBPDistrict
(
    Id INT IDENTITY PRIMARY KEY,
	CityId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPWard
(
    Id INT IDENTITY,
	DistrictId INT NOT NULL,
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE HBPSellerBrand
(
    Id INT IDENTITY PRIMARY KEY,
	FoodBeverageCategoryId SMALLINT NOT NULL,	
    Name NVARCHAR(255) NOT NULL,
	Description NVARCHAR(4000) NULL,
    StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPSellerBranch
(
    Id INT IDENTITY PRIMARY KEY,
	SellerBrandId INT NOT NULL,
	Name NVARCHAR(255) NOT NULL,
	Description NVARCHAR(500) NULL,
	PhoneNumber NVARCHAR(50) NULL,
	OpeningHour INT NOT NULL,
	OpeningTime INT NOT NULL,
	ClosingHour INT NOT NULL,
	ClosingTime INT NOT NULL,
	Address NVARCHAR(1000) NOT NULL,
	AddressDescription NVARCHAR(500) NULL,
	WardId INT NOT NULL,
	DistrictId INT NOT NULL,
	CityId INT NOT NULL,
    StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPSellerMenu
(
    Id BIGINT IDENTITY PRIMARY KEY,
	SellerBranchId INT NOT NULL,
	FoodBeverageId INT NOT NULL,
	Description NVARCHAR(1000) NULL,
	StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPShipper
(
    Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	GenderId SMALLINT NOT NULL,
	SSN NVARCHAR(15) NOT NULL,
	DriveLicence NVARCHAR(50) NOT NULL,
	Birthday DATETIME NOT NULL,
	Email NVARCHAR(100) NULL,
	PhoneNumber NVARCHAR(50) NOT NULL,
	PlateNumber NVARCHAR(10) NOT NULL,
	Address NVARCHAR(1000) NOT NULL,
	Description NVARCHAR(500) NULL,
	WardId INT NOT NULL,
	DistrictId INT NOT NULL,
	CityId INT NOT NULL,
    StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPBuyer
(
    Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	GenderId SMALLINT NOT NULL,
	Birthday DATETIME NOT NULL,
	Email NVARCHAR(100) NOT NULL,
	PhoneNumber NVARCHAR(50) NOT NULL,
    StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPBuyerAddress
(
    Id INT IDENTITY PRIMARY KEY,
	BuyerId INT NOT NULL,
	Address NVARCHAR(1000) NOT NULL,
	Description NVARCHAR(500) NULL,
	WardId INT NOT NULL,
	DistrictId INT NOT NULL,
	CityId INT NOT NULL,
    StatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPOrder
(
    Id BIGINT IDENTITY PRIMARY KEY,
	SellerBranchId INT NOT NULL,
	BuyerId INT NOT NULL,
	ShipperId INT NOT NULL,
	OrderTime DATETIME NOT NULL,
	ShippingFee DECIMAL(19,2) NOT NULL,
	OrderStatusId SMALLINT NOT NULL
);
GO
CREATE TABLE HBPOrderDetail
(
    Id BIGINT IDENTITY PRIMARY KEY,
	OrderId BIGINT NOT NULL,
	SellerMenuId BIGINT NOT NULL,
	Quantity INT NOT NULL,
	Price DECIMAL(19,2) NOT NULL
);
GO
CREATE TABLE HBPOrderTransaction
(
    Id BIGINT IDENTITY PRIMARY KEY,
	OrderId BIGINT NOT NULL,
	OrderStatusDetailId INT NOT NULL,
	Modified DATETIME NOT NULL
);
GO
CREATE TABLE HBPShipperAddressReceivedOrder
(
    Id BIGINT IDENTITY PRIMARY KEY,
	ShipperId INT NOT NULL,
	OrderId BIGINT NOT NULL,
	Address NVARCHAR(1000) NOT NULL,
	Description NVARCHAR(500) NULL,
	WardId INT NOT NULL,
	DistrictId INT NOT NULL,
	CityId INT NOT NULL
);
GO
CREATE TABLE HBPCancellationReport
(
    Id INT IDENTITY PRIMARY KEY,
	ShipperAddressReceivedOrderId BIGINT NOT NULL,
	OrderId BIGINT NOT NULL,
	CancellationReportTime DATETIME NOT NULL
);
GO
CREATE TABLE HBPCancellationReportDetail
(
    Id INT IDENTITY PRIMARY KEY,
	CancellationReportId INT NOT NULL,
	CancellationReportCategoryId INT NOT NULL,
	Description NVARCHAR(1000) NULL
);
GO

--ALTER TABLE HBPSellerBranch DROP CONSTRAINT FK_SellerBranch_Ward;
--ALTER TABLE HBPShipper DROP CONSTRAINT FK_Shipper_Ward;
--ALTER TABLE HBPBuyerAddress DROP CONSTRAINT FK_BuyerAddress_Ward;
--ALTER TABLE HBPShipperAddressReceivedOrder DROP CONSTRAINT FK_ShipperAddressReceivedOrder_Ward;

--ALTER TABLE HBPSellerBranch DROP CONSTRAINT FK_SellerBranch_District;
--ALTER TABLE HBPShipper DROP CONSTRAINT FK_Shipper_District;
--ALTER TABLE HBPBuyerAddress DROP CONSTRAINT FK_BuyerAddress_District;
--ALTER TABLE HBPShipperAddressReceivedOrder DROP CONSTRAINT FK_ShipperAddressReceivedOrder_District;

--ALTER TABLE HBPShipperAddressReceivedOrder DROP CONSTRAINT FK_ShipperAddressReceivedOrder_Order;

--ALTER TABLE HBPOrder DROP CONSTRAINT PK_HBPOrder;


ALTER TABLE HBPWard ADD CONSTRAINT PK_HBPWard PRIMARY KEY (Id, DistrictId);
GO
--ALTER TABLE HBPOrder ADD CONSTRAINT PK_HBPOrder PRIMARY KEY (Id);
--GO

ALTER TABLE HBPSellerBrand ADD CONSTRAINT FK_SellerBrand_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO
ALTER TABLE HBPSellerBranch ADD CONSTRAINT FK_SellerBranch_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO
ALTER TABLE HBPSellerMenu ADD CONSTRAINT FK_SellerMenu_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO
ALTER TABLE HBPShipper ADD CONSTRAINT FK_Shipper_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO
ALTER TABLE HBPBuyer ADD CONSTRAINT FK_Buyer_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO
ALTER TABLE HBPBuyerAddress ADD CONSTRAINT FK_BuyerAddress_Status FOREIGN KEY (StatusId) REFERENCES HBPStatus(Id);
GO


ALTER TABLE HBPDistrict ADD CONSTRAINT FK_District_City FOREIGN KEY (CityId) REFERENCES HBPCity(Id);
GO
ALTER TABLE HBPWard ADD CONSTRAINT FK_Ward_District FOREIGN KEY (DistrictId) REFERENCES HBPDistrict(Id);
GO
ALTER TABLE HBPFoodBeverage ADD CONSTRAINT FK_FoodBeverage_FBCategory FOREIGN KEY (FoodBeverageCategoryId) REFERENCES HBPFoodBeverageCategory(Id);
GO
ALTER TABLE HBPCancellationReportCategory ADD CONSTRAINT FK_CancellationReportCategory_CancellationReportType FOREIGN KEY (CancellationReportTypeId) REFERENCES HBPCancellationReportType(Id);
GO
ALTER TABLE HBPSellerBrand ADD CONSTRAINT FK_SellerBrand_FBCategory FOREIGN KEY (FoodBeverageCategoryId) REFERENCES HBPFoodBeverageCategory(Id);
GO
ALTER TABLE HBPSellerBranch ADD CONSTRAINT FK_SellerBranch_SellerBrand FOREIGN KEY (SellerBrandId) REFERENCES HBPSellerBrand(Id);
GO
ALTER TABLE HBPSellerBranch ADD CONSTRAINT FK_SellerBranch_Ward_District FOREIGN KEY (WardId, DistrictId) REFERENCES HBPWard(Id, DistrictId);
GO
ALTER TABLE HBPSellerBranch ADD CONSTRAINT FK_SellerBranch_City FOREIGN KEY (CityId) REFERENCES HBPCity(Id);
GO
ALTER TABLE HBPSellerMenu ADD CONSTRAINT FK_SellerMenu_SellerBranch FOREIGN KEY (SellerBranchId) REFERENCES HBPSellerBranch(Id);
GO
ALTER TABLE HBPSellerMenu ADD CONSTRAINT FK_SellerMenu_FoodBeverage FOREIGN KEY (FoodBeverageId) REFERENCES HBPFoodBeverage(Id);
GO
ALTER TABLE HBPShipper ADD CONSTRAINT FK_Shipper_Gender FOREIGN KEY (GenderId) REFERENCES HBPGender(Id);
GO
ALTER TABLE HBPShipper ADD CONSTRAINT FK_Shipper_Ward_District FOREIGN KEY (WardId, DistrictId) REFERENCES HBPWard(Id, DistrictId);
GO
ALTER TABLE HBPShipper ADD CONSTRAINT FK_Shipper_City FOREIGN KEY (CityId) REFERENCES HBPCity(Id);
GO
ALTER TABLE HBPBuyer ADD CONSTRAINT FK_Buyer_Gender FOREIGN KEY (GenderId) REFERENCES HBPGender(Id);
GO
ALTER TABLE HBPBuyerAddress ADD CONSTRAINT FK_BuyerAddress_Buyer FOREIGN KEY (BuyerId) REFERENCES HBPBuyer(Id);
GO
ALTER TABLE HBPBuyerAddress ADD CONSTRAINT FK_BuyerAddress_Ward_District FOREIGN KEY (WardId, DistrictId) REFERENCES HBPWard(Id, DistrictId);
GO
ALTER TABLE HBPBuyerAddress ADD CONSTRAINT FK_BuyerAddress_City FOREIGN KEY (CityId) REFERENCES HBPCity(Id);
GO
ALTER TABLE HBPOrder ADD CONSTRAINT FK_Order_OrderStatus FOREIGN KEY (OrderStatusId) REFERENCES HBPOrderStatus(Id);
GO
ALTER TABLE HBPOrder ADD CONSTRAINT FK_Order_SellerBranch FOREIGN KEY (SellerBranchId) REFERENCES HBPSellerBranch(Id);
GO
ALTER TABLE HBPOrder ADD CONSTRAINT FK_Order_Buyer FOREIGN KEY (BuyerId) REFERENCES HBPBuyer(Id);
GO
ALTER TABLE HBPOrder ADD CONSTRAINT FK_Order_Shipper FOREIGN KEY (ShipperId) REFERENCES HBPShipper(Id);
GO
ALTER TABLE HBPOrderDetail ADD CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderId) REFERENCES HBPOrder(Id);
GO
ALTER TABLE HBPOrderDetail ADD CONSTRAINT FK_OrderDetail_SellerMenu FOREIGN KEY (SellerMenuId) REFERENCES HBPSellerMenu(Id);
GO
ALTER TABLE HBPOrderStatusDetail ADD CONSTRAINT FK_OrderStatusDetail_Order FOREIGN KEY (OrderStatusId) REFERENCES HBPOrderStatus(Id);
GO
ALTER TABLE HBPOrderTransaction ADD CONSTRAINT FK_OrderTransaction_Order FOREIGN KEY (OrderId) REFERENCES HBPOrder(Id);
GO
ALTER TABLE HBPOrderTransaction ADD CONSTRAINT FK_OrderTransaction_OrderStatusDetail FOREIGN KEY (OrderStatusDetailId) REFERENCES HBPOrderStatusDetail(Id);
GO
ALTER TABLE HBPShipperAddressReceivedOrder ADD CONSTRAINT FK_ShipperAddressReceivedOrder_Order_Shipper FOREIGN KEY (OrderId) REFERENCES HBPOrder(Id);
GO
ALTER TABLE HBPShipperAddressReceivedOrder ADD CONSTRAINT FK_ShipperAddressReceivedOrder_Order FOREIGN KEY (ShipperId) REFERENCES HBPShipper(Id);
GO
ALTER TABLE HBPShipperAddressReceivedOrder ADD CONSTRAINT FK_ShipperAddressReceivedOrder_Ward_District FOREIGN KEY (WardId, DistrictId) REFERENCES HBPWard(Id, DistrictId);
GO
ALTER TABLE HBPShipperAddressReceivedOrder ADD CONSTRAINT FK_ShipperAddressReceivedOrder_City FOREIGN KEY (CityId) REFERENCES HBPCity(Id);
GO
ALTER TABLE HBPCancellationReport ADD CONSTRAINT FK_CancellationReport_ShipperAddressReceivedOrder FOREIGN KEY (ShipperAddressReceivedOrderId) REFERENCES HBPShipperAddressReceivedOrder(Id);
GO
ALTER TABLE HBPCancellationReport ADD CONSTRAINT FK_CancellationReport_Order FOREIGN KEY (OrderId) REFERENCES HBPOrder(Id);
GO
ALTER TABLE HBPCancellationReportDetail ADD CONSTRAINT FK_CancellationReportDetail_CancellationReport FOREIGN KEY (CancellationReportId) REFERENCES HBPCancellationReport(Id);
GO
ALTER TABLE HBPCancellationReportDetail ADD CONSTRAINT FK_CancellationReportDetail_CancellationReportCategory FOREIGN KEY (CancellationReportCategoryId) REFERENCES HBPCancellationReportCategory(Id);
GO

ALTER TABLE HBPSellerMenu ADD CONSTRAINT UC_SellerBranch_FoodBeverage UNIQUE (SellerBranchId, FoodBeverageId)
GO

ALTER TABLE HBPOrderDetail ADD CONSTRAINT UC_Order_SellerMenu UNIQUE (OrderId, SellerMenuId)
GO

INSERT INTO dbo.HBPStatus (Id, Name) VALUES(0, N'Inactive');
GO
INSERT INTO dbo.HBPStatus (Id, Name) VALUES(1, N'Active');
GO

INSERT INTO dbo.HBPOrderStatus (Id, Name) VALUES(0, N'Pending');
GO
INSERT INTO dbo.HBPOrderStatus (Id, Name) VALUES(1, N'In Progress');
GO
INSERT INTO dbo.HBPOrderStatus (Id, Name) VALUES(2, N'Completed');
GO
INSERT INTO dbo.HBPOrderStatus (Id, Name) VALUES(3, N'Cancelled');
GO

INSERT INTO dbo.HBPCity (Name, Code) VALUES (N'Ho Chi Minh City', N'HCMC');
GO

INSERT INTO dbo.HBPFoodBeverageCategory (Id, Name) VALUES (1, N'Food');
GO
INSERT INTO dbo.HBPFoodBeverageCategory (Id, Name) VALUES (2, N'Beverage');
GO
INSERT INTO dbo.HBPFoodBeverageCategory (Id, Name) VALUES (3, N'Food & Beverage');
GO

INSERT INTO dbo.HBPGender( Id, Name) VALUES ( 0, N'Male' )
INSERT INTO dbo.HBPGender( Id, Name) VALUES ( 1, N'Female' )
INSERT INTO dbo.HBPGender( Id, Name) VALUES ( 2, N'Other' )

INSERT [dbo].[HBPCity] ([Id], [Name], [Code]) VALUES (1, N'Ho Chi Minh City', N'HCMC')

INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (1, 1, N'Quận 1')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (2, 1, N'Quận 2')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (3, 1, N'Quận 3')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (4, 1, N'Quận 4')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (5, 1, N'Quận 5')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (6, 1, N'Quận 6')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (7, 1, N'Quận 7')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (8, 1, N'Quận 8')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (9, 1, N'Quận 9')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (10, 1, N'Quận 10')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (11, 1, N'Quận 11')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (12, 1, N'Quận 12')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (13, 1, N'Quận Bình Tân')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (14, 1, N'Quận Bình Thạnh')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (15, 1, N'Quận Gò Vấp')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (16, 1, N'Quận Phú Nhuận')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (17, 1, N'Quận Tân Bình')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (18, 1, N'Quận Tân Phú')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (19, 1, N'Quận Thủ Đức')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (20, 1, N'Huyện Bình Chánh')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (21, 1, N'Huyện Cần Giờ')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (22, 1, N'Huyện Củ Chi')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (23, 1, N'Huyện Hóc Môn')
INSERT [dbo].[HBPDistrict] ([Id], [CityId], [Name]) VALUES (24, 1, N'Huyện Nhà Bè')

INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (1, 1, N'Phường Bến Nghé')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (2, 1, N'Phường Bến Thành')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (3, 1, N'Phường Cầu Kho')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (4, 1, N'Phường Cầu Ông Lãnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (5, 1, N'Phường Cô Giang')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (6, 1, N'Phường Đa Kao')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (7, 1, N'Phường Nguyễn Cư Trinh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (8, 1, N'Phường Nguyễn Thái Bình')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (9, 1, N'Phường Phạm Ngũ Lão')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (10, 1, N'Phường Tân Định')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (11, 2, N'Phường An Khánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (12, 2, N'Phường An Lợi Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (13, 2, N'Phường An Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (14, 2, N'Phường Bình An')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (15, 2, N'Phường Bình Khánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (16, 2, N'Phường Bình Trưng Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (17, 2, N'Phường Bình Trưng Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (18, 2, N'Phường Cát Lái')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (19, 2, N'Phường Thạnh Mỹ Lợi')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (20, 2, N'Phường Thảo Điền')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (21, 2, N'Phường Thủ Thiêm')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (22, 3, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (23, 3, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (24, 3, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (25, 3, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (26, 3, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (27, 3, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (28, 3, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (29, 3, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (30, 3, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (31, 3, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (32, 3, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (33, 3, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (34, 3, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (35, 3, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (36, 4, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (37, 4, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (38, 4, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (39, 4, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (40, 4, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (41, 4, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (42, 4, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (43, 4, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (44, 4, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (45, 4, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (46, 4, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (47, 4, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (48, 4, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (49, 4, N'Phường 16')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (50, 4, N'Phường 18')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (51, 5, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (52, 5, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (53, 5, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (54, 5, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (55, 5, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (56, 5, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (57, 5, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (58, 5, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (59, 5, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (60, 5, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (61, 5, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (62, 5, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (63, 5, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (64, 5, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (65, 5, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (66, 6, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (67, 6, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (68, 6, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (69, 6, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (70, 6, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (71, 6, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (72, 6, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (73, 6, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (74, 6, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (75, 6, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (76, 6, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (77, 6, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (78, 6, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (79, 6, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (80, 7, N'Phường Bình Thuận')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (81, 7, N'Phường Phú Mỹ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (82, 7, N'Phường Phú Thuận')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (83, 7, N'Phường Tân Hưng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (84, 7, N'Phường Tân Kiểng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (85, 7, N'Phường Tân Phong')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (86, 7, N'Phường Tân Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (87, 7, N'Phường Tân Quy')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (88, 7, N'Phường Tân Thuận Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (89, 7, N'Phường Tân Thuận Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (90, 8, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (91, 8, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (92, 8, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (93, 8, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (94, 8, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (95, 8, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (96, 8, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (97, 8, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (98, 8, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (99, 8, N'Phường 10')
GO
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (100, 8, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (101, 8, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (102, 8, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (103, 8, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (104, 8, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (105, 8, N'Phường 16')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (106, 9, N'Phường Hiệp Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (107, 9, N'Phường Long Bình')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (108, 9, N'Phường Long Phước')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (109, 9, N'Phường Long Thạnh Mỹ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (110, 9, N'Phường Long Trường')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (111, 9, N'Phường Phú Hữu')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (112, 9, N'Phường Phước Bình')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (113, 9, N'Phường Phước Long A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (114, 9, N'Phường Phước Long B')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (115, 9, N'Phường Tân Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (116, 9, N'Phường Tăng Nhơn Phú A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (117, 9, N'Phường Tăng Nhơn Phú B')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (118, 9, N'Phường Trường Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (119, 10, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (120, 10, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (121, 10, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (122, 10, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (123, 10, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (124, 10, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (125, 10, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (126, 10, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (127, 10, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (128, 10, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (129, 10, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (130, 10, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (131, 10, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (132, 10, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (133, 10, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (134, 11, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (135, 11, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (136, 11, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (137, 11, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (138, 11, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (139, 11, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (140, 11, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (141, 11, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (142, 11, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (143, 11, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (144, 11, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (145, 11, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (146, 11, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (147, 11, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (148, 11, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (149, 11, N'Phường 16')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (150, 12, N'Phường An Phú Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (151, 12, N'Phường Đông Hưng Thuận')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (152, 12, N'Phường Hiệp Thành')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (153, 12, N'Phường Tân Chánh Hiệp')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (154, 12, N'Phường Tân Hưng Thuận')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (155, 12, N'Phường Tân Thới Hiệp')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (156, 12, N'Phường Tân Thới Nhất')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (157, 12, N'Phường Thạnh Lộc')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (158, 12, N'Phường Thạnh Xuân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (159, 12, N'Phường Thới An')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (160, 12, N'Phường Trung Mỹ Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (161, 13, N'Phường An Lạc')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (162, 13, N'Phường An Lạc A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (163, 13, N'Phường Bình Hưng Hòa')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (164, 13, N'Phường Bình Hưng Hoà A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (165, 13, N'Phường Bình Hưng Hoà B')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (166, 13, N'Phường Bình Trị Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (167, 13, N'Phường Bình Trị Đông A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (168, 13, N'Phường Bình Trị Đông B')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (169, 13, N'Phường Tân Tạo')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (170, 13, N'Phường Tân Tạo A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (171, 14, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (172, 14, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (173, 14, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (174, 14, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (175, 14, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (176, 14, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (177, 14, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (178, 14, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (179, 14, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (180, 14, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (181, 14, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (182, 14, N'Phường 17')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (183, 14, N'Phường 19')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (184, 14, N'Phường 21')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (185, 14, N'Phường 22')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (186, 14, N'Phường 24')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (187, 14, N'Phường 25')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (188, 14, N'Phường 26')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (189, 14, N'Phường 27')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (190, 14, N'Phường 28')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (191, 15, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (192, 15, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (193, 15, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (194, 15, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (195, 15, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (196, 15, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (197, 15, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (198, 15, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (199, 15, N'Phường 10')
GO
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (200, 15, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (201, 15, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (202, 15, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (203, 15, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (204, 15, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (205, 15, N'Phường 16')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (206, 15, N'Phường 17')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (207, 16, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (208, 16, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (209, 16, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (210, 16, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (211, 16, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (212, 16, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (213, 16, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (214, 16, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (215, 16, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (216, 16, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (217, 16, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (218, 16, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (219, 16, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (220, 16, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (221, 16, N'Phường 17')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (222, 17, N'Phường 01')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (223, 17, N'Phường 02')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (224, 17, N'Phường 03')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (225, 17, N'Phường 04')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (226, 17, N'Phường 05')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (227, 17, N'Phường 06')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (228, 17, N'Phường 07')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (229, 17, N'Phường 08')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (230, 17, N'Phường 09')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (231, 17, N'Phường 10')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (232, 17, N'Phường 11')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (233, 17, N'Phường 12')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (234, 17, N'Phường 13')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (235, 17, N'Phường 14')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (236, 17, N'Phường 15')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (237, 18, N'Phường Hiệp Tân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (238, 18, N'Phường Hoà Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (239, 18, N'Phường Phú Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (240, 18, N'Phường Phú Thọ Hoà')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (241, 18, N'Phường Phú Trung')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (242, 18, N'Phường Sơn Kỳ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (243, 18, N'Phường Tân Qúy')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (244, 18, N'Phường Tân Sơn Nhì')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (245, 18, N'Phường Tân Thành')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (246, 18, N'Phường Tân Thới Hoà')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (247, 18, N'Phường Tây Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (248, 19, N'Phường Bình Chiểu')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (249, 19, N'Phường Bình Thọ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (250, 19, N'Phường Hiệp Bình Chánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (251, 19, N'Phường Hiệp Bình Phước')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (252, 19, N'Phường Linh Chiểu')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (253, 19, N'Phường Linh Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (254, 19, N'Phường Linh Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (255, 19, N'Phường Linh Trung')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (256, 19, N'Phường Linh Xuân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (257, 19, N'Phường Tam Bình')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (258, 19, N'Phường Tam Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (259, 19, N'Phường Trường Thọ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (260, 20, N'Thị trấn Tân Túc')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (261, 20, N'Xã An Phú Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (262, 20, N'Xã Bình Chánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (263, 20, N'Xã Bình Hưng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (264, 20, N'Xã Bình Lợi')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (265, 20, N'Xã Đa Phước')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (266, 20, N'Xã Hưng Long')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (267, 20, N'Xã Lê Minh Xuân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (268, 20, N'Xã Phạm Văn Hai')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (269, 20, N'Xã Phong Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (270, 20, N'Xã Quy Đức')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (271, 20, N'Xã Tân Kiên')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (272, 20, N'Xã Tân Nhựt')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (273, 20, N'Xã Tân Quý Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (274, 20, N'Xã Vĩnh Lộc A')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (275, 20, N'Xã Vĩnh Lộc B')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (276, 21, N'Thị trấn Cần Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (277, 21, N'Xã An Thới Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (278, 21, N'Xã Bình Khánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (279, 21, N'Xã Long Hòa')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (280, 21, N'Xã Lý Nhơn')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (281, 21, N'Xã Tam Thôn Hiệp')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (282, 21, N'Xã Thạnh An')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (283, 22, N'Thị trấn Củ Chi')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (284, 22, N'Xã An Nhơn Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (285, 22, N'Xã An Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (286, 22, N'Xã Bình Mỹ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (287, 22, N'Xã Hòa Phú')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (288, 22, N'Xã Nhuận Đức')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (289, 22, N'Xã Phạm Văn Cội')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (290, 22, N'Xã Phú Hòa Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (291, 22, N'Xã Phú Mỹ Hưng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (292, 22, N'Xã Phước Hiệp')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (293, 22, N'Xã Phước Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (294, 22, N'Xã Phước Vĩnh An')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (295, 22, N'Xã Tân An Hội')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (296, 22, N'Xã Tân Phú Trung')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (297, 22, N'Xã Tân Thạnh Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (298, 22, N'Xã Tân Thạnh Tây')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (299, 22, N'Xã Tân Thông Hội')
GO
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (300, 22, N'Xã Thái Mỹ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (301, 22, N'Xã Trung An')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (302, 22, N'Xã Trung Lập Hạ')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (303, 22, N'Xã Trung Lập Thượng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (304, 23, N'Thị trấn Hóc Môn')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (305, 23, N'Xã Bà Điểm')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (306, 23, N'Xã Đông Thạnh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (307, 23, N'Xã Nhị Bình')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (308, 23, N'Xã Tân Hiệp')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (309, 23, N'Xã Tân Thới Nhì')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (310, 23, N'Xã Tân Xuân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (311, 23, N'Xã Thới Tam Thôn')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (312, 23, N'Xã Trung Chánh')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (313, 23, N'Xã Xuân Thới Đông')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (314, 23, N'Xã Xuân Thới Sơn')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (315, 23, N'Xã Xuân Thới Thượng')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (316, 24, N'Thị trấn Nhà Bè')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (317, 24, N'Xã Hiệp Phước')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (318, 24, N'Xã Long Thới')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (319, 24, N'Xã Nhơn Đức')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (320, 24, N'Xã Phú Xuân')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (321, 24, N'Xã Phước Kiển')
INSERT [dbo].[HBPWard] ([Id], [DistrictId], [Name]) VALUES (322, 24, N'Xã Phước Lộc')
GO

INSERT [dbo].[HBPFoodBeverageCategory] ([Id], [Name]) VALUES (1, N'Food')
INSERT [dbo].[HBPFoodBeverageCategory] ([Id], [Name]) VALUES (2, N'Beverage')
INSERT [dbo].[HBPFoodBeverageCategory] ([Id], [Name]) VALUES (3, N'Food & Beverage')

INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (1, 1, N'Bánh canh', N'Được làm từ bột gạo, bột mì, hoặc bột sắn hoặc bột gạo pha bột sắn cán thành tấm và cắt ra thành sợi to và ngắn với nước dùng được nấu từ tôm, cá, giò heo... thêm gia vị tùy theo từng loại')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (2, 1, N'Bánh đa cua', N'Bánh đa với nước dùng riêu cua')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (3, 1, N'Bún bò Huế', N'Bún đặc sản của xứ Huế, trong nước dùng có một ít mắm ruốc, góp phần làm nên hương vị rất riêng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (4, 1, N'Bún bung', N'Bún nấu với sườn và dọc mùng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (5, 1, N'Bún cá', N'Bún và chả cá nướng trộn nước mắm, rau sống')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (6, 1, N'Bún chả', N'Bún ăn kèm chả viên và chả miếng với nước chấm')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (7, 1, N'Bún chả cá', N'Bún với chả cá chan nước dùng nóng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (8, 1, N'Bún chạo tôm', N'Tôm xiên vào que mía nướng ăn kèm bún, rau sống')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (9, 1, N'Bún đậu mắm tôm', N'Bún ăn với đậu rán và mắm tôm')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (10, 1, N'Bún mắm', N'Bún chan nước dùng làm từ mắm cá linh hay cá sặc')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (11, 1, N'Bún mọc', N'Bún với mọc chan nước dùng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (12, 1, N'Bún ốc', N'Bún, ốc với nước dùng có vị chua')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (13, 1, N'Bún riêu cua', N'Bún và riêu cua được nấu từ gạch cua, thân cua giã, lọc với quả dọc, cà chua, mỡ nước, mẻ ngấu, nước mắm, muối, hành hoa.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (14, 1, N'Bún thịt nướng', N'Bún ăn với thịt nướng cùng nước mắm và rau sống kiểu Huế.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (15, 1, N'Bún thang', N'Bún ăn với nước dùng và cần đến 20 nguyên liệu: rau răm, mùi tàu, trứng gà rán mỏng, lườn gà xé, giò lụa thái sợi rải đều trên nền bún trắng. Bún phải là loại bún sợi nhỏ. Trên rắc tôm bông và rải vài lát lạp xường.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (16, 1, N'Cao lầu', N'Đặc sản của Hội An với sợi mì được chế biến rất công phu ăn cùng giá đỗ và thịt xá xíu')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (17, 1, N'Hủ tiếu', N'Bánh hủ tiếu chan nước dùng với thịt băm nhỏ, lòng heo nấu cùng. Sau đó trụng sơ bánh hủ tiếu với nước dùng, rồi cho các nguyên liệu phụ vào như giá đỗ, hẹ, thịt băm cùng lòng lợn vào')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (18, 1, N'Mì Quảng', N'Được làm từ sợi mì bằng bột gạo xay mịn và tráng thành từng lớp bánh mỏng, sau đó thái theo chiều ngang để có những sợi mì mỏng khoảng 2mm. Sợi mì làm bằng bột mỳ được trộn thêm một số phụ gia cho đạt độ dòn, dai. Dưới lớp mì là các loại rau sống, trên mì là thịt heo nạc, tôm, thịt gà cùng với nước dùng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (19, 1, N'Mì xào', N'Mì xào chín giòn với trứng, rau, hải sản...')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (20, 1, N'Miến lươn', N'Được nấu từ miến với thịt lươn có hai dạng: dạng miến lươn khô và miến lươn nước nấu nước dùng là nước xương')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (21, 1, N'Miến trộn', N'Miến được xào hoặc chần qua, trộn với tôm hoặc cua, nêm gia vị chua ngọt và cay')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (22, 1, N'Phở', N'Là một trong những món ăn đặc trưng nhất cho ẩm thực Việt Nam. Thành phần chính của phở là bánh phở và nước dùng (hay nước lèo theo cách gọi miền Nam) cùng với thịt bò hoặc gà cắt lát mỏng. Ngoài ra còn kèm theo các gia vị như: tương, tiêu, chanh, nước mắm, ớt,...')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (23, 1, N'Bánh cuốn', N'Bột gạo hấp tráng mỏng, để ăn khi còn ướt, bên trong cuốn nhân. Bánh thường ăn với một loại nước chấm pha nhạt từ nước mắm ')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (24, 1, N'Bò bía', N'Gồm bò bía mặn và bò bía ngọt, đều là bột mì cuốn các nguyện liệu khác')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (25, 1, N'Chả giò', N'Món ăn ngon, nổi tiếng của người Việt và được chế biến từ thịt, trứng, rau củ quả băm nhỏ trộn đều, gói trong bánh đa nem và rán giòn')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (26, 1, N'Gỏi cá', N'Thịt cá sống cuốn trong bánh đa nem cùng rau thơm ăn với nước chấm')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (27, 1, N'Gỏi cuốn', N'Bánh đa nem cuộn với các loại rau thơm, bún, và một số loại thịt như thịt bò, lợn, vịt, tôm, cá, cua đã nấu chín.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (28, 1, N'Nem chua', N'Sử dụng thịt lợn, lợi dụng men của lá và thính gạo để ủ chín, có vị chua ngậy. Đặc sản nổi tiếng ở Việt Nam')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (29, 1, N'Bánh bao', N'Làm bằng bột mỳ hấp có nhân gồm thịt heo xay, mộc nhĩ, nấm hương, miến, lạp xưởng, trứng chim cút hoặc trứng gà.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (30, 1, N'Bánh bèo', N'bánh làm từ bột gạo, nhân để rắc lên bánh làm bằng tôm xay nhuyễn, và nước chấm, một hỗn hợp mà nước mắm là thành phần chính và thường đổ trực tiếp vào bánh')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (31, 1, N'Bánh bột lọc', N'Bằng bột sắn được luộc một phần nhỏ, nhồi kỹ. Nhân thường bằng tôm trộn với gia vị, có thể làm nhân bằng thịt heo nạc hay hỗn hợp tôm-thịt heo')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (32, 1, N'Bánh căn', N'Bằng bột gạo nướng. Làm bánh căn thường phải có khuôn đúc đặc biệt, thường làm bằng đất nung, và có nhiều lỗ tròn để đặt khuôn. Vì bánh căn nhỏ nên thường tính theo cặp chứ không theo cái, ở giữa có thể quét mỡ hành hoặc đổ trứng.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (33, 1, N'Bánh chưng', N'Là loại bánh duy nhất có lịch sử lâu đời trong ẩm thực truyền thống Việt Nam còn được sử sách nhắc lại, bánh chưng có vị trí đặc biệt trong tâm thức của cộng đồng người Việt')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (34, 1, N'Bánh cống', N'Là hỗn hợp của thịt heo băm nhuyễn trộn với củ sắn và đậu xanh nguyên hột, trên mặt bánh có một con tôm nằm khoanh tròn')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (35, 1, N'Bánh dày', N'Được làm bằng xôi đã được giã thật mịn, có thể có nhân đậu xanh và sợi dừa với vị ngọt hoặc mặn. Bánh có thể được làm vào các dịp Tết cổ truyền của dân tộc Việt và vào ngày Giỗ Tổ Hùng Vương')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (36, 1, N'Bánh đúc', N'làm bằng bột gạo (tại miền Bắc và miền Trung) hoặc bột năng (miền Nam) với nước vôi trong một số gia vị. Bánh được làm thành tấm to, khi ăn thì cắt nhỏ thành miếng tùy thích.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (37, 1, N'Bánh giò', N'Bằng bột tẻ lọc, thịt nạc vai dùng chế biến nhân có kèm mộc nhĩ, hành khô, hạt tiêu, nước mắm, muối... Bánh giò có hình dài nhô cao như hình bàn tay úp')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (38, 1, N'Bánh gối', N'Được làm bằng nhiều lớp bột và chiên giòn. Theo truyền thống, nhân thịt lợn, nhưng ngày nay thịt gà và thịt bò cũng được sử dụng.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (39, 1, N'Bánh hỏi', N'Được làm từ bột gạo và có quy trình chế biến đặc biệt công phu, tỉ mỉ thường ăn chung với mỡ hành, thịt quay, thịt nướng, lòng heo...')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (40, 1, N'Bánh ít', N'làm từ bột nếp và bột đậu xanh với phương pháp hấp cách thủy. nhân bánh ít được xào chín trước khi gói cẩn thận bằng lá gai hoặc lá chuối tơ')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (41, 1, N'Bánh ít trần', N'Bánh ít không gói trong lá, thường rắc ruốc tôm, ruốc thịt lên trên')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (42, 1, N'Bánh khọt', N'Bằng bột gạo, có nhân tôm, được rán và ăn kèm với rau sống, ớt tươi, chấm nước sốt mắm tôm (không phải mắm tôm hay mắm tôm chua)')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (43, 1, N'Bánh khúc', N'làm từ lá rau khúc nếp, gạo nếp, nhân đậu xanh, thịt lợn mỡ có bọc ở ngoài bằng xôi')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (44, 1, N'Bánh mì', N'Bánh mì rạch đôi kẹp nhân ở giữa. Rất nhiều chủng loại khác nhau tùy vào nhân[')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (45, 1, N'Bánh nậm', N'Bằng bột tẻ, bánh mỏng dẹp với nhân nấm, thịt lợn, tiêu, ớt gói trong lá chuối')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (46, 1, N'Bánh quai vạc', N'được làm từ bột (khoai) mì tinh (hay bột năng) bên trong nhân có thể chứa tôm, thịt rồi đem luộc. Ở miền Nam thường xuất hiện phổ biến dưới dạng bánh chiên.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (47, 1, N'Bánh tai', N'Làm từ bột gạo tẻ, thịt lợn và một số gia vị khác')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (48, 1, N'Bánh tẻ', N'bột gạo tẻ, gói ngoài bằng lá dong và được luộc cho chín.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (49, 1, N'Bánh tét', N'là nét tương đồng của bánh chưng ở Miền Bắc về nguyên liệu, cách nấu, chỉ khác về hình dáng và sử dụng lá chuối để gói thay vì lá dong, nhưng cũng có nhiều bánh tét nhân chuối hay đậu đen.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (50, 1, N'Bánh tôm Hồ Tây', N'Tôm (nước ngọt) hồ Tây bọc bột mì cho vào chảo mỡ nóng già ngập bánh cho chín tới. Khi bánh phồng lên và ngả màu vàng có bốc mùi thơm ngậy')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (51, 1, N'Bánh xèo', N'Bằng bột gạo bên ngoài, bên trong có nhân là tôm, thịt, giá đỗ, được rán màu vàng, đúc thành hình tròn hoặc gấp lại thành hình bán nguyệt[')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (52, 1, N'Cháo lòng', N'Cháo kết hợp với nước dùng ngọt làm từ xương lợn hay nước luộc lòng lợn, và nguyên liệu chính cho bát cháo không thể thiếu các món phủ tạng lợn luộc')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (53, 1, N'Cháo trắng', N'Nấu gạo chín nhừ trong nước. Để được thành cháo thường thì thể tích nước phải hơn gấp 3 lần thể tích gạo')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (54, 1, N'Lẩu', N'Gồm một nồi nước dùng đang sôi, các món ăn sống được để xung quanh và người ăn gắp đồ ăn sống bỏ vào nồi nước dùng, đợi chín tới và ăn nóng')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (55, 1, N'Canh khổ qua nhồi thịt', N'Mướp đắng được nhồi thịt, bó lại bằng hành hoa nấu trong nước xương ninh')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (56, 1, N'Ốc nấu chuối đậu', N'Món ăn dân dã nhưng khá cầu kỳ với ốc luộc chín nấu cùng chuối xanh, đậu rán, thịt ba chỉ, có lá lốt, tía tô')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (57, 1, N'Súp cua', N'Món súp với thịt cua, trứng gà hoặc trứng cút ngoài ra còn có xương gà để làm súp thêm vị ngọt và bỗ dưỡng hoặc hạt bắp.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (58, 1, N'Súp yến', N'Món ăn sang trọng, đắt tiền, bổ dưỡng nằm trong Bát trân nấu từ tổ yến với đường.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (59, 1, N'Xôi chiên', N'Xôi trắng ấn dẹt thành từng bánh rồi chiên ngập dầu, hoặc có thể chiên phồng thành dạng tròn xoay như hình cầu.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (60, 1, N'Xôi đậu xanh', N'Đỗ xanh chà vỏ, ngâm nở và đãi bỏ vỏ (hoặc có thể để nguyên vỏ) trộn với gạo nếp và đồ chín. Đây là một loại xôi phổ biến và có rất nhiều loại xôi tương tự được chế biến với các loại đậu, đỗ')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (61, 1, N'Xôi gà', N'Được làm với nước cốt dừa và lá dứa, sau đó xé phay thịt gà luộc hoặc thịt gà quay, thái mỏng lạp sường và bày lên bát xôi như một đồ ăn kèm.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (62, 1, N'Xôi gấc', N'Là một món ăn ngon, bổ, phổ thông, và rất được ưa chuộng như một đồ thờ cúng ngày lễ, tết, giỗ chạp, hoặc đi kèm với lợn sữa quay trên mâm đồ lễ ăn hỏi. Sử dụng thịt gấc để tạo màu sắc đỏ tươi tắn và hương vị thơm ngon cho món xôi.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (63, 1, N'Xôi lá cẩm', N'Tương tự xôi xéo với đậu xanh tán nhuyễn, nhưng kết hợp với nước sắc của lá cẩm để lấy màu tím đỏ.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (64, 1, N'Xôi đậu phộng', N'Lạc nhân được luộc chín mềm, trộn đều với gạo nếp đã ngâm và đem lên đồ theo cách làm xôi thông thường')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (65, 1, N'Xôi ngũ sắc', N'Xôi được nấu kết hợp với các loại nước sắc của lá cơm xanh, cơm đỏ, cơm vàng để tạo màu. Thịnh hành với các dân tộc thiểu số (Mường, Tày, Thái). 5 màu xôi tượng trưng cho ngũ hành')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (66, 1, N'Xôi sắn', N'Gạo nếp trộn đều với củ sắn nếp đã bào thành sợi hoặc chặt miếng nhỏ, đồ chín và gia chút hành phi, mỡ nước.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (67, 1, N'Xôi trắng', N'Chỉ với gạo nếp và chút muối, không có bất cứ một nguyên liệu phụ nào khác hoặc đôi khi chỉ được kết hợp với một chút màu thực phẩm. Xôi trắng thường rất thịnh hành như một thứ quà trong sự kết hợp với các thực phẩm động vật')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (68, 1, N'Xôi vò', N'Điểm đặc biệt của loại xôi này là các hạt xôi được tách rất rời nhưng vẫn rất dẻo. Gần tương tự xôi xéo với đậu xanh đồ chín tán nhuyễn, nhưng gạo nếp được đồ riêng với một chút lá dứa lấy mùi thơm, và có thể có một chút bột dành dành, bột nghệ tạo màu')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (69, 1, N'Xôi xéo', N'Xôi đặt trong bát, lấy dao lạng mỏng từng lát xéo đậu xanh lên trên, rắc hành phi và rưới chút mỡ nước. Đây được coi là một trong những món xôi khó nấu ngon nhất')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (70, 1, N'Cơm đĩa', N'Cơm bình dân với nhiều món ăn đa dạng, phong phú. Thông thường thực đơn sẽ bao gồm một dĩa cơm và một phần thức ăn theo lựa chọn, một bát canh.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (71, 1, N'Cơm cháy Ninh Bình', N'Cơm cháy là phần cơm dưới đáy nồi khi nấu cơm thường chín vàng giòn, cơm cháy lấy ra xong phải phơi nắng tự nhiên hai, ba nắng, để chỗ thoáng, tránh ẩm mốc, lúc gần ăn mới chiên giòn')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (72, 1, N'Cơm hến', N'Cơm nguội trộn với hến luộc, nước hến, mắm ruốc, rau bắp cải, tóp mỡ, bánh tráng nướng, mì xào giòn, ớt màu, đậu phộng nguyên hạt, dầu ăn chín, tiêu và muối')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (73, 1, N'Cơm gà Quảng Nam', N'Cơm tẻ chín tới ăn với gà luộc rưới nước dùng gà')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (74, 1, N'Cơm lam', N'Được làm từ gạo nếp cùng một số nguyên liệu khác, cho vào ống tre, giang, nứa và nướng chín trên lửa')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (75, 1, N'Cơm nắm', N'Là món ăn có từ rất xa xưa của dân tộc. Cơm trắng nóng hổi đem nén chặt thành tấm bằng hai bàn tay rồi xắt miếng chấm với muối vừng vừa dẻo vừa bùi hài hòa vị mặn, ngọt.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (76, 1, N'Cơm nếp', N'Được nấu bằng gạo nếp, khác biệt với xôi chủ yếu ở phương thức nấu trực tiếp trong nước, không làm chín bằng hơi nước.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (77, 1, N'Cơm rang', N'Cơm cùng với dầu ăn hoặc mỡ được chiên với những thức ăn khác như thịt, trứng... Món ăn cực kỳ phổ biến tại Việt Nam')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (78, 1, N'Cơm tấm', N'Cơm tấm có thể gồm cả sườn, bì, chả, trứng hoặc không gồm đầy đủ các món trên nhưng phải có nước mắm ngọt')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (79, 1, N'Cơm trắng', N'Được làm ra từ gạo bằng cách đem nấu với một lượng vừa đủ nước, chỉ có nguyên liệu là gạo tẻ và không có thêm gia vị, là thức ăn gần như hàng ngày của người Việt')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (80, 2, N'Sữa tươi trân châu đường đen', N'Id et si quartu vobis si quartu manifestum brevens, non et quo, et trepicandor ut nomen quantare in rarendum')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (81, 2, N'Trà phô mai kem sữa', N'travissimantor et transit. Pro quo Tam quantare et estis Id quis pars quantare et quad Pro e novum egreddior')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (82, 2, N'Trà hoa quả', N'Multum e quo in gravis esset bono brevens, manifestum Longam, funem. vantis. venit. quo fecit. delerium.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (83, 2, N'Matcha đá xay', N'imaginator quo sed et e Versus brevens, et quartu sed non et eggredior. delerium. et homo, Tam cognitio,')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (84, 2, N'Trà đào chanh sả', N'rarendum eggredior. novum Sed trepicandor plorum Versus estum. funem. pladior dolorum dolorum gravis rarendum')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (85, 2, N'Trà hoa quả nhiệt đới', N'venit. quo in Tam non quo pars in Pro quis linguens Tam quartu imaginator pars nomen Longam, plorum quad')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (86, 2, N'Trà sữa gạo rang Hàn Quốc', N'manifestum esset estum. fecundio, quartu plorum eggredior. apparens imaginator linguens e novum plurissimum')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (87, 2, N'Trà sữa Hokkaido', N'linguens quad egreddior vobis e e vobis et et e parte vantis. linguens et novum travissimantor eggredior.')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (88, 2, N'Cafe latte', N'et quorum plorum egreddior vobis Et travissimantor nomen travissimantor quo parte plorum estis Multum pladior')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (89, 2, N'Cacao', N'si Sed fecit. Quad gravis gravum et e venit. manifestum Quad parte in in e sed transit. plurissimum Longam, et dolorum et Tam quo,')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (90, 2, N'Socola đá xay', N'linguens gravis esset quo, e quorum ut transit. brevens, cognitio, novum venit. plorum Longam, fecit,')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (91, 2, N'Sinh tố', N'plurissimum nomen quorum si vobis si novum Versus sed vobis plorum funem. vobis plurissimum et travissimantor si volcans')
INSERT [dbo].[HBPFoodBeverage] ([Id], [FoodBeverageCategoryId], [Name], [Description]) VALUES (92, 2, N'Soda việt quất', N'bono habitatio volcans quorum Id si dolorum funem. volcans trepicandor eggredior. venit. quad nomen quo,')

INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (1, 3, N'KFC', N'Là thương hiệu đồ ăn nhanh nổi tiếng nhất hiện nay, khi nhắc đến những thức ăn nhanh thì chắc có lẽ mọi người sẽ nghĩ ngay đến KFC đầu tiên. KFC dần trở nên rất quen thuộc với người dân Việt và rất được ưa chuộng. Món ăn hút khách nhất ở KFC chắc chắn là gà rán, món gà rán ở KFC nổi tiếng thơm ngon, được chế biến với nhiều hương vị khác nhau mang đến cảm giác ngon miệng cho người ăn. Ngoài gà rán thì tại KFC còn có các món như salad, hamburger hay cơm gà,...', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (2, 3, N'Lotteria', N'Lotteria là chuỗi cửa hàng thức ăn nhanh bắt nguồn tại Đông Á với cửa hàng đầu tiên ở Tokyo, Nhật Bản vào tháng 9 năm 1972. Lấy tên gọi bắt nguồn từ tên của công ty mẹ - Tập đoàn Lotte, thương hiệu hiện có chi nhánh ở Nhật Bản, Hàn Quốc, Indonesia, Việt Nam và Myanmar', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (3, 3, N'Domino''s Pizaa', N'Domino’s Pizza lần đầu xuất hiện trên thị trường vào năm 1960 khi 2 anh em nhà Monaghan là Tom và Jame Monaghan mua lại một cửa hàng pizza nhỏ có tên gọi Dominick’s Pizza ở Michigan với giá 500 đôla Mỹ. Sau 8 tháng, Jame từ bỏ việc kinh doanh và bán lại cổ phần của mình cho anh trai Tom với giá tương đương một chiếc xe Volkswagen loại cũ. Điều này khiến Tom nghĩ đến việc đem lại sức sống mới cho thương hiệu pizza của mình và quyết định đổi tên thành Domino’s Pizza.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (4, 2, N'Pew Pew', N'Chắc hẳn các bạn đều biết bánh mì kẹp là món ăn dân giã từ xa xưa của người Việt Nam, được ví như loại sanwich ngon nhất thế giới, chính vì thế, kinh doanh bánh mì quả là một sáng kiến không tồi. Vậy nếu bạn là người hâm mộ của pewpew hay có hứng thú với ngành nghề kinh doanh này, thì cùng tìm hiểu những bước đầu tiên để bắt tay vào chiến lược này nhé
Trước hết, để có thể kinh doanh bánh mì chú pew thì bạn phải sở hữu một chiếc xe bánh mì. Hiện nay trên thị trường có rất nhiều nơi bán xe bánh mì nhưng chỉ một vài nơi có thể đáp ứng được nhu cầu rẻ - chất lượng', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (5, 1, N'Hoàng Yến Vietnamese Cuisine', N'Thương hiệu Hoàng Yến từ lâu đã trở thành điểm đến quen thuộc của những người yêu ẩm thực truyền thống Việt Nam. Nét đặc sắc khó quên của Hoàng Yến được tạo nên bởi cái hồn trong mỗi món ăn, đúc kết từ niềm đam mê khám phá mỹ vị ẩm thực ba miền của người sáng lập và lưu giữ nét văn hoá trong mỗi tác phẩm. Hoàng Yến luôn chinh phục khách hàng dù là khó tính nhất bằng những món ăn rất riêng, từ dân dã như cánh gà chiên nước mắm, thịt kho nước dừa, canh cua rau đay, chả cá cơm cháy,… đến các món sang trọng và tinh tế như tôm càng kho tàu, cơm hấp lá sen, hải sâm cơm cháy, miến cua tay cầm, chả cá Lã Vọng, chả mực Hạ Long,…

Thực khách có thể tự mình khám phá nét duyên của ẩm thực Việt Nam qua những món ăn truyền thống cũng như những món được biến tấu sáng tạo từ những nguyên liệu vốn đơn giản và thuần Việt.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (6, 2, N'Sumo BBQ', N'Gắn liền với tên gọi của nghệ thuật nướng nổi tiếng Nhật Bản, Sumo Yakiniku là nhà hàng thịt nướng chú trọng đến nguyên liệu thượng hạng hay quá trình chuẩn bị tinh tế công phu từ bảo quản, chế biến thịt, sốt ướp, sốt chấm và kỹ thuật nướng.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (7, 3, N'Ba con cừu', N'Là một thương hiệu của Golden Gate JSC, công ty sáng lập và sở hữu các chuỗi nhà hàng Ashima, Kichi Kichi, SumoBBQ, Ba Con Cừu (the Mongolian Hotpot) lần đầu tiên ra mắt tại Việt Nam từ tháng 8/2012 là chuỗi nhà hàng tiên phong về lẩu cừu non Mông Cổ.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (8, 2, N'Osaka Ohsho', N'Quán Mì Gyoza trứ danh Nhật Bản thuộc tập đoàn Golden Gate', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (9, 3, N'Kichi Kichi', N'Hệ thống nhà hàng Lẩu băng chuyền hàng đầu Việt Nam với gần 100 nhà hàng trên toàn quốc.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (10, 1, N'Crystal Jade Kitchen', N'Lần đầu tiên xuất hiện tại Việt Nam, Crystal Jade – chuỗi nhà hàng danh tiếng Châu Á với hơn 120 nhà hàng tại 21 thành phố mang đến sự giao thoa giữa nền ẩm thực Quảng Đông truyền thống và xu hướng ẩm thực hiện đại. Với hơn 100 món ăn Quảng Đông danh tiếng ở mức giá chỉ từ 50,000đ; từng câu chuyện trong bữa ăn của bạn càng thêm thú vị bởi không gian hiện đại cùng phong cách ẩm thực chuẩn quốc tế khi đến với Crystal Jade Kitchen.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (11, 1, N'Daruma', N'Daruma – Món Nhật mỗi ngày với menu các Set cơm giá chỉ từ 59.000đ, các món Sushi giá chỉ từ 69.000đ, các set món chuẩn Nhật chỉ từ 109.000đ, và Buffet lẩu Nhật thỏa thích không giới hạn hơn 30 vị nhúng lẩu chỉ từ 219.000đ/Người.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (12, 2, N'Manwah', N'Sau hàng trăm năm tồn tại trong cuộc sống người Đài, lẩu Đài Loan không chỉ đơn thuần là sự kết hợp của các nguyên liệu quen thuộc, mà liên tục được cải tiến và hoàn thiện, từ thế hệ này sang thế hệ khác. Thực khách đến Manwah sẽ được tự mình khám phá hành trình ẩm thực đặc sắc với nước lẩu ngọt vị tự nhiên, kết hợp hầm cùng các loại gia vị dậy mùi thơm đặc trưng của Đài Loan. Nét đặc sắc không chỉ đến từ nước lẩu, mà còn đến từ cả những món nhúng kiểu Đài – bạn sẽ tìm thấy nhiều hơn là chỉ thịt bò và các loại rau thơm. Chính sự kết hợp các nguyên liệu, món ăn hài hoà sẽ tạo nên hương vị lẩu Đài Loan tỉ mỉ và tinh tế.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (13, 2, N'Vuvuzela', N'Vuvuzela là câu lạc bộ bia tươi theo phong cách bar, điểm đến đầy mê hoặc dành cho những người yêu thích bia tươi và đam mê khám phá những điều mới lạ. Tại Vuvuzela thực khách có thể tìm thấy gần như bất kì loại bia tươi nào từ Tiger, Bitburger là những loại quen thuộc cho đến Zamky – loại bia tươi Tiệp lần đầu tiên được biết đến hay rất nhiều những loại bia khác nhập khẩu từ Bỉ, Czech, Hà Lan.. Cùng với bia, món ăn đặc trưng của các quốc gia và những cô gái phục vụ xinh đẹp là những điểm nhấn khiến Vuvuzela trở nên khác biệt.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (14, 2, N'Isushi', N'iSushi mang tới khách hàng những trải nghiệm và cảm xúc Nhật thực thụ với Buffet Nhật Bản 100 món ăn tinh hoa với các món Sashimi tươi ngon, hơn 57 loại Sushi cùng nhiều món ăn hấp dẫn khác Teppanyaki, Yakitori… do Tổng bếp trưởng Noda Toshiro thực hiện.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (15, 3, N'Yutang', N'Yu Tang mang những hương vị truyền thống của trà sữa Đài Loan trở lại, cùng những nguyên liệu cao cấp nhất và bàn tay pha chế tinh tế nhất.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (16, 1, N'The coffee inn', N'Được sản sinh từ tâm huyết của những con người sống vì cà phê, The Coffee Inn là đại diện tiêu biểu của văn hóa cà phê mới tại Việt Nam. Mỗi sản phẩm tại The Coffee Inn là sự kết hợp hoàn hảo giữa nguyên liệu cao cấp từ những vùng trồng cà phê nổi tiếng tại Việt Nam (Sơn La, Khe Sanh, Đà Lạt) cùng kĩ thuật rang xay từ Nhật Bản đảm bảo cho những tách café chất lượng và thuần khiết nhất. Với không gian được thiết kế theo phong cách tối giản, cùng những sắp đặt khéo léo, mỗi khi tới với The Coffee Inn bạn sẽ có một trải nghiệm đầy thú vị dù là đi với gia đình, bạn bè hay đi một mình.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (17, 3, N'Citi Beer Station', N'Với không gian bia nam tính, độc đáo giúp “đấng mày râu” thỏa mãn cơn khát, City Beer Station là điểm đến để khách hàng thưởng thức bia mát lạnh cùng với món nhậu đặc sắc', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (18, 3, N'Kpub', N'K-Pub không chỉ đặc biệt ở tên gọi mà còn bởi phong cách nướng đường phố Hàn Quốc và những món ngon độc đáo có 1-0-2. Cùng hòa mình vào không khí náo nhiệt tại K-Pub để thưởng thức thịt nướng đường phố Hàn đích thực chỉ từ 149.000VNĐ/người và thỏa thích chọn lựa tại Buffet line 30+ món: ba chỉ bò Mỹ, panchan, món Hàn nóng hổi, đồ tráng miệng, nước uống. Đặc biệt, viền trứng phô-mai refill không giới hạn được tặng kèm với mọi loại buffet sẽ mang đến những trải nghiệm hương vị cực kì mới lạ cho các tín đồ thịt nướng. Cùng tới khám phá K-Pub ngay thôi nào!!', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (19, 3, N'Cowboy Jacks', N'Cowboy Jack’s – Authentic American Dining là chuỗi nhà hàng đậm chất Mỹ với phong cách hiện đại và gần gũi. Đến với Cowboy Jack’s, bạn không thể không thử qua các món ăn đặc biệt chỉ có thể tìm thấy tại đây như Chicago Pizza Nhân Nhồi với 8 hương vị đặc biêt, Sườn nướng Jumbo hay Bít tết bò Úc. Bạn là người thích khám phá sự thú vị của ẩm thực và văn hóa Mỹ? Cowboy Jack’s là sự lựa chọn tốt nhất dành cho bạn!', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (20, 1, N'37 street', N'Phố ngon 37 là nơi tụ hội của hơn 300 món ngon từ khắp miền tổ quốc. Những đầu bếp của phố ngon luôn hy vọng có thể mang đến cho khách thưởng thức hương vị nguyên bản nhất của ẩm thực dân dã Việt Nam', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (21, 3, N'Chili''s', N'Nhà hàng cung cấp các món ăn giống như các cửa hàng Chili khác trên toàn thế giới, theo khái niệm nhà hàng-quán bar ban đầu lấy cảm hứng từ các món ăn Mexico & Texas.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (22, 3, N'Hutong', N'Không giống bất cứ nơi đâu, nước lẩu Hồng Kông đậm đà tỏa hương thảo quả, ớt khô, quế, hồi… Thiên đường với hơn 99 vị nhúng lẩu từ thịt bào, hải sản tới rau củ, đặc biệt là các loại viên thả lẩu tươi như cá, bò, tôm, há cảo,… chỉ được làm khi khách bắt đầu gọi món. Chẳng cần phải đi xa tới gần 1000km, Thiên đường lẩu Hutong – Hot Pot Paradise với 99 vị nhúng lẩu sẽ cùng bạn trải nghiệm trong những hương vị nồng nhiệt và hấp dẫn nhất thế giới này!', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (23, 3, N'Ashima', N'Ra mắt từ năm 2005, trải qua hơn 10 năm mang hương vị nấm đến với thực khách, bộ sưu tập nấm của Ashima hiện đã lên tới hơn 23 loại nấm thiên nhiên và nấm quý có nguồn gốc từ Nhật Bản, Hàn quốc và Shangrila; hứa hẹn sẽ đưa thực khách đắm chìm trong không gian mang hơi hướng Á Đông hiện đại và trải nghiệm phong cách phục vụ thân thiện, đặc sắc bởi điệu múa tay khi phục vụ lẩu nấm của các cô gái tại Ashima.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (24, 1, N'Gogi House', N'GoGi House – Quán thịt nướng Hàn Quốc Ngon Số 1 sẽ đưa bạn ghé đến những quán thịt nướng tại Seoul đã tạo nên danh tiếng cho nền ẩm thực xứ kim chi. Nếu đã một lần thưởng thức thịt nướng tại GoGi House, bạn sẽ không thể quên được hương vị “ngất ngây” của những món sườn non bò Mỹ, nạc vai bò Mỹ, dẻ sườn tươi…. khi hòa quyện vào với các loại gia vị đặc trưng xứ Hàn đã trở nên hấp dẫn đến thế nào. Ngoài ra, những món ăn kèm không thể bỏ qua như cơm trộn, mỳ lạnh, canh Kimchi và các loại lẩu cũng sẽ làm bạn ấn tượng thêm về nền ẩm thực Hàn Quốc.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (25, 3, N'Shogun', N'Shogun – Quán Nướng Đường Phố Nhật Bản với menu buffet hơn 68 món Nướng & Nhậu đường phố Nhật Bản giá chỉ từ 29.000đ và các suất buffet thỏa thích chỉ từ 329.000đ/1người', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (26, 2, N'Texas Chicken', N'GÀ RÁN TỪ MỸ. 100% GÀ TƯƠI', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (27, 3, N'CARL''S Jr', N'Chuỗi cửa hàng thức ăn nhanh nhượng quyền từ Mỹ', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (28, 3, N'MK Suki', N'Chuỗi nhà hàng MK là thương hiệu nổi tiếng đến từ Thái Lan, mang lại cho thực khách trải nghiệm về món Lẩu tươi thơm ngon, độc đáo, tốt cho sức khỏe.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (29, 2, N'Popeyes', N'Hơn 40 năm trước tại New Orleans thuộc tiểu bang Louisiana, một huyền thoại ẩm thực đã ra đời. Khởi đầu từ một nhà hàng nhỏ và một ý tưởng lớn, ', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (30, 1, N'Yen Sushi Sake', N'Khởi đầu từ năm 2016, YEN Sushi & Sake Pub được thực khách yêu thích bởi không gian bài trí độc đáo và đặc sắc. Đội ngũ đầu bếp tại YEN được đào tào theo tiêu chuẩn Nhật Bản, luôn sẵn sàng phục vụ các món Sushi và Sashimi đa dạng, tươi ngon với nguồn nguyên liệu được chắt lọc kĩ lưỡng, hầu hết nguồn hàng được nhập khẩu trực tiếp từ đất nước mặt trời mọc. Bên cạnh đó, không thể không nhắc đến các món nướng Yaki đặc trưng của ẩm thực Nhật Bản được chế biến tinh tế. Còn gì tuyệt hơn khi thưởng thức món ngon trong một không gian đậm chất Nhật Bản giữa lòng TP.Hồ Chí Minh và thưởng thức các loại rượu trứ danh đến từ nhà rượu Tsukinoi Nhật Bản với hơn 150 tuổi.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (31, 1, N'My life coffee', N'Hệ thống cửa hàng café với đặc trưng không gian được thiết kế đa phong cách mang hơi thở Châu Âu, hòa quyện cùng dòng sản phẩm đa dạng và phù hợp với thị trường Việt Nam.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (32, 2, N'Yen Premium', N'Thương hiệu mang đến một không gian thưởng thức ẩm thực Nhật Bản đẳng cấp. Với tinh thần “Omotenashi” và cung cách phục vụ chu đáo, lối kiến trúc Ryotei khiến bất cứ ai cũng lầm tưởng mình đang bước chân vào một nhà hàng ngay tại Nhật Bản', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (33, 1, N'Shamoji Robata Yaki', N'Chuỗi nhà hàng mang lại một phong cách hoàn toàn khác biệt trong cách thưởng thức ẩm thực Nhật Bản và định nghĩa về phong cách “Nhậu Nhật”.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (34, 3, N'The Sushi Bar', N'he Sushi Bar was one of the first Japanese restaurants to open in Vietnam and is known for top quality and quick, reliable sushi delivery in Saigon.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (35, 2, N'Toky Deli', N'Chuỗi nhà hàng TOKYO Deli  ra đời với sự tham vọng làm thay đổi quan niệm đó. TOKYO Deli  mong muốn giới thiệu ẩm thực Nhật Bản đích thực đến với nhiều đối tượng khách hàng, đặc biệt là khách hàng Việt Nam, đồng thời biến nhu cầu thưởng thức món ăn Nhật thành một nhu cầu thường xuyên và phổ biến.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (36, 3, N'Uraetei BBQ', N'Một xu hướng ẩm thực Nhật Bản khác hoàn toàn với những gì mọi người thường nghĩ về món ăn Nhật.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (37, 1, N'Phuc Long', N'Trải qua hơn 50 năm chắt chiu tinh hoa từ những búp trà xanh và hạt cà phê thượng hạng cùng mong muốn mang lại cho khách hàng những trải nghiệm giá trị nhất khi thưởng thức, Phúc Long liên tục là thương hiệu tiên phong với nhiều ý tưởng sáng tạo đi đầu trong ngành trà và cà phê.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (38, 2, N'The coffee house', N'Tại The Coffee House, chúng tôi luôn trân trọng những câu chuyện và đề cao giá trị Kết nối con người. Chúng tôi mong muốn The Coffee House sẽ trở thành “Nhà Cà Phê', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (39, 2, N'Starbucks', N'Mỗi tuần Starbucks trên khắp thế giới phục vụ hàng triệu thức uống đến tay khách hàng. Và Starbucks cam kết rằng sẽ phục vụ từng khách hàng duy nhất tại một thời điểm.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (40, 3, N'Dunkin Donut', N'Cộng đồng Dunkin Donuts Việt Nam.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (41, 2, N'Kissho', N'KISSHO – pronounced as “kee-sho”, which means “good luck”, auspicious. Kissho is the first contemporary Japanese restaurant strategically located at 14 Nguyen Hue Boulevard District 1 HCMC.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (42, 3, N'Ngan Dinh', N'Tọa lạc tại tầng 5 của khách sạn Windsor Plaza, nhà hàng Ngân Đình phục vụ các món ăn mang đậm hương vị Quảng Đông đích thực và đặc sắc, được ghi nhận bằng nhiều giải thưởng quốc tế. Nhà hàng mang đến nhiều lựa chọn không gian ẩm thực đẳng cấp cho nhóm nhỏ hay tiệc lớn với 9 phòng VIP công suất phục vụ 10 người mỗi phòng.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (43, 1, N'Le Café', N'Mang đến không gian ẩm thực thanh lịch và sang trọng, Nhà hàng và Bar Le Café tại Sherwood Suites Sài Gòn là điểm hẹn mới lý tưởng với thực đơn chọn lọc nhiều món đặc sắc của Địa Trung Hải và Châu Á, cũng như các món ngon truyền thống Việt Nam do các đầu bếp tài hoa chuẩn bị ngay gian bếp mở. Tọa lạc tại tầng trệt và mở cửa từ 06:30 sáng đến 23:00 tối, Le Café cũng phục vụ phong phú các loại cocktail, cà phê, trà và các thức uống khác. Từ 11:30 trưa đến 15:00 chiều hàng ngày, thực khách có thể thưởng thức các thực đơn trưa hấp dẫn với ba món chọn sẵn gồm súp hoặc salad, món chính và tráng miệng.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (44, 1, N'Noodle noodle', N'The noodle is a staple of cuisines all across Asia, and new restaurant Noodle Noodle brings the best of all these amazing noodle dishes from around the region together in one place.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (45, 3, N'The Long', N'Drawing inspiration from Italian sidewalk cafes, take a break and enjoy signature refreshments at one of the most sought-after destinations in the city.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (46, 3, N'Long Triều', N'Từ đội ngũ bếp tài hoa, đến những nguyên liệu thượng đẳng, nhà hàng Long Triều mang đến tinh hoa ẩm thực Quảng Đông trong một không gian đẳng cấp bậc nhất. Nội thất sang trọng, kết hợp mạnh mẽ và tinh tế giữa đá ngọc bích, thần sa đỏ và vàng lá trong trang trí, nhà hàng Long Triều mang tới trải nghiệm ẩm thực đỉnh cao.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (47, 2, N'Vietnam House', N'Với vô số thành tựu nổi bật trong lĩnh vực ẩm thực, ngôi sao đầu bếp người Úc gốc Việt Luke Nguyễn đã tạo dựng cho bản thân một thương hiệu vô cùng ấn tượng trên con đường sự nghiệp của mình. Ở tuổi 23, anh đã thực hiện được mơ ước khi mở nhà hàng đầu tiên có tên Red Lantern, được đánh giá rất cao vào năm 2002. Luke Nguyễn cũng là người đứng sau và chịu trách nhiệm cố vấn cho Fat Noodle, chuỗi nhà hàng chuyên những món mì, phở Châu Á rất được yêu thích tại khu sòng bài The Star tại Pyrmont, Sydney, và Brisbane, nước Úc.', 1)
INSERT [dbo].[HBPSellerBrand] ([Id], [FoodBeverageCategoryId], [Name], [Description], [StatusId]) VALUES (48, 2, N'Amigo', N'Step off the streets into a Latin American themed steakhouse. Conveniently located on Nguyen Hue Street, Amigo Grill Restaurant features American, Australian, and Wagyu beef, along with freshly imported Norwegian salmon. A fully-stocked bar and international wine list complements any main course. Event hosting is available in the private dining room on the second floor.', 1)

INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (1, 1, N'KFC LOTTE GÒ VẤP', N'https://uot.net2/rbrcn/hdyzn/oqnst/luspu/vnn.php', N'947-2834718', 1855752989, -830169164, 1952068980, 926485152, N'Lô 1F17, tầng 1 , Lotte mart Gò Vấp, số 18, Phan Văn Trị', N'57 North Cowley Blvd.', 199, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (2, 1, N'KFC EMART GÒ VẤP', N'http://ygbb.netb/ukcgi/fxfua/vkdcg/haksw/bggn.html', N'391-7495352', -410366688, -1911431967, 1265013596, -618595231, N'366 Phan Văn Trị', N'81 North White Old Avenue', 194, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (3, 1, N'KFC LÊ VĂN VIỆT', N'http://vgcz.webo4/iljxl/xkdiq/ybnof/dsucd.html', N'998-3272815', -1377889098, -199963694, -1169521937, 2139080177, N'193 Lê Văn Việt', N'18 Rocky Clarendon Blvd.', 106, 9, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (4, 2, N'Lotteria Parkson Lê Thánh Tôn', N'https://kvq.localw/kfevp/szie.html', N'700-213-5500', -1453994288, 268705069, 1230899500, -45610287, N'35 Bis – 45 Lê Thánh Tôn', N'343 North Fabien St.', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (5, 2, N'Lotteria Lý Chính Thắng', N'http://uyi.netp/ecsgc/lgthe/dibgo/bdvzo/masi.htm', N'821-4981131', 1101335199, -1367014793, -1632694384, 1898373972, N'250B Lý Chính Thắng', N'13 Second Street', 30, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (6, 2, N'Lotteria Trần Hưng Đạo', N'https://xecab.webn/lyagr/hjsmu/meoet.html', N'923-5348637', -713709495, 148342606, 1730459367, -1165092484, N'95A Trần Hưng Đạo', N'33 South Old St.', 4, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (7, 3, N'Domino''s Pizaa - Nguyễn Tri Phương', N'http://uddgn.weba15/uopng/dbdxr/bqvmy/mwkhh/ttr.htm', N'716-9678103', -898528249, -227334509, 1703624413, 1032430673, N'313 NGUYEN TRI PHUONG', N'87 White Cowley Blvd.', 123, 10, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (8, 3, N'Domino''s Pizaa - Đinh Bộ Lĩnh', N'http://nxrms.net4/bqfld/jlnfp/gfngu.aspx', N'0712264834', -1089820218, 445514703, -1948692841, -1304387329, N'138 Dinh Bo Linh', N'295 White Hague Freeway', 188, 14, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (9, 4, N'Bánh Mì PewPew - Út Tịch', N'https://vtx.net5/nhduy/qbjq.htm', N'8519432534', 1683857489, -439088074, -1341802303, 97032882, N'66 Út Tịch', N'78 Nobel Road', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (10, 4, N'Bánh Mì PewPew - Đường D5', N'http://tay.localh31/ychsv/swl.html', N'320-058-5506', -372623083, -430756295, 488889504, -547022719, N'84 đường D5', N'57 Cowley Parkway', 187, 14, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (11, 48, N'Amigo', N'http://lhi.local41/aaxly/htwik/vvbxf/ylvpt/mndli.html', N'032-204-5425', 545171820, -830509131, -1115846439, -1401183747, N'55-57 Nguyễn Huệ', N'80 North Cowley St.', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (12, 47, N'Vietnam House', N'https://tnc.web7/sjsmi/mvzzs/uqkht.aspx', N'682-2882715', 1356404535, -1719340034, 2082275527, 297727376, N'93-95-97 Đồng Khởi', N'62 White Milton Road', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (13, 46, N'Long Triều', N'http://vks.net3/bwyfv/faqec/qjeb.php', N'436-921-3871', -1808242070, -2018707737, -81689757, 292155421, N'The Reverie Saigon (level 4), 22-36 Nguyen Hue Boulevard', N'181 Cowley Boulevard', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (14, 46, N'The Long', N'https://sab.netw/evydu/xduay/egdvi/fbomd.htm', N'5326202464', 910622045, -609469601, -308317154, 7164704, N'22-36 Nguyễn Huệ', N'392 Rocky Milton Boulevard', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (15, 44, N'Noodle Noodle', N'http://saloi.web8/zvolb/naknu.aspx', N'5891814696', 1879656300, -325335548, -918498440, -1511661332, N'20 Nguyễn Huệ', N'375 East Rocky Cowley Freeway', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (16, 10, N'Le Café', N'https://rogcr.local/xrfrw/pji.php', N'407-944-1394', -1131959984, 1924763144, -570082663, -1362885826, N'192 Nam Kỳ Khởi Nghĩa', N'360 Rocky Oak Avenue', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (17, 42, N'Ngan Dinh', N'http://qpnf.netb9/ornom/cshbf/jawds/kpzrh/qpl.html', N'466489-7151', -820409553, -1683964195, -400035190, -1263589832, N'54 - 56 Đồng Khởi', N'298 Nobel Blvd.', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (18, 41, N'Kissho', N'http://hkvu.localj11/bikbd/shjpn/xwkpy/tzpqt/toj.aspx', N'033172-1489', -1405372493, -7744230, -757599614, 1507454995, N'14 Nguyen Hue', N'99 New Street', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (19, 40, N'Dunkin Donut Hùng Vương', N'https://ufkb.net5/kvhrw/xuque/kgilo/hpvw.php', N'896-7035153', -339526905, -2118393494, -1749776436, 1381159375, N'158 Hùng Vương', N'973 Oak Avenue', 130, 10, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (20, 40, N'Dunkin Donut Nguyễn Đức Cảnh', N'https://hbv.webb4/ujcxk/pfzko/ete.htm', N'893-799-6436', 1943071997, 163349024, -531109701, 898870372, N'59 Nguyễn Đức Cảnh', N'72 White Hague Parkway', 85, 7, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (21, 39, N'Starbucks Tan Son Nhat Airport', N'https://wknhm.local14/vtxro/msxyg/nkgmx/daebq/bmxfi.html', N'990-844-9937', -1958583458, -1459714300, 960845139, 461975981, N'Tầng trệt, Khu thương mại Nhà Giữ Xe Ga Quốc nội Cảng hàng không Quốc tế Tân Sơn Nhất, 45 Trường Sơn', NULL, 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (22, 39, N'Starbucks Rex', N'https://ahovx.netd/xewtc/cjbje/tdvpb/gktke/fvlp.htm', N'018108-9936', 851570527, -2080246209, 1161438238, -242630273, N'141 Nguyễn Huệ', N'39 Green First Blvd.', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (23, 39, N'Starbucks New World', N'https://carsx.web/tmsvu/sbwey/tqn.html', N'267-502-3537', -233241662, 1365472299, -350219295, -1482449935, N'New World Hotel, 76 Nguyễn Thị Nghĩa', N'136 Fabien Freeway', 2, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (24, 39, N'Starbucks Nguyen Van Troi', N'http://gemy.webc0/lijqe/xlulb/norbk/aexzf.php', N'7525639192', 138879141, -869498896, 1600118645, -183254753, N'66 Nguyễn Văn Trỗi', N'68 Rocky Oak St.', 213, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (25, 39, N'Starbucks IBIS', N'http://vhj.locals14/apqpo/cflz.htm', N'807329-9963', 287657456, -497453102, 707248742, -917044388, N'2 Hồng Hà', N'157 Clarendon Boulevard', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (26, 39, N'Starbucks Nguyen Hue', N'https://rfbga.netv41/acilj/vmkrk/jocj.aspx', N'660-376-6309', 1225566682, 1475059972, -1724553265, -1974046555, N'99 Nguyễn Huệ', N'98 New Avenue', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (27, 39, N'Starbucks mPlaza Saigon', N'https://tbcd.nete/vemam/awaph/vhn.php', N'4192874576', -1825014570, -1238230831, -651447092, 64663350, N'39 Lê Duẩn, Quận 1 Mặt, Hai Bà Trưng', N'86 East Nobel Boulevard', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (28, 39, N'Starbucks Thao Dien', N'https://xbmg.net/zrkfd/romxp/ebmze/bfvpz/nbri.php', N'590-2071446', -1403028377, -1833018304, 115524581, -545514511, N'21 Đường Thảo Điền', N'14 South Green Cowley Boulevard', 20, 2, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (29, 39, N'Starbucks CMT8', N'https://ell.webp1/satbt/zzhno/ucj.php', N'919-8067926', -1377461992, 1644638176, 1911814363, 31506903, N'241Bis Cách Mạng Tháng Tám', N'47 West Milton Way', 25, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (30, 39, N'Starbucks Reserve Bar Han Thuyen', N'http://blj.web44/gjtzm/dpfit/sihaf.htm', N'890630-3491', 291283539, 539183075, 787082611, 1034982147, N'13 Hàn Thuyên', N'53 West Rocky First Parkway', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (31, 39, N'Starbucks Phan Xich Long', N'https://rnps.webu/ribyt/tohsy/lrztt/syyau/jtubw.htm', N'840356-4346', 1786566704, 1816916753, 1847266802, 1877616851, N'216 Phan Xích Long', N'863 Rocky Milton Boulevard', 212, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (32, 39, N'Starbucks Leman', N'http://nprk.web3/dxkxb/sjjtz/sqoso/drs.aspx', N'380-135-6170', 1069633657, -1553829819, -2038025978, 374738487, N'117 Nguyễn Đình Chiểu', N'73 White First Blvd.', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (33, 39, N'Starbucks Lakai', N'http://gvao.net3/wwxlr/imzom/xawn.html', N'415387-2202', 869648878, 868732667, -867816459, -866900248, N'Lakai Apartments, 98-126 Nguyễn Tri Phương', N'93 East Cowley Way', 57, 5, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (34, 39, N'Starbucks Crescent Strip', N'https://pyfmx.netx83/kktrv/igify/buyzs/uwb.html', N'394-537-5878', -1845865684, -511398899, 1324415758, 2137432620, N'CR1-02, Crescent Residence 1, 103 Ton Dat Tien', N'92 Rocky Second Avenue', 86, 7, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (35, 39, N'Starbucks Pearl Plaza', N'http://jaul.localp2/mgesb/zgthp.aspx', N'176374-4096', 117048684, 484432983, -851817285, -1219201584, N'561 Điện Biên Phủ', N'985 South White New Freeway', 187, 14, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (36, 39, N'Starbucks Dong Du', N'https://xlxpk.netc37/hdpip/tlsoh/pbvpj/dye.html', N'832-775-0454', 1325079864, 887361687, 449643510, 11925333, N'38 Đông Du', N'918 Green First Parkway', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (37, 39, N'Starbucks Lotte Pico', N'https://zwe.locale/kscdy/qcw.html', N'518-462-5426', 1334815821, 151009916, -1114687661, -2078365403, N'PICO PLAZA, 20 Cộng Hòa', N'77 Rocky Second Parkway', 233, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (38, 39, N'Starbucks Gateway', N'https://wvom.net6/gkxis/aborj/ejtll/nvi.aspx', N'440-1624220', -1739406493, -922308157, -105209821, -1435595132, N'Gateway, 177 Xa lộ Hà Nội, Khu phố 1', NULL, 20, 2, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (39, 39, N'Starbucks Vincom Dong Khoi', N'https://dbqgw.netg7/gphob/pfhxq/sbhsd/jjov.html', N'920-226-2118', 1289155140, -587336010, 2033000521, -1331181391, N'72 Lê Thánh Tôn', N'347 First Way', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (40, 39, N'Starbucks Emart', N'https://uedi.web8/vnztn/qufkk/veqdv/cdljq/hrmxe.htm', N'349-5328820', -350230049, -2115697619, -1733681542, 1351665462, N'Khu siêu thị Emart, 366 Đ. Phan Văn Trị', N'95 Oak Drive', 194, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (41, 38, N'The Coffee House - Lê Văn Sỹ', N'http://rwlfd.local90/agjzr/tcvxt/xwmwt/qwfdv/skz.html', N'2413411768', 1567155941, 70277539, 720882784, -1371488032, N'281 Đ. Lê Văn Sỹ', N'923 Old Street', 222, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (42, 38, N'The Coffee House - Đống Đa', N'http://gkj.neta52/cmuca/hiaje/eaxlk/hyrqw/jcmt.htm', N'0430215913', -1874471097, 847789765, -1968592086, 941910754, N'2 Đống Đa', N'196 West Green New Blvd.', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (43, 38, N'The Coffee House - Thăng Long', N'https://nkgdq.web/tlpba/jfpxg/hxlqd/yvowm/raxxg.htm', N'395891-8241', -1039554849, -372074463, -1852077724, -1184597338, N'51 Thăng Long', N'140 North White Second Blvd.', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (44, 38, N'The Coffee House - Nguyễn Kiệm', N'https://fgyf.web8/wqapc/raxbt/dwymk/hmyfh/sazf.htm', N'774-343-0243', -842111353, 1994556932, 999518867, 4480802, N'371 Nguyễn Kiệm', N'742 Hague Way', 192, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (45, 38, N'The Coffee House - Tran Huy Lieu', N'https://bsaz.localb/gmowz/bhuej/qpqj.htm', N'327-2201315', -431002147, 54850971, -1826183448, -1450032275, N'185 Trần Huy Liệu', N'39 South White Milton Blvd.', 213, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (46, 38, N'The Coffee House - Hồng Hà', N'https://jlrjq.local80/cthrt/utxxy/jbmcl/msfv.html', N'7797579637', -545246716, 371138208, 197029703, -22921201, N'18 Hồng Hà', N'949 Rocky Hague Avenue', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (47, 38, N'The Coffee House - Út Tịch', N'https://cxel.localf8/ixxrp/emnbz/fksnq/dgo.php', N'558-6515679', 1643090621, 711215005, 1926823036, -994947423, N'17B Út Tịch', N'11 Rocky Nobel St.', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (48, 38, N'The Coffee House - Lê Trung Nghĩa', N'http://vphx.local57/nlucc/sgnch/bhr.php', N'037-2377515', 1200696480, 242210610, 1431208387, 472722517, N'51 Lê Trung Nghĩa', N'77 South Nobel Parkway', 233, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (49, 38, N'The Coffee House - Huỳnh Văn Bánh', N'https://ahu.localv82/wmvpq/cvpbp.aspx', N'5825502637', -2143040269, 107982608, 220408597, 332834586, N'68 Huỳnh Văn Bánh', N'587 Hague Street', 220, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (50, 38, N'The Coffee House - Trần Quốc Thảo', N'http://nnqg.nete8/zrdzc/kxmrq.htm', N'077-5801727', 1875799924, 2119733976, 216184381, 460118433, N'183F Trần Quốc Thảo', N'565 Clarendon Avenue', 30, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (51, 38, N'The Coffee House Signature', N'http://cotc.netl2/koqtp/qchrm.aspx', N'1456425319', 896034318, -1974177321, -904836674, 1982979671, N'19B Phạm Ngọc Thạch', N'65 East Fabien Freeway', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (52, 38, N'The Coffee House - Trần Quang Khải', N'https://ufyu.local28/kleiw/kkqrs/ewj.aspx', N'590-0706846', 54600687, -1868342291, -1534600245, 1200858196, N'180 Trần Quang Khải', N'59 North White Fabien Road', 10, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (53, 37, N'Phuc Long Coffee & Tea - Cộng Hòa CN1', N'http://tppxo.localm/gdscg/wmtkf/ofvcl/ynx.php', N'722-814-6499', 1511379316, -85445412, -806995152, -1528544892, N'1B Cộng Hòa', N'12 Cowley Boulevard', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (54, 37, N'Phuc Long Coffee & Tea - Phổ Quang', N'http://xwnwi.webt54/rxrmn/snnbs/tus.aspx', N'260-169-3378', 161282038, -165476154, 169670264, -173864380, N'119C Phổ Quang', N'10 East Clarendon Blvd.', 214, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (55, 37, N'Phuc Long Coffee & Tea - Nguyễn Văn Trỗi', N'https://ozp.webs/amczu/dtxha/blpkv/dpisy/qwojm.php', N'896-2084567', -1523169464, -630284365, 1884882910, -991997814, N'106 Nguyễn Văn Trỗi', N'47 Green Second St.', 213, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (56, 37, N'Phuc Long Coffee & Tea - Trường Sơn', N'https://jarb.netx6/mvnmn/toxwn/inyjy/tgjin/atozt.aspx', N'581074-1381', 573355826, 1870218232, 1019596991, 168975750, N'60A Trường Sơn', N'61 Fabien Freeway', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (57, 37, N'Phuc Long Coffee & Tea - Cộng Hòa CN2', N'https://hwm.webj37/rwtjn/sztw.aspx', N'4457891820', 1624148578, 609531724, 1742398517, 727781663, N'18E Cộng Hòa', N'730 East Green Clarendon Drive', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (58, 37, N'Phuc Long Coffee & Tea - Trường Chinh', N'http://immtm.local/zlbqh/slnkh/ehkam/yxdml/zpxgv.aspx', N'6015290533', -252181719, 1337393364, -275121368, 1360333013, N'493 Trường Chinh', N'60 East First Parkway', 235, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (59, 37, N'Phuc Long Coffee & Tea - Lê Văn Sỹ', N'http://mityl.localk42/miejm/ubhjn/srrrl/ogfjw/loqq.php', N'826-008-7838', 1712361932, -223156087, -881433886, -1539711685, N'350 Lê Văn Sỹ', N'794 Green Fabien Avenue', 35, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (60, 37, N'Phuc Long Coffee & Tea - Nguyễn Đình Chiểu', N'https://fjl.nets/jaeyg/setsq/svrcm/yxqe.php', N'153-0292451', -2091626119, 1295289542, -498952971, 1850100041, N'117 Nguyễn Đình Chiểu', N'51 West Rocky Fabien Blvd.', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (61, 37, N'Phuc Long Coffee & Tea - Phạm Văn Hai', N'http://hqhd.net2/ffxhm/mwu.html', N'2459115108', 1499439516, -1363448855, -1227458191, -1091467527, N'9 Phạm Văn Hai', N'841 Second Way', 222, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (62, 36, N'Uraetei - Cộng Hòa', N'https://oulv.web9/shyhl/kucqu/lwoil/eisht/cms.php', N'781-419-6218', -780979231, -432097910, -83216589, -1881818915, N'117A Cộng Hòa', N'856 East Clarendon Blvd.', 233, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (63, 36, N'Uraetei - Trần Quốc Thảo', N'https://syrs.net1/machs/iogtn/vxtln/fzhvx.php', N'647-3280386', 769348444, -206083758, -1790302716, 1227038024, N'125A Trần Quốc Thảo', N'973 North Milton Avenue', 28, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (64, 36, N'Uraetei - NKKN', N'https://gtj.local67/emcmd/hdahd.aspx', N'9203230434', 253876352, 624958630, 996040908, 1367123186, N'67-69-71 Nam Ky Khoi Nghia, Ward, St', N'65 Second Blvd.', 2, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (65, 36, N'Uraetei - Nguyễn Trãi', N'https://bgzkd.neto8/ehtiu/bbgba/vdotn/slth.aspx', N'703-146-4935', -479630710, -276901966, 74173219, 2018928122, N'967-969 Đ. Nguyễn Trãi', N'36 South Clarendon Avenue', 64, 5, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (66, 36, N'Uraetei - Trần Hưng Đạo', N'https://fofoq.webc9/smaty/afg.php', N'033413-4192', -1631908572, 1208197740, 784486911, 360776082, N'545-547 Đ. Trần Hưng Đạo', N'288 South First Road', 3, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (67, 36, N'Uraetei - Nguyễn Hồng Đào', N'http://kauey.local0/nvmpz/ridoi/drrvm/nzqoe/qhadr.html', N'893-005-4593', -1030123103, -906106706, 782090306, -658073912, N'168 - 170 Đường Nguyễn Hồng Đào', N'18 West Second Avenue', 235, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (68, 36, N'Uraetei - 3/2', N'https://qxnx.neta5/nbfrn/aknmc/yrizs/nqa.aspx', N'497-715-5703', 317791394, 1853921493, -1242567948, 631214397, N'430-434 Đường 3 Tháng 2', N'884 East New Drive', 130, 10, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (69, 36, N'Uraetei - Thảo Điền', N'https://feukg.localk6/kqnwq/cxozo/cgioc.php', N'043468-0783', -684371987, 683319330, -682266679, 681214022, N'4 Đường Thảo Điền', N'515 North Second St.', 20, 2, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (70, 36, N'Uraetei - Thái Văn Lung', N'https://cblj.net63/hagob/qaiwb/fpnh.html', N'829-536-7305', 1826785095, 1414566684, -1002348276, 590129862, N'8A/9D2 Thái Văn Lung', N'33 White Milton Street', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (71, 35, N'TOKYO Deli - Trường Sơn', N'https://iuvd.locale49/pwlhf/sgglp/rblg.aspx', N'2910238039', -1622063731, 1442800923, -1263538121, -1084275316, N'4 Trường Sơn', N'39 East Fabien Way', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (72, 35, N'TOKYO Deli - Phan Xích Long', N'https://dbsk.localx19/atkmt/ihlih/wfhmx/yklql/wmsv.htm', N'9313777816', -329631432, 1648570958, 820026840, -2138966372, N'242 - 244 Phan Xích Long, phường 1, Quận Phú Nhuận', N'76 Old Blvd.', 207, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (73, 35, N'TOKYO Deli - Điện Biên Phủ', N'https://icfp.localo/ryvti/ndljh/tujha/hamz.aspx', N'152060-5816', -1116989345, 2122422694, -980372402, 1985805751, N'187 Điện Biên Phủ', N'95 Green Old Drive', 6, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (74, 35, N'TOKYO Deli - Phan Văn Trị', N'https://grq.neti49/pqoyf/xef.htm', N'407-314-5225', 1035966991, -931116074, -826265154, -721414234, N'366A3 Đ. Phan Văn Trị', N'844 Cowley Boulevard', 194, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (75, 35, N'TOKYO Deli - Trần Hưng Đạo', N'http://fmfz.netz/ubwxq/bcnta/skbiv/bsppw/kazjt.html', N'2173733219', 2019036268, 1713252048, 1407467828, -1101683611, N'120Bis Đ. Trần Hưng Đạo', N'297 First St.', 9, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (76, 35, N'TOKYO Deli - 3 /2', N'https://rpvmc.webr18/ouvyd/fqilf/pmqfr.htm', N'461-7089088', -954355791, 165612361, 1524352581, -735609157, N'386 - 388 Đường 3 Tháng 2', N'52 Old Way', 130, 10, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (77, 35, N'TOKYO Deli - Lê Quốc Hưng', N'http://yzc.net57/lthww/elqlu/jephm/lml.aspx', N'835-401-6693', 2071214387, -1265076309, 458938225, -1800283794, N'26 C-D-F, Lê Quốc Hưng', N'112 Old Way', 45, 4, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (78, 35, N'TOKYO Deli - Nguyễn Thị Thập', N'http://mos.webx42/mxtpk/grbzm/xzgt.aspx', N'1059191205', 687218568, 938984954, -1190751343, -1442517729, N'31-33 Khu Him Lam Khu Him Lam, Nguyễn Thị Thập', N'314 Rocky Cowley Boulevard', 83, 7, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (79, 35, N'TOKYO Deli - Lê Đại Hành', N'http://eqk.neti9/kierf/kseal/dhwzy/hddhe/ojcm.htm', N'295-066-3499', 293402185, 2097935752, 1754985672, -1412035595, N'184 Lê Đại Hành', N'64 Old Way', 148, 11, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (80, 35, N'TOKYO Deli - Song Hành', N'http://dey.local97/aohly/cpkj.php', N'015-948-7386', -351197502, 1861631025, -1224580907, 587530783, N'34 Song Hành, kp5', N'20 White Hague Avenue', 20, 2, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (81, 35, N'TOKYO Deli - Nguyễn Đức Cảnh', N'https://qcd.localv93/iafqe/ablg.html', N'206717-4309', 1222207001, -1661411354, 2100615701, -392336407, N'107 Nguyễn Đức Cảnh', N'42 Rocky Oak St.', 85, 7, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (82, 34, N'THE SUSHI BAR 4-Saigon Court', N'https://xpw.local/mgion/vwuy.php', N'520067-8045', -1812540320, 442216289, 1219375908, -1996535530, N'2 Tòa nhà Saigon Court, 149 Nguyễn Đình Chiểu', N'333 Clarendon Avenue', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (83, 33, N'Shamoji Robata Yaki', N'https://dyhmk.localr65/wnzba/zyvtx/rdeeq/katur.php', N'670-2728427', -291138264, -1456123860, -473625809, 1638611402, N'8 Đồng Khởi', N'58 Rocky Nobel Way', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (84, 32, N'Yen Premium', N'https://gonh.net36/txjsf/ejltp/mokdj/cwkn.php', N'5385325251', 1736383156, -2007658088, 131449367, 402724296, N'123 Bà Huyện Thanh Quan', N'642 East Rocky Oak Drive', 30, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (85, 31, N'My life coffee - Lê Duẩn', N'http://lnfc.localn/jaiom/fctrj/tervw/mmfj.htm', N'672638-7022', 907150077, 1299613709, 1692077341, 2084540973, N'2b Lê Duẩn', N'46 Fabien Parkway', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (86, 31, N'My life coffee - Trương Định', N'http://uzh.netb1/cbwpj/lvkal/alb.htm', N'640-427-3528', 363222046, 729419449, 1095616852, -1461814258, N'22A Trương Định', N'296 Green New Way', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (87, 31, N'My life coffee - Alexandre de Rhodes', N'https://usat.local/niqav/douzy/htowh/zyvny.html', N'9200122565', -199651445, -786734686, -1373817927, 1960901165, N'4 Alexandre de Rhodes', N'707 First Avenue', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (88, 30, N'Yen Sushi Sake - Lê Quý Đôn', N'http://yaib.web/muapr/whmbg/ylxsm/nca.htm', N'400121-4991', 1759206675, -2112621964, -318553603, 671968886, N'15 Lê Quý Đôn', N'836 Hague St.', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (89, 30, N'Yen Sushi Sake - NKKN', N'https://lec.web/zwbbg/ibygm/twapk/pejfw/gaenv.php', N'119-5964111', 1810917006, -878939912, 2094446459, 1162469362, N'92 Nam Kỳ Khởi Nghĩa', NULL, 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (90, 30, N'Yen Sushi Sake - Hai Bà Trưng', N'https://abnb.net7/duxng/dnwki/vuzzu/ougis.aspx', N'951244-7097', -1604681468, -811820304, -18959140, -1373581623, N'151e Hai Bà Trưng', N'89 Nobel Blvd.', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (91, 30, N'Yen Sushi Sake  - Đồng Khởi', N'http://jye.net/bcetu/jhtd.html', N'120-055-5339', 1923964595, -563081468, -1349681985, 2136282499, N'8 Đồng Khởi', N'11 Cowley Drive', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (92, 30, N'Yen Sushi Sake - Nguyễn Đức Cảnh', N'http://sckbf.web70/nffii/mbytw/blzky/orvnq/tmr.php', N'019-8796670', 1339528860, -1829563397, -172114284, 662148815, N'185 Nguyễn Đức Cảnh', N'79 Fabien Drive', 85, 7, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (93, 29, N'Popeyes - Cộng Hòa', N'http://gae.webk94/chzfq/tefhf/isao.htm', N'509-107-3071', -265816629, -367927348, -470038067, -572148786, N'15-17 Cộng Hòa', N'679 South First Avenue', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (94, 29, N'Popeyes - Trung Luong Expy', N'https://vux.webw8/gzcxx/frpdl/mzjam/nfvvk/vzfa.htm', N'8146053310', -1497551191, -1056861147, -616171103, 175481056, N'Trung Luong Expy', N'597 North Oak Parkway', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (95, 29, N'Popeyes - Nguyễn Bỉnh Khiêm', N'http://eop.locald4/xtkjx/xxlku.htm', N'375-549-9376', 1771320685, 1021762500, -272204318, 1670129777, N'13 Nguyễn Bỉnh Khiêm', N'13 West Rocky Cowley Parkway', 6, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (96, 28, N'MK Suki - Le Thanh Ton CN1', N'https://kom.web2/dgjxa/xwjok/bzgys/dbyfx/votq.php', N'808-528-4410', 199372340, 1884759066, -1422662148, -960565227, N'B3 Floor, Vincom Center B, 72, Le Thanh Ton Street', N'95 East Second Boulevard', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (97, 28, N'MK Suki - Nguyễn Du', N'https://ptmg.web9/oktow/pgef.html', N'8876463138', -402727652, -1213411254, -2024094856, 687294808, N'82 Nguyễn Du', N'215 South White First Boulevard', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (98, 28, N'MK Suki - Lê Thánh Tôn CN2', N'http://iyjub.neth8/dosdk/jhnku/ayfek/jhmqe/ttimn.html', N'239-2401953', -488748139, -719260422, -949772705, -1180284988, N'72 Lê Thánh Tôn', N'507 Green Oak Street', 1, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (99, 27, N'CARL''S Jr', N'http://sssu.localu/pxefu/gexam.aspx', N'038067-3409', -1032367303, -833222391, 634077476, -434932567, N'138A Trường Chinh', N'594 Nobel Blvd.', 233, 17, 1, 1)
GO
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (100, 26, N'Texas Chicken - Hoàng Văn Thụ', N'http://kkjr.local/elhfk/homms/gdnyf/ijecy.htm', N'4990583812', -364300700, 229372808, 94444919, 2107000677, N'392 Hoàng Văn Thụ', N'401 Old Blvd.', 225, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (101, 26, N'Texas Chicken - Phan Xích Long', N'http://lscx.local70/xwwpl/gqmdh.aspx', N'6930265663', -337324595, -1892166276, 1299524307, -706882344, N'276 Phan Xích Long', N'85 West First Parkway', 212, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (102, 26, N'Texas Chicken - Sư Vạn Hạnh', N'https://slx.webn/vomop/sodtm/imtsc/sthew/denk.php', N'841-2955435', -1658482720, -553033388, -1595067703, 489618368, N'463 Sư Vạn Hạnh', N'208 Clarendon Boulevard', 130, 10, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (103, 25, N'Shogun', N'https://pxwab.localr/dcglj/ehz.aspx', N'154-3002339', 1937364048, -247536029, -705191654, 1162847276, N'13 Lê Quý Đôn', N'563 West White Nobel Street', 27, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (104, 24, N'Gogi House - Trường Sơn CN1', N'http://sqrck.neth/xkmlr/pzuzs/udsvo/jxkkq/jjxbh.aspx', N'485-976-7351', -2064435934, 1414913849, 765391767, 115869685, N'14 Trường Sơn', N'211 West Green Oak Road', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (105, 24, N'Gogi House - Trường Sơn CN2', N'http://yoj.web4/wkhzq/ysppa/hdmu.htm', N'590014-7334', 1030290137, 746656422, -463022710, -179388995, N'Tan Son Nhat International Airport, Tầng Hầm - Khu vực Thương mại - nhà xe - Ga Quốc Nội, 45 Trường Sơn', N'12 Green Oak Street', 223, 17, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (106, 24, N'Gogi House - Lê Văn Sỹ', N'http://voszm.webg/auuoo/ietmy/sele.php', N'966699-4832', 1239536168, 715210186, -190884207, -1814041872, N'256 Đ. Lê Văn Sỹ', N'592 Fabien Road', 35, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (107, 23, N'Ashima - Nguyễn Đình Chiểu', N'http://gpm.web/vyoqf/rpgst/nlchv/favaw/uwki.php', N'959-326-2346', 23215706, -269762639, 516309566, -762856499, N'35A Nguyễn Đình Chiểu', N'376 Fabien Freeway', 6, 1, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (108, 23, N'Ashima - Tú Xương', N'https://skpng.web/oelyw/vnfjv/dpubd/iqj.html', N'642-0766098', -922450429, -175650055, -1576333328, 829532951, N'11 Tú Xương', N'785 North Oak Avenue', 28, 3, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (109, 22, N'Hutong - Phan Xích Long', N'https://adyy.localz99/lmynp/hggch/sebzl/rlnv.aspx', N'1822417959', 1905638988, 1235548253, 565457518, 2042850430, N'171 Phan Xích Long', N'17 Rocky Fabien Drive', 208, 16, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (110, 22, N'Hutong - Quang Trung', N'https://wqdj.local39/xvbou/jywyf/azs.html', N'242963-2911', 37180418, -1876300958, -1567937848, 1259574735, N'Số 1 Quang Trung', N'729 Milton Drive', 192, 15, 1, 1)
INSERT [dbo].[HBPSellerBranch] ([Id], [SellerBrandId], [Name], [Description], [PhoneNumber], [OpeningHour], [OpeningTime], [ClosingHour], [ClosingTime], [Address], [AddressDescription], [WardId], [DistrictId], [CityId], [StatusId]) VALUES (111, 22, N'Hutong - Lê Quý Đôn', N'http://ipo.webs18/ertnk/qqdqd/zwnq.aspx', N'2284181223', 1949490001, -638903285, -1475800213, 165213491, N'6B Lê Quý Đôn', N'61 Nobel Road', 27, 3, 1, 1)
