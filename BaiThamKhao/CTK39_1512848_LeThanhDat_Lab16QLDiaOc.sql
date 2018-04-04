-- Tên: Lê Thành Đạt
-- MSSV: 1512848
-- Lớp: CTK39

create database Lab16_QLDiaOc
go
use Lab16_QLDiaOc
go
drop table  Phieu_Gia_Han
go
drop table  Phieu_Thu
go
drop table  CT_PDK
go
drop table  Phieu_Dang_Ky
go
drop table  DichVu
go
drop table  Dia_Oc
go
drop table  Loai_Dia_Oc
go
drop table  NguoiBan
go



------Tạo lập cấu trúc các bảng
Create table NguoiBan
(
	 MaNB char(9) primary key,
	 HoTen nVarchar(50),
	 DiaChi nVarchar(70),
	 SoDT char(10)
)
go
Create table Loai_Dia_Oc
(
	MaLDO int primary key, 
	TenLDO nvarchar(50),
)
go
Create table Dia_Oc
(	
	MaDO char(9) primary key,
	So varchar(10),
	Duong nvarchar(30),
	Phuong nvarchar(30),
	Quan nvarchar(30),
	DTDat Real,
	DTXD Real,
	Huong nvarchar(10),
	ViTri nvarchar(20),
	Mota nvarchar(100),
	MaLDO int references Loai_Dia_Oc(MaLDO)
)
go

Create table DichVu
(
	MaDV int primary key,
	TenDV nvarchar(50),
	TienDV Money,
)
go
Create table Phieu_Dang_Ky
(
	MaPDK char(10) primary key,
	NgayDK Datetime,
	TongSoDV int,
	TongTien Money,
	MaNB char(9) references NguoiBan( MaNB)
)
go
Create table CT_PDK
(
	MaPDK char(10) references Phieu_Dang_Ky(MaPDK),
	MaDO char(9) references Dia_Oc(MaDO),
	MaDV int references DichVu(MaDV ),
	TuNgay datetime,
	DenNgay datetime,
	SoTien money,
	primary key (MaPDK,MaDO,MaDV)
)
go
Create table Phieu_Thu
(	
	MaPT char(10) primary key,
	MaPDK char(10) references Phieu_Dang_Ky(MaPDK),
	NgayThu datetime,
	LanThu int,
	Sotien money,
	MaPTGoc char(10),
)
go
Create table Phieu_Gia_Han
(
	MaPGH char(10) primary key,
	MaPDK char(10) references Phieu_Dang_Ky(MaPDK),
	MaDO char(9) references Dia_Oc(MaDO),
	MaDV int references DichVu(MaDV ),
	NgayGiaHan datetime,
	TuNgay datetime,
	ToiNgay datetime,
)
go


------tiến hành nhập dữ liệu cho từng bảng


-------------------------------------Nhập dữ liệu bảng người bán--------------------------------------
delete from NguoiBan
insert into NguoiBan values ('111222333',N'Nguyễn Tường Vân',N'330/2 Lê Hồng Phong, Quận 5','8111222')
insert into NguoiBan values ('222333444',N'Trần Thanh Tùng',N'111 Trương Định, Quận 3','8222333')
insert into NguoiBan values ('333444555',N'Nguyễn Ngọc Nga',N'315 An Dương Vương, Quận 5','8333444')
select * from NguoiBan
go
-------------------------------------------------------------------------------------------------------



-------------------------------------Nhập dữ liệu bảng loại địa ốc--------------------------------------
delete from Loai_Dia_Oc
insert into Loai_Dia_Oc values ('1',N'Nhà và đất')
insert into Loai_Dia_Oc values ('2',N'Đất')
select * from Loai_Dia_Oc
go
---------------------------------------------------------------------------------------------------------


-------------------------------------Nhập dữ liệu bảng  địa ốc--------------------------------------
delete from Dia_Oc
insert into Dia_Oc values ('DO111','731',N'Trần Hưng Đạo','7','1','1000','800',N'Đông',N'Mặt tiền','','1')
insert into Dia_Oc values ('DO222','638',N'Nguyễn Văn Cừ','5','5','500','450',N'Tây',N'Mặt tiền','','2')
insert into Dia_Oc values ('DO333','332/1',N'Nguyễn Thái Học','9','1','100','100',N'Nam',N'Hẻm','','1')
insert into Dia_Oc values ('DO444','980',N'Lê Hồng Phong','4','5','450','450',N'Bắc',N'Mặt tiền','','2')
insert into Dia_Oc values ('DO555','111/45',N'Trương Định','10','3','85','85',N'Đông Nam',N'Hẻm','','1')
select * from Dia_Oc
go
---------------------------------------------------------------------------------------------------------





