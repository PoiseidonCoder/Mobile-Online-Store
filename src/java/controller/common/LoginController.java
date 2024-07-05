package controller.common;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
public class LoginController extends HttpServlet {
    //login
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO dao = new UserDAO();
            HttpSession session = request.getSession();
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            if (dao.checkLogin(email, password)) {
                session.setAttribute("account", dao.getUserByEmail(email));
                response.getWriter().print("success");
            } else {
                response.getWriter().println("Mật khẩu không chính xác!");
            }
        } catch (Exception e) {
        }
    }

}
