/*-----------------------------------------------
Bài lab: Quản lý chuyến bay
Ngày thực hiện: 13/4/2018
Người thực hiện: La Quốc Thắng
MSSV: 1610207
------------------------------------------------*/

create database QL_ChuyenBay

use QL_ChuyenBay

go
create table KhachHang
(
	MaKH varchar(15) primary key,
	Ten varchar(15) not null,
	DChi varchar(50) not null,
	DThoai varchar(12),
)

go
create table NhanVien
(
	MaNV varchar(15) primary key,
	TenNV char(10) not null,
	DChi varchar(30) not null,
	DThoai char(7),
	Luong money not null,
	LoaiNV bit not null,
)

go
create table LoaiMB
(
	HangSX varchar(15) not null,
	MaLoai varchar(15) primary key
)

go
create table MayBay(
	SoHieu tinyint,
	MaLoai varchar(15) references LoaiMB(MaLoai),
	primary key(SoHieu, MaLoai)
)

go
Create table ChuyenBay
(
	MaCB varchar(4) primary key,
	SBDi char(3) not null,
	SBDen char(3) not null,
	GioDi time not null,
	GioDen time not null
)

go
create table LichBay
(
	NgayDi  date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(NgayDi,MaCB),
	SoHieu tinyint not null,
	MaLoai varchar(15) references LoaiMB(MaLoai)	
)

go
create table DatCho
(
	MaKH varchar(15) references KhachHang(MAKH),
	NgayDi  date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(NgayDi,MaCB,MaKH)
)

go
create table KhaNang
(
	MaNV varchar(15) references NhanVien(MaNV),
	MaLoai varchar(15) references LoaiMB(MaLoai),
	primary key(MaNV,MaLoai)
)

go
create table PhanCong
(
	MaNV varchar(15) references NhanVien(MaNV),
	NgayDi date,
	MaCB varchar(4) references ChuyenBay(MaCB),
	primary key(MaNV,NgayDi,MaCB)
)

Insert into KhachHang values('0009','Nga','223 Nguyen Trai','8932320')
Insert into KhachHang values('0101','Anh','567 Tran Phu','8826729')
Insert into KhachHang values('0045','Thu','285 Le Loi','8932203')
Insert into KhachHang values('0012','Ha','435 Quang Trung','8933232')
Insert into KhachHang values('0238','Hung','435 Pasteur','9812101')
Insert into KhachHang values('0397','Thanh','234 Le Van Si','8952943')
Insert into KhachHang values('0582','Mai','789 Nguyen Du','')
Insert into KhachHang values('0934','Minh','678 Le Lai','')
Insert into KhachHang values('0091','Hai','345 Hung Vuong','8893223')
Insert into KhachHang values('0314','Phuong','395 Vo Van Tan','8232320')
Insert into KhachHang values('0613','Vu','348 CMT8','8343232')
Insert into KhachHang values('0586','Son','123 Bach Dang','8556223')
Insert into KhachHang values('0422','Tien','75 Nguyen Thong','8332222')

Insert into NhanVien values('1006','Chi','12/6 Nguyen Kiem','8120012','150000','0')
Insert into NhanVien values('1005','Giao','65 Nguyen Thai Son','8324467','500000','0')
Insert into NhanVien values('1001','Huong','8 Dien Bien Phu','8330733','500000','1')
Insert into NhanVien values('1002','Phong','1 Ly Thuong Kiet','8308117','450000','1')
Insert into NhanVien values('1004','Phuong','351 Lac Long Quan','8308155','250000','0')
Insert into NhanVien values('1003','Quang','78 Truong Dinh','8324461','350000','1')
Insert into NhanVien values('1007','Tam','36 Nguyen Van Cu','8458188','500000','0')

Insert into LoaiMB values('Airbus','A310')
Insert into LoaiMB values('Airbus','A320')
Insert into LoaiMB values('Airbus','A330')
Insert into LoaiMB values('Airbus','A340')
Insert into LoaiMB values('Boeing','B727')
Insert into LoaiMB values('Boeing','B747')
Insert into LoaiMB values('Boeing','B757')
Insert into LoaiMB values('MD','DC10')
Insert into LoaiMB values('MD','DC9')

