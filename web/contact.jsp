<%-- 

--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
    </head>
    <body>
        <jsp:include page="./header.jsp"/>
        <div class="container">
            <div class="row">
                <div class="sider col-md-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="./Home">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="./ProductList">Loại sản phẩm</a></li>
                        </ol>
                    </nav>
                    <div class="search">
                        <form action="ProductList?index=1" class="form-search" method="get">
                            <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Search product here...">
                            <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                        </form>
                        <div class="side-item">
                            <h5>Giỏ hàng</h5>
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
                <div class="col-md-9">

                    <div class="orderdetails-content">
                        <div class="id-status-order">
                            <span class="status-order">Mua</span>
                        </div>

                        <form action="MyOrder" method="post">

                            <c:forEach items="${cart}" var="c">
                                <div class="products-container">
                                    <div class="left-container">
                                        <div class="img-container">
                                            <img class="product-img" onclick="window.location = 'ProductDetail?pid=${c.value.product.id}'" src="${c.value.product.img}" alt="">
                                        </div>
                                        <div class="product-content">
                                            <div onclick="window.location = 'ProductDetail?pid=${c.value.product.id}'" class="name-product">${c.value.product.title}</div>
                                            <div onclick="window.location = 'ProductDetail?pid=${c.value.product.id}'" class="quantity-product">x${c.value.quantity}</div>
                                        </div>
                                    </div>
                                    <div class="right-container">
                                        <div class="product-price">
                                            <span class="price">${c.value.product.salePrice*c.value.quantity}$</span>
                                            <span class="sale-price">${c.value.product.salePrice}$</span>
                                        </div>
                                    </div>
                                </div>   

                                <input type="hidden" name="order_id" value="${order_id}">
                                <input type="hidden" name="quantity" value="${c.value.quantity}">
                                <input type="hidden" name="product_id" value="${c.value.product.id}">
                                <input type="hidden" name="author_id" value="${account.user_id}">
                                <input type="hidden" name="title" value="${c.value.product.title}">
                                <input type="hidden" name="brand_id" value="${c.value.product.brand}">
                                <input type="hidden" name="price" value="${c.value.product.price}">
                                <input type="hidden" name="sale_price" value="${c.value.product.salePrice}">
                                <input type="hidden" name="stock" value="${c.value.product.stock}">
                                <input type="hidden" name="description" value="${c.value.product.description}">
                                <input type="hidden" name="img" value="${c.value.product.img}">
                                <input type="hidden" name="category_id" value="${c.value.product.category}">

                            </c:forEach>
                            <div class="hr"></div>
                            <div class="info-container">
                                <div class="order-info">
                                    <div class="img-container">
                                    </div>

                                    <div class="deliadd">Thông tin giao hàng:</div>
                                    <div class="fullname-container">Họ và tên <span class="fullname">${account.fullname}</span></div>
                                    <input type="hidden" name="action" value="addOrder">
                                    <input class="fullname" type="hidden" name="fullname">

                                    <div class="phone-address">
                                        Số điện thoại:<span class="phone">${account.phone}</span><br><span class="address"> Địa chỉ:${account.address}</span>
                                        <input class="phone" type="hidden" name="phone">
                                        <input class="address" type="hidden" name="address">
                                    </div>
                                    <div class="email-container">Email: <span class="emaila">${account.email}</span></div>
                                    <input class="emaila" type="hidden" name="emaila">

                                </div>
                                <div class="div-mid">

                                    <div class="form-check">
                                        <input class="form-check-input" value="8" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            Thanh toán khi giao hàng
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" value="9" type="radio" name="flexRadioDefault" id="flexRadioDefault2" >
                                        <label class="form-check-label" for="flexRadioDefault2">
                                            Thanh toán bằng thẻ ngân hàng
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label style="font-weight: bold" for="exampleFormControlTextarea1">Ghi chú</label>
                                        <textarea name="textarea" maxlength="50" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="div-right">

                                    <div class="total-prices">Tổng giá:&nbsp;&nbsp;&nbsp; <span class="bottoms">${total}$</span></div>
                                    <input type="hidden" name="total" value="${total}">
                                    <input type="submit" style="margin-top: 25px; background-color:peru" class="btn-feedback" value="Thanh toán">


                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
       

        <jsp:include page="./footer.jsp"/>

        <script src="js/bootstrap.js"></script>
        <script>
                                        document.getElementsByClassName("fullname")[1].value = document.getElementsByClassName("fullname")[0].innerHTML;
                                        document.getElementsByClassName("phone")[1].value = document.getElementsByClassName("phone")[0].innerHTML;
                                        document.getElementsByClassName("address")[1].value = document.getElementsByClassName("address")[0].innerHTML;
                                        document.getElementsByClassName("emaila")[1].value = document.getElementsByClassName("emaila")[0].innerHTML;


                                        function isValidEmail(email) {
                                            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                            return emailRegex.test(email);
                                        }

                                        function isValidPhoneNumber(phone) {
                                            var phoneRegex = /^0\d{9}$/;
                                            return phoneRegex.test(phone);
                                        }
                                        function isValidFullName(fullname) {
                                            var regex = /^[a-zA-ZÀ-ÿ\s']+$/;

                                            if (!regex.test(fullname)) {
                                                return false;
                                            }
                                            return true;
                                        }


                                        function btnChangeAddress() {
                                            var fullname = document.getElementById("fullnamect").value;
                                            var phone = document.getElementById("phonect").value;
                                            var address = document.getElementById("addressct").value;
                                            var email = document.getElementById("emailct").value;
                                            if (fullname === '' || phone === '' || address === '' || email === '') {
                                                alert('Không được để trống');
                                                return;
                                            }
                                            if (!isValidEmail(email)) {
                                                alert('Vui lòng nhập địa chỉ email hợp lệ');
                                                return;
                                            }
                                            if (!isValidPhoneNumber(phone)) {
                                                alert('Vui lòng nhập số hợp lệ bắt đầu bằng số 0 và có 10 số');
                                                return;
                                            }
                                            if (containsNumbers(fullname)) {
                                                alert('Tên không được chứa số');
                                                return;
                                            }
                                            if (!isValidFullName(fullname)) {
                                                alert('Tên không hợp lệ');
                                                return;
                                            }
                                            

                                            document.getElementsByClassName("fullname")[0].innerHTML = fullname;
                                            document.getElementsByClassName("phone")[0].innerHTML = phone;
                                            document.getElementsByClassName("address")[0].innerHTML = address;
                                            document.getElementsByClassName("emaila")[0].innerHTML = email;

                                            document.getElementsByClassName("fullname")[1].value = fullname;
                                            document.getElementsByClassName("phone")[1].value = phone;
                                            document.getElementsByClassName("address")[1].value = address;
                                            document.getElementsByClassName("emaila")[1].value = email;

                                            document.getElementById("changeAddress").style.display = "none";
                                            document.querySelector('body > div.modal-backdrop.fade.show').style.display = "none";
                                            alert('Thay đổi thành công');
                                            return;
                                        }
        </script>
    </body>
</html>


