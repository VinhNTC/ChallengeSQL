use QLBongDa
--Cau 1
go
select MACT, HOTEN, NGAYSINH, DIACHI, VITRI
from CAUTHU ct, CAULACBO clb, QUOCGIA qg
where ct.MACLB = clb.MACLB and
		ct.MAQG = qg.MAQG and
		TENCLB like N'%SHB Đà Nẵng%' and
		TENQG like N'%Bra-xin%'
--Cau2
go
select HOTEN, SOTRAI
from CAUTHU ct, THAMGIA tg
where ct.MACT = tg.MACT and
		tg.SOTRAI >= 2
--Cau 3
go
select MATRAN, NGAYTD, TENSAN, clb1.TENCLB, clb2.TENCLB,KETQUA
from TRANDAU td, SANVD svd, CAULACBO clb1, CAULACBO clb2
where td.MASAN = svd.MASAN and 
	MACLB1 = clb1.MACLB and
	MACLB2 = clb2.MACLB and
	td.VONG = 3 and td.NAM = 2009
--Cau 4
go
select hlv.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, clb.TENCLB
from HUANLUANVIEN hlv, HLV_CLB hlv_clb, CAULACBO clb, QUOCGIA qg
where hlv.MAHLV = hlv_clb.MAHLV and
		hlv_clb.MACLB = clb.MACLB
		and hlv.MAQG = qg.MAQG
		and qg.TENQG like N'%Việt Nam%'
--Cau 5
go
select clb.MACLB, TENCLB, svd.TENSAN, svd.DIACHI, COUNT(ct.MACT) as SOLUONGNGOAIBINH
from CAULACBO clb, SANVD svd, CAUTHU ct, QUOCGIA qg
where clb.MACLB = ct.MACLB and
		clb.MASAN = svd.MASAN and
		ct.MAQG = qg.MAQG and
		qg.TENQG <> N'Việt Nam'
group by qg.MAQG, clb.MACLB, TENCLB, TENSAN, svd.DIACHI
having COUNT(ct.MACT) >= 2
--Cau 6
go
select t.TENTINH, COUNT(ct.MACT) as SOLUONGCAUTHU
from TINH t, CAUTHU ct, CAULACBO clb
where t.MATINH = clb.MATINH and
	ct.MACLB = clb.MACLB and
	ct.VITRI like N'Tiền Đạo'
group by t.TENTINH
--Cau 7
go
select clb.TENCLB, t.TENTINH
from CAULACBO clb, TINH t, BANGXH bxh
where clb.MATINH = t.MATINH and
	clb.MACLB = bxh.MACLB and
	bxh.HANG = 1 and bxh.VONG = 3 
	and bxh.NAM = 2009
--Cau 8