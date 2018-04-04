-- Tên:	Le Thanh Dat
-- MSSV: 1512848
-- Lớp: CTK39

create database Lab11_QLNhapXuatHangHoa
go
use Lab11_QLNhapXuatHangHoa
go
create table HangHoa
(
	MaHH varchar(5) primary key,
	TenHH nvarchar(30) not null unique,
	DVT nvarchar(5) not null,
	SoLuongTon tinyint  -- tinyint 0 -> 255
)	go 
create table DoiTac
(
	MaDT varchar(5) primary key,
	TenDT nvarchar(25) not null,
	DiaChi nvarchar(35),
	DienThoai varchar(12)
)	go
create table KhaNangCC
(
	MaDT varchar(5) references DoiTac(MaDT),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(MaDT, MaHH)
)	go
create table HoaDon
(
	SoHD varchar(5) primary key,
	NgayLapHD datetime not null,
	MaDT varchar(5) references DoiTac(MaDT),
	TongTG float
)
	go
create table CT_HoaDon
(
	SoHD varchar(5) references HoaDon(SoHD),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(SoHD, MaHH),
	DonGia tinyint not null,
	SoLuong tinyint not null
)

-- Nhập liệu
insert into HangHoa values('CPU01','CPU INTEL, CELERON 600 BOX','CÁI','5')
insert into HangHoa values('CPU02','CPU INTEL, PIII 700','CÁI','10')
insert into HangHoa values('CPU03','CPU AMD K7 ATHL,ON 600','CÁI','8')
insert into HangHoa values('HDD01','HDD 10.2 GB QUANTUM','CÁI','10')
insert into HangHoa values('HDD02','HDD 13.6 GB SEAGATE','CÁI','15')
insert into HangHoa values('HDD03','HDD 20 GB QUANTUM','CÁI','6')
insert into HangHoa values('KB01','KB GENIUS','CÁI','12')
insert into HangHoa values('KB02','KB MITSUMIMI','CÁI','5')
insert into HangHoa values('MB01','GIGABYTE CHIPSET INTEL','CÁI','10')
insert into HangHoa values('MB02','ACOPR BX CHIPSET VIA','CÁI','10')
insert into HangHoa values('MB03','INTEL PHI CHIPSET INTEL','CÁI','10')
insert into HangHoa values('MB04','ECS CHIPSET SIS','CÁI','10')
insert into HangHoa values('MB05','ECS CHIPSET VIA','CÁI','10')
insert into HangHoa values('MNT01','SAMSUNG 14" SYNCMASTER','CÁI','5')
insert into HangHoa values('MNT02','LG 14"','CÁI','5')
insert into HangHoa values('MNT03','ACER 14"','CÁI','8')
insert into HangHoa values('MNT04','PHILIPS 14"','CÁI','6')
insert into HangHoa values('MNT05','VIEWSONIC 14"','CÁI','7')
select * from HangHoa

insert into DoiTac values('CC001','cTy TNC',N'176 BTX Q1 - TP.HCM','08.8250259')
insert into DoiTac values('CC002',N'cTy Hoàng Long','15A TTT Q1 - TP.HCM','08.8250898')
insert into DoiTac values('CC003',N'cTy Hợp Nhất','152 BTX Q1 - TP.HCM','08.8252376')
insert into DoiTac values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063.831129')
insert into DoiTac values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert into DoiTac values('K0003',N'Trần Nhật Duật',N'Lê Lợi Tp.Huế','054.848376')
insert into DoiTac values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khỡi Nghĩa Tp.Đà Lạt','063.823409')
select * from DoiTac
drop table DoiTac

set dateformat dmy
insert into HoaDon values('N0001','25/1/2006','CC001','')
insert into HoaDon values('N0002','1/5/2006','CC002','')
insert into HoaDon values('X0001','12/5/2006','K0001','')
insert into HoaDon values('X0002','16/6/2006','K0002','')
insert into HoaDon values('X0003','20/4/2006','K0003','')
select * from HoaDon

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
select * from KhaNangCC

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
select * from CT_HoaDon

--CÂU HỎI TRUY VẤN DỮ LIỆU CỦA CSDL:  Lab11_QLNhapXuatHangHoa
--1) Liệt kê các mặt hàng thuộc loại đĩa cứng.
Select *
From HangHoa
Where MaHH like'HDD%'
--2) Liệt kê các mặt hàng có số lượng tồn trên 10.
Select MaHH, TenHH, DVT
From HangHoa
Where SoluongTon > 10
--3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
Select *
From DoiTac
Where DiaChi like '%hcm'
--4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd; ngaylaphd; tên, địa chỉ, và điện thoại của nhà cung cấp; số mặt hàng
select HoaDon.SoHD ,HoaDon.NgayLapHD,DoiTac.TenDT,DoiTac.DiaChi,DoiTac.DienThoai,count(CT_HoaDon.MAHH) as SL
from HoaDon ,DoiTac,CT_HoaDon
where HoaDon.MaDT = DoiTac.MaDT and month(HoaDon.NgayLapHD)= 5 and year(HoaDon.NgayLapHD)=2006 and HoaDon.SoHD = CT_HoaDon.SoHD
group by HoaDon.SoHD ,HoaDon.NgayLapHD,DoiTac.TenDT,DoiTac.DiaChi,DoiTac.DienThoai
--5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.
Select D.MaDT, D.TenDT, D.DiaChi, D.DienTHoai
From HangHoa H, KhaNangCC K, DoiTac D
Where H.MaHH like 'HDD%' and H.MaHH = K.MaHH and K.MaDT = D.MaDT
group by D.MaDT, D.TenDT, D.DiaChi, D.DienTHoai
--6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.
Select D.TenDT
From DoiTac D, KhaNangCC K
Where D.MaDT = K.MaDT and K.MaHH like 'HDD01' and D.madt in(Select m.Madt
												From KhaNangCC m
												Where  m.Mahh like 'HDD02')and d.madt in(Select r.Madt
																						From KhaNangCC r
																						Where  r.Mahh like 'HDD03')
