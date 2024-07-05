<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <link href="./marketing/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.2.7/morris.min.js" integrity="sha512-nF4mXN+lVFhVGCieWAK/uWG5iPru9+/z1iz0MJbYTto85I/k7gmbTFFFNgU+xVRkF0LI2nRCK20AhxFIizNsXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="./marketing/css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body class="skin-black">
        <jsp:include page="./header.jsp"/>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <jsp:include page="./aside.jsp"/>
            <aside class="right-side">
                <section class="content">
                    <div class="row" style="margin-bottom:5px;">
                        <div class="col-md-3">
                            <div class="sm-st clearfix">
                                <span class="sm-st-icon st-red"><i class="fa fa-check-square-o"></i></span>
                                <div class="sm-st-info">
                                    <span>${numOrder}</span>
                                    Tổng đơn hàng
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="sm-st clearfix">
                                <span class="sm-st-icon st-violet"><i class="fa fa-envelope-o"></i></span>
                                <div class="sm-st-info">
                                    <span>${numFeedback}</span>
                                    Tổng phản hồi
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="sm-st clearfix">
                                <span class="sm-st-icon st-blue"><i class="fa fa-user"></i></span>
                                <div class="sm-st-info">
                                    <span>${numUser}</span>
                                    Tổng người dùng
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="sm-st clearfix">
                                <span class="sm-st-icon st-green"><i class="fa fa-paperclip"></i></span>
                                <div class="sm-st-info">
                                    <span>${numProduct}</span>
                                    Tổng sản phẩm
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-md-8">
                            <section class="panel" style="padding-right: 15px;">
                                <header class="panel-heading">
                                    Biểu đồ xu hướng khách hàng trong 7 ngày qua
                                </header>
                                <div class="panel-body">
                                    <canvas id="linechart" width="500" height="320"></canvas>
                                </div>
                            </section>

                        </div>
                        <div class="col-lg-4">
                            <div class="stat" >
                                <div class="stat-icon" style="color:#AC75F0">
                                    <i class="fa fa-dollar fa-3x stat-elem"></i>
                                </div>
                                <h5 class="stat-info" ><fmt:formatNumber type="number" minFractionDigits  = "2" value="${profit}"/>$ Lợi nhuận</h5>
                            </div><br >
                            <div class="panel">
                                <header class="panel-heading">
                                    Phần trăm trạng thái đơn hàng
                                </header>
                                <div class="panel-body no-padding">
                                    <table class="table table-condensed">
                                        <tr>
                                            <th style="width: 55px">Trạng thái</th>
                                            <th >Tiến triển</th>
                                            <th style="width: 50px">Số lượng</th>
                                        </tr>
                                        <c:forEach var="s" items="${allOrderStatus}">
                                            <tr>
                                                <td>${s.status}</td>
                                                <td>
                                                    <div class="progress xs">
                                                        <c:if test="${s.status=='Đang chờ'}"> <div class="progress-bar progress-bar-warning" style="width: ${s.numberOrder/numOrder*100}%"></div> </c:if>
                                                        <c:if test="${s.status=='Đang chuyển hàng'}"> <div class="progress-bar progress-bar-blue" style="width: ${s.numberOrder/numOrder*100}%"></div> </c:if>
                                                        <c:if test="${s.status=='Đã nhận'}"> <div class="progress-bar progress-bar-success" style="width: ${s.numberOrder/numOrder*100}%"></div> </c:if>
                                                        <c:if test="${s.status=='Đã hủy'}"> <div class="progress-bar progress-bar-danger" style="width: ${s.numberOrder/numOrder*100}%"></div> </c:if>
                                                        </div>
                                                    </td>
                                                <c:if test="${s.status=='Đang chờ'}"> <td><span class="badge bg-yellow">${s.numberOrder} Đơn</span></td> </c:if>
                                                <c:if test="${s.status=='Đang chuyển hàng'}"> <td><span class="badge bg-blue">${s.numberOrder} Đơn</span></td> </c:if>
                                                <c:if test="${s.status=='Đã nhận'}"> <td><span class="badge bg-green">${s.numberOrder} Đơn</span></td> </c:if>
                                                <c:if test="${s.status=='Đã hủy'}"> <td><span class="badge bg-red">${s.numberOrder} Đơn</span></td></c:if>
                                                </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-md-6">
                                <section class="panel" style="padding-right: 15px;">
                                    <header class="panel-heading">
                                        Biểu đồ sản phẩm mới trong 7 ngày qua
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="linechart1" width="500" height="320"></canvas>
                                    </div>
                                </section>
                            </div>
                            <div class="col-md-6">
                                <section class="panel" style="padding-right: 15px;">
                                    <header class="panel-heading">
                                        Biểu đồ phản hồi mới trong 7 ngày qua
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="linechart2" width="500" height="320"></canvas>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-8">
                                <section class="panel">
                                    <header class="panel-heading">
                                        Top 10 đơn hàng mới nhất
                                    </header>
                                    <div class="panel-body table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên khách hàng</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Tổng</th>
                                                    <th>Ngày đặt hàng</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <c:forEach var="o" items="${OrderList}">
                                                    <tr>
                                                        <td>${o.order_id}</td>
                                                        <td>${o.fullname}</td>
                                                        <td>${o.address}</td>
                                                        <td>${o.phone}</td>
                                                        <td>${o.total}$</td>
                                                        <td>${o.order_date}</td>
                                                        <c:if test="${o.status=='Đang chờ'}"> <td><span class="badge bg-yellow">${o.status}</span></td> </c:if>
                                                        <c:if test="${o.status=='Đang chuyển hàng'}"> <td><span class="badge bg-blue">${o.status}</span></td> </c:if>
                                                        <c:if test="${o.status=='Đã nhận'}"> <td><span class="badge bg-green">${o.status}</span></td> </c:if>
                                                        <c:if test="${o.status=='Đã hủy'}"> <td><span class="badge bg-red">${o.status}</span></td></c:if>
                                                        </tr>
                                                </c:forEach> 
                                            </tbody>
                                        </table>
                                    </div>
                                </section>
                            </div>
                            <div class="col-md-4">
                                <div class="panel">
                                    <header class="panel-heading">
                                        Sản phẩm bán chạy nhất
                                    </header>
                                    <table class="table table-bordered">
                                        <tr>
                                            <th style="width: 10px">#</th>
                                            <th>Tên sản phẩm</th>
                                            <th style="width: 100px">Số lượng đã bán</th>
                                        </tr>
                                        <c:forEach var="p" items="${topSelling}">
                                            <tr>
                                                <td>#.</td>
                                                <td>${p.title}</td>
                                                <td style="width: 100px">${p.quantity}</td>
                                            </tr>
                                        </c:forEach>                      

                                    </table>
                                </div>
                            </div>
                        </div>
                        
                </section>
                <div class="footer-main">
                    Copyright © 2024. Thiết kể bởi nhóm 3 lớp DE170740.
                </div>
            </aside>


        </div>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="./marketing/js/jquery.min.js" type="text/javascript"></script>
        <script src="./marketing/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <script src="./marketing/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="./marketing/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <script src="./marketing/js/plugins/chart.js" type="text/javascript"></script>
        <script src="./marketing/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
        <script src="./marketing/js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>
        <script src="./marketing/js/Director/app.js" type="text/javascript"></script>
        <script src="./marketing/js/Director/dashboard.js" type="text/javascript"></script>

        <script type="text/javascript">
            $('input').on('ifChecked', function (event) {
                $(this).parents('li').addClass("task-done");
                console.log('ok');
            });
            $('input').on('ifUnchecked', function (event) {
                $(this).parents('li').removeClass("task-done");
                console.log('not');
            });

        </script>
        <script>
            $('#noti-box').slimScroll({
                height: '400px',
                size: '5px',
                BorderRadius: '5px'
            });

            $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck({
                checkboxClass: 'icheckbox_flat-grey',
                radioClass: 'iradio_flat-grey'
            });
        </script>
        <script type="text/javascript">
            $(function () {
                "use strict";
                var date = new Date();
                let weeks = [];
                for (let i = 7; i > 0; i--) {
                    date.setDate(date.getDate() - i);
                    weeks.push(date.toString().slice(4, 10));
                    date = new Date();
                }
                let dataorder = [];
            <c:forEach var="p" items="${numberOrderinLast7day}">
                dataorder.push(${p});
            </c:forEach>
                var data = {
                    labels: weeks,
                    datasets: [
                        {
                            label: "My First dataset",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: dataorder
                        },
                    ]
                };
                new Chart(document.getElementById("linechart").getContext("2d")).Line(data, {
                    responsive: true,
                    maintainAspectRatio: false,
                });

            });
        </script>
        <script type="text/javascript">
            $(function () {
                "use strict";
                var date = new Date();
                let weeks = [];
                for (let i = 7; i > 0; i--) {
                    date.setDate(date.getDate() - i);
                    weeks.push(date.toString().slice(4, 10));
                    date = new Date();
                }
                let dataorder = [];
            <c:forEach var="p" items="${getTotalProductLast7day}">
                dataorder.push(${p});
            </c:forEach>
                var data = {
                    labels: weeks,
                    datasets: [
                        {
                            label: "My First dataset",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: dataorder
                        },
                    ]
                };
                new Chart(document.getElementById("linechart1").getContext("2d")).Line(data, {
                    responsive: true,
                    maintainAspectRatio: false,
                });

            });
        </script>
        <script type="text/javascript">
            $(function () {
                "use strict";
                var date = new Date();
                let weeks = [];
                for (let i = 7; i > 0; i--) {
                    date.setDate(date.getDate() - i);
                    weeks.push(date.toString().slice(4, 10));
                    date = new Date();
                }
                let dataorder = [];
            <c:forEach var="p" items="${getTotalFeedbackLast7day}">
                dataorder.push(${p});
            </c:forEach>
                var data = {
                    labels: weeks,
                    datasets: [
                        {
                            label: "My First dataset",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: dataorder
                        },
                    ]
                };
                new Chart(document.getElementById("linechart2").getContext("2d")).Line(data, {
                    responsive: true,
                    maintainAspectRatio: false,
                });

            });
        </script>
        <script type="text/javascript">
            $(function () {
                "use strict";
                var date = new Date();
                let weeks = [];
                for (let i = 7; i > 0; i--) {
                    date.setDate(date.getDate() - i);
                    weeks.push(date.toString().slice(4, 10));
                    date = new Date();
                }
                let dataorder = [];
            <c:forEach var="p" items="${getTotalPostLast7day}">
                dataorder.push(${p});
            </c:forEach>
                var data = {
                    labels: weeks,
                    datasets: [
                        {
                            label: "My First dataset",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: dataorder
                        },
                    ]
                };
                new Chart(document.getElementById("linechart3").getContext("2d")).Line(data, {
                    responsive: true,
                    maintainAspectRatio: false,
                });

            });
        </script>
    </body>
</html>