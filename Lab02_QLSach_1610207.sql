Create database Lab02_QLSach_1610207
use Lab02_QLSach_1610207;

go
Create table TheLoai
(MaTL nchar(4) primary key,
TenTL nvarchar(30) not null);

go
Create table NhaXuatBan
(MaNXB nchar(5) primary key,
TenNXB nvarchar(30) not null);

go
Create table TacGia
(MaTG nchar(4) primary key,
TenTG nvarchar(30) not null);

go
Create table Sach
(MaSH nchar(7) primary key,
TenSach nvarchar(100) not null,
MaTG nchar(4) references TacGia(MaTG),
MaNXB nchar(5) references NhaXuatBan(MaNXB),
MaTL nchar(4) references TheLoai(MaTL),
SoTrang integer not null,
NamXB integer not null,
SoLuong tinyint not null);

Insert into TheLoai Values('KT01',N'Kinh tế')
Insert into TheLoai Values('NN01',N'Ngoại ngữ')
Insert into TheLoai Values('TH01',N'Tin học')
Insert into TheLoai Values('VH01',N'Văn hóa - Du lịch')

Insert into NhaXuatBan Values('NXB01',N'Văn hóa thông tin')
Insert into NhaXuatBan Values('NXB02',N'Thống kê')
Insert into NhaXuatBan Values('NXB03',N'Trẻ')
Insert into NhaXuatBan Values('NXB04',N'Giao thông vận tải')
Insert into NhaXuatBan Values('NXB05',N'Tài chính')

Insert into TacGia Values('T001',N'Trần Việt Thanh')
Insert into TacGia Values('T002',N'Thùy Linh')
Insert into TacGia Values('T003',N'Phạm Vĩnh Hưng')
Insert into TacGia Values('T004',N'Trần Huy Hùng Cường')
Insert into TacGia Values('T005',N'Đậu Quang Tuấn')
Insert into TacGia Values('T006',N'Võ Văn Nhi')

Insert into Sach Values('KT00001',N'Nguyên lý kế toán','T006','NXB02','KT01','246','2005','15')
Insert into Sach Values('KT00002',N'Kế toán tài chính','T006','NXB05','KT01','272','2005','20')
Insert into Sach Values('KT00003',N'180 sơ đồ kế toán danh nghiệp','T006','NXB05','KT01','680','2005','8')
Insert into Sach Values('NN00001',N'Từ tượng hình, tượng thanh trong tiếng Nhật','T002','NXB03','NN01','232','2006','10')
Insert into Sach Values('NN00002',N'Từ điển Việt - Nhật','T001','NXB01','NN01','790','2002','15')
Insert into Sach Values('NN00003',N'Tiếng Nhật thực dụng trung cấp - Tập 1','T001','NXB03','NN01','312','2005','15')
Insert into Sach Values('TH00001',N'Tự học Word 2003 - Tin học văn phòng','T003','NXB01','TH01','220','2006','15')
Insert into Sach Values('TH00002',N'Thiết kế trang web bằng FrontPage 2003 Xara Webstyle và có hiệu quả','T005','NXB04','TH01','316','2006','10')
Insert into Sach Values('VH00001',N'Giới thiệu các tuyến du lịch Nam bộ','T004','NXB03','VH01','404','2006','10')
Insert into Sach Values('VH00002',N'Du lịch thế giới - Du lịch châu Âu','T004','NXB01','VH01','400','2005','10')

select *
from TheLoai

select *
from NhaXuatBan

select *
from TacGia

select *
from Sach