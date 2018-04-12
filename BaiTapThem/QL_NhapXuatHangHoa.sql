/* Môn: Cơ sở dữ liệu
   Bài lab: QL_NhapXuatHangHoa
   Thực hiện: La Quốc Thắng
   MSSV: 1610207
   Ngày: 11/4/2018 
*/
---------------------------------------------------------------------------------------

create database QL_NhapXuatHangHoa

use QL_NhapXuatHangHoa

go
create table HangHoa
(
	MaHH varchar(5) primary key,
	TenHH varchar(30) not null unique,
	DVT nvarchar(3) not null,
	SoLuongTon tinyint
)

go
create table DoiTac
(
	MaDT varchar(5) primary key,
	TenDT nvarchar(30) not null,
	DiaChi nvarchar(35),
	DienThoai varchar(12)
)

go
create table KhaNangCC
(
	MaDT varchar(5) references DoiTac(MaDT),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(MaDT, MaHH)
)

go
create table HoaDon
(
	SoHD varchar(5) primary key,
	NgayLapHD date not null,
	MaDT varchar(5) references DoiTac(MaDT),
	TongTG float
)

go
create table CT_HoaDon
(
	SoHD varchar(5) references HoaDon(SoHD),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(SoHD, MaHH),
	DonGia int not null,
	SoLuong tinyint not null
)

insert into HangHoa values('CPU01','CPU INTEL, CELERON 600 BOX',N'CÁI','5')
insert into HangHoa values('CPU02','CPU INTEL, PIII 700',N'CÁI','10')
insert into HangHoa values('CPU03','CPU AMD K7 ATHL,ON 600',N'CÁI','8')
insert into HangHoa values('HDD01','HDD 10.2 GB QUANTUM',N'CÁI','10')
insert into HangHoa values('HDD02','HDD 13.6 GB SEAGATE',N'CÁI','15')
insert into HangHoa values('HDD03','HDD 20 GB QUANTUM',N'CÁI','6')
insert into HangHoa values('KB01','KB GENIUS',N'CÁI','12')
insert into HangHoa values('KB02','KB MITSUMIMI',N'CÁI','5')
insert into HangHoa values('MB01','GIGABYTE CHIPSET INTEL',N'CÁI','10')
insert into HangHoa values('MB02','ACOPR BX CHIPSET VIA',N'CÁI','10')
insert into HangHoa values('MB03','INTEL PHI CHIPSET INTEL',N'CÁI','10')
insert into HangHoa values('MB04','ECS CHIPSET SIS',N'CÁI','10')
insert into HangHoa values('MB05','ECS CHIPSET VIA',N'CÁI','10')
insert into HangHoa values('MNT01','SAMSUNG 14" SYNCMASTER',N'CÁI','5')
insert into HangHoa values('MNT02','LG 14"',N'CÁI','5')
insert into HangHoa values('MNT03','ACER 14"',N'CÁI','8')
insert into HangHoa values('MNT04','PHILIPS 14"',N'CÁI','6')
insert into HangHoa values('MNT05','VIEWSONIC 14"',N'CÁI','7')

insert into DoiTac values('CC001','Cty TNC',N'176 BTX Q1 - TP.HCM','08.8250259')
insert into DoiTac values('CC002',N'Cty Hoàng Long','15A TTT Q1 - TP.HCM','08.8250898')
insert into DoiTac values('CC003',N'Cty Hợp Nhất','152 BTX Q1 - TP.HCM','08.8252376')
insert into DoiTac values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063.831129')
insert into DoiTac values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DoiTac values('K0003',N'Trần Nhật Duật',N'Lê Lợi Tp.Huế','054.848376')
insert into DoiTac values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khỡi Nghĩa Tp.Đà Lạt','063.823409')

set dateformat dmy	--Chỉnh định dạng ngày lại
insert into HoaDon values('N0001','25/1/2006','CC001','')
insert into HoaDon values('N0002','1/5/2006','CC002','')
insert into HoaDon values('X0001','12/5/2006','K0001','')
insert into HoaDon values('X0002','16/6/2006','K0002','')
insert into HoaDon values('X0003','20/4/2006','K0001','')

