const Category = require("../../models/category.model"); // Gọi thẳng Model
const Contact = require("../../models/contact.model");
const News = require("../../models/news.model");

let getPage = async (req, res) => {
  try {
    // Lấy dữ liệu từ Model
    const moiNhat = await News.MoiNhat();
    const xemNhieuNhat = await News.XemNhieuNhat();
    const tatCa = await News.getAll();
    const thinhHanh = await News.getTrending();
    const tinNong = await News.getBreaking();
    const lienHe = await Contact.getOne();
    const danhMuc = await Category.getAll();
    let chiTietTin = null;
    if (req.newsId) {
      chiTietTin = await News.getById(req.newsId);
      News.incrementViews(req.newsId);
    }

    return res.render("client/layout/layout", {
      url: req.url,
      moiNhat: moiNhat,
      xemNhieuNhat: xemNhieuNhat,
      tatCa: tatCa,
      tinNong: tinNong,
      thinhHanh: thinhHanh,
      danhMuc: danhMuc,
      lienHe: lienHe,
      chiTietTin: chiTietTin,
      categoryId: req.categoryId,
    });
  } catch (error) {
    console.error("Lỗi:", error);
    return res.render("client/layout/layout", {
      url: req.url,
      moiNhat: {},
      xemNhieuNhat: {},
      tatCa: {},
      tinNong: {},
      thinhHanh: {},
      danhMuc: {},
      lienHe: {},
    });
  }
};

let submitContact = async (req, res) => {
  try {
    // 1. Lấy dữ liệu người dùng nhập từ form
    const { ten, email, so_dien_thoai, tieu_de, noi_dung } = req.body;

    // 2. Gọi file pool kết nối DB (Đảm bảo bạn đã require pool ở đầu file controller nhé)
    const pool = require("../../config/dbConnect.js"); // Đường dẫn có thể khác tùy cấu trúc thư mục của bạn

    // 3. Câu lệnh SQL thêm vào bảng lien_he
    const sql = `
      INSERT INTO lien_he (ten, email, so_dien_thoai, tieu_de, noi_dung, ngay_gui, trang_thai) 
      VALUES (?, ?, ?, ?, ?, NOW(), 0)
    `;
    const values = [ten, email, so_dien_thoai, tieu_de, noi_dung];

    // 4. Thực thi câu lệnh
    await pool.execute(sql, values);

    // 5. Thành công thì đưa người dùng quay lại trang họ vừa đứng
    // (Thực tế có thể dùng flash message báo thành công, nhưng mình làm đơn giản trước nhé)
    res.redirect("/");
  } catch (error) {
    console.error("Lỗi khi gửi liên hệ:", error);
    res.status(500).send("Đã có lỗi xảy ra trong quá trình gửi liên hệ!");
  }
};

let subscribe = async (req, res) => {
  try {
    const pool = require("../../config/dbConnect.js"); // Sửa lại đường dẫn DB nếu cần
    const { email } = req.body;

    // Validate nhẹ xem có email gửi lên không
    if (!email) {
      return res
        .status(400)
        .json({ success: false, message: "Vui lòng nhập địa chỉ email!" });
    }

    // Câu lệnh Insert vào bảng dang_ky
    const sql = `INSERT INTO dang_ky (email) VALUES (?)`;
    await pool.execute(sql, [email]);

    // Trả về JSON báo thành công
    res.json({
      success: true,
      message: "Đăng ký nhận tin thành công! Cảm ơn bạn.",
    });
  } catch (error) {
    // Bắt lỗi trùng email (mã lỗi ER_DUP_ENTRY của MySQL)
    if (error.code === "ER_DUP_ENTRY") {
      return res.status(400).json({
        success: false,
        message: "Email này đã được đăng ký từ trước!",
      });
    }

    console.error("Lỗi khi đăng ký nhận tin:", error);
    res
      .status(500)
      .json({ success: false, message: "Lỗi server, vui lòng thử lại sau!" });
  }
};

let searchNews = async (req, res) => {
  try {
    const keyword = req.query.keyword || "";
    const page = parseInt(req.query.page) || 1;
    const limit = 4; // Số bài hiển thị trên 1 trang
    const offset = (page - 1) * limit;

    const totalRows = await News.countSearchNews(keyword);
    const totalPages = Math.ceil(totalRows / limit);

    // 2. Lấy danh sách tin tức tìm được
    const newsList = await News.searchNewsPagination(keyword, limit, offset);

    //Lấy thêm dữ liệu cho Navbar và Sidebar dùng chung
    const danhMuc = await Category.getAll();
    const thinhHanh = await News.getTrending();
    const lienHe = await Contact.getOne();

    // 4. Render ra giao diện EJS
    res.render("client/layout/layout", {
      url: "search", // Cực kỳ quan trọng: truyền chữ 'search' để layout gọi đúng file '../pages/search'
      keyword: keyword,
      newsList: newsList,
      totalRows: totalRows,
      totalPages: totalPages,
      currentPage: page,
      danhMuc: danhMuc,
      thinhHanh: thinhHanh,
      lienHe: lienHe,

      // Khai báo thêm các biến này thành null hoặc rỗng để layout không báo lỗi "is not defined" nữa
      chiTietTin: null,
      categoryId: null,
      moiNhat: {},
      xemNhieuNhat: {},
      tatCa: {},
      tinNong: {},
    });
  } catch (error) {
    console.error("Lỗi khi tìm kiếm:", error);
    res.status(500).send("Lỗi server!");
  }
};

module.exports = {
  getPage: getPage,
  submitContact: submitContact,
  subscribe: subscribe,
  searchNews: searchNews,
};
