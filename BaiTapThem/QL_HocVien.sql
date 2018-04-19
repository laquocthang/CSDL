/*-----------------------------------------------
Bài lab: Quản lý học viên
Ngày thực hiện: 18/4/2018
Người thực hiện: La Quốc Thắng
MSSV:1610207
------------------------------------------------*/

create database QL_HocVien

use QL_HocVien

go
drop table CaHoc
create table CaHoc
(
    Ca tinyint primary key,
    GioBatDau time not null,
    GioKetThuc time not null
)

go
drop table GiaoVien
create table GiaoVien
(
    MSGV char(4) primary key,
    HoGV nvarchar(20) not null,
    TenGV nvarchar(10) not null,
    DienThoai varchar(10) not null
)

go
drop table Lop
create table Lop
(
    MaLop char(4) primary key,
    TenLop varchar(20) not null,
    NgayKG date not null,
    HocPhi money not null,
    Ca tinyint references CaHoc(Ca),
    SoTiet tinyint not null,
    SoHV tinyint,
    MSGV char(4) references GiaoVien(MSGV)
)

go
drop table HocVien
create table HocVien
(
    MSHV varchar(6) primary key,
    Ho nvarchar(20) not null,
    Ten nvarchar(10) not null,
    NgaySinh date not null,
    Phai bit,
    MaLop char(4) references Lop(MaLop)
)

go
drop table HocPhi
create table HocPhi
(
    SoBL char(4) primary key,
    MSHV varchar(6) references HocVien(MSHV),
    NgayThu date not null,
    SoTien money,
    NoiDung varchar(30) not null,
    NguoiThu nvarchar(10) not null
)

delete from CaHoc
insert into CaHoc values('1','7:30','10:45')
insert into CaHoc values('2','13:30','16:45')
insert into CaHoc values('3','17:30','20:45')

delete from GiaoVien
insert into GiaoVien values('G001',N'Lê Hoàng','Anh','858936')
insert into GiaoVien values('G002',N'Nguyễn Ngọc',N'Lan','845623')
insert into GiaoVien values('G003',N'Trần Minh',N'Hùng','823456')
insert into GiaoVien values('G004',N'Võ Thanh',N'Trung','841256')

set dateformat dmy
delete from Lop
insert into Lop values ('A075','Access 2-4-6','18/12/2008','150000','3','60','3','G003')
insert into Lop values ('E114','Excel 3-5-7','02/01/2008','120000','1','45','3','G003')
insert into Lop values ('E115','Excel 2-4-6','22/01/2008','120000','3','45','0','G001')
insert into Lop values ('W123','Word 2-4-6','18/12/2008','100000','3','30','1','G001')
insert into Lop values ('W124','Word 3-5-7','01/03/2008','100000','1','30','0','G002')

delete from HocVien
insert into HocVien values ('0001',N'Lê Văn','Minh','10/06/1998','1','A075')
insert into HocVien values ('0002',N'Nguyễn Thị','Mai','20/04/1988','0','A075')
insert into HocVien values ('0003',N'Lê Ngọc',N'Tuấn','10/06/1984','1','A075')
insert into HocVien values ('0004',N'Vương Tuấn',N'Vũ','25/03/7979','1','E114')
insert into HocVien values ('0005',N'Lý Ngọc',N'Hân','01/12/1985','0','E114')
insert into HocVien values ('0006',N'Trần Mai','Linh','04/06/1980','0','E114')
insert into HocVien values ('0007',N'Nguyễn Ngọc',N'Tuyết','12/05/1986','0','W123')

delete from HocPhi
insert into HocPhi values('0001','','16/12/2008','150000','HP Access 2-4-6','Lan')
insert into HocPhi values('0002','','16/12/2008','100000','HP Access 2-4-6','Lan')
insert into HocPhi values('0003','','18/12/2008','150000','HP Access 2-4-6','Van')
insert into HocPhi values('0004','','15/1/2009','50000','HP Access 2-4-6','Van')
insert into HocPhi values('0005','','2/1/2008','120000','HP Excel 3-5-7','Van')
insert into HocPhi values('0006','','2/1/2008','120000','HP Excel 3-5-7','Van')
insert into HocPhi values('0007','','2/1/2008','80000','HP Excel 3-5-7','Van')
insert into HocPhi values('0008','','18/2/2008','100000','HP Word 2-4-6','Lan')

select * from CaHoc

select * from GiaoVien

select * from Lop

select * from HocVien

select * from HocPhi