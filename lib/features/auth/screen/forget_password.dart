import 'package:flutter/material.dart';
import 'package:test_flutter/database/database_helper.dart';
import 'package:test_flutter/navigation/routers.dart';
import 'package:test_flutter/utils/email_service.dart';
import 'package:test_flutter/utils/validators.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_button.dart';
import 'package:test_flutter/models/user_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: AuthHeader(
              title: 'Quên mật khẩu?',
              subtitle: 'Đừng lo lắng, chúng tôi sẽ giúp bạn',
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildGuideBox(),
                    const SizedBox(height: 16),
                    CustomTextField(
                      validator: Validators.validateEmail,
                      controller: emailController,
                      hint: 'Địa chỉ email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 24),
                    AuthButton(
                      text: 'Gửi liên kết đặt lại',
                      icon: Icons.send,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        final user = await DatabaseHelper.instance
                            .getUserByEmail(emailController.text.trim());
                        if (user != null) {
                          final newPass =
                              await EmailService.sendResetPasswordEmail(
                                emailController.text,
                                user.name!,
                              );
                          if (newPass.isNotEmpty) {
                            final updatedUser = User(password: newPass);
                            await DatabaseHelper.instance.updateUser(
                              updatedUser,
                            );
                          }
                          AuthRouter.goToLogin(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Email không tồn tại trong hệ thống',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton.icon(
                        onPressed: () => AuthRouter.goToLogin(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.indigo,
                        ),
                        label: const Text('Quay lại đăng nhập'),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGuideBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.info, size: 16, color: Colors.indigo),
                      SizedBox(width: 4),
                      Text(
                        'Hướng dẫn',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nhập địa chỉ email đã đăng ký để nhận liên kết đặt lại mật khẩu. Kiểm tra cả hộp thư rác nếu không thấy email.',
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
