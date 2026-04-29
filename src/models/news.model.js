const db = require("../config/dbConnect.js");

const News = {
  //lấy tất cả tin
  getAll: async () => {
    const sql = `
            SELECT id,tieu_de,link_hinh_anh,ngay_dang,t.id_danh_muc,ten_danh_muc
            FROM tin_tuc t LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  XemNhieuNhat: async () => {
    const sql = `
            SELECT id,tieu_de,link_hinh_anh,ngay_dang,t.id_danh_muc,ten_danh_muc
            FROM tin_tuc t 
            LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
            WHERE t.trang_thai = 'đang hiện' 
            ORDER BY t.luot_xem DESC limit 5;`;
    const [rows] = await db.execute(sql);
    return rows;
  },
  MoiNhat: async () => {
    const sql = `
            SELECT 
            t.id, 
            t.luot_xem,
            t.tieu_de, 
            t.link_hinh_anh, 
            t.ngay_dang, 
            t.id_danh_muc, 
            d.ten_danh_muc,
            (SELECT COUNT(*) FROM binh_luan b WHERE b.id_tin_tuc = t.id) AS so_luong_binh_luan
            FROM tin_tuc t 
            LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
            WHERE t.trang_thai = 'đang hiện' 
            ORDER BY t.ngay_dang DESC 
            LIMIT 5;`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  // Lấy tin mới nhất (5 tin)
  getLatest: async () => {
    const sql = `
            SELECT id,tieu_de,tac_gia,tom_tat,link_hinh_anh,ngay_dang,luot_xem,t.id_danh_muc,ten_danh_muc
            FROM tin_tuc t 
            LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
            WHERE t.trang_thai = 'đang hiện'
            ORDER BY t.ngay_dang DESC limit 5`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  //lấy tin phổ biến(5 tin)
  getPopular: async () => {
    const sql = `
            SELECT id,tieu_de,noi_dung,tac_gia,tom_tat,link_hinh_anh,ngay_dang,luot_xem,t.luot_xem_tuan,t.id_danh_muc,ten_danh_muc
            FROM tin_tuc t 
            LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
            WHERE t.trang_thai = 'đang hiện' 
            ORDER BY t.luot_xem_tuan DESC limit 5;`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  //lấy tin thịnh hành(5 tin)
  getTrending: async () => {
    const sql = `
            SELECT t.id, t.tieu_de, t.luot_xem, t.luot_xem_tuan,t.id_danh_muc, d.ten_danh_muc, COUNT(b.id) AS so_luong_binh_luan,
            (t.luot_xem + COUNT(b.id)) AS diem_thinh_hanh -- Tạo điểm số tổng hợp để đánh giá độ thịnh hành
            FROM tin_tuc t 
            LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
            LEFT JOIN binh_luan b ON t.id = b.id_tin_tuc
            WHERE t.trang_thai = 'đang hiện'
            GROUP BY t.id, d.ten_danh_muc
            ORDER BY diem_thinh_hanh DESC limit 5;`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  //lấy tin nóng(5 tin)
  getBreaking: async () => {
    const sql = `
            SELECT t.*, d.ten_danh_muc
            FROM tin_tuc t JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc
            WHERE t.trang_thai = 'đang hiện' AND t.ngay_dang >= DATE_SUB(NOW(), INTERVAL 1 DAY) -- Chỉ lấy tin trong 24h qua
            ORDER BY t.luot_xem DESC limit 5;`;
    const [rows] = await db.execute(sql);
    return rows;
  },

  // Lấy tất cả tin theo danh mục
  getByCategory: async (categoryId) => {
    const sql =
      "SELECT * FROM tin_tuc WHERE id_danh_muc = ? AND trang_thai = 'đang hiện'";
    const [rows] = await db.execute(sql, [categoryId]);
    return rows;
  },

  // Xem chi tiết bài viết
  getById: async (id) => {
    const [rows] = await db.execute(
      "SELECT t.*, d.ten_danh_muc FROM tin_tuc t LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc WHERE id = ?",
      [id],
    );
    return rows[0];
  },

  // Tăng lượt xem
  incrementViews: async (id) => {
    return await db.execute(
      "UPDATE tin_tuc SET luot_xem = luot_xem + 1 WHERE id = ?",
      [id],
    );
  },

  countSearchNews: async (keyword) => {
    const searchPattern = `%${keyword}%`;
    const countSql = `
    SELECT COUNT(*) as total 
    FROM tin_tuc 
    WHERE trang_thai = 'đang hiện' AND (tieu_de LIKE ? OR tom_tat LIKE ?)
  `;
    const [result] = await db.execute(countSql, [searchPattern, searchPattern]);
    return result[0].total; // Trả về 1 con số cụ thể
  },

  // Hàm 2: Lấy danh sách bài viết theo trang
  searchNewsPagination: async (keyword, limit, offset) => {
    const searchPattern = `%${keyword}%`;
    const sql = `
    SELECT 
        t.id, t.tieu_de, t.tom_tat, t.link_hinh_anh, t.ngay_dang, t.tac_gia, t.luot_xem, 
        t.id_danh_muc, d.ten_danh_muc,
        (SELECT COUNT(*) FROM binh_luan b WHERE b.id_tin_tuc = t.id) AS so_luong_binh_luan
    FROM tin_tuc t 
    LEFT JOIN danh_muc d ON t.id_danh_muc = d.id_danh_muc 
    WHERE t.trang_thai = 'đang hiện' AND (t.tieu_de LIKE ? OR t.tom_tat LIKE ?)
    ORDER BY t.ngay_dang DESC 
    LIMIT ? OFFSET ?
  `;

    // Dùng pool.query thay vì execute để không bị lỗi parse tham số LIMIT, OFFSET
    const [rows] = await db.query(sql, [
      searchPattern,
      searchPattern,
      limit,
      offset,
    ]);
    return rows; // Trả về mảng chứa danh sách bài viết
  },

  // Admin: Thêm tin mới
  create: async (data) => {
    const sql = `INSERT INTO tin_tuc (tieu_de, noi_dung, tac_gia, tom_tat, link_hinh_anh, id_danh_muc, trang_thai) 
                     VALUES (?, ?, ?, ?, ?, ?, ?)`;
    return await db.execute(sql, [
      data.tieu_de,
      data.noi_dung,
      data.tac_gia,
      data.tom_tat,
      data.link_hinh_anh,
      data.id_danh_muc,
      data.trang_thai,
    ]);
  },
};

module.exports = News;
