import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_flutter/features/auth/widgets/custom_text_field.dart';
import 'package:test_flutter/navigation/routers.dart';
import 'package:test_flutter/utils/validators.dart';
import '../widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3, child: _buildHeader(context)),
          Expanded(flex: 7, child: _buildFormCard()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Ảnh nền
        Image.asset('assets/images/toadanang.png', fit: BoxFit.cover),
        // Lớp phủ tối
        Container(color: Colors.indigo.withOpacity(0.8)),
        // Nội dung
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLogo(),
              const SizedBox(height: 8),
              _buildWelcomeText(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('assets/images/logo_utc2.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: const [
        Text(
          'Chào mừng trở lại',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Đăng nhập vào tài khoản của bạn',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              validator: Validators.validateEmail,
              controller: emailController,
              hint: 'Email',
              icon: Icons.email_outlined,
              isPassword: false,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              validator: Validators.validatePassword,
              controller: passwordController,
              hint: 'Mật khẩu',
              icon: Icons.lock_outline,
              isPassword: true,
              isPasswordVisible: isPasswordVisible,
              onToggleVisibility:
                  () => setState(() => isPasswordVisible = !isPasswordVisible),
            ),
            const SizedBox(height: 24),
            AuthButton(
              text: 'Đăng nhập',
              icon: Icons.login,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AuthRouter.goToRegister(context);
                } else {
                  Text(
                    'Vui lòng kiểm tra lại thông tin đăng nhập',
                    style: TextStyle(color: Colors.red),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  AuthRouter.goToForgotPassword(context);
                },
                icon: Icon(Icons.key, color: Colors.indigo),
                label: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            buildDividerWithText(),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: const [
                  Text(
                    'Chưa có tài khoản?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  AuthRouter.goToRegister(context);
                },
                icon: const Icon(Icons.person_add, color: Colors.indigo),
                label: const Text(
                  'Đăng ký ngay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDividerWithText() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('hoặc', style: TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
