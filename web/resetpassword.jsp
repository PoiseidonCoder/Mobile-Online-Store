<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Đặt lại mật khẩu</title>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="https://w7.pngwing.com/pngs/356/440/png-transparent-iphone-computer-icons-telephone-email-telephone-electronics-text-mobile-phones.png" />
        <link rel="stylesheet" href="./css/main.css">
    </head>

    <body class="biolife-body">
        <jsp:include page="./header.jsp"/>



        <form action="resetpassword" method="post">
            <div class="container-forgot">
                <div class="title-forgot">
                    <h2 class="forgotpassword">Đặt lại mật khẩu</h2>
                </div>
                <input type="hidden" name="email" value="${requestScope.email}">
                <div class="input-forgot"><input name="password" required="" type="password" class="email" placeholder="Password"></div>
                <div class="input-forgot"><input name="repassword" required="" type="password" class="email" placeholder="Re-Password"></div>
                <div class="error-forgot"><span class="msg">${requestScope.msg}</span></div>
                <div class="btn-forgot"><input type="submit" class="submit" value="Yêu cầu"></div>
            </div>
        </form>


        <!----------------------------------------------------------------------------------------------->

        <jsp:include page="./footer.jsp"/>


        <script src="js/main.js"></script>
        <script src="./js/bootstrap.js"></script>
    </body>

</html>