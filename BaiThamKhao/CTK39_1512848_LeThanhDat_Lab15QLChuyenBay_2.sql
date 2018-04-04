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

--1) Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công đã từng lái máy bay loại B747
	select n.MaNV, n.TenNV, n.DiaChi, n.DThoai
	from NhanVien n, PhanCong p, LichBay l
	where p.MaCB = l.MaCB and p.NgayDi = l.NgayDi 
		and l.MaLoai = 'B747'
		and n.MaNV = p.MaNV and n.LoaiNV = 1

	
--2) Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay DCA trong khoản thời gian từ 14g đến 18g
	select c.MaCB, l.NgayDi
	from ChuyenBay c, LichBay l
	where c.MaCB = l.MaCB and c.SBDi = 'DCA' and (datepart(hh,c.GioDi) between 14 and 18)
	-- Hàm lấy giờ trong time.. datepart(hh, <time>)

--3) Cho biết tên những nhân viên được phân công trên chuyến bay có mã số 100 xuất phát tại sân bay SLC
	select n.MaNV, n.TenNV
	from ChuyenBay c, LichBay l, PhanCong p, NhanVien n
	where c.MaCB = 100 
		and l.MaCB = c.MaCB 
		and p.MaCB = l.MaCB 
		and p.NgayDi = l.NgayDi
		and p.MaNV = n.MaNV
	group by n.MaNV, n.TenNV

--4) Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA
	select l.SoHieu, l.MaLoai
	from ChuyenBay c, LichBay l
	where c.MaCB = l.MaCB 
		  and SBDi = 'MIA'
	group by l.SoHieu, l.MaLoai
	
--5) Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, số điện thoại của tất cả các hành khách đi trên chuyến bay đó.
	--sắp xếp tăng dần theo mã chuyến bay và giảm dần theo ngày đi
	select l.MaCB, l.NgayDi, k.TenKH, k.DiaChi,k.DThoai
	from KhachHang k, DatCho d, LichBay l
	where k.MaKH = d.MaKH
		  and d.MaCB = l.MaCB
		  and d.NgayDi = l.NgayDi
	order by MaCB ASC, NgayDi DESC

-- Câu 6: Cho biết mã chuyến bay, ngày đi ,tên ,địa chỉ , điện thoại của tất cả những nhân viên được phân công trong chuyến bay đó. Sắp xếp
-- theo thứ tự tăn dần của mã chuyến bay  và theo ngày đi giảm dần.
	select l.MaCB, l.NgayDi, n.TenNV, n.DiaChi, n.DThoai
	from NhanVien n, PhanCong p, LichBay l
	where n.MaNV = p.MaNV
		  and p.MaCB = l.MaCB
		  and p.NgayDi = l.NgayDi
	order by l.NgayDi desc, l.MaCB asc


-- Câu 7: Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công 
-- được phân công vào chuyến bay hạ cánh xuống sân bay ORD
	select l.MaCB, l.NgayDi, n.MaNV, n.TenNV
	from NhanVien n, PhanCong p, ChuyenBay c, LichBay l
	where p.MaCB = l.MaCB
		and p.NgayDi = l.NgayDi
		and l.MaCB = c.MaCB
		and n.MaNV = p.MaNV 
		and n.LoaiNV = 1
		and c.SBDen = 'ORD'

-- Câu 8: Cho biết mã chuyến bay, ngày đi, tên của phi công 
-- có mã 1001 được phân công lái chuyến bay đó 
	select p.MaCB, p.NgayDi, n.TenNV
	from NhanVien n, PhanCong p
	where n.MaNV = p.MaNV
		and n.MaNV = '1001'

-- Câu 9: Thông tin những chuyến bay hạ cánh xuống DEN. 
-- Sắp xếp theo ngày đi giảm dần và sân bay xuất phát tăng dần
	select c.MaCB, l.NgayDi, c.SBDi, c.SBDen, convert(char(5), c.GioDi) as GioDi, convert(char(5), c.GioDen) as GioDen
	from ChuyenBay c, LichBay l
	where c.MaCB = l.MaCB
		and c.SBDen = 'DEN'
	group by c.MaCB, l.NgayDi, c.SBDi, c.SBDen, c.GioDi, c.GioDen
	order by l.NgayDi desc, c.SBDi asc  -------bi trung--- ????