Insert into MayBay values('10','B747')
Insert into MayBay values('11','B727')
Insert into MayBay values('13','B727')
Insert into MayBay values('13','B747')
Insert into MayBay values('21','DC10')
Insert into MayBay values('21','DC9')
Insert into MayBay values('22','B757')
Insert into MayBay values('22','DC9')
Insert into MayBay values('23','DC9')
Insert into MayBay values('14','DC9')
Insert into MayBay values('70','A310')
Insert into MayBay values('80','A310')
Insert into MayBay values('93','B757')

Insert into ChuyenBay values('100','SLC','BOS','08:00','17:50')
Insert into ChuyenBay values('112','DCA','DEN','14:00','18:07')
Insert into ChuyenBay values('121','STL','SLC','07:00','09:13')
Insert into ChuyenBay values('122','STL','YYV','08:30','10:19')
Insert into ChuyenBay values('206','DFW','STL','09:00','11:40')
Insert into ChuyenBay values('330','JFK','YYV','16:00','18:53')
Insert into ChuyenBay values('334','ORD','MIA','12:00','14:14')
Insert into ChuyenBay values('335','MIA','ORD','15:00','17:14')
Insert into ChuyenBay values('336','ORD','MIA','18:00','20:14')
Insert into ChuyenBay values('337','MIA','ORD','20:30','23:53')
Insert into ChuyenBay values('394','DFW','MIA','19:00','21:30')
Insert into ChuyenBay values('395','MIA','DFW','21:00','23:43')
Insert into ChuyenBay values('449','CDG','DEN','10:00','19:29')
Insert into ChuyenBay values('930','YYV','DCA','13:00','16:10')
Insert into ChuyenBay values('931','DCA','YYV','17:00','18:10')
Insert into ChuyenBay values('932','DCA','YYV','18:00','19:10')
Insert into ChuyenBay values('991','BOS','ORD','17:00','18:22')

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

insert into PhanCong values('1001','1/11/2000','100')
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

select * from KhachHang

select * from NhanVien

select * from LoaiMB

select * from MayBay

select * from ChuyenBay

select * from LichBay

select * from DatCho

select * from KhaNang

select * from PhanCong

---------------------------NỘI DUNG TRUY VẤN----------------------------

--Câu 1: Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công đã từng lái máy bay loại B747
select a.MaNV, TenNV, DChi, DThoai
from PhanCong a, NhanVien b, LichBay c
where a.MaNV=b.MaNV and a.MaCB=c.MaCB and a.NgayDi=c.NgayDi and MaLoai='B747' and LoaiNV=1

--Câu 2: Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay DCA trong khoảng thời gian từ 14h đến 18h
select a.MaCB, NgayDi
from ChuyenBay a, PhanCong b
where a.MaCB=b.MaCB and SBDi='DCA' and GioDi>='14:00' and GioDi<='18:00'

--Câu 3: Cho biết tên những nhân viên được phân công trên chuyến bay có mã số 100 xuất phát tại sân bay SLC
select a.MaNV, b.TenNV
from PhanCong a, NhanVien b, ChuyenBay c
where a.MaNV=b.MaNV and a.MaCB=c.MaCB and a.MaCB='100' and SBDi='SLC'
group by a.MaNV, b.TenNV

--Câu 4: Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA
select MaLoai, SoHieu
from ChuyenBay a, LichBay b
where a.MaCB=b.MaCB and SBDi = 'MIA'
group by MaLoai, SoHieu

--Câu 5: Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả các hành khách đi trên chuyến bay đó
--Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần
select  MaCB, NgayDi, Ten, DChi, DThoai
from DatCho a, KhachHang b
where a.MaKH=b.MaKH
group by MaCB, NgayDi, Ten, DChi, DThoai
order by MaCB, NgayDi desc

--Câu 6: Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả những nhân viên được phân công trên chuyến bay đó
--Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần
select MaCB, NgayDi, TenNV, DChi, DThoai
from PhanCong a, NhanVien b
where a.MaNV=b.MaNV
group by MaCB, NgayDi, TenNV, DChi, DThoai
order by MaCB, NgayDi desc

--Câu 7: Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công được phân công vào chuyến bay hạ cánh xuống sân bay ORD
select a.MaCB, NgayDi, b.MaNV, TenNV
from ChuyenBay a, NhanVien b, PhanCong c
where c.MaNV=b.MaNV and c.MaCB=a.MaCB and SBDen = 'ORD' and LoaiNV = 1

