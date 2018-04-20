/* Môn: Cơ sở dữ liệu
   Lab05_QLSanXuat
   Thực hiện: La Quốc Thắng
   Ngày: 20/4/2018 
*/
---------------------------------------------------------------------------------------

create database Lab05_QLSanXuat_1610207
use Lab05_QLSanXuat_1610207;

go
create table ToSanXuat
(MaTSX nchar(4) primary key,
TenTSX nchar(5) not null);

go
create table CongNhan
(MaCN nchar(5) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
Phai nchar(3) not null,
NgaySinh date,
MaTSX nchar(4) references ToSanXuat(MaTSX));

go
create table SanPham
(MaSP nchar(5) primary key,
TenSP nvarchar(20) not null,
DVTinh nchar(3) not null,
TienCong integer not null);

go
create table ThanhPham
(MaCN nchar(5) foreign key references CongNhan(MaCN),
MaSP nchar(5) foreign key references SanPham(MaSP),
Ngay date not null,
SoLuong tinyint not null,
constraint PK Primary key (MACN, MASP, Ngay));


---------------------------------------XÂY DỰNG THỦ TỤC NHẬP LIỆU------------------------------------

create proc usp_ThemToSanXuat
@MaTSX nchar(4), @TenTSX nchar(5)
as
Insert into ToSanXuat values (@MaTSX, @TenTSX)
----------------------------------------------------
create proc úp_ThemCongNhan
@MaCN nchar(5), @Ho nvarchar(20), @Ten nchar(10), @Phai nchar(3), @NgaySinh date, @MaTSX nchar(4)
as
Insert into CongNhan values (@MaCN, @Ho, @Ten, @Phai, @NgaySinh, @MaTSX)
----------------------------------------------------
create proc usp_ThemSanPham
@MaSP nchar(5), @TenSP nvarchar(20), @DVTinh nchar(3), @TienCong integer
as
Insert into SanPham values (@MaSP, @TenSP, @DVTinh, @TienCong)
----------------------------------------------------
create proc usp_ThemThanhPham
@MaCN nchar(5), @MaSP nchar(5), @Ngay date, @SoLuong tinyint
as
Insert into ThanhPham values (@MaCN, @MaSP, @Ngay, @SoLuong)

-----------------------------------------------------------------------------------------------------
Insert into ToSanXuat Values('TS01',N'Tổ 1')
Insert into ToSanXuat Values('TS02',N'Tổ 2')

set dateformat mdy
Insert into CongNhan values('CN001',N'Nguyễn Trường','An','Nam','5/12/1981','TS01')
Insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','6/4/1980','TS01')
Insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành','Nam','5/4/1981','TS02')
Insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh','Nam','2/15/1980','TS02')
Insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','12/3/1981','TS01')
Insert into CongNhan values('CN006',N'Lê Thị','Lan',N'Nữ','','TS02')

Insert into SanPham Values('SP001',N'Nồi đất',N'cái','10000')
Insert into SanPham Values('SP002',N'Chén',N'cái','2000')
Insert into SanPham Values('SP003',N'Bình gốm nhỏ',N'cái','20000')
Insert into SanPham Values('SP004',N'Bình gốm lớn',N'cái','25000')

Insert into ThanhPham Values('CN001','SP001','2/1/2007','10')
Insert into ThanhPham Values('CN001','SP001','2/20/2007','30')
Insert into ThanhPham Values('CN001','SP003','2/14/2007','15')
Insert into ThanhPham Values('CN002','SP001','2/1/2007','5')
Insert into ThanhPham Values('CN002','SP004','2/13/2007','10')
Insert into ThanhPham Values('CN003','SP001','1/15/2007','20')
Insert into ThanhPham Values('CN003','SP002','1/10/2007','50')
Insert into ThanhPham Values('CN003','SP004','2/14/2007','15')
Insert into ThanhPham Values('CN004','SP002','1/30/2007','100')
Insert into ThanhPham Values('CN004','SP003','1/12/2007','10')
Insert into ThanhPham Values('CN005','SP002','1/12/2007','100')
Insert into ThanhPham Values('CN005','SP003','2/1/2007','50')

select *
from CongNhan

select *
from ToSanXuat

select *
from SanPham

select *
from ThanhPham

