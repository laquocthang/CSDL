-- Tên: Lê Thành Đạt
-- MSSV: 1512848
-- Lớp: CTK39

create database Lab14_QLTieuLuan
go
use Lab14_QLTieuLuan
go
create table SinhVien
(
	MSSV char(7) primary key,
	TenSV nvarchar(15) not null,
	Lop char(3) not null
)	
go
create table ChuyenNganh
(
	MSCN char(2) primary key,
	TenCN nvarchar(20) not null unique,
)	
go
create table CongViec
(
	MSCV char(2) primary key,
	TenVC nvarchar(20) not null unique
)	
go
create table DeTai
(
	MSDT char(6) primary key,
	TenDT nvarchar(30) not null unique,
	MSCN char(2) references ChuyenNganh(MSCN),
	NgayBatDau date not null,
	NgayNghiemThu date not null
)	
go
create table ThucHienDeTai
(
	MSSV char(7) references SinhVien(MSSV),
	MSDT char(6) references DeTai(MSDT),
	MSCV char(2) references CongViec(MSCV)
	primary key (MSSV, MSDT, MSCV),
	Diem tinyint check(Diem between 0 and 10)
)


-- Nhập liệu

insert into SinhVien values('0400001',N'Nguyễn Văn An','K28')
insert into SinhVien values('0300095',N'Trần Hùng','K27')
insert into SinhVien values('0310005',N'Lê Thúy Hằng','K27')
insert into SinhVien values('0400023',N'Ngô Khoa','K28')
insert into SinhVien values('0400100',N'Phạm Tài','K28')
insert into SinhVien values('0310100',N'Đinh Tiến','K27')
select * from SinhVien

insert into ChuyenNganh values('01',N'Hệ thống thông tin')
insert into ChuyenNganh values('02',N'Mạng')
insert into ChuyenNganh values('03',N'Đồ họa')
insert into ChuyenNganh values('04',N'Công nghệ phần mềm')
select * from ChuyenNganh

insert into CongViec values('C1',N'Trưởng nhóm')
insert into CongViec values('C2',N'Thu thập thông tin')
insert into CongViec values('C3',N'Phân tích')
insert into CongViec values('C4',N'Thiết kế')
select * from CongViec

set dateformat dmy
insert into DeTai values('DT0601',N'Quản lý thư viện','01','15/9/2007','15/12/2007')
insert into DeTai values('DT0602',N'Nhận dạng vân tay','03','15/9/2007','15/12/2007')
insert into DeTai values('DT0603',N'Bán đấu giá trên mạng','02','15/9/2007','15/12/2007')
insert into DeTai values('DT0604',N'Quản lý siêu thị','04','15/9/2007','15/12/2007')
insert into DeTai values('DT0605',N'Giấu tin trong ảnh','03','15/9/2007','15/12/2007')
insert into DeTai values('DT0606',N'Phát hiện tấn công trên mạng','02','15/9/2007','15/12/2007')
select * from DeTai

insert into ThucHienDeTai values('0400001','DT0601','C1',7)
insert into ThucHienDeTai values('0400001','DT0603','C2',8)
insert into ThucHienDeTai values('0300095','DT0602','C2',9)
insert into ThucHienDeTai values('0310005','DT0604','C3',8)
insert into ThucHienDeTai values('0400023','DT0601','C3',6)
insert into ThucHienDeTai values('0400023','DT0605','C4',8)
insert into ThucHienDeTai values('0400100','DT0603','C3',8)
insert into ThucHienDeTai values('0310100','DT0604','C4',6)
insert into ThucHienDeTai values('0310100','DT0601','C2',5)
select * from ThucHienDeTai