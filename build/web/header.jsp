<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./css/header.css"/>
</style>
<body>
    <div class="modal-login" ${activeLogin}>
        <div onclick="loginOutClick()" class="modal__overlay"></div>
        <div class="modal__body-login">
            <div class="modal__inner">
                <div class="auth-form">
                    <div class="auth-form__header">
                        <h3 class="au-form__heading">Đăng nhập</h3>
                        <a onclick="registerClick()" class="au-form__switch-btn">Đăng ký</a>
                    </div>
                    <form>
                        <div class="auth-form__form">
                            <input type="hidden" id="urlcurrent" name="pageCurrent">
                            <div class="auth-form__group">
                                <input id="emailid" required type="email" class="auth-form__input" placeholder="Email">
                            </div>
                            <div class="auth-form__group">
                                <input id="passwordid" required type="password" class="auth-form__input" placeholder="Password">
                            </div>
                        </div>
                        <div class="auth-form__forgotgroup">
                            <a href="forgotpassword" class="auth-form__forgot">Quên mật khẩu</a>
                        </div>
                        <div class="auth-form__msg"><span id="msg">${msg}</span></div>
                        <div class="auth-form__controls">
                            <input onclick="btnLogin()" type="button" style="width: 100%" class="auth-form__button" value="Login">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-register">
        <div onclick="registerOutClick()" class="modal__overlay"></div>
        <div class="modal__body">
            <div class="modal__inner">
                <div class="auth-form">
                    <div class="auth-form__header">
                        <a onclick="loginClick()" class="au-form__switch-btn">Đăng nhập</a>
                        <h3 class="au-form__heading">Đăng ký</h3>
                    </div>
                    <form>
                        <div class="auth-form__form">
                            <input type="hidden" id="urlcurrentRegister" name="pageCurrent">
                            <div class="auth-form__group">
                                <input id="fullname" required type="text" class="auth-form__input" placeholder="Full name">
                            </div>
                            <div class="auth-form__group">
                                <input id="phone" required type="text" class="auth-form__input" placeholder="Mobile number">
                            </div>
                            <div class="auth-form__group">
                                <input id="address" required type="text" class="auth-form__input" placeholder="Address">
                            </div>
                            <div class="auth-form__radio">
                                <span class="auth-form__input"><label>Nan<input id="male" type="radio" value="1" checked="" name="gender" required="required"></label></span>
                                <span class="auth-form__input"><label>Nữ<input id="female" type="radio" value="0" name="gender"></label></span>
                            </div>
                            <div class="auth-form__group">
                                <input  id="email" required type="email" class="auth-form__input" placeholder="Email">
                            </div>
                            <div class="auth-form__container-pass">
                                <div class="auth-form__group">
                                    <input id="password"  id="password" required type="password" class="auth-form__input" placeholder="Password">
                                </div>
                                <div class="auth-form__group">
                                    <input id="repassword"  id="repassword" required type="password" class="auth-form__input" placeholder="Re-Password">
                                </div>
                            </div>
                        </div>
                        <div class="auth-form__msg"><span id="msgregister"></div>
                        <div class="auth-form__controls">
                            <input onclick="btnRegister()" type="button" class="auth-form__button" style="width: 100%" value="Register">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="header-top">
        <div class="container">
            <div class="top-bar left">
                <ul>
                    <li><a href="#"><i class="fa fa-envelope" aria-hidden="true"></i> baothu81gl@gmail.com</a></li>
                    <li><a href="#">9 Điểm chứ không cần nhiều</a></li>
                </ul>
            </div>
            <div class="top-bar right">
                <ul>
                    <li style="display: none"><a href="#" class="login-link"><i class="fa fa-tasks "></i> Quản lý trang</a></li>
                    <li style="display: none"><a href="#" class="login-link"><i class="fa fa-user"></i></i> Hồ sơ</a></li>
                    <li <c:if test="${account!=null}">
                            style="display: none"
                        </c:if>><a  onclick="loginClick()" class="login-link">Đăng nhập</a></li>
                    <li <c:if test="${account!=null}">
                            style="display: none"
                        </c:if>><a  onclick="registerClick()" class="register-link">Đăng ký</a></li>
                    <li <c:if test="${account==null}">
                            style="display: none"
                        </c:if>>
                        <div class="dropdown">
                            <button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" style="padding-top: 0px" aria-haspopup="true" aria-expanded="false">
                                ${account.fullname}
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#myModal-2" data-toggle="modal">Hồ sơ</a>
                                <a class="dropdown-item" href="#changePass" data-toggle="modal">Thay đổi mật khẩu</a>
                                <c:if test="${account.role==1}">
                                    <a class="dropdown-item" href="marketingdasboard">Trang quản lý</a>
                                </c:if>
                                <c:if test="${account.role!=1}">
                                    <a class="dropdown-item" href="AddProduct">Thêm sản phẩm</a>
                                </c:if>
                                <a class="dropdown-item" href="MyOrder">Đơn mua</a>
                                <a class="dropdown-item" href="productmanagement">Đơn bán</a>
                                <a class="dropdown-item" href="logout">Đăng xuất</a>
                            </div>

                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="header-bottom">
        <div class="container">
            <div class="main-content">
                <div class="logo">
                    <img onclick="window.location = 'Home'" src="images/hinhdep.png" alt="Error_logo" width="auto" height="120">
                </div>
                <div class="main-menu">
                    <ul>
                        <li><a href="Home" ${requestScope.pageCurrent ? "Style='background-color: orange; padding:10px 10px;border-radius:5px;'":""} >Trang chủ</a></li>
                        <li><a href="ProductList" >Sản phẩm</a></li>
                        <c:if test="${account!=null}">
                            <li><a href="MyOrder">Đơn mua </a></li>
                          <li><a class="dropdown-item" href="productmanagement">Đơn bán</a></li>
                        </c:if>
                    </ul>
                    <div class="search">
                        <form action="ProductList?index=1" class="form-search" method="get">
                            <input type="text" name="search" class="input-text" value="${requestScope.search}" placeholder="Search product here...">
                            <button type="submit" class="btn-submit"><i class="fa fa-search"></i></button>
                        </form>
                    </div>
                </div>
                <div class="cart">
                    <a href="CartView">
                        <i class="fa fa-shopping-bag"></i></a>
                </div>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal-2" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Hồ sơ</h4>
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <div class="profile-pic">
                                    <img id="myAvatar" style="border-radius: 15px;" src="${account.avatar}" width="120" >
                                    <input id="fileAvatar" onchange="changeAvatar()" type="file" accept=".jpg, .jpeg, .png">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-lg-4 col-sm-4 control-label">Email<span style="color:#ff0000">(*)</span></label>
                            <div class="col-lg-12">
                                <input type="text" class="form-control" id="emailaccount" readonly value="${account.email}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newFullname" class="col-lg-4 col-sm-4 control-label">Họ và tên <span style="color:#ff0000">(*)</span></label>
                            <div class="col-lg-12">
                                <input id="fullnamepf" type="text" class="form-control" placeholder="Fullname" value="${account.fullname}">
                                <p class="help-block" style="color: red" id="errorFullName"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label style="
                                   margin-right: 50px;
                                   " for="newTitle" class="col-lg-3 col-sm-3 control-label">Giới tính<span style="color:#ff0000"> (*)</span></label>
                            <label style="margin-right: 15px"> Nam
                                <input id="malepf" type="radio" name="genderpf" value="male" ${account.gender==true?"checked":""}/>
                            </label>
                            <label>Nữ<input id="femalepf" type="radio" name="genderpf" value="female" ${account.gender==false  ?"checked":""}/>
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="newMobile" class="col-lg-4 col-sm-4 control-label">Số điện thoại<span style="color:#ff0000"> (*)</span></label>
                            <div class="col-lg-12">
                                <input id="phonepf" type="text" class="form-control" placeholder="Mobile" value="${account.phone}">
                                <p class="help-block" style="color: red" id="errorPhone"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newAddress" class="col-lg-4 col-sm-4 control-label">Địa chỉ<span style="color:#ff0000">(*)</span></label>
                            <div class="col-lg-12">
                                <input id="addresspf" type="text" class="form-control" placeholder="Address" value="${account.address}">
                                <p class="help-block" style="color: red" id="errorAddress"></p>
                            </div>
                        </div>
                        <span style="color: red;
                              font-weight: 500;" id="msgProfile">
                        </span>
                        <div class="form-group">
                            <div class="col-lg-offset-4 col-lg-6">
                                <button type="button" class="btn btn-danger get" onclick="btnChangeProfile()" id="saveC">Lưu thay đổi</button>
                            </div>
                        </div>

                    </form>

                </div>

            </div>
        </div>
    </div>

    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="changePass" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Lưu thay đổi</h4>
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                </div>
                <div class="modal-body">

                    <form>
                        <div class="form-group">
                            <label>Mật khẩu cũ<span style="color:#ff0000"> (*)</span></label>
                            <div class="col-lg-12">
                                <input type="password" required="" id="oldpasswordcp" name="oldpassword" class="form-control" placeholder="Old password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Mậu khẩu mới<span style="color:#ff0000"> (*)</span></label>
                            <div class="col-lg-12">
                                <input type="password" required="" id="passwordcp" name="newpassword" class="form-control" placeholder="New password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Xác nhận mật khẩu<span style="color:#ff0000"> (*)</span></label>
                            <div class="col-lg-12">
                                <input type="password" required="" id="cfpasswordcp" name="confirmpassword" class="form-control" placeholder="Confirm Password">
                            </div>
                        </div>
                        <span style="color: red;
                              font-weight: 500;" id="msgChangePass">
                        </span>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-12">
                                <input onclick="btnChangePass()" type="button" class="btn btn-danger" value="Save Changes">
                            </div>
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </div>


