package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import helper.Contants;
import model.User;
import service.UserService;

import java.io.IOException;

@WebServlet(name = "SignIn", value = "/sign-in")
public class SignIn extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("template/dang-nhap.jsp").forward(request, response);
		return;
	}
	// SignIn sẽ gọi UserService để thực hiện kiểm tra
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//5. Hệ thống lấy dữ liệu và kiểm tra dữ liệu nhập  (mainguyen)
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(username);
		System.out.println(password);

		// UserService sẽ vào database tìm result set có tài khoản và mật khẩu tương ứng
		// để trả về

		// 6.Hệ thống gọi dangNhap() để lấy thông tin   (mainguyen)
		User user = UserService.dangNhap(username, password);
		if (user == null) {
			
//			7.1 Hiển thị thông báo tên đăng nhập và password không hợp lệ   (mainguyen)
      
			request.setAttribute("error", "Username or password is incorrect");// truyền kèm theo biến
			// .forward(request, response) khi muốn truyền tất cả input truyền sang trang kế
			// tiếp
			request.getRequestDispatcher("/template/dang-nhap.jsp").forward(request, response);
		} else {
			// Nếu có tồn tại tài khoản và mật khẩu đó, sẽ trả về một trang html thông báo
			// đăng nhập thành công cho người dùng
			System.out.println(user.getRole());
			HttpSession session = request.getSession(true);
			session.setAttribute("userLogin", user);// lưu thông tin của user vào trường auth trên session
			if (user.getRole() == Contants.ROLE_CUSTOMER) {
				System.out.println("addressDefault");
																// khi mua hàng
				// 8. Thông tin tài khoản đã tồn tại trong database sẽ chuyển đến trang Sản phẩm   (mainguyen)
				response.sendRedirect("/products");// goi api lấy danh sách sản phẩm
			} else if (user.getRole() == Contants.ROLE_ADMIN) {
				response.sendRedirect("/quan-tri-admin/indexAdmin.jsp");
			}
			return;
		}
	}
}
