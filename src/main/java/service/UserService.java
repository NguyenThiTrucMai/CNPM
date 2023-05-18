package service;

import db.JDBIConnector;
import helper.Contants;
import helper.SendMail;
import model.User;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.stream.Collectors;

// https://jdbi.org/#_quick_links
// https://jdbi.org/#_resource_management

public class UserService {
	private static UserService instance;

	private UserService() {
	}

	public static UserService getInstance() {
		if (instance == null) {
			instance = new UserService();
		}
		return instance;
	}
	// 1.1 UserService lấy thông tin người dùng qua database (Hiếu)
	public static List<User> getData() {
		return JDBIConnector.get().withHandle(handle -> {
			return handle.createQuery("select * from user").mapToBean(User.class).stream().collect(Collectors.toList());
		});
	}
	public static User getUserByEmail(String email) {
		List<User> users = JDBIConnector.get()
				.withHandle(h -> h.createQuery("select * from user where email = ? and status = 1").bind(0, email)
						.mapToBean(User.class).stream().collect(Collectors.toList()));
		if (users.size() == 0)
			return null;
		return users.get(0);
	}
	//2.1 UserService lấy thông tin từ database để check coi tên người dùng có tồn tại chưa (Hiếu)
	public static boolean checkUserNameExist(String username) {
		List<User> users = JDBIConnector.get()
				.withHandle(h -> h.createQuery("select * from user where username = ? and status = 1").bind(0, username)
						.mapToBean(User.class).stream().collect(Collectors.toList()));
		if (users.size() == 0)
			//2.2 Nếu tên người dùng trùng thì trả lại kết quả là false (Hiếu)
			return false;
		return true;
	}

	public static User dangNhap(String username, String password) {
		// 7. Hệ thống kiểm tra dữ liệu ở Database (Mai)
		List<User> users = JDBIConnector.get()
				.withHandle(h -> h.createQuery("select * from user where username = ? and status = 1").bind(0, username)
						.mapToBean(User.class).stream().collect(Collectors.toList()));
		if (users.size() == 0)
			return null;
		User user = users.get(0);
		// mật khẩu lưu db có mã hóa (Mai)
		if (!user.getPassword().equals(hashPassword(password)))
			return null;
		return user;
	}

