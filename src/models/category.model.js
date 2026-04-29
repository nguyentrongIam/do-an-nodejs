const db = require("../config/dbConnect.js");

const Category = {
  // Lấy tất cả danh mục
  getAll: async () => {
    const [rows] = await db.execute(
      "SELECT id_danh_muc, ten_danh_muc FROM danh_muc",
    );
    return rows;
  },

  // Thêm danh mục mới
  create: async (name) => {
    return await db.execute("INSERT INTO danh_muc (ten_danh_muc) VALUES (?)", [
      name,
    ]);
  },

  // Xóa danh mục
  delete: async (id) => {
    return await db.execute("DELETE FROM danh_muc WHERE id_danh_muc = ?", [id]);
  },
};

module.exports = Category;
