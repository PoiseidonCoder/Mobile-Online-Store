package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import model.RoleFilter;
public class FilterDAO extends DBContext{
    public ArrayList<String> getAllPublicPath() {
        ArrayList<String> listPublicPath = new ArrayList<>();
        try {
            String sql = "select url from Feature where isPublic = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                
                listPublicPath.add(rs.getString(1));
            }
        } catch (SQLException e) {
        }
        return listPublicPath;
    }
    public LinkedHashMap<RoleFilter, Integer> getAllNonPublicPath() {
        LinkedHashMap<RoleFilter, Integer> listNonPublicPath = new LinkedHashMap<>();
        try {
            String sql = "select r.roleID,r.active,f.url from RoleAuthor r,Feature f where f.id = r.feature";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                RoleFilter roleFilter = new RoleFilter(rs.getInt(1),rs.getString(3));
                listNonPublicPath.put(roleFilter,rs.getInt(2));
            }
        } catch (SQLException e) {
        }
        return listNonPublicPath;
    }
}