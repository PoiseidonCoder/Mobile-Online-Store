<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hoàn thành giỏ hàng</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body>
        <jsp:include page="./header.jsp" />
        <c:if test="${requestScope.index==null }">
            <c:set var="index" scope="page" value="1" />
        </c:if>
        <c:if test="${requestScope.index!=null}">
            <c:set var="index" scope="page" value="${requestScope.index}" />
        </c:if>
        <section class="section-product-detail">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="./Home">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="./MyOrder">Đơn hàng của tôi</a></li>
                        <li class="breadcrumb-item active">Thông tin đơn hàng</li>
                    </ol>
                </nav>
                <div class="main-section-content">
                    <div class="sider">
                        <div class="search">
                            <div class="side-item">
                                <h5>Loại sản phẩm</h5>
                                <ul class="cat-list">
                                    <c:forEach var="cate" items="${cate}">
                                        <li class="cat-list-item "><a href="#sublist${cate.setting_id}" data-bs-toggle="collapse" class="${cate.setting_id==requestScope.categoryId?"fw-bold":""}">${cate.getValue()}</a>
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
                                <c:forEach var="pro" items="${latesproduct}">
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

                    <div class="orderdetails-content">
                        <div class="id-status-order">
                            <span class="id-order">Chúc mừng bạn đặt hàng thành công!</span>
                            <span class="status-order">Trạng thái: ${order.setting.value}</span>
                        </div>
                        <c:forEach items="${orderdetails}" var="o">
                            <div class="products-container">
                                <div class="left-container">
                                    <div class="img-container">
                                        <img onclick="window.location = 'ProductDetail?pid=${o.product_id}'" class="product-img" src="${o.image}" alt="">
                                    </div>
                                    <div class="product-content">
                                        <div onclick="window.location = 'ProductDetail?pid=${o.product_id}'" class="name-product">${o.title}</div>
                                        <div class="quantity-product">x${o.quantity}</div>
                                    </div>
                                </div>
                                <div class="right-container">
                                    <div class="product-price">
                                        <span class="price">${o.price}$</span>
                                        <span class="sale-price">${o.sale_price}$</span>
                                    </div>
                                    <c:if test="${order.setting.value=='Received'}">
                                        <div class="feedback-item">
                                            <button class="btn-feedback" onclick="window.location = './SendFeedback?pid=${o.product_id}'">Nhận xét</button>
                                        </div>
                                    </c:if>
                                </div>

                            </div>

                        </c:forEach>
                        <div class="hr"></div>
                        <div class="info-container">
                            <div class="order-info">
                                <div class="deliadd">Địa chỉ nhận hàng:</div>
                                <div class="fullname">Họ và tên:  ${order.fullname}</div>
                                <div class="address-order">
                                    ${order.phone}<br>${order.address}
                                </div>
                            </div>
                            <div class="div-right">

                                <c:if test="${canCancel!=null}">
                                    <button data-toggle="modal" data-target="#exampleModal"  style="margin-bottom: 25px; background-color:peru" class="btn-feedback">Cancel Order</button>
                                </c:if>
                                <div class="total-prices">Tổng tiền:&nbsp;&nbsp;&nbsp; <span class="bottoms">${order.total}$</span></div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Hủy đơn hàng</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div style="text-align: center">Bạn có muốn hủy đơn hàng</div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                            <button onclick="window.location = 'cancelorder?oid=${order.order_id}'" type="button" class="btn btn-primary">Hủy đơn hàng</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="./footer.jsp" />
        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>

    </body>

</html>