package controller.marketing;
import dao.SettingDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Setting;
public class AddProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SettingDAO settingDao = new SettingDAO();
        ArrayList<Setting> categoryList = settingDao.getAllProCategory();
        ArrayList<Setting> brandList = settingDao.getAllProBrand();
        request.setAttribute("cate", categoryList);
        request.setAttribute("brand", brandList);
        request.getRequestDispatcher("./addproduct.jsp").forward(request, response);
    }
}
