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
go

--------------------------------CÂU 2: XÂY DỰNG CÁC RÀNG BUỘC BẰNG TRIGGER----------------------------------

--RB1: Số lượng sách >=0
create trigger tg_SoLuongSach
	on Sach for insert, update
	as
	if update(SoLuong)
		if exists(select * from inserted where SoLuong < 0)
			begin
				raiserror (N'Số lượng sách phải >= 0',15,1)
				rollback tran
			end

/*Kiểm tra
exec usp_ThemSach 'TH0008',N'Giáo trình Access 2000','N001',N'Thiện Tâm','-1','12/11/2005','TH'
*/
go

--RB2: Tên NXB là duy nhất
	alter table NhaXuatBan add
	constraint TenNXBDuyNhat unique (TenNXB)

/*Kiểm tra
insert into NhaXuatBan values ('N004',N'Thống kê')
*/
go

--RB3: Tên thể loại là duy nhất
	alter table TheLoai add
	constraint TenTLDuyNhat unique (TenTL)

/*Kiểm tra
insert into TheLoai values ('LH',N'Toán học')
*/
go

--RB4: Mã thẻ gồm 6 ký tự theo quy tắc 2 chữ cuối của năm tạo thẻ + số thứ tự của thẻ trong năm đó
--(Cái này chuyển sang phần hàm thay vì phần ràng buộc)
drop function dbo.fn_SinhMaThe
create function fn_SinhMaThe() returns char(6)
	as
		begin
			declare @NamHienTai char(4)
			declare @stt int
			declare @MaThe char(6)
			set @stt = 0
			set @NamHienTai = CONVERT(char(4),YEAR(GETDATE()))
			if exists (select * from BanDoc where left(MaThe,2) = right(@NamHienTai,2))
				set @stt = (select convert(int,right(max(MaThe),4))
				from BanDoc
				where left(MaThe,2) = right(@NamHienTai,2))
			set @stt = @stt + 1
			set @MaThe = right('00'+cast(right(@NamHienTai,2) as varchar(2)),2) + right('0000'+cast(@stt as varchar(4)),4)
			return @MaThe
		end

/*Kiểm tra
print dbo.fn_SinhMaThe()
*/
go

--RB5: Mã sách gồm 6 ký tự theo quy tắc mã thể loại + số thứ tự của cuốn sách trong thể loại đó
--(Cái này chuyển sang phần hàm thay vì phần ràng buộc)
drop function fn_SinhMaSach
create function fn_SinhMaSach(@MaTL char(2)) returns char(6)
	as
		begin
			declare @stt int
			declare @MaSach char (6)
			set @stt=0
			if exists (select * from Sach where MaTL = @MaTL)
				set @stt = (select convert(int,right(max(MaSach),4))
				from Sach
				where MaTL = @MaTL)
			set @stt = @stt + 1
			set @MaSach = @MaTL + right('0000'+cast(@stt as varchar(4)),4)
			return @MaSach
		end

/*Kiểm tra
print dbo.fn_SinhMaSach('TH')
print dbo.fn_SinhMaSach('HH')
*/
go

--RB6: Mỗi độc giả không được giữ quá 3 quyển sách
drop trigger tg_KhongGiuQua3CuonSach
create trigger tg_KhongGiuQua3CuonSach
	on MuonSach for insert 
	as
	if update(MaSach)
		begin
			declare cur_ThemMuonSach cursor local
			for select MaThe
			from inserted
			open cur_ThemMuonSach
			declare @MaThe char(6), @SoLuong tinyint
			fetch next from cur_ThemMuonSach into @MaThe
			while @@FETCH_STATUS = 0
				begin
					set @SoLuong = (select count(MaSach) from MuonSach where NgayTra = '' and MaThe = @MaThe)
					if @SoLuong > 3
						begin
							raiserror (N'Mỗi bạn đọc chỉ giữ từ 3 cuốn sách trở xuống',15,1)
							rollback tran
						end
					fetch next from cur_ThemMuonSach into @MaThe
				end
			close cur_ThemMuonSach
			deallocate cur_ThemMuonSach
		end

/*Kiểm tra
delete from MuonSach
insert into MuonSach values ('060001','TH0001','4/8/2007','')
insert into MuonSach values ('060001','TH0002','4/8/2007','')
insert into MuonSach values ('060001','TH0003','4/8/2007','')
insert into MuonSach values ('060001','TH0004','4/8/2007','')
*/
go

