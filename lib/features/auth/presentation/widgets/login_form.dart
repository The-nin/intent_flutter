import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/auth/presentation/widgets/input_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise_5_8_26/features/auth/presentation/providers/auth_provider.dart';
import 'package:exercise_5_8_26/features/auth/presentation/widgets/auth_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> onLoginPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text;
    final password = passwordController.text;
    final errorColor = Theme.of(context).colorScheme.error;

    final success = await context.read<AuthProvider>().login(
      username,
      password,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.authentication.loginSuccess.tr()),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      final errorMsg =
          context.read<AuthProvider>().errorMessage ??
          LocaleKeys.authentication.loginError.tr();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: errorColor),
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
    final colors = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.authentication.loginUsername.tr(),
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
                return LocaleKeys.authentication.loginUsernameWarning.tr();
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          Text(
            LocaleKeys.authentication.loginPassword.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          InputPassword(controller: passwordController),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              LocaleKeys.authentication.loginForgotPassword.tr(),
              style: TextStyle(fontSize: 16, color: colors.primary),
            ),
          ),

          const SizedBox(height: 30),

          AuthButton(
            onPressed: authProvider.state == UiStateEnum.loading
                ? null
                : onLoginPressed,
            text: LocaleKeys.authentication.loginButton.tr(),
            isLoading: authProvider.state == UiStateEnum.loading,
          ),
        ],
      ),
    );
  }
}
