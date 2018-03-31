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
NgaySinh date not null,
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

Insert into ToSanXuat Values('TS01','Tổ 1')
Insert into ToSanXuat Values('TS02','Tổ 2')

Insert into CongNhan values('CN001','Nguyễn Trường','An','Nam','5/12/1981','TS01')
Insert into CongNhan values('CN002','Lê Thị Hồng','Gấm','Nữ','6/4/1980','TS01')
Insert into CongNhan values('CN003','Nguyễn Công','Thành','Nam','5/4/1981','TS02')
Insert into CongNhan values('CN004','Võ Hữu','Hạnh','Nam','2/15/1980','TS02')
Insert into CongNhan values('CN005','Lý Thanh','Hân','Nữ','12/3/1981','TS01')

Insert into SanPham Values('SP001','Nồi đất','cái','10000')
Insert into SanPham Values('SP002','Chén','cái','2000')
Insert into SanPham Values('SP003','Bình gốm nhỏ','cái','20000')
Insert into SanPham Values('SP004','Bình gốm lớn','cái','25000')

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