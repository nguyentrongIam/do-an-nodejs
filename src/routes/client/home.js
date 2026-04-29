const express = require("express");
const router = express.Router();
const pool = require("../../config/dbConnect.js");
const homeController = require("../../controllers/client/home.controller.js");
// Trang chủ
router.get(
  "/",
  (req, res, next) => {
    console.log(req.originalUrl);
    req.url = "/";
    next();
  },
  homeController.getPage,
);

//Trang danh mục bài viết
router.get(
  "/category/:id",
  (req, res, next) => {
    req.categoryId = req.params.id;
    console.log(req.originalUrl);
    req.url = "/category";
    next();
  },
  homeController.getPage,
);

router.get(
  "/category",
  (req, res, next) => {
    req.url = "category";
    next();
  },
  homeController.getPage,
);

//Trang liên hệ
router.get(
  "/contact",
  (req, res, next) => {
    console.log(req.originalUrl);
    req.url = "/contact";
    next();
  },
  homeController.getPage,
);

// Single News
router.get(
  "/single/:id",
  (req, res, next) => {
    req.newsId = req.params.id;
    console.log(req.originalUrl);
    req.url = "/single";
    next();
  },
  homeController.getPage,
);

//popup liên hệ
router.post("/submit-contact", homeController.submitContact);

//đăng ký
router.post("/subscribe", homeController.subscribe);

//tìm kiếm
router.get("/search", homeController.searchNews);

// Xuất router để sử dụng ở file khác
module.exports = router;
