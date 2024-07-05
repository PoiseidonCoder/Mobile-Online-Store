package controller.marketing;
import dao.DashboarDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderDetail;
public class MarketingDasboard extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DashboarDAO dao = new  DashboarDAO();
        int numProduct = dao.getTotalNumberPoduct();
        int numUser= dao.getTotalNumberUser();
        int numFeedback = dao.getTotalNumberFeedback();
        int numOrder = dao.getTotalNumberOrder();
        int profit = dao.getTotalProfit();
        ArrayList<Order> allOrderStatus = dao.getTotalStautusOrder();
        List<OrderDetail> topSelling = dao.getTopSelling();
        ArrayList<Order> OrderList = dao.getLastestOrder();
         ArrayList numberOrderinLast7day = dao.getTotalOrderLast7day();
         ArrayList getTotalProductLast7day = dao.getTotalProductLast7day();
         ArrayList getTotalFeedbackLast7day = dao.getTotalFeedbackLast7day();
         request.setAttribute("numProduct", numProduct);
         request.setAttribute("numUser", numUser);
         request.setAttribute("numFeedback",numFeedback );
         request.setAttribute("numOrder", numOrder);
         request.setAttribute("profit", profit);
         request.setAttribute("allOrderStatus", allOrderStatus);
         request.setAttribute("topSelling", topSelling);
         request.setAttribute("OrderList", OrderList);
         request.setAttribute("numberOrderinLast7day", numberOrderinLast7day);
         request.setAttribute("getTotalProductLast7day", getTotalProductLast7day);
         request.setAttribute("getTotalFeedbackLast7day", getTotalFeedbackLast7day);
        request.getRequestDispatcher("./marketing/dashboard.jsp").forward(request, response);
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
}