--Câu 8: Cho biết mã số chuyến bay, ngày đi và tên của phi công có mã 1001 được phân công lái chuyến bay đó
select MaCB, NgayDi, TenNV
from PhanCong a, NhanVien b
where a.MaNV=b.MaNV and a.MaNV='1001'

--Câu 9: Cho biết thông tin của những chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo ngày đi giảm dần và sân bay xuất phát tăng dần
select b.MaCB, SBDi, SBDen, GioDen, GioDen
from ChuyenBay a, LichBay b
where a.MaCB=b.MaCB and SBDen = 'DEN'
order by NgayDi desc, SBDi

--Câu 10: Cho biết hãng sản xuất và mã loại máy bay mà phi công có khả năng bay được
select HangSX, b.MaLoai, MaNV
from KhaNang a, LoaiMB b
where a.MaLoai=b.MaLoai
group by HangSX, b.MaLoai, MaNV

--Câu 11: Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay mã số 100 vào ngày 1/11/2000
select a.MaNV, TenNV
from PhanCong a, NhanVien b
where a.MaNV=b.MaNV and MaCB = '100' and NgayDi = '1/11/2000' and LoaiNV = 1

--Câu 12: Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công vào chuyến bay xuất phát vào ngày 31/10/2000 tại sân bay MIA vào lúc 20:30
select a.MaCB, b.MaNV, TenNV
from ChuyenBay a, PhanCong b, NhanVien c
where a.MaCB=b.MaCB and b.MaNV=c.MaNV and NgayDi = '31/10/2000' and SBDi = 'MIA' and GioDi = '20:30'

--Câu 13: Cho biết thông tin về chuyến bay (MaCB, SoHieu, MaLoai, HangSX) mà phi công Quang đã lái
--select MaCB, SoHieu, a.MaLoai, HangSX
--from LichBay a, NhanVien b, KhaNang c, LoaiMB d
--where b.MaNV=c.MaNV and c.MaLoai=a.MaLoai and d.MaLoai=a.MaLoai and TenNV='Quang' and LoaiNV =1

select c.MaCB, SoHieu, a.MaLoai, HangSX
from LichBay a, NhanVien b, PhanCong c, LoaiMB d
where a.MaLoai=d.MaLoai and TenNV='Quang' and LoaiNV=1 and b.MaNV=c.MaNV and a.MaCB=c.MaCB and a.NgayDi=c.NgayDi

--Câu 14: Cho biết tên của những phi công chưa được phân công lái chuyến bay nào
select *
from NhanVien
where LoaiNV=1 and MaNV not in (select a.MaNV
								from PhanCong a, NhanVien b
								where a.MaNV=b.MaNV and LoaiNV=1
								group by a.MaNV)
					
--Câu 15: Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng Boeing
select a.MaKH, Ten
from KhachHang a, DatCho b, LichBay c
where a.MaKH=b.MaKH and c.MaCB=b.MaCB and b.NgayDi=c.NgayDi and MaLoai like 'B%'
group by a.MaKH, Ten

--Câu 16: Cho biết các chuyến bay chỉ bay với máy bay số hiệu 10 và mã loại B747
select distinct MaCB, SoHieu, MaLoai
from LichBay
where MaCB not in (select MaCB
					from LichBay
					where SoHieu <> '10' or MaLoai <> 'B747')

--Câu 17: Với mỗi sân bay (SBDen), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó, sắp xếp theo tên sân bay
select SBDen, count(SBDen) as SoLuongHaCanh
from ChuyenBay
group by SBDen
order by SBDen asc

--Câu 18: Với mỗi sân bay (SBDi), cho biết số lượng chuyến bay xuất phát sân bay đó, sắp xếp theo tên sân bay
select SBDi, count(SBDi) as SoLuongCatCanh
from ChuyenBay
group by SBDi
order by SBDi asc

--Câu 19: Với mỗi sân bay(SBDi), cho biết số lượng chuyến bay xuất phát theo từng ngày
select l.NgayDi, c.SBDi, count(c.SBDi) as SoLuongXuatPhat
from ChuyenBay c, LichBay l
where l.MaCB = c.MaCB
group by l.NgayDi, c.SBDi

--Câu 20: Với mỗi sân bay(SBDen), cho biết số lượng chuyến bay hạ cánh theo từng ngày
select l.NgayDi, c.SBDen, count(c.SBDen) as SoLuongHaCanh
from ChuyenBay c, LichBay l
where l.MaCB = c.MaCB
group by l.NgayDi, c.SBDen

