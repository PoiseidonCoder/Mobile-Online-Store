package controller.common;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class Verify extends HttpServlet {
    @Override
//    verify
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO dao = new UserDAO();
            String action = request.getParameter("action");
            String email = request.getParameter("email");
            String key = request.getParameter("key");

            if (action.equals("register")) {
                if (dao.checkEmailAndKey(email, key)) {
                    dao.activeAccount(email);
                    request.setAttribute("msg", "Đăng ký thành công!");
                } else {
                    request.setAttribute("msg", "Sai mã , Đăng ký không thành công!");
                }
                request.setAttribute("activeLogin", "style='display: flex;'");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } else {
                if (dao.checkEmailAndKey(email, key)) {
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
        }
    }
}
