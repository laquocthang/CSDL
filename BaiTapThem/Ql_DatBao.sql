/* Môn: Cơ sở dữ liệu
   Bài lab: QL_DatBao
   Thực hiện: La Quốc Thắng
   MSSV: 1610207
   Ngày: 11/4/2018 
*/
---------------------------------------------------------------------------------------

create database QL_DatBao

use QL_DatBao

go
create table BAO_TCHI
(
	MA_BAO_TC varchar(4) primary key,
	TEN nvarchar(30) not null,
	DINH_KY nvarchar(30) not null,
	SOLUONG smallint not null,
	GIABAN int not null
)

go
create table PHATHANH_BAO
(
	MA_BAO_TC varchar(4),
	SO_BAO_TC smallint,
	NGAY_PH date not null,
	primary key(MA_BAO_TC,SO_BAO_TC)
)

go
create table KH_HANG
(
	MAKH varchar(4) primary key,
	TENKH nvarchar(8) not null,
	DC_KH varchar(10) not null
)

go
create table DATBAO
(
	MAKH varchar(4) references KH_HANG(MAKH),
	MA_BAO_TC varchar(4) references BAO_TCHI(MA_BAO_TC),
	SL_MUA smallint not null,
	NGAY_DM date not null,
	primary key(MAKH, MA_BAO_TC)
)

insert into BAO_TCHI values('TT01',N'Tuổi trẻ',N'Nhật báo','1000','1500')
insert into BAO_TCHI values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san','3000','6000')
insert into BAO_TCHI values('TN01',N'Thanh niên',N'Nhật báo','1000','2000')
insert into BAO_TCHI values('PN01',N'Phụ nữ',N'Tuần báo','2000','4000')
insert into BAO_TCHI values('PN02',N'Phụ nữ',N'Nhật báo','1000','2000')

set dateformat dmy
insert into PHATHANH_BAO values('TT01','123','15/12/2005')
insert into PHATHANH_BAO values('KT01','70','15/12/2005')
insert into PHATHANH_BAO values('TT01','124','16/12/2005')
insert into PHATHANH_BAO values('TN01','256','17/12/2005')
insert into PHATHANH_BAO values('PN01','45','23/12/2005')
insert into PHATHANH_BAO values('PN02','111','18/12/2005')
insert into PHATHANH_BAO values('PN02','112','19/12/2005')
insert into PHATHANH_BAO values('TT01','125','17/12/2005')
insert into PHATHANH_BAO values('PN01','46','30/12/2005')

insert into KH_HANG values('KH01',N'LAN','2 NCT')
insert into KH_HANG values('KH02',N'NAM','32 THĐ')
insert into KH_HANG values('KH03',N'NGỌC','16 LHP')

insert into DATBAO values('KH01','TT01','100','12/1/2000')
insert into DATBAO values('KH02','TN01','150','1/5/2001')
insert into DATBAO values('KH01','PN01','200','25/6/2001')
insert into DATBAO values('KH03','KT01','50','17/3/2002')
insert into DATBAO values('KH03','PN02','200','26/8/2003')
insert into DATBAO values('KH02','TT01','250','15/1/2004')
insert into DATBAO values('KH01','KT01','300','14/10/2004')

select * from BAO_TCHI

select * from PHATHANH_BAO

select * from KH_HANG

select * from DATBAO

-----------------------------------TRUY VẤN SỮ LIỆU--------------------------------

--Câu 1: Cho biết các tờ báo, tạp chí có định kỳ phát hành hàng tuần
select *
from BAO_TCHI
where DINH_KY like N'Tuần báo'

--Câu 2: Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ
select a.MA_BAO_TC, TEN, DINH_KY, SOLUONG, GIABAN, SO_BAO_TC, NGAY_PH
from BAO_TCHI a, PHATHANH_BAO b
where a.MA_BAO_TC=b.MA_BAO_TC and a.MA_BAO_TC like 'PN%'

--Câu 3: Cho biết tên các khách hàng có đặt mua báo phụ nữ, không liệt kê khách hàng trùng
select a.MAKH, TENKH
from KH_HANG a, DATBAO b
where a.MAKH=b.MAKH and MA_BAO_TC like 'PN%'
group by a.MAKH, TENKH

