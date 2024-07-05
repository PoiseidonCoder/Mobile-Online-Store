package controller.common;

import dao.FeedbackDAO;
import dao.ProductDAO;
import dao.SettingDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.Setting;
import model.User;
//Feedback
public class SendFeedback extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            ProductDAO productDao = new ProductDAO();
            SettingDAO settingDao = new SettingDAO();
            ArrayList<Setting> categoryList = settingDao.getAllProCategory();
            ArrayList<Setting> brandList = settingDao.getAllProBrand();
            ArrayList<Setting> orderStatus = settingDao.getAllOrderStatus();
            ArrayList<Product> fearturedProduct = productDao.getFearturedProduct();
            int userId = 1;
            String pid = request.getParameter("pid");
            Object o = session.getAttribute("account");
            User user = (User) o;
            userId = user.getUser_id();
            Product product = productDao.getProductByID(Integer.valueOf(pid));
            request.setAttribute("prolist5", fearturedProduct);
            request.setAttribute("cate", categoryList);
            request.setAttribute("brand", brandList);
            request.setAttribute("status", orderStatus);
            request.setAttribute("product", product);
            request.getRequestDispatcher("sendfeedback.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("404.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FeedbackDAO fdao = new FeedbackDAO();
            String proid = request.getParameter("pid");
            HttpSession session = request.getSession();
            String content = request.getParameter("feedbackContent");
            String rate = request.getParameter("rating");
            String img = request.getParameter("img");
            User user = (User) session.getAttribute("account");
            fdao.insertFeedback(proid, user.getUser_id(), content, rate, img);
            response.sendRedirect("MyOrder");
        } catch (Exception e) {
            response.sendRedirect("404.jsp");
        }

    }
}