--RB7: Độc giả không được phép mượn lại cuốn sách mà họ đang nợ
drop trigger tg_KhongDuocMuonLai
create trigger tg_KhongDuocMuonLai
	on MuonSach for insert, update
	as
	if update(MaSach)
		begin
			declare cur_ThemMuonSach cursor local
			for select MaThe, MaSach
			from inserted
			open cur_ThemMuonSach
			declare @MaThe char(6), @MaSach char(6), @soLuong tinyint
			fetch next from cur_ThemMuonSach into @MaThe, @MaSach
			while @@FETCH_STATUS = 0
				begin
					set @soLuong = (select count(MaSach) from MuonSach where MaThe = @MaThe and MaSach = @MaSach)
					if @soLuong>=2
						begin
							raiserror (N'Không được mượn lại cuốn sách đã nợ',15,1)
							rollback tran
						end
					fetch next from cur_ThemMuonSach into @MaThe, @MaSach
				end
			close cur_ThemMuonSach
			deallocate cur_ThemMuonSach
		end
go

--RB8: Số lượng trong bảng sách sẽ được thay đổi tùy theo thao tác cho bạn đọc mượn, nhận trả sách hay nhập thêm sách
drop trigger tg_CapNhatSoLuongSach
create trigger tg_CapNhatSoLuongSach
	on MuonSach for insert, update
	as
	if update(MaSach) or update(NgayMuon) or update(NgayTra)
		begin
			declare cur_ThemMuonSach cursor local
			for select MaSach, NgayMuon, NgayTra
			from inserted
			open cur_ThemMuonSach
			declare @MaSach char(6), @NgayMuon datetime, @NgayTra datetime
			fetch next from cur_ThemMuonSach into @MaSach, @NgayMuon, @NgayTra
			while @@fetch_status = 0
				begin
					if @NgayMuon <> ''
						begin
							update Sach
							set SoLuong = SoLuong - 1
							where MaSach = @MaSach
						end
					if @NgayTra <> ''
						begin
							update Sach
							set SoLuong = SoLuong + 1
							where MaSach = @MaSach
						end
					fetch next from cur_ThemMuonSach into @MaSach, @NgayMuon, @NgayTra
				end
			close cur_ThemMuonSach
			deallocate cur_ThemMuonSach
		end		
go

--Cách 2 (Sử dụng thủ tục Cập nhật sách 2)
create trigger tg_CapNhatSoLuongSach_2
	on MuonSach for insert, update
	as
	if update(MaSach) or update(NgayMuon) or update(NgayTra)
		begin
			declare cur_ThemMuonSach cursor local
			for select MaSach, NgayMuon, NgayTra
			from inserted
			open cur_ThemMuonSach
			declare @MaSach char(6), @NgayMuon datetime, @NgayTra datetime
			fetch next from cur_ThemMuonSach into @MaSach, @NgayMuon, @NgayTra
			while @@fetch_status = 0
				begin
					if @NgayMuon <> ''
						exec usp_CapNhatSach_2 @MaSach,1
					if @NgayTra <> ''
							exec usp_CapNhatSach_2 @MaSach,2
					fetch next from cur_ThemMuonSach into @MaSach, @NgayMuon, @NgayTra
				end
			close cur_ThemMuonSach
			deallocate cur_ThemMuonSach
		end		

/*Kiểm tra
insert into MuonSach values ('060001','TH0001','4/8/2007','')
*/
go

--------------------------------CÂU 3: XÂY DỰNG THỦ TỤC THÊM, XÓA, SỬA----------------------------------

--==============THÊM=================
create proc usp_ThemNhaXuatBan
	@MaNXB char(4),
	@TenNXB nvarchar(30)
as
if exists (select * from NhaXuatBan where MaNXB = @MaNXB)
	print N'Đã có mã nhà xuất bản trong CSDL'
else
	insert into NhaXuatBan values (@MaNXB, @TenNXB)
go
----------------------------------------------------
create proc usp_ThemTheLoai
	@MaTL char(2),
	@TenTL nvarchar(30)
as
if exists (select * from TheLoai where MaTL = @MaTL)
	print N'Đã có mã thể loại trong CSDL'
else
	insert into TheLoai values (@MaTL, @TenTL)
go
----------------------------------------------------
create proc usp_ThemSach
	@MaSach char(6),
	@TuaDe nvarchar(50),
	@MaNXB char(4),
	@TacGia nvarchar(30),
	@SoLuong int,
	@NgayNhap datetime,
	@MaTL char(2)
as
if exists (select * from Sach where MaSach = @MaSach)
	print N'Đã có mã sách trong CSDL'
else
	insert into Sach values (@MaSach, @TuaDe, @MaNXB, @TacGia, @SoLuong, @NgayNhap, @MaTL)
