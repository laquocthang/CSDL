--YÊU CẦU:
--1. Xác định khóa chính, khóa ngoại của các lược đồ quan hệ.
--2. Đặt tên cơ sở dữ liệu là MSSV_QLDeTai (ví dụ 1234567_QLDeTai)
--3. Xếp thứ tự, khai báo khóa chính, khóa ngoại để hoàn thiện các lệnh tạo bảng.
--4. Phát biểu các truy vấn sau bằng SQL:
---a) Cho biết những đề tài (MSDT, TenDT) thuộc chuyên ngành ‘Hệ thống thông tin’.
---b) Lập danh sách các đề tài thuộc chuyên ngành 'Đồ họa', thông tin cần hiển thị bao gồm: MSDT, TenDT, Số sinh viên tham gia.
---c) Cho biết thông tin của đề tài có nhiều sinh viên tham gia nhất.
---d) Cho biết thông tin (MSDT, TenDT, TenCN) của đề tài chưa có sinh viên tham gia.
---e) Cho biết số đề tài của từng chuyên ngành, thông tin cần hiển thị bao gồm MACN, TenCN, số đề tài.
---f) Cho biết tên các sinh viên không làm đề tài "Quản lý siêu thị".
---g) Cho biết số đề tài mà mỗi sinh viên tham gia thực hiện.
---h) Cho biết chuyên ngành (MSCN, TENCN) không có đề tài. 
---i) Cho biết tên những sinh viên thực hiện nhiều đề tài nhất.
---j) Cho biết sinh viên tham gia tất cả các đề tài, thông tin cần hiển thị gồm: MSSV, TenSV,Lop
---------------------------BÀI LÀM------------------------------
	--HỌ VÀ TÊN:
	--MSSV:
	--LỚP:
	--ĐỀ THI SỐ: 1
----------------------------------------------------------------
	 
--TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
create database ....
go
use ...
go
create table SinhVien
(MSSV char(7),
TenSV nvarchar(30),
Lop char(3)
)
go
create table ChuyenNganh
(MSCN char(2),
TenCN nvarchar(30)
)
go
create table CongViec
(MSCV char(2),
TenCV nvarchar(30)
)
go
create table ThucHienDeTai
(
MSSV char(7),
MSDT char(6),
MSCV char(2) ,
Diem tinyint
)
go
create table DeTai
(MSDT char(6),
TenDT nvarchar(50),
MSCN char(2) ,
NgayBatDau Datetime,
NgayNghiemThu Datetime
)

---------NHẬP DỮ LIỆU CHO CÁC BẢNG-----------
--------------------
insert into ChuyenNganh values('01',N'Hệ thống thông tin')
insert into ChuyenNganh values('02',N'Mạng')
insert into ChuyenNganh values('03',N'Đồ họa')
insert into ChuyenNganh values('04',N'Công nghệ phần mền')
----------------------
insert into CongViec values('C1',N'Trưởng nhóm')
insert into CongViec values('C2', N'Thu thập thông tin')
insert into CongViec values('C3',N'Phân tích')
insert into CongViec values('C4', N'Thiết kế')
----------------------
set dateformat dmy
go
insert into DeTai values('DT0601', N'Quản lý thư viện', '01', '15/09/2007', '15/12/2007')
insert into DeTai values('DT0602', N'Nhận dạng vân tay', '03', '15/09/2007', '15/12/2007')
insert into DeTai values('DT0603', N'Bán đấu giá trên mạng', '02', '15/09/2007', '15/12/2007')
insert into DeTai values('DT0604', N'Quản lý siêu thị', '04', '15/09/2007', '15/12/2007')
insert into DeTai values('DT0605', N'Giấu tin trong ảnh', '03', '15/09/2007', '15/12/2007')
insert into DeTai values('DT0606', N'Phát hiện tấn công trên mạng', '02', '15/09/2007', '15/12/2007')
---------------------
insert into SinhVien values('0400001', N'Nguyễn Văn An', 'K28')
insert into SinhVien values('0300095', N'Trần Hùng', 'K27')
insert into SinhVien values('0310005', N'Lê Thuý Hằng', 'K27')
insert into SinhVien values('0400023', N'Ngô Khoa', 'K28')
insert into SinhVien values('0400100', N'Phạm Tài', 'K28')
insert into SinhVien values('0310100', N'Đinh Tiến', 'K27')
---------------------
insert into ThucHienDeTai values('0400001', 'DT0601', 'C1', 7)
insert into ThucHienDeTai values('0400001', 'DT0603', 'C2', 8)
insert into ThucHienDeTai values('0300095', 'DT0602', 'C2', 9)
insert into ThucHienDeTai values('0310005', 'DT0604', 'C3', 8)
insert into ThucHienDeTai values('0400023', 'DT0601', 'C3', 6)
insert into ThucHienDeTai values('0400023', 'DT0605', 'C4', 8)
insert into ThucHienDeTai values('0400100', 'DT0603', 'C3', 8)
insert into ThucHienDeTai values('0310100', 'DT0604', 'C4', 6)
insert into ThucHienDeTai values('0310100', 'DT0601', 'C2', 5)
-------------TRUY VẤN DỮ LIỆU-------------

