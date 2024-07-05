package model;
public class User {

    private int user_id;
    private String fullname;
    private String email;
    private String password;
    private boolean gender;
    private String phone;
    private String address;
    private int role;
    private int active;
    private String key;
    private String avatar;

    public User() {
    }

    public User(int user_id, String fullname) {
        this.user_id = user_id;
        this.fullname = fullname;
    }

    public User(String fullname, String email, String phone) {
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
    }

    public User(int user_id, String fullname, String email, boolean gender, String phone, String address, String avatar) {
        this.user_id = user_id;
        this.fullname = fullname;
        this.email = email;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.avatar = avatar;
    }
    

    public User(int user_id, String fullname, String email, String password, boolean gender, String phone, String address, int role, int active, String key, String avatar) {
        this.user_id = user_id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.active = active;
        this.key = key;
        this.avatar = avatar;
    }

    public User(int user_id) {
        this.user_id = user_id;
    }

    public User(int user_id, String fullname, String email, String phone, String avatar) {
        this.user_id = user_id;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.avatar = avatar;
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

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "User{" + "user_id=" + user_id + ", fullname=" + fullname + ", email=" + email + ", password=" + password + ", gender=" + gender + ", phone=" + phone + ", address=" + address + ", role=" + role + ", active=" + active + ", key=" + key + ", avatar=" + avatar + '}';
    }

}


