/* Môn: Cơ sở dữ liệu
   QL_DatBao
   Thực hiện: La Quốc Thắng
   Ngày: 11/4/2018 
*/
---------------------------------------------------------------------------------------

create database QL_DatBao

use QL_DatBao

go
create table BAO_TCHI
(MA_BAO_TC varchar(4) primary key,
TEN nvarchar(30) not null,
DINH_KY nvarchar(30) not null,
SOLUONG smallint not null,
GIABAN smallint not null)

go
create table PHATHANH_BAO
(MA_BAO_TC varchar(4),
SO_BAO_TC smallint,
NGAY_PH date not null,
primary key(MA_BAO_TC,SO_BAO_TC))

go
create table KH_HANG
(MAKH varchar(4) primary key,
TENKH nvarchar(8) not null,
DC_KH varchar(10) not null)

go
create table DATBAO
(MAKH varchar(4) references KH_HANG(MAKH),
MA_BAO_TC varchar(4) references BAO_TCHI(MA_BAO_TC),
SL_MUA smallint not null,
NGAY_DM date not null,
primary key(MAKH, MA_BAO_TC))

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