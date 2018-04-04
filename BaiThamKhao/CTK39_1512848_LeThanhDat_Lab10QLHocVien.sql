-- Tên: Lê Thành Đạt
-- MSSV: 1512848
-- Lớp: CTK39

create database Lab10_QLHocVien
go
use Lab10_QLHocVien
go
create table CaHoc
(
	Ca int primary key,
	GioBatDau time not null, 
	GioKetThuc time not null
)	
go
create table GiaoVien
(
	MaGV varchar(4) primary key,
	HoGV nvarchar(15) not null,
	TenGV nvarchar(10) not null,
	DienThoai varchar(10)
)	
go
create table Lop
(
	MaLop varchar(4) primary key,
	TenLop varchar(15) not null,
	NgayKG date not null,
	HocPhi money not null, 
	Ca int references CaHoc(Ca),
	SoTiet int not null,
	MaGV varchar(4) references GiaoVien(MaGV)
)
go
create table HocVien
(
	MaHV char(4) primary key,
	Ho nvarchar(20) not null,
	Ten nvarchar(8) not null,
	NgaySinh date not null,
	Phai bit,
	MaLop varchar(4) references Lop(MaLop)
)

-- Nhập liệu

insert into CaHoc values('1','7:30','10:45')
insert into CaHoc values('2','13:30','16:45')
insert into CaHoc values('3','17:30','20:45')
select * from CaHoc

insert into GiaoVien values('G001',N'Lê Hoàng','Anh','858936')
insert into GiaoVien values('G002',N'Nguyễn Ngọc',N'Lan','845623')
insert into GiaoVien values('G003',N'Trần Minh',N'Hùng','823456')
insert into GiaoVien values('G004',N'Võ Thanh',N'Trung','841256')
select * from GiaoVien

set dateformat dmy
insert into Lop values ('A075','Access 2-4-6','18/12/2008','150000','3','60','G003')
insert into Lop values ('E114','Excel 3-5-7','02/01/2008','120000','1','45','G003')
insert into Lop values ('E115','Excel 2-4-6','22/01/2008','120000','3','45','G001')
insert into Lop values ('W123','Word 2-4-6','18/12/2008','100000','3','30','G001')
insert into Lop values ('W124','Word 3-5-7','01/03/2008','100000','1','30','G002')
select * from Lop

set dateformat dmy
insert into HocVien values ('0001',N'Lê Văn',N'Minh','10/06/1998','1','A075')
insert into HocVien values ('0002',N'Nguyễn Thị',N'Mai','20/04/1988','0','A075')
insert into HocVien values ('0003',N'Lê Ngọc',N'Tuấn','10/06/1984','1','A075')
insert into HocVien values ('0004',N'Vương Tuấn',N'Vũ','25/03/7979','1','E114')
insert into HocVien values ('0005',N'Lý Ngọc',N'Hân','01/12/1985','0','E114')
insert into HocVien values ('0006',N'Trần Mai',N'Linh','04/06/1980','0','E114')
insert into HocVien values ('0007',N'Nguyễn Ngọc',N'Tuyết','12/05/1986','0','W123')
select * from HocVien

DECLARE @d DATETIME = GETDATE();  
SELECT FORMAT( @d, 'dd/MM/yyyy', 'en-US' ) AS 'DateTime Result'  
       ,FORMAT(123456789,'###-##-####') AS 'Custom Number Result';  