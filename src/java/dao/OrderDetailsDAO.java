package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
public class OrderDetailsDAO extends DBContext {
    public List<OrderDetail> getOrderDetailByOrderID(int orderID) {
        try {
            List<OrderDetail> list = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement("SELECT order_detail_id, order_id, quantity, product_id, title, price, sale_price, img from order_detail where order_id = ?");
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getString(8)));
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }
  

   
}



