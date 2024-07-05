package controller.common;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
public class DeleteCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int productID = Integer.parseInt(request.getParameter("pid"));
        HttpSession session = request.getSession();
        Map<Integer,CartItem> cart = (Map<Integer,CartItem>) session.getAttribute("cart");
        if(cart == null)
            cart = new LinkedHashMap<>();
        if(cart.containsKey(productID)){
            cart.remove(productID);
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("CartView");
    }
}