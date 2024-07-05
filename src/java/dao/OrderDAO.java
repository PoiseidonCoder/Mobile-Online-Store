package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class OrderDAO extends DBContext {

    public ArrayList<Order> getOrderByUser(String status, String from, String to, int id, int index) {
        ArrayList<Order> OrderList = new ArrayList<>();
        try {
            String sql = "  select o.*, s.orderstatus, od.numpro from \n"
                    + "  (select [order].*, s.[value] as orderstatus from setting s, [order]  where [order].status = s.setting_id) s, [order] o,\n"
                    + "  (select count(order_detail_id) as numpro, order_id from order_detail group by order_id ) as od\n"
                    + "  where o.order_id = s.order_id  and od.order_id = o.order_id\n"
                    + "  and o.status like ? and o.order_date between ? and ? and o.user_id = ?\n"
                    + "   order by order_id asc OFFSET ? ROWS FETCH NEXT 4  ROWS ONLY ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + status + "%");
            stm.setString(2, from);
            stm.setString(3, to);
            stm.setInt(4, id);
            stm.setInt(5, (index - 1) * 4);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Order b = new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getDate(6), rs.getDouble(7), rs.getInt(8), rs.getBoolean(10), rs.getString(11), rs.getString(12), rs.getInt(13));
                OrderList.add(b);
            }
        } catch (SQLException e) {
        }
        return OrderList;
    }

    public int getTotalNumber(String status, String from, String to, int id) {
        try {
            String sql = "  select count(o.order_id) as number from [order] o,(select distinct order_id from order_detail) od where o.status like ? and o.order_id = od.order_id \n"
                    + "  and o.order_date between ? and ? and o.user_id = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + status + "%");
            stm.setString(2, from);
            stm.setString(3, to);
            stm.setInt(4, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int num = rs.getInt(1);
                return num;
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public void deleteOrder(int oid) {
        try {
            String sql = "delete from order_detail where order_id =? delete from [order] where order_id= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, oid);
            stm.setInt(2, oid);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void cancelOrder(int orderID) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[order]\n"
                    + "   SET [status] = 16\n"
                    + " WHERE order_id = ?");
            ps.setInt(1, orderID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertOrder(int user_id, String fullname, String address, String phone, float total, int payment_id, String note) {
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO [dbo].[order]\n"
                    + "           ([user_id]\n"
                    + "           ,[fullname]\n"
                    + "           ,[address]\n"
                    + "           ,[phone]\n"
                    + "           ,[order_date]\n"
                    + "           ,[total]\n"
                    + "           ,[payment_id]\n"
                    + "           ,[status]\n"
                    + "           ,[active]\n"
                    + "           ,[notes])\n"
                    + "     VALUES (?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, user_id);
            ps.setString(2, fullname);
            ps.setString(3, address);
            ps.setString(4, phone);
            ps.setString(5, LocalDate.now().toString());
            ps.setFloat(6, total);
            ps.setInt(7, payment_id);
            ps.setInt(8, 13);
            ps.setBoolean(9, true);
            ps.setString(10, note);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertOrderDetail(int order_id, String[] quantity, String[] product_id, String[] author_id, String[] title,
            String[] brand_id, String[] price, String[] sale_price, String[] stock, String[] description, String[] img, String[] category_id) {
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO [dbo].[order_detail]\n"
                    + "           ([order_id]\n"
                    + "           ,[quantity]\n"
                    + "           ,[product_id]\n"
                    + "           ,[author_id]\n"
                    + "           ,[title]\n"
                    + "           ,[brand_id]\n"
                    + "           ,[price]\n"
                    + "           ,[sale_price]\n"
                    + "           ,[stock]\n"
                    + "           ,[description]\n"
                    + "           ,[img]\n"
                    + "           ,[category_id])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?,?,?,?,?,?)");
            int i = 0;
            for (String string : title) {
                ps.setInt(1, order_id);
                ps.setString(2, quantity[i]);
                ps.setString(3, product_id[i]);
                ps.setString(4, author_id[i]);
                ps.setString(5, title[i]);
                ps.setString(6, brand_id[i]);
                ps.setString(7, price[i]);
                ps.setString(8, sale_price[i]);
                ps.setString(9, stock[i]);
                ps.setString(10, description[i]);
                ps.setString(11, img[i]);
                ps.setString(12, category_id[i]);
                i++;
                ps.executeUpdate();
            }
        } catch (Exception e) {
        }
    }

    public int getOrderID() {
        try {
            String sql = "select IDENT_CURRENT( 'order')";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int num = rs.getInt(1) + 1;
                return num;
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public Order getOrderByOrderID(int orderID) {
        try {
            List<OrderDetail> list = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement("select order_id, setting.value as order_status, fullname, address,phone, order_date, total  from [order] join setting on setting_id = status where order_id = ?");
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Order(rs.getInt(1), new Setting(rs.getString(2)), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDate(6), rs.getDouble(7));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void pay(int order_id, int user_id) {
        String sql = "update  [dbo].[order]\n"
                + "set status= 15\n"
                + "where order_id = ? and [user_id] =?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, order_id);
            stm.setInt(2, user_id);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int convertValueToID(String value) {
        try {
            String sql = "select setting_id from setting where value = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, value);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int num = rs.getInt(1) + 1;
                return num;
            }
        } catch (SQLException e) {
        }
        return 0;
    }
}
