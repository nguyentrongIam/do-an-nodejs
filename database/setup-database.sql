CREATE DATABASE IF NOT EXISTS news_db;
USE news_db;

CREATE TABLE TinTuc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    publish_date DATE,
    title VARCHAR(255) NOT NULL,
    summary TEXT, -- Tóm tắt ngắn
    content TEXT, -- Nội dung chi tiết
    image_url VARCHAR(255),
    img_position ENUM('left', 'right', 'none') DEFAULT 'none',
    author VARCHAR(100)
);
INSERT INTO TinTuc (category, publish_date, title, summary, image_url, img_position, author) VALUES 
('KINH DOANH', '2026-04-10', 'Giá vàng trong nước tăng vọt, vượt ngưỡng 90 triệu đồng', 'Ảnh hưởng từ thị trường thế giới khiến giá vàng miếng SJC sáng nay tăng mạnh...', '/images/gold.jpg', 'left', 'Hải Nam'),
('CÔNG NGHỆ', '2026-04-09', 'Việt Nam bắt đầu thử nghiệm mạng 6G tại các thành phố lớn', 'Bộ Thông tin và Truyền thông vừa cấp phép thử nghiệm hạ tầng mạng thế hệ mới...', '/images/tech6g.jpg', 'right', 'Minh Tú'),
('THỂ THAO', '2026-04-09', 'Tuyển Việt Nam chuẩn bị cho vòng loại World Cup', 'Huấn luyện viên trưởng đã triệu tập 26 cầu thủ ưu tú nhất cho đợt tập trung này...', '/images/football.jpg', 'left', 'Quốc Anh'),
('DU LỊCH', '2026-04-08', 'Phú Quốc vào top 10 hòn đảo tuyệt vời nhất châu Á', 'Tạp chí du lịch nổi tiếng vừa công bố danh sách những điểm đến hấp dẫn nhất năm...', '/images/phuquoc.jpg', 'none', 'Linh Đan'),
('GIÁO DỤC', '2026-04-08', 'Nhiều trường đại học công bố phương thức xét tuyển mới', 'Năm nay, các trường ưu tiên xét tuyển dựa trên chứng chỉ quốc tế và đánh giá tư duy...', '/images/university.jpg', 'right', 'Thanh Bình'),
('GIẢI TRÍ', '2026-04-07', 'Phim điện ảnh Việt cán mốc doanh thu 500 tỷ đồng', 'Tác phẩm mới nhất của đạo diễn tên tuổi vừa xác lập kỷ lục doanh thu phòng vé mới...', '/images/movie.jpg', 'left', 'Khánh An'),
('XE', '2026-04-07', 'VinFast ra mắt mẫu xe điện thông minh phân khúc giá rẻ', 'Mẫu xe mới hứa hẹn sẽ làm thay đổi thói quen di chuyển của người dân đô thị...', '/images/vinfast.jpg', 'right', 'Hoàng Hiệp'),
('ĐỜI SỐNG', '2026-04-06', 'TP.HCM đón đợt nắng nóng gay gắt nhất từ đầu năm', 'Nhiệt độ ngoài trời có lúc lên đến 40 độ C, người dân được khuyến cáo hạn chế ra đường...', '/images/weather.jpg', 'none', 'Mạnh Hùng'),
('SỨC KHỎE', '2026-04-06', 'Xu hướng ăn uống "xanh" đang bùng nổ tại các đô thị', 'Chế độ ăn nhiều rau củ và thực phẩm hữu cơ đang trở thành lối sống của giới trẻ...', '/images/health.jpg', 'left', 'Ngọc Diệp'),
('KHOA HỌC', '2026-04-05', 'Phát hiện loài thực vật mới tại vườn quốc gia Cúc Phương', 'Các nhà khoa học vừa công bố một loài lan hiếm lần đầu tiên được tìm thấy...', '/images/flower.jpg', 'right', 'Bảo Lâm');