</body>
<script>

    var registerForm = document.getElementsByClassName('modal-register')[0];
    var loginForm = document.getElementsByClassName('modal-login')[0];
    function registerClick() {
        registerForm.style.display = 'flex';
        loginForm.style.display = 'none';
    }
    function registerOutClick() {
        registerForm.style.display = 'none';

    }
    function loginClick() {
        loginForm.style.display = 'flex';
        registerForm.style.display = 'none';
    }
    function loginOutClick() {
        loginForm.style.display = 'none';
    }

    function btnLogin() {
        axios.get('login', {
            params: {
                email: document.getElementById("emailid").value,
                password: document.getElementById("passwordid").value
            }
        }).then((response) => {
            if (response.data == "success") {
                window.location.assign("Home");
            } else {
                document.getElementById("msg").innerHTML = response.data;
            }
        })
    }

    function btnChangePass() {
        axios.get('changepassword', {
            params: {
                oldPassword: document.getElementById("oldpasswordcp").value,
                password: document.getElementById("passwordcp").value,
                rePassword: document.getElementById("cfpasswordcp").value,
            }
        }).then((response) => {
            document.getElementById("msgChangePass").innerHTML = response.data;
        })
    }

    function btnRegister() {
        axios.get('register', {
            params: {
                fullname: document.getElementById("fullname").value,
                phone: document.getElementById("phone").value,
                address: document.getElementById("address").value,
                male: document.getElementById("male").checked,
                female: document.getElementById("female").checked,
                email: document.getElementById("email").value,
                password: document.getElementById("password").value,
                repassword: document.getElementById("repassword").value,

            }
        }).then((response) => {
            document.getElementById("msgregister").innerHTML = response.data;
        })
    }

//                                    ChangeAvatar
    function changeAvatar() {
        var file = document.getElementById("fileAvatar").files[0];
        if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
            if (file.size / (1024 * 1024) < 5) {
                var fileReader = new FileReader();
                fileReader.readAsDataURL(file);
                fileReader.onload = function () {
                    document.getElementById("myAvatar").src = (fileReader.result);
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
        document.getElementById("fileAvatar").files[0].value = ''
        document.getElementById("fileAvatar").type = '';
        document.getElementById("fileAvatar").type = 'file';
    }



    function btnChangeProfile() {
        $.ajax({
            url: "profile",
            type: "post", 
            data: {
                fullnamepf: document.getElementById("fullnamepf").value,
                malepf: document.getElementById("malepf").checked,
                femalepf: document.getElementById("femalepf").checked,
                phonepf: document.getElementById("phonepf").value,
                addresspf: document.getElementById("addresspf").value,
                myAvatar: document.getElementById("myAvatar").src
            },
            success: function (data) {
                document.getElementById("msgProfile").innerHTML = data;
            }
        });
    }
</script>


