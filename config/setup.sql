-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS news_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE news_db;

-- --------------------------------------------------------
-- 1. Bảng Thông tin liên lạc
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS thong_tin_lien_lac (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dia_chi VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    link_facebook VARCHAR(255),
    link_youtube VARCHAR(255),
    link_instagram VARCHAR(255),
    link_twitter VARCHAR(255),
    link_linkedin VARCHAR(255)
);

-- Thêm 1 dòng dữ liệu liên lạc
INSERT INTO thong_tin_lien_lac (dia_chi, email, link_facebook, link_youtube, link_instagram, link_twitter, link_linkedin) 
VALUES (
    '123 Đường Lê Lợi, Quận 1, TP. Hồ Chí Minh', 
    'toasoan@news.vn', 
    'https://facebook.com/vnnews_official', 
    'https://youtube.com/c/vnnews_tv', 
    'https://instagram.com/vnnews_daily', 
    'https://twitter.com/vnnews_update', 
    'https://linkedin.com/company/vnnews'
);

-- --------------------------------------------------------
-- 2. Bảng Tài khoản
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS tai_khoan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    ten_dang_nhap VARCHAR(50) UNIQUE NOT NULL,
    mat_khau VARCHAR(255) NOT NULL
);

-- Thêm 5 tài khoản mẫu
INSERT INTO tai_khoan (email, ten_dang_nhap, mat_khau) VALUES 
('nguyenvana@gmail.com', 'nva_user', 'e10adc3949ba59abbe56e057f20f883e'), -- mk: 123456
('tranthingoc@yahoo.com', 'ngoctran99', 'e10adc3949ba59abbe56e057f20f883e'),
('lethanhbinh@outlook.com', 'binh_le', 'e10adc3949ba59abbe56e057f20f883e'),
('phamminhhoang@gmail.com', 'hoangpm', 'e10adc3949ba59abbe56e057f20f883e'),
('vothuha@gmail.com', 'havo2024', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------
-- 3. Bảng Tin tức
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS tin_tuc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tieu_de VARCHAR(255) NOT NULL,
    chu_de VARCHAR(100) NOT NULL,
    noi_dung TEXT NOT NULL,
    tac_gia VARCHAR(100),
    tom_tat TEXT,
    link_hinh_anh VARCHAR(255),
    ngay_dang DATETIME DEFAULT CURRENT_TIMESTAMP,
    luot_xem INT DEFAULT 0,
    trang_thai ENUM('ẩn', 'đang hiện') DEFAULT 'đang hiện'
);

