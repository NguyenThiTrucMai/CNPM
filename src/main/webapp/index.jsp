<%@page import="response.ProductCartResponse"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!-- 1
. Người dùng truy cập vào website (mainguyen) -->
                <!DOCTYPE html>
                <html lang="en">

                <head>

                    <title>G15 | Trang chủ</title>




                    <link rel="stylesheet" href="/themes/css1/product.css">
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>G15 | Đăng nhập</title>
                    <link rel="shortcut icon" href="/images/logo-new.jpg" type="image/x-icon">

                    <!-- CSS only -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
                        rel="stylesheet"
                        integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
                        crossorigin="anonymous">
                    <link rel="stylesheet" href="libs/glider.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
                        integrity="sha512-L7MWcK7FNPcwNqnLdZq86lTHYLdQqZaz5YcAgE+5cnGmlw8JT03QB2+oxL100UeB6RlzZLUxCGSS4/++mNZdxw=="
                        crossorigin="anonymous" referrerpolicy="no-referrer" />
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@400;700&display=swap"
                        rel="stylesheet">


                    <link rel="stylesheet" href="libs/jquery.exzoom.min.css">

                    <link rel="stylesheet" href="/themes/css/main.css">
                    <link rel="stylesheet" href="/themes/css/style_section.css">
                    <link rel="stylesheet" href="/themes/css1/menu.css">
                </head>

                <body>
                    <!-- header -->

                 
	<!-- header -->
    <header id="header">
        <div class="container">
            <div class="d-flex  align-items-center">
                <div class="col col-md-2">
                    <a href="/index.jsp"> <img src="../images/logo-new.jpg" alt=""
                            width="150" id="logo" />
                    </a>
                </div>
                <div id="sidebar">
                    <div class="container">
                        <div class="d-flex">
                            <div class="col col-md-2 col-sm-12"></div>
                            <div class="col col-md-5 col-sm-12">
                                <form id="searchBox" action="./search" method="get">
                                    <div class="form-group d-flex">
                                        <input type="text" name="txtSearch" id="searchInput"
                                            class="form-control"
                                            placeholder="Bạn cần tìm..."
                                            aria-describedby="helpId"
                                            oninput="searchByName(this)" />
                                        <ul id="result_search_box"></ul>
                                        <button type="submit" class="btn" id="searchBtn">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- 2. Nhấn vào nút "Đăng nhập" ở góc trên bên phải màn hình của trang chủ  (mainguyen)-->
                            <!-- Thong tin khi ddang nhaap -->
                            <div class="col-md-5 col-sm-12">
                                <ul class="d-flex">
                                    <% User auth=(User) session.getAttribute("userLogin");
                                        if (auth==null) { %>

                                        <li>
                                            <!-- <img src="images/icon_dang_nhap.png" alt="" /> -->
                                            <a href="/template/dang-nhap.jsp"
                                                class='fas fa-user-alt'> <span
                                                    id="get_name_user">Đăng nhập</span>
                                            </a>
                                        </li>
                                        <li>
                                            <!-- <img src="images/icon_dang_nhap.png" alt="" /> -->
                                            <a href="/template/dang-ky.jsp"
                                                class='fas fa-user-alt'> <span
                                                    id="get_name_user">Đăng ký</span></a>
                                        </li>
                                        <% } else { %>


                                            <div class="nav-item dropdown">
                                                <a href="../khach-hang.jsp"
                                                    class="nav-link dropdown-toggle show"
                                                    data-bs-toggle="dropdown"
                                                    aria-expanded="true"> <img
                                                        class="rounded-circle me-lg-2"
                                                        src="../images/profie.png" alt=""
                                                        style="width: 40px; height: 40px;">
                                                    <span class="d-none d-lg-inline-flex">
                                                        <%=auth.getUsername()%>
                                                    </span>
                                                </a>
                                                <!-- </ul> -->
                                            </div>
                                        </a></li>
                                    <li class="menu-item"><a href="/sale-off"
                                            class="d-flex">
                                            <h4>KHUYẾN MÃI</h4>
                                        </a></li>
                                    <li class="menu-item"><a
                                            href="/template/lien-he.jsp" class="d-flex">
                                            <h4>LIÊN HỆ</h4>
                                        </a></li>
                                    <li class="menu-item"><a
                                            href="/template/tin-tuc.jsp" class="d-flex">
                                            <h4>TIN TỨC</h4>
                                        </a></li>
                                    <li class="menu-item"><a href="/cart"
                                            class="d-flex">
                                            <i class="fa fa-cart-plus" width="24"></i>
                                            <% int size=0; if
                                                (session.getAttribute("productCartList")
                                                !=null) { HashMap<Integer,
                                                ProductCartResponse> cartList = (HashMap
                                                <Integer, ProductCartResponse>) session
                                                    .getAttribute("productCartList");

                                                    size = cartList.size();
                                                    }
                                                    %> <span>
                                                        <%=size%>
                                                    </span>
                                        </a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<%--main--%>
<main id="home_page">
    <%-- poster--%>
    <section id="poster_main">
        <div class="container-fluid px-0">
            <div id="carouselExampleDark" class="carousel carousel-dark slide"
                data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="0" class="active" aria-current="true"
                        aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleDark"
                        data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-bs-interval="2000">
                        <img src="images/banner/banner.jpg" class="d-block w-100"
                            alt="..." height="">
                    </div>
                    <div class="carousel-item" data-bs-interval="2000">
                        <img src="images/slide-04.jpg" class="d-block w-100" alt="..."
                            height="">
                    </div>
                    <div class="carousel-item">
                        <img src="images/slide-05.jpg" class="d-block w-100" alt="..."
                            height="">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button"
                    data-bs-target="#carouselExampleDark" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button"
                    data-bs-target="#carouselExampleDark" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <script>
            $("#poster_main").ready(function () {
                window.addEventListener('load', function () {
                    new Glider(document.querySelector('.glider--poster'), {
                        slidesToShow: 1,
                        dots: '.rect--poster',
                        draggable: true
                    });
                })
            })
        </script>
    </section>
<section id="product_arrival">
<div class="container">
    <h2 class="text-center">SẢN PHẨM NỔI BẬT</h2>
    <div class="row py-3 products">
        <c:forEach items="${listProduct}" var="p">
            <div class="col col-lg-3 p-2">
                <div class="card product-item">
                    <a href="/detail?idproduct=${p.idproduct}">
                        <img src='images\products\<c:out value="${p.codecate}"/>/<c:out value="${p.image}"/>'
                            class="card-img-top" alt="<c:out value="
                            ${p.image}" />">
                    </a>
                    <div class="card-body text-center">
                        <a href="/detail?idproduct=${p.idproduct}">
                            <h3 class="card-title" style="min-height: 50px">
                                ${p.title}</h3>
                            <p class="card-price">
                                <span class="price">
                                    <c:if test="${p.discount > 0}">
                                        <%-- <del>
                                            <c:out value="${p.price}" />
                                            VND</del>--%>
                                            <del>
                                                <fmt:formatNumber type="number"
                                                    maxFractionDigits="3"
                                                    value="${p.price}" /> VND
                                            </del>
                                    </c:if>
                                    <c:if test="${p.discount == 0}">
                                        <%-- <strong>
                                            <c:out value="${p.price}" />
                                            VND</strong>--%>
                                            <strong>
                                                <fmt:formatNumber type="number"
                                                    maxFractionDigits="3"
                                                    value="${p.price}" /> VND
                                            </strong>
                                    </c:if>
                                </span>
                                <span class="price-sale">
                                    <c:if test="${p.discount > 0}">
                                        <%-- <strong>
                                            <c:out value="${p.discount}" />
                                            VND</strong>--%>
                                            <strong>
                                                <fmt:formatNumber type="number"
                                                    maxFractionDigits="3"
                                                    value="${p.discount}" /> VND
                                            </strong>
                                    </c:if>
                                </span>
                            </p>
                        </a>
                        <div class="card-btn">
                            <a href="yeu-thich.html">
                                <button class="btn btn-like" value="ad1"
                                    title="Thêm vào mục yêu thích">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </a>
                            <form action="/cart/add-to-cart" method="POST"
                                style="width: 50%">
                                <input name="ismeasure" type="hidden" value="0">
                                <input name="id" type="hidden"
                                    value="${p.idproduct}">
                                <input type="hidden" name="get_quantity_order"
                                    id="get_quantity_order" class="form-control"
                                    value="1" min="1" /> <input
                                    name="get_size_order" type="hidden"
                                    value="S" />
                                <button class="btn btn-primary"
                                    style="width: 100%"><i
                                        class="fas fa-cart-plus"></i></button>
                            </form>
                            <a href="/datmay?idproduct=${p.idproduct}"
                                class="btn btn-outline-dark mx-2"
                                id="datmay_btn" style="width: 50%">ĐẶT
                                MAY</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
    <div class="d-flex justify-content-center">

        <a href="products" class="btn btn-outline-dark">Xem thêm sản phẩm</a>
    </div>
</div>
</section>
<section id="section_cate_product">
<div class="container">
    <h2 class="text-center">DANH MỤC SẢN PHẨM</h2>
    <div class="row">
        <div class="col col-lg-3 p-2">
            <a href="da-hoi.html">
                <div class="card">
                    <img src="images/products/da-hoi/DH (7).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">VÁY DẠ HỘI</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="ao-dai.html">
                <div class="card">
                    <img src="images/products/ao-dai/AD (9).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">ÁO DÀI</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="dam-vay.html">
                <div class="card">
                    <img src="images/products/dam-vay/DV (9).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">ĐẦM VÁY</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="vest.html">
                <div class="card">
                    <img src="images/products/vest/vestt(7).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">VEST</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="chan-vay.html">
                <div class="card">
                    <img src="images/products/chan-vay/CV (9).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">CHÂN VÁY</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="quan.html">
                <div class="card">
                    <img src="images/products/quan/quann(1).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">QUẦN</h3>
                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="set-do.html">
                <div class="card">

                    <img src="images/products/set-do/setdo(2).jpg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">SET ĐỒ</h3>

                </div>
            </a>
        </div>
        <div class="col col-lg-3 p-2">
            <a href="ao-khoac.html">
                <div class="card">

                    <img src="images/products/ao-khoac/aokhoac (3).jpeg" alt=""
                        class="card-img-top">
                    <h3 class="text-center card-title">ÁO KHOÁC</h3>

                </div>
            </a>
        </div>
    </div>
</div>
</section>
<section id="poster_sup">
<div class="container-fluid p-0">
    <img src="images/slide-01.jpg" alt="">
</div>
</section>
<section id="section_news">
<div class="container">
    <h2 class="text-center mb-3">TIN TỨC</h2>
    <div class="row mb-3">
        <div class="col col-lg-4">
            <div class="card hip-item">
                <a href="tin-tuc-chi-tiet.html">
                    <img src="images/phoi-do-voi-chan-vay-but-chi-yodyvn.jpg"
                        class="card-img-top" alt="...">
                    <div class="card-body">
                        <h4 class="card-title">
                            Gợi ý 10 outfit phối đồ với chân váy bút chì sành
                            điệu
                        </h4>
                        <p href="#" class="card-text">
                            Chân váy bút chì được xem là trang phục được các cô
                            nàng yêu thích và sử dụng trong
                            suốt những năm
                            vừa qua và chưa bao giờ là món đồ lỗi mốt. Phối đồ
                            với chân váy bút chì ra sao? Cùng
                            YODY tìm hiểu
                            ngay với bài viết dưới đây nhé!
                            <i>Đọc thêm</i>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        <div class="col col-lg-4">
            <div class="card hip-item">
                <a href="tin-tuc-chi-tiet.html">
                    <img src="images/post-1.png" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h4 class="card-title">
                            06 OUTFIT CÔNG SỞ CHO MỘT TUẦN TIẾT KIỆM THỜI GIAN
                        </h4>
                        <p href="#" class="card-text">
                            Hiện nay không ít cơ quan, công ty chỉ quy định
                            chung cho trang phục đi làm của nhân
                            viên, không bắt
                            buộc mặc đồng phục cố định nào. Vì vậy, chị em phụ
                            nữ có thể thoải mái sáng tạo, thể
                            hiện khả năng
                            phối đồ khi đi làm của mình.
                            <i>Đọc thêm</i>
                        </p>
                    </div>
                </a>
            </div>
        </div>
        <div class="col col-lg-4">
            <div class="card hip-item">
                <a href="tin-tuc-chi-tiet.html">
                    <img src="images/post-2.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h4 class="card-title">
                            Chân váy đuôi cá dài mặc với áo gì để tôn dáng, luôn
                            sành điệu?
                        </h4>
                        <p href="#" class="card-text">
                            Chân váy đuôi cá những chiếc váy không còn xa lạ đối
                            với phái đẹp không những tiện
                            lợi còn đem lại
                            sự sang chảnh. Vậy, chân váy đuôi cá dài mặc với áo
                            gì? Mix chân váy đuôi cá mùa
                            đông thế nào để thể
                            hiện được phong cách của mình?
                            <i>Đọc thêm</i>
                        </p>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-center">
        <a href="/tin-tuc.jsp" class="btn btn-outline-dark">Xem thêm tin tức</a>
    </div>
</div>
</section>
</main>
<!-- footer -->
<%@ include file="/template/footer.jsp" %>
<!-- js -->
</body>
</html>