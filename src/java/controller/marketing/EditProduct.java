package controller.marketing;
import dao.ProductDAO;
import dao.SettingDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Setting;
import model.User;
public class EditProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String pid = request.getParameter("pid");
        ProductDAO productDao = new ProductDAO();
        SettingDAO settingDao = new SettingDAO();
        ArrayList<Setting> categoryList = settingDao.getAllProCategory();
        ArrayList<Setting> brandList = settingDao.getAllProBrand();
        Product  p =   productDao.getProductByID(Integer.parseInt(pid));
        request.setAttribute("s", p);
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        User account = (User)request.getSession().getAttribute("account");
        if (account.getRole() == 2) {
                request.getRequestDispatcher("editproduct.jsp").forward(request, response);
            } else if ((account.getRole() == 1)) {
                request.getRequestDispatcher("./marketing/editproduct.jsp").forward(request, response);
            }
    }
}
