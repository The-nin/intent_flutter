import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<InputPassword> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputPassword> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: const Color.fromRGBO(189, 189, 189, 1)),

        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Color.fromARGB(255, 105, 83, 205),
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
    );
  }
}
