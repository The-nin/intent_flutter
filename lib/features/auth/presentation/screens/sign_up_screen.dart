import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.authentication.signUpTitle.tr(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      LocaleKeys.authentication.signUpSubtitle.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                const SignUpForm(),

                const SizedBox(height: 24),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: LocaleKeys.authentication.moveLoginTextSpan1.tr(),
                      style: TextStyle(color: colors.onSurface),
                      children: [
                        TextSpan(
                          text: LocaleKeys.authentication.moveLoginTextSpan2
                              .tr(),
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/login');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
