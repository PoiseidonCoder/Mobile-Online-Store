<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="left-side sidebar-offcanvas" id="left-aside" style="height: 100%;">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="./marketing/img/26115.jpg" class="img-circle" alt="User Image" />
            </div>
            <div class="pull-left info">
                <p>Xin chào, ${account.fullname}</p>

                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="">
                <a href="marketingdasboard">
                    <i class="fa fa-dashboard"></i> <span>Tổng quan</span>
                </a>
            </li>
            <li>
                <a href="sliderlist">
                    <i class="fa-solid fa-chart-bar"></i> <span>Quản lý thanh trượt</span>
                </a>
            </li>

            <li>
                <a href="productmanagement">
                    <i class="fa-brands fa-product-hunt"></i></i> <span>Quản lý sản phẩm</span>
                </a>
            </li>

            <li>
                <a href="FeedbackList">
                    <i class="fa-solid fa-comment"></i><span>Danh sách phản hồi</span>
                </a>
            </li>
            <li>
                <a href="ManageAccount">
                    <i class="fa-solid fa-user"></i> <span>Quản lý người dùng</span>
                </a>
            </li>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>


