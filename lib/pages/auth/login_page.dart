import 'package:exercise8_5_25/widgets/auth/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              SizedBox(height: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Login Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to your account to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(189, 189, 189, 1),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
