/* Môn: Cơ sở dữ liệu
   QL_NhapXuatHangHoa
   Thực hiện: La Quốc Thắng
   Ngày: 11/4/2018 
*/
---------------------------------------------------------------------------------------

create database QL_NhapXuatHangHoa

use QL_NhapXuatHangHoa

go
create table HangHoa
(
	MaHH varchar(5) primary key,
	TenHH varchar(30) not null unique,
	DVT nvarchar(3) not null,
	SoLuongTon tinyint
)

go
create table DoiTac
(
	MaDT varchar(5) primary key,
	TenDT nvarchar(30) not null,
	DiaChi nvarchar(35),
	DienThoai varchar(12)
)

go
create table KhaNangCC
(
	MaDT varchar(5) references DoiTac(MaDT),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(MaDT, MaHH)
)

go
create table HoaDon
(
	SoHD varchar(5) primary key,
	NgayLapHD date not null,
	MaDT varchar(5) references DoiTac(MaDT),
	TongTG float
)

go
create table CT_HoaDon
(
	SoHD varchar(5) references HoaDon(SoHD),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(SoHD, MaHH),
	DonGia tinyint not null,
	SoLuong tinyint not null
)

insert into HangHoa values('CPU01','CPU INTEL, CELERON 600 BOX',N'CÁI','5')
insert into HangHoa values('CPU02','CPU INTEL, PIII 700',N'CÁI','10')
insert into HangHoa values('CPU03','CPU AMD K7 ATHL,ON 600',N'CÁI','8')
insert into HangHoa values('HDD01','HDD 10.2 GB QUANTUM',N'CÁI','10')
insert into HangHoa values('HDD02','HDD 13.6 GB SEAGATE',N'CÁI','15')
insert into HangHoa values('HDD03','HDD 20 GB QUANTUM',N'CÁI','6')
insert into HangHoa values('KB01','KB GENIUS',N'CÁI','12')
insert into HangHoa values('KB02','KB MITSUMIMI',N'CÁI','5')
insert into HangHoa values('MB01','GIGABYTE CHIPSET INTEL',N'CÁI','10')
insert into HangHoa values('MB02','ACOPR BX CHIPSET VIA',N'CÁI','10')
insert into HangHoa values('MB03','INTEL PHI CHIPSET INTEL',N'CÁI','10')
insert into HangHoa values('MB04','ECS CHIPSET SIS',N'CÁI','10')
insert into HangHoa values('MB05','ECS CHIPSET VIA',N'CÁI','10')
insert into HangHoa values('MNT01','SAMSUNG 14" SYNCMASTER',N'CÁI','5')
insert into HangHoa values('MNT02','LG 14"',N'CÁI','5')
insert into HangHoa values('MNT03','ACER 14"',N'CÁI','8')
insert into HangHoa values('MNT04','PHILIPS 14"',N'CÁI','6')
insert into HangHoa values('MNT05','VIEWSONIC 14"',N'CÁI','7')

insert into DoiTac values('CC001','Cty TNC',N'176 BTX Q1 - TP.HCM','08.8250259')
insert into DoiTac values('CC002',N'Cty Hoàng Long','15A TTT Q1 - TP.HCM','08.8250898')
insert into DoiTac values('CC003',N'Cty Hợp Nhất','152 BTX Q1 - TP.HCM','08.8252376')
insert into DoiTac values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063.831129')
insert into DoiTac values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DoiTac values('K0003',N'Trần Nhật Duật',N'Lê Lợi Tp.Huế','054.848376')
insert into DoiTac values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khỡi Nghĩa Tp.Đà Lạt','063.823409')

set dateformat dmy	--Chỉnh định dạng ngày lại
insert into HoaDon values('N0001','25/1/2006','CC001','')
insert into HoaDon values('N0002','1/5/2006','CC002','')
insert into HoaDon values('X0001','12/5/2006','K0001','')
insert into HoaDon values('X0002','16/6/2006','K0002','')
insert into HoaDon values('X0003','20/4/2006','K0003','')

insert into KhaNangCC values('CC001','CPU01')
insert into KhaNangCC values('CC001','HDD03')
insert into KhaNangCC values('CC001','KB01')
insert into KhaNangCC values('CC001','MB02')
insert into KhaNangCC values('CC001','MB04')
insert into KhaNangCC values('CC001','MNT01')
insert into KhaNangCC values('CC002','CPU01')
insert into KhaNangCC values('CC002','CPU02')
insert into KhaNangCC values('CC002','CPU03')
insert into KhaNangCC values('CC002','KB02')
insert into KhaNangCC values('CC002','MB01')
insert into KhaNangCC values('CC002','MB05')
insert into KhaNangCC values('CC002','MNT03')
insert into KhaNangCC values('CC003','HDD01')
insert into KhaNangCC values('CC003','HDD02')
insert into KhaNangCC values('CC003','HDD03')
insert into KhaNangCC values('CC003','MB03')

insert into CT_HoaDon values('N0001','CPU01','63','10')
insert into CT_HoaDon values('N0001','HDD03','97','7')
insert into CT_HoaDon values('N0001','KB01','3','5')
insert into CT_HoaDon values('N0001','MB02','57','5')
insert into CT_HoaDon values('N0001','MNT01','112','3')
insert into CT_HoaDon values('N0002','CPU02','115','3')
insert into CT_HoaDon values('N0002','KB02','5','7')
insert into CT_HoaDon values('N0002','MNT03','111','5')
insert into CT_HoaDon values('X0001','CPU01','67','2')
insert into CT_HoaDon values('X0001','HDD03','100','2')
insert into CT_HoaDon values('X0001','KB01','5','2')
insert into CT_HoaDon values('X0001','MB02','62','1')
insert into CT_HoaDon values('X0002','CPU01','67','1')
insert into CT_HoaDon values('X0002','KB02','7','3')
insert into CT_HoaDon values('X0002','MNT01','115','2')
insert into CT_HoaDon values('X0003','CPU01','67','1')
insert into CT_HoaDon values('X0003','MNT03','115','2')

select * from HangHoa

select * from DoiTac

select * from KhaNangCC

select * from HoaDon

select * from CT_HoaDon