-------------------------------------Nhập dữ liệu bảng dịch vụ--------------------------------------
delete from DichVu
insert into DichVu values ('1',N'Tờ bướm quảng cáo 200 tờ','200000')
insert into DichVu values ('2',N'Tờ bướm quảng cáo 100 tờ','100000')
insert into DichVu values ('3',N'Quảng cáo trên báo','300000')
select * from DichVu
go
---------------------------------------------------------------------------------------------------------



-------------------------------------Nhập dữ liệu bảng phiếu đăng ký--------------------------------------
delete from Phieu_Dang_Ky
set dateformat dmy
insert into Phieu_Dang_Ky values ('PDK111','01/05/2005','1','1040000','111222333')
insert into Phieu_Dang_Ky values ('PDK222','19/10/2005','2','600000','222333444')
insert into Phieu_Dang_Ky values ('PDK333','07/09/2005','3','1000000','333444555')
select * from Phieu_Dang_Ky
go
---------------------------------------------------------------------------------------------------------



-------------------------------------Nhập dữ liệu bảng chi tiết phiếu đăng ký--------------------------------------
delete from CT_PDK
set dateformat dmy
insert into CT_PDK values ('PDK111','DO111','1','05/05/2005','05/07/2005','400000')
insert into CT_PDK values ('PDK222','DO222','1','01/11/2005','31/12/2005','400000')
insert into CT_PDK values ('PDK222','DO333','2','01/11/2005','31/12/2005','200000')
insert into CT_PDK values ('PDK333','DO444','1','15/09/2005','15/10/2005','200000')
insert into CT_PDK values ('PDK333','DO444','2','15/09/2005','15/10/2005','100000')
insert into CT_PDK values ('PDK333','DO555','3','15/09/2005','15/10/2005','300000')
select * from CT_PDK
go
---------------------------------------------------------------------------------------------------------



-------------------------------------Nhập dữ liệu bảng phiếu thu--------------------------------------
delete from Phieu_Thu
set dateformat dmy
insert into Phieu_Thu values ('PT111','PDK111','01/05/2005','1','400000',NULL)
insert into Phieu_Thu values ('PT222','PDK222','19/10/2005','1','400000',NULL)
insert into Phieu_Thu values ('PT333',NULL,'15/12/2005','2','200000','PT222')
insert into Phieu_Thu values ('PT444',NULL,'05/07/2005','2','320000','PT111')
insert into Phieu_Thu values ('PT555',NULL,'01/11/2005','3','320000','PT111')
insert into Phieu_Thu values ('PT666','PDK333','07/09/2005','1','600000',NULL)
insert into Phieu_Thu values ('PT777',NULL,'15/11/2005','2','400000','PT666')
select * from Phieu_Thu
go
---------------------------------------------------------------------------------------------------------



-------------------------------------Nhập dữ liệu bảng phiếu gia hạn--------------------------------------
delete from Phieu_Gia_Han
set dateformat dmy
insert into Phieu_Gia_Han values ('PGH111','PDK111','DO111','1','05/07/2005','05/07/2005','05/09/2005')
insert into Phieu_Gia_Han values ('PGH222','PDK111','DO111','1','01/11/2005','01/11/2005','31/12/2005')
insert into Phieu_Gia_Han values ('PGH333','PDK333','DO444','1','15/11/2005','15/11/2005','15/12/2005')
insert into Phieu_Gia_Han values ('PGH444','PDK333','DO555','3','15/11/2005','15/11/2005','15/12/2005')
select * from Phieu_Gia_Han
go

-Câu 1:Cho biết danh sách những người bán có đăng ký quảng cáo với thời hạn sử dụng từ tháng 8 tới thasgn 10 năm 2006
----->Kết quả không có ai vì trong cơ sở dữ liệu ngày gia hạn lớn nhất chỉ thuộc năm 2005
select distinct NguoiBan.MaNB,NguoiBan.HoTen,NguoiBan.DiaChi
from NguoiBan,Phieu_Dang_Ky,CT_PDK
where NguoiBan.MaNB=Phieu_Dang_Ky.MaNB and Phieu_Dang_Ky.MaPDK=CT_PDK.MaPDK and MONTH(CT_PDK.TuNgay)>8 and YEAR(CT_PDK.TuNgay)=2006
																			 and MONTH(CT_PDK.DenNgay)<10 and YEAR(CT_PDK.DenNgay)=2006
