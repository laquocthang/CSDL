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

------------------------XÂY DỰNG CÁC THỦ TỤC NHẬP LIỆU------------------------

create proc usp_ThemCaHoc
@ca tinyint, @giobd datetime, @giokt datetime
as
insert into CaHoc values(@ca,@giobd,@giokt)
----------------------------------------------------
create proc usp_ThemGiaoVien
@MSGV char(4), @HoGV nvarchar(20), @TenGV nvarchar(10), @DienThoai varchar(11)
as
insert into GiaoVien values(@MSGV, @HoGV, @TenGV, @DienThoai)
----------------------------------------------------
create proc usp_ThemLop
@MaLop char(4), @TenLop nvarchar(20), @NgayKG datetime, @HocPhi int, @Ca tinyint, @SoTiet int, @SoHV int, @MSGV char(4)
as
insert into Lop values (@MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV)
----------------------------------------------------
create proc usp_ThemHocVien
@MSHV char(4), @Ho nvarchar(20), @Ten nvarchar(10), @NgaySinh datetime, @Phai nvarchar(4), @MaLop char(4)
as
insert into HocVien values (@MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop)
----------------------------------------------------
create proc usp_ThemHocPhi
@SoBL char(6), @MSHV char(4), @NgayThu datetime, @SoTien int, @NoiDung nvarchar(50), @NguoiThu nvarchar(30)
as
insert into HocPhi values (@SoBL, @MSHV, @NgayThu, @SoTien, @NoiDung, @NguoiThu)
----------------------------------------------------
print dbo.fn_SinhMaBL('0006')

create proc usp_ThemHocPhi_2
@SoBL char(6), @MSHV char(4), @NgayThu datetime, @SoTien int, @NoiDung nvarchar(50), @NguoiThu nvarchar(30)
as
set @SoBL=dbo.fn_SinhMaBL(@MSHV)
insert into HocPhi values (@SoBL, @MSHV, @NgayThu, @SoTien, @NoiDung, @NguoiThu)


------------------------XÂY DỰNG HÀM TRÊN CƠ SỞ DỮ LIỆU------------------------

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

-----------------------------------------------------------------------------

exec usp_ThemCaHoc '1','7:30','10:45'
exec usp_ThemCaHoc '2','13:30','16:45'
exec usp_ThemCaHoc '3','17:30','20:45'

exec usp_ThemGiaoVien 'G001',N'Lê Hoàng','Anh','858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan','845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng','823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung','841256'

set dateformat dmy
exec usp_ThemLop 'A075','Access 2-4-6','18/12/2008','150000','3','60','3','G003'
exec usp_ThemLop 'E114','Excel 3-5-7','02/01/2008','120000','1','45','3','G003'
exec usp_ThemLop 'E115','Excel 2-4-6','22/01/2008','120000','3','45','0','G001'
exec usp_ThemLop 'W123','Word 2-4-6','18/12/2008','100000','3','30','1','G001'
exec usp_ThemLop 'W124','Word 3-5-7','01/03/2008','100000','1','30','0','G002'

exec usp_ThemHocVien '0001',N'Lê Văn','Minh','10/06/1998','1','A075'
exec usp_ThemHocVien '0002',N'Nguyễn Thị','Mai','20/04/1988','0','A075'
exec usp_ThemHocVien '0003',N'Lê Ngọc',N'Tuấn','10/06/1984','1','A075'
exec usp_ThemHocVien '0004',N'Vương Tuấn',N'Vũ','25/03/7979','1','E114'
exec usp_ThemHocVien '0005',N'Lý Ngọc',N'Hân','01/12/1985','0','E114'
exec usp_ThemHocVien '0006',N'Trần Mai','Linh','04/06/1980','0','E114'
exec usp_ThemHocVien '0007',N'Nguyễn Ngọc',N'Tuyết','12/05/1986','0','W123'

exec usp_ThemHocPhi 'A07501','0001','16/12/2008','150000','HP Access 2-4-6','Lan'
exec usp_ThemHocPhi 'A07502','0002','16/12/2008','100000','HP Access 2-4-6','Lan'
exec usp_ThemHocPhi 'A07503','0003','18/12/2008','150000','HP Access 2-4-6','Van'
exec usp_ThemHocPhi 'A07504','0004','15/1/2009','50000','HP Access 2-4-6','Van'
exec usp_ThemHocPhi 'E11401','0004','2/1/2008','120000','HP Excel 3-5-7','Van'
exec usp_ThemHocPhi 'E11402','0005','2/1/2008','120000','HP Excel 3-5-7','Van'
exec usp_ThemHocPhi 'E11403','0006','2/1/2008','80000','HP Excel 3-5-7','Van'
exec usp_ThemHocPhi 'W12301','0007','18/2/2008','100000','HP Word 2-4-6','Lan'
--------------------------------------

select * from CaHoc

select * from GiaoVien

select * from Lop

select * from HocVien

select * from HocPhi