import 'package:exercise_5_8_26/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LogoutItem extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLoading;

  const LogoutItem({super.key, this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),

          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(Icons.logout, color: colors.error),
          title: Text(
            l10n.logout,
            style: TextStyle(color: colors.error, fontWeight: FontWeight.w600),
          ),
          trailing: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.error,
                  ),
                )
              : null,
          onTap: isLoading ? null : onTap,
        ),
      ),
    );
  }
}