-- Câu 10: Cho biết hãng sản xuất và mã loại máy bay mà 
-- phi công có khả năng bay được
	select l.HangSX, l.MaLoai
	from KhaNang k, LoaiMB l
	where k.MaLoai = l.MaLoai
	group by l.HangSX, l.MaLoai
	
-- Câu 11: Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay số 100 ngày 11/01/2000
	select n.MaNV, n.TenNV
	from PhanCong p, NhanVien n
	where p.MaNV = n.MaNV
		and p.NgayDi = '1/11/2000'
		and p.MaCB = '100'
		and n.LoaiNV = 1		
	group by  n.MaNV, n.TenNV

-- Câu 12: Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công vào chuyến bay ngày 31/10/2000
-- tại MIA lúc 20:30
	select c.MaCB, n.MaNV, n.TenNV
	from ChuyenBay c, PhanCong p, NhanVien n
	where p.MaCB = c.MaCB
		and p.MaNV = n.MaNV
		and p.NgayDi = '31/10/2000'
		and c.GioDi like '20:30%'
		and c.SBDi = 'MIA'

-- Câu 13: Cho biết thông tin về các chuyến bay mà phi công Quang đã lái
	select l.MaCB, l.SoHieu, l.MaLoai, lmb.HangSX
	from NhanVien n, PhanCong p, LichBay l, MayBay mb ,LoaiMB lmb
	where n.MaNV = p.MaNV 
		and n.TenNV = 'Quang' and n.LoaiNV = 1
		and p.MaCB = l.MaCB 
		and p.NgayDi = l.NgayDi
		and l.MaLoai = mb.MaLoai
		and mb.MaLoai = lmb.MaLoai
	group by l.MaCB, l.SoHieu, l.MaLoai, lmb.HangSX

-- Câu 14: Cho biết tên những phi công chưa được phân công lái máy bay chuyến nào
	select MaNV, TenNV, LoaiNV
	from NhanVien 
	where LoaiNV = 1
		and MaNV not in ( select n.MaNV
						from PhanCong p, NhanVien n
						where p.MaNV = n.MaNV
							and n.LoaiNV = 1
						group by n.MaNV)

-- Câu 15: Cho biết tên khách hàng đã di chuyển trên máy bay của hãng Boeing
	select k.MaKH, k.TenKH
	from KhachHang k, DatCho d, LichBay l, MayBay mb, LoaiMB lmb
	where k.MaKH = d.MaKH and d.MaCB = l.MaCB 
		and l.MaLoai = mb.MaLoai and mb.MaLoai = lmb.MaLoai
		and lmb.HangSX = 'Boeing'
	group by k.MaKH, k.TenKH

-- Câu 16: Cho biết các chuyến bay chỉ bay với số hiệu 10 và mã loại B747
	select distinct MaCB, SoHieu, MaLoai
	from LichBay
	where MaCB not in (select MaCB
					from LichBay
					where SoHieu <> '10' or MaLoai <> 'B747')	

---------- Gom nhóm + hàm
-- Câu 17: Với mỗi sân bay (SBDen), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó, sắp xếp theo tên sân bay
	select SBDen, count(SBDen) as SoLuongHaCanh
	from ChuyenBay
	group by SBDen
	order by SBDen asc

-- Câu 18: Với mỗi sân bay (SBDi), cho biết số lượng chuyến bay xuất phát sân bay đó, sắp xếp theo tên sân bay
	select SBDi, count(SBDi) as SoLuongCatCanh
	from ChuyenBay
	group by SBDi
	order by SBDi asc

-- Câu 19: Với mỗi sân bay(SBDi), cho biết số lượng chuyến bay xuất phát theo từng ngày
	select convert(char(10), l.NgayDi, 103) as NgayDi, c.SBDi, count(c.SBDi) as SoLuongXuatPhat
	from ChuyenBay c, LichBay l
	where l.MaCB = c.MaCB
	group by l.NgayDi, c.SBDi
	order by l.NgayDi

