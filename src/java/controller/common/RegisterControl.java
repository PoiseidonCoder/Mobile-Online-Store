package controller.common;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
public class RegisterControl extends HttpServlet {
    //register
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            UserDAO dao = new UserDAO();
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String repassword = request.getParameter("repassword");
            int gender = 0; 
            try {
                String male = request.getParameter("male");
                gender = 1;
            } catch (Exception e) {
            }
            if (!dao.isValidName(fullname)) {
                out.println("Tên không hợp lệ không được chứa khoảng cách hoặc chữ số");
                return;
            }
            if (!dao.isValidEmail(email)) {
                out.println("Email không hợp lệ!");
                return;
            }

            if (!dao.isValidPhoneNumber(phone)) {
                out.println("Số không hợp lệ , phải chứa 10 chữ số và bắt đầu bằng 0!");
                return;
            }
            if (dao.checkEmail(email)) {
                out.println("Email đã tồn tại!");
            } else if (!password.equals(repassword)) {
                out.println("Vui lòng nhập mật khẩu khớp!");
            } else {
                dao.insertUser(fullname, phone, address, email, password, gender);
                out.println("Vui lòng xác nhận email qua tin mail đã gởi!");
            }
        } catch (Exception e) {
        }
    }
}
