const mysql = require("mysql2");
require("dotenv").config();

// Tạo một pool kết nối (tốt hơn cho ứng dụng web)
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

// Chuyển sang dạng Promise để có thể dùng async/await
const promisePool = pool.promise();

module.exports = promisePool;
