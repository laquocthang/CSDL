/* Môn: Cơ sở dữ liệu
   Lab02_QLSach
   Thực hiện: La Quốc Thắng
   Ngày: 4/4/2018 
*/
---------------------------------------------------------------------------------------

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

--Phan bai tap
--Query 1: Cho biết số lượng cuốn sách theo từng thể loại (TenTL, TongSoLuong)
select a.MaTL, b.TenTL, sum(a.SoLuong) as SoLuong
from Sach a, TheLoai b
where a.MaTL=b.MaTL
group by a.MaTL,TenTL

--Query 2: Hãy cho biết số cuốn sách mà mỗi nhà xuất bản đã xuất bản
select b.MaNXB, b.TenNXB, sum(SOLUONG) as SoCuonSach
from Sach a, NhaXuatBan b
where a.MaNXB=b.MaNXB
group by b.MaNXB, b.TenNXB

--Query 3: Hãy cho biết số cuốn sách mà mỗi tác giả đã viết
select a.MaTG, b.TenTG, count(a.MaTG) as SoCuonSach
from Sach a, TacGia b
where a.MaTG=b.MaTG
group by a.MaTG, b.TenTG

--Query 4: Cho biết số cuốn sách xuất bản theo từng năm
select NamXB, sum(SoLuong)
from Sach
group by NamXB

--Query 5: Cho biết số cuốn sách xuất bản năm 2005
select NamXB, sum(SoLuong)
from Sach
where NamXB=2005
group by NamXB

--Query 6


--Query 7: Hãy liệt kê thông tin về các cuốn sách đã được xuất bản
select TenSach, TenTG, TenNXB, NamXB, SoLuong
from Sach a, TacGia b, NhaXuatBan c
where a.MaTG=b.MaTG and a.MaNXB=c.MaNXB

--Query 8: Liệt kê các cuốn sách thuộc thể loại "Văn hóa - Du lịch" và "Ngoại ngữ"
select TenSach, TenTG
from Sach a, TacGia b, TheLoai c
where a.MaTG=b.MaTG and a.MaTL=c.MaTL and c.TenTL like N'Văn hóa - Du lịch' union
		(select TenSach, TenTG
		from Sach a, TacGia b, TheLoai c
		where a.MaTG=b.MaTG and a.MaTL=c.MaTL and c.TenTL like N'Ngoại ngữ')

--Query 9: Cho biết các cuốn sách có số trang >400
select TenSach, SoTrang
from Sach
where SoTrang>400

--Query 10: Cho biết tên những nhà xuất bản không xuất bản sách thuộc thể loại "Tin học"
select TenNXB, MaNXB
from NhaXuatBan a
where a.MaNXB not in (
					select c.MaNXB
					from TheLoai b, Sach c
					where b.MaTL=c.MaTL and b.TenTL = N'Tin học')

--Query 11: Cho biết họ tên tác giả  viết nhiều sách nhất
select a.MaTG, b.TenTG
from Sach a, TacGia b
where a.MaTG=b.MaTG
group by a.MaTG, b.TenTG
having COUNT(a.MaSH)>=all(select COUNT(c.MaSH)
						from Sach c
						group by c.MaTG)
						
--Query 12: Cho biết tên thể loại có nhiều sách được xuất bản nhất
select b.MaTL, b.TenTL, COUNT(a.MaSH) as SoLuong
from Sach a, TheLoai b
where a.MaTL=b.MaTL
group by b.MaTL, b.TenTL
having count(a.MaSH)>=all(select count(c.MaSH)
						from  Sach c
						group by c.MaTL)
						
--Query 13: Cho biết tên nhà xuất bản xuất bản ít sách nhất
select b.MaNXB, b.TenNXB
from Sach a, NhaXuatBan b
where a.MaNXB=b.MaNXB
group by b.MaNXB, b.TenNXB
having count(a.MaSH)<all(select count(c.MaSH)
						from Sach c
						group by c.MaTL)