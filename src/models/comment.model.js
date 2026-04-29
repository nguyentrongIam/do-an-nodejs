const db = require("../config/dbConnect.js");

const Comment = {
  // Lấy bình luận của một bài viết
  getByNewsId: async (newsId) => {
    const sql =
      "SELECT * FROM binh_luan WHERE id_tin_tuc = ? ORDER BY ngay_comment DESC";
    const [rows] = await db.execute(sql, [newsId]);
    return rows;
  },

  // Thêm bình luận
  create: async (newsId, email, content) => {
    const sql =
      "INSERT INTO binh_luan (id_tin_tuc, email_nguoi_dung, noi_dung_comment) VALUES (?, ?, ?)";
    return await db.execute(sql, [newsId, email, content]);
  },
};

module.exports = Comment;
