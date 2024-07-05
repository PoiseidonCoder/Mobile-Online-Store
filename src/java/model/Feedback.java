package model;
import java.sql.Date;
public class Feedback {

    private int feedback_id;
    private int product_id;
    private User user;
    private int rated;
    private String fb_content;
    private String image;
    private Date feedback_date;
    private boolean active;
    private Product product;
                      
    public Feedback() {
    }

    public Feedback(int feedback_id, int product_id, User user, int rated, String fb_content, String image, Date feedback_date, boolean active) {
        this.feedback_id = feedback_id;
        this.product_id = product_id;
        this.user = user;
        this.rated = rated;
        this.fb_content = fb_content;
        this.image = image;
        this.feedback_date = feedback_date;
        this.active = active;
    }

    public Feedback(int feedback_id, User user, Product product, int rated, boolean active, String fb_content) {
        this.feedback_id = feedback_id;
        this.user = user;
        this.rated = rated;
        this.active = active;
        this.product = product;
        this.fb_content = fb_content;
    }

    public int getFeedback_id() {
        return feedback_id;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getRated() {
        return rated;
    }

    public void setRated(int rated) {
        this.rated = rated;
    }

    public String getFb_content() {
        return fb_content;
    }

    public void setFb_content(String fb_content) {
        this.fb_content = fb_content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getFeedback_date() {
        return feedback_date;
    }

    public void setFeedback_date(Date feedback_date) {
        this.feedback_date = feedback_date;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedback_id=" + feedback_id + ", product_id=" + product_id + ", user=" + user + ", rated=" + rated + ", fb_content=" + fb_content + ", image=" + image + ", feedback_date=" + feedback_date + ", active=" + active + ", product=" + product + '}';
    }

    
    

}



