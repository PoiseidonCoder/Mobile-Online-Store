package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
public class DashboarDAO extends DBContext {

    public int getTotalNumberPoduct() {
        try {
            String sql = "  select count(*) from product";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalNumberUser() {
        try {
            String sql = "   select count(*) from [user]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalNumberFeedback() {
        try {
            String sql = "  select count(*) from feedback";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalNumberOrder() {
        try {
            String sql = "  select count(*) from [order]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalProfit() {
        try {
            String sql = "   select sum(total) from [order]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList getTotalStautusOrder() {
        ArrayList<Order> a = new ArrayList<>();
        try {
            String sql = "   select count(*),[status],  s.[value] as orderstatus from [order], setting s"
                    + " where[order].status = s.setting_id group by[status], s.[value] order by[status] asc ";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                a.add(new Order(result.getString(3), result.getInt(1)));
            }
        } catch (Exception e) {
        }
        return a;
    }

    public ArrayList getTotalOrderLast7day() {
        ArrayList a = new ArrayList();
        try {
            String sql = "  select COUNT(*) as numberorder,order_date  from [order] \n"
                    + "  where order_date between  getdate() - 8 and  getdate()-1\n"
                    + "   group by order_date order by order_date asc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                a.add(result.getInt(1));
            }
        } catch (Exception e) {
        }
        return a;
    }

    public ArrayList getTotalProductLast7day() {
        ArrayList a = new ArrayList();
        try {
            String sql = " select count(*) as numberProduct, create_date from Product\n"
                    + " where create_date between  getdate() - 8 and  getdate()-1\n"
                    + " group by create_date order by create_date asc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                a.add(result.getInt(1));
            }
        } catch (Exception e) {
        }
        return a;
    }

    public ArrayList getTotalFeedbackLast7day() {
        ArrayList a = new ArrayList();
        try {
            String sql = "select count(*) as numberFeedbac, feedback_date from feedback\n"
                    + "	where feedback_date between  getdate() - 8 and  getdate()-1\n"
                    + "	group by feedback_date order by feedback_date asc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                a.add(result.getInt(1));
            }
        } catch (Exception e) {
        }
        return a;
    }

    public ArrayList getTotalPostLast7day() {
        ArrayList a = new ArrayList();
        try {
            String sql = " select count(*) as numberPost, post_date from blog\n"
                    + "	where post_date between  getdate() - 8 and  getdate()-1\n"
                    + "	group by post_date order by post_date asc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                a.add(result.getInt(1));
            }
        } catch (Exception e) {
        }
        return a;
    }

    public List<OrderDetail> getTopSelling() {
        try {
            String sql = "  select top 5 sum([quantity]) as numberproduct, title from [order_detail]\n"
                    + "  group by title order by numberproduct desc";
            List<OrderDetail> list = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt(1), rs.getString(2)));
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Order> getLastestOrder() {
        ArrayList<Order> OrderList = new ArrayList<>();
        try {
            String sql = " select  top 10 [order].*, s.[value] as orderstatus from setting s, [order] \n"
                    + "   where [order].status = s.setting_id  order by order_date";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Order b = new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getDate(6), rs.getDouble(7), rs.getInt(8), rs.getBoolean(10), rs.getString(11), rs.getString(12));
                OrderList.add(b);
            }
        } catch (SQLException e) {
        }
        return OrderList;
    }

}
