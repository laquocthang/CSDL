/*-----------------------------------------------
Bài lab: Quản lý thư viện
Ngày thực hiện: 18/4/2018
Người thực hiện: La Quốc Thắng
MSSV:1610207
------------------------------------------------*/

drop database QL_ThuVien
create database QL_ThuVien
use QL_ThuVien

go
drop table NhaXuatBan
create table NhaXuatBan
(
    MaNXB char(4) primary key,
    TenNXB nvarchar(30) not null
)

go
drop table TheLoai
create table TheLoai
(
    MaTL char(2) primary key,
    TenTL nvarchar(20) not null
)

go
drop table Sach
create table Sach
(
    MaSach char(6) primary key,
    TuaDe nvarchar(30) not null,
    MaNXB char(4) references NhaXuatBan(MaNXB),
    TacGia nvarchar(30) not null,
    SoLuong tinyint not null,
    NgayNhap date not null,
    MaTL char(2) not null
)

go
drop table BanDoc
create table BanDoc
(
    MaThe char(6) primary key,
    TenBanDoc nvarchar(30) not null,
    DiaChi nvarchar(30) not null,
    SoDT nchar(6)
)

go
drop table MuonSach
create table MuonSach
(
    MaThe char(6) references BanDoc(MaThe),
    MaSach char(6) references Sach(MaSach),
    NgayMuon date not null,
    NgayTra date
    CONSTRAINT PK Primary key(MaThe, MaSach, NgayMuon)
)

delete from NhaXuatBan
Insert into NhaXuatBan Values('N001',N'Giáo dục')
Insert into NhaXuatBan Values('N002',N'Khoa học kỹ thuật')
Insert into NhaXuatBan Values('N003',N'Thống kê')

delete from TheLoai
Insert into TheLoai Values('TH',N'Tin học')
Insert into TheLoai Values('HH',N'Hóa học')
Insert into TheLoai Values('KT',N'Kinh tế')
Insert into TheLoai Values('TN',N'Toán học')

delete from Sach
Insert into Sach Values('TH0001',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn','3','9/8/2005','TH')
Insert into Sach Values('TH0002',N'Lập trình mạng','N003',N'Phạm Vĩnh Hưng','2','12/3/2003','TH')
Insert into Sach Values('TH0003',N'Thiết kế mạng chuyên nghiệp','N002',N'Phạm Vĩnh Hưng','5','5/4/2003','TH')
Insert into Sach Values('TH0004',N'Thực hành mạng','N003',N'Trần Quang','3','5/6/2005','TH')
Insert into Sach Values('TH0005',N'3D Studio kỹ xảo hoạt hình T1','N001',N'Trương Bình','2','2/5/2004','TH')
Insert into Sach Values('TH0006',N'3D Studio kỹ xảo hoạt hình T2','N001',N'Trương Bình','3','6/5/2004','TH')
Insert into Sach Values('TH0007',N'Giáo trình Access 2000','N001',N'Thiện Tâm','5','12/11/2005','TH')

delete from BanDoc
Insert into BanDoc Values('050001',N'Trần Xuân','17 Yersin','858936')
Insert into BanDoc Values('050002',N'Lê Nam',N'5 Hai Bà Trưng','845623')
Insert into BanDoc Values('060001',N'Nguyễn Năm',N'10 Lý Tự Trọng','823456')
Insert into BanDoc Values('060002',N'Trần Hùng',N'20 Trần Phú','841256')

delete from MuonSach
Insert into MuonSach Values('050001','TH0006','12/12/2006','3/1/2007')
Insert into MuonSach Values('050001','TH0007','12/12/2006','')
Insert into MuonSach Values('050002','TH0001','3/8/2006','4/15/2007')
Insert into MuonSach Values('050002','TH0002','3/4/2007','4/4/2007')
Insert into MuonSach Values('050002','TH0003','4/2/2007','4/15/2007')
Insert into MuonSach Values('050002','TH0004','3/4/2007','')
Insert into MuonSach Values('060002','TH0001','4/8/2007','')
Insert into MuonSach Values('060002','TH0007','3/15/2007','4/15/2007')

select *
from NhaXuatBan

select *
from TheLoai

select *
from Sach

select *
from BanDoc

select *
from MuonSach
