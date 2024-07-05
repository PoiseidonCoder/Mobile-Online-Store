package controller.common;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
public class ChangePassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        String email = ((User) session.getAttribute("account")).getEmail();
        String oldpassword = request.getParameter("oldPassword");
        String newpassword = request.getParameter("password");
        String confirmpassword = request.getParameter("rePassword");
        if(oldpassword.equals("") || newpassword.equals("") || confirmpassword.equals("")){
            response.getWriter().println("Không cho phép để trống!");
        }
        else if (dao.checkLogin(email, oldpassword)==false) {
            response.getWriter().println("Mật khẩu cũ không đúng vui lòng xác nhận lại!");
        } else if(!newpassword.equals(confirmpassword)){
            response.getWriter().println("Vui lòng nhập 2 mật khẩu giống nhau!");
        }else{
            dao.updatePassword(email, newpassword);
            response.getWriter().println("Đổi mật khẩu thành công!");
        }
    }
}
