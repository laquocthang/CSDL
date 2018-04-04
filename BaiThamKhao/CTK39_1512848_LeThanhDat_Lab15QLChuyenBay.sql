-- Tên:Lê Thành Đạt
-- MSSV: 1512848
-- Lớp: CTK39

CREATE DATABASE Lab15_QLChuyenBay
go
use Lab15_QLChuyenBay
go
create table KhachHang(
	MaKH char(4) primary key,
	TenKH varchar(15) not null,
	DiaChi varchar(50) not null,
	DThoai varchar(12),
)
go
create table NhanVien(
	MaNV char(4) primary key,
	TenNV char(10) not null,
	DiaChi varchar(30) not null,
	DThoai char(7),
	Luong money not null,
	LoaiNV bit not null,
)
go
create table LoaiMB(
	MaLoai varchar(15) primary key,
	HangSX varchar(15) not null
)
go
create table MayBay(
	SoHieu tinyint,
	MaLoai varchar(15) references LoaiMB(MaLoai),
	primary key(SoHieu, MaLoai)
)
go
Create table ChuyenBay(
	MaCB varchar(4) primary key,
	SBDi char(3) not null,
	SBDen char(3) not null,
	GioDi time not null,
	GioDen time not null
)
go
create table LichBay(
	NgayDi  date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(NgayDi,MaCB),
	SoHieu tinyint not null,
	MaLoai varchar(15) references LoaiMB(MaLoai)	
)
go
create table DatCho(
	MaKH char(4) references KHACHHANG(MAKH),
	NgayDi  date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(NGAYDI,MACB,MAKH)
)
go
create table KhaNang(
	MaNV char(4) references NhanVien(MaNV),
	MaLoai varchar(15) references LoaiMB(MaLoai),
	primary key(MaNV,MaLoai)
)
go
create table PHANCONG(
	MaNV char(4) references NhanVien(MaNV),
	NgayDi date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(MaNV,NgayDi,MaCB)
)


insert into KhachHang values('0009','Nga','223 Nguyen Trai','8932320')
insert into KhachHang values('0101','ANH','567 Tran Phu','8826729')
insert into KhachHang values('0045','Thu','285 Le Loi','8932203')
insert into KhachHang values('0012','Ha','435 Quang Trung','8933232')
insert into KhachHang values('0238','Hung','456 Pasteur','9812101')
insert into KhachHang values('0397','Thanh','234 Le Van Si','8952943')
insert into KhachHang values('0582','Mai','789 Nguyen Du','')
insert into KhachHang values('0934','Minh','678 Le Lai','')
insert into KhachHang values('0091','Hai','345 Hung Vuong','8893223')
insert into KhachHang values('0314','Phuong','395 Vo Van Tan','8232320')
insert into KhachHang values('0613','Vu','348 CMT8','8343232')
insert into KhachHang values('0586','Son','123 Bach Dang','8556223')
insert into KhachHang values('0422','Tien','75 Nguyen Thong','8332222')
select *from KhachHang

insert into NhanVien values('1006','Chi','12/6 Nguyen Kiem','8120012','150000','0')
insert into NhanVien values('1005','Giao','65 Nguyen Thai Son','8324467','500000','0')
insert into NhanVien values('1001','Huong','8 Dien Bien Phu','8330733','500000','1')
insert into NhanVien values('1002','Phong','1 Ly Thuong Kiet','8308117','450000','1')
insert into NhanVien values('1004','Phuong','351 Lac Hong Quan','8308155','250000','0')
insert into NhanVien values('1003','Quang','78 Truong Dinh','8324461','350000','1')
insert into NhanVien values('1007','Tam','36 Nguyen Van Cu','8458188','500000','0')
select*from NhanVien

insert into LoaiMB values('A310','Airbus')
insert into LoaiMB values('A320','Airbus')
insert into LoaiMB values('A330','Airbus')
insert into LoaiMB values('A340','Airbus')
insert into LoaiMB values('B727','Boeing')
insert into LoaiMB values('B747','Boeing')
insert into LoaiMB values('B757','Boeing')
insert into LoaiMB values('DC10','MD')
insert into LoaiMB values('DC9','MD')
select * from LoaiMB

insert into MayBay values('10','B747')
insert into MayBay values('11','B727')
insert into MayBay values('13','B727')
insert into MayBay values('13','B747')
insert into MayBay values('21','DC10')
insert into MayBay values('21','DC9')
insert into MayBay values('22','B757')
insert into MayBay values('22','DC9')
insert into MayBay values('23','DC9')
insert into MayBay values('24','DC9')
insert into MayBay values('70','A310')
insert into MayBay values('80','A310')
insert into MayBay values('93','B757')
select*from MayBay

