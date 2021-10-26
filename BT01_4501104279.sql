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
select MATRAN, NGAYTD, TENSAN, MACLB1, MACLB2,KETQUA
from TRANDAU td, BANGXH bxh, SANVD svd, CAULACBO clb
where td.MASAN = svd.MASAN and
		
