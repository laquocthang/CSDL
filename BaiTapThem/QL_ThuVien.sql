/*-----------------------------------------------
Bài lab: Quản lý thư viện
Ngày thực hiện: 20/4/2018
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
    TenTL nvarchar(30) not null
)

go
drop table Sach
create table Sach
(
    MaSach char(6) primary key,
    TuaDe nvarchar(50) not null,
    MaNXB char(4) references NhaXuatBan(MaNXB),
    TacGia nvarchar(30) not null,
    SoLuong int not null,
    NgayNhap datetime not null,
    MaTL char(2) references TheLoai(MaTL)
)

go
drop table BanDoc
create table BanDoc
(
    MaThe char(6) primary key,
    TenBanDoc nvarchar(30) not null,
    DiaChi nvarchar(50) not null,
    SoDT varchar(11)
)

go
drop table MuonSach
create table MuonSach
(
    MaThe char(6) references BanDoc(MaThe),
    MaSach char(6) references Sach(MaSach),
    NgayMuon datetime not null,
    NgayTra datetime,
    CONSTRAINT PK Primary key(MaThe, MaSach, NgayMuon)
)

--------------------------------CÂU 2: XÂY DỰNG CÁC RÀNG BUỘC BẰNG TRIGGER----------------------------------

--RB1: Số lượng sách >=0

--RB2: Tên NXB là duy nhất

--RB3: Tên thể loại là duy nhất

--RB4: Mã thẻ gồm 6 ký tự theo quy tắc 2 chữ cuối của năm tạo thẻ + số thứ tự của thẻ trong năm đó

--RB5: Mã sách gồm 6 ký tự theo quy tắc mã thể loại + số thứ tự của cuốn sách trong thể loại đó

--RB6: Mỗi đọc giả không được giữ quá 3 quyển sách

--RB7: Đọc giả không được phép mượn lại cuốn sách mà học đang nợ

--RB8: Số lượng trong bảng sách sẽ được thay đổi tùy theo thao tác cho bạn đọc mượn, nhận trả sách hay nhập thêm sách

--------------------------------CÂU 3: XÂY DỰNG THỦ TỤC THÊM, XÓA, SỬA----------------------------------

create proc usp_ThemNhaXuatBan
@MaNXB char(4), @TenNXB nvarchar(30)
as
if exists (select * from NhaXuatBan where MaNXB = @MaNXB)
	print N'Đã có mã nhà xuất bản trong CSDL'
else
	insert into NhaXuatBan values (@MaNXB, @TenNXB)
----------------------------------------------------
create proc usp_ThemTheLoai
@MaTL char(2), @TenTL nvarchar(30)
as
if exists (select * from TheLoai where MaTL = @MaTL)
	print N'Đã có mã thể loại trong CSDL'
else
	insert into TheLoai values (@MaTL, @TenTL)
----------------------------------------------------
create proc usp_ThemSach
@MaSach char(6), @TuaDe nvarchar(50), @MaNXB char(4), @TacGia nvarchar(30), @SoLuong int, @NgayNhap datetime, @MaTL char(2)
as
if exists (select * from Sach where MaSach = @MaSach)
	print N'Đã có mã sách trong CSDL'
else
	insert into Sach values (@MaSach, @TuaDe, @MaNXB, @TacGia, @SoLuong, @NgayNhap, @MaTL)
----------------------------------------------------
create proc usp_ThemBanDoc
@MaThe char(6), @TenBanDoc nvarchar(30), @DiaChi nvarchar(50), @SoDT varchar(11)
as
if exists (select * from BanDoc where MaThe = @MaThe)
	print N'Đã có mã bạn đọc trong CSDL'
else
	insert into BanDoc values (@MaThe, @TenBanDoc, @DiaChi, @SoDT)
----------------------------------------------------
create proc usp_ThemMuonSach
@MaThe char(6), @MaSach char(6), @NgayMuon datetime, @NgayTra datetime
as
if exists (select * from MuonSach where MaThe = @MaThe and MaSach = @MaSach and NgayMuon = @NgayMuon)
	print N'Đã có dữ liệu mượn sách trong CSDL'
else
	insert into MuonSach values (@MaThe, @MaSach, @NgayMuon, @NgayTra)
----------------------------------------------------
create proc usp_CapNhatNhaXuatBan
@MaNXB char(4), @TenNXB nvarchar(30)
as
	begin
		update NhaXuatBan
		set TenNXB=@TenNXB
		where MaNXB=@MaNXB
	end
------------------------------------------
create proc usp_CapNhatTheLoai
@MaTL char(2), @TenTL nvarchar(30)
as
	begin
		update TheLoai
		set TenTL=@TenTL
		where MaTL=@MaTL
	end
------------------------------------------
create proc usp_CapNhatSach
@MaSach char(6), @TuaDe nvarchar(50), @MaNXB char(4), @TacGia nvarchar(30), @SoLuong int, @NgayNhap datetime, @MaTL char(2)
as
	begin
		update Sach
		set TuaDe=@TuaDe, MaNXB=@MaNXB, TacGia=@TacGia, SoLuong=@SoLuong, NgayNhap=@NgayNhap, MaTL=@MaTL
		where MaSach=@MaSach
	end
------------------------------------------
create proc usp_CapNhatBanDoc
@MaThe char(6), @TenBanDoc nvarchar(30), @DiaChi nvarchar(50), @SoDT varchar(11)
as
	begin
		update BanDoc
		set TenBanDoc=@TenBanDoc, DiaChi=@DiaChi, SoDT=@SoDT
		where MaThe=@MaThe
	end
------------------------------------------
create proc usp_CapNhatMuonSach
@MaThe char(6), @MaSach char(6), @NgayMuon datetime, @NgayTra datetime
as
	begin
		update MuonSach
		set NgayTra=@NgayTra
		where MaThe = @MaThe and MaSach = @MaSach and NgayMuon = @NgayMuon
	end

------------------------------------------
------------------------------------------
------------------------------------------

--------------------------------CÂU 4: VIẾT THỦ TỤC CẬP NHẬT SỐ LƯỢNG CUỐN SÁCH CÓ MÃ SỐ X TÙY THEO THAO TÁC CHO MƯỢN HOẶC NHẬN TRẢ SÁCH----------------------------------

--------------------------------CÂU 5: VIẾT THỦ TỤC LẬP DANH SÁCH CÁC QUYỂN SÁCH THUỘC MỘT THỂ LOẠI CHO TRƯỚC----------------------------------

--------------------------------CÂU 6: VIẾT THỦ TỤC LIỆT KÊ NHỮNG THÔNG TIN CỦA TẤT CẢ ĐỘC GIẢ ĐANG CÒN NỢ SÁCH----------------------------------

--------------------------------CÂU 7: VIẾT THỦ TỤC LẬP DANH SÁCH DANH SÁCH MÀ MỘT ĐỘC GIẢ CHO TRƯỚC ĐÃ MƯỢN----------------------------------

--------------------------------CÂU 8: VIẾT THỦ TỤC LẬP DANH SÁCH CÁC QUYỂN SÁCH CHƯA ĐƯỢC MƯỢN----------------------------------

--------------------------------------------------------------------------------------------

exec usp_ThemNhaXuatBan 'N001',N'Giáo dục'
exec usp_ThemNhaXuatBan 'N002',N'Khoa học kỹ thuật'
exec usp_ThemNhaXuatBan 'N003',N'Thống kê'

exec usp_ThemTheLoai 'TH',N'Tin học'
exec usp_ThemTheLoai 'HH',N'Hóa học'
exec usp_ThemTheLoai 'KT',N'Kinh tế'
exec usp_ThemTheLoai 'TN',N'Toán học'

exec usp_ThemSach 'TH0001',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn','3','9/8/2005','TH'
exec usp_ThemSach 'TH0002',N'Lập trình mạng','N003',N'Phạm Vĩnh Hưng','2','12/3/2003','TH'
exec usp_ThemSach 'TH0003',N'Thiết kế mạng chuyên nghiệp','N002',N'Phạm Vĩnh Hưng','5','5/4/2003','TH'
exec usp_ThemSach 'TH0004',N'Thực hành mạng','N003',N'Trần Quang','3','5/6/2005','TH'
exec usp_ThemSach 'TH0005',N'3D Studio kỹ xảo hoạt hình T1','N001',N'Trương Bình','2','2/5/2004','TH'
exec usp_ThemSach 'TH0006',N'3D Studio kỹ xảo hoạt hình T2','N001',N'Trương Bình','3','6/5/2004','TH'
exec usp_ThemSach 'TH0007',N'Giáo trình Access 2000','N001',N'Thiện Tâm','5','12/11/2005','TH'

exec usp_ThemBanDoc '050001',N'Trần Xuân','17 Yersin','858936'
exec usp_ThemBanDoc '050002',N'Lê Nam',N'5 Hai Bà Trưng','845623'
exec usp_ThemBanDoc '060001',N'Nguyễn Năm',N'10 Lý Tự Trọng','823456'
exec usp_ThemBanDoc '060002',N'Trần Hùng',N'20 Trần Phú','841256'

exec usp_ThemMuonSach '050001','TH0006','12/12/2006','3/1/2007'
exec usp_ThemMuonSach '050001','TH0007','12/12/2006',''
exec usp_ThemMuonSach '050002','TH0001','3/8/2006','4/15/2007'
exec usp_ThemMuonSach '050002','TH0002','3/4/2007','4/4/2007'
exec usp_ThemMuonSach '050002','TH0003','4/2/2007','4/15/2007'
exec usp_ThemMuonSach '050002','TH0004','3/4/2007',''
exec usp_ThemMuonSach '060002','TH0001','4/8/2007',''
exec usp_ThemMuonSach '060002','TH0007','3/15/2007','4/15/2007'

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