package model;
public class Slide {

    private int silde_id;
    private String title;
    private String image;
    private String backlink;
    private int authot_id;
    private String description;
    private boolean active;

    public Slide() {
    }

    public Slide(int silde_id, String title, String image, String backlink, int authot_id, String description, boolean active) {
        this.silde_id = silde_id;
        this.title = title;
        this.image = image;
        this.backlink = backlink;
        this.authot_id = authot_id;
        this.description = description;
        this.active = active;
    }

    public Slide(String title, String image) {
        this.title = title;
        this.image = image;
    }

    public Slide(String title, String image, String description, String backlink) {
        this.title = title;
        this.image = image;
        this.description = description;
        this.backlink = backlink;

    }

    public int getSilde_id() {
        return silde_id;
    }

    public void setSilde_id(int silde_id) {
        this.silde_id = silde_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBacklink() {
        return backlink;
    }

    public void setBacklink(String backlink) {
        this.backlink = backlink;
    }

    public int getAuthot_id() {
        return authot_id;
    }

    public void setAuthot_id(int authot_id) {
        this.authot_id = authot_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

}


