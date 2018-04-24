/*---------------------------------------------------------------------------------------
 Môn: Cơ sở dữ liệu
   Lab05_QLSanXuat
   Thực hiện: La Quốc Thắng
   Ngày: 23/4/2018 
*/---------------------------------------------------------------------------------------

create database Lab05_QLSanXuat_1610207
use Lab05_QLSanXuat_1610207;
go

create table ToSanXuat
(
	MaTSX nchar(4) primary key,
	TenTSX nchar(5) not null
);
go

create table CongNhan
(
	MaCN nchar(5) primary key,
	Ho nvarchar(20) not null,
	Ten nchar(10) not null,
	Phai nchar(3) not null,
	NgaySinh date,
	MaTSX nchar(4) references ToSanXuat(MaTSX)
);
go

create table SanPham
(
	MaSP nchar(5) primary key,
	TenSP nvarchar(20) not null,
	DVTinh nchar(3) not null,
	TienCong integer not null
);
go

create table ThanhPham
(
	MaCN nchar(5) foreign key references CongNhan(MaCN),
	MaSP nchar(5) foreign key references SanPham(MaSP),
	Ngay date not null,
	SoLuong tinyint not null,
	constraint PK Primary key (MACN, MASP, Ngay)
);
go

---------------------------------------CÂU 1: CÀI ĐẶT CÁC RÀNG BUỘC TOÀN VẸN------------------------------------
--RB1: Công nhân phải đủ 18 tuổi khi vào làm
drop trigger tg_CongNhanDu18Tuoi
create trigger tg_CongNhanDu18Tuoi
on CongNhan for insert, update
as
if UPDATE(NgaySinh)
	if exists (select * from inserted where DATEDIFF(year, NgaySinh, GETDATE()) < 18)
		begin
			raiserror (N'Công nhân phải đủ 18 tuổi thì mới vào làm',15,1)
			rollback tran
		end

/*Kiểm tra
exec usp_ThemCongNhan 'CN006',N'Lê Thị','Lan',N'Nữ','1/1/2002','TS02'
*/
go

--RB2: Tên tổ sản xuất phải phân biệt
	alter table ToSanXuat add
	constraint TSX_PhanBiet unique (TenTSX)

/*Kiểm tra
exec usp_ThemToSanXuat 'TS03',N'Tổ 1'
*/
go

--RB3: Tên sản phẩm phải khác nhau
	alter table SanPham add
	constraint TenSP_PhanBiet unique (TenSP)

/*Kiểm tra
exec usp_ThemSanPham 'SP005',N'Chén',N'cái',2000
*/
go

--RB4: Tiền công > 0, số lượng phải > 0
create trigger tg_TienCongDuong
on SanPham for insert, update
as
if update(TienCong)
	if exists (select * from inserted where TienCong <= 0)
		begin
			raiserror (N'Tiền công phải lớn hơn không',15,1)
			rollback tran
		end

/*Kiểm tra
update SanPham
set TienCong = 0
where MaSP = 'SP001'
*/
go

create trigger tg_SoLuongDuong
on ThanhPham for insert, update
as
if update (SoLuong)
	if exists (select *	from inserted where SoLuong <= 0)
		begin
			raiserror (N'Số lượng phải lớn hơn không',15,1)
			rollback tran
		end

/*Kiểm tra
update ThanhPham
set SoLuong = 0
where MaCN = 'CN001' and MaSP = 'SP001' and Ngay = '02/01/2007'
*/
go

--RB5: Ngày sản xuất thành phẩm phải thuộc năm hiện hành và không được lớn hơn ngày hiện tại
create trigger tg_NgaySXThanhPham
on ThanhPham for insert, update
as
if update (Ngay)
	if exists (select * from inserted where year(Ngay) <> year(GETDATE()) and GETDATE() < Ngay)
		begin
			raiserror (N'Ngày sản xuất thành phẩm phải thuộc năm hiện hành và không được lớn hơn ngày hiện tại',15,1)
			rollback tran
		end
go

---------------------------------------CÂU 3: XÂY DỰNG THỦ TỤC NHẬP LIỆU------------------------------------

create proc usp_ThemToSanXuat
	@MaTSX nchar(4),
	@TenTSX nchar(5)
