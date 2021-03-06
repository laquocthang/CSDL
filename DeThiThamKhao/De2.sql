--YÊU CẦU:
--1. Xác định khóa chính, khóa ngoại của các lược đồ quan hệ.
--2. Đặt tên cơ sở dữ liệu là QLTour_MSSV (ví dụ QLTour­_1234567)
--3. Xếp thứ tự, khai báo khóa chính, khóa ngoại để hoàn thiện các lệnh tạo bảng.
--4. Phát biểu các truy vấn sau bằng SQL:
---a) Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày.
---b) Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017.
---c) Cho biết các tour không đi qua thành phố 'Nha Trang'. 
---d) Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
---e) Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn. 
---f) Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
---g) Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
---h) Lập danh sách các tour đi qua thành phố 'Đà Lạt', thông tin cần hiển thị bao gồm: Mã tour, Songay.
---i) Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
---j) Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua.
---------------------------BÀI LÀM------------------------------
	--HỌ VÀ TÊN:
	--MSSV:
	--LỚP:
	--ĐỀ THI SỐ: 2
----------------------------------------------------------------

--TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
create database De2
go
use De2
go

create table ThanhPho
(MaTP char(2) primary key,
TenTP nvarchar(30)
)
go

create table Tour
(MaTour char(4) primary key,
TongSoNgay tinyint
)
go
create table Tour_TP
(MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay tinyint
constraint PK_Tour_TP primary key(MaTour, MaTP)
)
go

create table Lich_TourDL
(MaTour char(4) references Tour(MaTour),
NgayKH DateTime,
TenHDV nvarchar(10) ,
SoNguoi int,
TenKH nvarchar(30)
constraint PK_Lich_TourDL primary key(MaTour, NgayKH)
)
go

---------NHẬP DỮ LIỆU CHO CÁC BẢNG-----------
--------------------
insert into ThanhPho values('01', N'Đà Lạt')
insert into ThanhPho values('02', N'Nha Trang')
insert into ThanhPho values('03', N'Phan Thiết')
insert into ThanhPho values('04', N'Huế')
insert into ThanhPho values('05', N'Đà Nẵng')
--------------------
insert into Tour values('T001', 3)
insert into Tour values('T002', 4)
insert into Tour values('T003', 5)
insert into Tour values('T004', 7)
--------------------
insert into Tour_TP values('T001', '01', 2)
insert into Tour_TP values('T001', '03', 1)
insert into Tour_TP values('T002', '01', 2)
insert into Tour_TP values('T002', '02', 2)
insert into Tour_TP values('T003', '02', 2)
insert into Tour_TP values('T003', '01', 1)
insert into Tour_TP values('T003', '04', 2)
insert into Tour_TP values('T004', '02', 2)
insert into Tour_TP values('T004', '05', 2)
insert into Tour_TP values('T004', '04', 3)
--------------------
set dateformat dmy
go
insert into Lich_TourDL values('T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng')
insert into Lich_TourDL values('T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc')
insert into Lich_TourDL values('T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam')
insert into Lich_TourDL values('T003', '10/03/2017', N'Nam', 45, N'Nguyễn An')
insert into Lich_TourDL values('T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung')
insert into Lich_TourDL values('T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc')
insert into Lich_TourDL values('T001', '30/04/2017', N'Nam', 25, N'Trần Nam')
insert into Lich_TourDL values('T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá')
-------------TRUY VẤN DỮ LIỆU-------------
---a) Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày.
select *
from Tour
where TongSoNgay between 3 and 5
go

---b) Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017.
select t.MaTour, TongSoNgay
from Tour t, Lich_TourDL l
where t.MaTour=l.MaTour and month(NgayKH)=2 and year(NgayKH)=2017
go

---c) Cho biết các tour không đi qua thành phố 'Nha Trang'. 
select *
from Tour
where MaTour not in(select p.MaTour
					from ThanhPho c, Tour_TP p
					where p.MaTP=c.MaTP and TenTP like 'Nha Trang'
)

---d) Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
select MaTour, count(MaTP) as N'Số thành phố đi qua'
from Tour_TP
group by MaTour

---e) Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn. 
select TenHDV, count(MaTour) as N'Số lượng tour'
from Lich_TourDL
group by TenHDV

---f) Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
select t.MaTP, TenTP, count(MaTour) as N'Số tour đi qua'
from ThanhPho t, Tour_TP p
where t.MaTP=p.MaTP
group by t.MaTP, TenTP
having count(MaTour)>=all(select count(MaTour)
						from Tour_TP
						group by MaTP
)
go

---g) Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
select MaTour, count(MaTP) as N'Số thành phố đi qua'
from Tour_TP
group by MaTour
having count(MaTP)=(select count(MaTP) from ThanhPho)
go

---h) Lập danh sách các tour đi qua thành phố 'Đà Lạt', thông tin cần hiển thị bao gồm: Mã tour, Songay.
select p.MaTour, SoNgay
from ThanhPho t, Tour_TP p
where t.MaTP=p.MaTP and TenTP like N'Đà Lạt'
go

---i) Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
select t.MaTour, NgayKH, TongSoNgay
from Tour t, Lich_TourDL l
where t.MaTour=l.MaTour and SoNguoi=(select max(SoNguoi) from Lich_TourDL) 
go

---j) Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua.
select c.MaTP, TenTP
from Tour_TP t, ThanhPho c
where t.MaTP=c.MaTP
group by c.MaTP, TenTP
having count(MaTour)=(select count(MaTour)from Tour)
go