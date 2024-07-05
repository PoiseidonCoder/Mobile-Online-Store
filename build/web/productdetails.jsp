<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết sản phẩm</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body>
        <jsp:include page="./header.jsp"/>

        <section class="section-product-detail">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="./Home">Trang chủ </a></li>
                        <li class="breadcrumb-item"><a href="./ProductList?index=1">Danh sách sản phẩm</a></li>
                        <li class="breadcrumb-item active">Thông tin sản phẩm</li>
                    </ol>   
                </nav> 
                <div class="main-section-content">
                    <div class="sider">
                        <div class="search">
                            <form action="ProductList?index=1" class="form-search" method="get">
                                <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Tìm kiếm tại đây">
                                <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                            </form>
                            <div class="side-item">
                                <h5>Loại sản phẩm</h5>
                                <ul class="cat-list">
                                    <c:forEach var="cate" items="${cate}">
                                        <li class="cat-list-item "><a href="#sublist${cate.setting_id}" data-bs-toggle="collapse" class="${cate.setting_id==requestScope.categoryId?"fw-bold":""}">${cate.value}</a>
                                            <div class="collapse" id="sublist${cate.setting_id}">
                                                <div class="card card-body " style="border: none;">
                                                    <c:forEach var="brand" items="${brand}">
                                                        <a href="./ProductList?brandId=${brand.setting_id}&categoryId=${cate.setting_id}&orderby=&index=1&search=${requestScope.search}" 
                                                           class="${brand.setting_id==requestScope.brandId&&cate.setting_id==requestScope.categoryId?"fw-bold":""} sub-cate-item" >- ${brand.value}</a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="latest-product">
                                <h5>Sản phẩm mới nhất</h5>
                                <c:forEach var="pro" items="${prolist5}">
                                    <div class="latest-product-item">
                                        <a href="./ProductDetail?pid=${pro.id}" title="product thumbnail" style="width: 45%;"><img src="${pro.img}" alt="" width="100%"></a>
                                        <div class="latest-product-info">
                                            <h4 class="latest-product-title"><a href="./ProductDetail?pid=${pro.id}" class="product-name">${pro.title}</a></h4>
                                            <div class="latest-product-price">
                                                <p><span class="price-amount"><span>$</span>${pro.salePrice} </span></p>
                                                <del><span class="price-amount"><span>$</span>${pro.price}</span></del>
                                            </div>
                                            <div class="btn-list">
                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn"> Xem</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="product-details" style="margin-left: 20px">
                        <div class="product-img">
                            <a href="#"><img src="${product.img}" width="100%"></a>
                        </div>
                        <div class="product-detail-info">
                            <h1>${product.title}</h1>
                            <div class="star-ratings">
                                <div class="fill-ratings" >
                                    <p>${numberFb}</p>
                                </div>
                            </div>
                            <h5>Loại sản phẩm: ${product.category}</h5>
                            <h5>Thương hiệu: ${product.brand}</h5>
                            <h5>Người bán: ${requestScope.seller}</h5>
                            <div class="product-price">
                                <p> Giá giảm : <span class="price-amount"><span class="currencySymbol">$</span>${product.salePrice}</span></p><p><del><span class="price-amount"><span class="currencySymbol">$</span>${product.price}</span></del></p><br>

                            </div>
                            <div class="details-description"></div>
                            <div class="btn-pro-details">
                                <form action="cart">
                                    Số lượng: <input type="number"  name="quantity"  min="1" value="1"  max="${product.stock-requestScope.requestScope.quantityincart}">
                                    <input type="hidden" name="pid" value="${product.id}">
                                    Hàng Còn: ${(product.stock-requestScope.requestScope.quantityincart)}(Đã tính giỏ hàng)
                                    <button class="submit" <c:if test="${(product.stock-requestScope.requestScope.quantityincart) <= 0}">style="pointer-events: none; opacity: 0.5;"</c:if>  type="submit" onclick="addCart()" value="Thêm vào giỏ hàng">
                                        <c:if test="${(product.stock-requestScope.requestScope.quantityincart) <= 0}">Hết hàng</c:if>
                                        <c:if test="${(product.stock-requestScope.requestScope.quantityincart) > 0}">Thêm vào giỏ hàng</c:if>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="display-feedback">
                                <h2 style="padding: 10px; border-bottom: 1px solid lightgray; margin-top: 20px;">Thông tin tổng thể:</h2>
                            ${product.description}
                        </div>           
                        <div class="display-feedback">
                            <h2 style="padding: 10px; border-bottom: 1px solid lightgray; margin-top: 20px;">Danh sách phản hồi:</h2>
                            <c:forEach items="${fblist}" var="fb">
                                <div class="feedback-item" style="height: 180px;">
                                    <div class="fb-content">
                                        <div class="avatar"><img src="${fb.user.avatar}" class="rounded-circle" alt="avatar" height="50px" width="50px"> <span >${fb.user.fullname} - ${fb.rated}<i class="fa fa-star" style="color: red;"></i></span></div>
                                        <p>Ngày: ${fb.feedback_date}</p>
                                        <span class="description" style="width:70% ">${fb.fb_content}</span>
                                    </div>
                                    <div class="fb-img"> 
                                        <image src="${fb.image}" height="120px;" >
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                        <div class="recommend-items">
                            <h2 style="text-align: center;padding: 10px; border-bottom: 1px solid lightgray;">Đề xuất sản phẩm</h2>
                            <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <div class="row">
                                            <c:forEach items="${requestScope.recommend1}" var="pro">
                                                <div class="product-item col-4">
                                                    <a href="./ProductDetail?pid=${pro.id}" title="product thumbnail" ><img src="${pro.img}" alt="" width="100%"></a>
                                                    <div class="product-info">
                                                        <b class="categories">${pro.brand} - ${pro.category}</b>
                                                        <h4 class="product-title"><a href="./ProductDetail?pid=${pro.id}" class="product-name">${pro.title}</a></h4>

                                                        <div class="price">
                                                            <p><span class="price-amount"><span>$</span>${pro.salePrice}</span></p>
                                                            <del><span class="price-amount"><span>$</span>${pro.price}</span></del>
                                                        </div>

                                                        <div class="btn-list">
                                                            <a href="./cart?pid=${pro.id}&quantity=1" class="product-btn" <c:if test="${pro.stock <= 0}">style="pointer-events: none; opacity: 0.5;"</c:if> onclick="addCart()"><i class="fa fa-cart-arrow-down"></i>
                                                                <c:if test="${pro.stock <= 0}">Hết hàng</c:if>
                                                                <c:if test="${pro.stock > 0}">Thêm vào giỏ hàng</c:if>
                                                                </a>
                                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn"><i class="fa fa-eye" ></i> Xem</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="carousel-item ">
                                        <div class="row">
                                            <c:forEach items="${recommend2}" var="pro">
                                                <div class="product-item col-4">
                                                    <a href="./ProductDetail?pid=${pro.id}" title="product thumbnail" ><img src="${pro.img}" alt="" width="100%"></a>
                                                    <div class="product-info">
                                                        <b class="categories">${pro.brand} - ${pro.category}</b>
                                                        <h4 class="product-title"><a href="./ProductDetail?pid=${pro.id}" class="product-name">${pro.title}</a></h4>
                                                        <div class="price">
                                                            <p>Price: <span class="price-amount"><span>$</span>${pro.salePrice}</span></p>
                                                            <del><span class="price-amount"><span>$</span>${pro.price}</span></del>
                                                        </div>
                                                        <div class="btn-list">
                                                            <a href="./cart?pid=${pro.id}&quantity=1" class="product-btn" <c:if test="${pro.stock <= 0}">style="pointer-events: none; opacity: 0.5;"</c:if> onclick="addCart()"><i class="fa fa-cart-arrow-down"></i>
                                                                <c:if test="${pro.stock <= 0}">Hết hàng</c:if>
                                                                <c:if test="${pro.stock > 0}">Thêm vào giỏ hàng</c:if>
                                                                </a>
                                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn"><i class="fa fa-eye" ></i> Xem</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <button class="carousel-control-prev" style="margin-bottom: 100px" type="button" data-bs-target="#carouselExampleControls"
                                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Trước</span>
                                </button>
                                <button class="carousel-control-next" style="margin-bottom: 100px" type="button" data-bs-target="#carouselExampleControls"
                                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Sau</span>
                                </button>
                            </div>
                        </div>/
                    </div>  
                </div>
            </div>
        </section>
        <jsp:include page="./footer.jsp"/>

        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>
    </body>
</html>