-- Thêm 10 tin tức (Mô phỏng báo Việt Nam)
INSERT INTO tin_tuc (tieu_de, chu_de, noi_dung, tac_gia, tom_tat, link_hinh_anh, ngay_dang, luot_xem, trang_thai) VALUES 
-- Tin 1
('Ngân hàng Nhà nước giảm lãi suất điều hành lần thứ 4', 'Kinh tế', 'Sáng nay, Ngân hàng Nhà nước quyết định giảm các mức lãi suất điều hành từ 0,5% đến 1%/năm. Đây là lần thứ 4 liên tiếp trong năm cơ quan này có động thái nới lỏng chính sách tiền tệ nhằm hỗ trợ doanh nghiệp phục hồi sản xuất kinh doanh...', 'Hoàng Anh', 'Quyết định giảm lãi suất điều hành tiếp tục được Ngân hàng Nhà nước đưa ra nhằm hỗ trợ tăng trưởng kinh tế.', 'https://picsum.photos/seed/news1/800/400', '2024-05-10 08:30:00', 12500, 'đang hiện'),
-- Tin 2
('Apple chuẩn bị ra mắt tính năng AI tạo sinh trên iOS 18', 'Công nghệ', 'Theo các rò rỉ mới nhất, Apple sẽ tích hợp hàng loạt tính năng AI tạo sinh vào iOS 18, bao gồm khả năng viết lại email, tạo hình ảnh từ văn bản và cải tiến Siri thông minh hơn. Lễ ra mắt sẽ diễn ra tại WWDC vào tháng tới...', 'Minh Tuấn', 'iOS 18 được kỳ vọng là bản cập nhật phần mềm lớn nhất trong lịch sử Apple với sự xuất hiện của AI.', 'https://picsum.photos/seed/news2/800/400', '2024-05-11 09:15:00', 8900, 'đang hiện'),
-- Tin 3
('Đội tuyển Việt Nam chốt danh sách thi đấu vòng loại World Cup', 'Thể thao', 'Huấn luyện viên trưởng đã chính thức công bố danh sách 23 cầu thủ sẽ tham dự hai trận đấu quan trọng tại vòng loại thứ 2 World Cup 2026. Đáng chú ý là sự trở lại của một số trụ cột hàng phòng ngự sau chấn thương...', 'Quốc Thắng', 'Danh sách tập trung ĐTQG Việt Nam có sự góp mặt của nhiều cựu binh dày dạn kinh nghiệm.', 'https://picsum.photos/seed/news3/800/400', '2024-05-12 10:00:00', 45000, 'đang hiện'),
-- Tin 4
('Phát hiện mới về phương pháp điều trị ung thư bằng tế bào T', 'Y tế', 'Các nhà khoa học tại Viện Nghiên cứu Y khoa vừa công bố một thử nghiệm lâm sàng thành công, sử dụng liệu pháp tế bào T đã chỉnh sửa gen để nhắm mục tiêu và tiêu diệt các khối u rắn. Tỷ lệ đáp ứng thuốc ở bệnh nhân lên tới 75%...', 'Thu Hương', 'Bước đột phá y học mở ra hy vọng mới cho những bệnh nhân mắc ung thư giai đoạn cuối.', 'https://picsum.photos/seed/news4/800/400', '2024-05-13 14:20:00', 6700, 'đang hiện'),
-- Tin 5
('Khởi công dự án Vành đai 4 vùng Thủ đô', 'Xã hội', 'Sáng nay, dự án đầu tư xây dựng tuyến đường Vành đai 4 - Vùng Thủ đô Hà Nội đã chính thức được khởi công. Tuyến đường có chiều dài 112,8 km, đi qua Hà Nội, Hưng Yên và Bắc Ninh, với tổng mức đầu tư hơn 85.000 tỷ đồng...', 'Lê Đạt', 'Dự án giao thông trọng điểm quốc gia Vành đai 4 chính thức bước vào giai đoạn thi công.', 'https://picsum.photos/seed/news5/800/400', '2024-05-14 07:45:00', 11200, 'đang hiện'),
-- Tin 6
('Bộ Giáo dục công bố phương án thi tốt nghiệp THPT năm 2025', 'Giáo dục', 'Theo phương án mới nhất, từ năm 2025, thí sinh sẽ thi 4 môn, gồm 2 môn bắt buộc (Toán, Ngữ văn) và 2 môn tự chọn trong số các môn còn lại học ở lớp 12. Điều này giúp giảm áp lực thi cử và định hướng nghề nghiệp sớm cho học sinh...', 'Thanh Bình', 'Phương án thi mới 2+2 chính thức áp dụng từ lứa học sinh sinh năm 2007.', 'https://picsum.photos/seed/news6/800/400', '2024-05-15 16:30:00', 53000, 'đang hiện'),
-- Tin 7
('Du lịch Việt Nam đón 6 triệu lượt khách quốc tế trong 5 tháng đầu năm', 'Du lịch', 'Tổng cục Du lịch cho biết, lượng khách quốc tế đến Việt Nam đang phục hồi mạnh mẽ. Đóng góp lớn nhất vẫn là thị trường Hàn Quốc, Trung Quốc và các nước châu Âu. Ngành du lịch dự kiến vượt mục tiêu 8 triệu lượt khách của cả năm...', 'Hải Yến', 'Sự bùng nổ của khách quốc tế đánh dấu sự phục hồi hoàn toàn của ngành du lịch hậu đại dịch.', 'https://picsum.photos/seed/news7/800/400', '2024-05-16 11:10:00', 4200, 'đang hiện'),
-- Tin 8
('Phim điện ảnh Việt gây tiếng vang tại Lễ hội phim Cannes', 'Giải trí', 'Đạo diễn Trần Anh Hùng cùng đoàn làm phim đã nhận được tràng pháo tay dài 8 phút tại buổi công chiếu ra mắt tại Cannes. Bộ phim mang đậm nét văn hóa Việt Nam đương đại kết hợp cùng nghệ thuật kể chuyện độc đáo...', 'Bảo Trâm', 'Một tác phẩm điện ảnh nước nhà xuất sắc lọt vào danh sách tranh giải tại liên hoan phim danh giá.', 'https://picsum.photos/seed/news8/800/400', '2024-05-17 20:00:00', 21000, 'đang hiện'),
-- Tin 9
('Đề xuất đánh thuế nhà đất bỏ hoang', 'Bất động sản', 'Hiệp hội Bất động sản vừa trình văn bản kiến nghị Chính phủ xem xét đánh thuế tài sản đối với nhà đất bỏ hoang, không đưa vào sử dụng trong thời gian dài nhằm ngăn chặn tình trạng đầu cơ và lãng phí nguồn lực xã hội...', 'Đình Nghĩa', 'Giải pháp mạnh tay được đề xuất để làm nguội thị trường bất động sản đang có dấu hiệu sốt ảo.', 'https://picsum.photos/seed/news9/800/400', '2024-05-18 09:50:00', 18500, 'ẩn'),
-- Tin 10
('Kính viễn vọng James Webb phát hiện thiên hà xa xôi nhất', 'Khoa học', 'NASA vừa công bố hình ảnh mới nhất từ kính viễn vọng không gian James Webb, cho thấy một thiên hà hình thành chỉ khoảng 300 triệu năm sau vụ nổ Big Bang. Đây là hệ sao cổ xưa nhất mà con người từng quan sát được...', 'Tuấn Kiệt', 'Khám phá mới định hình lại hiểu biết của chúng ta về giai đoạn sơ khai của vũ trụ.', 'https://picsum.photos/seed/news10/800/400', '2024-05-19 15:25:00', 31000, 'đang hiện');