-- Câu 20: Với mỗi sân bay(SBDen), cho biết số lượng chuyến bay hạ cánh theo từng ngày
	select convert(char(10), l.NgayDi, 103) as NgayDi, c.SBDen, count(c.SBDen) as SoLuongHaCanh
	from ChuyenBay c, LichBay l
	where l.MaCB = c.MaCB
	group by l.NgayDi, c.SBDen
	order by l.NgayDi

-- Câu 21: Cho biết mã chuyến bay, ngày đi cùng với số lượng nhân viên không phải là phi công trên chuyến bay đó
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(p.MaNV) as SoLuongNhanVien
	from PhanCong p, LichBay l, NhanVien n
	where p.MaCB = l.MaCB
		and p.NgayDi = l.NgayDi
		and p.MaNV = n.MaNV
		and n.LoaiNV <> 1
	group by l.MaCB, l.NgayDi
	order by l.NgayDi asc

-- Câu 22: Số lượng chuyến bay xuất phát từ sân bay MIA ngày 1/11/2000
	select c.SBDi, l.NgayDi, count(c.SBDi) as SoLuongChuyenBayDi
	from LichBay l, ChuyenBay c
	where l.MaCB = c.MaCB
		and c.SBDi = 'MIA' 
		and l.NgayDi = '1/11/2000'
	group by c.SBDi, l.NgayDi

-- Câu 23: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên, sắp xếp giảm dần thêo số lượng
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(p.MaNV) as SoLuongNhanVien
	from ChuyenBay c, LichBay l, PhanCong p
	where c.MaCB = l.MaCB
		and l.MaCB = p.MaCB and l.NgayDi = p .NgayDi
	group by l.MaCB, l.NgayDi
	order by count(p.MaNV) desc

-- Câu 24: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã đặt chỗ trên chuyến bay đó, sắp giảm dần số lượng
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(d.MaKH) as SoLuongHanhKhach
	from DatCho d, LichBay l, ChuyenBay c
	where d.MaCB = l.MaCB and d.NgayDi = l.NgayDi
		and l.MaCB = c.MaCB
	group by l.MaCB, l.NgayDi 
	order by count(d.MaKH) desc

-- Câu 25: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của các nhân viên, sắp tăng theo tổng lương
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, sum(n.Luong) as TongLuongPhiHanhDoan
	from LichBay l, NhanVien n, PhanCong p
	where l.MaCB = p.MaCB and l.NgayDi = p.NgayDi
		and p.MaNV = n.MaNV
	group by l.MaCB, l.NgayDi 
	order by sum(n.Luong) asc

-- Câu 26: Cho biết lương trung bình của các nhân viên không phải là phi công
	select avg(Luong) as LuongTrungBinhPhiCong
	from NhanVien
	where LoaiNV <> 1

-- Câu 27: Lương trung bình của các phi công
	select avg(Luong) as LuongTrungBinhPhiCong
	from NhanVien
	where LoaiNV = 1

-- Câu 28: Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay đó hạ cánh xuống ORD
	select mb.SoHieu, mb.MaLoai, count(c.SBDen) as SoLuongChuyenBay
	from MayBay mb, LichBay l, ChuyenBay c
	where l.MaCB = c.MaCB 
		and l.SoHieu = mb.SoHieu and l.MaLoai = mb.MaLoai
		and c.SBDen = 'ORD'
	group by mb.SoHieu, mb.MaLoai

-- Câu 29: Cho biết sân bay(SBDi) và số lượng chuyến bay có nhiều hơn 2 chuyến bay xuất phát trong khoảng 10g đến 22g
	select SBDi, count(SBDi) as SoLuongChuyenBay
	from ChuyenBay c
	where datepart(hh,GioDi) between 10 and 22
	group by SBDi
	having count(SBDi) > 2

-- Câu 30: Cho biết tên phi công được phân công ít nhất 2 chuyến bay trong cùng một ngày
	select n.MaNV, n.TenNV, convert(char(10), p.NgayDi, 103) as NgayBay, count(p.MaNV) as SoLuongChuyenBay
	from NhanVien n, LichBay l, PhanCong p
	where l.MaCB = p.MaCB and l.NgayDi = p.NgayDi
		and p.MaNV = n.MaNV and n.LoaiNV = 1
	group by n.MaNV, n.TenNV, p.NgayDi
	having count(p.MaNV) >= 2

