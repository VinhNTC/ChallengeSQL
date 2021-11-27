use DemoQLBanHang
go
--Khai bao bien giu ho ten
declare @HoTen nvarchar(50)
select @HoTen = N'Nguyễn Văn A'
print @HoTen
--Lay gia lon, gia trung binh cua hang hoa
declare @GiaLonNhat float
declare @GiaTrungBinh float

select @GiaLonNhat = MAX(DonGia),
	@GiaTrungBinh = AVG(DonGia)
from HangHoa
print CONCAT(N'Giá lớn nhất: ', @GiaLonNhat, N', Giá TB: ', @GiaTRungBinh)
--Khai bao bien kieu ngay thang
declare @date date = '2019-04-16';
declare @curent_date date = getdate();
declare @duedate date = getdate() + 2;

select @date as 'Date',
		@curent_date as 'Curent date',
		@duedate as 'Due date';
--Khai bao bang tam
declare @bangtam table(
	MaKH nvarchar(50),
	HoTen nvarchar(200)
)
--Lay danh sach khach hang da tung mau hang do vao bang tam
insert into @bangtam
select MaKH, HoTen
from KhachHang
where MaKH in(
	select DISTINCT MaKH
	from HoaDon
)
select * from @bangtam
--Demo tim max
declare @a float
declare @b float
set @a = 11
set @b = 21
if @a > @b
begin
	print CONCAT(@a, ' > ', @b)
end
else
begin
	print CONCAT(@a, ' <= ', @b)
end
--Demo case when
select kh.MaKH, kh.HoTen,
	case GioiTinh
		when 1 then N'Nam'
		when 0 then N'Nữ'
		else N'Khác'
	end as GioiTinh,
	case
		when GioiTinh = 1 then 0.05
		when GioiTinh = 0 then 0.02
		else 0
	end as GiamGia
from KhachHang kh join HoaDon hd on kh.MaKH = hd.MaKH
--Demo while
declare @i int
declare @n int
declare @s int
select @i = 1, @s = 0, @n = 5
while (@i <= @n)
begin
	if(@i % 2 != 0)
	begin
		select @s = @s + @i
	end
	select @i = @i + 1
end
print CONCAT(N'Giá trị của s là: ', @s)
go
declare @age int
declare @name nvarchar(50)
set @age = 20
set @name = N'Vinh'
print (N'Tuổi của Vinh là: ' + cast(@age as nvarchar(2)))
print CONCAT(N'Tuổi của Vinh là: ', @age)
go
select * from sys.tables
select * from sys.all_columns
where object_id = 3
go
declare @temp int 
select @temp = isnull(COUNT(MaKH), 0)
from KhachHang
where MaKH like '11111'
if @temp is null
begin
	print N'temp is null'
end
else
begin
	print @temp
end
--Tao proc lay danh sach hang hoa theo loai, nha cung cap
create proc spLayDanhSachHangHoa
	@MaLoai int,
	@MaNCC nvarchar(50)
as
begin
	select *
	from HangHoa
	where MaLoai = @MaLoai and MaNCC = @MaNCC
end

exec spLayDanhSachHangHoa 1001,'NK'
--demo lay danh sach hang hoa theo loai
create proc spLayDanhSachHangHoaTheoLoai
	@MaLoai int,
	@SoBanGhi int OUTPUT
as
begin
	select *
	from HangHoa
	where MaLoai = @MaLoai
	set @SoBanGhi = @@ROWCOUNT
end
declare @x int
exec spLayDanhSachHangHoaTheoLoai 1001, @x OUT
print @x
--Cau 1: Viet store them loai
create proc spThemLoai
	@MaLoai int OUTPUT,
	@TenLoai nvarchar(50),
	@MoTa nvarchar(max),
	@Hinh nvarchar(50)
as
begin
	--Them moi loai
	insert into Loai(TenLoai, Hinh, MoTa)
	values(@TenLoai, @Hinh, @MoTa)
	--Lay ma loai vua tang
	set @MaLoai = @@IDENTITY
end
--Demo Them loai
declare @Ma int
exec spThemLoai @Ma OUT, N'Văn phòng phẩm',N'Văn phòng phẩm',N'N/A'
print CONCAT(N'Mã loại vừa thêm: ', @Ma)

select * from Loai