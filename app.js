const express = require("express");
const app = express();
app.set("view engine", "ejs");
app.use(express.static("public"));

//trang chủ
app.get("/", (req, res) => {
  res.render("home", { title: "Trang chủ" });
  console.log(req.url);
});

//Danh mục bài viết
app.get("/category", (req, res) => {
  res.render("category", { title: "Danh mục bài viết" });
  console.log(req.url);
});
//Liên hệ
app.get("/contact", (req, res) => {
  res.render("contact", { title: "Liên hệ" });
  console.log(req.url);
});
//Login
app.get("/login", (req, res) => {
  res.render("login", { title: "Login" });
  console.log(req.url);
});
//Single
app.get("/single", (req, res) => {
  res.render("single", { title: "Single News" });
  console.log(req.url);
});
app.use((req, res) => {
  res.status(404).render("404", { title: "404 - Không tìm thấy trang" });
});
app.listen(3000, (req, res) => {
  console.log("Server đang chạy ở: http://127.0.0.1:3000");
});
