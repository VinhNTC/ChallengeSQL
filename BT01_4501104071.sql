use QLBongDa
go
--21. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (kể cả sân nhà và sân khách) trong mùa giải năm 2009.
--Ta lấy ra mã câu lạc bộ và tên câu lạc
--Từ bảng trận đấu ta join nó với bảng câu lạc bộ, vì tính trên cả sân nhà và sân khách nên ta xét MACLB1 vs MACLB và MACLB2 vs MACLB.
--Điều kiện thuộc năm 2009
--Group by để đếm số trận của clb, so sánh nếu nó đá với tổng số clb trừ đi 1( bỏ nó ra ) thì => nó đá với tất cả các clb.
--Dùng DISTINCT để loại bỏ những trận trùng lập nếu nó lỡ đá lại một trận nữa.
--Sau khi xét ở cả sân nhà và khách thì ta cho nó giao lại với nhau (INTERSECT), thỏa cả 2 vế thì nó sẽ cho ra clb đá với tất cả clb khác ở cả sân nhà và sân khách

SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB1 = c.MACLB
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB2) = (SELECT COUNT(*) - 1 FROM CAULACBO)
EXCEPT
SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB2 = c.MACLB
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB1) = (SELECT COUNT(*) - 1 FROM CAULACBO)

--22. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) trong mùa giải năm 2009.
--Ta lấy ra mã câu lạc bộ và tên câu lạc
--Từ bảng trận đấu ta join nó với bảng câu lạc bộ, vì chỉ tính trên sân nhà nên ta chỉ xét MACLB1 vs MACLB mà thôi
--Điều kiện thuộc năm 2009
--Group by để đếm số trận của clb, so sánh nếu nó đá với tổng số clb trừ đi 1( bỏ nó ra ) thì => nó đá với tất cả các clb.
--Dùng DISTINCT để loại bỏ những trận trùng lập nếu nó lỡ đá lại một trận nữa.

SELECT c.MACLB, c.TENCLB
FROM TRANDAU t JOIN CAULACBO c ON t.MACLB1 = c.MACLB	
WHERE t.NAM = 2009
GROUP BY c.MACLB, c.TENCLB
HAVING COUNT(DISTINCT t.MACLB2) = (SELECT COUNT(*) - 1 FROM CAULACBO)

go
--49. Khi thêm cầu thủ mới, kiểm tra số áo của cầu thủ thuộc cùng một câu lạc bộ phải khác nhau.
go
CREATE TRIGGER trg_KiemTraSoAo		--tạo trigger trg_KiemTraSoAo
	ON CAUTHU						--trên bảng CAUTHU
	FOR INSERT, UPDATE
AS BEGIN
	DECLARE @SoAo int				--tạo biến @SoAo
	DECLARE @MaCLB nvarchar(5)		--tạo biến @MaCLB
	SELECT @SoAo = SO, @MaCLB = MACLB
	FROM inserted					--lấy giá trị của các biến tương ứng từ bảng inserted

	IF((SELECT COUNT(*)				--Thực hiện điều kiện if, đếm xem trong bảng CAUTHU cùng clb nếu tồn tại nhiều hơn một cầu thủ có cùng										MACLB và SO thì báo lỗi
	FROM CAUTHU ct JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
	WHERE ct.SO = @SoAo and clb.MACLB = @MaCLB)>1)
	BEGIN
		RAISERROR (N'Không được trùng số áo',15,1)	--nội dung lỗi
		ROLLBACK									--hủy thao tác
	END
END
--50. Khi thêm thông tin cầu thủ thì in ra câu thông báo bằng Tiếng Việt ‘Đã thêm cầu thủ mới’.
go
CREATE TRIGGER trg_ThemCauThu		--tạo trigger trg_ThemCauThu
	ON CAUTHU
	FOR INSERT 
