package controller.common;

import dao.ProductDAO;
import dao.SlideDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.CartItem;
import model.Product;
import model.Slide;
//Home
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("pageCurrent", true);
        HttpSession session = request.getSession();
        ProductDAO dao = new ProductDAO();
        ArrayList<Product> productList = dao.getFearturedProduct();
        ArrayList<Slide> listSlide = new SlideDAO().getAllSlide();
        int numberSlide = new SlideDAO().getNumberSlide();
        int quantityincart = 0;

        if (session.getAttribute("cart" )!= null) {
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            for (Product p : productList) {
                if (cart.containsKey(p.getId())) {
                    quantityincart = cart.get(p.getId()).getQuantity();
                    p.setStock(p.getStock() - quantityincart);
                }
            }
        }
        request.setAttribute("prolist", productList);
        request.setAttribute("listSlide", listSlide);
        request.setAttribute("numberSlide", numberSlide);
        request.getSession().setAttribute("url", "Home");
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    public static void main(String[] args) {
        for (Product p : new ProductDAO().getFearturedProduct()) {
            System.out.println(p);
        }
    }
}
