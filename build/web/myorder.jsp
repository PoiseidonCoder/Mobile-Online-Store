<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Đơn hàng của tôi</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>

    <body>
        <jsp:include page="./header.jsp" />
        <c:if test="${param['index']==null }">
            <c:set var="index" scope="page" value="1" />
        </c:if>
        <c:if test="${param['index']!=null}">
            <c:set var="index" scope="page" value="${param['index']}" />
        </c:if>
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
                                <input type="text" name="search" class="input-text" value="${param['search']}" placeholder="Search product here...">
                                <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                            </form>
                            <div class="side-item">
                                <h5>Loại sản phẩm</h5>
                                <ul class="cat-list">
                                    <c:forEach var="cate" items="${cate}">
                                        <li class="cat-list-item "><a href="#sublist${cate.getSetting_id()}" data-bs-toggle="collapse" class="${cate.getSetting_id()==param['categoryId']?"fw-bold":""}">${cate.getValue()}</a>
                                            <div class="collapse" id="sublist${cate.getSetting_id()}">
                                                <div class="card card-body " style="border: none;">
                                                    <c:forEach var="brand" items="${brand}">
                                                        <a href="./ProductList?brandId=${brand.getSetting_id()}&categoryId=${cate.getSetting_id()}&orderby=&index=1&search=${param['search']}" 
                                                           class="${brand.getSetting_id()==param['brandId']&&cate.getSetting_id()==param['categoryId']?"fw-bold":""} sub-cate-item" >- ${brand.getValue()}</a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="latest-product">
                                <h5>Sản phẩm mới nhât</h5>
                                <c:forEach var="pro" items="${prolist5}">
                                    <div class="latest-product-item">
                                        <a href="./ProductDetail?pid=${pro.getId()}" title="product thumbnail" style="width: 45%;"><img src="${pro.getImg()}" alt="" width="100%"></a>
                                        <div class="latest-product-info">
                                            <h4 class="latest-product-title"><a href="./ProductDetail?pid=${pro.getId()}" class="product-name">${pro.getTitle()}</a></h4>
                                            <div class="latest-product-price">
                                                <p><span class="price-amount"><span>$</span>${pro.getSalePrice()} </span></p>
                                                <del><span class="price-amount"><span>$</span>${pro.getPrice()}</span></del>
                                            </div>
                                            <div class="btn-list">
                                                <a href="./ProductDetail?pid=${pro.getId()}" class="product-btn"> Xem thêm</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="myorder-content">
                        <div class="order-filter">
                            <form method="get" action="MyOrder">
                                <input type="date" name="from" value="${param['from']}">
                                <input type="date" name="to" value="${param['to']}">
                                <select name="status">
                                    <option value="" >Tất cả tình trạng</option>

                                    <c:forEach var="s" items="${status}">
                                        <option value="${s.getSetting_id()}" ${s.getSetting_id()==param['status']?"selected":""}>${s.getValue()}</option>

                                    </c:forEach>
                                </select>
                                <input class="submit-btn" type="submit" value="Lọc">
                            </form>
                        </div>
                        <div class="main-table">
                            <table class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Ngày đặt hàng</th>
                                        <th>Tổng chi phí</th>
                                        <th>Số lượng<br> Sản phẩm</th>
                                        <th>Trạng thái</th>
                                        <th class="order-notes">Ghi chú</th>
                                        <th >Hoạt động</th>
                                        <th colspan="2">Thanh toán</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="od" items="${OrderList}">
                                        <tr>
                                            <td>${od.getOrder_id()}</td>
                                            <td>${od.getOrder_date()}</td>
                                            <td>${od.getTotal()}$</td>
                                            <td>${od.getNumberPro()} </td>
                                            <td>
                                                <div class="btn btn-${od.getStatus()=="Đã hủy"?"danger":"success"}"style="padding: 10px;">${od.getStatus()}</div>
                                            </td>
                                            <td class="order-notes"><p>${od.getNote()}</p></td>
                                                    <c:if test="${od.getStatus()!='Shipping'}">
                                                <td><button type="button" class="delete" style="border: none;" data-toggle="modal" data-target="#ModalUP${od.getOrder_id()}" >
                                                        <i class="fa fa-trash"></i></button></td>
                                                    </c:if>
                                                    <c:if test="${od.getStatus()=='Shipping'}">
                                                <td></td>
                                            </c:if>
                                            <td><a class="view" href="./orderinformation?orderid=${od.getOrder_id()}"><i class="fa fa-eye" aria-hidden="true"></i></a></td>
                                        </tr>
                                        <!-- Modal -->
                                    <div class="modal fade" id="ModalUP${od.getOrder_id()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Xác nhận hủy đơn?</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <div style="text-align: center">Bạn có muốn đặt hàng?</div>
                                                    <div style="text-align: center">ID đơn hàng: ${od.getOrder_id()}</div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                    <button onclick="window.location = './MyOrder?action=delete&oid=${od.getOrder_id()}'" type="button" class="btn btn-primary">Xóa đơn hàng</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="pagination-arena">
                            <ul class="pagination">
                                <li class="page-item"><a
                                        href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=1"
                                        class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
                                </li>
                                <li class="page-item">
                                    <a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${index-2}"
                                       class="page-link ${index-2<1?" d-none":""}">${index-2}</a>
                                </li>
                                <li class="page-item">
                                    <a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${index-1}"
                                       class="page-link ${index-1<1?" d-none":""}">${index-1}</a>
                                </li>
                                <li class="page-item active">
                                    <a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${index}"
                                       class="page-link">${index}</a>
                                </li>
                                <li class="page-item">
                                    <a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${index+1}"
                                       class="page-link ${index+1>numberPage?" d-none":""}">${index+1}</a>
                                </li>
                                <li class="page-item">
                                    <a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${index+2}"
                                       class="page-link ${index+2>numberPage?" d-none":""}">${index+2}</a>
                                </li>
                                <li><a href="./MyOrder?from=${param['from']}&to=${param['to']}&status=${param['status']}&index=${numberPage}"
                                       class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <jsp:include page="./footer.jsp" />
        <script src="./js/bootstrap.js"></script>
        <script src="./js/main.js"></script>
        <script>
                                function warmDelete(x) {
                                    x.href = "#";
                                    alert("Vui lòng đăng nhập trước ");
                                }
        </script>

    </body>

</html>