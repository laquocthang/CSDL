create database Lab07_QLHangHoa_1610207
use Lab07_QLHangHoa_1610207;

go
create table HangHoa
(MSHH nchar(4) primary key,
TenHH nchar(10) not null);

go
create table KhachHang
(MSKH nchar(4) primary key,
TenKH nvarchar(30) not null,
NoDau smallint);

go
create table HoaDon
(MSHD nchar(4) primary key,
NgayHD date not null,
MSKH nchar(4) references KhachHang(MSKH));

go
create table PhieuThu
(MSPT nchar(4) primary key,
NgayThu date not null,
MSKH nchar(4) references KhachHang(MSKH),
SoTien smallint not null);

go
create table ChiTietHoaDon
(MSHD nchar(4) foreign key references HoaDon(MSHD),
MSHH nchar(4) foreign key references HangHoa(MSHH),
SoLuong tinyint not null,
DonGia tinyint not null);

Insert into HangHoa Values ('H001','Banh')
Insert into HangHoa Values ('H002','Keo')
Insert into HangHoa Values ('H003','Duong')
Insert into HangHoa Values ('H004','Sua')

Insert into KhachHang Values ('K001','Nguyen Van Minh','1000')
Insert into KhachHang Values ('K002','Le Ngoc Dung','2500')
Insert into KhachHang Values ('K003','Tran Tan Luc','0')
Insert into KhachHang Values ('K004','Le Thi Mai','800')

Insert into HoaDon Values ('0001','1/1/2007','K001')
Insert into HoaDon Values ('0002','1/1/2007','K003')
Insert into HoaDon Values ('0003','1/10/2007','K001')
Insert into HoaDon Values ('0004','1/12/2007','K001')
Insert into HoaDon Values ('0005','2/1/2007','K003')

Insert into PhieuThu values('T001','1/1/2007','K001','1000')
Insert into PhieuThu values('T002','1/4/2007','K002','500')
Insert into PhieuThu values('T003','1/10/2007','K001','800')
Insert into PhieuThu values('T004','1/15/2007','K001','700')
Insert into PhieuThu values('T005','2/2/2007','K002','1000')

Insert into ChiTietHoaDon Values ('0001','H001','10','50')
Insert into ChiTietHoaDon Values ('0001','H002','5','30')
Insert into ChiTietHoaDon Values ('0001','H003','10','100')
Insert into ChiTietHoaDon Values ('0002','H002','20','30')
Insert into ChiTietHoaDon Values ('0002','H003','20','100')
Insert into ChiTietHoaDon Values ('0003','H001','15','50')
Insert into ChiTietHoaDon Values ('0003','H002','10','40')
Insert into ChiTietHoaDon Values ('0004','H001','5','60')
Insert into ChiTietHoaDon Values ('0004','H003','20','90')
Insert into ChiTietHoaDon Values ('0005','H002','10','40')

select *
from HangHoa

select *
from KhachHang

select *
from HoaDon

select *
from PhieuThu

select *
from ChiTietHoaDon
