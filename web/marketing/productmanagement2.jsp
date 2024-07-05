<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <link href="./marketing/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.2.7/morris.min.js" integrity="sha512-nF4mXN+lVFhVGCieWAK/uWG5iPru9+/z1iz0MJbYTto85I/k7gmbTFFFNgU+xVRkF0LI2nRCK20AhxFIizNsXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="./marketing/css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body class="skin-black">
        <c:if test="${requestScope.index==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${requestScope.index!=null}">
            <c:set var = "index" scope = "page" value = "${requestScope.index}"/>
        </c:if>
        <!-- header logo: style can be found in header.less -->
        <div class="left-side sidebar-offcanvas"  style="height: 1200px;position: fixed; width: 220px; background-color: #39435c;left: 0; top:0;">
        </div>
        <jsp:include page="./header.jsp"/>
        <div class="wrapper row-offcanvas row-offcanvas-left" style="height: 100%;">
            <!-- Left side column. contains the logo and sidebar -->
            <jsp:include page="./aside.jsp"/>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">

                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel">
                                <header class="panel-heading">
                                    Product List
                                </header>
                                <!-- <div class="box-header"> -->
                                <!-- <h3 class="box-title">Responsive Hover Table</h3> -->

                                <!-- </div> -->
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                            <form class="search-slider"
                                                  style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                                  method="get" action="productmanagement">
                                                <div class="left-filter">
                                                    <a class="btn btn-primary" href="AddProduct" >Thêm mới sản phẩm</a>
                                                </div>

                                                <div class="right-search">
                                                    <label class="form-control"
                                                           style="border:none;display: inline;">Category</label>
                                                    <select class="form-control" name="categoryId" style="display: inline; width: 100px;">
                                                        <option value="">All</option>
                                                        <c:forEach var="cate" items="${cate}">
                                                            <option value="${cate.setting_id}" ${cate.setting_id==requestScope.categoryId?"selected":""}>${cate.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <label class="form-control"
                                                           style="border:none;display: inline;">Brands</label>
                                                    <select class="form-control" name="brandId" style="display: inline; width: 100px;">
                                                        <option value="">All</option>
                                                        <c:forEach var="brand" items="${brand}">
                                                            <option value="${brand.setting_id}" ${brand.setting_id==requestScope.brandId?"selected":""}>${brand.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <label class="form-control"
                                                           style="border:none;display: inline;">Status</label>
                                                    <select class="form-control" name="status" style="display: inline; width: 100px;">
                                                        <option value="">All</option>
                                                        <option value="1" ${requestScope.status==1?'selected':''}>Hoạt động</option>
                                                        <option value="0" ${requestScope.status==0?'selected':''}>Không hoạt động</option>
                                                    </select>
                                                    <input type="text" name="search" class="form-control" value="${requestScope.search} "
                                                           style="width: 250px;" placeholder="Search" />
                                                    <select class="form-control input-sm" name="type-search"
                                                            style="display: inline; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                        <option value="0" requestScope.type-search==0?'selected':''}>Title</option>
                                                        <option value="1" requestScope.type-search==1?'selected':''}>Brief</option>
                                                    </select>
                                                    <button class="btn btn-default">Lọc</button>
                                                </div>
                                            </form>
                                        </div>
                                        <table class="table table-hover " id="tablepro">
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                    <th style="width: 55px;">ID<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Name<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th style="width: 240px;">Image</th>
                                                    <th style="width: 340px;">Brief information<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Category<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Brand<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Stock<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Price<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Sale Price<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th>Status<i class="fa fa-caret-down" aria-hidden="true"></i></th>
                                                    <th  width="20px">Edit</th>
                                                    <th  width="20px">Del</th>
                                                    <th width="3%">Switch</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach var="s" items="${prolist}">
                                                    <tr>
                                                        <td style="width: 55px;">${s.id}</td>
                                                        <td data-toggle="modal" data-target="#Show${s.id}" style="cursor: pointer;">${s.getTitle()}</td>
                                                        <td style="width: 240px;"><image  src="${s.img}" width="150px"></td>
                                                        <td style="width: 340px;">${s.brief}...</td>
                                                        <td>${s.category}</td>
                                                        <td>${s.brand}</td>
                                                        <td>${s.stock}</td>
                                                        <td>${s.price}$</td>
                                                        <td>${s.salePrice}$</td>
                                                        <c:if test="${s.active}">
                                                            <td><span class="label label-success" style="font-size: 15px">Hoạt động</span></td>
                                                        </c:if>
                                                        <c:if test="${!s.active}">
                                                            <td><span class="label label-danger" style="font-size: 15px">Không hoạt động</span></td>
                                                        </c:if>
                                                            <td width="20px"><a class="btn btn-primary" href="EditProduct?pid=${s.id}"   ><i class="fa fa-pencil-square" aria-hidden="true"></i></a></td>
                                                        <td Width="20px"><a class="btn btn-danger" data-toggle="modal" data-target="#Delete${s.id}"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                                                                <c:if test="${s.active}">
                                                            <td><a class="btn btn-warning" href="productmanagement?action=switch&pid=${s.id}&sstatus=0&index=${index}">Không hoạt động</a></td>
                                                        </c:if>
                                                        <c:if test="${!s.active}">
                                                            <td ><a class="btn btn-success" href="productmanagement?action=switch&pid=${s.id}&sstatus=1&index=${index}">Hoạt động</a></td>
                                                        </c:if>
                                                    </tr>
                                                    <!-- Show detail modal -->

                                                <div class="modal fade" id="Delete${s.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Xác nhận xóa</h5>

                                                            </div>
                                                            <div class="modal-body">
                                                                <div style="text-align: center">Bạn có muốn xóa sản phẩm</div>
                                                                <div style="text-align: center"> Id sản phẩm: ${s.id}</div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button onclick="window.location = 'productmanagement?action=delete&pid=${s.id}&index=${index}'" type="button" class="btn btn-primary">Xóa sản phẩm</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination-arena " style="margin-left: 40%">
                                            <ul class="pagination">
                                                <li class="page-item"><a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=1" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                                <li class="page-item">
                                                    <a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-2}" class="page-link " style="${index-2<1?"display:none;":""}">${index-2}</a></li>
                                                <li class="page-item">
                                                    <a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-1}" class="page-link " style="${index-1<1?"display:none;":""}">${index-1}</a></li>
                                                <li class="page-item active">
                                                    <a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index}" class="page-link">${index}</a></li>
                                                <li class="page-item">
                                                    <a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+1}" class="page-link " style="${index+1>numberPage?"display:none;":""}" >${index+1}</a></li>
                                                <li class="page-item">
                                                    <a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+2}" class="page-link " style="${index+2>numberPage?"display:none;":""}">${index+2}</a></li>
                                                <li><a href="./productmanagement?categoryId=${requestScope.categoryId}&brandId=${requestScope.brandId}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${numberPage}" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                            </ul>
                                        </div> 
                                    </div><!-- /.box-body -->
                                </div><!-- /.box -->
                            </div>
                        </div>
                </section><!-- /.content -->
                <div class="footer-main">
                    Copyright &copy Director, 2014
                </div>
            </aside><!-- /.right-side -->
            <script>
                function changeimg${s.id}() {
                    var file = document.getElementById("img${s.id}").files[0];
                    if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
                        if (file.size / (1024 * 1024) < 5) {
                            var fileReader = new FileReader();
                            fileReader.readAsDataURL(file);
                            fileReader.onload = function () {
                                document.getElementById("image${s.id}").value = (fileReader.result);
                                document.getElementById("demoimg${s.id}").src = (fileReader.result);
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
                    document.getElementById("img${s.id}").files[0].value = ''
                    document.getElementById("img${s.id}").type = '';
                    document.getElementById("img${s.id}").type = 'file';
                }

            </script>
        </div><!-- ./wrapper -->

        <script>

            function checkInput() {
                var content = document.getElementById("feedbackContent");
                var img = document.getElementById("fbimg");
                console.log(1);
                var a = 0;
                if (content.value == "") {
                    document.getElementById("invalid").innerHTML = "Content of feedback not allow empty!"
                    a = 1;
                }
                if (content.value.length > 200) {
                    document.getElementById("invalid").innerHTML = "Content of feedback must less than 200 character!"
                    a = 1;
                }
                if (img.value == "") {
                    document.getElementById("invalid1").innerHTML = "Please choose 1 picture!"
                    a = 1;
                }
                console.log(1);
                if (a == 1) {
                    return false;
                } else {
                    return true;
                }

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

        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        
        <!-- Bootstrap -->
        <script src="./marketing/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Director App -->
        <script src="./marketing/js/Director/app.js" type="text/javascript"></script>
    </body>
</html>