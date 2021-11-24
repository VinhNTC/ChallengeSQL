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
go
select hlv.TENHLV
from HUANLUANVIEN hlv, HLV_CLB hlv_clb
where hlv.MAHLV = hlv_clb.MAHLV and
		hlv.DIENTHOAI like ''
--Cau 9
go
select hlv.MAHLV, hlv.TENHLV
from HUANLUANVIEN hlv, QUOCGIA qg, HLV_CLB hlv_clb
where hlv.MAHLV = hlv_clb.MAHLV and
		hlv.MAQG = qg.MAQG and
		qg.TENQG like N'%Việt Nam%' and
		hlv_clb.VAITRO like ''
--Cau 10
go
select ct.MACT, ct.HOTEN, bxh.HANG
from CAUTHU ct, CAULACBO clb, BANGXH bxh
where ct.MACLB = clb.MACLB and
		clb.MACLB = bxh.MACLB and
		bxh.VONG = 3 and bxh.NAM = 2009 and
		(bxh.HANG < 3 or bxh.HANG > 6)
--Cau 11
go
select td.NGAYTD, svd.TENSAN, clb1.TENCLB, clb2.TENCLB, td.KETQUA
from TRANDAU td, SANVD svd, CAULACBO clb1, CAULACBO clb2, BANGXH bxh
where clb1.MACLB = td.MACLB1 and
		clb2.MACLB = td.MACLB2 and
		td.MASAN = svd.MASAN and
		clb1.MACLB = bxh.MACLB and
		bxh.HANG = 1 and bxh.VONG <= 3 and bxh.NAM = 2009
--Cau 12
go
select td.NGAYTD, clb1.TENCLB as tenclb1, clb2.TENCLB as tenclb2, td.KETQUA
from TRANDAU td, CAULACBO clb1, CAULACBO clb2, SANVD svd
where clb1.MACLB = td.MACLB1 and
		clb2.MACLB = td.MACLB2 and
		clb1.MASAN = svd.MASAN and
		MONTH(td.NGAYTD) = 3 and
		td.KETQUA like '%0'
--Cau 13
go 
select ct.MACT, ct.HOTEN, ct.NGAYSINH
from CAUTHU ct
where ct.HOTEN like N'%Công%' 
--Cau 14
go
select ct.MACT, ct.HOTEN, ct.NGAYSINH
from CAUTHU ct
where ct.HOTEN not like N'%Nguyễn%' 
--Cau 15
go
select hlv.MAHLV, hlv.NGAYSINH, hlv.TENHLV, hlv.DIACHI
from HUANLUANVIEN hlv, QUOCGIA qg
where hlv.MAQG = qg.MAQG and
	hlv.MAQG like N'%VN' and
	YEAR(GETDATE()) - YEAR(hlv.NGAYSINH) between 35 and 40
--Cau 16
go
select clb.TENCLB, hlv.TENHLV
from CAULACBO clb, HUANLUANVIEN hlv, HLV_CLB hlv_clb
where clb.MACLB = hlv_clb.MACLB and
		hlv_clb.MAHLV = hlv.MAHLV and
		hlv_clb.VAITRO = 'HLV Chính' and
		DAY(hlv.NGAYSINH) = 20 and MONTH(hlv.NGAYSINH) = 5
--Cau 17
go
select clb.TENCLB, t.TENTINH, sum(tg.SOTRAI) as SoBT
from TRANDAU td join THAMGIA tg on td.MATRAN = tg.MATD
				join CAUTHU ct on tg.MACT = ct.MACT
				join CAULACBO clb on ct.MACLB = clb.MACLB
				join TINH t on clb.MATINH = t.MATINH
where td.NAM = 2009
group by clb.TENCLB, t.TENTINH
having sum(tg.SOTRAI) > = 
			(select Max(SoBT) from (
				select clb.MACLB, sum(tg.SOTRAI) as SoBT
				from TRANDAU td join THAMGIA tg on td.MATRAN = tg.MATD
								join CAUTHU ct on tg.MACT = ct.MACT
								join CAULACBO clb on ct.MACLB = clb.MACLB
				where td.NAM = 2009
				group by clb.MACLB) t)
--Cau 18
go
select clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI, COUNT(ct.MACT) as SOLUONGCAUTHU
from SANVD svd join CAULACBO clb on svd.MASAN = clb.MASAN
				join CAUTHU ct on clb.MACLB = ct.MACLB
where ct.MAQG not like '%VN%' and
		clb.MACLB in(
		select MACLB from(
			select clb.MACLB, COUNT(ct.MACT) as SOLUONG
				from CAULACBO clb join CAUTHU ct on clb.MACLB = ct.MACLB
				where ct.MAQG not like '%VN%'
				group by clb.MACLB
				having COUNT(ct.MACT) >= 2) t1)
group by clb.MACLB, clb.TENCLB, svd.TENSAN, svd.DIACHI
having COUNT(ct.MACT) >= 2
--Cau 19
go
select MACLB, cast(LEFT(HIEUSO, CHARINDEX('-', HIEUSO) - 1) as int) - cast(RIGHT(HIEUSO, len(HIEUSO) - charindex('-', HIEUSO)) as int) as SOBANTHANG
from BANGXH
where NAM = 2009
order by SOBANTHANG desc
--Cau 20
go
select td.NGAYTD, svd.TENSAN, clb1.TENCLB as CLB1, clb2.TENCLB as CLB2, td.KETQUA
from TRANDAU td join SANVD svd on td.MASAN = svd.MASAN
				join CAULACBO clb1 on td.MACLB1 = clb1.MACLB
				join CAULACBO clb2 on td.MACLB2 = clb2.MACLB
where clb1.TENCLB = 
	(select TOP 1 clb.TENCLB
	from CAULACBO clb join BANGXH bxh on bxh.MACLB = clb.MACLB
	where bxh.VONG = 3 and bxh.NAM = 2009
	order by bxh.HANG desc) 
	or clb2.TENCLB = 
	(select TOP 1 clb.TENCLB
	from CAULACBO clb join BANGXH bxh on bxh.MACLB = clb.MACLB
	where bxh.VONG = 3 and bxh.NAM = 2009
	order by bxh.HANG desc) 
--Cau 21
go
SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB1 = c.MACLB
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB2) = 
								(SELECT COUNT(*) - 1 FROM CAULACBO)
EXCEPT
SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB2 = c.MACLB
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB1) = 
								(SELECT COUNT(*) - 1 FROM CAULACBO)
--Cau 22
go
SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB1 = c.MACLB	
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB2) = 
								(SELECT COUNT(*) - 1 FROM CAULACBO)