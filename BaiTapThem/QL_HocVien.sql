/*-----------------------------------------------
Bài lab: Quản lý học viên
Ngày thực hiện: 20/4/2018
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
    GioBatDau datetime not null,
    GioKetThuc datetime not null
)
go

drop table GiaoVien
create table GiaoVien
(
    MSGV char(4) primary key,
    HoGV nvarchar(20) not null,
    TenGV nvarchar(10) not null,
    DienThoai varchar(11) not null
)
go

drop table Lop
create table Lop
(
    MaLop char(4) primary key,
    TenLop nvarchar(20) not null,
    NgayKG datetime not null,
    HocPhi int not null,
    Ca tinyint references CaHoc(Ca),
    SoTiet int not null,
    SoHV int,
    MSGV char(4) references GiaoVien(MSGV)
)
go

drop table HocVien
create table HocVien
(
    MSHV char(4) primary key,
    Ho nvarchar(20) not null,
    Ten nvarchar(10) not null,
    NgaySinh datetime not null,
    Phai nvarchar(4),
    MaLop char(4) references Lop(MaLop)
)
go

drop table HocPhi
create table HocPhi
(
    SoBL char(6) primary key,
    MSHV char(4) references HocVien(MSHV),
    NgayThu datetime not null,
    SoTien int,
    NoiDung nvarchar(50) not null,
    NguoiThu nvarchar(30) not null
)
go

------------------------CÂU 3: XÂY DỰNG CÁC RÀNG BUỘC TOÀN VẸN BẰNG TRIGGER------------------------

--RB1: Giờ kết thúc của một ca học không được trước giờ bắt đầu của ca học đó
drop trigger tr_GioBD_GioKT
create trigger tr_GioBD_GioKT
on CaHoc for insert, update
as
if update(GioBatDau) or update(GioKetThuc)
	if exists (select * from inserted i where i.GioKetThuc<i.GioBatDau)
		begin
			raiserror (N'Giờ kết thúc không được trước giờ bắt đầu của ca học',15,1)
			rollback tran
		end
go

/*Kiểm tra
insert into CaHoc values ('4','21:00','20:00')

update CaHoc
set GioKetThuc = '6:45'
where Ca=1
*/

--RB2: Sĩ số học viên của một lớp học (SoHV) không quá 30 học viên và đúng bằng số học viên của lớp đó
--Hàm đếm số học viên hiện có trong 1 lớp
create function fn_Dem_SiSo (@MaLop char(4)) returns int
as
	begin
		declare @count int
		set @count = (select count(MSHV) from HocVien where MaLop=@MaLop)
		return @count
	end
go

/*Kiểm tra
print dbo.fn_Dem_SiSo('A075')
*/

create trigger tg_SiSo
on Lop for insert, update
as
if update(SoHV)
	if exists (select * from inserted where SoHV>30 or SoHV<>dbo.fn_Dem_SiSo(MaLop))
		begin
			raiserror (N'Sĩ số của một lớp không được quá 30 và phải bằng số học viên của lớp',15,1)
			rollback tran
		end
go

/*Kiểm tra
update Lop
set SoHV = 4
where MaLop = 'A075'
*/

--RB3: Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học
--Hàm trả về số tiền học phí cần phải trả của một học viên
drop function fn_SoTienHocPhi_HocVien
create function fn_SoTienHocPhi_HocVien(@MSHV char(4)) returns int
as
	begin
		declare @HocPhi int
		set @HocPhi = (select HocPhi from HocVien h, Lop l where h.MaLop=l.MaLop and MSHV=@MSHV)
		return @HocPhi
	end
go

/*Kiểm tra
print dbo.fn_SoTienHocPhi_HocVien('0001')
*/

drop trigger tg_SoTienThu
create trigger tg_SoTienThu
on HocPhi for insert, update
as
if update(SoTien)
	if exists (select * from HocPhi group by MSHV having sum(SoTien)>dbo.fn_SoTienHocPhi_HocVien(MSHV))
		begin
			raiserror (N'Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên theo học',15,1)
			rollback tran
		end
go

/*Kiểm tra
exec usp_ThemHocPhi_2 '0002','15/02/2009',50000, N'Lan'
*/

------------------------CÂU 4: XÂY DỰNG CÁC HÀM------------------------

