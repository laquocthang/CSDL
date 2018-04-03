use Lab02_QLSach_1610207

--Query 1
select a.MaTL, b.TenTL, sum(a.SoLuong) as SoLuong
from Sach a, TheLoai b
where a.MaTL=b.MaTL
group by a.MaTL,TenTL

--Query 2
select b.MaNXB, b.TenNXB, sum(SOLUONG) as SoCuonSach
from Sach a, NhaXuatBan b
where a.MaNXB=b.MaNXB
group by b.MaNXB, b.TenNXB

--Query 3
select a.MaTG, b.TenTG, count(a.MaTG) as SoCuonSach
from Sach a, TacGia b
where a.MaTG=b.MaTG
group by a.MaTG, b.TenTG

--Query 4
select NamXB, sum(SoLuong)
from Sach
group by NamXB

--Query 5
select NamXB, sum(SoLuong)
from Sach
where NamXB=2005
group by NamXB

--Query 6


--Query 7
select TenSach, TenTG, TenNXB, NamXB, SoLuong
from Sach a, TacGia b, NhaXuatBan c
where a.MaTG=b.MaTG and a.MaNXB=c.MaNXB

--Query 8
select TenSach, TenTG
from Sach a, TacGia b, TheLoai c
where a.MaTG=b.MaTG and a.MaTL=c.MaTL and c.TenTL like N'Văn hóa - Du lịch' intersect
(select TenSach, TenTG
from Sach a, TacGia b, TheLoai c
where a.MaTG=b.MaTG and a.MaTL=c.MaTL and c.TenTL like N'Ngoại ngữ')

--Query 9
select TenSach, SoTrang
from Sach
where SoTrang>400

--Query 10
select TenNXB, c.MaNXB
from Sach a, TheLoai b, NhaXuatBan c
where a.MaTL=b.MaTL and a.MaNXB=c.MaNXB and b.TenTL not in (
select d.TenTL
from TheLoai d
where d.TenTL = N'Tin học')

--Query 11
