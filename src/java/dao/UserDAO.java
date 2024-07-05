package dao;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import model.User;
import service.MD5;
import service.SendMail;

public class UserDAO extends DBContext {

    public User getUserByEmail(String email) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM [User] WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getBoolean(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getString(10), rs.getString(11));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public String getEmailByID(int id) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM [dbo].[user] where [user_id] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString("email");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean checkLogin(String email, String password) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM [User] WHERE email = ? AND password = ? and active = 1");
            ps.setString(1, email);
            ps.setString(2, MD5.getMd5(password));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void insertUser(String fullname, String phone, String address, String email, String password, int gender) {
        try {
            String randomKey = MD5.getMd5(String.valueOf(new Random().nextInt(999999)));
            PreparedStatement ps = connection.prepareStatement("INSERT INTO [dbo].[user]\n"
                    + "           ([fullname]\n"
                    + "           ,[email]\n"
                    + "           ,[password]\n"
                    + "           ,[gender]\n"
                    + "           ,[phone]\n"
                    + "           ,[address]\n"
                    + "           ,[role]\n"
                    + "           ,[active]\n"
                    + "           ,[key]"
                    + "           ,[avatar])\n"
                    + "     VALUES (?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, MD5.getMd5(password));
            ps.setInt(4, gender);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.setInt(7, 2);
            ps.setInt(8, 0);
            ps.setString(9, randomKey);
            ps.setString(10, "https://iconape.com/wp-content/files/im/10836/svg/iconfinder_3_avatar_2754579.svg");
            SendMail.send(email, "Xác minh đăng ký Shop10Diem", messageRegister(fullname, phone, address, email, randomKey));
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    private String messageRegister(String fullname, String phone, String address, String email, String randomKey) {
        return "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n"
                + "    <title>Document</title>\n"
                + "</head>\n"
                + "\n"
                + "<body>\n"
                + "    <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n"
                + "        <tbody>\n"
                + "            <tr>\n"
                + "                <td style=\"border-collapse:collapse;border-left:1px solid #ff6e40;border-right:1px solid #ff6e40\">\n"
                + "                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n"
                + "                        <tbody>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:18px 20px 20px 20px;vertical-align:middle;line-height:20px;font-family:Arial;background-color:#ff6e40;text-align:center\">\n"
                + "                                    <span style=\"color:#ffffff;font-size:115%;text-transform:uppercase\">Tài khoản hoạt động\n"
                + "                                    </span> </td>\n"
                + "                            </tr>\n"
                + "\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px\"> <span style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif;line-height:18px\">\n"
                + "                                        Chúng tôi đã nhận được yêu cầu mở tài khoản với thông tin chính sau:</span>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:20px 0px 12px 0px\">\n"
                + "                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n"
                + "                                        <tbody>\n"
                + "                                            <tr>\n"
                + "                                                <td style=\"padding:8px 10px 8px 20px;font-family:Arial,Helvetica,sans-serif;color:#666666;font-size:12px;border-bottom:1px solid #dcdcdc\" align=\"right\"><span>Họ và tên:</span></td>\n"
                + "                                                <td style=\"padding:8px 20px 8px 10px;font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#2525253;border-bottom:1px solid #dcdcdc\" align=\"left\"><strong>" + fullname + "</strong></td>\n"
                + "                                            </tr>\n"
                + "                                            <tr>\n"
                + "                                                <td style=\"padding:8px 10px 8px 20px;font-family:Arial,Helvetica,sans-serif;color:#666666;font-size:12px;border-bottom:1px solid #dcdcdc\" align=\"right\"><span>Email:\n"
                + "                                                    </span></td>\n"
                + "                                                <td style=\"padding:8px 20px 8px 10px;font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#2525253;border-bottom:1px solid #dcdcdc\" align=\"left\"><a href=\"mailto:" + email + "\" target=\"_blank\">" + email + "</a></td>\n"
                + "                                            </tr>\n"
                + "                                            <tr>\n"
                + "                                                <td style=\"padding:8px 10px 8px 20px;font-family:Arial,Helvetica,sans-serif;color:#666666;font-size:12px;border-bottom:1px solid #dcdcdc\" align=\"right\"><span>Số điện thoại:\n"
                + "                                                    </span></td>\n"
                + "                                                <td style=\"padding:8px 20px 8px 10px;font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#2525253;border-bottom:1px solid #dcdcdc\" align=\"left\">" + phone + "</td>\n"
                + "                                            </tr>\n"
                + "                                            <tr>\n"
                + "                                                <td style=\"padding:8px 10px 8px 20px;font-family:Arial,Helvetica,sans-serif;color:#666666;font-size:12px;border-bottom:1px solid #dcdcdc\" align=\"right\"><span>Địa chỉ:\n"
                + "                                                    </span></td>\n"
                + "                                                <td style=\"padding:8px 20px 8px 10px;font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#2525253;border-bottom:1px solid #dcdcdc\" align=\"left\">" + address + "</td>\n"
                + "                                            </tr>\n"
                + "                                        </tbody>\n"
                + "                                    </table>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px\"> <strong style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif;line-height:18px\">\n"
                + "                                        Để tiếp tục quá trình đăng ký, vui lòng nhấp vào liên kết bên dưới:</strong> </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:10px 20px 12px 20px\">\n"
                + "                                    <div style=\"background:rgb(255,248,204);border:1px solid rgb(255,140,0);padding:10px;border-radius:3px 3px 0px 0px;font-size:11px;font-family:'Courier New',Courier,monospace\" align=\"center\"> <a title=\"Đường dẫn kích hoạt tài khoản\" href=\"http://localhost:8080/onlineShop/verify?action=register&email=" + email + "&key=" + randomKey + "\" style=\"text-decoration:none;color:#252525\" target=\"_blank\">http://localhost:8080/onlineShop/verify?action=register&email=" + email + "&key=" + randomKey + "</a>\n"
                + "                                    </div>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </tbody>\n"
                + "                    </table>\n"
                + "                </td>\n"
                + "            </tr>\n"
                + "            <tr>\n"
                + "                <td>\n"
                + "                    <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
                + "                        <tbody>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px;border-left:1px solid #ff6e40;border-right:1px solid #ff6e40\"><span style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif\">Cảm ơn bạn đã quan tâm và sử dụng dịch vụ của chúng tôi</span> </td>\n"
                + "                            </tr>\n"
                + "                        </tbody>\n"
                + "                    </table>\n"
                + "                </td>\n"
                + "            </tr>\n"
                + "        </tbody>\n"
                + "    </table>\n"
                + "</body>\n"
                + "\n"
                + "</html>";
    }

    public boolean checkEmail(String email) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM [User] WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public int totalUser() {
        try {
            PreparedStatement ps = connection.prepareStatement("select count(*)\n"
                    + "from [dbo].[user]\n"
                    + "where role !=1");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public boolean isValidEmail(String email) {
        return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

    public boolean isValidPhoneNumber(String phone) {
        return phone.matches("^0\\d{9}$");
    }

    public boolean checkEmailAndKey(String email, String keyRandom) {
        try {
            PreparedStatement ps = connection.prepareStatement("select * from [user] where email = ? and [key] = ?");
            ps.setString(1, email);
            ps.setString(2, keyRandom);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void activeAccount(String email) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[user]\n"
                    + "   SET [active] = 1\n"
                    + "      ,[key] = NULL\n"
                    + " WHERE email = ?");
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertKey(String email) {
        try {
            String randomKey = MD5.getMd5(String.valueOf(new Random().nextInt(999999)));
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[user]\n"
                    + "   SET [key] = ?\n"
                    + " WHERE email = ?");
            ps.setString(1, randomKey);
            ps.setString(2, email);
            SendMail.send(email, "Xác minh reset mật khẩu Shop10Diem", messageResetPass(email, randomKey));
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    private String messageResetPass(String email, String randomKey) {
        return "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n"
                + "    <title>Document</title>\n"
                + "</head>\n"
                + "\n"
                + "<body>\n"
                + "    <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">\n"
                + "        <tbody>\n"
                + "            <tr>\n"
                + "                <td style=\"border-collapse:collapse;border-left:1px solid #ff6e40;border-right:1px solid #ff6e40\">\n"
                + "                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n"
                + "                        <tbody>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:18px 20px 20px 20px;vertical-align:middle;line-height:20px;font-family:Arial;background-color:#ff6e40;text-align:center\">\n"
                + "                                    <span style=\"color:#ffffff;font-size:115%;text-transform:uppercase\">Active account\n"
                + "                                    </span> </td>\n"
                + "                            </tr>\n"
                + "\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px\"> <span style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif;line-height:18px\">\n"
                + "                                        Chúng tôi đã nhận được yêu cầu mở tài khoản với thông tin chính sau:</span>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:20px 0px 12px 0px\">\n"
                + "                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n"
                + "                                        <tbody>\n"
                + "                                        </tbody>\n"
                + "                                    </table>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px\"> <strong style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif;line-height:18px\">\n"
                + "                                        Để tiếp tục quá trình đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới:</strong> </td>\n"
                + "                            </tr>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:10px 20px 12px 20px\">\n"
                + "                                    <div style=\"background:rgb(255,248,204);border:1px solid rgb(255,140,0);padding:10px;border-radius:3px 3px 0px 0px;font-size:11px;font-family:'Courier New',Courier,monospace\" align=\"center\"> <a title=\"Đường dẫn kích hoạt tài khoản\" href=\"http://localhost:8080/onlineShop/verify?action=forgot&email=" + email + "&key=" + randomKey + "\" style=\"text-decoration:none;color:#252525\" target=\"_blank\">http://localhost:8080/onlineShop/verify?action=forgot&email=" + email + "&key=" + randomKey + "</a>\n"
                + "                                    </div>\n"
                + "                                </td>\n"
                + "                            </tr>\n"
                + "                        </tbody>\n"
                + "                    </table>\n"
                + "                </td>\n"
                + "            </tr>\n"
                + "            <tr>\n"
                + "                <td>\n"
                + "                    <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
                + "                        <tbody>\n"
                + "                            <tr>\n"
                + "                                <td style=\"padding:4px 20px 12px 20px;border-left:1px solid #ff6e40;border-right:1px solid #ff6e40\"><span style=\"font-size:12px;color:#252525;font-family:Arial,Helvetica,sans-serif\">Thank you for your interest and use of our services</span> </td>\n"
                + "                            </tr>\n"
                + "                        </tbody>\n"
                + "                    </table>\n"
                + "                </td>\n"
                + "            </tr>\n"
                + "        </tbody>\n"
                + "    </table>\n"
                + "</body>\n"
                + "\n"
                + "</html>";
    }

    public void updatePassword(String email, String password) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[user]\n"
                    + "   SET [password] = ?\n"
                    + "      ,[key] = NULL\n"
                    + " WHERE email = ?");
            ps.setString(1, MD5.getMd5(password));
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void genarateQRCode(String data, String path, String charset, int h, int w) throws WriterException, IOException {
        BitMatrix bitMatrix = new MultiFormatWriter().encode(data, BarcodeFormat.QR_CODE, w, h);
        MatrixToImageWriter.writeToPath(bitMatrix, path.substring(path.lastIndexOf('.') + 1), Paths.get(path));
    }

    public void updateProfile(String fullname, int gender, String phone, String address, String avatar, String email) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[user]\n"
                    + "   SET [fullname] = ?\n"
                    + "      ,[gender] = ?\n"
                    + "      ,[phone] = ?\n"
                    + "      ,[address] =? \n"
                    + "      ,[avatar] = ?\n"
                    + " WHERE email = ?");
            ps.setString(1, fullname);
            ps.setInt(2, gender);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, avatar);
            ps.setString(6, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<User> getAll(int id, String fullname, String email) {
        ArrayList<User> list = new ArrayList<User>();
        String sql = "SELECT [user_id], [fullname], [email], [password], [gender], [phone], [address], [role], [active], [key], [avatar] "
                + "FROM [User] WHERE 1 = 1 ";

        // Add conditions for filtering based on input parameters
        if (id > 0) {
            sql += "AND [user_id] = ? ";
        }
        if (fullname != null) {
            sql += "AND [fullname] LIKE ? ";
        }
        if (email != null) {
            sql += "AND [email] LIKE ? ";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set parameters based on the provided input
            int parameterIndex = 1;
            if (id > 0) {
                ps.setInt(parameterIndex++, id);
            }
            if (fullname != null) {
                ps.setString(parameterIndex++, "%" + fullname + "%");
            }
            if (email != null) {
                ps.setString(parameterIndex++, "%" + email + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(rs.getInt("user_id"), rs.getString("fullname"), rs.getString("email"), rs.getString("gender").equals("1") ? true : false, rs.getString("phone"), rs.getString("address"), rs.getString("avatar")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteAccount(int user_id) {
        try {
            String sql = "DELETE FROM [dbo].[feedback] WHERE user_id = ?\n"
                    + "DELETE FROM [dbo].[product] WHERE [author_id] = ?\n"
                    + "DELETE FROM [dbo].[slide] WHERE author_id = ?\n"
                    + "DELETE FROM [order_detail] WHERE author_id = ?\n"
                    + "DELETE FROM [order] WHERE user_id = ?\n"
                    + "DELETE FROM [cart] WHERE user_id = ?\n"
                    + "DELETE FROM [user] WHERE user_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, user_id);
            stm.setInt(2, user_id);
            stm.setInt(3, user_id);
            stm.setInt(4, user_id);
            stm.setInt(5, user_id);
            stm.setInt(6, user_id);
            stm.setInt(7, user_id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isValidName(String fullname) {
        return fullname.matches("^[a-zA-ZÀ-ỹ ]+$");
    }

    public static void main(String[] args) {
        new UserDAO().deleteAccount(7);
    }

}
