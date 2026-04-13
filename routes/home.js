const express = require("express");
const router = express.Router();
const pool = require("../config/database");
// Trang chủ
router.get("/", async (req, res) => {
  try {
    // Sử dụng pool.query để lấy dữ liệu
    const [categories] = await pool.query(
      "SELECT id_danh_muc, ten_danh_muc FROM danh_muc",
    );

    // Render ra file home.ejs trong thư mục views/user/
    res.render("user/home", {
      title: "Trang chủ",
      url: req.path,
      categories: categories,
    });
  } catch (error) {
    console.error("Lỗi truy vấn:", error);
    res.status(500).send("Đã xảy ra lỗi máy chủ!");
  }
  console.log(req.originalUrl);
});

// Danh mục bài viết
router.get("/category", async (req, res) => {
  try {
    // Sử dụng pool.query để lấy dữ liệu
    const [categories] = await pool.query(
      "SELECT id_danh_muc, ten_danh_muc FROM danh_muc",
    );

    // Render ra file home.ejs trong thư mục views/user/
    res.render("user/category", {
      title: "Trang chủ",
      url: req.path,
      categories: categories,
    });
  } catch (error) {
    console.error("Lỗi truy vấn:", error);
    res.status(500).send("Đã xảy ra lỗi máy chủ!");
  }
  console.log(req.originalUrl);
});

// Liên hệ
router.get("/contact", (req, res) => {
  res.render("user/contact", { title: "Liên hệ", url: req.path });
  console.log(req.originalUrl);
});

// Login
router.get("/login", (req, res) => {
  res.render("login", { title: "Login" });
  console.log(req.originalUrl);
});

// Single News
router.get("/single", (req, res) => {
  res.render("user/single", { title: "Single News", url: req.path });
  console.log(req.originalUrl);
});

// Xuất router để sử dụng ở file khác
module.exports = router;
