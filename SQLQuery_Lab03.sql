use Lab03_QLHangHoa_1610207

--Query 1
select a.NgayBan, a.SoHD, b.TenHH, c.SL_Ban, b.DonGia, c.SL_Ban*b.DonGia as ThanhTien
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH

--Query 2
select a.NgayBan, sum(c.SL_Ban*b.DonGia) as TongTien
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH
group by NgayBan

--Query 3
select b.MaHH, sum(c.SL_Ban) as TongSoBan, sum(c.SL_Ban*b.DonGia) as TongTien 
from HoaDon a, Hang_Hoa b, CT_HoaDon c
where a.SoHD=c.SoHD and b.MaHH=c.MaHH
group by b.MaHH, b.TenHH

--Query 4
--select d.SoHD, a.NgayBan, b.TenKH, sum(d.SL_Ban*c.DonGia) as TongTien
--from HoaDon a, Khach b, Hang_Hoa c, CT_HoaDon d
--where a.SoHD=d.SoHD and a.MaKH=b.MaKH and c.MaHH=d.MaHH
--group by d.SoHD