<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách sản phẩm</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body class="biolife-body">
        <c:if test="${empty requestScope.index}">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${not empty requestScope.index}">
            <c:set var = "index" scope = "page" value = "${requestScope.index}"/>
        </c:if>
        <jsp:include page="./header.jsp"/>
        <!--Navigation  section-->
        <section class="section-product-list">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="./Home">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="./ProductList?index=1">Danh sách sản phẩm</a></li>
                    </ol>
                </nav>
                <div class="main-section-content">
                    <div class="sider">
                        <div class="search">
                            <form action="ProductList?index=1" class="form-search" method="get">
                                <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Tìm kiếm sản phẩm tại đây">
                                <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                            </form>
                            <div class="side-item">
                                <h5>Loại sản phẩm</h5>
                                <ul class="cat-list">
                                    <c:forEach var="cate" items="${cate}">
                                        <li class="cat-list-item "><a href="#sublist${cate.setting_id}" data-bs-toggle="collapse" class="${cate.setting_id==requestScope.categoryId?"fw-bold":""}">${cate.value}</a>
                                            <div class="${cate.setting_id==requestScope.categoryId?"":"collapse"}" id="sublist${cate.setting_id}">
                                                <div class="card card-body " style="border: none;">
                                                    <c:forEach var="brand" items="${brand}">
                                                        <a href="./ProductList?brandId=${brand.setting_id}&categoryId=${cate.setting_id}&orderby=&index=1&search=${requestScope.search}" 
                                                           class="${brand.getSetting_id()==requestScope.brandId&&cate.setting_id==requestScope.categoryId?"fw-bold":""} sub-cate-item" >- ${brand.value}</a>
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
                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn"> Xem thêm</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="display-list">
                        <div class="filter">
                            <form action="ProductList" name="frm-refine" method="get">
                                <div class="left">
                                    <span class="filter-title">Tìm kiếm</span>
                                    <select name="categoryId">
                                        <option value="">Loại sản phẩm</option>
                                        <c:forEach var="cate" items="${requestScope.cate}">
                                            <option value="${cate.setting_id}" ${cate.setting_id eq requestScope.categoryId?"selected":""}>${cate.value}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="brandId">
                                        <option value="">Nhãn hiệu</option>
                                        <c:forEach var="brand" items="${requestScope.brand}">
                                            <option value="${brand.setting_id}" ${brand.setting_id eq brandId?"selected":""}>${brand.value}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="priceRangeId">
                                        <option value="">Khoảng giá</option>
                                        <c:forEach var="priceRange" items="${requestScope.priceRange}">
                                            <option value="${priceRange.setting_id}" ${priceRange.setting_id eq priceRangeId ? "selected" : ""}>${priceRange.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="right">
                                    <span class="filter-title">Sắp xếp </span>
                                    <select name="orderby">
                                        <option  ${orderby==1?"selected":""} value="1" >Theo ngày</option>
                                        <option  ${orderby==2?"selected":""} value="2">Theo giá tăng dần</option>
                                        <option  ${orderby==3?"selected":""} value="3">Theo giá giảm dần</option>
                                    </select>
                                    <button type="submit" value="Go" id="submit_pfilter">Lọc</button>
                                </div>
                            </form>
                        </div>
                        <div class="product-list">
                            <c:forEach var="pro" items="${requestScope.prolist}">
                                <div class="product-item" style="width: 31%">
                                    <a href="./ProductDetail?pid=${pro.id}" title="product thumbnail" ><img src="${pro.img}" alt="" width="100%"></a>
                                    <div class="product-info">
                                        <b class="categories">${pro.brand} - ${pro.category}</b>
                                        <h4 class="product-title"><a href="./ProductDetail?pid=${pro.id}" class="product-name">${pro.title}</a></h4>
                                        <div class="price">
                                            <p><span class="price-amount"><span>$</span>${pro.salePrice}</span></p>
                                            <del><span class="price-amount"><span>$</span>${pro.price}</span></del>
                                        </div>
                                        <div class="product-description">
                                            <p>${pro.description}....</p>
                                        </div>
                                        <div class="btn-list">
                                            <a href="./cart?pid=${pro.id}&quantity=1" <c:if test="${pro.stock <= 0}">style="pointer-events: none; opacity: 0.5;"</c:if> class="product-btn" onclick="addCart()"><i class="fa fa-cart-arrow-down"></i>
                                                <c:if test="${pro.stock <= 0}">Hết hàng${requestScope.containCart}</c:if>
                                                <c:if test="${pro.stock > 0}">Thêm vào giỏ hàng</c:if>
                                                </a>
                                            <a href="./ProductDetail?pid=${pro.id}" class="product-btn"><i class="fa fa-eye" ></i> Xem</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="pagination-arena">
                            <ul class="pagination">
                                <li class="page-item"><a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=1&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                <li class="page-item">
                                    <a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${index-2}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link ${index-2<1?"d-none":""}">${index-2}</a></li>
                                <li class="page-item">
                                    <a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${index-1}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link ${index-1<1?"d-none":""}">${index-1}</a></li>
                                <li class="page-item active">
                                    <a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${index}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link">${index}</a></li>
                                <li class="page-item">
                                    <a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${index+1}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link ${index+1>numberPage?"d-none":""}" >${index+1}</a></li>
                                <li class="page-item">
                                    <a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${index+2}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link ${index+2>numberPage?"d-none":""}">${index+2}</a></li>
                                <li><a href="./ProductList?brandId=${requestScope.brandId}&categoryId=${requestScope.categoryId}&orderby=${requestScope.orderby}&index=${numberPage}&search=${requestScope.search}&priceRangeId=${requestScope.priceRangeId}" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <jsp:include page="./footer.jsp"/>
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>
        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>
        <script>
                                                    function loginClick() {
                                                        loginForm.style.display = 'flex';
                                                    }
        </script>
    </body>

</html>