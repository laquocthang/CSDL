-- Tên: Lê Thành Đạt
-- MSSV: 1512848
-- Lớp: CTK39

create database Lab12_QLDatBao
go
use Lab12_QLDatBao
go
create table Bao_TChi
(
	Ma_BaoTChi char(4) primary key,
	Ten nvarchar(20) not null,
	DinhKy nvarchar(15) not null,
	SoLuong smallint check(SoLuong > 0),
	GiaBan smallint check(GiaBan > 0)
)	
go
create table PhatHanhBao
(
	Ma_BaoTChi char(4) references Bao_TChi(Ma_BaoTChi),
	So_BaoTChi smallint not null check(So_BaoTChi > 0),
	primary key(Ma_BaoTChi, So_BaoTChi),
	NgayPH date not null 

)	
go
create table KH_Hang
(
	MaKH char(4) primary key,
	Ten_KH nvarchar(10) not null,
	DiaChi_KH nvarchar(10) not null
)	
go
create table DatBao
(
	MaKH char(4) references KH_Hang(MaKH),
	Ma_BaoTChi char(4) references Bao_TChi(Ma_BaoTChi),
	primary key(MaKH, Ma_BaoTChi),
	SL_Mua smallint check(SL_Mua > 0),
	Ngay date not null
)

-- Nhập liệu

insert into Bao_TChi values('TT01',N'Tuổi trẻ',N'Nhật báo','1000','1500')
insert into Bao_TChi values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san','3000','6000')
insert into Bao_TChi values('TN01',N'Thanh niên',N'Nhật báo','1000','2000')
insert into Bao_TChi values('PN01',N'Phụ nữ',N'Tuần báo','2000','4000')
insert into Bao_TChi values('PN02',N'Phụ nữ',N'Nhật báo','1000','2000')
select * from Bao_TChi

set dateformat dmy
insert into PhatHanhBao values('TT01','123','15/12/2005')
insert into PhatHanhBao values('KT01','70','15/12/2005')
insert into PhatHanhBao values('TT01','124','16/12/2005')
insert into PhatHanhBao values('TN01','256','17/12/2005')
insert into PhatHanhBao values('PN01','45','23/12/2005')
insert into PhatHanhBao values('PN02','111','18/12/2005')
insert into PhatHanhBao values('PN02','112','19/12/2005')
insert into PhatHanhBao values('TT01','125','17/12/2005')
insert into PhatHanhBao values('PN01','46','30/12/2005')
select * from PhatHanhBao

insert into KH_Hang values('KH01',N'LAN','2 NCT')
insert into KH_Hang values('KH02',N'NAM','32 THĐ')
insert into KH_Hang values('KH03',N'NGỌC','16 LHP')
select * from KH_Hang

set dateformat dmy
insert into DatBao values('KH01','TT01','100','12/1/2000')
insert into DatBao values('KH02','TN01','150','1/5/2001')
insert into DatBao values('KH01','PN01','200','25/6/2001')
insert into DatBao values('KH03','KT01','50','17/3/2002')
insert into DatBao values('KH03','PN02','200','26/8/2003')
insert into DatBao values('KH02','TT01','250','15/1/2004')
insert into DatBao values('KH01','KT01','300','14/10/2004')
select * from DatBao

--1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
SELECT Ma_BaoTChi,Ten,GiaBan 
FROM Bao_TChi 
WHERE DinhKy like 'T%';
--2) Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
SELECT *
FROM Bao_TChi 
WHERE Ma_BaoTChi like 'PN%';
--3) Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
SELECT DISTINCT Ten_KH
FROM KH_Hang K,DatBao D
WHERE K.MaKH=D.MaKH and D.Ma_BaoTChi LIKE 'PN%'
--4) Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
SELECT Ten_KH
FROM KH_Hang K,DatBao D
WHERE K.MaKH=D.MaKH and D.Ma_BaoTChi LIKE 'PN%'
--5) Cho biết các khách hàng không đặt mua báo thanh niên.
SELECT DISTINCT Ten_KH
FROM KH_Hang K,DatBao D
WHERE K.MaKH=D.MaKH and D.Ma_BaoTChi NOT LIKE 'TN01'
--6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
SELECT MaKH,SUM(SL_Mua)
FROM DatBao
Group by MaKH
--7) Cho biết số khách hàng đặt mua báo trong năm 2004.
SELECT MaKH
FROM DatBao 
WHERE year(Ngay)=2004
--8) Cho biết thông tin đặt mua báo của các khách hàng (TENKH, TEN, DINH_KY, SL_MUA, SOTIEN), trong đó SOTIEN=SL_MUA*DONGIA. 
Select K.Ten_KH,B.Ten,B.DinhKy,D.SL_Mua,(D.SL_Mua*B.GiaBan) as 'Số tiền'
From KH_Hang K, DatBao D,Bao_TChi B
Where K.MaKH = D.MaKH and B.Ma_BaoTChi = D.Ma_BaoTChi
--9) Cho biết các tờ báo, tạp chí (TEN, DINHKY) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
Select B.Ten,B.DinhKy,SUM(D.SL_Mua) As 'Số Lượng Mua'
From DatBao D,Bao_TChi B
Where B.Ma_BaoTChi = D.Ma_BaoTChi
Group by B.Ten,B.DinhKy
--10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
Select Ten
From Bao_TChi 
Where Ma_BaoTChi LIKE 'HS%'
--11) Cho biết những tờ báo không có người đặt mua.
Select A.Ten
From Bao_TChi A,DatBao B 
Where A.Ma_BaoTChi = B.Ma_BaoTChi AND B.Ma_BaoTChi NOT IN (Select B.Ma_BaoTChi
														    From DatBao B 
														    Group By B.Ma_BaoTChi)
--12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
Select B.Ten,B.DinhKy
From DatBao D,Bao_TChi B
Where B.Ma_BaoTChi = D.Ma_BaoTChi AND D.SL_Mua IN (SELECT MAX(D.SL_Mua)
													FROM DatBao D)
--13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
Select A.Ten_KH
From KH_Hang A,DatBao B
Where A.MaKH =B.MaKH AND B.SL_Mua IN (SELECT MAX(B.SL_Mua)
										            FROM DatBao B)
--14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
Select *
From Bao_TChi
Where DinhKy LIKE 'B%'
--15) Cho biết các tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.
Select A.Ten
From Bao_TChi A,DatBao B
Where A.Ma_BaoTChi = B.Ma_BaoTChi AND B.MaKH='KH01'and B.Ma_BaoTChi IN (SELECT C.Ma_BaoTChi
																		 FROM DatBao C
																		Where C.MaKH='KH02') and B.Ma_BaoTChi IN (SELECT D.Ma_BaoTChi
																													FROM DatBao D
																													Where D.MaKH='KH03')