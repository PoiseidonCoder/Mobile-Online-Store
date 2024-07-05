    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Trang chủ</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body class="biolife-body">
        <jsp:include page="./header.jsp" />
        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach items="${requestScope.listSlide}" var="c" varStatus="count">
                    <div class="carousel-item ${count.count==1?"active":""}">
                        <a href="${c.backlink}"><img src="${c.image}" class="d-block w-100" alt="value"></a>
                        <div class="carousel-caption d-none d-md-block">
                            <h1 class="text-warning">${c.title}</h1>
                            <h4 class="text-warning">${c.description}</h4>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden"></span>
            </button>
        </div>
        <section class="section-product-list">
            <h1 style="text-align: center; font-size: 75px;color: #666666">Nổi Bật</h1>
            <div class="main-section-content">
                <div class="display-list">
                    <div class="product-list  display-list">
                        <c:forEach var="pro" items="${requestScope.prolist}">
                            <div class="product-item">
                                <a href="ProductDetail?pid=${pro.id}" title="product thumbnail"><img src="${pro.img}" alt="" width="100%"></a>
                                <div class="product-info">
                                    <h4 class="product-title"><a href="ProductDetail?pid=${pro.id}" class="product-name">${pro.getTitle()}</a></h4>
                                    <div class="price">
                                        <p><span class="price-amount"><span>$</span>${pro.salePrice}</span></p>
                                        <del><span class="price-amount"><span>$</span>${pro.salePrice}</span></del>
                                    </div>
                                    <div class="product-description">
                                        <p>${pro.description}....</p>
                                    </div>
                                    <div class="btn-list">
                                        <a href="ProductDetail?pid=${pro.id}" class="product-btn"><i class="fa fa-eye"></i> Xem Thêm</a>
                                        <a href="./cart?pid=${pro.id}&quantity=1" <c:if test="${pro.stock <= 0}">style="pointer-events: none; opacity: 0.5;"</c:if> class="product-btn" onclick="addCart()"><i class="fa fa-cart-arrow-down"></i>
                                            <c:if test="${pro.stock <= 0}">Hết hàng </c:if>
                                            <c:if test="${pro.stock > 0}">Thêm vào giỏ hàng</c:if>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="./footer.jsp" />
    </body>
    <script src="./js/bootstrap.js"></script>
    <script src="./js/main.js"></script>
</html>


