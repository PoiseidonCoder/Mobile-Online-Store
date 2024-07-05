package model;
public class OrderDetail {
    private int order_detail_id;
    private int order_id;
    private int quantity;
    private int product_id;
    private int author_id;
    private String title;
    private int brand_id;
    private float price;
    private float sale_price;
    private int stock;
    private String description;
    private String image;
    private int category_id;

    public OrderDetail() {
    }

    public OrderDetail(int quantity, String title) {
        this.quantity = quantity;
        this.title = title;
    }

    public OrderDetail(int order_detail_id, int order_id, int quantity, int product_id, String title, float price, float sale_price, String image) {
        this.order_detail_id = order_detail_id;
        this.order_id = order_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.title = title;
        this.price = price;
        this.sale_price = sale_price;
        this.image = image;
    }

    public OrderDetail(int order_detail_id, int order_id, int quantity, int product_id, int author_id, String title, int brand_id, float price, float sale_price, int stock, String description, String image, int category_id) {
        this.order_detail_id = order_detail_id;
        this.order_id = order_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.author_id = author_id;
        this.title = title;
        this.brand_id = brand_id;
        this.price = price;
        this.sale_price = sale_price;
        this.stock = stock;
        this.description = description;
        this.image = image;
        this.category_id = category_id;
    }

    public int getOrder_detail_id() {
        return order_detail_id;
    }

    public void setOrder_detail_id(int order_detail_id) {
        this.order_detail_id = order_detail_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getSale_price() {
        return sale_price;
    }

    public void setSale_price(float sale_price) {
        this.sale_price = sale_price;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "order_detail_id=" + order_detail_id + ", order_id=" + order_id + ", quantity=" + quantity + ", product_id=" + product_id + ", author_id=" + author_id + ", title=" + title + ", brand_id=" + brand_id + ", price=" + price + ", sale_price=" + sale_price + ", stock=" + stock + ", description=" + description + ", image=" + image + ", category_id=" + category_id + '}';
    }
    
}



