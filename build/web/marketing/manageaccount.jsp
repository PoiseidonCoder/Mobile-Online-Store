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
                                    Danh sách tài khoản
                                </header>
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
<!--                                        <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                            <form class="search-slider"
                                                  style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                                  method="get" action="sliderlist">
                                                <div class="left-search"></div>
                                                <div class="right-search">

                                                    <input type="text" name="search" class="form-control" value="${param['search']}"
                                                           style="width: 250px;" placeholder="Search" />
                                                    <select class="form-control input-sm" name="type-search"
                                                            style="display: inline; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                    </select>
                                                    <button class="btn btn-default">Đi</button>
                                                </div>
                                            </form>
                                        </div>-->
                                        <table class="panel-body table-responsive" id="slidetable" cellspacing="0" style="width: 100%;" id="slidetable">
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px; border-bottom: 1px solid #ccc; text-align: center;">
                                                    <th>ID</th>
                                                    <th>Họ và tên</th>
                                                    <th>Email</th>
                                                    <th>Giới tính</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Avatar</th>
                                                    <th  width="3%">Xóa</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach var="account" items="${requestScope.userList}">
                                                    <tr>
                                                        <td>${account.user_id}</td>
                                                        <td data-toggle="modal" >${account.fullname}</td>
                                                        <td data-toggle="modal" >${account.email}</td>
                                                        <td data-toggle="modal" >${account.gender}</td>
                                                        <td data-toggle="modal" >${account.phone}</td>
                                                        <td data-toggle="modal" >${account.address}</td>
                                                        <td><a class="btn btn-danger" data-toggle="modal" data-target="#Delete${account.user_id}"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                                                    </tr>
                                                <div class="modal fade" id="Delete${account.user_id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Xác nhận xóa account.</h5>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div style="text-align: center">Bạn có muốn xóa account?</div>
                                                                <div style="text-align: center">Account Id: ${account.user_id}</div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                                <button onclick="window.location = 'ManageAccount?action=delete&user_id=${account.user_id}'" type="button" class="btn btn-primary">Xóa account</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> 


                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination-arena " style="margin-left: 40%">
                                            <ul class="pagination">
                                                <li class="page-item"><a href="./ManageAccount?index=1" class="page-link"><i class="fa fa-angle-left" aria-hidden="true"></i></a></li>
                                                <li class="page-item">
                                                    <a href="./ManageAccount?index=${index-2}" class="page-link " style="${index-2<1?"display:none;":""}">${index-2}</a></li>
                                                <li class="page-item">
                                                    <a href="./ManageAccount?index=${index-1}" class="page-link " style="${index-1<1?"display:none;":""}">${index-1}</a></li>
                                                <li class="page-item active">
                                                    <a href="./ManageAccount?index=${index}" class="page-link">${index}</a></li>
                                                <li class="page-item">
                                                    <a href="./ManageAccount?index=${index+1}" class="page-link " style="${index+1>numberPage?"display:none;":""}" >${index+1}</a></li>
                                                <li class="page-item">
                                                    <a href="./ManageAccount?index=${index+2}" class="page-link " style="${index+2>numberPage?"display:none;":""}">${index+2}</a></li>
                                                <li><a href="./ManageAccount?index=${numberPage}" class="page-link"><i class="fa fa-angle-right" aria-hidden="true"></i></a></li>
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