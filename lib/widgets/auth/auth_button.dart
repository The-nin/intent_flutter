import "package:flutter/material.dart";

class AuthButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  const AuthButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        text ?? '',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
