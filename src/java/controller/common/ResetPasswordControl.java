package controller.common;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
public class ResetPasswordControl extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        if (!password.equals(repassword)) {
            request.setAttribute("msg", "Vui lòng nhập password trùng nhau!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
        } else {
            dao.updatePassword(email, password);
            request.setAttribute("msg", "Đặt lại thành công vui lòng đăng nhập!");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
        }
    }
    public static void main(String[] args) {
        System.out.println(new Date());
    }
}
