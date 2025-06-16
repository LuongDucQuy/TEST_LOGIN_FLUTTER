import 'package:test_flutter/database/database_helper.dart';

class LoginController {
  Future<String?> LoginUser(String email, String password) async {
    final user = await DatabaseHelper.instance.getUserByEmail(email);
    if (user == null) {
      return 'Email không tồn tại';
    }

    try {
      if (user.email == email && user.password == password) {
        return null;
      } else {
        return 'Thông tin đăng nhập không chính xác';
      }
    } catch (e) {
      return 'Đăng nhập không thành công: ${e.toString()}';
    }
  }
}
