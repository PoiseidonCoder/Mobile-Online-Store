package controller.common;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import dao.OrderDAO;
import dao.OrderDetailsDAO;
import dao.ProductDAO;
import dao.SettingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.file.Paths;
import model.User;
public class OrderInformation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int userId = 1;
            Object o = session.getAttribute("account");
            User user = (User) o;
            userId = user.getUser_id();
            ProductDAO productDao = new ProductDAO();
            SettingDAO settingDao = new SettingDAO();
            OrderDetailsDAO orderInfoDAO = new OrderDetailsDAO();
            OrderDAO orderDAO = new OrderDAO();
            int orderid = Integer.parseInt(request.getParameter("orderid"));
            if (orderDAO.getOrderByOrderID(orderid).getSetting().getValue().equals("Đang chờ") || orderDAO.getOrderByOrderID(orderid).getSetting().getValue().equals("Đang chuyển hàng")) {
                request.setAttribute("canCancel", "Hủy đơn hàng");
            }
            String data = "http://localhost:8080/onlineShop/Pay?order_id=" + orderid + "&user_id=" + userId;
            genarateQRCode(data, "D:\\Documents\\NetBeansProjects\\onlineShop\\web\\images\\QR.png", "UTF-8", 300, 300);
            request.setAttribute("orderdetails", orderInfoDAO.getOrderDetailByOrderID(orderid));
            request.setAttribute("order", orderDAO.getOrderByOrderID(orderid));
            request.setAttribute("latesproduct", productDao.getFearturedProduct());
            request.setAttribute("cate", settingDao.getAllProCategory());
            request.setAttribute("brand", settingDao.getAllProBrand());
            request.getRequestDispatcher("orderinformation.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("404.jsp");
        }
    }
    public static void genarateQRCode(String data, String path, String charset, int h, int w) throws WriterException, IOException {
        BitMatrix bitMatrix = new MultiFormatWriter().encode(data, BarcodeFormat.QR_CODE, w, h);
        MatrixToImageWriter.writeToPath(bitMatrix, path.substring(path.lastIndexOf('.') + 1), Paths.get(path));
    }

}
