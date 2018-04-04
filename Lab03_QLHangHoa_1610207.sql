/* Môn: Cơ sở dữ liệu
   Lab03_QLHangHoa
   Thực hiện: La Quốc Thắng
   Ngày: 4/4/2018 
*/
---------------------------------------------------------------------------------------

Create database Lab03_QLHangHoa_1610207
use Lab03_QLHangHoa_1610207;

go
Create table Khach
(MaKH nchar(5) primary key,
TenKH nvarchar(30) not null,
DiaChi nvarchar(30) not null,
DThoai nvarchar(10));

go
Create table Hang_Hoa
(MaHH nchar(5) primary key,
TenHH nvarchar(30) not null,
DVTinh nchar(10) not null,
DonGia real not null);

go
Create table HoaDon
(SoHD nchar(5) primary key,
NgayBan date not null,
MaKH nchar(5) references Khach(MaKH));

go
Create table CT_HoaDon
(SoHD nchar(5) foreign key references HoaDon(SoHD),
MaHH nchar(5) foreign key references Hang_Hoa(MaHH),
SL_Ban int not null)

Insert into Khach Values('K0001',N'Công ty ABC',N'11 Hai Bà Trưng','8121212')
Insert into Khach Values('K0002',N'Lê Mộng Mơ',N'02 Võ Thị Sáu','')
Insert into Khach Values('K0003',N'Trần Văn A',N'123 Lê Lợi','8123123')
Insert into Khach Values('K0004',N'Lê Văn Bé',N'111 Lê Hồng Phong','')
Insert into Khach Values('K0005',N'Cửa hàng X',N'102 Huỳnh Thúc Kháng','8222222')

Insert into Hang_Hoa Values('CA001',N'Cát xây',N'Mét khối','40000')
Insert into Hang_Hoa Values('CA002',N'Cát tô',N'Mét khối','50000')
Insert into Hang_Hoa Values('GB001',N'Gạch bông',N'Viên','10000')
Insert into Hang_Hoa Values('GM001',N'Gạch men',N'Viên','8000')
Insert into Hang_Hoa Values('SB001',N'Sơn bạch tuyết','Kg','25000')
Insert into Hang_Hoa Values('SB002',N'Sơn Expo','Kg','35000')
Insert into Hang_Hoa Values('STL05',N'Sắt hình L',N'Mét','15000')
Insert into Hang_Hoa Values('STO10',N'Sắt tròn',N'Mét','17000')
Insert into Hang_Hoa Values('VE005',N'Ván ép 5mm',N'Tấm','45000')
Insert into Hang_Hoa Values('XM300',N'Xi măng P300','Bao','50000')
Insert into Hang_Hoa Values('XM400',N'Xi măng P400','Bao','55000')

Insert into HoaDon Values('H0001','1/15/2006','K0001')
Insert into HoaDon Values('H0002','1/15/2006','K0002')
Insert into HoaDon Values('H0003','1/16/2006','K0003')
Insert into HoaDon Values('H0004','1/17/2006','K0004')
Insert into HoaDon Values('H0005','2/18/2006','K0005')

Insert into CT_HoaDon Values('H0001','GB001','500')
Insert into CT_HoaDon Values('H0001','SB001','10')
Insert into CT_HoaDon Values('H0001','STL05','100')
Insert into CT_HoaDon Values('H0001','XM400','50')
Insert into CT_HoaDon Values('H0002','GM001','200')
Insert into CT_HoaDon Values('H0002','SB002','20')
Insert into CT_HoaDon Values('H0002','VE005','50')
Insert into CT_HoaDon Values('H0003','VE005','30')
Insert into CT_HoaDon Values('H0003','XM300','100')
Insert into CT_HoaDon Values('H0004','GB001','1000')
Insert into CT_HoaDon Values('H0004','GM001','100')
Insert into CT_HoaDon Values('H0004','SB002','50')
Insert into CT_HoaDon Values('H0004','STO10','100')
Insert into CT_HoaDon Values('H0005','STO10','50')
Insert into CT_HoaDon Values('H0005','XM300','80')

select *
from Khach

select *
from Hang_Hoa