----->Giả sử đổi điều kiện thành thời hạn sử dụng từ tháng 8 tới thasgn 10 năm 2005
select distinct NguoiBan.MaNB,NguoiBan.HoTen,NguoiBan.DiaChi
from NguoiBan,Phieu_Dang_Ky,CT_PDK
where NguoiBan.MaNB=Phieu_Dang_Ky.MaNB and Phieu_Dang_Ky.MaPDK=CT_PDK.MaPDK and MONTH(CT_PDK.TuNgay)>=8 and YEAR(CT_PDK.TuNgay)=2005
																			 and MONTH(CT_PDK.DenNgay)<=10 and YEAR(CT_PDK.DenNgay)=2005



----Câu 2:Cho biết danh sách những người bán có đăng ký quảng cáo với ngày đăng ký thuộc tháng  10 năm 2005
select distinct NguoiBan.MaNB,NguoiBan.HoTen,NguoiBan.DiaChi
from Phieu_Dang_Ky,NguoiBan
where Phieu_Dang_Ky.MaNB=NguoiBan.MaNB and Month(Phieu_Dang_Ky.NgayDK)=10 and Year(Phieu_Dang_Ky.NgayDK)=2005



----Câu 3:Cho biết danh sách người bán lập phiếu phiếu gia hạn vào tháng 11 năm 2005
select distinct NguoiBan.MaNB,NguoiBan.HoTen,NguoiBan.DiaChi
from NguoiBan,Phieu_Dang_Ky,Phieu_Gia_Han
where NguoiBan.MaNB=Phieu_Dang_Ky.MaNB and Phieu_Dang_Ky.MaPDK=Phieu_Gia_Han.MaPDK 
										and Month(Phieu_Gia_Han.NgayGiaHan)=11 and Year(Phieu_Gia_Han.NgayGiaHan)=2005


-----Câu 4:Cho biết danh sách những người bán địa ốc có đăng ký dịch vụ quảng cáo trên báo
select distinct NB.MaNB,NB.HoTen,NB.DiaChi
from NguoiBan NB,Phieu_Dang_Ky PDK,CT_PDK CTPDK
where NB.MaNB=PDK.MaNB and PDK.MaPDK=CTPDK.MaPDK and CTPDK.MaDV =3

----CÂu 5:Với mỗi người bán,cho biết lần gia hạn lâu nhất của mỗi lần đăng ký là bao nhiêu ngày
select distinct a.HoTen,b.NgayDK,MAX(datediff(DAY,TuNgay,ToiNgay)) as Số_ngày_gia_hạn_nhiều_nhất
from NguoiBan a,Phieu_Dang_Ky b,Phieu_Gia_Han c
where a.MaNB=b.MaNB and b.MaPDK=c.MaPDK
group by a.HoTen,b.NgayDK

----Câu 6:Vỡi mỗi địa ốc có đăng ký quảng cáo trong năm 2005,cho biết lần đăng ký quảng cáo lâu nhất trong năm 2005 của địa ốc đó kéo dài bao 
-----nhiêu ngày
select distinct a.mado as Mã_địa_ốc, a.so as số, a.duong as Đường, a.phuong as Phường, a.quan as Quận, max(datediff(day,b.tungay,b.denngay)) as Số_ngày_đăng_ký_QC_nhiều_nhất
from dia_oc a, ct_pdk b
where a.mado = b.mado
group by a.mado, a.so, a.duong, a.phuong, a.quan
-----Câu 7:Cho biết danh sách những người bán đăng kí quảng cáo nhiều địa ốc khác nhau nhất trong năm 2005
select distinct  a.MaNB, a.HoTen,a.DiaChi
from NguoiBan a, Phieu_Dang_Ky b, CT_PDK c
where a.MaNB = b.MaNB and b.MaPDK = c.MaPDK
group by a.MaNB, a.HoTen,a.DiaChi
having count(c.MaDO) >= all(
							select count(distinct CT_PDK.MaDO) 
							from CT_PDK
							group by CT_PDK.MaPDK
							)
