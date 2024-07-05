package model;
public class StockColor {
    int id;
    int pid;
    int cid;
    int stock;
    String color;

    public StockColor(int id, int pid, int cid, int stock, String color) {
        this.id = id;
        this.pid = pid;
        this.cid = cid;
        this.stock = stock;
        this.color = color;
    }

    public StockColor() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
    
    
}
