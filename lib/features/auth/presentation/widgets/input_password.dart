import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
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
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: LocaleKeys.authentication.loginPasswordHint.tr(),
        hintStyle: TextStyle(color: colors.onSurfaceVariant),

        prefixIcon: Icon(Icons.lock_outline, color: colors.primary),

        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: colors.onSurfaceVariant,
          ),
          onPressed: _togglePasswordVisibility,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1.2, color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 2.4, color: colors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1.2, color: colors.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 2.4, color: colors.error),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocaleKeys.authentication.loginPasswordWarning.tr();
        }
        return null;
      },
    );
  }
}
