-----Câu 1 ------
CREATE TABLE Nhap (
    SoHDN nvarchar(10) PRIMARY KEY,
    MaVT nvarchar(10) NOT NULL,
    SoLuongN int NOT NULL,
    DonGiaN float NOT NULL,
    NgayN datetime NOT NULL
);

CREATE TABLE Xuat (
    SoHDX nvarchar(10) PRIMARY KEY,
    MaFT nvarchar(10) NOT NULL,
    SoLuongX int NOT NULL,
    DonGiaX float NOT NULL,
    NgayX datetime NOT NULL
);

CREATE TABLE Ton (
    MaVT nvarchar(10) PRIMARY KEY,
    TenVT nvarchar(50) NOT NULL,
    SoLuongT int NOT NULL
);
-- Thêm 3 phiếu nhập vào bảng Nhap
INSERT INTO Nhap (SoHDN, MaVT, SoLuongN, DonGiaN, NgayN)
VALUES ('PN001', 'VT01', 10, 10000, '2023-04-20'),
       ('PN002', 'VT02', 20, 20000, '2023-04-21'),
       ('PN003', 'VT03', 30, 30000, '2023-04-22');

-- Thêm 3 phiếu xuất vào bảng Xuat
INSERT INTO Xuat (SoHDX, MaFT, SoLuongX, DonGiaX, NgayX)
VALUES ('PX001', 'FT01', 5, 150000, '2023-04-20'),
       ('PX002', 'FT02', 10, 250000, '2023-04-21'),
       ('PX003', 'FT03', 15, 350000, '2023-04-22');

-- Thêm 4 mặt hàng vào bảng Ton
INSERT INTO Ton (MaVT, TenVT, SoLuongT)
VALUES ('VT01', 'Mat hang 1', 50),
       ('VT02', 'Mat hang 2', 100),
       ('VT03', 'Mat hang 3', 150),
       ('VT04', 'Mat hang 4', 200);
-- Câu 2 ( 2 điểm )

CREATE FUNCTION ThongKeTienBan(@NgayX datetime, @MaVT nvarchar(10))
RETURNS TABLE
AS
RETURN (
    SELECT Ton.MaVT, Ton.TenVT, SUM(Nhap.SoLuongN * Nhap.DonGiaN) AS TienBan
    FROM Ton
    JOIN Nhap ON Ton.MaVT = Nhap.MaVT
    WHERE Nhap.MaVT = @MaVT AND CONVERT(date, Nhap.NgayN) = CONVERT(date, @NgayX)
    GROUP BY Ton.MaVT, Ton.TenVT
);

SELECT * FROM ThongKeTienBan('2023-04-01', 'VT01');

-- Câu 3
CREATE FUNCTION ThongKeTienNhap(@MaVT nvarchar(10), @NgayN datetime)
RETURNS TABLE
AS
RETURN (
SELECT MaVT, SUM(SoLuongN * DonGiaN) AS TienNhap
FROM Nhap
WHERE MaVT = @MaVT AND NgayN = @NgayN
GROUP BY MaVT, NgayN
)
SELECT * FROM ThongKeTienNhap('VT001', '2023-04-01')

-- Câu 4
CREATE TRIGGER tr_Nhap_Insert
ON Nhap
FOR INSERT
AS
BEGIN
    DECLARE @MaVT nvarchar(10)
    DECLARE @SoLuongN int

    SELECT @MaVT = MaVT, @SoLuongN = SoLuongN
    FROM inserted

    IF EXISTS(SELECT 1 FROM Ton WHERE MaVT = @MaVT)
    BEGIN
        UPDATE Ton SET SoLuongT = SoLuongT + @SoLuongN WHERE MaVT = @MaVT
    END
    ELSE
    BEGIN
        ROLLBACK TRAN
        RAISERROR ('Mã VT chưa có mặt trong bảng Ton', 16, 1)
    END
END
INSERT INTO Nhap (SoHDN, MaVT, SoLuongN, DonGiaN, NgayN) VALUES ('PN007', 'VT04', 15, 12000, '2023-04-04');
