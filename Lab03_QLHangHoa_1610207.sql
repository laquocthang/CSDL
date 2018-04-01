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
