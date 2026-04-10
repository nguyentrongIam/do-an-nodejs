const express = require("express");
const router = express.Router();

// Trang chủ
router.get("/", (req, res) => {
  res.render("home", { title: "Trang chủ" });
});

// Danh mục bài viết
router.get("/danh-muc-bai-viet", (req, res) => {
  res.render("danh-muc-bai-viet", { title: "Danh mục bài viết" });
});

// Bạn có thể gom các trang tĩnh khác vào đây...

module.exports = router;
