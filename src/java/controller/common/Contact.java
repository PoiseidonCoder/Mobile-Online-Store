package controller.common;

import dao.OrderDAO;
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

public class Contact extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        if (account == null) {
            request.setAttribute("messageError", "Vui lòng đăng nhập!!");
            request.getRequestDispatcher("./CartView").forward(request, response);
            return;
        }
        if (session.getAttribute("cart").toString().equals("{}")) {
            request.setAttribute("messageError","Giỏ hàng trống, hãy thêm sản phẩm vào giỏ hàng!");
            request.getRequestDispatcher("./CartView").forward(request, response);
            return;
        }
        session.setAttribute("account", account);
        ArrayList<Setting> categoryList = new SettingDAO().getAllProCategory();
        ArrayList<Setting> brandList = new SettingDAO().getAllProBrand();
        ArrayList<Product> fearturedProduct = new ProductDAO().getFearturedProduct();
        request.setAttribute("prolist5", fearturedProduct);
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        request.setAttribute("order_id", new OrderDAO().getOrderID());
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}
