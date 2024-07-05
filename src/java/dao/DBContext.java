package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;
public class DBContext {
     protected Connection connection;
    public DBContext()
    {
        try{
            String user="sa";
            String pass="1234";
            String url="jdbc:sqlserver://localhost:1433;databaseName=onlineShopSWP21";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        }
        catch(Exception ex)
        {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void main(String[] args) {
       new DBContext();
    }
}