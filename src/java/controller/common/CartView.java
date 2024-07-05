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
//ViewCart
public class CartView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
        }
        double total = 0;
        for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
            Integer key = entry.getKey();
            CartItem value = entry.getValue();
            total += value.getProduct().getSalePrice() * value.getQuantity();
            int stock= new ProductDAO().getStock(value.getProduct().getId());
            if( value.getQuantity()>new ProductDAO().getStock(key)||value.getQuantity()==0){
                        request.setAttribute("error", "Số lượng tồn kho sản phẩm chỉ còn :"+stock);
                        
            }
        }
        ArrayList<Setting> categoryList = new SettingDAO().getAllProCategory();
        ArrayList<Setting> brandList = new SettingDAO().getAllProBrand();
        ArrayList<Product> fearturedProduct = new ProductDAO().getFearturedProduct();
        request.setAttribute("prolist5", fearturedProduct);
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        session.setAttribute("total", total);
        session.setAttribute("count", cart.size());
        session.setAttribute("cart", cart);
        request.getSession().setAttribute("url", "CartView");
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
