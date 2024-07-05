package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Feedback;
import model.Product;
import model.User;
public class FeedbackDAO extends DBContext {

    public void insertFeedback(String pid, int uid, String content, String rate, String img) {
        try {
            String sql = "insert into feedback values (?,?,?,?,?,GETDATE(),1)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pid);
            stm.setInt(2, uid);
            stm.setInt(3, Integer.valueOf(rate));
            stm.setString(4, content);
            stm.setString(5, img);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Feedback> getFeedbackBypid(int pid) {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "select fb.*, u.* from feedback fb, [user] u where product_id= ? and u.user_id = fb.user_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(9), rs.getString(10), rs.getString(11), rs.getString(14), rs.getString("avatar"));
                Feedback fb = new Feedback(rs.getInt(1), rs.getInt(2), u, rs.getInt(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getBoolean(8));
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
        }
        return FeedbackList;
    }

    public String getNumberFeedbackByProId(int pid) {
        try {
            String sql = "select avg( Cast(rated as Float)),count(*) from feedback where product_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String avg = "0";
                if (rs.getString(2) != null) {
                    avg = rs.getString(2);
                }
                String s = "<b>" + rs.getString(1) + "</b><i class=\"fa fa-star\" ></i>  (" + avg + " feedbacks)";
                return s;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Feedback> getAllFeedbacks() {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "select feedback_id, fullname,p.img,  title, rated, f.active, email, phone, f.fb_content from feedback f join product p on f.product_id = p.product_id join [user] u on u.user_id = f.user_id "
                    + "order by feedback_id asc OFFSET 1 ROWS FETCH NEXT 9  ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback(rs.getInt("feedback_id"), new User(rs.getString("fullname"), rs.getString("email"), rs.getString("phone")), new Product(rs.getString("img"), rs.getString("title")), rs.getInt("rated"), rs.getBoolean("active"), rs.getString("fb_content"));
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
        }
        return FeedbackList;
    }

    public ArrayList<Feedback> getFeedbackByConditions(String star, String status, String fullname, String product, int index) {
        ArrayList<Feedback> FeedbackList = new ArrayList<>();
        try {
            String sql = "select feedback_id, fullname,p.img,  title, rated, f.active, email, phone, f.fb_content from feedback f join product p on f.product_id = p.product_id \n"
                    + "join [user] u on u.user_id = f.user_id where rated like ? and f.active like ? and fullname like ? and title like ? "
                    + "order by feedback_id asc OFFSET ? ROWS FETCH NEXT 9  ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + star + "%");
            stm.setString(2, "%" + status + "%");
            stm.setString(3, "%" + fullname + "%");
            stm.setString(4, "%" + product + "%");
            stm.setInt(5, (index - 1) * 9);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback(rs.getInt("feedback_id"), new User(rs.getString("fullname"), rs.getString("email"), rs.getString("phone")), new Product(rs.getString("img"), rs.getString("title")), rs.getInt("rated"), rs.getBoolean("active"), rs.getString("fb_content"));
                FeedbackList.add(fb);
            }
        } catch (SQLException e) {
        }
        return FeedbackList;
    }

    public int getNumberFeedbackWithCondition(String star, String status, String fullname, String product) {
        try {
            String sql = "  select COUNT(*) from feedback f join product p on f.product_id = p.product_id \n"
                    + "join [user] u on u.user_id = f.user_id where rated like ? and f.active like ? and fullname like ? and title like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + star + "%");
            stm.setString(2, "%" + status + "%");
            stm.setString(3, "%" + fullname + "%");
            stm.setString(4, "%" + product + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public void updateStatusByFbID(String status, String fid) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[feedback]\n"
                    + "   SET [active] = ?\n"
                    + " WHERE feedback_id = ?");
            ps.setString(1, status);
            ps.setString(2, fid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    public static void main(String[] args) {
        new FeedbackDAO().insertFeedback("70", 1, "hi", "5", "hihi");
    }

}