--Tính tổng số học phí đã thu được của một lớp khi biết mã lớp
create function fn_TongSoHocPhi_Lop(@MaLop char(4)) returns int
as
	begin
		declare @TongHocPhi int
		set @TongHocPhi = (select sum(SoTien) from HocPhi where LEFT(SoBL,4)=@MaLop)
		return @TongHocPhi
	end
go

/*Kiểm tra
print dbo.fn_TongSoHocPhi_Lop('A075')
*/

--Tính tổng số học phí thu được trong một khoảng thời gian cho trước
create function fn_TongSoHocPhi_KhoangThoiGian (@NgayBD datetime, @NgayKT datetime) returns int
as
	begin
		declare @HocPhi int
		set @HocPhi = (select sum(SoTien) from HocPhi where NgayThu between @NgayBD and @NgayKT)
		return @HocPhi
	end
go

/*Kiểm tra
print dbo.fn_TongSoHocPhi_KhoangThoiGian('16/12/2008','18/12/2008')
*/

--Cho biết một học viên cho trước đã đóng đủ học phí hay chưa
create function fn_KiemTraDongDuHocPhi (@MSHV char(4)) returns bit
as
	begin
		declare @result bit
		declare @soTien int
		set @soTien=(select sum(SoTien) from HocPhi where MSHV=@MSHV)		
		if dbo.fn_SoTienHocPhi_HocVien(@MSHV)=@soTien
			set @result=1		--Đã đóng đủ
		else 
			set @result=0		--Chưa đóng đủ
		return @result
	end
go

/*Kiểm tra
print dbo.fn_KiemTraDongDuHocPhi('0002')
*/

--Hàm sinh mã biên lai
create function fn_SinhMaBL (@MSHV char(4)) returns char(6)
as
	begin
		declare @SoBL varchar(6)
		declare @MaLop char(4)
		declare @SoBL_max char(6)
		declare @stt int
		declare @temp varchar(6)
		declare @i int
		set @SoBL=''
		if exists (select * from HocVien where MSHV=@MSHV)		--Nếu tồn tại học viên
			begin
				select @MaLop = MaLop							--Lấy mã lớp của học viên
				from HocVien
				where MSHV=@MSHV
				if not exists (select * from HocPhi where LEFT(SoBL,4)=@MaLop)	--Tìm số biên lai lớn nhất của lớp
					set @stt=1
				else
					select @SoBL_max=MAX(SoBL)
					from HocPhi
					where LEFT(SoBL,4)=@MaLop
					
				set @stt=CONVERT(int,RIGHT(@SoBL_max,len(@SoBL_max)-len(@MaLop)))+1
					
				set @temp=CONVERT(varchar(2),@stt)				--Tạo số biên lai mới
				set @i=1
				set @SoBL=@MaLop
				while (@i<=2-LEN(@temp))
					begin
						set @SoBL = @SoBL+'0'
						set @i=@i+1
					end
				set @SoBL=@SoBL+@temp;
			end
		return @SoBL
	end
go

------------------------CÂU 5: XÂY DỰNG CÁC THỦ TỤC------------------------

--Thủ tục thêm một học viên
	create proc usp_ThemHocVien
	@MSHV char(4), @Ho nvarchar(20), @Ten nvarchar(10), @NgaySinh datetime, @Phai nvarchar(4), @MaLop char(4)
	as
	if exists (select * from HocVien where MSHV = @MSHV)
		print N'Đã tồn tại học viên này trong CSDL'
	else
		begin
			insert into HocVien values (@MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop)
			update Lop
			set SoHV = SoHV+1
			where MaLop = @MaLop
		end
go

--Thủ tục cập nhật thông tin của một học viên cho trước
	drop proc usp_CapNhat_HocVien
	create proc usp_CapNhat_HocVien
	@MSHV char(4), @Ho nvarchar(20), @Ten nvarchar(10), @NgaySinh datetime, @Phai nvarchar(4), @MaLop char(4)
	as
	if exists (select * from HocVien where MSHV = @MSHV)
		begin
			update HocVien
			set Ho = @Ho, Ten = @Ten, NgaySinh = @NgaySinh, Phai = @Phai, MaLop = @MaLop
			where MSHV = @MSHV
		end
	else 
		exec usp_ThemHocVien @MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop
