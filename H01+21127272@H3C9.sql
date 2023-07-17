﻿USE MASTER 
GO
IF DB_ID ('TRGTAM') IS NOT NULL
	DROP DATABASE COMPUTER

CREATE DATABASE TRGTAM
GO
USE TRGTAM
GO
CREATE TABLE HOIVIEN
(
	MAHV CHAR(4),
	HOTEN NVARCHAR(50),
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(50),
	MALOAI NVARCHAR(5),
	NGUOIGIOITHIEU CHAR(4),

	CONSTRAINT PK_HV
	PRIMARY KEY (MAHV)
)
GO

CREATE TABLE TRUNGTAM
(
	MACTY CHAR(2),
	STT INT,
	HOITRUONG CHAR(4),
	DIACHI NVARCHAR(50),
	NGAYLAP DATETIME,

	CONSTRAINT PK_TT
	PRIMARY KEY (MACTY, STT)
)
GO

CREATE TABLE DANGKY
(
	MACTY CHAR(2),
	MATT INT,
	MAHV CHAR(4),
	NGAYDANGKY DATETIME,
	PHIDK INT,
	THOIHAN INT,
)
GO

ALTER TABLE HOIVIEN
ADD 
	CONSTRAINT FK_NGGT
	FOREIGN KEY (NGUOIGIOITHIEU)
	REFERENCES HOIVIEN(MAHV)
GO

ALTER TABLE TRUNGTAM
ADD 
	CONSTRAINT FK_HT
	FOREIGN KEY (HOITRUONG)
	REFERENCES HOIVIEN(MAHV)
GO

ALTER TABLE DANGKY
ADD
	CONSTRAINT FK_HV
	FOREIGN KEY (MAHV)
	REFERENCES HOIVIEN(MAHV),
	CONSTRAINT FK_CT
	FOREIGN KEY (MACTY, MATT)
	REFERENCES TRUNGTAM(MACTY, STT)
GO

INSERT HOIVIEN
VALUES
	('HV01', N'Nguyễn Văn Sơn', '10-30-2000', N'1 Bis Nguyễn Trãi Q5 TP HCM', N'Bạc', NULL),
	('HV02', N'Trần Trung Kiên', '12-13-2000', N'12 B Nguyễn Văn Trỗi Đồng Nai', N'Bạc', NULL),
	('HV03', N'Trần Thị Bình', '1-1-1998', NULL, N'Vàng', NULL),
	('HV04', N'Nguyễn Văn Toàn', '1-1-1978', NULL, NULL, NULL)
GO

INSERT TRUNGTAM
VALUES
	('L1', 1, NULL, N'123 Vườn Lài, Tân Phú', '1-1-2022'),
	('L1', 2, NULL, N'45 Phú Thọ Hòa, Tân Phú', '12-13-2022'),
	('L2', 1, NULL, N'11 Võ Văn Ngân, Thủ Đức', '2-1-2023')
GO

INSERT DANGKY
VALUES
	(NULL, NULL, NULL, '2-12-2009', 90000, 356),
	(NULL, NULL, NULL, '12-30-2019', 87000, 500),
	(NULL, NULL, NULL, '6-6-2016', 100000, 500),
	(NULL, NULL, NULL, '3-7-2018', 120000, 100)
GO

UPDATE HOIVIEN
SET NGUOIGIOITHIEU = 'HV03' WHERE MAHV = 'HV01'
UPDATE HOIVIEN
SET NGUOIGIOITHIEU = 'HV03' WHERE MAHV = 'HV02'
UPDATE HOIVIEN
SET NGUOIGIOITHIEU = 'HV01' WHERE MAHV = 'HV04'
GO

UPDATE TRUNGTAM
SET HOITRUONG = 'HV03' WHERE MACTY = 'L1' AND STT = 1
UPDATE TRUNGTAM
SET HOITRUONG = 'HV03' WHERE MACTY = 'L1' AND STT = 2
UPDATE TRUNGTAM
SET HOITRUONG = 'HV01' WHERE MACTY = 'L2' AND STT = 1
GO

UPDATE DANGKY
SET MACTY = 'L1' WHERE PHIDK = 90000
UPDATE DANGKY
SET MATT = 1 WHERE PHIDK = 90000
UPDATE DANGKY
SET MAHV = 'HV01' WHERE PHIDK = 90000
UPDATE DANGKY
SET MACTY = 'L1' WHERE PHIDK = 87000
UPDATE DANGKY
SET MATT = 1 WHERE PHIDK = 87000
UPDATE DANGKY
SET MAHV = 'HV02' WHERE PHIDK = 87000
UPDATE DANGKY
SET MACTY = 'L2' WHERE PHIDK = 100000
UPDATE DANGKY
SET MATT = 1 WHERE PHIDK = 100000
UPDATE DANGKY
SET MAHV = 'HV03' WHERE PHIDK = 100000
UPDATE DANGKY
SET MACTY = 'L1' WHERE PHIDK = 120000
UPDATE DANGKY
SET MATT = 2 WHERE PHIDK = 120000
UPDATE DANGKY
SET MAHV = 'HV04' WHERE PHIDK = 120000
GO

SELECT DISTINCT HV.MAHV, HV.HOTEN, HV.NGAYSINH, HV.DIACHI, HV.MALOAI, HV.NGUOIGIOITHIEU
FROM HOIVIEN HV, TRUNGTAM TT
WHERE HV.MAHV = TT.HOITRUONG
AND TT.DIACHI LIKE N'%Tân Phú%'

SELECT DISTINCT TT.MACTY, TT.STT, COUNT(*) AS N'Số lượng hội viên'
FROM TRUNGTAM TT, DANGKY DK
WHERE TT.MACTY = DK.MACTY
AND TT.STT = DK.MATT
GROUP BY TT.MACTY, TT.STT