--Câu 21: Cho biết mã chuyến bay, ngày đi cùng với số lượng nhân viên không phải là phi công trên chuyến bay đó
select l.MaCB, l.NgayDi, count(p.MaNV) as SoLuongNhanVien
from PhanCong p, LichBay l, NhanVien n
where p.MaCB = l.MaCB and p.NgayDi = l.NgayDi and p.MaNV = n.MaNV and n.LoaiNV <> 1
group by l.MaCB, l.NgayDi

--Câu 22: Số lượng chuyến bay xuất phát từ sân bay MIA ngày 1/11/2000
select c.SBDi, l.NgayDi, count(c.SBDi) as SoLuongChuyenBayDi
from LichBay l, ChuyenBay c
where l.MaCB = c.MaCB and c.SBDi = 'MIA' and l.NgayDi = '1/11/2000'
group by c.SBDi, l.NgayDi

--Câu 23: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên, sắp xếp giảm dần theo số lượng
select l.MaCB, l.NgayDi, count(p.MaNV) as SoLuongNhanVien
from ChuyenBay c, LichBay l, PhanCong p
where c.MaCB = l.MaCB and l.MaCB = p.MaCB and l.NgayDi = p.NgayDi
group by l.MaCB, l.NgayDi
order by count(p.MaNV) desc

--Câu 24: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã đặt chỗ trên chuyến bay đó, sắp giảm dần số lượng
select l.MaCB, l.NgayDi, count(d.MaKH) as SoLuongHanhKhach
from DatCho d, LichBay l, ChuyenBay c
where d.MaCB = l.MaCB and d.NgayDi = l.NgayDi and l.MaCB = c.MaCB
group by l.MaCB, l.NgayDi 
order by count(d.MaKH) desc

--Câu 25: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của các nhân viên, sắp tăng theo tổng lương
select l.MaCB, l.NgayDi, sum(Luong) as TongLuongPhiHanhDoan
from LichBay l, NhanVien n, PhanCong p
where l.MaCB = p.MaCB and l.NgayDi = p.NgayDi and p.MaNV = n.MaNV
group by l.MaCB, l.NgayDi 
order by sum(Luong) asc

--Câu 26: Cho biết lương trung bình của các nhân viên không phải là phi công
select avg(Luong) as LuongTrungBinhPhiCong
from NhanVien
where LoaiNV <> 1

--Câu 27: Lương trung bình của các phi công
select avg(Luong) as LuongTrungBinh
from NhanVien
where LoaiNV = 1

--Câu 28: Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay đó hạ cánh xuống ORD
select SoHieu, MaLoai, count(c.MaCB) as SoLuongChuyenBay
from LichBay l, ChuyenBay c
where l.MaCB = c.MaCB and c.SBDen = 'ORD'
group by SoHieu, MaLoai

--Câu 29: Cho biết sân bay (SBDi) và số lượng chuyến bay có nhiều hơn 2 chuyến bay xuất phát trong khoảng 10h đến 22h
select SBDi, count(MaCB) as SoLuongChuyenBay
from ChuyenBay c
where datepart(hh,GioDi) between 10 and 22
group by SBDi
having count(MaCB) > 2

--Câu 30: Cho biết tên phi công được phân công ít nhất 2 chuyến bay trong cùng một ngày
select n.MaNV, TenNV, p.NgayDi, count(p.MaNV) as SoLuongChuyenBay
from NhanVien n, PhanCong p
where p.MaNV = n.MaNV and n.LoaiNV = 1
group by n.MaNV, TenNV, p.NgayDi
having count(p.MaNV) >= 2

--Câu 31: Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3 khách hàng đặt chỗ
select l.MaCB, l.NgayDi, count(d.MaKH) as SoLuongKhachHang
from LichBay l, DatCho d
where l.MaCB = d.MaCB and l.NgayDi = d.NgayDi
group by l.MaCB, l.NgayDi
having count(d.MaKH) < 3

--Câu 32: Cho biết số hiệu máy bay và mã loại máy bay mà phi công mang mã số 1001 được phân công lái trên 2 lần
select l.SoHieu, l.MaLoai, count(l.SoHieu) as SoLanLai
from PhanCong p, LichBay l
where p.MaNV = '1001' and p.MaCB = l.MaCB and p.NgayDi = l.NgayDi
group by l.SoHieu, l.MaLoai
having count(l.SoHieu) > 2