-----Câu 8:Với mỗi người bán cho biết họ đã thực hiện đăng ký quảng cáo bao nhiêu lần ( số lần đăng ký tính luôn cả những lần gia hạn)
select a.manb, hoten, diachi, count(c.madv) as số_lần_đăng_ký
from nguoiban a, phieu_dang_ky b , (
										(
											select mapdk,madv
											from  ct_pdk
										)
									union all
										(
											select mapdk,madv
											from  phieu_gia_han)
									) as c
where a.manb = b.manb and b.mapdk = c.mapdk
group by a.manb, hoten, diachi

---Câu 9:Với mỗi địa ốc cho biết nó đã được đăng ký quảng cáo bao nhiêu lần ( số lần đăng ký tính luôn cả những lần gia hạn)
select a.mado, so, duong,phuong,quan, count(b.madv) as số_lần_đăng_ký
from dia_oc a,(
					select mado,madv
					from ct_pdk
					union all
					select mado,madv
					from phieu_gia_han
				) as b
where a.mado = b.mado
group by a.mado, so, duong,phuong,quan

-----Câu 10:Cho biết danh sách những người bán đăng ký quảng cáo nhiều địa ốc ở quận 5 nhất
select a.hoten, count(c.mado) as Số_lượng_đăng_ký
from nguoiban a,phieu_dang_ky b, ct_pdk c
where a.manb = b.manb and b.mapdk = c.mapdk and a.diachi  like N'%quận 5'
group by hoten
having count(c.mado) >= all
							(
								select count(f.mado) 
								from nguoiban d,phieu_dang_ky e,ct_pdk f
								where d.manb = e.manb and e.mapdk = f.mapdk and d.diachi like N'%quận 5'
								group by f.mapdk
							)
------Câu 11:Chó biết những người bán có ít nhất một lần đăng ký trong đó đăng kí tất cả các dịch vụ hiện có 
select a.manb,hoten, diachi
from nguoiban a
where a.manb in(
				select MaNB
				from phieu_dang_ky
				where tongsodv =(	
									select count(DichVu.MaDV)
									from DichVu
								)
				)
------Câu 12:Cho biết người bán  đã đăng ký tất cả các dịch vụ có mệnh giá 200.000 trở lên
select a.manb,a.hoten, a.diachi
from nguoiban a, phieu_dang_ky b, ct_pdk c, dichvu d
where a.manb = b.manb and b.mapdk = c.mapdk and c.madv = d.madv and d.tiendv >=200000
group by a.manb,a.hoten, a.diachi, c.mapdk
having count(distinct c.madv) = (
									select count(madv)
									from dichvu
									where tiendv >=200000
								)
------Câu 13:Cho biết danh sách địa ốc đã được đăng kí quảng cáo với tất cả các dịch vụ có tiền dịch vụ nằm trong khoảng 100.000 tới 300.000
select a.manb,a.hoten, a.diachi
from nguoiban a, phieu_dang_ky b, ct_pdk c, dichvu d
where a.manb = b.manb and b.mapdk = c.mapdk and c.madv = d.madv and d.tiendv between 100000 and 200000
group by a.manb,a.hoten, a.diachi, c.mapdk
having count(distinct c.madv) = (
									select count(madv)
									from dichvu
									where tiendv between 100000 and 200000
								)
------Câu 14 : Cho biết danh sách địa ốc có ít nhất 1 lần đăng ký sử dujg tất cả các dịch vụ hiện có
select a.mado,so,duong,phuong, quan
from dia_oc a, ct_pdk b
where a.mado = b.mado
group by a.mado,so,duong,phuong, quan
having count(b.madv) = (
						select count(madv)
						from dichvu
						)
------Câu 15:Cho biết danh sách những người bán có ít nhất một lần đăng kí vào tháng 10
------ trong đó sử dụng tất cả các dịch vụ nằm trong khoảng 100.000 tới 200.000
select a.manb,a.hoten, a.diachi
from nguoiban a, phieu_dang_ky b, ct_pdk c, dichvu d
where a.manb = b.manb and b.mapdk = c.mapdk and c.madv = d.madv and d.tiendv between 100000 and 200000 and month(b.ngaydk) =10
group by a.manb,a.hoten, a.diachi, c.mapdk
having count(distinct c.madv) = (select count(g.madv)
								from phieu_dang_ky e, ct_pdk f,dichvu g
								where e.mapdk = f.mapdk and f.madv = g.madv and g.tiendv between 100000 and 200000 and month(ngaydk) =10)
