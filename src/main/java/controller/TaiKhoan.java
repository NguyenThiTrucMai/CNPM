package controller;

import javax.servlet.*;
import javax.servlet.http.*;

import model.User;
import service.UserService;

import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "TaiKhoan", value = "/tai-khoan/*")
public class TaiKhoan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String action = request.getPathInfo();// lấy được đường dẫn phía sau chữ cart
        if (action == null) {
            action = "/";
        }
        switch (action) {
            case "/update-address":
                if (session.getAttribute("addressDefault") == null) {
                    response.sendRedirect("thong-tin-khach-hang/dia-chi.jsp");
                    return;
                }
                break;
            default:
                break;
        }
        // request.getRequestDispatcher("template/dang-nhap.jsp").forward(request,response);
        return;
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();// lấy được đường dẫn phía sau chữ cart /
        if (action == null) {
            action = "/";
        }
        switch (action) {
            // 1.1 Khởi động chức năng cập nhật tài khoản (Hiếu)
            case "/cap-nhat-tai-khoan":
                updateUser(request, response);
                return;
            default:
                break;
        }
        // request.getRequestDispatcher("template/dang-nhap.jsp").forward(request,response);
        return;
    }
    // 1.2 TaiKhoan sẽ yêu cầu UserService để thực hiện chức năng (lấy thông tin tài khoản từ database) (Hiếu)
    protected void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf8");// lấy dữ liệu ép kiểu về tiếng việt
        response.setCharacterEncoding("utf8");
        response.setContentType("text/html; charset=UTF-8");
        System.out.println("update user info");
        HttpSession session = request.getSession(true);
//		Check người dùng coi có đăng nhập chưa? (Hiếu)
        if (session.getAttribute("userLogin") == null) {
//			Nếu chưa thì chuyển sang trang sign-in (Hiếu)
            response.sendRedirect("/sign-in");
            return;
        }
        //1.2 UserService sẽ lấy dữ liệu thông tin người dùng từ database (chưa chỉnh sửa) (Hiếu)
        User info = (User) session.getAttribute("userLogin");
        System.out.println(info);
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        // 2.1 UserService kiểm tra username mới này có giống với tài khoản nào không (Hiếu)
        if (!username.equals(info.getUsername())) {
            //2.2 Nếu đã có tên người dùng đó thì hiện thông báo lỗi (Hiếu)
            if (UserService.checkUserNameExist(username)) {
                System.out.println("check user name");
                //2.2 Controller setAttribute error => Hiện thông báo lỗi (Hiếu)
                request.setAttribute("error", "Username này đã có người sử dụng. Vui lòng đổi username khác");
                request.getRequestDispatcher("/thong-tin-khach-hang/quan-ly-tai-khoan.jsp").forward(request, response);
                return;
            }
            //2.1 Nếu chưa ai sử dụng thì có quyền set username (Hiếu)
            info.setUsername(username);
        }
        // 2.1 Khi trường thông tin hợp lệ thì set thông tin người dùng dựa vào input trong trang (Hiếu)
        info.setLastname(lastname);
        info.setFirstname(firstname);
        info.setEmail(email);
        info.setPhone(phone);
        System.out.println(info);
        //3.1 UserServicecập nhật thông tin đó vào database (Hiếu)
        boolean isUpdate = UserService.updateUserByIdUser(info.getIduser(), info);
        System.out.println(isUpdate);
        session.setAttribute("userLogin", info);// cập nhật thông tin trên section (Hiếu)
        // 3.1 Sau khi chỉnh sửa xong thông tin hệ thống sẽ chuyển lại sang trang quan-ly-tai-khoan (Hiếu)
        response.sendRedirect("/thong-tin-khach-hang/quan-ly-tai-khoan.jsp");
    }
}