as
if exists (select * from ToSanXuat where MaTSX = @MaTSX)
	print N'Đã tồn tại tổ sản xuất này trong CSDL'
else
	Insert into ToSanXuat values (@MaTSX, @TenTSX)
go
----------------------------------------------------
create proc usp_ThemCongNhan
	@MaCN nchar(5),
	@Ho nvarchar(20),
	@Ten nchar(10),
	@Phai nchar(3),
	@NgaySinh date,
	@MaTSX nchar(4)
as
if exists (select * from CongNhan where MaCN = @MaCN)
	print N'Đã tồn tại công nhân này trong CSDL'
else
	Insert into CongNhan values (@MaCN, @Ho, @Ten, @Phai, @NgaySinh, @MaTSX)
go
----------------------------------------------------
create proc usp_ThemSanPham
	@MaSP nchar(5),
	@TenSP nvarchar(20),
	@DVTinh nchar(3),
	@TienCong integer
as
if exists (select * from SanPham where MaSP = @MaSP)
	print N'Đã tồn tại sản phẩm này trong CSDL'
else
	Insert into SanPham values (@MaSP, @TenSP, @DVTinh, @TienCong)
go
----------------------------------------------------
create proc usp_ThemThanhPham
	@MaCN nchar(5),
	@MaSP nchar(5),
	@Ngay date,
	@SoLuong tinyint
as
if exists (select * from ThanhPham where MaCN = @MaCN and MaSP = @MaSP and Ngay = @Ngay)
	print N'Đã tồn tại thành phẩm này trong CSDL'
else
	Insert into ThanhPham values (@MaCN, @MaSP, @Ngay, @SoLuong)
go
--Tạo thủ tục tính tiền công hàng tháng cho công nhân với tháng cần tính tiền là tham số input
create proc tg_TinhTienCong
	@Thang tinyint
as
	select c.MaCN, Ho, Ten, Phai, NgaySinh, MaTSX, sum(SoLuong * TienCong) as TienCong
	from SanPham s, ThanhPham t, CongNhan c
	where s.MaSP = t.MaSP and c.MaCN = t.MaCN and month(Ngay) = @Thang
	group by c.MaCN, Ho, Ten, Phai, NgaySinh, MaTSX

/*Kiểm tra
exec tg_TinhTienCong 2
*/
go
-----------------------------------------------------------------------------------------------------
exec usp_ThemToSanXuat 'TS01',N'Tổ 1'
exec usp_ThemToSanXuat 'TS02',N'Tổ 2'

set dateformat mdy
exec usp_ThemCongNhan 'CN001',N'Nguyễn Trường','An','Nam','5/12/1981','TS01'
exec usp_ThemCongNhan 'CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','6/4/1980','TS01'
exec usp_ThemCongNhan 'CN003',N'Nguyễn Công',N'Thành','Nam','5/4/1981','TS02'
exec usp_ThemCongNhan 'CN004',N'Võ Hữu',N'Hạnh','Nam','2/15/1980','TS02'
exec usp_ThemCongNhan 'CN005',N'Lý Thanh',N'Hân',N'Nữ','12/3/1981','TS01'

exec usp_ThemSanPham 'SP001',N'Nồi đất',N'cái','10000'
exec usp_ThemSanPham 'SP002',N'Chén',N'cái','2000'
exec usp_ThemSanPham 'SP003',N'Bình gốm nhỏ',N'cái','20000'
exec usp_ThemSanPham 'SP004',N'Bình gốm lớn',N'cái','25000'

exec usp_ThemThanhPham 'CN001','SP001','2/1/2007','10'
exec usp_ThemThanhPham 'CN001','SP001','2/20/2007','30'
exec usp_ThemThanhPham 'CN001','SP003','2/14/2007','15'
exec usp_ThemThanhPham 'CN002','SP001','2/1/2007','5'
exec usp_ThemThanhPham 'CN002','SP004','2/13/2007','10'
exec usp_ThemThanhPham 'CN003','SP001','1/15/2007','20'
exec usp_ThemThanhPham 'CN003','SP002','1/10/2007','50'
exec usp_ThemThanhPham 'CN003','SP004','2/14/2007','15'
exec usp_ThemThanhPham 'CN004','SP002','1/30/2007','100'
exec usp_ThemThanhPham 'CN004','SP003','1/12/2007','10'
exec usp_ThemThanhPham 'CN005','SP002','1/12/2007','100'
exec usp_ThemThanhPham 'CN005','SP003','2/1/2007','50'

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
go

