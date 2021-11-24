use QLBongDa
--Cau 27
go
create view vCauThu 
as 
	select ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
	from CAULACBO clb join CAUTHU ct on clb.MACLB = ct.MACLB
						join QUOCGIA qg on ct.MAQG = qg.MAQG
	where clb.TENCLB like N'%SHB Đà Nẵng%' and 
	qg.TENQG like '%Bra-xin%'
go
select * from vCauThu
--Cau 28
go
create view vKetQua
as
	select td.MATRAN, td.NGAYTD, svd.TENSAN, clb1.TENCLB as TENCLB1, clb2.TENCLB as TENCLB2, td.KETQUA
	from TRANDAU td join SANVD svd on td.MASAN = svd.MASAN
					join CAULACBO clb1 on clb1.MASAN = svd.MASAN
					join CAULACBO clb2 on clb2.MASAN = svd.MASAN
	where td.VONG = 3 and td.NAM = 2009
go
select * from vKetQua
--Cau 29
go
create view vHLV
as
	select hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, hlv_clb.VAITRO, clb.TENCLB
	from QUOCGIA qg join HUANLUANVIEN hlv on hlv.MAQG = qg.MAQG
					join  HLV_CLB hlv_clb on hlv_clb.MAHLV = hlv.MAHLV
					join CAULACBO clb on hlv_clb.MACLB = clb.MACLB
	where qg.TENQG like N'%Việt Nam%'
go
select * from vHLV
	
							
