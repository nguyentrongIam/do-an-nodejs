-- 1. TẠO CƠ SỞ DỮ LIỆU
CREATE DATABASE IF NOT EXISTS news_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE news_db;

-- --------------------------------------------------------
-- 2. TẠO CÁC BẢNG (THEO THỨ TỰ ƯU TIÊN KHÓA NGOẠI)
-- --------------------------------------------------------

-- Bảng Thông tin liên lạc
CREATE TABLE IF NOT EXISTS thong_tin_lien_lac (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dia_chi VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    link_facebook VARCHAR(255),
    link_youtube VARCHAR(255),
    link_instagram VARCHAR(255),
    link_twitter VARCHAR(255),
    link_linkedin VARCHAR(255)
);

-- Bảng Tài khoản
CREATE TABLE IF NOT EXISTS tai_khoan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    ten_dang_nhap VARCHAR(50) UNIQUE NOT NULL,
    mat_khau VARCHAR(255) NOT NULL
);

-- Bảng Danh mục (Phải có trước bảng Tin tức)
CREATE TABLE IF NOT EXISTS danh_muc (
    id_danh_muc INT AUTO_INCREMENT PRIMARY KEY,
    ten_danh_muc VARCHAR(100) NOT NULL UNIQUE
);

-- Bảng Tin tức (Sử dụng ngay_dang mặc định là NOW)
CREATE TABLE IF NOT EXISTS tin_tuc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tieu_de VARCHAR(255) NOT NULL,
    id_danh_muc INT,
    noi_dung TEXT NOT NULL,
    tac_gia VARCHAR(100),
    tom_tat TEXT,
    link_hinh_anh VARCHAR(255),
    ngay_dang DATETIME DEFAULT CURRENT_TIMESTAMP, -- Tự động tạo thời gian
    luot_xem INT DEFAULT 0,
    luot_xem_tuan INT DEFAULT 0,
    trang_thai ENUM('ẩn', 'đang hiện') DEFAULT 'đang hiện',
    FOREIGN KEY (id_danh_muc) REFERENCES danh_muc(id_danh_muc) ON DELETE SET NULL
);

-- Bảng Bình luận (Quản lý Reply bằng tra_loi_binh_luan)
CREATE TABLE IF NOT EXISTS binh_luan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_nguoi_dung VARCHAR(100) NOT NULL,
    id_tin_tuc INT NOT NULL,
    tra_loi_binh_luan INT DEFAULT NULL,
    noi_dung_comment TEXT NOT NULL,
    ngay_comment DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tin_tuc) REFERENCES tin_tuc(id) ON DELETE CASCADE,
    FOREIGN KEY (tra_loi_binh_luan) REFERENCES binh_luan(id) ON DELETE CASCADE
);

