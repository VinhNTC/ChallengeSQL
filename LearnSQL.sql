use Demo
--CAU 1
go
select SV.TENSV
from KHOA KH, SVIEN SV
where KH.MAKHOA = SV.MAKHOA and
		KH.TENKHOA = 'CNTT'
--CAU 2
go
select MH.TENMH, MH.TINCHI
from MHOC MH
--CAU 3
go
select KQ.DIEM
from SVIEN SV join KQUA KQ on SV.MASV = KQ.MASV
where SV.MASV like '%08'
--CAU 4
go
select *
from SVIEN sv join KQUA kq on sv.MASV = kq.MASV
			join HPHAN hp on kq.MAHP = hp.MAHP
			join MHOC mh on hp.MAMH = mh.MAMH
where kq.DIEM >= 7
--CAU 5
go
select sv.TENSV
from SVIEN sv join KHOA k on sv.MAKHOA = k.MAKHOA
			join MHOC mh on k.MAKHOA = mh.MAKHOA
where mh.TENMH like N'%Toán rời rạc%' 
--CAU 6
go
select *
from MHOC mh join DKIEN dk on mh.MAMH = dk.MAMH
where mh.TENMH like N'%Cơ sở dữ liệu%'
--CAU 7
go
select mh.TENMH
from MHOC mh join DKIEN dk on mh.MAMH = dk.MAMH
where dk.MAMH_TRUOC like 'TH0003'
--CAU 8
go
select hp.MAHP, COUNT(DISTINCT(sv.MASV)) as SoLuongSV
from HPHAN hp join KQUA kq on hp.MAHP = kq.MAHP
			join SVIEN sv on kq.MASV = sv.MASV
group by hp.MAHP
--CAU 9
go
select sv.TENSV, sv.NAM, hp.HOCKY, AVG(kq.DIEM) as DTB
from HPHAN hp join KQUA kq on hp.MAHP = kq.MAHP
			join SVIEN sv on kq.MASV = sv.MASV
group by sv.TENSV, sv.NAM, hp.HOCKY
--CAU 10
go
select TOP (1) sv.TENSV
from SVIEN sv join KQUA kq on sv.MASV = kq.MASV
order by kq.DIEM desc
--CAU 11



