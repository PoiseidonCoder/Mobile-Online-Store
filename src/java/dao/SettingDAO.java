package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Setting;
public class SettingDAO extends DBContext {
    public ArrayList<Setting> getAllProCategory() {
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "select * from setting where orders = 2  and active =1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Setting s = new Setting(result.getInt("setting_id"), result.getString("type"), result.getString("value"),
                        result.getInt("orders"), result.getBoolean("active"));
                settingList.add(s);
            }
        } catch (Exception e) {
        }
        return settingList;
    }
    public ArrayList<Setting> getAllProPriceRange() {
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "SELECT * FROM setting WHERE orders = 9 AND active = 1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Setting s = new Setting(
                        result.getInt("setting_id"),
                        result.getString("type"),
                        result.getString("value"),
                        result.getInt("orders"),
                        result.getBoolean("active")
                );
                settingList.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return settingList;
    }

    public ArrayList<Setting> getAllProBrand() {
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "select * from setting where orders = 4 and active =1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Setting s = new Setting(result.getInt("setting_id"), result.getString("type"), result.getString("value"),
                        result.getInt("orders"), result.getBoolean("active"));
                settingList.add(s);
            }
        } catch (Exception e) {
        }
        return settingList;
    }

    public ArrayList<Setting> getAllOrderStatus() {
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "select * from setting where orders = 5 and active =1";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Setting s = new Setting(result.getInt("setting_id"), result.getString("type"), result.getString("value"),
                        result.getInt("orders"), result.getBoolean("active"));
                settingList.add(s);
            }
        } catch (Exception e) {
        }
        return settingList;
    }
}
