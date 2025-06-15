class Validators {
  static final RegExp _emailRegExp =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _phoneRegExp =
      RegExp(r'^(0|\+84)[1-9][0-9]{8}$');

  static final RegExp _nameRegExp =
      RegExp(r"^[a-zA-ZÀ-ỹ\s'.-]{2,50}$");

  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$');

  // Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  // Số điện thoại
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    if (!_phoneRegExp.hasMatch(value.trim())) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  // Tên
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ tên';
    }
    if (!_nameRegExp.hasMatch(value.trim())) {
      return 'Họ tên không hợp lệ';
    }
    return null;
  }

  // Mật khẩu
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return 'Mật khẩu phải từ 6 ký tự và chứa cả chữ và số';
    }
    return null;
  }

  // Xác nhận mật khẩu
  static String? validateConfirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }
    if (password != confirm) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  // Trường bắt buộc (dùng chung)
  static String? requiredField(String? value, {String message = 'Trường này không được để trống'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
