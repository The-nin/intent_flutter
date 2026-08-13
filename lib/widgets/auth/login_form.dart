import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:exercise8_5_25/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise8_5_25/providers/auth_provider.dart';
import 'package:exercise8_5_25/widgets/auth/auth_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> onLoginPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text;
    final password = passwordController.text;

    try {
      await context.read<AuthProvider>().login(username, password);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Username',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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
                color: Color.fromRGBO(189, 189, 189, 1),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: passwordController,
            obscureText: !_isPasswordVisible,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: const Color.fromRGBO(189, 189, 189, 1),
              ),

              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color.fromRGBO(189, 189, 189, 1),
              ),

              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color.fromRGBO(189, 189, 189, 1),
                ),
                onPressed: _togglePasswordVisibility,
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
                return 'Please enter your password';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

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
            onPressed: authProvider.state == UiState.loading
                ? null
                : onLoginPressed,
            text: 'Login',
            isLoading: authProvider.state == UiState.loading,
          ),
        ],
      ),
    );
  }
}
