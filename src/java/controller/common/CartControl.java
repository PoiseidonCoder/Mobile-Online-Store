package controller.common;

import dao.ProductDAO;
import dao.SettingDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import model.Setting;

public class CartControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int productID = Integer.parseInt(request.getParameter("pid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
        }

        if (((String) request.getSession().getAttribute("url")).equals("CartView")) {
            if (cart.containsKey(productID)) {
                cart.get(productID).setQuantity(quantity);
            }
        } else {
            if (cart.containsKey(productID)) {
                int oldQuan = cart.get(productID).getQuantity();
                cart.get(productID).setQuantity(oldQuan + quantity);
            } else {
                Product p = new ProductDAO().getProductByID(productID);
                cart.put(productID, new CartItem(p, quantity));
            }
        }
        ProductDAO productDao = new ProductDAO();
        SettingDAO settingDao = new SettingDAO();
        ArrayList<Setting> categoryList = settingDao.getAllProCategory();
        ArrayList<Setting> brandList = settingDao.getAllProBrand();
        ArrayList<Product> fearturedProduct = productDao.getFearturedProduct();
        request.setAttribute("stock", productDao.getProductByID(productID).getStock());
        request.setAttribute("prolist5", fearturedProduct);
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        session.setAttribute("cart", cart);
        response.sendRedirect((String) request.getSession().getAttribute("url"));
    }
}
