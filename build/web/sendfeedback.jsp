<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Gởi phản hồi</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body>
        <jsp:include page="./header.jsp" />

        <section class="section-product-detail">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="./Home">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="./ProductList?index=1">Danh sách sản phẩm</a></li>
                        <li class="breadcrumb-item active">Thông tin sản phẩm</li>
                    </ol>
                </nav>
                <div class="main-section-content">
                    <div class="sider">
                        <div class="search">
                            <form action="ProductList?index=1" class="form-search" method="get">
                                <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Search product here...">
                                <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                            </form>
                            <div class="side-item">
                                <h5>Loại sản phẩm</h5>
                                <ul class="cat-list">
                                    <c:forEach var="cate" items="${requestScope.cate}">
                                        <li class="cat-list-item "><a href="#sublist${cate.setting_id}" data-bs-toggle="collapse" class="${cate.setting_id==requestScope.categoryId?"fw-bold":""}">${cate.value}</a>
                                            <div class="collapse" id="sublist${cate.setting_id}">
                                                <div class="card card-body " style="border: none;">
                                                    <c:forEach var="brand" items="${requestScope.brand}">
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
                                                <a href="./ProductDetail?pid=${pro.id}" class="product-btn"> Xem thêm...</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="feedback-content">
                        <h1>Gởi phản hồi</h1>
                        <div class="main-content">
                            <form action="SendFeedback" method="post" onsubmit="return checkInput();">
                                <div class="product-info">
                                    <h3>Thông tin sản phẩm</h3>
                                    <p><b>Tên: </b>${product.title}</p>
                                    <p><b>Giá: </b>${product.price} $ </p>
                                    <p><b>Loại: </b>${product.category}</p>
                                    <p><b>Nhãn hiệu: </b>${product.brand}</p>
                                </div>
                                <span><b>Nội dung phản hồi:</b></span>
                                <textarea name="feedbackContent" id="feedbackContent"></textarea>
                                <span id="invalid" style="color: red;"> ${sessionScope.messc}</span>
                                <div><b>Đánh giá chất lượng: </b></div>

                                <div class="rating">
                                    <input type="radio" id="star5" name="rating" value="5" />
                                    <label for="star5" title="text">5 Sao</label>
                                    <input type="radio" id="star4" name="rating" value="4" />
                                    <label for="star4" title="text">4 Sao</label>
                                    <input type="radio" id="star3" name="rating" value="3"/>
                                    <label for="star3" title="text">3 Sao</label>
                                    <input type="radio" id="star2" name="rating" value="2"  />
                                    <label for="star2" title="text">2 Sao</label>
                                    <input type="radio" id="star1" name="rating" value="1" checked/>
                                    <label for="star1" title="text">1 Sao</label>
                                </div><br><br>
                                <span><b>Ảnh phản hồi:  </b></span>
                                <input type="file" id="fbimg" name="fbimg" onchange="changeFbimg()" accept=".jpg, .jpeg, .png"><br>

                                <span  id="invalid1" style="color: red;" > </span><br>
                                <input name="img" id="sendimg" type="hidden" >
                                <input name="pid" value="${product.id}" type="hidden">
                                <input type="submit" value="Submit" class="submit" >
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="./footer.jsp" />
        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>
        <script>
                                    function checkInput() {
                                        var content = document.getElementById("feedbackContent");
                                        var img = document.getElementById("fbimg");
                                        console.log(1);
                                        var a = 0;
                                        if (content.value == "") {
                                            document.getElementById("invalid").innerHTML = "Nội dung phản hồi không được để trống!"
                                            a = 1;
                                        }
                                        if (content.value.length > 200) {
                                            document.getElementById("invalid").innerHTML = "Nội dung phản hồi phải ít hơn 200 ký tự!"
                                            a = 1;
                                        }
                                        if (img.value == "") {
                                            document.getElementById("invalid1").innerHTML = "Vui lòng thêm ảnh!"
                                            a = 1;
                                        }
                                        console.log(1);
                                        if (a == 1) {
                                            return false;
                                        } else {
                                            return true;
                                        }

                                    }
                                    function changeFbimg() {
                                        var file = document.getElementById("fbimg").files[0];
                                        if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
                                            if (file.size / (1024 * 1024) < 5) {
                                                var fileReader = new FileReader();
                                                fileReader.readAsDataURL(file);
                                                fileReader.onload = function () {
                                                    document.getElementById("sendimg").value = (fileReader.result);
                                                }
                                            } else {
                                                uploadError();
                                            }
                                        } else {
                                            uploadError();
                                        }
                                    }
                                    function uploadError() {
                                        alert('Please upload photo file < 5MB')
                                        document.getElementById("fbimg").files[0].value = ''
                                        document.getElementById("fbimg").type = '';
                                        document.getElementById("fbimg").type = 'file';
                                    }
                                    function  checksubmit() {
                                        if (document.getElementById("feedbackContent").value.length > 200) {
                                            document.getElementById('invalid').style.display = "block";
                                            return false;
                                        }
                                        if (document.getElementById("fbimg").value == "") {
                                            document.getElementById('invalid2').style.display = "block";
                                            return false;
                                        }
                                        return true;
                                    }
        </script>
    </body>

</html>