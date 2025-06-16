import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class EmailService {
  static final smtpServer = gmail(
    'testabc151004@gmail.com',
    'vjbnixcuyykncfna',
  ); // dùng app password

  static Future<void> sendRegisterSuccessEmail(
    String toEmail,
    String userName,
  ) async {
    final message =
        Message()
          ..from = Address('testabc151004@gmail.com', 'App Support')
          ..recipients.add(toEmail)
          ..subject = 'Đăng ký thành công'
          ..text =
              'Chào $userName,\n\nTài khoản của bạn đã được đăng ký thành công.\n\nCảm ơn bạn!';

    try {
      await send(message, smtpServer);
      print('Email gửi thành công');
    } catch (e) {
      print('Lỗi gửi email: $e');
    }
  }

  static Future<String> sendResetPasswordEmail(
    String toEmail,
    String userName,
  ) async {
    final randomPassword = _generateRandomPassword();

    final message =
        Message()
          ..from = Address('testabc151004@gmail.com', 'App Support')
          ..recipients.add(toEmail)
          ..subject = 'Khôi phục mật khẩu'
          ..text = '''
                Chào $userName,

                Mật khẩu mới của bạn là: $randomPassword

                Vui lòng đăng nhập và đổi mật khẩu ngay sau khi đăng nhập.

                Trân trọng,
                App Support
                ''';

    try {
      await send(message, smtpServer);
      print('Email gửi thành công');
      return randomPassword;
    } catch (e) {
      print('Lỗi gửi email: $e');
      return '';
    }
  }

  static String _generateRandomPassword({int length = 8}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
      length,
      (index) => chars[Random().nextInt(chars.length)],
    ).join();
  }
}