-- --------------------------------------------------------
-- 4. Bảng Bình luận
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS binh_luan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_nguoi_dung VARCHAR(100) NOT NULL,
    id_tin_tuc INT NOT NULL,
    noi_dung_comment TEXT NOT NULL,
    ngay_comment DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tin_tuc) REFERENCES tin_tuc(id) ON DELETE CASCADE
);

-- Thêm 40 bình luận (4 bình luận cho mỗi tin tức)
INSERT INTO binh_luan (id_tin_tuc, email_nguoi_dung, noi_dung_comment, ngay_comment) VALUES 
-- Tin 1
(1, 'nguyenvana@gmail.com', 'Hy vọng lãi suất cho vay cũng giảm tương ứng.', '2024-05-10 09:00:00'),
(1, 'tranthingoc@yahoo.com', 'Doanh nghiệp vẫn khó tiếp cận vốn lắm.', '2024-05-10 09:30:00'),
(1, 'docgia1@gmail.com', 'Tin vui cho chứng khoán rồi!', '2024-05-10 10:15:00'),
(1, 'phamminhhoang@gmail.com', 'Lãi suất tiết kiệm giờ thấp quá.', '2024-05-10 11:00:00'),
-- Tin 2
(2, 'lethanhbinh@outlook.com', 'Mong Siri thông minh hơn chứ hiện tại chán quá.', '2024-05-11 10:00:00'),
(2, 'vothuha@gmail.com', 'Không biết iPhone cũ có được cập nhật tính năng này không?', '2024-05-11 10:20:00'),
(2, 'ifancuong@gmail.com', 'Apple luôn đi sau nhưng làm tốt nhất.', '2024-05-11 11:45:00'),
(2, 'nguyenvana@gmail.com', 'Tuyệt vời, hóng iOS 18!', '2024-05-11 12:30:00'),
-- Tin 3
(3, 'phamminhhoang@gmail.com', 'Đội hình này hàng công hơi mỏng nhỉ.', '2024-05-12 10:15:00'),
(3, 'bongda_fan@yahoo.com', 'Việt Nam vô địch! Chúc đội tuyển thành công.', '2024-05-12 10:45:00'),
(3, 'tranthingoc@yahoo.com', 'Cần trao cơ hội cho nhiều cầu thủ trẻ hơn.', '2024-05-12 11:20:00'),
(3, 'vothuha@gmail.com', 'Lịch thi đấu cụ thể là ngày nào vậy anh em?', '2024-05-12 13:00:00'),
-- Tin 4
(4, 'bacsy_tam@gmail.com', 'Nghiên cứu rất triển vọng, hy vọng sớm phổ biến.', '2024-05-13 15:00:00'),
(4, 'nguyenvana@gmail.com', 'Y học ngày càng phát triển, tin vui cho nhân loại.', '2024-05-13 16:30:00'),
(4, 'lethanhbinh@outlook.com', 'Chi phí điều trị chắc chắn sẽ rất đắt đỏ.', '2024-05-13 17:10:00'),
(4, 'ngoclan_198x@gmail.com', 'Tuyệt vời quá, cảm ơn các nhà khoa học.', '2024-05-13 19:00:00'),
-- Tin 5
(5, 'nguyenvana@gmail.com', 'Mong dự án thi công đúng tiến độ.', '2024-05-14 08:30:00'),
(5, 'hanoi_pho@gmail.com', 'Giải quyết được kẹt xe là tốt lắm rồi.', '2024-05-14 09:15:00'),
(5, 'phamminhhoang@gmail.com', 'Hạ tầng giao thông phát triển thì kinh tế mới lên được.', '2024-05-14 10:00:00'),
(5, 'vothuha@gmail.com', 'Đoạn qua nhà mình sắp bị giải tỏa rồi.', '2024-05-14 11:45:00'),
-- Tin 6
(6, 'tranthingoc@yahoo.com', 'Cháu nhà mình thi lứa này, cũng đỡ áp lực hơn.', '2024-05-15 17:00:00'),
(6, 'giaovien_toan@gmail.com', 'Thi 4 môn là hợp lý trong giai đoạn hiện nay.', '2024-05-15 18:30:00'),
(6, 'lethanhbinh@outlook.com', 'Quan trọng là đề thi phân loại được học sinh.', '2024-05-15 19:20:00'),
(6, 'nguyenvana@gmail.com', 'Các trường ĐH chắc phải đổi phương án tuyển sinh theo.', '2024-05-15 20:10:00'),
-- Tin 7
(7, 'tourguide_vn@gmail.com', 'Đợt này khách Hàn Quốc sang đông thật.', '2024-05-16 11:45:00'),
(7, 'vothuha@gmail.com', 'Du lịch phát triển, bà con làm dịch vụ cũng mừng.', '2024-05-16 12:30:00'),
(7, 'phamminhhoang@gmail.com', 'Cần quản lý chặt chẽ nạn chặt chém thì khách mới quay lại.', '2024-05-16 14:00:00'),
(7, 'lethanhbinh@outlook.com', 'Cảnh quan Việt Nam mình đẹp không thua kém nước nào.', '2024-05-16 15:15:00'),
-- Tin 8
(8, 'cinephile99@gmail.com', 'Tự hào điện ảnh nước nhà!', '2024-05-17 21:00:00'),
(8, 'tranthingoc@yahoo.com', 'Bao giờ phim này chiếu rạp ở Việt Nam vậy?', '2024-05-17 22:30:00'),
(8, 'nguyenvana@gmail.com', 'Trần Anh Hùng luôn làm ra những kiệt tác.', '2024-05-18 08:15:00'),
(8, 'vothuha@gmail.com', 'Phim nghệ thuật thường hơi khó xem với số đông.', '2024-05-18 09:00:00'),
-- Tin 9
(9, 'dautubatdongsan@gmail.com', 'Đánh thuế là đúng, tránh tình trạng đầu cơ lướt sóng.', '2024-05-18 10:15:00'),
(9, 'phamminhhoang@gmail.com', 'Người có nhu cầu thực mãi không mua được nhà.', '2024-05-18 11:30:00'),
(9, 'lethanhbinh@outlook.com', 'Cần có lộ trình áp dụng rõ ràng.', '2024-05-18 13:00:00'),
(9, 'nguyenvana@gmail.com', 'Khu tôi ở biệt thự bỏ hoang nhiều vô kể.', '2024-05-18 14:45:00'),
-- Tin 10
(10, 'yeukhoahoc@yahoo.com', 'Vũ trụ bao la thực sự, con người quá nhỏ bé.', '2024-05-19 16:00:00'),
(10, 'tranthingoc@yahoo.com', 'JWST đã đem lại những hình ảnh ngoài sức tưởng tượng.', '2024-05-19 17:20:00'),
(10, 'vothuha@gmail.com', 'Chờ đợi những phát hiện về sự sống ngoài Trái Đất.', '2024-05-19 19:10:00'),
(10, 'phamminhhoang@gmail.com', 'Bức ảnh đẹp như một tác phẩm nghệ thuật.', '2024-05-19 20:30:00');

