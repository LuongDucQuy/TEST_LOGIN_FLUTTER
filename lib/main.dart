import 'package:flutter/material.dart';
import 'package:test_flutter/features/auth/screen/forget_password.dart';
import 'package:test_flutter/features/auth/screen/signin.dart';
import 'package:test_flutter/features/auth/screen/signup.dart';
import 'package:test_flutter/navigation/routers.dart';

void main() {
  AuthRouter.setupRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
