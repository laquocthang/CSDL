create database Lab06_QLSach_1610207
use Lab06_QLSach_1610207;

go
create table NhaXuatBan
(MaNXB nchar(4) primary key,
TenNXB nvarchar(30) not null)

go
create table Sach
(MaSach nchar(6) primary key,
TuaDe nvarchar(30) not null,
MaNXB nchar(4) references NhaXuatBan(MaNXB),
TacGia nvarchar(30) not null,
SoLuong tinyint not null,
NgayNhap date not null)

go
create table BanDoc
(MaThe nchar(6) primary key,
TenBanDoc nvarchar(30) not null,
DiaChi nvarchar(30) not null,
SoDT nchar(6))

go
create table MuonSach
(MaThe nchar(6) foreign key references BanDoc(MaThe),
MaSach nchar(6) foreign key references Sach(MaSach),
NgayMuon date not null,
NgayTra date
CONSTRAINT PK Primary key(MaThe, MaSach, NgayMuon))

Insert into NhaXuatBan Values('N001',N'Giáo dục')
Insert into NhaXuatBan Values('N002',N'Khoa học kỹ thuật')
Insert into NhaXuatBan Values('N003',N'Thống kê')

Insert into Sach Values('000001',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn','3','9/8/2005')
Insert into Sach Values('000002',N'Lập trình mạng','N003',N'Phạm Vĩnh Hưng','2','12/3/2003')
Insert into Sach Values('000003',N'Thiết kế mạng chuyên nghiệp','N002',N'Phạm Vĩnh Hưng','5','5/4/2003')
Insert into Sach Values('000004',N'Thực hành mạng','N003',N'Trần Quang','3','5/6/2005')
Insert into Sach Values('000005',N'3D Studio kỹ xảo hoạt hình T1','N001',N'Trương Bình','2','2/5/2004')
Insert into Sach Values('000006',N'3D Studio kỹ xảo hoạt hình T2','N001',N'Trương Bình','3','6/5/2004')
Insert into Sach Values('000007',N'Giáo trình Access 2000','N001',N'Thiện Tâm','5','12/11/2005')

Insert into BanDoc Values('050001',N'Trần Xuân','17 Yersin','858936')
Insert into BanDoc Values('050002',N'Lê Nam',N'5 Hai Bà Trưng','845623')
Insert into BanDoc Values('060001',N'Nguyễn Năm',N'10 Lý Tự Trọng','823456')
Insert into BanDoc Values('060002',N'Trần Hùng',N'20 Trần Phú','841256')

Insert into MuonSach Values('050001','000006','12/12/2006','3/1/2007')
Insert into MuonSach Values('050001','000007','12/12/2006','')
Insert into MuonSach Values('050002','000001','3/8/2006','4/15/2007')
Insert into MuonSach Values('050002','000002','3/4/2007','4/4/2007')
Insert into MuonSach Values('050002','000003','4/2/2007','4/15/2007')
Insert into MuonSach Values('050002','000004','3/4/2007','')
Insert into MuonSach Values('060002','000001','4/8/2007','')
Insert into MuonSach Values('060002','000007','3/15/2007','4/15/2007')

select *
from NhaXuatBan

select *
from Sach

select *
from BanDoc

select *
from MuonSach
