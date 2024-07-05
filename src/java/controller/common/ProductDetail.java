package controller.common;
import dao.FeedbackDAO;
import dao.ProductDAO;
import dao.SettingDAO;
import dao.UserDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Feedback;
import model.Product;
import model.Setting;
//ProductDetail
public class ProductDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ProductDAO productDao = new ProductDAO();
        SettingDAO settingDao = new SettingDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        HttpSession session = request.getSession();
        try {
            int pid = Integer.parseInt(request.getParameter("pid"));
            Product product = productDao.getProductByID(pid);
            ArrayList<Setting> categoryList = settingDao.getAllProCategory();
            ArrayList<Setting> brandList = settingDao.getAllProBrand();
            ArrayList<Product> fearturedProduct = productDao.getFearturedProduct();
            ArrayList<Product> recommend1 = productDao.getRecommendPro(product.getCategory(), 0);
            ArrayList<Product> recommend2 = productDao.getRecommendPro(product.getCategory(), 4);
            ArrayList<Feedback> FeedbackList = feedbackDAO.getFeedbackBypid(pid);
            String numberFb = feedbackDAO.getNumberFeedbackByProId(pid);
            int quantityincart = 0;
            if (session.getAttribute("cart")!= null) {
                try {
                    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                    if (cart.containsKey(pid)) {
                        quantityincart = cart.get(pid).getQuantity();
                    } else {
                        quantityincart = 0;
                    }
                } catch (Exception e) {
                }
            }
            request.setAttribute("product", product);
            request.setAttribute("seller", new UserDAO().getEmailByID(product.getAuthor().getUser_id()));
            request.setAttribute("quantityincart", quantityincart);
            request.setAttribute("prolist5", fearturedProduct);
            request.setAttribute("recommend1", recommend1);
            request.setAttribute("recommend2", recommend2);
            request.setAttribute("cate", categoryList);
            request.setAttribute("brand", brandList);
            request.setAttribute("fblist", FeedbackList);
            request.setAttribute("numberFb", numberFb);
            request.getSession().setAttribute("url", "ProductDetail?pid=" + pid);
            request.getRequestDispatcher("productdetails.jsp").forward(request, response);
        } catch (Exception e) {
            response.getWriter().print(e);
        }
    }
}
