package model;
import java.sql.Date;
public class Order {
    private int order_id;
    private int user_id;
    private String fullname;
    private String address;
    private String phone;
    private Date order_date;
    private double total;
    private int payment_id;
    private int status_id;
    private boolean active;
    private String note;
    private String status;
    private int numberPro;
    private Setting setting;
    private User u;
    private int numberOrder;

    public Order() {
    }

    public Order(String status, int numberOrder) {
        this.status = status;
        this.numberOrder = numberOrder;
    }

    public Order(int order_id, Setting setting, String fullname, String address, String phone, Date order_date, double total) {
        this.order_id = order_id;
        this.setting = setting;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.order_date = order_date;
        this.total = total;
    }

    public Setting getSetting() {
        return setting;
    }

    public Order(int order_id, int user_id, String fullname, String address, String phone, Date order_date, double total, int payment_id, boolean active, String note, String status) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.order_date = order_date;
        this.total = total;
        this.payment_id = payment_id;
        this.active = active;
        this.note = note;
        this.status = status;
    }

    public Order(int order_id, int user_id, String fullname, String address, String phone, Date order_date, double total, int payment_id, boolean active, String note, String status, int numberPro) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.order_date = order_date;
        this.total = total;
        this.payment_id = payment_id;
        this.active = active;
        this.note = note;
        this.status = status;
        this.numberPro = numberPro;
    }

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }

    public int getNumberOrder() {
        return numberOrder;
    }

    public void setNumberOrder(int numberOrder) {
        this.numberOrder = numberOrder;
    }

    
    public int getNumberPro() {
        return numberPro;
    }

    public void setNumberPro(int numberPro) {
        this.numberPro = numberPro;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" + "order_id=" + order_id + ", user_id=" + user_id + ", fullname=" + fullname + ", address=" + address + ", phone=" + phone + ", order_date=" + order_date + ", total=" + total + ", payment_id=" + payment_id + ", status_id=" + status_id + ", active=" + active + ", note=" + note + ", status=" + status + ", numberPro=" + numberPro + ", setting=" + setting + '}';
    }
    
}



