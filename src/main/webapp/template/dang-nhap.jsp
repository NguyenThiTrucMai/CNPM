<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!-- 3. Hệ thống hiển thị trang đăng nhập  (mainguyen)-->
<!DOCTYPE html>
<html lang="en">

<head>

<title>G15 | Đăng nhập</title>




<link rel="stylesheet" href="../themes/css1/dang-nhap.css">
</head>

<body>
	<!-- header -->


	<%@ include file="header.jsp"%>


	<main id="main">
		<section>

			<div class="container-lg">
				<div class="row justify-content-center">

					<!-- <div class="d-flex box"> -->

					<div class="col-md-5 left">
						<div class="carousel-inner-login">
							<img src="../images/logo-new.jpg" class="login" alt="First slide">
						</div>


					</div>
					<div class="col-md-7 right">
						<h1 class="text-center mb-3">Đăng nhập</h1>
						<!-- 4. Người dùng nhập tên đăng nhập và mật khẩu đã có vào form sign-in  (mainguyen)-->
						<form class="frm_login" action="/sign-in" method="POST">
							<div class="row">


								<div class="col-sm-12">
									<label class="form-label">Email/ Tên đăng nhập <span
										class="text-muted">(Tùy chọn)</span></label> <input type="text"
										value="<%=request.getParameter(" username") != null ? request.getParameter("username") : "mainguyen"%>"
										name="username" class="form-control" placeholder="username"
										required>

									<div class="invalid-feedback">Vui lòng nhập một địa chỉ
										email hợp lệ để đăng nhập.</div>
								</div>


								<div class="col-sm-11">
									<label for="ip_password" class="form-label">Mật khẩu
										hiện tại</label> <input type="password" class="form-control"
										name="password" id="ip_password"
										placeholder="Mật khẩu hiện tại" value="" required>

									<div class="invalid-feedback">Mật khẩu hợp lệ là bắt
										buộc.</div>
								</div>

								<div class="col-sm-1">

									<button class="btn btn-outline-secondary" type="button"
										id="btnPassword">
										<span class="fas fa-eye"></span>
									</button>

								</div>

								<a href="/template/quen-mat-khau.jsp" id="forget_pass">Quên
									mật khẩu?</a>

								<%
								if (request.getAttribute("error") != null) {
								%>
								<label style="color: red"> <%=request.getAttribute("error")%>
								</label>
								<%
								}
								%>

							</div>

							
							<button id="login_btn" class="btn btn-dark" type="submit">
								Đăng nhập</button>

						</form>

						<!-- Form sign-in gửi request đến Controller chính -->
						<!-- Controller chính tiếp tục gửi request từ form đến SignIn trong Controller để thực hiện các hàm -->

						<hr>

						<p class="d-flex text-center justify-content-center-login">
							Chưa có tài khoản tại G15? <a href="/template/dang-ky.jsp">Đăng
								ký</a>
						</p>
					</div>

				</div>

			</div>

		</section>
	</main>

	<!-- footer -->
	<%@ include file="footer.jsp"%>

</body>

</html>