--Query 2: Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được và xếp theo thứ tự tăng dần của ngày
select a.TenSP, b.Ngay, b.SoLuong, b.SoLuong*a.TienCong as ThanhTien
from SanPham a, ThanhPham b, CongNhan c
where a.MaSP=b.MaSP and c.MaCN=b.MaCN and Ho+' '+Ten=N'Nguyễn Trường An'
order by b.Ngay
go

--Query 3: Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
select a.MaCN, a.Ho+' '+a.Ten as HoTen
from CongNhan a
where a.MaCN not in (select c.MaCN
from SanPham b, ThanhPham c
where b.MaSP=c.MaSP and b.TenSP=N'Bình gốm lớn')
go

--Query 4: Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'
select a.MaCN, Ho+' '+Ten as HoTen
from CongNhan a, ThanhPham b, SanPham c
where a.MaCN=b.MaCN and b.MaSP =c.MaSP and c.TenSP=N'Nồi đất' and a.MaCN in 
		(select d.MaCN
	from ThanhPham d, SanPham e
	where d.MaSP=e.MaSP and e.TenSP=N'Bình gốm nhỏ')
group by a.MaCN, Ho, Ten
go

--Query 5: Thống kê số lượng công nhân theo từng tổ sản xuất
select b.MaTSX, TenTSX, COUNT(MaCN)
from CongNhan a, ToSanXuat b
where a.MaTSX=b.MaTSX
group by b.MaTSX, b.TenTSX
go

--Query 6: Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được
select Ho, Ten, TenSP, sum(SoLuong) as TongSLThanhPham, SUM(TienCong*SoLuong)
from ThanhPham a, CongNhan b, SanPham c
where a.MaCN=b.MaCN and c.MaSP=a.MaSP
group by Ho, Ten, c.TenSP
go

--Query 7:Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2006
select sum(SoLuong*TienCong) as ThanhTien
from ThanhPham a, SanPham b
where b.MaSP=a.MaSP and month(a.Ngay)=1 and year(a.Ngay)='2007'
go

--Query 8:Cho biết sản phẩm sản xuất nhiều nhất trong tháng 2 năm 2007
select TenSP
from ThanhPham a, SanPham b
where a.MaSP=b.MaSP and MONTH(a.Ngay)=2 and year(a.Ngay)=2007
group by b.MaSp, TenSP
having sum(SoLuong)>=all(select sum(SoLuong)
from ThanhPham c, SanPham d
where c.MaSP=d.MaSP and month(Ngay)=2 and year(Ngay)=2007
group by d.MaSP)
go

--Query 9: Cho biết công nhân sản xuất nhiều chén nhất
SELECT B.MaCN, Ho+' ' + Ten as HoTen
FROM SanPham A, ThanhPham B, CongNhan E
WHERE A.MaSP=B.MaSP AND A.TenSP = N'Chén' AND B.MACN=E.MACN
GROUP BY B.MaCN, Ho,Ten
HAVING SUM(SoLuong)>=ALL(SELECT SUM(SoLuong) AS TONGSOLUONG
FROM SanPham C, ThanhPham D
WHERE C.MaSP=D.MaSP AND C.TenSP = N'Chén'
GROUP BY MaCN)
go

--Query 10: Tiền công tháng 2 năm 2007 của công nhân viên có mã 'CN0002'
SELECT MaCN, SUM(TIEN) AS TIENCONG
FROM(select MaCN, A.MaSP AS MASP, (SoLuong*TienCong) AS TIEN
	from ThanhPham AS A, SanPham AS B
	WHERE A.MaSP = B.MaSP AND MaCN='CN002' AND MONTH(NGAY)=2 AND YEAR(NGAY)=2007
	GROUP BY MaCN,A.MaSP,TienCong,SoLuong) AS D
GROUP BY MaCN
go

--Query 11: Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
select MaCN, COUNT(MaSP)
from ThanhPham
Group By MaCN
Having COUNT(MaSP)>=3
go

--Query 12:Cấp nhật giá tiền công của các loại bình gốm thêm 1000
UPDATE SanPham
set TienCong=(TienCong+1000)
where TenSP like 'Bình gốm %'
go