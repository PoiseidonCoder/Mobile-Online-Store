package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Product;
import model.StockColor;
import model.User;

public class ProductDAO extends DBContext {

    //when get product always get with condition and then if have sort we will sort with a method 
    

    public ArrayList<Product> getAllProductByCondition(String brand, String category, String orderBy, String search, String priceRangeId, int index) {
        ArrayList<Product> proList = new ArrayList<>();
        String sort = "";
        switch (orderBy) {
            case "1":
                sort = " order by a.create_date desc";
                break;
            case "2":
                sort = " order by sale_price asc";
                break;
            case "3":
                sort = " order by sale_price desc";
                break;
            default:
                sort = " order by a.create_date desc";
        }
        int minPrice = 0;
        int maxPrice = 0;

        switch (priceRangeId) {
            case "24":
                minPrice = 300;
                maxPrice = 1000;
                break;
            case "25":
                minPrice = 1001;
                maxPrice = 2000;
                break;
            case "26":
                minPrice = 2001;
                maxPrice = 5000;
                break;
            case "27":
                minPrice = 5001;
                maxPrice = 10000;
                break;
            case "28":
                minPrice = 10001;
                maxPrice = 50000;
                break;
            case "29":
                minPrice = 50001;
                maxPrice = 100000;
                break;
            default:
                minPrice = 0;
                maxPrice = 100000;
                break;
        }
        try {
            String sql = "SELECT a.*, SUBSTRING(a.description, 0, 60) AS brief, b.category\n"
                    + "FROM (\n"
                    + "    SELECT p.*, s.[value] AS brand\n"
                    + "    FROM product p\n"
                    + "    JOIN setting AS s ON s.setting_id = p.brand_id\n"
                    + "    WHERE p.brand_id LIKE ?\n"
                    + ") AS a,\n"
                    + "(\n"
                    + "    SELECT p.product_id, s.[value] AS category\n"
                    + "    FROM product p\n"
                    + "    JOIN setting AS s ON s.setting_id = p.category_id\n"
                    + "    WHERE p.category_id LIKE ?\n"
                    + ") AS b\n"
                    + "WHERE a.product_id = b.product_id\n"
                    + "    AND a.active = 1\n"
                    + "    AND a.title LIKE ?\n"
                    + "    AND a.sale_price >= ?\n"
                    + "    AND a.sale_price < ?\n"
                    + sort
                    + "   OFFSET ? ROWS FETCH NEXT 9 ROWS ONLY";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + search + "%");
            stm.setInt(4, minPrice);
            stm.setInt(5, maxPrice);
            stm.setInt(6, (index - 1) * 9);
            ResultSet result = stm.executeQuery();

            while (result.next()) {
                Product p = new Product(result.getInt("product_id"), result.getString("title"), result.getString("brand"), result.getDouble("price"), result.getDouble("sale_price"), result.getInt("stock"),
                        result.getString("brief"), result.getString("img"), result.getString("category"), result.getDate("create_date"), new User(result.getInt("author_id")), result.getBoolean("active"));
                proList.add(p);
            }
        } catch (Exception e) {
        }
        return proList;
    }

    public int getStock(int pid) {
        ArrayList<StockColor> proList = new ArrayList<>();
        try {
            String sql = "select stock from product "
                    + "  where product_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getNumberProduct(String brand, String category, String search, String priceRangeId) {
        try {
            int minPrice = 0;
            int maxPrice = 0;

            switch (priceRangeId) {
                case "24":
                    minPrice = 300;
                    maxPrice = 1000;
                    break;
                case "25":
                    minPrice = 1001;
                    maxPrice = 2000;
                    break;
                case "26":
                    minPrice = 2001;
                    maxPrice = 5000;
                    break;
                case "27":
                    minPrice = 5001;
                    maxPrice = 10000;
                    break;
                case "28":
                    minPrice = 10001;
                    maxPrice = 50000;
                    break;
                case "29":
                    minPrice = 50001;
                    maxPrice = 100000;
                    break;
                default:
                    minPrice = 0;
                    maxPrice = 100000;
                    break;

            }
            String sql = "select count(a.product_id) as number from (select p.* , s.[value] as brand from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a,\n"
                    + " (select p.product_id, s.[value] as category from product p , setting as s\n"
                    + " where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id and a.active =1 and a.title like ? AND a.sale_price >= ? AND a.sale_price < ? \n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + search + "%");
            stm.setInt(4, minPrice);
            stm.setInt(5, maxPrice);
            ResultSet result = stm.executeQuery();

            while (result.next()) {
                int number = result.getInt(1);
                return number;
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Product getProductByID(int pid) {
        try {
            String sql = "select a.*, b.category from (select p.* , s.[value] as brand from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id ) as a,\n"
                    + " (select p.product_id, s.[value] as category from product p , setting as s\n"
                    + " where s.setting_id = p.category_id ) as b\n"
                    + " where a.product_id = b.product_id  and a.product_id = ?\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Product p = new Product(result.getInt("product_id"), result.getString("title"), result.getString("brand"), result.getDouble("price"), result.getDouble("sale_price"), result.getInt("stock"),
                        result.getString("description"), result.getString("img"), result.getString("category"), result.getDate("create_date"), new User(result.getInt("author_id")), result.getBoolean("active"));
                return p;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Product> getFearturedProduct() {
        ArrayList<Product> proList = new ArrayList<>();
        try {
            String sql = "SELECT TOP 6 product_id, title, sale_price, price, SUBSTRING(description, 0, 70) AS description, img\n,stock"
                    + " FROM product\n"
                    + " WHERE active = 1 AND stock > 0\n"
                    + " ORDER BY create_date DESC;";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                proList.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return proList;
    }

    public int getNumberProduct(String brand, String category, String search) {
        try {
            String sql = "select count(a.product_id) as number from (select p.* , s.[value] as brand from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a,\n"
                    + " (select p.product_id, s.[value] as category from product p , setting as s\n"
                    + " where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id and a.active =1 and a.title like ? \n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + search + "%");
            ResultSet result = stm.executeQuery();

            while (result.next()) {
                int number = result.getInt(1);
                return number;
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList<Product> getRecommendPro(String category, int index) {
        ArrayList<Product> proList = new ArrayList<>();
        try {
            String sql = " select p.* , s.[value] as brand from product p , setting s \n"
                    + " where s.setting_id = p.category_id and p.active =1 and s.[value] like ?\n"
                    + " order by  p.create_date OFFSET ? ROWS FETCH NEXT 3  ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + category + "%");
            stm.setInt(2, index);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getDouble(5), rs.getDouble(4), rs.getString(7), rs.getString(8),rs.getInt(6));
                proList.add(p);
            }
        } catch (Exception e) {
        }
        return proList;
    }

    public void updateStockByProductID(int stock, int productID) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[product]\n"
                    + "   SET [stock] = ?\n"
                    + " WHERE product_id = ?");
            ps.setInt(1, stock);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getTotalNumberProduct() {
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

    public ArrayList<Product> getAllProductForMarketing(int id, String brand, String category, String status, String title, String brief, int index) {
        ArrayList<Product> proList = new ArrayList<>();
        try {
            String sql = "select a.*, b.category from (select p.* , s.[value] as brand, substring([description],0,60) as brief from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a, \n"
                    + "	(select p.product_id, s.[value] as category from product p , setting as s\n"
                    + "  where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id  and a.title like ? and  a.brief like ? and a.active like ? and author_id = ?\n"
                    + "	order by a.product_id asc OFFSET  ? ROWS FETCH NEXT 15  ROWS ONLY;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + title + "%");
            stm.setString(4, "%" + brief + "%");
            stm.setString(5, "%" + status + "%");
            stm.setInt(6, id);
            stm.setInt(7, (index - 1) * 15);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Product p = new Product(result.getInt("product_id"), result.getString("title"), result.getString("brand"), result.getDouble("price"), result.getDouble("sale_price"), result.getInt("stock"),
                        result.getString("description"), result.getString("img"), result.getString("category"), result.getDate("create_date"), new User(result.getInt("author_id")), result.getBoolean("active"));
                p.setBrief(result.getString("brief"));
                proList.add(p);
            }
        } catch (Exception e) {
        }
        return proList;
    }

    public ArrayList<Product> getAllProductForMarketingByAdmin(String brand, String category, String status, String title, String brief, int index) {
        ArrayList<Product> proList = new ArrayList<>();
        try {
            String sql = "  select a.*, b.category from (select p.* , s.[value] as brand, substring([description],0,60) as brief from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a, \n"
                    + "	(select p.product_id, s.[value] as category from product p , setting as s\n"
                    + "  where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id  and a.title like ? and  a.brief like ? and a.active like ?\n"
                    + "	order by a.product_id asc OFFSET  ? ROWS FETCH NEXT 15  ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + title + "%");
            stm.setString(4, "%" + brief + "%");
            stm.setString(5, "%" + status + "%");
            stm.setInt(6, (index - 1) * 15);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                Product p = new Product(result.getInt("product_id"), result.getString("title"), result.getString("brand"), result.getDouble("price"), result.getDouble("sale_price"), result.getInt("stock"),
                        result.getString("description"), result.getString("img"), result.getString("category"), result.getDate("create_date"), new User(result.getInt("author_id")), result.getBoolean("active"));
                p.setBrief(result.getString("brief"));
                proList.add(p);
            }
        } catch (Exception e) {
        }
        return proList;
    }

    public int getNumberProductForMarketingByAdmin(String brand, String category, String status, String title, String brief) {
        try {
            String sql = "  select count(*)  from (select p.* , s.[value] as brand, substring([description],0,50) as brief from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a, \n"
                    + "	(select p.product_id, s.[value] as category from product p , setting as s\n"
                    + "  where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id  and a.title like ? and  a.brief like ? and a.active like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + title + "%");
            stm.setString(4, "%" + brief + "%");
            stm.setString(5, "%" + status + "%");
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getNumberProductForMarketing(int id, String brand, String category, String status, String title, String brief) {
        try {
            String sql = "  select count(*)  from (select p.* , s.[value] as brand, substring([description],0,50) as brief from product p , setting as s \n"
                    + " where s.setting_id = p.brand_id and p.brand_id like ? ) as a, \n"
                    + "	(select p.product_id, s.[value] as category from product p , setting as s\n"
                    + "  where s.setting_id = p.category_id and p.category_id like ?) as b\n"
                    + " where a.product_id = b.product_id  and a.title like ? and  a.brief like ? and a.active like ? and author_id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + brand + "%");
            stm.setString(2, "%" + category + "%");
            stm.setString(3, "%" + title + "%");
            stm.setString(4, "%" + brief + "%");
            stm.setString(5, "%" + status + "%");
            stm.setInt(6, id);
            ResultSet result = stm.executeQuery();
            while (result.next()) {
                return result.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateProduct(String title, int brandId, double price, double salePrice, int stock, String description, String img, int cateId, int pid, String createDate, int active) {
        try {
            String sql = "  update product set [title] = ? ,[brand_id] = ?  ,[price]  = ? ,[sale_price]  = ? ,[stock] = ? ,[description] = ? ,[img]=? , \n"
                    + "  [category_id] = ? ,[create_date] = ? ,[active] = ?  where product_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, title);
            stm.setInt(2, brandId);
            stm.setDouble(3, price);
            stm.setDouble(4, salePrice);
            stm.setInt(5, stock);
            stm.setString(6, description);
            stm.setString(7, img);
            stm.setInt(8, cateId);
            stm.setString(9, createDate);
            stm.setInt(10, active);
            stm.setInt(11, pid);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addNewProduct(String title, int brandId, double price, double salePrice, int stock, String description, String img, int cateId, int userId, int status) {
        try {
            String sql = "  insert into product ([title],[brand_id] ,[price] ,[sale_price] ,[stock],[description],[img] ,[category_id],[create_date],[author_id],[active])\n"
                    + "  values (?,?,?,?,?,?,?,?,GETDATE(),?,?)  ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, title);
            stm.setInt(2, brandId);
            stm.setDouble(3, price);
            stm.setDouble(4, salePrice);
            stm.setInt(5, stock);
            stm.setString(6, description);
            stm.setString(7, img);
            stm.setInt(8, cateId);
            stm.setInt(9, userId);
            stm.setInt(10, status);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void switchProduct(int pid, int sstatus) {
        try {
            String sql = " UPDATE product set [active] = ? where product_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sstatus);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteProduct(int pid) {
        try {
            String sql = " delete from feedback where product_id =?\n"
                    + "  delete from product where product_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        for (Product p : new ProductDAO().getFearturedProduct()) {
            System.out.println(p);
        }
    }

}