go
--Xóa một học viên cho trước
	create proc usp_XoaHocVien
	@MSHV char(4)
	as
	if exists (select * from HocVien where MSHV = @MSHV)	
		begin
			delete from HocVien
			where MSHV = @MSHV
		end
	else print N'Không tìm thấy học viên này để xóa'
go

--Thêm một lớp học
	create proc usp_ThemLop
	@MaLop char(4), @TenLop nvarchar(20), @NgayKG datetime, @HocPhi int, @Ca tinyint, @SoTiet int, @SoHV int, @MSGV char(4)
	as
	if exists(select * from Lop where MaLop = @MaLop)
		print N'Đã tồn tại lớp này trong CSDL'
	else
		insert into Lop values (@MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV)

--Cập nhật thông tin của một lớp học cho trước
	create proc usp_CapNhat_LopHoc
	@MaLop char(4), @TenLop nvarchar(20), @NgayKG datetime, @HocPhi int, @Ca tinyint, @SoTiet int, @SoHV int, @MSGV char(4)
	as
	if exists (select * from Lop where MaLop = @MaLop)
		begin
			update Lop
			set TenLop = @TenLop, NgayKG = @NgayKG, HocPhi = @HocPhi, Ca = @Ca, SoTiet = @SoTiet, SoHV = @SoHV, MSGV = @MSGV
			where MaLop = @MaLop
		end
	else
		exec usp_ThemLop @MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV
go

--Xóa một lớp học cho trước nếu lớp học này không có học viên
	create proc usp_Xoa_LopHoc
	@MaLop char(4)
	as
	if exists (select * from Lop where MaLop = @MaLop and SoHV = 0)
		begin
			delete from Lop
			where MaLop = @MaLop
		end
	else
		print N'Không tìm thấy lớp như vậy và/hoặc lớp đã tồn tại học viên'

/*Kiểm tra
exec usp_Xoa_LopHoc 'A076'
*/

--Lập danh sách học viên của một lớp cho trước
	create proc usp_LapDSHocVien_CuaLop
	@MaLop char(4)
	as
	select * from HocVien where MaLop = @MaLop
go

/*Kiểm tra
exec usp_LapDSHocVien_CuaLop 'A075'
*/

--Lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước
	create proc usp_LapDSHocVien_ChuaDongDuHP
	@MaLop char(4)
	as
		if exists (select * from HocVien where MaLop = @MaLop)
			begin
				select * from HocVien where MaLop = @MaLop and dbo.fn_KiemTraDongDuHocPhi(MSHV) = 0
			end
go

/*Kiểm tra
exec usp_LapDSHocVien_ChuaDongDuHP 'E114'
*/

--Thủ tục khác
create proc usp_ThemHocPhi_2
@MSHV char(4), @NgayThu Datetime, @SoTien int, @NguoiThu nvarchar(30)
As
declare @SoBL char(6)
declare @NoiDung nvarchar(50)
declare @MaLop char(4)
if exists (select * from HocVien where Mshv = @mshv)
	Begin
		set @SoBL = dbo.fn_SinhMaBL(@MSHV)
		select @MaLop = malop from HocVien where Mshv = @mshv
		select	@NoiDung = TenLop from Lop where MaLop = @MaLop
		set @NoiDung = 'HP '+ @NoiDung
		insert into HocPhi values(@SoBL, @MSHV, @NgayThu, @SoTien, @NoiDung, @NguoiThu)
		print N'Đã thêm dữ liệu vào bảng học phí thành công.'
	End
go

-----------------------------------------------------------------------------

Insert into CaHoc values ('1','7:30','10:45')
Insert into CaHoc values ('2','13:30','16:45')
Insert into CaHoc values ('3','17:30','20:45')

Insert into GiaoVien values ('G001',N'Lê Hoàng','Anh','858936')
Insert into GiaoVien values ('G002',N'Nguyễn Ngọc',N'Lan','845623')
Insert into GiaoVien values ('G003',N'Trần Minh',N'Hùng','823456')
Insert into GiaoVien values ('G004',N'Võ Thanh',N'Trung','841256')