insert into KhaNangCC values('CC001','CPU01')
insert into KhaNangCC values('CC001','HDD03')
insert into KhaNangCC values('CC001','KB01')
insert into KhaNangCC values('CC001','MB02')
insert into KhaNangCC values('CC001','MB04')
insert into KhaNangCC values('CC001','MNT01')
insert into KhaNangCC values('CC002','CPU01')
insert into KhaNangCC values('CC002','CPU02')
insert into KhaNangCC values('CC002','CPU03')
insert into KhaNangCC values('CC002','KB02')
insert into KhaNangCC values('CC002','MB01')
insert into KhaNangCC values('CC002','MB05')
insert into KhaNangCC values('CC002','MNT03')
insert into KhaNangCC values('CC003','HDD01')
insert into KhaNangCC values('CC003','HDD02')
insert into KhaNangCC values('CC003','HDD03')
insert into KhaNangCC values('CC003','MB03')

insert into CT_HoaDon values('N0001','CPU01','63','10')
insert into CT_HoaDon values('N0001','HDD03','97','7')
insert into CT_HoaDon values('N0001','KB01','3','5')
insert into CT_HoaDon values('N0001','MB02','57','5')
insert into CT_HoaDon values('N0001','MNT01','112','3')
insert into CT_HoaDon values('N0002','CPU02','115','3')
insert into CT_HoaDon values('N0002','KB02','5','7')
insert into CT_HoaDon values('N0002','MNT03','111','5')
insert into CT_HoaDon values('X0001','CPU01','67','2')
insert into CT_HoaDon values('X0001','HDD03','100','2')
insert into CT_HoaDon values('X0001','KB01','5','2')
insert into CT_HoaDon values('X0001','MB02','62','1')
insert into CT_HoaDon values('X0002','CPU01','67','1')
insert into CT_HoaDon values('X0002','KB02','7','3')
insert into CT_HoaDon values('X0002','MNT01','115','2')
insert into CT_HoaDon values('X0003','CPU01','67','1')
insert into CT_HoaDon values('X0003','MNT03','115','2')

select * from HangHoa

select * from DoiTac

select * from KhaNangCC

select * from HoaDon

select * from CT_HoaDon

----------------------------TRUY VẤN DỮ LIỆU--------------------------------

--Câu 1: Liệt kê các mặt hàng thuộc loại đĩa cứng
select *
from HangHoa
where MaHH like 'HDD%'

--Câu 2: Liệt kê các mặt hàng có số lượng tồn trên 10
select *
from HangHoa
where SoLuongTon>10

--Câu 3: Cho biết thông tin của các nhà cung cấp ở Tp. Hồ Chí Minh
select *
from DoiTac
where DiaChi like '%HCM' and MaDT like 'CC%'

--Câu 4: Liệt kê các hóa đơn nhập hàng trong tháng 5/2006
select a.SoHD, NgayLapHD, TenDT, DiaChi, DienThoai, SUM(SoLuong)as SoMatHang
from HoaDon a, DoiTac b, CT_HoaDon c 
where a.MaDT=b.MaDT and a.SoHD=c.SoHD and MONTH(NgayLapHD)=5 and YEAR(NgayLapHD)=2006 and a.SoHD like 'N%'
group by a.SoHD, TenDT, DiaChi, DienThoai, NgayLapHD

--Câu 5: Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
select a.MaDT, TenDT
from DoiTac a, KhaNangCC b
where a.MaDT=b.MaDT and b.MaHH like 'HDD%' and a.MaDT like 'CC%'
group by a.MaDT, TenDT

--Câu 6: Cho biết tên các nhà cung cấp có thể cung cấp các loại đĩa cứng
select c.MaDT, TenDT
from HangHoa a, KhaNangCC b, DoiTac c
where a.MaHH=b.MaHH and c.MaDT=b.MaDT and a.MaHH like 'HDD%'
group by c.MaDT, TenDT
having COUNT(a.MaHH) = (select count(MaHH)
						from HangHoa
						where MaHH like 'HDD%')

--Câu 7: Cho biết tên các nhà cung cấp không cung cấp đĩa cứng
select a.MaDT, TenDT, DiaChi, DienThoai
from DoiTac a, KhaNangCC b
where a.MaDT=b.MaDT and a.MaDT not in (select MaDT
										from KhaNangCC
										where MaHH like 'HDD%'
										group by MaDT)
group by a.MaDT, TenDT, DiaChi, DienThoai										

--Câu 8: Cho biết thông tin của mặt hàng chưa bán được
select *
from HangHoa
where MaHH not in (select MaHH
					from CT_HoaDon
					group by MaHH)