go
--Cách 2:
create proc usp_ThemSach_2
	@TuaDe nvarchar(50),
	@MaNXB char(4),
	@TacGia nvarchar(30),
	@SoLuong int,
	@NgayNhap datetime,
	@MaTL char(2)
as
begin
	declare @MaSach char(6)
	set @MaSach = dbo.fn_SinhMaSach(@MaTL)
	insert into Sach values (@MaSach, @TuaDe, @MaNXB, @TacGia, @SoLuong, @NgayNhap, @MaTL)
end
go
----------------------------------------------------
create proc usp_ThemBanDoc
	@MaThe char(6),
	@TenBanDoc nvarchar(30),
	@DiaChi nvarchar(50),
	@SoDT varchar(11)
as
if exists (select * from BanDoc where MaThe = @MaThe)
	print N'Đã có mã bạn đọc trong CSDL'
else
	insert into BanDoc values (@MaThe, @TenBanDoc, @DiaChi, @SoDT)
go
--Cách 2:
create proc usp_ThemBanDoc_2
	@TenBanDoc nvarchar(30),
	@DiaChi nvarchar(50),
	@SoDT varchar(11)
as
	begin
		declare @MaThe char(6)
		set @MaThe = dbo.fn_SinhMaThe()
		insert into BanDoc values (@MaThe, @TenBanDoc, @DiaChi, @SoDT)
	end
go
----------------------------------------------------
create proc usp_ThemMuonSach
	@MaThe char(6),
	@MaSach char(6),
	@NgayMuon datetime,
	@NgayTra datetime
as
if exists (select * from MuonSach where MaThe = @MaThe and MaSach = @MaSach and NgayMuon = @NgayMuon)
	print N'Đã có dữ liệu mượn sách trong CSDL'
else
	insert into MuonSach values (@MaThe, @MaSach, @NgayMuon, @NgayTra)
go

--==============CẬP NHẬT=================
create proc usp_CapNhatNhaXuatBan
	@MaNXB char(4),
	@TenNXB nvarchar(30)
as
	begin
		update NhaXuatBan
		set TenNXB=@TenNXB
		where MaNXB=@MaNXB
	end
go
------------------------------------------
create proc usp_CapNhatTheLoai
	@MaTL char(2),
	@TenTL nvarchar(30)
as
	begin
		update TheLoai
		set TenTL=@TenTL
		where MaTL=@MaTL
	end
go
------------------------------------------
create proc usp_CapNhatSach
	@MaSach char(6),
	@TuaDe nvarchar(50),
	@MaNXB char(4),
	@TacGia nvarchar(30),
	@SoLuong int,
	@NgayNhap datetime,
	@MaTL char(2)
as
	begin
		update Sach
		set TuaDe=@TuaDe, MaNXB=@MaNXB, TacGia=@TacGia, SoLuong=@SoLuong, NgayNhap=@NgayNhap, MaTL=@MaTL
		where MaSach=@MaSach
	end
go
------------------------------------------
create proc usp_CapNhatBanDoc
	@MaThe char(6),
	@TenBanDoc nvarchar(30),
	@DiaChi nvarchar(50),
	@SoDT varchar(11)
as
	begin
		update BanDoc
		set TenBanDoc=@TenBanDoc, DiaChi=@DiaChi, SoDT=@SoDT
		where MaThe=@MaThe
	end
go
------------------------------------------
create proc usp_CapNhatMuonSach
	@MaThe char(6),
	@MaSach char(6),
	@NgayMuon datetime,
	@NgayTra datetime
as
	begin
		update MuonSach
		set NgayTra=@NgayTra
		where MaThe = @MaThe and MaSach = @MaSach and NgayMuon = @NgayMuon
	end
go

--==============XÓA=================
create proc usp_XoaNXB
	@MaNXB char(4)
as
if exists(select * from Sach where @MaNXB = MaNXB)
	print N'Không thể xóa vì đã có tham chiếu'
else
	begin
		delete from NhaXuatBan
		where MaNXB = @MaNXB
	end

/*Kiểm tra
exec usp_XoaNXB 'N001'
*/
go
------------------------------------------
create proc usp_XoaTheLoai
	@MaTL char(2)
as
if exists(select * from Sach where @MaTL = MaTL)
	print N'Không thể xóa vì đã có tham chiếu'
else
	begin
		delete from TheLoai
		where MaTL = @MaTL
	end

/*Kiểm tra
exec usp_XoaNXB 'N001'
*/
go
------------------------------------------
create proc usp_XoaBanDoc
	@MaThe char(6)
as
if exists (select * from MuonSach where @MaThe = MaThe)
	print N'Không thể xóa vì đã có tham chiếu'
