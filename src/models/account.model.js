const db = require("../config/dbConnect.js");

const Account = {
  // Tìm tài khoản theo tên đăng nhập (Dùng cho Login)
  findByUsername: async (username) => {
    const [rows] = await db.execute(
      "SELECT * FROM tai_khoan WHERE ten_dang_nhap = ?",
      [username],
    );
    return rows[0];
  },

  // Tạo tài khoản mới
  create: async (email, username, password) => {
    return await db.execute(
      "INSERT INTO tai_khoan (email, ten_dang_nhap, mat_khau) VALUES (?, ?, ?)",
      [email, username, password],
    );
  },
};

module.exports = Account;