-- Câu 31: Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3 khách hàng đặt chỗ
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(d.MaKH) as SoLuongKhachHang
	from LichBay l, DatCho d
	where l.MaCB = d.MaCB and l.NgayDi = d.NgayDi
	group by l.MaCB, l.NgayDi
	having count(d.MaKH) < 3

-- Câu 32: Cho biết số hiệu máy bay và mã loại máy bay mà phi công mang mã số 1001 được phân công lái trên 2 lần
	select l.SoHieu, l.MaLoai, count(l.SoHieu) as SoLanLai
	from PhanCong p, LichBay l
	where p.MaNV = '1001'
		and p.MaCB = l.MaCB and p.NgayDi = l.NgayDi
	group by l.SoHieu, l.MaLoai
	having count(l.SoHieu) > 2

-- Câu 33: Với mỗi hãng sản xuất cho biết số lượng loại máy bay mà hãng đố sản xuất
	select HangSX, count(MaLoai) as SoLuongSanXuat
	from LoaiMB
	group by HangSX

---------- Truy vấn lồng + hàm
-- Câu 34: Cho biết hãng sản xuất, mã loại và số hiệu của máy bay được sử dụng nhiều nhất
	select lmb.HangSX, l.MaLoai, l.SoHieu, count(l.MaCB) as SoLanBay
	from LoaiMB lmb, MayBay mb, LichBay l
	where lmb.MaLoai = mb.MaLoai
		and l.SoHieu = mb.SoHieu and l.MaLoai = mb.MaLoai
	group by lmb.HangSX, l.MaLoai, l.SoHieu
	having count(l.MaCB) >= all
					(select count(MaCB)
					from LichBay 
					group by SoHieu, MaLoai)

-- Câu 35: Cho biết tên phi công được phân công đi nhiều chuyến bay nhất
	select n.MaNV, n.TenNV, count(p.MaNV) as SoLanBay
	from NhanVien n, PhanCong p
	where n.MaNV = p.MaNV
	group by n.MaNV, n.TenNV
	having count(p.MaNV) >= all(
					select count(p.MaNV)
					from PhanCong p, NhanVien n
					where p.MaNV = n.MaNV
					group by p.MaNV)

-- Câu 36: Cho biết thông tin của phi công(tên, địa chỉ, số điện thoại) lái nhiều chuyến bay nhất
	select n.MaNV, n.TenNV, count(p.MaNV) as SoLanLaiNhieuNhat
	from NhanVien n, PhanCong p
	where n.MaNV = p.MaNV and n.LoaiNV = 1
	group by n.MaNV, n.TenNV
	having count(p.MaNV) >= all(
					select count(p.MaNV)
					from PhanCong p, NhanVien n
					where p.MaNV = n.MaNV and n.LoaiNV = 1
					group by p.MaNV)

-- Câu 37: Cho biết sân bay(SBDen) và số lượng chuyến bay của sân bay có ít chuyến bay đáp nhất
	select SBDen, count(SBDen) as SoChuyenBayDapItNhat
	from ChuyenBay
	group by SBDen
	having count(SBDen) <= all (
					select count(SBDen)
					from ChuyenBay
					group by SBDen)

-- Câu 38: Cho biết sân bay(SBDi) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất phát nhất
	select SBDi, count(SBDi) as SoChuyenBayXuatPhatNhieuNhat
	from ChuyenBay
	group by SBDi
	having count(SBDi) >= all (
					select count(SBDi)
					from ChuyenBay
					group by SBDi)

-- Câu 39: Cho biết tên, địa chỉ và số điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất
	select k.TenKH, k.DiaChi, k.DiaChi, count(d.MaKH) as SoLuotBay
	from KhachHang k, DatCho d
	where k.MaKH = d.MaKH
	group by k.TenKH, k.DiaChi, k.DiaChi
	having count(d.MaKH) >= all(
						select count(MaKH)
						from DatCho
						group by MaKH)

