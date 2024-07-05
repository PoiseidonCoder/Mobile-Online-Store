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
        <link href="./marketing/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.2.7/morris.min.js" integrity="sha512-nF4mXN+lVFhVGCieWAK/uWG5iPru9+/z1iz0MJbYTto85I/k7gmbTFFFNgU+xVRkF0LI2nRCK20AhxFIizNsXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="./marketing/css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <%@include file="header.jsp" %>
        <aside class="right-side">

            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel">
                            <header class="panel-heading">
                                Thêm sản phẩm mới
                            </header>
                            <div style="width: 100%">
                                <form action="productmanagement?action=add" method="post">
                                    <div class="row">
                                        <div class="form-group  col-md-12">
                                            <span class="thong-tin-thanh-toan">
                                                <h5>Thêm sản phẩm mới</h5>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="form-group col-md-6">
                                            <label for="exampleSelect1" class="control-label">Tiêu đề:</label>
                                            <input class="form-control" type="text" maxlength="50" name="protitle" required value="">
                                            <input class="form-control" type="hidden"  name="index" value="${index}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Tồn kho</label>
                                            <input class="form-control" type="number" min="1" name="stock" required value="">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Loại sản phẩm:</label>
                                            <select class="form-control" name="categoryId" style="display: inline; width: 100px;">
                                                <c:forEach var="cate" items="${cate}">
                                                    <option value="${cate.setting_id}" ${cate.value==s.category?"selected":""}>${cate.value}</option>
                                                </c:forEach>
                                            </select>

                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Thương hiệu:</label>
                                            <select class="form-control" name="brandId" style="display: inline; width: 100px;">
                                                <c:forEach var="brand" items="${brand}">
                                                    <option value="${brand.setting_id}" ${brand.value==s.brand?"selected":""}>${brand.value}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Giá:</label>
                                            <input class="form-control" type="number" step="0.01" min="1" name="price" required value="">

                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Giá bán:</label>
                                            <input class="form-control" type="number" step="0.01" min="1" name="salePrice" required value="">

                                        </div>
                                        <div class="form-group col-md-12">
                                            <label class="control-label">Trạng thái</label><br>
                                            <input  type="radio" name="prodstatus" required value="1" >Hoạt động
                                            <input  type="radio" name="prodstatus" required value="0" > Không hoạt động
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label class="control-label">Miêu tả:</label>
                                            <textarea class="form-control" name="Description" id="editoradd" maxlength="300" style="height: 95px;"></textarea>
                                        </div>
                                        <div class="form-group col-md-10">
                                            <label class="control-label" >Ảnh</label>

                                            <input class="form-control" id="imgadd" required onchange="changeimgadd()" name="image" type="file" >
                                            <input name="proimage" id="imageadd" value="" type="hidden" >
                                            <image  src="" id="demoimgadd" style="margin-top: 5px;" width="30%">
                                        </div>
                                    </div>
                                    <BR>
                                    <button class="btn btn-primary" type="submit">Lưu</button>
                                    <a class="btn btn-danger" data-dismiss="modal" href="productmanagement">Hủy</a>
                                    <BR>
                                </form>  
                            </div>

                        </div><!-- /.box -->
                    </div>
                </div>
            </section><!-- /.content -->
            <div class="footer-main">
                Copyright © 2024. Thiết kể bởi nhóm 3 lớp DE170740.
            </div>
        </aside><!-- /.right-side -->
        <script>
            CKEDITOR.replace('editoradd');
        </script>
        <script>
            function changeimgadd() {
                var file = document.getElementById("imgadd").files[0];
                if (file.name.match(/.+\.(jpg|png|jpeg)/i)) {
                    if (file.size / (1024 * 1024) < 5) {
                        var fileReader = new FileReader();
                        fileReader.readAsDataURL(file);
                        fileReader.onload = function () {
                            document.getElementById("imageadd").value = (fileReader.result);
                            document.getElementById("demoimgadd").src = (fileReader.result);
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
                document.getElementById("imgadd").files[0].value = ''
                document.getElementById("imgadd").type = '';
                document.getElementById("imgadd").type = 'file';
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
