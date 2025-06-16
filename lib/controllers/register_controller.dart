import 'package:test_flutter/utils/email_service.dart';
import '../database/database_helper.dart';
import '../models/user_model.dart';

class RegisterController {
  Future<String?> registerUser(User user) async {
    final existingUser = await DatabaseHelper.instance.getUserByEmail(
      user.email!,
    );
    if (existingUser != null) {
      return 'Email đã được đăng kí';
    }

    try {
      await DatabaseHelper.instance.insertUser(user);
      await EmailService.sendRegisterSuccessEmail(user.email!, user.name!);
      return null;
    } catch (e) {
      return 'Đăng kí không thành công: ${e.toString()}';
    }
  }
}
