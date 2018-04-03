use Lab04_QLNhanVien_1610207

--Q17
select B.MANV, Ho+' '+Ten As HoTen, TenCN, TenKN, MucDo
from ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
where A.MSCN=B.MSCN and B.MANV=C.MANV and C.MSKN=D.MSKN and TenKN='Excel' and C.MucDo>=all(
select E.MucDo
from NhanVienKyNang E, KyNang F
where E.MSKN=F.MSKN and TenKN='Excel')

--Q18
select B.MaNV,Ho+' '+Ten As HoTen , TenCN, count(MSKN) As SoKN
from ChiNhanh A, NhanVien B, NhanVienKyNang C
where A.MSCN=B.MSCN and B.MANV=C.MANV
group by B.MANV,Ho,Ten,TenCN
having count(MSKN)>=all (
select count(MSKN)
from NhanVienKyNang
group by MaNV)

/*Truy van long tuong quan
Q19: Voi moi ky nang, cho biet nhung nhan vien gioi hoac thanh thao ky nang do nhat. 
Thong tin gom TenKN (Sap tang dan), MaNV, HoTen, TenCN, MucDo
(Tong quat cua cau Q17)*/
select TenKN, B.MANV, Ho+' '+Ten as HoTen, TenCN, MucDo
from ChiNhanh a, NhanVien B, NhanVienKyNang C, KyNang D
where A.MSCN=B.MSCN and B.MANV=C.MANV and C.MSKN=D.MSKN and C.MucDo=
(select Max(E.MucDo)
from NhanVienKyNang E
where E.MSKN=D.MSKN)
order by TenKN,Ten,Ho
--order by TenKN desc,Ten desc,Ho desc

--Q20: Liet ke cac nhan vien vua su dung duoc Word, vua su dung duoc Access.
--Thong tin can hien thi: MaNV, HoTen, TenCN
select B.MANV, Ho+' '+Ten as HoTen, TenCN
from ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
where A.MSCN=B.MSCN and B.MANV=C.MANV and C.MSKN=D.MSKN
and TenKN='Word' and B.MANV in (
select E.MANV
from NhanVienKyNang E, KyNang F
where E.MSKN=F.MSKN and TenKN='Access')

--Q22: Phép hiệu/trừ
--Liet ke cac nhan vien (MANV,HoTen,TenCN) khong su dung Access
select B.MANV, Ho+' '+Ten as HoTen, TenCN
from ChiNhanh A, NhanVien B
where A.MSCN=B.MSCN and B.MANV not in (
select C.MANV
from NhanVienKyNang C, KyNang D
where C.MSKN=D.MSKN and TenKN='Access')

--Q23: Cho biet nhan vien su dung duoc tat ca ky nang
--(Liet ke nhan vien co so ky nang dung duoc = so ky nang cua bang KyNang)
select B.MANV, Ho+' '+Ten As HoTen, TenCN
from ChiNhanh A, NhanVien B, NhanVienKyNang C
where A.MSCN=B.MSCN and B.MANV=C.MANV
group by B.MANV,Ho,Ten,TenCN
having count(MSKN)=(
select count(MSKN)
from KyNang)