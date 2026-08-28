import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
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
          tileColor: colors.surface,
          splashColor: colors.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: Icon(icon),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chevron_right,
                color: colors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
