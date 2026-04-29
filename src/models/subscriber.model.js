const db = require("../config/dbConnect.js");

const Subscriber = {
  // Đăng ký nhận tin
  add: async (email) => {
    return await db.execute("INSERT INTO dang_ky (email) VALUES (?)", [email]);
  },

  // Admin: Lấy danh sách email
  getAll: async () => {
    const [rows] = await db.execute(
      "SELECT * FROM dang_ky ORDER BY thoi_gian_dang_ky DESC",
    );
    return rows;
  },
};

module.exports = Subscriber;
