import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/features/auth/screen/forget_password.dart';
import 'package:test_flutter/features/auth/screen/signin.dart';
import 'package:test_flutter/features/auth/screen/signup.dart';

class AuthRouter {
  static final FluroRouter router = FluroRouter();

  // Route names
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static void setupRoutes() {
    router.define(
      '/login',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return const LoginScreen();
        },
      ),
    );

    router.define(
      '/register',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return const RegisterScreen();
        },
      ),
    );

    router.define(
      '/forgot-password',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return const ForgotPasswordScreen();
        },
      ),
    );
  }

  // Navigation helpers
  static void goToLogin(BuildContext context) {
    router.navigateTo(context, login, replace: true);
  }

  static void goToRegister(BuildContext context) {
    router.navigateTo(context, register);
  }

  static void goToForgotPassword(BuildContext context) {
    router.navigateTo(context, forgotPassword);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
