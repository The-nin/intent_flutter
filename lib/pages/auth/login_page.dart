import 'package:exercise8_5_25/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void onLoginPressed() {
    print('Login button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Start learning with us by creating an account.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),
            ),
            AuthButton(onPressed: onLoginPressed, text: 'Login'),
          ],
        ),
      ),
    );
  }
}
