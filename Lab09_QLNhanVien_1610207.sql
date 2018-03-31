create database Lab09_QLNhanVien_1610207
use Lab09_QLNhanVien_1610207;

go
create table NhanVien
(MSNV nchar(4) primary key,
HoTen nvarchar(30) not null,
Phai bit not null,
NgaySinh date not null);

go
create table ChucVu
(MSCV nchar(2) primary key,
TenCV nvarchar(20) not null)

go
create table DuAn
(MSDA nchar(3) primary key,
TenDA nvarchar(30) not null,
NgayBatDau date not null,
NgayNghiemThuDK date not null,
NgayNghiemThuTT date)

go
create table NhanVien_DuAn
(MSDA nchar(3) foreign key references DuAn(MSDA),
MSNV nchar(4) foreign key references NhanVien(MSNV),
MSCV nchar(2) references ChucVu(MSCV))

Insert into NhanVien Values('0001','Lê Văn Kiên','1','6/10/1970')
Insert into NhanVien Values('0002','Nguyễn Ngọc','1','4/20/1982')
Insert into NhanVien Values('0003','Lê Thị Mai','0','6/10/1968')
Insert into NhanVien Values('0004','Vương Hùng','1','3/25/1975')
Insert into NhanVien Values('0005','Lý Bích Ngọc','0','12/1/1980')
Insert into NhanVien Values('0006','Trần Văn Tuấn','1','6/10/1985')

Insert into ChucVu Values('01','Trưởng dự án ')
Insert into ChucVu Values('02','Phân tích viên')
Insert into ChucVu Values('03','Lập trình viên')
Insert into ChucVu Values('04','Kỹ thuật viên')

Insert into DuAn Values('D01','Lắp mạng','12/1/2006','12/15/2006','12/20/2006')
Insert into DuAn Values('D02','Phần mềm kế toán','2/15/2007','4/15/2007','')
Insert into DuAn Values('D03','Phần mềm QL Nhân sự','2/20/2007','6/1/2007','5/25/2007')
Insert into DuAn Values('D04','Phần mềm QL Kinh doanh','6/20/2007','1/1/2008','')

Insert into NhanVien_DuAn Values('D01','0001','01')
Insert into NhanVien_DuAn Values('D01','0002','04')
Insert into NhanVien_DuAn Values('D01','0004','02')
Insert into NhanVien_DuAn Values('D02','0001','01')
Insert into NhanVien_DuAn Values('D02','0003','02')
Insert into NhanVien_DuAn Values('D02','0004','03')
Insert into NhanVien_DuAn Values('D02','0005','03')
Insert into NhanVien_DuAn Values('D03','0003','01')
Insert into NhanVien_DuAn Values('D03','0004','02')
Insert into NhanVien_DuAn Values('D03','0005','03')

select *
from NhanVien

select *
from ChucVu

select *
from DuAn

select *
from NhanVien_DuAn