set dateformat dmy
exec usp_ThemLop 'A075','Access 2-4-6','18/12/2008','150000','3','60','0','G003'
exec usp_ThemLop 'E114','Excel 3-5-7','02/01/2008','120000','1','45','0','G003'
exec usp_ThemLop 'E115','Excel 2-4-6','22/01/2008','120000','3','45','0','G001'
exec usp_ThemLop 'W123','Word 2-4-6','18/12/2008','100000','3','30','0','G001'
exec usp_ThemLop 'W124','Word 3-5-7','01/03/2008','100000','1','30','0','G002'

exec usp_ThemHocVien '0001',N'Lê Văn','Minh','10/06/1998','Nam','A075'
exec usp_ThemHocVien '0002',N'Nguyễn Thị','Mai','20/04/1988',N'Nữ','A075'
exec usp_ThemHocVien '0003',N'Lê Ngọc',N'Tuấn','10/06/1984','Nam','A075'
exec usp_ThemHocVien '0004',N'Vương Tuấn',N'Vũ','25/03/7979','Nam','E114'
exec usp_ThemHocVien '0005',N'Lý Ngọc',N'Hân','01/12/1985',N'Nữ','E114'
exec usp_ThemHocVien '0006',N'Trần Mai','Linh','04/06/1980',N'Nữ','E114'
exec usp_ThemHocVien '0007',N'Nguyễn Ngọc',N'Tuyết','12/05/1986',N'Nữ','W123'

exec usp_CapNhat_HocVien '0001',N'Lê Văn','Minh','10/06/1998','Nam','A075'
exec usp_CapNhat_HocVien '0002',N'Nguyễn Thị','Mai','20/04/1988',N'Nữ','A075'
exec usp_CapNhat_HocVien '0003',N'Lê Ngọc',N'Tuấn','10/06/1984','Nam','A075'
exec usp_CapNhat_HocVien '0004',N'Vương Tuấn',N'Vũ','25/03/7979','Nam','E114'
exec usp_CapNhat_HocVien '0005',N'Lý Ngọc',N'Hân','01/12/1985',N'Nữ','E114'
exec usp_CapNhat_HocVien '0006',N'Trần Mai','Linh','04/06/1980',N'Nữ','E114'
exec usp_CapNhat_HocVien '0007',N'Nguyễn Ngọc',N'Tuyết','12/05/1986',N'Nữ','W123'


Insert into HocPhi values ('A07501','0001','16/12/2008','150000','HP Access 2-4-6','Lan')
Insert into HocPhi values ('A07502','0002','16/12/2008','100000','HP Access 2-4-6','Lan')
Insert into HocPhi values ('A07503','0003','18/12/2008','150000','HP Access 2-4-6',N'Vân')
Insert into HocPhi values ('A07504','0002','15/1/2009','50000','HP Access 2-4-6',N'Vân')
Insert into HocPhi values ('E11401','0004','2/1/2008','120000','HP Excel 3-5-7',N'Vân')
Insert into HocPhi values ('E11402','0005','2/1/2008','120000','HP Excel 3-5-7',N'Vân')
Insert into HocPhi values ('E11403','0006','2/1/2008','80000','HP Excel 3-5-7',N'Vân')
Insert into HocPhi values ('W12301','0007','18/2/2008','100000','HP Word 2-4-6','Lan')

/*Dùng thủ tục ThemHocPhi_2 để thêm biên lai*/
exec usp_ThemHocPhi_2 '0001','16/12/2008',150000, N'Lan'
exec usp_ThemHocPhi_2 '0002','16/12/2008',100000, N'Lan'
exec usp_ThemHocPhi_2 '0003','18/12/2008',150000, N'Vân'
exec usp_ThemHocPhi_2 '0002','15/01/2009',50000, N'Vân'
exec usp_ThemHocPhi_2 '0004','02/01/2008',120000, N'Vân'
exec usp_ThemHocPhi_2 '0005','02/01/2008',120000, N'Vân'
exec usp_ThemHocPhi_2 '0006','02/01/2008',80000, N'Vân'
exec usp_ThemHocPhi_2 '0007','18/02/2008',100000, N'Lan'
go
--------------------------------------

select * from CaHoc

select * from GiaoVien

select * from Lop

select * from HocVien

select * from HocPhi