AS BEGIN
	DECLARE @hoten nvarchar(100)	--tạo các biến tương ứng
	DECLARE @vitri nvarchar(20)
	DECLARE @ngaysinh datetime
	DECLARE @diachi nvarchar(200)
	DECLARE @maclb varchar(5)
	DECLARE @maqg varchar(5)
	SELECT @vitri = VITRI, @hoten = HOTEN, @ngaysinh = NGAYSINH, @diachi = DIACHI, @maclb = MACLB, @maqg= MAQG 
	FROM inserted					--lấy giá trị các biến tương ứng
	BEGIN 
		PRINT (N'Đã thêm cầu thủ mới')	--nội dung thông báo
	END 
END

--51. Khi thêm cầu thủ mới, kiểm tra số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ.
go
CREATE TRIGGER trg_CauThuNuocNgoai	--tạo trigger trg_ThemCauThu
	ON CAUTHU
	FOR INSERT,UPDATE
AS BEGIN
	DECLARE @maclb varchar(5)		--tạo biến @maclb
	SELECT @maclb = MACLB			--lấy giá trị biến @maclb từ MACLB
	FROM inserted
	if((SELECT COUNT(*)				--xét điều kiện if, đếm số lượng cầu thủ trong cùng 1 clb
	FROM CAUTHU ct JOIN CAULACBO clb ON ct.MACLB = clb.MACLB 
	WHERE clb.MACLB = @maclb and ct.MAQG != 'VN') > 8)	--với điều kiện @maclb mới thêm vào và quốc tịch nước ngoài mà số lượng lớn hơn 8
	BEGIN												
		raiserror(N'Không được quá 8 cầu thủ nước ngoài',15,1) --thì xuất nội dung lỗi
		rollback											  --hủy thao tác
	END
END
--52. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên quốc gia đã có.
go
CREATE TRIGGER trg_KiemTraTenQG		--tạo trigger trg_KiemTraTenQG
	ON QUOCGIA 
	FOR INSERT
AS BEGIN
	IF EXISTS (SELECT *				--lấy tất cả dữ liệu
				FROM inserted
				WHERE TENQG IN		--kiểm tra điều kiện TENQG này có nằm trong bảng QUOCGIA không?
	(
	SELECT TENQG
	FROM QUOCGIA
	))
	BEGIN
		RAISERROR (N'Tên quốc gia này đã tồn tại',15,1)	--nội dung thông báo khi trùng tên
		ROLLBACK										--hủy thao tác
	END
END

--53. Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với tên tỉnh thành đã có.
go
CREATE TRIGGER trg_KiemTraTenTinh	--tạo trigger trg_KiemTraTenTinh
	ON TINH
	FOR INSERT
AS BEGIN
	IF EXISTS						--kiểm tra điều kiện TENTINH này có nằm trong bảng TINH không?
	(SELECT * 
		FROM inserted 
		WHERE TENTINH IN
		(
			SELECT TENTINH
			FROM TINH
		)
	)
	BEGIN
		RAISERROR (N'Tên tỉnh này đã tồn tại',15,1)	--nội dung thông báo khi trùng tên
		ROLLBACK									--hủy thao tác
	END
END

--54. Không cho sửa kết quả của các trận đã diễn ra.
go
CREATE TRIGGER trg_KetQua			--tạo trigger trg_KetQua
	ON TRANDAU
	FOR UPDATE
AS BEGIN
	DECLARE @ketqua varchar(5)		--tạo biến @ketqua
	SELECT @ketqua = KETQUA			--lấy dữ liệu từ bảng deleted
	FROM deleted
	ROLLBACK TRANSACTION			--trả Transaction về trạng thái trước khi có thay đổi mà chưa được lưu tới data
	UPDATE TRANDAU SET KETQUA=@ketqua WHERE KETQUA=@ketqua	--thiết lập update dữ liệu, không cho thay đổi KETQUA khi có người chỉnh sửa
	RAISERROR (N'Không được thay đổi dữ liệu kết quả',15,1)	--nội dung thông báo
END
--UPDATE dữ liệu để kiểm tra
UPDATE TRANDAU
SET KETQUA = '0-0'
WHERE MATRAN = 8
