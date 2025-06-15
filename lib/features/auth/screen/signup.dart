import 'package:flutter/material.dart';
import 'package:test_flutter/navigation/routers.dart';
import 'package:test_flutter/utils/validators.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_button.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isConfirmVisible = false;
  bool isAgreed = false;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: AuthHeader(
              title: 'Tạo tài khoản mới',
              subtitle: 'Gia nhập cộng đồng UTC2 ngay hôm nay',
            ),
          ),
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNameField(),
                    _buildEmailField(),
                    _buildPhoneField(),
                    _buildDOBField(context),
                    _buildGenderDropdown(),
                    _buildPasswordField(),
                    _buildConfirmPasswordField(),
                    _buildAgreementCheckbox(),
                    const SizedBox(height: 24),
                    _buildRegisterButton(),
                    const SizedBox(height: 16),
                    buildDividerWithText(),
                    const SizedBox(height: 16),
                    _buildLoginRedirect(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() => Column(
    children: [
      CustomTextField(
        validator: Validators.validateName,
        controller: nameController,
        hint: 'Họ và tên',
        icon: Icons.person,
      ),
      const SizedBox(height: 16),
    ],
  );

  Widget _buildEmailField() => Column(
    children: [
      CustomTextField(
        validator: Validators.validateEmail,
        controller: emailController,
        hint: 'Email',
        icon: Icons.email,
      ),
      const SizedBox(height: 16),
    ],
  );

  Widget _buildPhoneField() => Column(
    children: [
      CustomTextField(
        validator: Validators.validatePhone,
        controller: phoneController,
        hint: 'Số điện thoại',
        icon: Icons.phone,
      ),
      const SizedBox(height: 16),
    ],
  );

  Widget _buildDOBField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: dobController,
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng chọn ngày sinh';
            }

            try {
              final dob = DateFormat('dd/MM/yyyy').parse(value);
              final today = DateTime.now();
              final age =
                  today.year -
                  dob.year -
                  (today.month < dob.month ||
                          (today.month == dob.month && today.day < dob.day)
                      ? 1
                      : 0);

              if (age < 18) {
                return 'Bạn phải từ 18 tuổi trở lên';
              }
            } catch (_) {
              return 'Ngày sinh không hợp lệ';
            }

            return null;
          },
          decoration: InputDecoration(
            labelText: 'Ngày sinh',
            prefixIcon: Icon(Icons.cake),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none, // No visible border line
            ),
            filled: true,
            fillColor: Colors.grey[100], // Light grey background
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime(2000),
            );
            if (picked != null) {
              dobController.text = DateFormat('dd/MM/yyyy').format(picked);
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Giới tính',
            prefixIcon: Icon(Icons.wc),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100], // Light grey background
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng chọn giới tính';
            }
            return null;
          },
          value: gender,
          items:
              [
                'Nam',
                'Nữ',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => setState(() => gender = value),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      children: [
        CustomTextField(
          validator: Validators.validatePassword,
          controller: passwordController,
          hint: 'Mật khẩu',
          icon: Icons.lock,
          isPassword: true,
          isPasswordVisible: isPasswordVisible,
          onToggleVisibility:
              () => setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      children: [
        CustomTextField(
          controller: confirmPasswordController,
          hint: 'Xác nhận mật khẩu',
          icon: Icons.lock,
          isPassword: true,
          isPasswordVisible: isConfirmVisible,
          onToggleVisibility:
              () => setState(() => isConfirmVisible = !isConfirmVisible),
          validator: (value) {
            if (value != passwordController.text) {
              return 'Mật khẩu xác nhận không khớp';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isAgreed,
          onChanged: (value) => setState(() => isAgreed = value ?? false),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Open terms and policy
            },
            child: const Text.rich(
              TextSpan(
                text: 'Tôi đồng ý với ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: 'điều khoản sử dụng',
                    style: TextStyle(
                      color: Colors.indigo,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' và '),
                  TextSpan(
                    text: 'chính sách bảo mật',
                    style: TextStyle(
                      color: Colors.indigo,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' của UTC2'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return AuthButton(
      text: 'Đăng ký tài khoản',
      icon: Icons.person_add,
      onPressed: () {
        if (!_formKey.currentState!.validate()) return;

        if (!isAgreed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bạn cần đồng ý với điều khoản sử dụng'),
            ),
          );
          return;
        }
        AuthRouter.goToLogin(context);
      },
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

  Widget _buildLoginRedirect(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Đã có tài khoản?', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                AuthRouter.goToLogin(context);
              },
              icon: const Icon(Icons.login, color: Colors.indigo),
              label: const Text(
                'Đăng nhập ngay',
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
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