--Câu 33: Với mỗi hãng sản xuất cho biết số lượng loại máy bay mà hãng đó sản xuất
select HangSX, count(MaLoai) as SoLuongSanXuat
from LoaiMB
group by HangSX

--Câu 34: Cho biết hãng sản xuất, mã loại và số hiệu của máy bay được sử dụng nhiều nhất
select l.HangSX, l.MaLoai, b.SoHieu, count(b.MaCB) as SoLanBay
from LoaiMB l, LichBay b
where l.MaLoai=b.MaLoai
group by l.HangSX, l.MaLoai, b.SoHieu
having count(b.MaCB) >= all (select count(MaCB)
							from LichBay 
							group by SoHieu, MaLoai)

--Câu 35: Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất
select n.MaNV, TenNV, count(p.MaNV) as SoLanBay
from NhanVien n, PhanCong p
where n.MaNV = p.MaNV
group by n.MaNV, TenNV
having count(MaCB) >= all(select count(MaCB)
							from PhanCong p, NhanVien n
							where p.MaNV=n.MaNV
							group by p.MaNV)

--Câu 36: Cho biết thông tin của phi công (tên, địa chỉ, số điện thoại) lái nhiều chuyến bay nhất
select n.MaNV, TenNV, count(p.MaNV) as SoLanLaiNhieuNhat
from NhanVien n, PhanCong p, LichBay l
where n.MaNV = p.MaNV and p.MaCB=l.MaCB and p.NgayDi=l.NgayDi and n.LoaiNV = 1
group by n.MaNV, TenNV
having count(p.MaNV) >= all(select count(p.MaNV) as SoLanLaiNhieuNhat
							from NhanVien n, PhanCong p, LichBay l
							where n.MaNV = p.MaNV and p.MaCB=l.MaCB and p.NgayDi=l.NgayDi and n.LoaiNV = 1
							group by n.MaNV, TenNV)

--Câu 37: Cho biết sân bay (SBDen) và số lượng chuyến bay của sân bay có ít chuyến bay đáp nhất
select SBDen, count(MaCB) as SoChuyenBayDapItNhat
from ChuyenBay
group by SBDen
having count(MaCB) <= all (select count(MaCB)
							from ChuyenBay
							group by SBDen)

--Câu 38: Cho biết sân bay (SBDi) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất phát nhất
select SBDi, count(MaCB) as SoChuyenBayXuatPhatNhieuNhat
from ChuyenBay
group by SBDi
having count(MaCB) >= all (select count(MaCB)
							from ChuyenBay
							group by SBDi)

--Câu 39: Cho biết tên, địa chỉ và số điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất
select k.Ten, k.DChi, DThoai, count(d.MaCB) as SoLuotBay
from KhachHang k, DatCho d
where k.MaKH = d.MaKH
group by k.Ten, k.DChi, DThoai
having count(d.MaCB) >= all(select count(MaCB)
							from DatCho
							group by MaKH)

--Câu 40: Cho biết mã số, tên, lương của các phi công có khả năng lái nhiều loại máy bay nhất
select n.MaNV, TenNV, Luong, count(k.MaLoai) as SoMayBayCoTheLai
from NhanVien n, KhaNang k
where n.MaNV = k.MaNV
group by  n.MaNV, TenNV, Luong
having count(k.MaLoai) >= all(select count(MaLoai)
							from KhaNang
							group by MaNV)

--Câu 41: Cho biết thông tin của nhân viên có mức lương cao nhất
select *
from NhanVien
where Luong = (select max(Luong)
				from NhanVien)

--Câu 42: Cho biết tên, địa chỉ của các nhân viên có lương cao nhất trong phi hành đoàn (các nhân viên được phân công trong một chuyến bay)
select TenNV, DChi, Luong, MaCB, NgayDi
from NhanVien n, PhanCong p
where n.MaNV = p.MaNV and Luong >= all(select Luong
										from NhanVien n, PhanCong p
										where n.MaNV = p.MaNV
										group by  Luong, NgayDi)
group by Luong, MaCB, NgayDi, TenNV, DChi

