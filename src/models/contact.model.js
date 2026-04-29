const db = require("../config/dbConnect.js");

const Contact = {
  // Lấy thông tin liên hệ duy nhất
  getOne: async () => {
    const [rows] = await db.execute("SELECT * FROM thong_tin_lien_lac LIMIT 1");
    return rows[0];
  },

  // Admin: Cập nhật thông tin
  update: async (data) => {
    const sql = `UPDATE thong_tin_lien_lac SET dia_chi=?, email=?, link_facebook=?, link_youtube=?, link_instagram=? WHERE id=1`;
    return await db.execute(sql, [
      data.dia_chi,
      data.email,
      data.fb,
      data.yt,
      data.ig,
    ]);
  },
};

module.exports = Contact;