--7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
Select D.TenDT
From DoiTac D
where D.MaDT not in (Select K.MaDT
					From KhaNangCC K
					Where K.MaHH like 'HDD%' 
					group by K.MaDT)									
--8) Cho biết thông tin của mặt chưa bán được.
Select C.MaHH
From CT_HoaDon C
group by (MaHH)
--9) Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng).
Select H.MaHH
From HangHoa H 
Where H.MaHH not in(Select C.MaHH
					From CT_HoaDon C
					group by (MaHH))
--10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất.
Select H.MaHH, H.TenHH
From HangHoa H
Where H.MaHH in (Select  C.MaHH
					From CT_HoaDon C
					Where C.SoHD like'X0001') and H.MaHH in (Select  T.MaHH
																	From CT_HoaDon T
																	Where T.SoHD like'X0002') and H.MaHH in (Select R.MaHH
																															From CT_HoaDon R
																															Where R.SoHD like'X0003')
--11) Cho biết hóa đơn nhập nhiều mặt hàng nhất.
select c.SoHD, c.MaHH
from CT_HoaDon c
where  c.MaHH in(select r.MaHH
				from HangHoa r
				group by r.MaHH)
--12) Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
select h.SoHD, h.NgayLapHD, t.SoHD,COUNT(t.MaHH) as 'Hang khong duoc nhap trong 1.2006'
from HoaDon h, CT_HoaDon t
where t.SoHD =h.SoHD and MONTH(h.NgayLapHD)=1 and YEAR(h.NgayLapHD)=2006
group by h.SoHD, h.NgayLapHD ,t.SoHD
--13) Cho biết tên các mặt hàng không bán được trong tháng 6/2006
select h.SoHD, h.NgayLapHD, t.SoHD,t.MaHH,COUNT(t.MaHH) as 'Hang khong duoc ban trong 6.2006'
from HoaDon h, CT_HoaDon t
where t.SoHD =h.SoHD and MONTH(h.NgayLapHD)=6 and YEAR(h.NgayLapHD)=2006
group by h.SoHD, h.NgayLapHD ,t.SoHD, t.MaHH
--14) Cho biết cửa hàng bán bao nhiêu mặt hàng.
select h.SoHD,c.MaHH,COUNT(h.SoHD) as 'So mat hang da ban'
from  CT_HoaDon c,HoaDon h
where c.SoHD=h.SoHD
group by h.SoHD,c.MaHH
--15) Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp.
select d.MaDT, d.TenDT, count(k.MaHH) as 'So HH duoc cung cap'
from DoiTac d, KhaNangCC k
where d.MaDT=k.MaDT
group by d.MaDT,d.TenDT
--16) Cho biết thông tin của khách hàng có giao dịch với của hàng nhiều nhất.
select d.MaDT,d.DiaChi,d.DienThoai,h.SoHD,d.TenDT
from DoiTac d, HoaDon h
where d.MaDT=h.MaDT
group by d.MaDT,d.DiaChi,d.DienThoai,h.SoHD,d.TenDT
--17) Tính tổng doanh thu năm 2006.
select SUM(c.SoLuong*c.DonGia) as 'Tong doanh thu'
from HoaDon h, CT_HoaDon c
where h.SoHD=c.SoHD and h.SoHD like'X%' and YEAR(h.NgayLapHD)=2006
--18) Cho biết loại mặt hàng bán chạy nhất.
select left(h.MaHH,len((h.MaHH)-2)),Sum(c.SoLuong)
from HangHoa h, CT_HoaDon c
where h.MaHH=h.TenHH and c.SoHD like 'X%'
group by LEFT(len(h.MaHH)-2,h.MaHH)
having SUM(c.SoLuong) >= all(select SUM(c.SoLuong)
							from CT_HoaDon
							where SoHD like'X%'
							group by left((MaHH),len(MaHH)-2))
--19) Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, tenhh, dvt, tổng số lượng, tổng thành tiền.
select h.MaHH,h.TenHH,h.DVT,d.SoHD,d.NgayLapHD,SUM(c.SoLuong) as 'Tong so luong',SUM(c.SoLuong*c.DonGia) as 'Tong thanh tien'
from HangHoa h,HoaDon d, CT_HoaDon c
where h.MaHH=c.MaHH and c.SoHD=d.SoHD and c.SoHD like'X%' and MONTH(d.NgayLapHD)=5 and YEAR(d.NgayLapHD)=2006
group by h.MaHH,h.TenHH,h.DVT,d.SoHD,d.NgayLapHD
--20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất.
select h.MaHH,h.TenHH,c.SoHD,SUM(c.SoLuong) as 'Tong so luong'
from HangHoa h,CT_HoaDon c
where h.MaHH=c.MaHH and c.SoHD like 'X%'
group by h.MaHH,h.TenHH,c.SoHD
having SUM(c.SoLuong) >= all(select SUM(SoLuong) as 'So Luong'
							from CT_HoaDon
							where SoHD like 'X%'
							group by MaHH)
--21) Cập nhật giá trị cho thuộc tính TONGTG của từng hóa đơn tương ứng.
update HoaDon
set TongTG = (select SUM(CT_HoaDon.DonGia*CT_HoaDon.SoLuong)
			from CT_HoaDon
			where CT_HoaDon.SoHD=HoaDon.SoHD)