	public static String hashPassword(String password) {
		// https://www.baeldung.com/sha-256-hashing-java
		try {
			MessageDigest sha256 = null;
			sha256 = MessageDigest.getInstance("SHA-256");
			byte[] hash = sha256.digest(password.getBytes());
			BigInteger number = new BigInteger(1, hash);
			return number.toString(16);
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}

	// đăng ký user (Mai)
	// thêm mới user - admin chủ động setup là admin hay kh nên không cần set role (Mai)
	public static int addRegister(User input) {
		String pass = hashPassword(input.getPassword());// để bảo mật thì cần hash mật khẩu trước khi lưu
		input.setPassword(pass);// lưu password đã được mã hóa để bảo mật

		input.setStatus(1);
		input.setRole(Contants.ROLE_CUSTOMER);
		return insertUser(input);
	}

	// https://jdbi.org/#_updates
	// https://stackoverflow.com/questions/48361387/get-primary-keys-of-updated-rows-when-doing-an-update-with-jdbi
	// https://jdbi.org/#_generated_keys
	public static int insertUser(User input) {
		try {
			// query > insert
			String query = "INSERT INTO user (`lastname`,`firstname`,`email`,`username`,`phone`,`password`,`role`,`status`) VALUES( ?, ?, ?, ?, ?, ?, ?, ?)";
			int result = JDBIConnector.get().withHandle(handle -> {
				int id = handle.createUpdate(query).bind(0, input.getLastname()).bind(1, input.getFirstname())
						.bind(2, input.getEmail()).bind(3, input.getUsername()).bind(4, input.getPhone())
						.bind(5, input.getPassword()).bind(6, input.getRole()).bind(7, input.getStatus())
						.executeAndReturnGeneratedKeys().mapTo(Integer.class).findOnly();
				// .execute();
				return id;
			});
			return result;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	// 3.1 UserService bắt đầu cập nhật dữ liệu người dùng trong database (Hiếu)
	public static boolean updateUserByIdUser(int userId, User user) {
		// query > insert
		String query = "update user set lastname=?, firstname=?, username=?, email=?, phone=? where iduser = ? and status = 1";
		int result = JDBIConnector.get().withHandle(handle -> {
			int count = handle.createUpdate(query).bind(0, user.getLastname()).bind(1, user.getFirstname())
					.bind(2, user.getUsername()).bind(3, user.getEmail()).bind(4, user.getPhone()).bind(5, userId)
					.execute();
			return count;
		});
		if (result == 1) {
			return true;
		}
		return false;
	}

	public static boolean updatePassByIdUser(int iduser, User user) {
		System.out.println(iduser);
		System.out.println(user.getPassword());
		// query > insert
		String query = "update user set  password=? where iduser = ? and status =1";
		int result = JDBIConnector.get().withHandle(handle -> {
			int count = handle.createUpdate(query).bind(0, user.getPassword()).bind(1, iduser).execute();
			return count;
		});
		if (result == 1) {
			return true;
		}
		return false;
	}

	// gửi phản hồi cho đăng ký nhận thông báo ở footer (Mai)
	public boolean getMailNotify(String email) {
		String qCheckUser = "SELECT firstname, lastname, username FROM `user` WHERE email=?";
		List<User> users = JDBIConnector.get().withHandle(handle -> handle.createQuery(qCheckUser).bind(0, email)
				.mapToBean(User.class).stream().collect(Collectors.toList()));
		String content = "";
		if (users.size() != 1) {
			content = "G15 xin chào,\nG15 xác nhận đăng ký nhận thông báo thành công!\nCảm ơn bạn đã quan tâm các sản phẩm của G15. Các chuương trình giảm giá, ưu đãi sẽ được gửi về địa chỉ email: "
					+ email + "\nChúc bạn một ngày tốt lành,\nG15";
			SendMail.sendMail(email, "Đăng ký mail nhận thông báo", content);
			System.out.println("Thành công! Khách hàng chưa đăng ký");
		} else {
			User user = users.get(0);
			content = "G15 xin chào " + user.getFirstname()
					+ ",\nG15 xác nhận đăng ký nhận thông báo thành công!\nCảm ơn bạn đã quan tâm các sản phẩm của G15. Các chuương trình giảm giá, ưu đãi sẽ được gửi về địa chỉ email: "
					+ email + "\nChúc bạn một ngày tốt lành,\nG15";
			SendMail.sendMail(email, "Đăng ký mail nhận thông báo", content);
			System.out.println("Thành công! Khách hàng " + user.getFirstname());
			return true;
		}
		return false;
	}

	// Gửi email xác nhận đặt lịch hẹn (Mai)
	public boolean getMailContact(String name, String email, String phone, String date, String msg) {
		String qCheckUser = "SELECT firstname, lastname, username FROM `user` WHERE email=?";
		List<User> users = JDBIConnector.get().withHandle(handle -> handle.createQuery(qCheckUser).bind(0, email)
				.mapToBean(User.class).stream().collect(Collectors.toList()));
		String content = "";
		if (!email.equals("")) {
			content = "G15 xin chào,\nG15 gửi email xác nhận yêu cầu \"Đặt lịch hẹn\" của " + name;
			content += "\n Họ và tên: " + name;
			content += "\n Email: " + email;
			content += "\n Số điện thoại: " + phone;
			content += "\n Ngày hẹn: " + date;
			content += "\n Yêu cầu: \"" + msg + "\"";
			content += "\nChúng tôi sẽ liên hệ bằng cuộc gọi thêm lần nữa sau 24H!\nCảm ơn bạn đã quan tâm!\nG15";
			System.out.println("Đặt lịch hẹn thành công");
			SendMail.sendMail(email, "Đặt lịch hẹn", content);
			return true;
		} else {
			System.out.println("Đặt lịch hẹn thất bại");
		}
		return false;
	}

	// send-mail reset password (Mai)
	public boolean passwordRecovery(String email) {
		User user = getUserByEmail(email);
		if (user != null) {

			// Cập nhật tài khoản về mật khẩu mặc định
			user.setPassword(hashPassword(Contants.PASSWORD_DEFAULT));
			boolean idUpdate = updateUserByIdUser(user.getIduser(), user);
			System.out.println(idUpdate);
			System.out.println("reset password");

			String textMail = "! Chào mừng bạn đến với MBA. Tên đăng nhập: " + user.getUsername() + ", Mật khẩu: "
					+ Contants.PASSWORD_DEFAULT;
			SendMail.sendMail(email, "[Web Đặt May MBA] Password-Recovery", textMail);
			return true;
		}
		return false;
	}

	public User getDetailUserByIdUser(int iduser) {
		System.out.println(iduser);
		String query = "select * FROM user where iduser=?";
		List<User> datas = JDBIConnector.get().withHandle(handle -> {
			return handle.createQuery(query).bind(0, iduser).mapToBean(User.class).stream()
					.collect(Collectors.toList());
		});
		if (datas.size() > 0) {
			return datas.get(0);// lấy duy nhất 1 sản phẩm
		}
		return null;
	}


}