--Câu 43: Cho biết mã chuyến bay, giờ đi, giờ đến của chuyến bay sớm nhất trong ngày 
select NgayDi, c.MaCB, GioDi, GioDen
from LichBay l, ChuyenBay c
where l.MaCB = c.MaCB
group by c.MaCB, GioDi, GioDen, NgayDi
having GioDi <= all (select GioDi
					from LichBay l, ChuyenBay c
					where l.MaCB = c.MaCB
					group by NgayDi, GioDi)

--Câu 44: Cho biết chuyến bay có thời gian bay dài nhất
select MaCB, SBDi, SBDen, GioDi, GioDen, datediff(minute, GioDi, GioDen) as SoPhutBay
from ChuyenBay
group by MaCB, SBDi, SBDen, GioDi, GioDen
having datediff(minute , GioDi, GioDen) >= all(select datediff(minute, GioDi, GioDen)
												from ChuyenBay)

--Câu 45: Cho biết chuyến bay có thời gian bay ít nhất
select MaCB, SBDi, SBDen, GioDi, GioDen, datediff(minute, GioDi, GioDen) as SoPhutBay
from ChuyenBay
group by MaCB, SBDi, SBDen, GioDi, GioDen
having datediff(minute , GioDi, GioDen) <= all(select datediff(minute, GioDi, GioDen)
												from ChuyenBay)

--Câu 46: Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại máy bay B747 nhiều nhất
select l.MaCB, l.NgayDi, count(MaLoai) as SoLanBay
from  LichBay l
where MaLoai = 'B747'
group by l.MaCB, l.NgayDi
having count(MaCB) >= all (select count(MaCB)
							from LichBay
							where MaLoai = 'B747'
							group by MaCB, NgayDi)

--Câu 47: Với mỗi chuyến bay có trên 3 khách hàng, cho biết mã chuyến bay và số lượng nhân viên trên chuyến bay đó
select p.MaCB, p.NgayDi, count(p.MaNV) as SoLuongNV
from PhanCong p, (select MaCB, NgayDi
				from DatCho
				group by MaCB, NgayDi
				having count(MaKH) >= 3) as c
where p.MaCB = c.MaCB and p.NgayDi = c.NgayDi
group by p.MaCB, p.NgayDi

--Câu 48: Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng nhân viên trong từng loại nhân viên đó
select LoaiNV, count(LoaiNV) as SoLuong, sum(Luong) as TongLuong
from NhanVien
group by LoaiNV
having sum(Luong) > 600000

--Câu 49: Với mỗi chuyến bay có trên 3 nhân viên, cho biết số lượng khách trên chuyến bay đó
select d.MaCB, d.NgayDi, count(MaKH) as SoLuongKH
from DatCho d, (select MaCB, NgayDi
				from PhanCong
				group by MaCB, NgayDi
				having count(MaNV)>3) as c
where d.MaCB=c.MaCB and d.NgayDi=c.NgayDi
group by d.MaCB, d.NgayDi

--Câu 50: Với mỗi loại máy bay có nhiều hơn 1 chiếc, cho biết số lượng chuyến bay đã được bố trí bay bằng loại máy bay đó
select m.MaLoai, count(MaCB) as SoLuongCB
from MayBay m, LichBay l
where m.SoHieu=l.SoHieu and m.MaLoai=l.MaLoai
group by m.MaLoai
having count (m.SoHieu) > 1

--Câu 51: Cho biết chuyến bay nào đã bay tất cả các máy bay của hãng Boeing
select *
from ChuyenBay
where MaCB in (select MaCB
			from LichBay
			where MaLoai like 'B%'
			group by MaCB, MaLoai
			having count(MaLoai) = (select count(MaLoai)
									from LoaiMB
									where HangSX = 'Boeing'))

--Câu 52: Cho biết phi công có khả năng lái tất cả các máy bay của hãng AirBus
select *
from NhanVien
where MaNV in (select MaNV
			from KhaNang
			where MaLoai like 'A%'
			group by MaNV
			having count(MaLoai) = (select count(MaLoai)
									from LoaiMB
									where HangSX = 'Airbus'))

--Câu 53: Cho biết tên nhân viên (không phải là phi công) được phân công vào tất cả các chuyến bay có mã 100
select p.MaNV
from PhanCong p, NhanVien n
where p.MaCB = '100' and n.MaNV = p.MaNV and n.LoaiNV <> 1 and p.NgayDi in (select NgayDi
																			from PhanCong
																			where MaCB = '100'
																			group by NgayDi)
group by p.MaNV