-- Bảng Đăng ký nhận tin
CREATE TABLE IF NOT EXISTS dang_ky (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    thoi_gian_dang_ky DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- --------------------------------------------------------
-- 3. THÊM DỮ LIỆU THỰC TẾ (INSERT DATA)
-- --------------------------------------------------------

-- Dữ liệu liên lạc (Trụ sở báo Tuổi Trẻ làm mẫu)
INSERT INTO thong_tin_lien_lac (dia_chi, so_dien_thoai, email, link_facebook, link_youtube) 
VALUES ('60A Hoàng Văn Thụ, P.9, Q.Phú Nhuận, TP.HCM', '02839971010', 'toasoan@tuoitre.com.vn', 'https://facebook.com/baotuoitre', 'https://youtube.com/baotuoitre');

-- Dữ liệu danh mục
INSERT INTO danh_muc (ten_danh_muc) VALUES ('Thời sự'), ('Kinh doanh'), ('Công nghệ'), ('Thể thao'), ('Giải trí');

-- Dữ liệu tài khoản (Mật khẩu đã mã hóa MD5 cho '123456')
INSERT INTO tai_khoan (email, ten_dang_nhap, mat_khau) VALUES 
('admin@news.vn', 'admin_chinh', 'e10adc3949ba59abbe56e057f20f883e'),
('user_test@gmail.com', 'nguoidung1', 'e10adc3949ba59abbe56e057f20f883e');

-- Dữ liệu tin tức (Nội dung chi tiết từ các nguồn báo lớn)
INSERT INTO tin_tuc (tieu_de, id_danh_muc, noi_dung, tac_gia, tom_tat, link_hinh_anh, luot_xem, luot_xem_tuan) VALUES 

-- Tin 1: Đường sắt tốc độ cao
('Đề xuất xây đường sắt tốc độ cao 350km/h đi qua 20 tỉnh thành', 1, 
'Sáng nay, Bộ Giao thông Vận tải đã chính thức trình Chính phủ báo cáo nghiên cứu tiền khả thi dự án đường sắt tốc độ cao trên trục Bắc - Nam. Tuyến đường sắt này có chiều dài khoảng 1.541 km, bắt đầu từ ga Ngọc Hồi (Hà Nội) và kết thúc tại ga Thủ Thiêm (TP.HCM). Dự án được thiết kế với vận tốc 350 km/h, tập trung vận chuyển hành khách và có thể vận chuyển hàng hóa khi cần thiết...', 
'Gia Chính (VnExpress)', 
'Dự án đường sắt tốc độ cao Bắc - Nam với tổng vốn đầu tư hơn 67 tỷ USD dự kiến hoàn thành vào năm 2035.', 
'/client/images/duong-sat.webp', 15200, 4500),

-- Tin 2: Biến động giá vàng
('Giá vàng SJC biến động nghẹt thở, người dân xếp hàng chờ mua', 2, 
'Ghi nhận vào lúc 9h sáng, giá vàng miếng SJC tại các cửa hàng lớn ở TP.HCM và Hà Nội tiếp tục tăng nóng, có thời điểm chạm mốc 82,5 triệu đồng/lượng. Tại phố vàng Trần Nhân Tông (Hà Nội), hàng dài người dân đã xếp hàng từ sớm để chờ đến lượt giao dịch. Theo các chuyên gia kinh tế, giá vàng trong nước tăng vọt chủ yếu do ảnh hưởng từ đà tăng kỷ lục của giá vàng thế giới...', 
'Lê Thanh (Tuổi Trẻ)', 
'Giá vàng miếng SJC liên tục lập đỉnh mới trong bối cảnh giá vàng thế giới tăng cao kỷ lục.', 
'/client/images/mua-vang.webp', 28000, 9200),

-- Tin 3: Bóng đá - HLV Kim Sang-sik
('HLV Kim Sang-sik và buổi tập "truyền lửa" đầu tiên tại Việt Nam', 4, 
'Ngay sau lễ ra mắt hoành tráng, tân HLV trưởng Kim Sang-sik đã bắt tay ngay vào công việc tại sân tập của Trung tâm đào tạo bóng đá trẻ Việt Nam. Trong buổi tập đầu tiên, chiến lược gia người Hàn Quốc dành nhiều thời gian để quan sát và trực tiếp hướng dẫn các học trò thực hiện các bài tập di chuyển đội hình...', 
'Trọng Vũ (Dân Trí)', 
'Tân thuyền trưởng Kim Sang-sik mang đến bầu không khí tích cực trong buổi tập đầu tiên cùng các cầu thủ.', 
'/client/images/bong-da.webp', 42000, 15000),

-- Tin 4: Công nghệ - GPT-4o
('GPT-4o: Bước tiến mới của AI với khả năng giao tiếp như người thật', 3, 
'Trong sự kiện "Spring Update" vừa diễn ra, OpenAI đã gây sốc cho cộng đồng công nghệ khi trình làng GPT-4o - mô hình ngôn ngữ đa phương thức thế hệ mới. Chữ "o" trong tên gọi viết tắt của "Omni", thể hiện khả năng xử lý đồng thời cả văn bản, âm thanh và hình ảnh theo thời gian thực...', 
'Khương Nha (VnExpress)', 
'Mô hình GPT-4o mới có thể trò chuyện bằng giọng nói và xử lý hình ảnh với tốc độ gần như con người.', 
'/client/images/chat-gpt.webp', 35000, 21000)

-- Tin 5: Kinh doanh (Nguồn: Tuổi Trẻ)
('Xuất khẩu sầu riêng sang Trung Quốc có thể đạt mốc 3 tỷ USD', 2, 
'Theo Hiệp hội Rau quả Việt Nam, xuất khẩu sầu riêng đang chứng kiến sự tăng trưởng phi mã nhờ các nghị định thư ký kết với Trung Quốc. Hiện nay, sầu riêng Việt Nam có lợi thế về mùa vụ quanh năm và thời gian vận chuyển ngắn hơn so với Thái Lan. Nhiều vùng trồng tại Đắk Lắk, Tiền Giang đang mở rộng diện tích và nâng cao tiêu chuẩn VietGAP để đáp ứng yêu cầu khắt khe từ thị trường tỉ dân. Nếu duy trì đà này, ngành hàng sầu riêng sẽ sớm trở thành "tỉ đô" chủ lực của nông nghiệp Việt Nam.', 
'Công Trung (Tuổi Trẻ)', 
'Sầu riêng Việt Nam đang chiếm lĩnh thị trường Trung Quốc với kỳ vọng kim ngạch kỷ lục 3 tỷ USD trong năm nay.', 
'/client/images/sau-rieng.webp', 12500, 3200),

-- Tin 6: Công nghệ (Nguồn: VnExpress)
('Việt Nam sắp có trung tâm dữ liệu AI quy mô hàng đầu khu vực', 3, 
'Tập đoàn công nghệ trong nước vừa công bố kế hoạch xây dựng trung tâm dữ liệu (Data Center) thế hệ mới tại Khu công nghệ cao TP.HCM. Dự án tập trung vào hạ tầng tính toán hiệu năng cao để phục vụ huấn luyện các mô hình trí tuệ nhân tạo lớn. Trung tâm này dự kiến sử dụng chip đồ họa chuyên dụng mới nhất của NVIDIA, hỗ trợ các doanh nghiệp khởi nghiệp và tổ chức nghiên cứu trong việc phát triển giải pháp AI "Make in Vietnam". Đây là bước đi chiến lược để đưa Việt Nam trở thành một Digital Hub của Đông Nam Á.', 
'Lưu Quý (VnExpress)', 
'Dự án Data Center mới sẽ cung cấp sức mạnh tính toán khổng lồ cho các dự án AI tại Việt Nam.', 
'/client/images/trung-tam-du-lieu.webp', 8900, 2100),

-- Tin 7: Thể thao (Nguồn: Thanh Niên)
('Quang Hải tỏa sáng giúp CLB Công an Hà Nội áp sát ngôi đầu V-League', 4, 
'Trong trận tâm điểm vòng 18 V-League tối qua, tiền vệ Nguyễn Quang Hải đã có một siêu phẩm đá phạt từ khoảng cách 25m, góp công lớn vào chiến thắng 2-0 trước đối thủ cạnh tranh trực tiếp. Lối chơi sáng tạo và khả năng điều tiết trận đấu của Hải "con" đã giúp đội nhà kiểm soát hoàn toàn thế trận. Với 3 điểm quý giá này, CLB Công an Hà Nội chỉ còn kém đội đầu bảng đúng 1 điểm, khiến cuộc đua vô địch năm nay trở nên kịch tính hơn bao giờ hết.', 
'Hữu Bình (Thanh Niên)', 
'Siêu phẩm của Quang Hải giúp cuộc đua vô địch V-League trở nên nóng hơn bao giờ hết.', 
'/client/images/quang-hai.webp', 21000, 5600),

-- Tin 8: Giải trí (Nguồn: VnExpress)
('Phim điện ảnh Việt cán mốc doanh thu 400 tỷ đồng chỉ sau 2 tuần', 5, 
'Tác phẩm điện ảnh mới nhất khai thác đề tài gia đình đã tạo nên cơn sốt phòng vé trên toàn quốc. Theo số liệu từ Box Office Vietnam, bộ phim liên tục phá các kỷ lục về lượng vé đặt trước và số suất chiếu trong ngày. Thành công này đến từ kịch bản gần gũi, chạm đến cảm xúc người xem cùng diễn xuất xuất sắc của dàn diễn viên thực lực. Các chuyên gia nhận định, đây là tín hiệu cực kỳ lạc quan cho thị trường phim nội địa trong bối cảnh các bom tấn Hollywood đang có dấu hiệu hạ nhiệt.', 
'Mai Nhật (VnExpress)', 
'Điện ảnh Việt tiếp tục thống trị phòng vé với kỷ lục doanh thu mới lên tới 400 tỷ đồng.', 
'/client/images/phim-viet.webp', 45000, 12000),

-- Tin 9: Thời sự (Nguồn: Tuổi Trẻ)
('TP.HCM khởi công xây dựng cầu nối quận 7 và huyện Nhà Bè', 1, 
'Sáng nay, UBND TP.HCM đã chính thức phát lệnh khởi công dự án cầu bắc qua kênh Tẻ, kết nối trực tiếp khu đô thị mới quận 7 với khu công nghiệp Hiệp Phước. Dự án có tổng chiều dài hơn 2km, quy mô 6 làn xe với tổng vốn đầu tư gần 3.000 tỷ đồng. Khi hoàn thành vào năm 2026, cây cầu này được kỳ vọng sẽ giải quyết triệt để tình trạng ùn tắc tại cửa ngõ phía Nam thành phố, đồng thời thúc đẩy giao thương kinh tế cho toàn vùng kinh tế trọng điểm.', 
'Thu Dung (Tuổi Trẻ)', 
'Dự án giao thông trọng điểm phía Nam TP.HCM chính thức khởi công với tổng vốn 3.000 tỷ đồng.', 
'/client/images/xay-cau.webp', 14300, 3100);

-- Dữ liệu bình luận (Có phân cấp Trả lời)
INSERT INTO binh_luan (email_nguoi_dung, id_tin_tuc, tra_loi_binh_luan, noi_dung_comment) VALUES 
('thanhnam@gmail.com', 1, NULL, 'Mong dự án sớm triển khai, đi tàu 350km/h chắc sướng lắm.'),
('kisu_giaothong@yahoo.com', 1, 1, 'Kỹ thuật vận hành tuyến này rất phức tạp, nhưng là xu hướng tất yếu của thế giới.'),
('lanhuong_89@gmail.com', 2, NULL, 'Giá vàng cao quá, muốn mua một ít tích lũy mà cũng run tay.'),
('dautu_thongthai@gmail.com', 2, 3, 'Tầm này vào vàng hơi mạo hiểm bạn ạ, nên đợi nhịp điều chỉnh.');

-- Dữ liệu đăng ký
INSERT INTO dang_ky (email) VALUES ('docgia_trungthanh@gmail.com'), ('lienhe_marketing@outlook.com');