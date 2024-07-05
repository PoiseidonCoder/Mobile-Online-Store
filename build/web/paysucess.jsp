<%-- 
    Document   : paysucess
    Created on : Mar 12, 2024, 2:55:22 AM
    Author     : THI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>404 Page</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body class="biolife-body" style="margin: 0;">
        <jsp:include page="./header.jsp"/>
        <div class="page-contain page-404">
            <div id="main-content" class="main-content">
                <div class="container">
                    <div class="row">
                        <div class="content-404">
                            <h2 class="title">Thanh toán đơn hàng thành công</h2>
                            <h2 class="title">Vui lòng trở lại trang chủ. </h2>
                            <div class="button"><a  href="./Home">Về trang chủ.</a> </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <jsp:include page="./footer.jsp"/>
    </body>
</html>