insert into ChuyenBay values('100','SLC','BOS','08:00','17:50')
insert into ChuyenBay values('112','DCA','DEB','14:00','18:07')
insert into ChuyenBay values('121','STL','SLC','07:00','09:13')
insert into ChuyenBay values('122','STL','YYV','08:30','10:19')
insert into ChuyenBay values('206','DFW','STL','09:00','11:40')
insert into ChuyenBay values('330','JFK','YYV','16:00','18:53')
insert into ChuyenBay values('334','ORD','MIA','12:00','14:14')
insert into ChuyenBay values('335','MIA','ORD','15:00','17:14')
insert into ChuyenBay values('336','ORD','MIA','18:00','20:14')
insert into ChuyenBay values('337','MIA','ORD','20:30','23:53')
insert into ChuyenBay values('394','DFW','MIA','17:00','21:30')
insert into ChuyenBay values('395','MIA','DFW','21:00','23:43')
insert into ChuyenBay values('449','CDG','DEN','10:00','19:29')
insert into ChuyenBay values('930','YYV','DCA','13:00','16:10')
insert into ChuyenBay values('931','DCA','YYV','17:00','18:10')
insert into ChuyenBay values('932','DCA','YYV','18:00','19:10')
insert into ChuyenBay values('991','BOS','ORD','17:00','18:22')
select * from ChuyenBay

set dateformat dmy
insert into LichBay values('1/11/2000','100','80','A310')
insert into LichBay values('1/11/2000','112','21','DC10')
insert into LichBay values('1/11/2000','206','22','DC9')
insert into LichBay values('1/11/2000','334','10','B747')
insert into LichBay values('1/11/2000','395','23','DC9')
insert into LichBay values('1/11/2000','991','22','B757')
insert into LichBay values('1/11/2000','337','10','B747')
insert into LichBay values('31/10/2000','100','11','B727')
insert into LichBay values('31/10/2000','112','11','B727')
insert into LichBay values('31/10/2000','206','13','B727')
insert into LichBay values('31/10/2000','334','10','B747')
insert into LichBay values('31/10/2000','335','10','B747')
insert into LichBay values('31/10/2000','337','24','DC9')
insert into LichBay values('31/10/2000','449','70','A310')
select * from LichBay

set dateformat dmy
insert into DatCho values('0009','1/11/2000','100')
insert into DatCho values('0009','31/10/2000','449')
insert into DatCho values('0045','1/11/2000','991')
insert into DatCho values('0012','31/10/2000','206')
insert into DatCho values('0238','31/10/2000','334')
insert into DatCho values('0582','1/11/2000','991')
insert into DatCho values('0091','1/11/2000','100')
insert into DatCho values('0314','31/10/2000','449')
insert into DatCho values('0613','1/11/2000','100')
insert into DatCho values('0586','1/11/2000','991')
insert into DatCho values('0586','31/10/2000','100')
insert into DatCho values('0422','31/10/2000','449')
select * from DatCho

insert into KhaNang values('1001','B727')
insert into KhaNang values('1001','B747')
insert into KhaNang values('1001','DC9')
insert into KhaNang values('1001','DC10')
insert into KhaNang values('1002','A320')
insert into KhaNang values('1002','A340')
insert into KhaNang values('1002','B757')
insert into KhaNang values('1002','DC9')
insert into KhaNang values('1003','A310')
insert into KhaNang values('1003','DC9')
select * from KhaNang

set dateformat dmy
insert into PhanCong values('1001','11/1/2000','100')
insert into PhanCong values('1001','31/10/2000','100')
insert into PhanCong values('1002','1/11/2000','100')
insert into PhanCong values('1002','31/10/2000','100')
insert into PhanCong values('1003','31/10/2000','100')
insert into PhanCong values('1003','31/10/2000','337')
insert into PhanCong values('1004','31/10/2000','100')
insert into PhanCong values('1004','31/10/2000','337')
insert into PhanCong values('1005','31/10/2000','337')
insert into PhanCong values('1006','1/11/2000','991')
insert into PhanCong values('1006','31/10/2000','337')
insert into PhanCong values('1007','1/11/2000','112')
insert into PhanCong values('1007','1/11/2000','991')
insert into PhanCong values('1007','31/10/2000','206')
select * from PhanCong
