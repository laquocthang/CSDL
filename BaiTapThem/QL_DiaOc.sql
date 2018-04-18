/*-----------------------------------------------
Bài lab: Quản lý địa ốc
Ngày thực hiện: 13/4/2018
Người thực hiện: La Quốc Thắng
MSSV:1610207
------------------------------------------------*/

create database QL_DiaOc

use QL_DiaOC

drop table  PhieuGiaHan
go
drop table  PhieuThu
go
drop table  CT_PDK
go
drop table  PhieuDangKy
go
drop table  DichVu
go
drop table  DiaOc
go
drop table  LoaiDiaOc
go
drop table  NguoiBan

go 
create table NguoiBan
(
	MaNB char(9) primary key,
	HoTen nvarchar(50) not null,
	DiaChi nvarchar(70) not null,
	SoDT char(10)
)

go
create table LoaiDiaOc
(
	MaLDO int primary key,
	TenLDO nvarchar(50) not null
)

go
create table DiaOc
(
	MaDO varchar(9) primary key,
	So varchar(10) not null,
	Duong nvarchar(30) not null,
	Phuong varchar(30) not null,
	Quan varchar(30) not null,
	DTDat real not null,
	DTXD real not null,
	Huong nvarchar(10) not null,
	ViTri nvarchar(20) not null,
	MoTa varchar(100),
	MaLDO int references LoaiDiaOc(MaLDO)
)

go
create table DichVu
(
	MaDV int primary key,
	TenDV nvarchar(50) not null,
	TienDV money
)

go
create table PhieuDangKy
(
	MaPDK varchar(10) primary key,
	NgayDK date not null,
	TongSoDV int not null,
	TongTien money not null,
	MaNB char(9) references NguoiBan(MaNB)
)

go
create table CT_PDK
(
	MaPDK varchar(10) references PhieuDangKy(MaPDK),
	MaDO varchar(9) references DiaOc(MaDO),
	MaDV int references DichVu(MaDV),
	TuNgay date not null,
	DenNgay date not null,
	SoTien money not null,
	primary key(MaPDK, MaDO, MaDV)
)

go
create table PhieuThu
(
	MaPT varchar(10) primary key,
	PhieuDK varchar(10) references PhieuDangKy(MaPDK),
	NgayThu date not null,
	LanThu int not null,
	SoTien money not null,
	MaPTGoc varchar(10)
)

go
create table PhieuGiaHan
(
	MaPGH varchar(10) primary key,
	PhieuDK varchar(10) references PhieuDangKy(MaPDK),
	MaDO varchar(9) references DiaOc(MaDO),
	MaDV int references DichVu(MaDV),
	NgayGiaHan date not null,
	TuNgay date not null,
	DenNgay date not null
)

insert into NguoiBan values ('111222333',N'Nguyễn Tường Vân',N'330/2 Lê Hồng Phong, Quận 5','8111222')
insert into NguoiBan values ('222333444',N'Trần Thanh Tùng',N'111 Trương Định, Quận 3','8222333')
insert into NguoiBan values ('333444555',N'Nguyễn Ngọc Nga',N'315 An Dương Vương, Quận 5','8333444')

insert into LoaiDiaOc values ('1',N'Nhà và đất')
insert into LoaiDiaOc values ('2',N'Đất')

insert into DiaOc values ('DO111','731',N'Trần Hưng Đạo','7','1','1000','800',N'Đông',N'Mặt tiền','','1')
insert into DiaOc values ('DO222','638',N'Nguyễn Văn Cừ','5','5','500','450',N'Tây',N'Mặt tiền','','2')
insert into DiaOc values ('DO333','332/1',N'Nguyễn Thái Học','9','1','100','100',N'Nam',N'Hẻm','','1')
insert into DiaOc values ('DO444','980',N'Lê Hồng Phong','4','5','450','450',N'Bắc',N'Mặt tiền','','2')
insert into DiaOc values ('DO555','111/45',N'Trương Định','10','3','85','85',N'Đông Nam',N'Hẻm','','1')

insert into DichVu values ('1',N'Tờ bướm quảng cáo 200 tờ','200000')
insert into DichVu values ('2',N'Tờ bướm quảng cáo 100 tờ','100000')
insert into DichVu values ('3',N'Quảng cáo trên báo','300000')

set dateformat dmy
insert into PhieuDangKy values ('PDK111','01/05/2005','1','1040000','111222333')
insert into PhieuDangKy values ('PDK222','19/10/2005','2','600000','222333444')
insert into PhieuDangKy values ('PDK333','07/09/2005','3','1000000','333444555')

