package controller.marketing;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.User;

public class ManageAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        String action = request.getParameter("action");
        if (action == null) {
            try {
                int user_id = request.getParameter("user_id") == null ? -1 : Integer.valueOf(request.getParameter("user_id"));
                String fullname = request.getParameter("fullname") == null ? "" : request.getParameter("fullname");
                String email = request.getParameter("email") == null ? "" : request.getParameter("email");
                String search = request.getParameter("search") == null ? "" : request.getParameter("search");
                ArrayList<User> userList = userDAO.getAll(user_id, fullname, email);
                request.setAttribute("userList", userList);
                int numberPage = (int) Math.ceil((double) userDAO.totalUser() / 9);
                request.setAttribute("numberPage", numberPage);
            } catch (Exception e) {
            }
            String currentPage = request.getParameter("index");
            int index;
            if (currentPage == null) {
                index = 1;
            } else {
                index = Integer.parseInt(currentPage);
            }
            request.setAttribute("index", index);
            request.getRequestDispatcher("./marketing/manageaccount.jsp").forward(request, response);
        }

        if ("delete".equals(action)) {
            String index = request.getParameter("index");
            int user_id = request.getParameter("user_id") == null ? -1 : Integer.valueOf(request.getParameter("user_id"));
            userDAO.deleteAccount(user_id);
            response.sendRedirect("ManageAccount?index=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
