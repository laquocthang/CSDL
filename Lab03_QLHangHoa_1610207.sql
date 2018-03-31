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

Insert into Khach Values('K0001','Công ty ABC','11 Hai Bà Trưng','8121212')
Insert into Khach Values('K0002','Lê Mộng Mơ','02 Võ Thị Sáu','')
Insert into Khach Values('K0003','Trần Văn A','123 Lê Lợi','8123123')
Insert into Khach Values('K0004','Lê Văn Bé','111 Lê Hồng Phong','')
Insert into Khach Values('K0005','Cửa hàng X','102 Huỳnh Thúc Kháng','8222222')

Insert into Hang_Hoa Values('CA001','Cát xây','Mét khối','40000')
Insert into Hang_Hoa Values('CA002','Cát tô','Mét khối','50000')
Insert into Hang_Hoa Values('GB001','Gạch bông','Viên','10000')
Insert into Hang_Hoa Values('GM001','Gạch men','Viên','8000')
Insert into Hang_Hoa Values('SB001','Sơn bạch tuyết','Kg','25000')
Insert into Hang_Hoa Values('SB002','Sơn Expo','Kg','35000')
Insert into Hang_Hoa Values('STL05','Sắt hình L','Mét','15000')
Insert into Hang_Hoa Values('STO10','Sắt tròn','Mét','17000')
Insert into Hang_Hoa Values('VE005','Ván ép 5mm','Tấm','45000')
Insert into Hang_Hoa Values('XM300','Xi măng P300','Bao','50000')
Insert into Hang_Hoa Values('XM400','Xi măng P400','Bao','55000')

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