insert into CT_PDK values ('PDK111','DO111','1','05/05/2005','05/07/2005','400000')
insert into CT_PDK values ('PDK222','DO222','1','01/11/2005','31/12/2005','400000')
insert into CT_PDK values ('PDK222','DO333','2','01/11/2005','31/12/2005','200000')
insert into CT_PDK values ('PDK333','DO444','1','15/09/2005','15/10/2005','200000')
insert into CT_PDK values ('PDK333','DO444','2','15/09/2005','15/10/2005','100000')
insert into CT_PDK values ('PDK333','DO555','3','15/09/2005','15/10/2005','300000')

insert into PhieuThu values ('PT111','PDK111','01/05/2005','1','400000',NULL)
insert into PhieuThu values ('PT222','PDK222','19/10/2005','1','400000',NULL)
insert into PhieuThu values ('PT333',NULL,'15/12/2005','2','200000','PT222')
insert into PhieuThu values ('PT444',NULL,'05/07/2005','2','320000','PT111')
insert into PhieuThu values ('PT555',NULL,'01/11/2005','3','320000','PT111')
insert into PhieuThu values ('PT666','PDK333','07/09/2005','1','600000',NULL)
insert into PhieuThu values ('PT777',NULL,'15/11/2005','2','400000','PT666')

insert into PhieuGiaHan values ('PGH111','PDK111','DO111','1','05/07/2005','05/07/2005','05/09/2005')
insert into PhieuGiaHan values ('PGH222','PDK111','DO111','1','01/11/2005','01/11/2005','31/12/2005')
insert into PhieuGiaHan values ('PGH333','PDK333','DO444','1','15/11/2005','15/11/2005','15/12/2005')
insert into PhieuGiaHan values ('PGH444','PDK333','DO555','3','15/11/2005','15/11/2005','15/12/2005')

select * from NguoiBan

select * from LoaiDiaOc

select * from DiaOc

select * from DichVu

select * from PhieuDangKy

select * from CT_PDK

select * from PhieuThu

select * from PhieuGiaHan

--Câu 1: Cho biết danh sách những người bán có đăng ký quảng cáo với thời hạn sử dụng từ tháng 8 đến tháng 10 năm 2006
select distinct n.MaNB, HoTen, DiaChi
from NguoiBan n, PhieuDangKy p, CT_PDK c
where n.MaNB=p.MaNB and p.MaPDK=c.MaPDK and TuNgay>='1/8/2005' and DenNgay<'1/11/2005'

--Câu 2: Cho biết danh  sách những người bán có đăng ký quảng cáo với ngày đăng ký nằm trong tháng 10 năm 2005
select distinct n.MaNB, HoTen, DiaChi
from NguoiBan n, PhieuDangKy p
where n.MaNB=p.MaNB and NgayDK between '1/10/2005' and '31/10/2005'


--Câu 3: Cho biết danh sách những người bán lập phiếu gia hạn vào tháng 11 năm 2005
select distinct n.MaNB, HoTen, DiaChi
from NguoiBan n, PhieuDangKy p, PhieuGiaHan g
where n.MaNB=p.MaNB and p.MaPDK=g.PhieuDK and month(NgayGiaHan)=11 and YEAR(NgayGiaHan)=2005

--Câu 4: Cho biết danh sách những người bán địa ốc có đăng ký dịch vụ quảng cáo trên báo
select distinct n.MaNB, HoTen, DiaChi, SoDT
from NguoiBan n, PhieuDangKy p, CT_PDK c
where n.MaNB=p.MaNB and p.MaPDK=c.MaPDK and MaDV=3

--Câu 5: Với mỗi người bán, cho biết lần gia hạn lâu nhất của mỗi lần đăng ký là bao nhiêu ngày
select distinct HoTen, DATEDIFF(day,TuNgay,DenNgay) as SoNgayGiaHan
from NguoiBan n, PhieuDangKy p, PhieuGiaHan g
where n.MaNB=p.MaNB and p.MaPDK=g.PhieuDK and datediff(day,TuNgay,DenNgay)=(select max(datediff(day,TuNgay,DenNgay))
	from PhieuGiaHan)

--Câu 6: Với mỗi địa ốc có đăng ký quảng cáo trong năm 2005, cho biết lần đăng ký quảng cáo lâu nhất trong năm 2005 của địa ốc đó kéo dài bao nhiêu ngày
select distinct d.MaDO, So, Duong, Phuong, Quan, DATEDIFF(DAY,TuNgay,DenNgay) as SoNgay
from DiaOc d, CT_PDK c, PhieuDangKy p
where d.MaDO = c.MaDO and c.MaPDK=p.MaPDK and YEAR(NgayDK)=2005 and DATEDIFF(day,TuNgay,DenNgay)=(select MAX(DATEDIFF(day,TuNgay,DenNgay))
	from CT_PDK)

