<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách phản hồi</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <link href="./marketing/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.2.7/morris.min.js" integrity="sha512-nF4mXN+lVFhVGCieWAK/uWG5iPru9+/z1iz0MJbYTto85I/k7gmbTFFFNgU+xVRkF0LI2nRCK20AhxFIizNsXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="./marketing/css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body class="skin-black">
        <c:if test="${requestScope.search==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${requestScope.search!=null}">
            <c:set var = "index" scope = "page" value = "${requestScope.search}"/>
        </c:if>
        <div class="left-side sidebar-offcanvas"  style="height: 1200px;position: fixed; width: 220px; background-color: #39435c;left: 0; top:0;">
        </div>
        <jsp:include page="./header.jsp"/>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <jsp:include page="./aside.jsp"/>
            <aside class="right-side">
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel">
                                <header class="panel-heading">
                                    Danh sách phản hồi:
                                </header>
                                
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                            <form class="search-slider"
                                                  style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                                  method="get" action="FeedbackList">
                                                <div class="left-search"></div>
                                                <div class="right-search">
                                                    <select class="form-control" name="star" style="display: inline; width: 135px;">
                                                        <option value="" ${requestScope.star==""?'selected':''}>Tất cả sao</option>
                                                        <option value="1" ${requestScope.star==1?'selected':''}>1</option>
                                                        <option value="2" ${requestScope.star==2?'selected':''}>2</option>
                                                        <option value="3" ${requestScope.star==3?'selected':''}>3</option>
                                                        <option value="4" ${requestScope.star==4?'selected':''}>4</option>
                                                        <option value="5" ${requestScope.star==5?'selected':''}>5</option>
                                                    </select>
                                                    <select class="form-control" name="status" style="display: inline; width: 110px;">
                                                        <option value="" selected="">All Status</option>
                                                        <option value="1" ${requestScope.status==1?'selected':''}>Hoạt động</option>
                                                        <option value="0"${requestScope.status==0?'selected':''}>Không hoạt động</option>
                                                    </select>
                                                    <input type="text" name="search"  class="form-control"
                                                           style="width: 250px;" placeholder="Search" value="${requestScope.search}"/>
                                                    <select name="type-search" class="form-control input-sm" 
                                                            style="display: inline; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                        <option value="0" ${requestScope.type-search==0?'selected':''}>Tên sản phẩm</option>
                                                        <option value="1" ${requestScope.type-search==1?'selected':''}>Sản phẩm:</option>
                                                    </select>
                                                    <button class="btn btn-default">Đi</button>
                                                </div>
                                            </form>
                                        </div>
                                        <table class="panel-body table-responsive" id="slidetable" cellspacing="0" style="width: 100%;">
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px; border-bottom: 1px solid #ccc; text-align: center;">
                                                    <th>ID</th>
                                                    <th>Tên</th>
                                                    <th>Ảnh</th>
                                                    <th>Sản phẩm</th>
                                                    <th>Sao</th>
                                                    <th>Trạng thái</th>
                                                    <th  width="3%">Chỉnh sửa</th>
                                                    <th  width="3%">Xem</th>
                                                    <th width="3%">Chuyển đổi</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="f" items="${feedbackList}">
                                                    <tr>
                                                        <td>${f.feedback_id}</td>
                                                        <td>${f.user.fullname}</td>
                                                        <td><img src="${f.product.img}" width="100px"></td>
                                                        <td>${f.product.title}</td>
                                                        <td>${f.rated}</td>
                                                        <c:if test="${f.active}">
                                                            <td><span class="label label-success" style="font-size: 15px">Hoạt động</span></td>
                                                        </c:if>
                                                        <c:if test="${!f.active}">
                                                            <td><span class="label label-danger" style="font-size: 15px">Không hoạt động</span></td>
                                                        </c:if>
                                                        <td><a class="btn btn-primary"  data-toggle="modal" data-target="#EditModalUP${f.feedback_id}"><i class="fa-solid fa-pen-to-square" aria-hidden="true"></i></a></td>
                                                        <td><a class="btn btn-danger" data-toggle="modal" data-target="#View${f.feedback_id}"><i class="fa fa-eye" aria-hidden="true"></i></a></td>
                                                                <c:if test="${f.active==true}">
                                                            <td><a class="btn btn-warning" href="FeedbackList?action=switch&fid=${f.feedback_id}&status=0">Không hoạt động</a></td>
                                                        </c:if>
                                                        <c:if test="${f.active==false}">
                                                            <td><a class="btn btn-success" href="FeedbackList?action=switch&fid=${f.feedback_id}&status=1">Hoạt động</a></td>
                                                        </c:if>
                                                    </tr>
                                                    <!-- Show detail modal -->

                                                <div class="modal fade" id="EditModalUP${f.feedback_id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                                     data-keyboard="false">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-body">
                                                                <form action="FeedbackList">
                                                                    <input type="hidden" readonly="" name="action" value="edit">
                                                                    <div class="row">
                                                                        <div class="form-group  col-md-12">
                                                                            <span class="thong-tin-thanh-toan">
                                                                                <h5>Chỉnh sửa thông tin phản hồi</h5>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="form-group col-md-6">
                                                                            <label class="control-label">Họ và tên</label>
                                                                            <input class="form-control" type="text" readonly="" value="${f.user.fullname}">
                                                                            <input class="form-control" type="hidden" name="fid" readonly="" value="${f.feedback_id}">
                                                                        </div>
                                                                        <div class="form-group col-md-6">
                                                                            <label for="exampleSelect1" class="control-label">Email</label>
                                                                            <input class="form-control" type="text" id="stitle" value="${f.user.email}" readonly="">
                                                                            <span id="invalid1" style="color: red;"> </span>

                                                                        </div>
                                                                        <div class="form-group col-md-6">
                                                                            <label class="control-label">Số điện thoại</label>
                                                                            <input class="form-control" type="text" readonly="" value="${f.user.phone}">
                                                                        </div>
                                                                        <div class="form-group col-md-6">
                                                                            <label for="exampleSelect1" class="control-label">Sao</label>
                                                                            <input class="form-control" type="text" value="${f.rated}" readonly="">
                                                                            <span id="invalid1" style="color: red;"> </span>

                                                                        </div>
                                                                        <div class="form-group col-md-12">
                                                                            <label class="control-label">Phản hồi</label>
                                                                            <textarea readonly="" class="form-control" >${f.fb_content}</textarea>
                                                                            <span id="invalid3" style="color: red;"> </span>
                                                                        </div><div class="form-group col-md-12" style="
                                                                                   text-align: center;
                                                                                   ">
                                                                            <label class="control-label">Ảnh</label>
                                                                            <img src="${f.product.img}" alt="" width="150">
                                                                            <span id="invalid3" style="color: red;"> </span>
                                                                        </div>

                                                                        <div class="form-group col-md-12" style="
                                                                             text-align: center;
                                                                             ">
                                                                            <label class="control-label">Trạng thái</label><br>
                                                                            <input  type="radio" name="status" required="" value="1" ${f.active?"checked":""}>Hoạt động
                                                                            <input  type="radio" name="status" required="" value="0" ${f.active==false?"checked":""}> Không hoạt động
                                                                        </div>

                                                                    </div>
                                                                    <br>
                                                                    <input class="btn btn-primary" type="submit" value="Lưu ">
                                                                    <a class="btn btn-danger" data-dismiss="modal" href="#">Hủy</a>
                                                                    <br>
                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="modal fade" id="View${f.feedback_id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                                     data-keyboard="false">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-body">
                                                                <div class="row">
                                                                    <div class="form-group  col-md-12">
                                                                        <span class="thong-tin-thanh-toan">
                                                                            <h5>Xem thông tin phản hồi</h5>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="form-group col-md-6">
                                                                        <label class="control-label">Họ và tên</label>
                                                                        <input class="form-control" type="text" readonly="" value="${f.user.fullname}">
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="exampleSelect1" class="control-label">Email</label>
                                                                        <input class="form-control" type="text" value="${f.user.email}" readonly="">
                                                                        <span id="invalid1" style="color: red;"> </span>

                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label class="control-label">Số điện thoại</label>
                                                                        <input class="form-control" type="text" readonly="" value="${f.user.phone}">
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label for="exampleSelect1" class="control-label">Sao</label>
                                                                        <input class="form-control" type="text" id="stitle" value="${f.rated}" readonly="">
                                                                        <span id="invalid1" style="color: red;"> </span>

                                                                    </div>
                                                                    <div class="form-group col-md-12">
                                                                        <label class="control-label">Phản hồi</label>
                                                                        <textarea readonly="" class="form-control" >${f.fb_content}</textarea>
                                                                        <span id="invalid3" style="color: red;"> </span>
                                                                    </div><div class="form-group col-md-12" style="
                                                                               text-align: center;
                                                                               ">
                                                                        <label class="control-label">Ảnh</label>
                                                                        <img src="${f.product.img}" alt="" width="150">
                                                                        <span id="invalid3" style="color: red;"> </span>
                                                                    </div>



                                                                </div>
                                                                <div class="form-group col-md-12" style="
                                                                     text-align: center;
                                                                     ">
                                                                    <label class="control-label">Trạng thái: </label> 
                                                                    <c:if test="${f.active}">
                                                                        <span class="label label-success" style="font-size: 15px">Hoạt động</span>
                                                                    </c:if>
                                                                    <c:if test="${!f.active}">
                                                                        <span class="label label-danger" style="font-size: 15px">Không hoạt động</span>
                                                                    </c:if>

                                                                </div>

                                                                <br>
                                                                <a class="btn btn-danger" data-dismiss="modal" href="#">Đóng</a>
                                                                <br>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination-arena " style="margin-left: 40%">
                                            <ul class="pagination">
                                                <li class="page-item"><a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=1"" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                                <li class="page-item">
                                                    <a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-2}"" class="page-link " style="${index-2<1?"display:none;":""}">${index-2}</a></li>
                                                <li class="page-item">
                                                    <a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index-1}"" class="page-link " style="${index-1<1?"display:none;":""}">${index-1}</a></li>
                                                <li class="page-item active">
                                                    <a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index}"" class="page-link">${index}</a></li>
                                                <li class="page-item">
                                                    <a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+1}"" class="page-link " style="${index+1>numberPage?"display:none;":""}" >${index+1}</a></li>
                                                <li class="page-item">
                                                    <a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${index+2}"" class="page-link " style="${index+2>numberPage?"display:none;":""}">${index+2}</a></li>
                                                <li><a href="./FeedbackList?star=${requestScope.star}&status=${requestScope.status}&search=${requestScope.search}&type-search=${requestScope.type-search}&index=${numberPage}"" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
                                            </ul>
                                        </div> 
                                    </div><!-- /.box-body -->
                                </div><!-- /.box -->
                            </div>
                        </div>

                </section><!-- /.content -->
                <div class="footer-main">
                    Copyright © 2024. Thiết kể bởi nhóm 3 lớp DE170740.s
                </div>
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

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
        <!-- Bootstrap -->
        <script src="./marketing/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Director App -->
        <script src="./marketing/js/Director/app.js" type="text/javascript"></script>
    </body>
</html>