--Câu 4: Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ
select a.MAKH, TENKH
from KH_HANG a, DATBAO b
where a.MAKH=b.MAKH and MA_BAO_TC like 'PN%'
group by a.MAKH, TENKH
having COUNT(a.MAKH)=(select COUNT(MAKH)
					from DATBAO
					where MA_BAO_TC like 'PN%')
					
--Câu 5: Cho biết tên các khách hàng không đặt mua báo thanh niên
select a.MAKH, TENKH, DC_KH
from KH_HANG a, DATBAO b
where a.MAKH=b.MAKH and a.MAKH not in (select MAKH
									from DATBAO
									where MA_BAO_TC like 'TN%')
									
--Câu 6: Cho biết số tờ báo mã mỗi khách hàng đã đặt mua
select a.MAKH, TENKH, DC_KH, SUM(SL_MUA) as SoLuongMua
from KH_HANG a, DATBAO b
where a.MAKH=b.MAKH
group by a.MAKH, TENKH, DC_KH

--Câu 7: Cho biết số khách hàng đặt mua báo trong năm 2004
select COUNT(MAKH)
from DATBAO
where YEAR(NGAY_DM)=2004

--Câu 8: Cho biết thông tin đặt mua báo của các khách hàng
select TENKH, TEN, DINH_KY, SL_MUA, SL_MUA * GIABAN as SoTien
from KH_HANG a, BAO_TCHI b, DATBAO c
where a.MAKH=c.MAKH and b.MA_BAO_TC=c.MA_BAO_TC
group by TENKH, TEN, DINH_KY, SL_MUA, GIABAN

--Câu 9: Cho biết các tờ báo, tạp chí và tổng số lượng đặt mua của từng khách hàng đối với tờ báo, tạp chí đó
select A.MA_BAO_TC, TEN, DINH_KY, SUM(SL_MUA) AS SoLuongDat
from BAO_TCHI A, DATBAO B
where A.MA_BAO_TC=B.MA_BAO_TC
group by A.MA_BAO_TC,TEN,DINH_KY

--Câu 10:Cho biết các tờ báo dành cho sv
select MA_BAO_TC, TEN
from BAO_TCHI
where MA_BAO_TC like 'HS%'

--Câu 11:Cho biết những tờ báo không có người đặt mua
select A.MA_BAO_TC, TEN
from BAO_TCHI A
where A.MA_BAO_TC not in(select B.MA_BAO_TC
from BAO_TCHI B, DATBAO C
where B.MA_BAO_TC=C.MA_BAO_TC)

--Câu 12:Cho biết tên, định kỳ những tờ báo có nhiều người đặt mua nhất
select TEN, DINH_KY, SUM(SL_MUA) AS TóngSLMua
from BAO_TCHI A, DATBAO B
where A.MA_BAO_TC=B.MA_BAO_TC
group by  TEN,DINH_KY
having SUM(SL_MUA)>= all(select SUM(D.SL_MUA)
						from DATBAO D
						group by  MA_BAO_TC)

--Câu 13:Cho biết khách hàng đặt mua nhiều báo nhất
select TENKH, DC_KH, SUM(SL_MUA) AS TongSLMua
from KH_HANG A, DATBAO B
where A.MAKH=B.MAKH
group by TENKH, DC_KH
having SUM(SL_MUA)>= all(select SUM(C.SL_MUA) 
						from DATBAO C
						group by MAKH)

--Câu 14: Cho biết các tờ báo phát hành định kỳ 2 lần trong tháng
select TEN, DINH_KY
from BAO_TCHI
where DINH_KY like N'Bán nguyệt san'

--Câu 15: Cho biết các tờ báo có 3 khách hàng đặt mua trở lên
select A.MA_BAO_TC, TEN, COUNT(MAKH) AS SoKhach
from BAO_TCHI A, DATBAO B
where A.MA_BAO_TC=b.MA_BAO_TC
group by A.MA_BAO_TC, TEN
having COUNT(MAKH)>=3