--Câu 7: Cho biết danh sách những người bán đăng ký quảng cáo nhiều địa ốc khác nhau nhất trong năm 2005
select distinct n.MaNB, HoTen, DiaChi
from NguoiBan n, PhieuDangKy p, CT_PDK c
where n.MaNB=p.MaNB and p.MaPDK=c.MaPDK 
group by n.MaNB, HoTen, DiaChi
having count(MaDO)>=all (select COUNT(distinct MaDO)
	from CT_PDK
	group by MaPDK)


--Câu 8: Với mỗi người bán cho biết họ đã thực hiện đăng ký quảng cáo bao nhiêu lần
select distinct n.MaNB, HoTen, DiaChi, count(c.MaDV) as SoLanDK
from NguoiBan n, PhieuDangKy p, ((select MaPDK, MaDV
	from CT_PDK) UNION all(select PhieuDK as MaPDK, MaDV
		from PhieuGiaHan)) as c
where n.MaNB=p.MaNB and p.MaPDK=c.MaPDK
group by n.MaNB, HoTen, DiaChi

--Câu 9: Với mỗi địa ốc cho biết nó đã được đăng ký quảng cáo bao nhiêu lần
select distinct d.MaDO, So, Duong, Phuong, Quan, count(c.MaDV) as SoLanDK
from DiaOc d, ((select MaDO, MaDV
	from CT_PDK) UNION all(select MaDO, MaDV
		from PhieuGiaHan)) as c
where d.MaDO=c.MaDO
group by d.MaDO, So, Duong, Phuong, Quan

--Câu 10: Cho biết danh sách những người bán đăng kí quảng cáo nhiều địa ốc ở quận 5 nhất
select HoTen, count(c.MaDO) as Số_lượng_đăng_ký
from NguoiBan a,PhieuDangKy b, CT_PDK c
where a.MaNB = b.MaNB and b.MaPDK = c.MaPDK and DiaChi like N'%quận 5'
group by HoTen
having count(c.MaDO) >= all(select count(f.MaDO) 
	from NguoiBan d,PhieuDangKy e,CT_PDK f
	where d.MaNB = e.MaNB and e.MaPDK = f.MaPDK and DiaChi like N'%quận 5'
	group by f.MaPDK)

--Câu 11:Cho biết những người bán có ít nhất một lần đăng ký trong đó đăng kí tất cả các dịch vụ hiện có 
select distinct MaNB, HoTen, DiaChi
from NguoiBan
where MaNB in (select MaNB
	from PhieuDangKy
	where TongSoDV= (select count(MaDV)
		from DichVu))

--Câu 12:Cho biết người bán đã đăng ký tất cả các dịch vụ có mệnh giá 200.000 trở lên
select distinct a.MaNB, HoTen, DiaChi
from NguoiBan a, PhieuDangKy b, CT_PDK c, DichVu d
where a.MaNB = b.MaNB and b.MaPDK = c.MaPDK and c.MaDV = d.MaDV and d.TienDV >=200000
group by a.MaNB, HoTen, DiaChi, c.MaPDK
having count(distinct c.MaDV) = (select count(madv)
	from DichVu
	where TienDV >=200000)

--Câu 13:Cho biết danh sách địa ốc đã được đăng kí quảng cáo với tất cả các dịch vụ có tiền dịch vụ nằm trong khoảng 100.000 tới 300.000
select distinct d.MaDO, So, Duong, Phuong, Quan
from DiaOc d, CT_PDK c, DichVu v
where d.MaDO=c.MaDO and c.MaDV=v.MaDV and v.TienDV between 100000 and 300000
group by d.MaDO, So, Duong, Phuong, Quan
having count(distinct c.MaDV)=(select count(MaDV)
	from DichVu
	where TienDV between 100000 and 300000)

--Câu 14 : Cho biết danh sách địa ốc có ít nhất 1 lần đăng ký sử dụng tất cả các dịch vụ hiện có
select distinct d.MaDO, So, Duong, Phuong, Quan
from DiaOc d, CT_PDK c, DichVu v
where d.MaDO=c.MaDO and c.MaDV=v.MaDV
group by d.MaDO, So, Duong, Phuong, Quan
having count(distinct c.MaDV)=(select count(MaDV)
	from DichVu)

--Câu 15:Cho biết danh sách những người bán có ít nhất một lần đăng kí vào tháng 10 trong đó sử dụng tất cả các dịch vụ có giá tiền trong khoảng từ 100.000 đến 200.000
select distinct n.MaNB, HoTen, DiaChi, SoDT
from NguoiBan n, PhieuDangKy p, CT_PDK c, DichVu d
where n.MaNB=p.MaNB and p.MaPDK=c.MaPDK and c.MaDV=d.MaDV and d.TienDV between 100000 and 200000 and month(NgayDK)=10
group by n.MaNB, HoTen, DiaChi, SoDT
having count(distinct c.MaDV)=(select count(MaDV)
	from DichVu
	where TienDV between 100000 and 200000)