
package controller.common;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
public class ChangeInformation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int gender = Integer.parseInt(request.getParameter("gender"));
        User account = (User)session.getAttribute("account");
        account.setAddress(address);
        account.setFullname(name);
        if(gender == 1)
            account.setGender(true);
        else
            account.setGender(false);
        account.setPhone(phone);
        session.setAttribute("account", account);
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}