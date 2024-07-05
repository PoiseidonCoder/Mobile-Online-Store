<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Loại sản phẩm</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>

    <body>
        <jsp:include page="./header.jsp"/>
        <section class="section-product-list">
            <div class="container col-md-12">
                <div class="row">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Home">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="CartView">Giỏ hàng</a></li>
                        </ol>
                    </nav>
                    <div class="sider col-md-3">
                        <div class="search">
                            <form action="ProductList?index=1" class="form-search" method="get">
                                <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Search product here...">
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
                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn">Xem thêm</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div id="cart-summary">
                            <table>
                                <tr>
                                    <td>Giá: </td>
                                    <td>${total}</td>
                                </tr>
                                <tr>
                                    <td >Số lượng:</td>
                                    <td>${count}</td>
                                </tr>	
                                <tr>
                                    <td>Phí vận chuyển</td>
                                    <td>Miễn phí</td>
                                </tr>
                                <tr>
                                    
                                    <td ><a href="contact" <c:if test="${not empty error}">style="pointer-events: none; opacity: 0.5;"</c:if>>Đặt hàng</a></td>
                                    <td><a href="ProductList" >Mua thêm</a></td>
                                </tr>
                            </table>
                                    
                        </div>
                        <p style="text-align: center;color:red;font-size: 25px">${error}${messageError}</p>
                        <div class="cart-content">
                            <div class="col-md-12">
                                ${requestScope.hihi}
                                <table>
                                    <thead>
                                        <tr>
                                            <td>Ảnh</td>
                                            <td>Tiêu đề</td>
                                            <td>Giá</td>
                                            <td>Số lượng</td>
                                            <td>Tổng giá:</td>
                                            <td>Xóa </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${cart}" var="c">
                                            <tr>
                                                <td class="cart-item-img">
                                                    <a href="" style="display:block"><img
                                                            src="${c.value.product.img}"
                                                            width="100px;" alt=""></a>
                                                </td>
                                                <td class="cart-pro-title">
                                                    <h4>${c.value.product.title}</h4>
                                                </td>
                                                <td class="cart-item-price">
                                                    <p>${c.value.product.salePrice}</p>

                                                </td>
                                                <td class="cart_quantity">
                                                    <div class="cart_quantity_button">
                                                        <form action="cart">
                                                            <input type="hidden" name="pid" value="${c.value.product.id}"> 
                                                            <input   type="number" class="submit" name="quantity" min="1"  value="${c.value.quantity}" onchange="this.form.submit()">
                                                        </form>  
                                                    </div>
                                                </td>
                                                <td class="cart_total">
                                                    <p class="cart_total_price">${c.value.product.salePrice*c.value.quantity}</p>
                                                </td>
                                                <td class="cart_delete">
                                                    <a class="cart_quantity_delete" href="delCart?pid=${c.value.product.id}"><i class="fa fa-times"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="./footer.jsp"/>
        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>
    </body>

</html>