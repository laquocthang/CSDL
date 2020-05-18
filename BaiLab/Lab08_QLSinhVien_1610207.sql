create database Lab08_QLSinhVien_1610207
use Lab08_QLSinhVien_1610207;

go
create table KHOA
(MSKhoa nchar(2) primary key,
TenKhoa nvarchar(30) not null unique,
TenTat nchar(4) not null unique);

go
create table Lop
(MSLop nchar(4) primary key,
TenLop nvarchar(30) not null unique,
MSKhoa nchar(2) references KHOA(MSKhoa),
NienKhoa nchar(4) not null);

go
create table Tinh
(MSTinh nchar(2) primary key,
TenTinh nvarchar(20) not null unique);

go
create table MonHoc
(MSMH nchar(4) primary key,
TenMH nvarchar(30) not null,
HeSo tinyint not null);

go
create table SinhVien
(MSSV nchar(7) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
NgaySinh date not null,
MSTinh nchar(2) references TINH(MSTinh),
NgayNhapHoc date not null,
MSLop nchar(4) references LOP(MSLop),
Phai bit not null,
DiaChi nvarchar(30) not null,
DienThoai nchar(10),
HinhAnh image);

go
create table BANGDIEM
(MSSV nchar(7) foreign key references SinhVien(MSSV),
MSMH nchar(4) foreign key references MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null,
constraint PK primary key (MSSV, MSMH, LanThi));

Insert into KHOA Values('1','Cong nghe thong tin','CNTT')
Insert into KHOA Values('2','Dien tu vien thong','DTVT')
Insert into KHOA Values('3','Quan tri kinh doanh','QTKD')
Insert into KHOA Values('4','Cong nghe sinh hoc','CNSH')

Insert into Lop Values('98TH','Tin hoc khoa 1998','1','1998')
Insert into Lop Values('98VT','Vien thong khoa 1998','2','1998')
Insert into Lop Values('99QT','Quan tri khoa 1999','3','1999')
Insert into Lop Values('99TH','Tin hoc khoa 1999','1','1999')
Insert into Lop Values('99VT','Vien thong khoa 1999','2','1999')

Insert into Tinh Values('01','An Giang')
Insert into Tinh Values('02','TPHCM')
Insert into Tinh Values('03','Dong Nai')
Insert into Tinh Values('04','Long An')
Insert into Tinh Values('05','Hue')
Insert into Tinh Values('06','Ca Mau')

Insert into MonHoc Values('QA01','Kinh te vi mo','2')
Insert into MonHoc Values('QA02','Quan tri chat luong','3')
Insert into MonHoc Values('TA01','Nhap mon tin hoc','2')
Insert into MonHoc Values('TA02','Lap trinh co ban','3')
Insert into MonHoc Values('TB01','Cau truc du lieu','2')
Insert into MonHoc Values('TB02','Co so du lieu','2')
Insert into MonHoc Values('VA01','Dien tu co ban','2')
Insert into MonHoc Values('VA02','Mach so','3')
Insert into MonHoc Values('VB01','Truyen so lieu','3')
Insert into MonHoc Values('XA01','Vat ly dai cuong','2')

