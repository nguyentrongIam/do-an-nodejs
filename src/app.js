const express = require("express");
const app = express();
const configViewEngine = require("./config/viewEngine");

// Khai báo các route
const indexRouter = require("./routes/client/home.js");

//config view engine
configViewEngine(app);

//tạo đường dẫn dùng để include body cho layout
app.use((req, res, next) => {
  res.locals.url = req.path; // Tự động lấy đường dẫn hiện tại gán vào biến url
  next();
});

app.use("/", indexRouter);

//404
app.use((req, res) => {
  res.status(404).render("404", { title: "404 - Không tìm thấy trang" });
});

// Khởi động server
app.listen(3000, () => {
  console.log("Server đang chạy ở: http://127.0.0.1:3000");
});
