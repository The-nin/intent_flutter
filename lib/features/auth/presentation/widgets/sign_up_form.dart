import 'package:exercise_5_8_26/features/auth/presentation/widgets/input_password.dart';
import 'package:flutter/material.dart';

import 'package:exercise_5_8_26/features/auth/presentation/widgets/auth_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> onSignUpPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign up is unavailable until a backend is connected.'),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Username',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: usernameController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter your username',
              hintStyle: TextStyle(
                color: const Color.fromRGBO(189, 189, 189, 1),
              ),

              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color.fromARGB(255, 105, 83, 205),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1.2,
                  color: Color.fromARGB(255, 192, 191, 191),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 2.4,
                  color: Color.fromARGB(255, 105, 83, 205),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 1.2, color: Colors.red),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 2.4, color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          Text(
            'Password',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          InputPassword(controller: passwordController),

          const SizedBox(height: 12),

          Text(
            'Confirm password',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: confirmPasswordController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter your confirm password',
              hintStyle: TextStyle(
                color: const Color.fromRGBO(189, 189, 189, 1),
              ),

              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color.fromARGB(255, 105, 83, 205),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1.2,
                  color: Color.fromARGB(255, 192, 191, 191),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 2.4,
                  color: Color.fromARGB(255, 105, 83, 205),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 1.2, color: Colors.red),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 2.4, color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter confirm password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(105, 83, 205, 1),
              ),
            ),
          ),

          const SizedBox(height: 30),

          AuthButton(
            onPressed: onSignUpPressed,
            text: 'Sign Up',
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
