package controller.common;

import dao.ProductDAO;
import dao.SettingDAO;
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
import model.Setting;
//ProductList
public class ProductList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDao = new ProductDAO();
        SettingDAO settingDao = new SettingDAO();
        //Get parameter and check the value null or not
        String brandId = request.getParameter("brandId") == null ? "" : request.getParameter("brandId");
        String categoryId = request.getParameter("categoryId") == null ? "" : request.getParameter("categoryId");
        String orderBy = request.getParameter("orderby") == null ? "" : request.getParameter("orderby");
        String priceRangeId = request.getParameter("priceRangeId") == null ? "" : request.getParameter("priceRangeId");
        
        ArrayList<Setting> priceRangeList = settingDao.getAllProPriceRange();
        String search = request.getParameter("search") == null ? "" : request.getParameter("search");
        search = search.trim();
        ArrayList<Setting> categoryList = settingDao.getAllProCategory();
        ArrayList<Setting> brandList = settingDao.getAllProBrand();
        ArrayList<Product> fearturedProduct = productDao.getFearturedProduct();
        int index;
        String currentPage = request.getParameter("index");
        if (currentPage == null) {
            index = 1;
        } else {
            index = Integer.parseInt(currentPage);
        }
        ArrayList<Product> productList = productDao.getAllProductByCondition(brandId, categoryId, orderBy, search, priceRangeId, index);
        int quantityincart = 0;
        HttpSession session = request.getSession();
        if (session.getAttribute("cart") != null) {
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            for (Product p : productList) {
                if (cart.containsKey(p.getId())) {
                    quantityincart = cart.get(p.getId()).getQuantity();
                    p.setStock(p.getStock() - quantityincart);
                }
            }
        }
        int totalproduct = productDao.getNumberProduct(brandId, categoryId, search, priceRangeId);
        int numberPage = totalproduct % 9 == 0 ? totalproduct / 9 : (totalproduct / 9) + 1;

        request.setAttribute("prolist", productList);
        request.setAttribute("index", index);
        request.setAttribute("prolist5", fearturedProduct);
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        request.setAttribute("numberPage", numberPage);
        request.setAttribute("priceRangeId", priceRangeId);
        request.setAttribute("orderby", orderBy);
        request.setAttribute("brandId", brandId);
        request.setAttribute("categoryId", categoryId);
        request.getSession().setAttribute("url", "ProductList?brandId=" + brandId + "&categoryId=" + categoryId + "&orderby=" + orderBy + "&index=" + index + "&search=" + search + "&priceRangeId=" + priceRangeId);
        request.setAttribute("priceRange", priceRangeList);
        request.getRequestDispatcher("productlist.jsp").forward(request, response);
    }
}