--Câu 9: Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất
select TenHH, SUM(SoLuong) as TongSLBan
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and SoHD like 'X%'
group by TenHH
having SUM(SoLuong)>=all(select SUM(SoLuong)
						from CT_HoaDon
						where SoHD like 'X%'
						group by MaHH)

--Câu 10: Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
select TenHH, SUM(SoLuong) as TongSLBan
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and SoHD like 'N%'
group by TenHH
having SUM(SoLuong)<=all(select SUM(SoLuong)
						from CT_HoaDon
						where SoHD like 'N%'
						group by MaHH)

--Câu 11: Cho biết hóa đơn nhập nhiều mặt hàng nhất
select a.SoHD, NgayLapHD, SUM(SoLuong) as TongSLNhap
from HoaDon a, CT_HoaDon b
where a.SoHD=b.SoHD and b.SoHD like 'N%'
group by a.SoHD, NgayLapHD
having SUM(SoLuong) >= all(select SUM(SoLuong)
							from CT_HoaDon
							where SoHD like 'N%'
							group by SoHD)

--Câu 12: Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
select a.MaHH, TenHH
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and a.MaHH not in (select MaHH
										from CT_HoaDon d, HoaDon e
										where d.SoHD=e.SoHD and e.SoHD like 'N%' and MONTH(NgayLapHD)=1 and YEAR(NgayLapHD)=2006
										group by MaHH)

--Câu 13: Cho biết các mặt hàng không bán được trong tháng 6/2006
select a.MaHH, TenHH
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and a.MaHH not in (select MaHH
										from CT_HoaDon d, HoaDon e
										where d.SoHD=e.SoHD and e.SoHD like 'X%' and MONTH(NgayLapHD)=6 and YEAR(NgayLapHD)=2006
										group by MaHH)

--Câu 14: Cho biết cửa hàng bán bao nhiêu mặt hàng
select COUNT(SoHD) as TongSLBan
from CT_HoaDon
where SoHD like 'X%'

--Câu 15: Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select A.MaDT, TenDT, COUNT(MaHH)
from DoiTac a, KhaNangCC B
where a.MaDT=B.MaDT
group by a.MaDT, TenDT

--Câu 16: Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
select a.MaDT, TenDT, DiaChi, DienThoai
from DoiTac a, HoaDon b
where a.MaDT=b.MaDT and a.MaDT like 'K%'
group by a.MaDT, TenDT, DiaChi, DienThoai
having COUNT(b.SoHD)>=all (select COUNT(SoHD)
						from HoaDon
						group by MaDT)

--Câu 17: Tính tổng doanh thu năm 2006
select sum(DonGia * SoLuong) as TongDoanhThu
from HoaDon a, CT_HoaDon b
where a.SoHD=b.SoHD and Year(NgayLapHD)=2006

--Câu 18: Cho biết loại mặt hàng bán chạy nhất
select a.MaHH, TenHH
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and SoHD like 'X%'
group by a.MaHH, TenHH
having SUM(SoLuong) >= all (select SUM(SoLuong)
							from CT_HoaDon
							where SoHD like 'X%'
							group by MaHH)

--Câu 19: Liệt kê thông tin bán hàng của tháng 5/2006
select a.MaHH, TenHH, DVT, SUM(SoLuong) as TongSoLuong, SUM(DonGia * SoLuong) as TongThanhTien
from HangHoa a, CT_HoaDon b, HoaDon c
where a.MaHH=b.MaHH and b.SoHD=c.SoHD and b.SoHD like 'X%' and MONTH(NgayLapHD)=5 and YEAR(NgayLapHD)=2006
group by a.MaHH, TenHH, DVT

--Câu 20: Liệt kê thông tin mặt hàng có nhiều người mua nhất
select a.MaHH, TenHH
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and SoHD like 'X%'
group by a.MaHH, TenHH
having SUM(SoLuong) >= all (select SUM(SoLuong)
							from CT_HoaDon
							where SoHD like 'X%'
							group by MaHH)

--Câu 21: Tính và cập nhật tổng trị giá của các hóa đơn
update HoaDon	
set TongTG=(select SUM(DonGia * SoLuong)
			from CT_HoaDon
			where CT_HoaDon.SoHD=HoaDon.SoHD)

select * from HoaDon