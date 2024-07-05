package model;
public class Setting {
    private int setting_id;
    private String type;
    private String value;
    private int order;
    private boolean active;

    public Setting() {
    }

    public Setting(String value) {
        this.value = value;
    }

    public Setting(int setting_id, String type, String value, int order, boolean active) {
        this.setting_id = setting_id;
        this.type = type;
        this.value = value;
        this.order = order;
        this.active = active;
    }

    public int getSetting_id() {
        return setting_id;
    }

    public void setSetting_id(int setting_id) {
        this.setting_id = setting_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public boolean isActive() {
        return active;
    }

    public void setStattus(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "Setting{" + "setting_id=" + setting_id + ", type=" + type + ", value=" + value + ", order=" + order + ", active=" + active + '}';
    }
    
    
}