-- Câu 40: Cho biết mã số, tên, lương của các phi công có khả năng lái nhiều loại máy bay nhất
	select n.MaNV, n.TenNV, n.Luong, count(k.MaNV) as SoMayBayCoTheLai
	from NhanVien n, KhaNang k
	where n.MaNV = k.MaNV
	group by  n.MaNV, n.TenNV, n.Luong
	having count(k.MaNV) >= all(
						select count(MaNV)
						from KhaNang
						group by MaNV)

-- Câu 41: Cho biết thông tin của nhân viên có mức lương cao nhất
	select MaNV, TenNV, DiaChi, DThoai, Luong, LoaiNV
	from NhanVien
	where Luong = (select max(Luong)
					from NhanVien)

-- Câu 42: Cho biết tên, địa chỉ của các nhân viên có lương cao nhất trong phi hành đoàn
-- (các nhân viên được phân công trong một chuyến bay)
	select n.TenNV, n.DiaChi, n.Luong, p.MaCB, p.NgayDi
	from NhanVien n, PhanCong p
	where n.MaNV = p.MaNV and n.Luong >= all(
										select n.Luong
										from NhanVien n, PhanCong p
										where n.MaNV = p.MaNV
										group by  n.Luong, p.MaCB, p.NgayDi)
	-- Các chuyến bay 
	select NgayDi, MaCB
	from PhanCong
	group by NgayDi, MaCB

-- Câu 43: Cho biết mã chuyến bay, giờ đi, giờ đến của chuyến bay sớm nhất trong ngày 
	select c.MaCB, convert(char(5), c.GioDi) as GioDi , convert(char(5), c.GioDen) as GioDen, convert(char(10), l.NgayDi, 103) as NgayDi
	from LichBay l, ChuyenBay c
	where l.MaCB = c.MaCB
	group by c.MaCB, c.GioDi, c.GioDen, l.NgayDi
	having c.GioDi <= all
				(select c.GioDi
					from LichBay l, ChuyenBay c
					where l.MaCB = c.MaCB
					group by l.NgayDi, c.GioDi)

-- Câu 44: Cho biết chuyến bay có thời gian bay dài nhất
	select MaCB, SBDi, SBDen, convert(char(5), GioDi) as GioDi , convert(char(5), GioDen) as GioDen, datediff(minute, GioDi, GioDen) as SoPhutBay
	from ChuyenBay
	group by MaCB, SBDi, SBDen, GioDi, GioDen
	having datediff(minute , GioDi, GioDen) >= all(
											select datediff(minute, GioDi, GioDen)
											from ChuyenBay)

-- Câu 45: Cho biết chuyến bay có thời gian bay ít nhất
	select MaCB, SBDi, SBDen, convert(char(5), GioDi) as GioDi , convert(char(5), GioDen) as GioDen, datediff(minute, GioDi, GioDen) as SoPhutBay
	from ChuyenBay
	group by MaCB, SBDi, SBDen, GioDi, GioDen
	having datediff(minute , GioDi, GioDen) <= all(
											select datediff(minute, GioDi, GioDen)
											from ChuyenBay)

-- Câu 46: Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại máy bay B747 nhiều nhất
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(MaLoai) as SoLanBayVoiB747
	from  LichBay l
	where MaLoai = 'B747'
	group by l.MaCB, l.NgayDi
	having count(MaLoai) >= all (select count(MaLoai)
								from LichBay
								where MaLoai = 'B747'
								group by MaCB, NgayDi)
	order by MaCB desc


-- Câu 47: Với mỗi chuyến bay có trên 3 khách hàng, cho biết mã chuyến bay và số lượng nhân viên trên chuyến bay đó
	select p.MaCB, p.NgayDi, count(p.MaNV) as SoLuongNV
	from PhanCong p, (select MaCB, NgayDi
					from DatCho
					group by MaCB, NgayDi
					having count(MaKH) >= 3) as c
	where p.MaCB = c.MaCB and p.NgayDi = c.NgayDi
	group by p.MaCB, p.NgayDi

	-- Các chuyến bay có trên 3 khách hàng
	select l.MaCB, l.NgayDi
	from KhachHang k, DatCho d, LichBay l
	where k.MaKH = d.MaKH and d.MaCB = l.MaCB and d.NgayDi = l.NgayDi			
	group by l.MaCB, l.NgayDi
	having count(d.MaKH) >= 3

	-- Đếm số lượng khách trên mỗi chuyến bay
	select l.MaCB, convert(char(10), l.NgayDi, 103) as NgayDi, count(d.MaKH) as 'Số lượng khách trên chuyến bay'
	from KhachHang k, DatCho d, LichBay l
	where k.MaKH = d.MaKH and d.NgayDi = l.NgayDi and d.MaCB = l.MaCB
	group by l.MaCB, l.NgayDi