select *
from HoaDon

select *
from CT_HoaDon

--Phan bai tap
--Query 1: Tạo query hiển thị chi tiết thông tin về các mặt hàng đã được bán
select a.NgayBan, a.SoHD, b.TenHH, c.SL_Ban, b.DonGia, round(c.SL_Ban*b.DonGia,2) as ThanhTien
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH

--Query 2: tạo query đưa bảng tổng hợp tiền bán theo từng ngày của cửa hàng
select a.NgayBan, sum(c.SL_Ban*b.DonGia) as TongTien
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH
group by NgayBan

--Query 3: Tạo query đưa ra bảng tổng hợp số lượng bán và tổng tiền đã bán ra  của từng loại mặt hàng
select b.MaHH, sum(c.SL_Ban) as TongSoBan, sum(c.SL_Ban*b.DonGia) as TongTien 
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH
group by b.MaHH, b.TenHH

--Query 4: Tạo bảng tính tổng tiền từng hóa đơn bán hàng
select d.SoHD, a.NgayBan, b.TenKH, sum(d.SL_Ban*c.DonGia) as TongTien
from HoaDon a, Khach b, Hang_Hoa c, CT_HoaDon d
where a.SoHD=d.SoHD and a.MaKH=b.MaKH and c.MaHH=d.MaHH
group by d.SoHD, a.NgayBan, b.TenKH

--Query 8: Cho biết tên những mặt hàng bán chạy nhất
select b.MaHH, b.TenHH, SUM(a.SL_Ban) as SoLuong
from CT_HoaDon a, Hang_Hoa b
where a.MaHH=b.MaHH
group by b.MaHH, b.TenHH
having SUM(a.SL_Ban)>=all(select SUM(SL_Ban)
						from CT_HoaDon c
						group by c.MaHH)
						
--Query 9: Cho biết thông tin về các khách hàng mua nhiều mặt hàng nhất
select c.MaKH, c.TenKH
from CT_HoaDon a, HoaDon b, Khach c
where a.SoHD=b.SoHD and b.MaKH=c.MaKH
group by b.SoHD, c.MaKH, c.TenKH
having SUM(a.SL_Ban)>=all(select SUM(d.SL_Ban)
							from CT_HoaDon d
							group by d.SoHD)
							
--Query 10: Cho biết thông tin của hóa đơn có tổng giá trị lớn nhất
select b.SoHD, b.NgayBan, b.MaKH, SUM(SL_Ban*DonGia) as TongGiaTri
from CT_HoaDon a, HoaDon b, Hang_Hoa c
where a.SoHD=b.SoHD and c.MaHH=a.MaHH
group by b.SoHD, b.NgayBan, b.MaKH
having SUM(SL_Ban*DonGia)>=all(select SUM(d.SL_Ban*e.DonGia)
								from CT_HoaDon d, Hang_Hoa e
								where d.MaHH=e.MaHH
								group by d.SoHD)
								
--Query 11:: Cho biết số lượng hóa đơn
select SoHD, COUNT(SoHD)
from CT_HoaDon
group by SoHD

--Query 12: Cho biết những mặt hàng chưa bán được
select MaHH, TenHH
from Hang_Hoa
where MaHH not in(select a.MaHH
					from CT_HoaDon a, Hang_Hoa b
					where a.MaHH=b.MaHH
					group by a.MaHH)

--Query 13: Cho biết những hóa đơn có mua mặt hàng sơn
select a.SoHD
from CT_HoaDon a, Hang_Hoa b
where a.MaHH=b.MaHH and TenHH like N'Sơn%'

--Query 14: Cho biết số lượng khách hàng có mua "Sắt tròn"
select count(a.SoHD) as SoLuong
from CT_HoaDon a, Hang_Hoa b
where a.MaHH=b.MaHH and TenHH=N'Sắt tròn'

--Query 15: Tính tổng số tiền bán trong ngày 15/1/2006
select sum(a.SL_Ban*b.DonGia) as TongSoTien
from CT_HoaDon a, Hang_Hoa b, HoaDon c
where a.MaHH =b.MaHH and c.SoHD=a.SoHD and NgayBan='1/15/2006'