else
	begin
		delete from BanDoc
		where MaThe = @MaThe
	end

/*Kiểm tra
exec usp_XoaBanDoc '050001'
*/
go
------------------------------------------
create proc usp_XoaSach
	@MaSach char(6)
as
if exists (select * from MuonSach where @MaSach = MaSach)
	print N'Không thể xóa vì đã có tham chiếu'
else
	begin
		delete from Sach
		where MaSach = @MaSach
	end

/*Kiểm tra
exec usp_XoaSach 'TH0001'
*/
go
------------------------------------------
create proc usp_XoaMuonSach
	@MaThe char(6),
	@MaSach char(6),
	@NgayMuon datetime
as
	begin
		delete from MuonSach
		where MaSach = @MaSach and MaThe = @MaThe and NgayMuon = @NgayMuon
	end
go

--------------------------------CÂU 4: VIẾT THỦ TỤC CẬP NHẬT SỐ LƯỢNG CUỐN SÁCH CÓ MÃ SỐ X TÙY THEO THAO TÁC CHO MƯỢN HOẶC NHẬN TRẢ SÁCH----------------------------------
drop proc usp_CapNhatSach_2
create proc usp_CapNhatSach_2
	@MaSach char(6),
	@ThaoTac tinyint
as
	begin
		declare cur_CapNhatSach cursor local
		for select MaSach
		from Sach
		open cur_CapNhatSach
		declare @MaSH char(6)
		fetch next from cur_CapNhatSach into @MaSH
		while @@FETCH_STATUS = 0
			begin
				if @MaSH = @MaSach
					if @ThaoTac = 1
						begin
							update Sach
							set SoLuong = SoLuong - 1
							where @MaSach = MaSach
						end
					else
						begin
							update Sach
							set SoLuong = SoLuong + 1
							where @MaSach = MaSach
						end
				fetch next from cur_CapNhatSach into @MaSH
			end
		close cur_CapNhatSach
		deallocate cur_CapNhatSach
	end

/*Kiểm tra
exec usp_CapNhatSach_2 'TH0001',2
*/
go

--------------------------------CÂU 5: VIẾT THỦ TỤC LẬP DANH SÁCH CÁC QUYỂN SÁCH THUỘC MỘT THỂ LOẠI CHO TRƯỚC----------------------------------
create proc usp_LietKeSach_TheLoai
	@MaTL char(2)
as
select * from Sach where MaTL = @MaTL

/*Kiểm tra
exec usp_LietKeSach_TheLoai 'TH'
exec usp_LietKeSach_TheLoai 'TN'
*/
go
--------------------------------CÂU 6: VIẾT THỦ TỤC LIỆT KÊ NHỮNG THÔNG TIN CỦA TẤT CẢ ĐỘC GIẢ ĐANG CÒN NỢ SÁCH----------------------------------
create proc usp_LietKeBanDocNoSach
as
select * from BanDoc where MaThe in (select distinct MaThe from MuonSach where NgayTra = '')

/*Kiểm tra
exec usp_LietKeBanDocNoSach
*/
go
--------------------------------CÂU 7: VIẾT THỦ TỤC LẬP DANH SÁCH CÁC QUYỂN SÁCH MÀ MỘT ĐỘC GIẢ CHO TRƯỚC ĐÃ MƯỢN----------------------------------
create proc usp_LietKeSach_BanDocDaMuon
	@MaThe char(6)
as
select * from Sach where MaSach in (select distinct MaSach from MuonSach where @MaThe = MaThe)

/*Kiểm tra
exec usp_LietKeSach_BanDocDaMuon '050002'
*/
go
--------------------------------CÂU 8: VIẾT THỦ TỤC LẬP DANH SÁCH CÁC QUYỂN SÁCH CHƯA ĐƯỢC MƯỢN----------------------------------
create proc usp_LietKeSach_ChuaMuon
as
select * from Sach where MaSach not in (select distinct MaSach from MuonSach)

/*Kiểm tra
exec usp_LietKeSach_ChuaMuon
*/
go
--------------------------------------------------------------------------------------------

exec usp_ThemNhaXuatBan 'N001',N'Giáo dục'
exec usp_ThemNhaXuatBan 'N002',N'Khoa học kỹ thuật'
exec usp_ThemNhaXuatBan 'N003',N'Thống kê'

exec usp_ThemTheLoai 'TH',N'Tin học'
exec usp_ThemTheLoai 'HH',N'Hóa học'
exec usp_ThemTheLoai 'KT',N'Kinh tế'
exec usp_ThemTheLoai 'TN',N'Toán học'

set dateformat mdy
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