-- --------------------------------------------------------
-- 5. Bảng Đăng ký (Nhận bản tin/Newsletter)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS dang_ky (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    thoi_gian_dang_ky DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Thêm 5 email đăng ký
INSERT INTO dang_ky (email, thoi_gian_dang_ky) VALUES 
('nguyenvana@gmail.com', '2024-05-01 08:00:00'),
('doanhnghiep_x@yahoo.com.vn', '2024-05-05 14:30:00'),
('sinhvien_bkhn@gmail.com', '2024-05-10 09:15:00'),
('lethanhbinh@outlook.com', '2024-05-15 20:00:00'),
('marketing_team@company.com', '2024-05-18 11:11:00');



-- --------------------------------------------------------
-- 1. Tạo bảng Danh mục
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS danh_muc (
    id_danh_muc INT AUTO_INCREMENT PRIMARY KEY,
    ten_danh_muc VARCHAR(100) NOT NULL UNIQUE
);

-- --------------------------------------------------------
-- 2. Thêm dữ liệu vào bảng danh_muc dựa trên cột chu_de của bảng tin_tuc
-- --------------------------------------------------------
-- Câu lệnh này sẽ lấy các giá trị duy nhất từ cột 'chu_de' của bảng 'tin_tuc' để chèn vào bảng 'danh_muc'
INSERT INTO danh_muc (ten_danh_muc)
SELECT DISTINCT chu_de FROM tin_tuc;

-- --------------------------------------------------------
-- 3. Chuẩn hóa bảng tin_tuc (Gắn kết id_danh_muc thay vì dùng text)
-- --------------------------------------------------------

-- Bước A: Thêm cột id_danh_muc vào bảng tin_tuc
ALTER TABLE tin_tuc ADD COLUMN id_danh_muc INT;
SET SQL_SAFE_UPDATES = 0;
-- Bước B: Cập nhật giá trị id_danh_muc dựa trên tên chủ đề tương ứng
UPDATE tin_tuc t
JOIN danh_muc d ON t.chu_de = d.ten_danh_muc
SET t.id_danh_muc = d.id_danh_muc;

-- Bước C: Thiết lập khóa ngoại (Foreign Key) để đảm bảo toàn vẹn dữ liệu
ALTER TABLE tin_tuc 
ADD CONSTRAINT fk_tin_tuc_danh_muc 
FOREIGN KEY (id_danh_muc) REFERENCES danh_muc(id_danh_muc) 
ON DELETE SET NULL;

-- Bước D Xóa cột chu_de (dạng text cũ) để hoàn tất chuẩn hóa
ALTER TABLE tin_tuc DROP COLUMN chu_de;
SET SQL_SAFE_UPDATES = 1;



-- Xem tin tức kèm theo tên danh mục thông qua phép Join
SELECT t.tieu_de, d.ten_danh_muc, t.tac_gia, t.ngay_dang
FROM tin_tuc t
LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc;