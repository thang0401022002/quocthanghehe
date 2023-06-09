---- lab 6.1 ------
GO
CREATE FUNCTION Lab6_C1(@ten AS NVARCHAR(50))
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE sp.tensp LIKE '%' + @ten + '%'
GO
GO
SELECT * FROM Lab6_C1('Galaxy Note 11')
GO
--- lab6.2 ---
GO
CREATE FUNCTION Lab6_C2(@x DATE, @y DATE)
RETURNS TABLE
AS
RETURN 
    SELECT sp.masp, sp.tensp, hsx.tenhang, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota
    FROM Nhap n
    JOIN Sanpham sp ON n.masp = sp.masp
    JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE n.ngaynhap BETWEEN @x AND @y
GO
GO
SELECT * FROM Lab6_C2('2018-01-01', '2020-12-31')
GO

--- lab6.3 ---
GO
CREATE FUNCTION Lab6_C3 (@hangsx nvarchar(50), @luachon int)
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, hsx.tenhang, sp.soluong, sp.giaban, sp.donvitinh, sp.mota
    FROM Sanpham sp
    JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @hangsx AND ((@luachon = 0 AND sp.soluong = 0) OR (@luachon = 1 AND sp.soluong > 0))
GO
GO
SELECT * FROM Lab6_C3('Oppo', 1)
GO
---- lab6.4 ------
GO
CREATE FUNCTION Lab6_C3 (@hangsx nvarchar(50), @luachon int)
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, hsx.tenhang, sp.soluong, sp.giaban, sp.donvitinh, sp.mota
    FROM Sanpham sp
    JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @hangsx AND ((@luachon = 0 AND sp.soluong = 0) OR (@luachon = 1 AND sp.soluong > 0))
GO
GO
SELECT * FROM Lab6_C3('Oppo', 1)
GO

--- lab6.5 ---
GO
CREATE FUNCTION Lab6_C5(@address NVARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT *
FROM Hangsx
WHERE diachi LIKE '%' + @address + '%'
GO
GO
SELECT * FROM Lab6_C5(N'Vi')
GO

--- lab 6.6 ---
GO
CREATE FUNCTION Lab6_C6(@x INT, @y INT)
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, hsx.tenhang, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, xuat.ngayxuat
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    INNER JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE YEAR(xuat.ngayxuat) BETWEEN @x AND @y;
GO
GO
SELECT * FROM Lab6_C6(2018,2020)
GO
--- lab 6.7 ---
GO
CREATE FUNCTION dbo.Lab6_Cau7
(
    @mahangsx INT,
    @luaChon INT
)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        sp.masp, 
        sp.tensp, 
        sp.soluong, 
        sp.giaban, 
        sp.donvitinh, 
        sp.mota
    FROM 
        Sanpham sp
        JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
        LEFT JOIN Nhap n ON sp.masp = n.masp
        LEFT JOIN Xuat x ON sp.masp = x.masp
    WHERE 
        hs.mahangsx = @mahangsx 
        AND (@luaChon = 0 AND n.masp IS NOT NULL OR @luaChon = 1 AND x.masp IS NOT NULL)
)
GO

--- lab6.8 ---
GO
CREATE FUNCTION dbo.Lab6_Cau8
(
    @ngayNhap DATE
)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        nv.manv, 
        nv.tennv, 
        nv.gioitinh, 
        nv.diachi, 
        nv.sodt, 
        nv.email, 
        nv.phong
    FROM 
        Nhanvien nv 
        JOIN Nhap n ON nv.manv = n.manv
    WHERE 
        n.ngaynhap = @ngayNhap
)
GO
--- lab 6.9 ---
GO
CREATE FUNCTION Lab6_Cau9
(
    @minPrice FLOAT,
    @maxPrice FLOAT,
    @manufacturer VARCHAR(50)
)
RETURNS @products TABLE
(
    masp VARCHAR(10),
    mahangsx VARCHAR(10),
    tensp NVARCHAR(50),
    soluong INT,
    mausac NVARCHAR(50),
    giaban FLOAT,
    donvitinh NVARCHAR(20),
    mota NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO @products
    SELECT s.masp, s.mahangsx, s.tensp, s.soluong, s.mausac, s.giaban, s.donvitinh, s.mota
    FROM Sanpham s
    INNER JOIN Hangsx h ON s.mahangsx = h.mahangsx
    WHERE s.giaban >= @minPrice AND s.giaban <= @maxPrice AND h.tenhang = @manufacturer
    RETURN
END
GO
--- lab 6.10 ---

GO
CREATE FUNCTION Lab6_Cau10
(
)
RETURNS TABLE
AS
RETURN
(
    SELECT sp.Masp, sp.Tensp, sp.Mausac, sp.Giaban, sp.Donvitinh, sp.Mota, hs.Tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hs ON sp.Mahangsx = hs.Mahangsx
)
GO

GO
SELECT * FROM Lab6_Cau10()
GO