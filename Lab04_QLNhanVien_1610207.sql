CREATE DATABASE Lab04_QLNhanVien_1610207
use Lab04_QLNhanVien_1610207;

GO
CREATE TABLE ChiNhanh
(MSCN nchar(2) primary key,
TenCN NVARCHAR(30) not null unique);

GO
CREATE TABLE NhanVien
(MANV nchar(4) primary key,
Ho NVARCHAR(20) not null,
Ten NVARCHAR(10) not null,
NgaySinh date not null,
NgayVaoLam date not null,
MSCN nchar(2) references ChiNhanh(MSCN));

GO
CREATE TABLE KyNang
(MSKN nchar(2) primary key,
TenKN NVARCHAR(15) not null unique);

GO
CREATE TABLE NhanVienKyNang
(MANV nchar(4) foreign key references NhanVien(MANV),
MSKN nchar(2) foreign key references KyNang(MSKN),
MucDo tinyint not null);

insert into ChiNhanh values('01',N'Quận 1');
insert into ChiNhanh values('02',N'Quận 5');
insert into ChiNhanh values('03',N'Bình Thạnh');

Insert into KyNang Values('01',N'Word')
Insert into KyNang Values('02',N'Excel')
Insert into KyNang Values('03',N'Access')
Insert into KyNang Values('04',N'Power Point')
Insert into KyNang Values('05',N'SPSS')

Insert into NhanVien Values('0001',N'Lê Văn','Minh','6/10/1960','5/2/1986','01')
Insert into NhanVien Values('0002',N'Nguyễn Thị','Mai','4/20/1970','7/4/2001','01')
Insert into NhanVien Values('0003',N'Lê Anh',N'Tuấn','6/25/1975','9/1/1982','02')
Insert into NhanVien Values('0004',N'Vương Tuấn',N'Vũ','3/25/1960','1/12/1986','02')
Insert into NhanVien Values('0005',N'Lý Anh',N'Hân','12/1/1980','5/15/2004','02')
Insert into NhanVien Values('0006',N'Phan Lê',N'Tuấn','6/4/1976','10/5/2002','03')
Insert into NhanVien Values('0007',N'Lê Tuấn',N'Tú','8/15/1975','8/15/2000','03')

Insert into NhanVienKyNang Values('0001','01','2')
Insert into NhanVienKyNang Values('0001','02','1')
Insert into NhanVienKyNang Values('0002','01','2')
Insert into NhanVienKyNang Values('0002','03','2')
Insert into NhanVienKyNang Values('0003','02','1')
Insert into NhanVienKyNang Values('0003','03','2')
Insert into NhanVienKyNang Values('0004','01','5')
Insert into NhanVienKyNang Values('0004','02','4')
Insert into NhanVienKyNang Values('0004','03','1')
Insert into NhanVienKyNang Values('0005','02','4')
Insert into NhanVienKyNang Values('0005','04','4')
Insert into NhanVienKyNang Values('0006','02','4')
Insert into NhanVienKyNang Values('0006','03','2')
Insert into NhanVienKyNang Values('0006','05','4')
Insert into NhanVienKyNang Values('0007','03','4')
Insert into NhanVienKyNang Values('0007','04','3')

select *
from ChiNhanh

select *
from KyNang

select *
from NhanVien

select *
from NhanVienKyNang
