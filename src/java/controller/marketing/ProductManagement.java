package controller.marketing;

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

public class ProductManagement extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        ProductDAO productDao = new ProductDAO();
        SettingDAO settingDao = new SettingDAO();
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        String action = request.getParameter("action");
        if (action == null) {
            String brandId = request.getParameter("brandId") == null ? "" : request.getParameter("brandId");
            String categoryId = request.getParameter("categoryId") == null ? "" : request.getParameter("categoryId");
            String status = request.getParameter("status") == null ? "" : request.getParameter("status");
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");
            String typeSearch = request.getParameter("type-search");
            search = search.trim();
            String title = "";
            String brief = "";
            if ("0".equals(typeSearch)) {
                title = search;
            }
            if ("1".equals(typeSearch)) {
                brief = search;
            }
            ArrayList<Setting> categoryList = settingDao.getAllProCategory();
            ArrayList<Setting> brandList = settingDao.getAllProBrand();
            int totalproduct;
            if(account.getRole()==1){
                 totalproduct = productDao.getNumberProductForMarketingByAdmin(brandId, categoryId, status, title, brief);
            }else{
                 totalproduct = productDao.getNumberProductForMarketing(account.getUser_id(),brandId, categoryId, status, title, brief);
            }
            int numberPage = (int) Math.ceil((double) totalproduct / 15);
            int index;
            String currentPage = request.getParameter("index");
            if (currentPage == null) {
                index = 1;
            } else {
                index = Integer.parseInt(currentPage);
            }
            request.setAttribute("index", index);
            request.setAttribute("cate", categoryList);
            request.setAttribute("brand", brandList);
            request.setAttribute("numberPage", numberPage);

            if (account.getRole() == 2) {
                ArrayList<Product> productList = new ProductDAO().getAllProductForMarketing(account.getUser_id(), brandId, categoryId, status, title, brief, index);
                request.setAttribute("prolist", productList);
                request.getRequestDispatcher("productmanagement.jsp").forward(request, response);
            } else if ((account.getRole() == 1)) {
                ArrayList<Product> productList = new ProductDAO().getAllProductForMarketingByAdmin(brandId, categoryId, status, title, brief, index);
                request.setAttribute("prolist", productList);
                request.getRequestDispatcher("./marketing/productmanagement2.jsp").forward(request, response);
            }
        }
        if ("edit".equals(action)) {
            String index = request.getParameter("index");
            String proid = request.getParameter("proid");
            String protitle = request.getParameter("protitle");
            String categoryId = request.getParameter("categoryId");
            String brandId = request.getParameter("brandId");
            String price = request.getParameter("price");
            String salePrice = request.getParameter("salePrice");
            String stock = request.getParameter("stock");
            String createDate = request.getParameter("createDate");
            String prodstatus = request.getParameter("prodstatus");
            String Description = request.getParameter("Description");
            String proimage = request.getParameter("proimage");
            productDao.updateProduct(protitle, Integer.valueOf(brandId), Double.valueOf(price), Double.valueOf(salePrice),
                    Integer.valueOf(stock), Description, proimage, Integer.valueOf(categoryId), Integer.valueOf(proid), createDate, Integer.valueOf(prodstatus));
            response.sendRedirect("productmanagement?index=" + index);

        }
        if ("switch".equals(action)) {
            String pid = request.getParameter("pid");
            String index = request.getParameter("index");
            String sstatus = request.getParameter("sstatus");
            productDao.switchProduct(Integer.valueOf(pid), Integer.valueOf(sstatus));
            response.sendRedirect("productmanagement?index=" + index);
        }
        if ("delete".equals(action)) {
            String index = request.getParameter("index");
            String pid = request.getParameter("pid");
            productDao.deleteProduct(Integer.valueOf(pid));
            response.sendRedirect("productmanagement?index=" + index);

        }
        if ("add".equals(action)) {
            String index = request.getParameter("index");
            String protitle = request.getParameter("protitle");
            String categoryId = request.getParameter("categoryId");
            String brandId = request.getParameter("brandId");
            String price = request.getParameter("price");
            String salePrice = request.getParameter("salePrice");
            String stock = request.getParameter("stock");
            String prodstatus = request.getParameter("prodstatus");
            String Description = request.getParameter("Description");
            String proimage = request.getParameter("proimage");
            productDao.addNewProduct(protitle, Integer.valueOf(brandId), Double.valueOf(price), Double.valueOf(salePrice),
                    Integer.valueOf(stock), Description, proimage, Integer.valueOf(categoryId), account.getUser_id(), Integer.valueOf(prodstatus));
            response.sendRedirect("productmanagement");
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
    public static void main(String[] args) {
        new ProductDAO().deleteProduct(12);
    }
}

