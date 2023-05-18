<%@ page import="model.User"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>G15 | Khách hàng</title>
	<link rel="stylesheet" href="../themes/css1/thong-tin-khach-hang.css">
	<link rel="stylesheet" href="../themes/css1/dia-chi.css">
</head>
<body>
<%--1. Người dùng truy cập thành công vào trang quản lý tài khoản và bắt đầu chức năng chỉnh sửa thông tin tài khoản--%>
<!-- header -->
<%@ include file="/template/header.jsp"%>
<main class="content" id="main">
	<section>
		<div class="container-lg">
			<div class="row justify-content-center">
				<%@ include file="header-left.jsp"%>
				<div class="col-md-8 right">
					<!-- Thông tin tài khoản -->
					<h1 class="text-center mb-3">Thông tin tài khoản</h1>
					<%
						// Check đăng nhập
						if (session.getAttribute("userLogin") != null) {
							User infoUser = (User) session.getAttribute("userLogin");
					%>
					<%--1.2  Truy cập Controller TaiKhoan, lấy thông tin từ database thông qua User Service để hiển thị
                        thông tin người dùng ban đầu, khi lấy xong sẽ hiển thị qua form --%>
					<%--2.1 Người dùng nhập thông tin tài khoản (Bắt đầu chỉnh sửa thông tin người dùng--%>
					<form class="needs-validation"
						  action="/tai-khoan/cap-nhat-tai-khoan" method="POST">
						<div class="row ">
							<div class="col-sm-6">
								<%--2.1 Kiểm tra trường thông tin--%>
								<%--2.1 Người dùng nhập Họ--%>
								<label for="lastName" class="form-label">Họ</label> <input
									type="text" class="form-control" name="lastname"
									value="<%=infoUser.getLastname()%>" placeholder="Nguyễn"
									required>
								<%--2.2 Trường hợp người dùng nhập tên Họ không hợp lệ => hiện thông báo--%>
								<div class="invalid-feedback">Họ hợp lệ là bắt buộc.</div>
							</div>
							<div class="col-sm-6">
								<%--2.1 Người dùng nhập Tên--%>
								<label for="firstName" class="form-label">Tên </label> <input
									type="tel" class="form-control" name="firstname"
									value="<%=infoUser.getFirstname()%>" placeholder="Trúc Mai"
									required>
								<%--2.2 Trường hợp người dùng nhập Tên không hợp lệ => hiện thông báo--%>
								<div class="invalid-feedback">Tên hợp lệ là bắt buộc.</div>
							</div>
							<div class="col-sm-12">
								<%--2.1 Người dùng nhập tên đăng nhập--%>
								<label for="username" class="form-label">Tên đăng nhập</label>
								<input type="text" class="form-control" name="username"
									   placeholder="mainguyen" value="<%=infoUser.getUsername()%>"
									   required>
								<%--2.2 Trường hợp người dùng nhập tên đăng nhập không hợp lệ/ hoặc đã trùng => hiện thông báo--%>
								<div class="invalid-feedback">Tên đăng nhập hợp lệ là bắt
									buộc.</div>
							</div>
							<div class="col-12">
								<%--2.1 Người dùng nhập địa chỉ Email--%>
								<label for="email" class="form-label">Email<span
										class="text-muted">(Tùy chọn)</span></label> <input type="email"
																							class="form-control" name="email"
																							value="<%=infoUser.getEmail()%>"
																							placeholder="mainguyen@gmail.com">
								<%--2.2 Trường hợp người dùng nhập địa chỉ email không hợp lệ => hiện thông báo--%>
								<div class="invalid-feedback">Vui lòng nhập một địa chỉ
									email hợp lệ để cập nhật thông tin vận chuyển.</div>
							</div>

							<div class="col-12">
								<%--2.1 Người dùng nhập số điện thoại--%>
								<label for="phone" class="form-label">Số điện thoại</label> <input
									type="tel" class="form-control" name="phone"
									value="<%=infoUser.getPhone()%>" placeholder="0123456789">
								<%--2.2 Trường hợp người dùng nhập số điện thoại không hợp lệ--%>
								<div class="invalid-feedback">Vui lòng nhập số điện thoại
									hợp lệ để cập nhật thông tin vận chuyển.</div>
							</div>
							<%--2.2 Check coi form có lỗi không.
                               2.2.1 Nếu có thì hiện label thông báo lỗi--%>
							<%
								if (request.getAttribute("error") != null) {
							%>
							<label style="color: red"><%=request.getAttribute("error")%></label>
							<%
								}
							%>
						</div>
						<%--2.3 Người dùng bấm vào nút cập nhật để cập nhật thông tin--%>
						<button id="login_btn" class="btn btn-dark" type="submit">Cập nhật</button>
					</form>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</section>
</main>
<!-- footer -->
<%@ include file="/template/footer.jsp"%>
<!-- js -->
</body>
</html>