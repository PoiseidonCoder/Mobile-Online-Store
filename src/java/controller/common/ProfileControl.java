package controller.common;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
public class ProfileControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        String email = ((User) session.getAttribute("account")).getEmail();
        String fullnamepf = request.getParameter("fullnamepf");
        int gender = 0;
        if (request.getParameter("malepf").equals("true")) {
            gender = 1;
        } else {
            gender = 0;
        }
        String phonepf = request.getParameter("phonepf");
        String addresspf = request.getParameter("addresspf");
        String myAvatar = request.getParameter("myAvatar");

        System.out.println("" + email);
        System.out.println("fullnamepf: " + fullnamepf);
        System.out.println("gender: " + gender);
        System.out.println("phonepf: " + phonepf);
        System.out.println("addresspf: " + addresspf);
        System.out.println("myAvatar: " + myAvatar);
        if (!dao.isValidName(fullnamepf)) {
            response.getWriter().println("Tên không được chứa khoảng trống hoặc kí tự đặc biệt!");
        } else if (!dao.isValidPhoneNumber(phonepf)) {
            response.getWriter().println("Số điện thoại phải chứa 10 số và bắt đầu bằng số 0!");

        } else if (addresspf.trim() == null) {
            response.getWriter().println("Địa chỉ không được để trống");
        } else {
            dao.updateProfile(fullnamepf, gender, phonepf, addresspf, myAvatar, email);
            session.setAttribute("account", dao.getUserByEmail(email));
            response.getWriter().println("Đổi thông tin thành công!");
        }
    }
}
