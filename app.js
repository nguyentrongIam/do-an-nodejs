const express = require("express");
const app = express();
app.set("view engine", "ejs");
app.use(express.static("public"));

//trang chủ
app.get("/", (req, res) => {
  res.render("trang-chu", { title: "Trang chủ" });
});

//Danh mục bài viết
app.get("/danh-muc-bai-viet", (req, res) => {
  res.render("danh-muc-bai-viet", { title: "Danh mục bài viết" });
});
//Liên hệ
app.get("/lien-he", (req, res) => {
  res.render("lien-he", { title: "Liên hệ" });
});
//Login
app.get("/login", (req, res) => {
  res.render("login", { title: "Login" });
});
app.use((req, res) => {
  res.status(404).render("404", { title: "404 - Không tìm thấy trang" });
});
app.listen(3000, (req, res) => {
  console.log("Server đang chạy ở: http://127.0.0.1:3000");
});
