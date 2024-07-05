package controller.common;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class ForgotPassword extends HttpServlet {
    @Override
    //forgotpassword
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();
        if (dao.checkEmail(email)) {
            request.setAttribute("msgg", "Vui lòng nhận email để xác thực!");
            dao.insertKey(email);
        } else {
            request.setAttribute("msgg", "Email không tồn tại!");
        }
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }
}
