import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
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
      SnackBar(content: Text(LocaleKeys.authentication.signUpUnavailable.tr())),
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
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.authentication.signUpUsername.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: usernameController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: LocaleKeys.authentication.loginUsernameHint.tr(),
              hintStyle: TextStyle(color: colors.onSurfaceVariant),

              prefixIcon: Icon(Icons.person_outline, color: colors.primary),

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
                return LocaleKeys.authentication.signUpUsernameWarning.tr();
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          Text(
            LocaleKeys.authentication.signUpPassword.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          InputPassword(controller: passwordController),

          const SizedBox(height: 12),

          Text(
            LocaleKeys.authentication.signUpConfirmPassword.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: confirmPasswordController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: LocaleKeys.authentication.signUpConfirmPasswordHint
                  .tr(),
              hintStyle: TextStyle(color: colors.onSurfaceVariant),

              prefixIcon: Icon(Icons.lock_outline, color: colors.primary),

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
                return LocaleKeys.authentication.signUpConfirmPasswordWarning
                    .tr();
              }
              if (value != passwordController.text) {
                return LocaleKeys.authentication.errorConfirmPasswordWarning
                    .tr();
              }
              return null;
            },
          ),

          const SizedBox(height: 50),

          AuthButton(
            onPressed: onSignUpPressed,
            text: LocaleKeys.authentication.signUpButton.tr(),
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
