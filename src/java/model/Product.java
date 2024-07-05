package model;
import java.sql.Date;
import java.util.ArrayList;
public class Product {
    private int id;
    private String title;
    private String brand;
    private double price;
    private double salePrice;
    private int stock;
    private String description;
    private String img;
    private String category;
    private Date createDate;
    private User author;
    private boolean active;
    private String brief;
    private ArrayList<StockColor> stockColor;
      
    public Product() {
    }

    public Product(String title) {
        this.title = title;
    }

    public Product(int id, String title, String brand, double price, double salePrice, int stock, String description, String img, String category, Date createDate, User author, boolean active) {
        this.id = id;
        this.title = title;
        this.brand = brand;
        this.price = price;
        this.salePrice = salePrice;
        this.stock = stock;
        this.description = description;
        this.img = img;
        this.category = category;
        this.createDate = createDate;
        this.author = author;
        this.active = active;
    }

    public Product( String img, String title) {
        this.title = title;
        this.img = img;
    }

    
    public Product(int id, String title, String brand, double price, double salePrice, int stock, String description, String img, String category, Date createDate, User author, boolean active, String brief) {
        this.id = id;
        this.title = title;
        this.brand = brand;
        this.price = price;
        this.salePrice = salePrice;
        this.stock = stock;
        this.description = description;
        this.img = img;
        this.category = category;
        this.createDate = createDate;
        this.author = author;
        this.active = active;
        this.brief = brief;
    }

    
    public Product(String title, double salePrice, double price, String description, String img) {
        this.title = title;       
        this.price = price;
        this.salePrice = salePrice;
        this.description = description;
        this.img = img;
    }

    public Product(int id, String title, double salePrice, double price, String description, String img,int stock) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.salePrice = salePrice;
        this.description = description;
        this.img = img;
        this.stock=stock;
    }
    public Product(int id, String title, double salePrice, double price, String description, String img) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.salePrice = salePrice;
        this.description = description;
        this.img = img;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    
    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public ArrayList<StockColor> getStockColor() {
        return stockColor;
    }

    public void setStockColor(ArrayList<StockColor> stockColor) {
        this.stockColor = stockColor;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", title=" + title + ", brand=" + brand + ", price=" + price + ", salePrice=" + salePrice + ", stock=" + stock + ", description=" + description + ", img=" + img + ", category=" + category + ", createDate=" + createDate + ", author=" + author + ", active=" + active + ", brief=" + brief + '}';
    }

  
}





