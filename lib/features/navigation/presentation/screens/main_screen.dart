import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .locale; // Đăng ký lắng nghe ngôn ngữ để update BottomNavigationBar labels
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            top: BorderSide(
              color: colors.outline.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onItemTapped,

          backgroundColor: colors.surface,

          unselectedItemColor: colors.onSurfaceVariant.withValues(alpha: 0.55),
          selectedItemColor: colors.primary,

          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),

          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: LocaleKeys.bottomNavigation.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: LocaleKeys.bottomNavigation.order.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: LocaleKeys.bottomNavigation.favorite.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: LocaleKeys.bottomNavigation.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
