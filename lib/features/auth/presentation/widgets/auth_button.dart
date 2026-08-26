import "package:flutter/material.dart";

class AuthButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Opacity(
        opacity: isLoading ? 0.5 : 1,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            disabledBackgroundColor: colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: colors.onPrimary,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  text ?? '',
                  style: TextStyle(fontSize: 24, color: colors.onPrimary),
                ),
        ),
      ),
    );
  }
}
