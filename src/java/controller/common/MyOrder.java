/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.SettingDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.file.Paths;
import model.Order;
import model.Product;
import model.Setting;
import model.User;
import service.SendMail;
public class MyOrder extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            HttpSession session = request.getSession();
            ProductDAO productDao = new ProductDAO();
            SettingDAO settingDao = new SettingDAO();
            OrderDAO orderDAO = new OrderDAO();
            String action = request.getParameter("action");
            System.out.println(action);
            if ("delete".equals(action)) {
                String oid = request.getParameter("oid");
                orderDAO.deleteOrder(Integer.parseInt(oid));
                response.sendRedirect("./MyOrder");
            }
            if (action == null) {
                ArrayList<Setting> categoryList = settingDao.getAllProCategory();
                ArrayList<Setting> brandList = settingDao.getAllProBrand();
                ArrayList<Setting> orderStatus = settingDao.getAllOrderStatus();
                ArrayList<Product> fearturedProduct = productDao.getFearturedProduct();

                int userId = 1;
                String index = "1";
                Object o = session.getAttribute("account");
                User user = (User) o;
                userId = user.getUser_id();
                index = request.getParameter("index") == null ? "1" : request.getParameter("index");
                String status = request.getParameter("status") == null ? "" : request.getParameter("status");
                String from = "".equals(request.getParameter("from")) || request.getParameter("from") == null ? "1990-01-01" : request.getParameter("from");
                String to = "".equals(request.getParameter("to")) || request.getParameter("to") == null ? "2030-01-01" : request.getParameter("to");
                ArrayList<Order> OrderList = orderDAO.getOrderByUser(status, from, to, userId, Integer.valueOf(index));
                int totalOrder = orderDAO.getTotalNumber(status, from, to, userId);
                int numberPage = (int) Math.ceil((double) totalOrder / 4);

                request.setAttribute("prolist5", fearturedProduct);
                request.setAttribute("cate", categoryList);
                request.setAttribute("brand", brandList);
                request.setAttribute("status", orderStatus);
                request.setAttribute("OrderList", OrderList);
                request.setAttribute("numberPage", numberPage);
                request.getRequestDispatcher("myorder.jsp").forward(request, response);
            }
            if ("addOrder".equals(action)) {
                int orderID = Integer.parseInt(request.getParameter("order_id"));
                User user = (User) session.getAttribute("account");
                int user_id = (user).getUser_id();
                String fullname = request.getParameter("fullname");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                float total = Float.parseFloat(request.getParameter("total"));
                int payment_id = Integer.parseInt(request.getParameter("flexRadioDefault"));
                String note = request.getParameter("textarea");
                String email = request.getParameter("emaila");
                orderDAO.insertOrder(user_id, fullname, address, phone, total, payment_id, note);

                String[] quantity = request.getParameterValues("quantity");
                String[] product_id = request.getParameterValues("product_id");
                String[] author_id = request.getParameterValues("author_id");
                String[] title = request.getParameterValues("title");
                String[] brand_id = request.getParameterValues("category_id");

                for (int i = 0; i < brand_id.length; i++) {
                    brand_id[i] = String.valueOf(orderDAO.convertValueToID(brand_id[i]));
                }

                String[] price = request.getParameterValues("price");
                String[] sale_price = request.getParameterValues("sale_price");
                String[] stock = request.getParameterValues("stock");
                for (int i = 0; i < stock.length; i++) {
                    new ProductDAO().updateStockByProductID(Integer.parseInt(stock[i]) - Integer.parseInt(quantity[i]), Integer.parseInt(product_id[i]));
                }

                String[] description = request.getParameterValues("description");
                String[] img = request.getParameterValues("img");
                String[] category_id = request.getParameterValues("category_id");
                for (int i = 0; i < category_id.length; i++) {
                    category_id[i] = String.valueOf(orderDAO.convertValueToID(category_id[i]));
                }
                String payment1 = "";
                String payment2 = "";

                if (payment_id == 8) {
                    payment1 = "checked";
                    payment2 = "disable";
                } else {
                    payment2 = "checked";
                    payment1 = "disable";
                }
                SendMail.send(email, "Xác nhận thanh toán từ Shop 10 Điểm!", message(fullname, phone, address, email, payment1, payment2, note, total, product_id, img, title, quantity, price, sale_price, orderID, user_id));
                orderDAO.insertOrderDetail(orderID, quantity, product_id, author_id, title, brand_id, price, sale_price, stock, description, img, category_id);
                request.setAttribute("latesproduct", productDao.getFearturedProduct());
                request.setAttribute("cate", settingDao.getAllProCategory());
                request.setAttribute("brand", settingDao.getAllProBrand());
                request.getSession().setAttribute("cart", null);
                response.sendRedirect("orderinformation?orderid=" + orderID);
            }

        } catch (Exception e) {
            response.getWriter().print(e);
        }
    }
    private String message(String fullname, String phone, String address, String email, String payment1, String payment2, String notes, float total, String[] product_id,
            String[] img, String[] title, String[] quantity, String[] price, String[] sale_price, int orderID, int userID) {
        String list = "";
        String infoBank = "";
        if(payment2.equals("checked")){
            infoBank+="<span style='font-weight: bold;' class=\"status-order\">Để tiếp tục hoàn tất đơn hàng quý khách vui lòng chuyển tới:</span><div>Bank name: Vietcombank</div><div>Account number: 0291000350547</div><div>Transfer content: "+orderID+""+userID+"</div>";
        }else{
            infoBank+="<span style='font-weight: bold;' class=\"status-order\">Chúc mừng bạn đã đặt hàng thành công!</span>";
        }
        for (int i = 0; i < title.length; i++) {
            list += "<div style='display: flex;justify-content: space-between ;padding: 30px 50px; align-items: center;box-shadow: rgba(38, 40, 41, 0.3) 0px 1px 2px 0px, rgba(60, 64, 67, 0.15) 0px 1px 3px 1px;' class=\"products-container\">\n"
                    + "                            <div style='display: flex;display: flex;align-items: center;gap: 20px;' class=\"left-container\">\n"
                    + "                                <div class=\"img-container\">\n"
                    + "                                    <img style='width: 100px;height: 100px;object-fit: cover;box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;' class=\"product-img\" onclick=\"window.location = 'ProductDetail?pid=" + product_id[i] + "'\" src=\"" + img[i] + "\" alt=\"\">\n"
                    + "                                </div>\n"
                    + "                                <div class=\"product-content\">\n"
                    + "                                    <div style='margin-right:50px;' onclick=\"window.location = 'ProductDetail?pid=" + product_id[i] + "'\" class=\"name-product\">" + title[i] + "</div>\n"
                    + "                                    <div style=' color: red;' onclick=\"window.location = 'ProductDetail?pid=" + product_id[i] + "'\" class=\"quantity-product\">x" + quantity[i] + "</div>\n"
                    + "                                </div>\n"
                    + "                            </div>\n"
                    + "                            <div style=' display: flex;gap: 90px;' class=\"right-container\">\n"
                    + "                                <div  class=\"product-price\">\n"
                    + "                                    <span style='text-decoration-line: line-through;' class=\"price\">" + price[i] + "$</span>\n"
                    + "                                    <span style=' color: red;font-weight: bold;' class=\"sale-price\">" + sale_price[i] + "$</span>\n"
                    + "                                </div>\n"
                    + "                            </div>\n"
                    + "                        </div>";

        }
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"utf-8\">\n"
                + "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                + "    <title>Cart Contact</title>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"container-fluid\">\n"
                + "        <div class=\"row\">\n"
                + "            <div class=\"col-md-11\">\n"
                + "                <div style='box-shadow: rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.05) 0px 4px 6px -2px;' class=\"orderdetails-content\">\n"
                + "                    <div style='width: 100%;justify-content: center;padding: 15px;gap: 15px;box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;' class=\"id-status-order\">\n"
                +infoBank                
                + "                    </div>\n"
                + "                    <form action=\"MyOrder\" method=\"post\">\n"
                + list
                + "                        <div style='margin: 25px;border-top: 3px solid red;' class=\"hr\"></div>\n"
                + "                        <div style='  display: flex;justify-content: space-between;padding: 30px 50px;align-items: center;' class=\"info-container\">\n"
                + "                            <div class=\"order-info\">\n"
                + "                                <div class=\"img-container\">\n"
                + "                                </div>\n"
                + "                                <div style=' margin-bottom: 25px;font-weight: bold;' class=\"deliadd\">Delivery address</div>\n"
                + "                                <div class=\"fullname-container\">Fullname: <span class=\"fullname\">" + fullname + "</span></div>\n"
                + "                                <div class=\"phone-address\">\n"
                + "                                    <span class=\"phone\">" + phone + "</span><br><span class=\"address\">Gia Lai</span>\n"
                + "                                </div>\n"
                + "                                <div style='margin-bottom: 15px;' class=\"email-container\">Email: <span class=\"emaila\">" + email + "</span></div>\n"
                + "                            </div>\n"
                + "                            <div class=\"div-mid\">\n"
                + "                                <div class=\"form-check\">\n"
                + "                                    <input class=\"form-check-input\" value=\"8\" type=\"radio\" name=\"flexRadioDefault\" id=\"flexRadioDefault1\" " + payment1 + ">\n"
                + "                                    <label class=\"form-check-label\" for=\"flexRadioDefault1\">\n"
                + "                                        Payment on delivery\n"
                + "                                    </label>\n"
                + "                                </div>\n"
                + "                                <div class=\"form-check\">\n"
                + "                                    <input class=\"form-check-input\" value=\"9\" type=\"radio\" name=\"flexRadioDefault\" id=\"flexRadioDefault2\" " + payment2 + ">\n"
                + "                                    <label class=\"form-check-label\" for=\"flexRadioDefault2\">\n"
                + "                                        Payment by bank\n"
                + "                                    </label>\n"
                + "                                </div>\n"
                + "                                <div class=\"form-group\">\n"
                + "                                    <label style=\"font-weight: bold\" for=\"exampleFormControlTextarea1\">Notes</label>\n"
                + "                                    <textarea readonly name=\"textarea\" class=\"form-control\" id=\"exampleFormControlTextarea1\" rows=\"3\">" + notes + "</textarea>\n"
                + "                                </div>\n"
                + "                            </div>\n"
                + "                            <div style='text-align: end;font-family: 'Poppins', sans-serif;font-size: larger' class=\"div-right\">\n"
                + "                                <div style='color: red;font-weight: bold;' class=\"total-prices\">Total Price:&nbsp;&nbsp;&nbsp; <span class=\"bottoms\">" + total + "$</span></div>\n"
                + "                            </div>\n"
                + "                        </div>\n"
                + "                    </form>\n"
                + "                </div>\n"
                + "            </div>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";
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