Insert into SinhVien Values('98TH001','Nguyen Van','An','8/6/1980','01','9/3/1998','98TH','1','12 Tran Hung Dao, Q.1','8234512','')
Insert into SinhVien Values('98TH002','Le Thi','An','10/17/1979','01','9/3/1998','98TH','0','23 CMT8, Q.Tan Binh','0303234342','')
Insert into SinhVien Values('98VT001','Nguyen Duc','Bình','11/25/1981','02','9/3/1998','98VT','1','245 Lac Long Quan, Q.11','8654323','')
Insert into SinhVien Values('98VT002','Tran Ngoc','Anh','8/19/1980','02','9/3/1998','98VT','0','242 Tran Hung Dao, Q.1','','')
Insert into SinhVien Values('99QT001','Nguyen Thi','Oanh','8/19/1973','04','10/5/1999','99QT','0','76 Hung Vuong, Q.5','0901656324','')
Insert into SinhVien Values('99QT002','Le My','Hanh','5/20/1976','04','10/5/1999','99QT','0','12 Pham Ngoc Thach, Q.3','','')
Insert into SinhVien Values('99TH001','Ly Van Hung','Dung','9/27/1981','03','10/5/1999','99TH','1','178 CMT8, Q. Tân Bình','7563213','')
Insert into SinhVien Values('99TH002','Van Minh','Hoang','1/1/1981','04','10/5/1999','99TH','1','272 Ly Thuong Kiet, Q.10','8341234','')
Insert into SinhVien Values('99TH003','Nguyen','Tuan','1/12/1980','03','10/5/1999','99TH','1','162 Tran Hung Dao, Q.5','','')
Insert into SinhVien Values('99TH004','Tran Van','Minh','6/25/1981','04','10/5/1999','99TH','1','147 Dien Bien Phu, Q.3','7236754','')
Insert into SinhVien Values('99TH005','Nguyen Thai','Minh','1/1/1980','04','10/5/1999','99TH','1','345 Le Dai Hanh, Q.11','','')
Insert into SinhVien Values('99VT001','Le Ngoc','Mai','6/21/1982','01','10/5/1999','99VT','0','129 Tran Hung Dao, Q.1','0903124534','')

Insert into BANGDIEM Values('98TH001','TA01','1','8.5')
Insert into BANGDIEM Values('98TH001','TA02','1','8')
Insert into BANGDIEM Values('98TH001','TB01','1','7')
Insert into BANGDIEM Values('98TH002','TA01','1','4')
Insert into BANGDIEM Values('98TH002','TA01','2','5.5')
Insert into BANGDIEM Values('98TH002','TB01','1','7.5')
Insert into BANGDIEM Values('98VT001','VA01','1','4')
Insert into BANGDIEM Values('98VT001','VA01','2','5')
Insert into BANGDIEM Values('98VT002','VA02','1','7.5')
Insert into BANGDIEM Values('99QT001','QA01','1','7')
Insert into BANGDIEM Values('99QT001','QA02','1','6.5')
Insert into BANGDIEM Values('99QT002','QA01','1','8.5')
Insert into BANGDIEM Values('99QT002','QA02','1','9')
Insert into BANGDIEM Values('99TH001','TA01','1','4')
Insert into BANGDIEM Values('99TH001','TA01','2','6')
Insert into BANGDIEM Values('99TH001','TB01','1','6.5')
Insert into BANGDIEM Values('99TH002','TB01','1','10')
Insert into BANGDIEM Values('99TH002','TB02','1','9')
Insert into BANGDIEM Values('99TH003','TA02','1','7.5')
Insert into BANGDIEM Values('99TH003','TB01','1','3')
Insert into BANGDIEM Values('99TH003','TB01','2','6')
Insert into BANGDIEM Values('99TH003','TB02','1','8')
Insert into BANGDIEM Values('99TH004','TB02','1','2')
Insert into BANGDIEM Values('99TH004','TB02','2','4')
Insert into BANGDIEM Values('99TH004','TB02','3','3')

select *
from KHOA

select *
from Lop

select *
from Tinh

select *
from MonHoc

select *
from SinhVien

select *
from BANGDIEM

-- 23) Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau:
-- MSTinh -  Tên Tỉnh - Số SV Nam - Số SV Nữ - Tổng cộngselect t.MSTinh, t.TenTinh, 	(		select COUNT(*)		from SinhVien		where Phai = 1 and MSTinh = t.MSTinh	) as 'SoSVNam',	(		select COUNT(*)		from SinhVien		where Phai = 0 and MSTinh = t.MSTinh	) as 'SoSVNu',	COUNT(*) as 'TongCong'from Tinh t, SinhVien svwhere t.MSTinh = sv.MSTinhgroup by t.MSTinh, t.TenTinh