<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách slider</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <link href="./marketing/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.2.7/morris.min.js" integrity="sha512-nF4mXN+lVFhVGCieWAK/uWG5iPru9+/z1iz0MJbYTto85I/k7gmbTFFFNgU+xVRkF0LI2nRCK20AhxFIizNsXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="./marketing/css/style.css" rel="stylesheet" type="text/css" />

        <style type="text/css">
            td{
                padding: 5px;
            }
            th{
                padding: 5px;
            }
        </style>
    </head>
    <body class="skin-black">
        <c:if test="${requestScope.index==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${requestScope.index!=null}">
            <c:set var = "index" scope = "page" value = "${requestScope.index}"/>
        </c:if>
        <div class="left-side sidebar-offcanvas"  style="height: 1200px;position: fixed; width: 220px; background-color: #39435c;left: 0; top:0;">
        </div>
        <jsp:include page="./header.jsp"/>

        <div class="wrapper row-offcanvas row-offcanvas-left">
            <jsp:include page="./aside.jsp"/>
            <aside class="right-side">

                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel">
                                <header class="panel-heading">
                                    Danh sách slide
                                </header>
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                            <form class="search-slider"
                                                  style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                                  method="get" action="sliderlist">
                                                <div class="left-search"></div>
                                                <div class="right-search">
                                                    <label class="form-control"
                                                           style="border:none;display: inline;">Trạng thái</label>
                                                    <select class="form-control" name="status" style="display: inline; width: 100px;">
                                                        <option value="" >Tất cả</option>
                                                        <option value="0" ${requestScope.status==0?'selected':''}>Không hoạt động</option>
                                                        <option value="1" ${requestScope.status==1?'selected':''}>Hoạt động</option>
                                                    </select>
                                                    <input type="text" name="search" class="form-control" value="${requestScope.search}"
                                                           style="width: 250px;" placeholder="Search" />
                                                    <select class="form-control input-sm" name="type-search"
                                                            style="display: inline; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                        <option value="0" ${requestScope.type-search==0?'selected':''}>Tiêu đề</option>
                                                        <option value="1" ${requestScope.type-search==1?'selected':''}>Liên kết</option>
                                                    </select>
                                                    <button class="btn btn-default">Đi</button>
                                                </div>
                                            </form>
                                        </div>
                                        <table class="panel-body table-responsive" id="slidetable" cellspacing="0" style="width: 100%;" id="slidetable">
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px; border-bottom: 1px solid #ccc; text-align: center;">
                                                    <th>ID</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Ảnh</th>
                                                    <th>Liên kết</th>
                                                    <th>Trạng thái</th>
                                                    <th  width="3%">Sửa</th>
                                                    <th  width="3%">Xóa</th>
                                                    <th width="3%">Chuyển đổi</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach var="s" items="${slist}">
                                                    <tr>
                                                        <td>${s.silde_id}</td>
                                                        <td data-toggle="modal" style="cursor: pointer;">${s.title}</td>
                                                        <td><image  src="${s.image}" width="200px"></td>
                                                        <td>${s.backlink}</td>
                                                        <c:if test="${s.active}">
                                                            <td><span class="label label-success" style="font-size: 15px">Hoạt động</span></td>
                                                        </c:if>
                                                        <c:if test="${!s.active}">
                                                            <td><span class="label label-danger" style="font-size: 15px">Không hoạt động</span></td>
                                                        </c:if>
                                                        <td><a class="btn btn-primary"  data-toggle="modal" data-target="#EditModalUP${s.silde_id}"><i class="fa fa-pencil-square" aria-hidden="true"></i></a></td>
                                                        <td><a class="btn btn-danger" data-toggle="modal" data-target="#Delete${s.silde_id}"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                                                                <c:if test="${s.active}">
                                                            <td><a class="btn btn-warning" href="sliderlist?action=switch&sid=${s.silde_id}&sstatus=0">Không hoạt động</a></td>
                                                        </c:if>
                                                        <c:if test="${!s.active}">
                                                            <td><a class="btn btn-success" href="sliderlist?action=switch&sid=${s.silde_id}&sstatus=1">Hoạt động</a></td>
                                                        </c:if>
                                                    </tr>

                                                <div class="modal fade" id="Delete${s.silde_id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Xác nhận xóa slide.</h5>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div style="text-align: center">Bạn có muốn xóa Slide?</div>
                                                                <div style="text-align: center">Slide Id: ${s.silde_id}</div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                                <button onclick="window.location = 'sliderlist?action=delete&sid=${s.silde_id}'" type="button" class="btn btn-primary">Xóa slide</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 

                                                <!-- edit modal -->
                                                <div class="modal fade" id="EditModalUP${s.silde_id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                                     data-keyboard="false">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-body">
                                                                <form action="sliderlist?action=edit" method="post" onsubmit="return checkInput${s.silde_id}();">
                                                                    <div class="row">
                                                                        <div class="form-group  col-md-12">
                                                                            <span class="thong-tin-thanh-toan">
                                                                                <h5>Chỉnh sửa thông tin thiết kế</h5>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="form-group col-md-6">
                                                                            <label class="control-label">ID</label>
                                                                            <input class="form-control" type="text" readonly name="slideid" value="${s.silde_id}">
                                                                        </div>
                                                                        <div class="form-group col-md-6">
                                                                            <label for="exampleSelect1" class="control-label">Tiêu đề</label>
                                                                            <input class="form-control" type="text" id="stitle${s.silde_id}" maxlength="50" name="slidetitle" required value="${s.title}">
                                                                            <span id="invalid1${s.silde_id}" style="color: red;"> </span>

                                                                        </div>
                                                                        <div class="form-group col-md-12">
                                                                            <label class="control-label">Liên kết:</label>
                                                                            <input class="form-control" type="text" id="backlink${s.silde_id}" maxlength="250" name="slidebacklink"  required value="${s.backlink}">
                                                                            <span id="invalid2${s.silde_id}" style="color: red;"> </span>

                                                                        </div>
                                                                        <div class="form-group col-md-12">
                                                                            <label class="control-label">Mieu tả</label>
                                                                            <input class="form-control" type="text" id="sdesc${s.silde_id}" maxlength="250"  name="slidedescript" required value="${s.description}">
                                                                            <span id="invalid3${s.silde_id}" style="color: red;"> </span>
                                                                        </div>
                                                                        <div class="form-group col-md-12">
                                                                            <label class="control-label">Trạng thái</label><br>
                                                                            <input  type="radio" name="slidestatus" required value="1" ${s.active?'Checked':''}>Hoạt động
                                                                            <input  type="radio" name="slidestatus" required value="0" ${!s.active?'Checked':''}> Không hoạt động
                                                                        </div>
                                                                        <div class="form-group col-md-10">
                                                                            <label class="control-label" >Ảnh</label>

                                                                            <input class="form-control" id="img${s.silde_id}" onchange="changeimg${s.silde_id}()" name="image" value="${s.image}" type="file" >
                                                                            <input name="slideimage" id="slideimage${s.silde_id}" value="${s.image}" type="hidden" >
                                                                            <image  src="${s.image}" id="demoimg${s.silde_id}" style="margin-top: 5px;" width="100%">
                                                                        </div>
                                                                    </div>
                                                                    <BR>
                                                                    <button class="btn btn-primary" type="submit">Lưu</button>
                                                                    <a class="btn btn-danger" data-dismiss="modal" href="#">Hủy</a>
                                                                    <BR>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <script>
                                                    function changeimg${s.silde_id}() {
                                                        var file = document.getElementById("img${s.silde_id}").files[0];
                                                        if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
                                                            if (file.size / (1024 * 1024) < 5) {
                                                                var fileReader = new FileReader();
                                                                fileReader.readAsDataURL(file);
                                                                fileReader.onload = function () {
                                                                    document.getElementById("slideimage${s.silde_id}").value = (fileReader.result);
                                                                    document.getElementById("demoimg${s.silde_id}").src = (fileReader.result);
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
                                                        document.getElementById("img${s.silde_id}").files[0].value = ''
                                                        document.getElementById("img${s.silde_id}").type = '';
                                                        document.getElementById("img${s.silde_id}").type = 'file';
                                                    }
                                                    function checkInput${s.silde_id}() {
                                                        var content = document.getElementById("sdesc${s.silde_id}");
                                                        console.log(1);
                                                        var a = 0;
                                                        if (content.value.length > 300) {
                                                            document.getElementById("invalid3${s.silde_id}").innerHTML = "Description must less than 300 character!"
                                                            a = 1;
                                                        } else {
                                                            document.getElementById("invalid3${s.silde_id}").innerHTML = ""
                                                        }
                                                        if (document.getElementById("stitle${s.silde_id}").value.length > 100) {
                                                            document.getElementById("invalid1${s.silde_id}").innerHTML = "Title must less than 100 character!"
                                                            a = 1;
                                                        } else {
                                                            document.getElementById("invalid1${s.silde_id}").innerHTML = ""
                                                        }
                                                        if (document.getElementById("backlink${s.silde_id}").value.length > 200) {
                                                            document.getElementById("invalid2${s.silde_id}").innerHTML = "Backlink must less than 200 character!"
                                                            a = 1;
                                                        } else {
                                                            document.getElementById("invalid2${s.silde_id}").innerHTML = ""

                                                        }
                                                        console.log(1);
                                                        if (a == 1) {
                                                            return false;
                                                        } else {
                                                            return true;
                                                        }
                                                    }
                                                </script>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination-arena " style="margin-left: 40%">
                                            <ul class="pagination">
                                                <li class="page-item"><a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=1" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                                <li class="page-item">
                                                    <a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-2}" class="page-link " style="${index-2<1?"display:none;":""}">${index-2}</a></li>
                                                <li class="page-item">
                                                    <a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-1}" class="page-link " style="${index-1<1?"display:none;":""}">${index-1}</a></li>
                                                <li class="page-item active">
                                                    <a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index}" class="page-link">${index}</a></li>
                                                <li class="page-item">
                                                    <a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+1}" class="page-link " style="${index+1>numberPage?"display:none;":""}" >${index+1}</a></li>
                                                <li class="page-item">
                                                    <a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+2}" class="page-link " style="${index+2>numberPage?"display:none;":""}">${index+2}</a></li>
                                                <li><a href="./sliderlist?status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${numberPage}" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                            </ul>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                </section>
                <div class="footer-main">
                    Copyright © 2024. Thiết kể bởi nhóm 3 lớp DE170740.
                </div>
            </aside>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
        <script>
                                                    $(document).ready(function () {
                                                        $("#slidetable").DataTable({bFilter: false, bInfo: false, paging: false});
                                                    });
        </script>
        <script>

        </script>
        <script src="./marketing/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="./marketing/js/Director/app.js" type="text/javascript"></script>
    </body>
</html>