--Phan bai tap
--Query 1: Liệt kê các công nhân theo tổ sản xuất và xếp thứ tự tăng dần của tên tổ sản xuất , tên công nhân
select a.TenTSX, b.Ho+' '+b.Ten as HoTen, b.NgaySinh, b.Phai
from ToSanXuat a, CongNhan b
where a.MaTSX=b.MaTSX
order by a.TenTSX, b.Ten

--Query 2: Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được và xếp theo thứ tự tăng dần của ngày
select a.TenSP, b.Ngay, b.SoLuong, b.SoLuong*a.TienCong as ThanhTien
from SanPham a, ThanhPham b, CongNhan c
where a.MaSP=b.MaSP and c.MaCN=b.MaCN and Ho+' '+Ten=N'Nguyễn Trường An'
order by b.Ngay

--Query 3: Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
select a.MaCN, a.Ho+' '+a.Ten as HoTen
from CongNhan a
where a.MaCN not in (select c.MaCN
					from SanPham b, ThanhPham c
					where b.MaSP=c.MaSP and b.TenSP=N'Bình gốm lớn')
--Query 4: Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'
select a.MaCN, Ho+' '+Ten as HoTen
from CongNhan a, ThanhPham b, SanPham c
where a.MaCN=b.MaCN and b.MaSP =c.MaSP and c.TenSP=N'Nồi đất' and a.MaCN in 
		(select d.MaCN
		from ThanhPham d, SanPham e
		where d.MaSP=e.MaSP and e.TenSP=N'Bình gốm nhỏ')
group by a.MaCN, Ho, Ten

--Query 5: Thống kê số lượng công nhân theo từng tổ sản xuất
select b.MaTSX, TenTSX, COUNT(MaCN)
from CongNhan a, ToSanXuat b
where a.MaTSX=b.MaTSX
group by b.MaTSX, b.TenTSX

--Query 6: Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được
select Ho, Ten, TenSP, sum(SoLuong) as TongSLThanhPham, SUM(TienCong*SoLuong)
from ThanhPham a, CongNhan b, SanPham c
where a.MaCN=b.MaCN and c.MaSP=a.MaSP
group by Ho, Ten, c.TenSP

--Query 7:Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2006
select sum(SoLuong*TienCong) as ThanhTien
from ThanhPham a, SanPham b
where b.MaSP=a.MaSP and month(a.Ngay)=1 and year(a.Ngay)='2007'

--Query 8:Cho biết sản phẩm sản xuất nhiều nhất trong tháng 2 năm 2007
select TenSP
from ThanhPham a, SanPham b
where a.MaSP=b.MaSP and MONTH(a.Ngay)=2 and year(a.Ngay)=2007
group by b.MaSp, TenSP
having sum(SoLuong)>=all(select sum(SoLuong)
						from ThanhPham c, SanPham d
						where c.MaSP=d.MaSP and month(Ngay)=2 and year(Ngay)=2007
						group by d.MaSP)

--Query 9: Cho biết công nhân sản xuất nhiều chén nhất
SELECT B.MaCN,Ho+' ' + Ten as HoTen
FROM SanPham A,ThanhPham B,CongNhan E
WHERE A.MaSP=B.MaSP AND A.TenSP = N'Chén' AND B.MACN=E.MACN
GROUP BY B.MaCN, Ho,Ten
HAVING SUM(SoLuong)>=ALL(SELECT SUM(SoLuong) AS TONGSOLUONG 
						FROM SanPham C,ThanhPham D
						WHERE C.MaSP=D.MaSP AND C.TenSP = N'Chén'
						GROUP BY MaCN)

--Query 10: Tiền công tháng 2 năm 2007 của công nhân viên có mã 'CN0002'
SELECT MaCN,SUM(TIEN) AS TIENCONG
FROM(select MaCN,A.MaSP AS MASP,(SoLuong*TienCong) AS TIEN
	from ThanhPham AS A,SanPham AS B
	WHERE A.MaSP = B.MaSP AND MaCN='CN002' AND MONTH(NGAY)=2 AND YEAR(NGAY)=2007
	GROUP BY MaCN,A.MaSP,TienCong,SoLuong) AS D
GROUP BY MaCN

--Query 11: Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
select MaCN,COUNT(MaSP)
from ThanhPham
Group By MaCN
Having COUNT(MaSP)>=3

--Query 12:Cấp nhật giá tiền công của các loại bình gốm thêm 1000
UPDATE SanPham
set TienCong=(TienCong+1000)
where TenSP like 'Bình gốm %'