-- Câu 48: Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng nhân viên trong từng loại nhân viên đó
	select LoaiNV, count(LoaiNV) as SoLuong, sum(Luong) as TongLuong
	from NhanVien
	group by LoaiNV
	having sum(Luong) > 600000

-- Câu 49: Với mỗi chuyến bay có trên 3 nhân viên, cho biết số lượng khách trên chuyến bay đó
	
-- Câu 50: Với mỗi loại máy bay có nhiều hơn 1 chiếc, cho biết số lượng chuyến bay đã được bố trí bay bằng loại máy bay đó
	select MaLoai, count(MaLoai) as SoLuongChuyenBayDuocSapXep
	from LichBay
	group by MaLoai
	having MaLoai in ( select mb.MaLoai
					from MayBay mb
					group by mb.MaLoai
					having count(mb.MaLoai) > 1)
	
	-- error
	select mb.MaLoai, count(mb.MaLoai) as SoLuong, count(l.MaLoai) as SoLuongChuyenBayDuocBoTri
	from MayBay mb, LichBay l
	where mb.SoHieu = l.SoHieu and mb.MaLoai = l.MaLoai
	group by mb.MaLoai
	having count(mb.MaLoai) > 1	

    --- So Luong moi loai may bay
	select mb.MaLoai, count(mb.MaLoai) as SoLuong
	from MayBay mb
	group by mb.MaLoai
	having count(mb.MaLoai) > 1

---------- Phép chia -----
-- Câu 51: Cho biết chuyến bay nào đã bay tất cả các máy bay của hãng Boeing
	select MaCB, SBDi, SBDen, convert(char(5), GioDi) as GioDi , convert(char(5), GioDen) as GioDen
	from ChuyenBay
	where MaCB in (select MaCB --, count(MaLoai)
				from LichBay
				where MaLoai like 'B%'
				group by MaCB
				having count(MaLoai) = (select count(MaLoai)
									from LoaiMB
									where HangSX = 'Boeing'))
	-- đếm tất cả máy bay của hãng Boeing --> trong bảng lichbay đếm theo mã chuyến bay số lượng chuyến bay dùng mã B% của hãng Boeing
	-- nếu bằng với số lượng máy bay hãng Boeing thì xuất chuyenbay theo macb thì bảng lichbay

-- Câu 52: Cho biết phi công có khả năng lái tất cả các máy bay của hãng AirBus
	select *
	from NhanVien
	where MaNV in (select MaNV --, count(MaLoai)
				from KhaNang
				where MaLoai like 'A%'
				group by MaNV
				having count(MaLoai) = (select count(MaLoai)
									from LoaiMB
									where HangSX = 'Airbus'))
	-- đếm all số ml của hãng airbus -> trong bảng khanang đếm theo từng nv số lượng máy bay hãng airbus có thể lái
	-- nếu số lượng lái = số lượng máy bay hãng airbus thì xuất phi công ra


-- Câu 53: Cho biết tên nhân viên(không phải là phi công) được phân công vào tất cả các chuyến bay có mã 100
	select *
	from NhanVien
	where LoaiNV <> 1
		and MaNV in (select p.MaNV
				from PhanCong p, NhanVien n
				where p.NgayDi in (select NgayDi
								from PhanCong
								where MaCB = '100'
								group by NgayDi) and p.MaCB = '100'
					and n.MaNV = p.MaNV
					and n.LoaiNV <> 1
				group by p.MaNV)				
	
	select *
	from NhanVien
	where LoaiNV <> 1
		and MaNV in (select MaNV
				from PhanCong
				where (select MaCB, NgayDi) in (select MaCB, NgayDi
										from PhanCong
										where MaCB = '100'
										group by MaCB, NgayDi)
	group by MaNV)