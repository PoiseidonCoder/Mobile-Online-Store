package model;
public class RoleFilter {
    private int roleId;
    private String url;

    public RoleFilter() {
    }

    public RoleFilter(int roleId, String url) {
        this.roleId = roleId;
        this.url = url;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}