import 'package:exercise_5_8_26/features/profile/presentation/providers/logout_provider.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> onPressed() async {
    final success = await context.read<LogoutProvider>().logout();

    if (!mounted) {
      return;
    }

    if (success) {
      context.go('/login');
      return;
    }

    final errorMessage = context.read<LogoutProvider>().errorMessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage ?? 'Logout failed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Profile'),
            Consumer<LogoutProvider>(
              builder: (context, logoutProvider, child) {
                return ElevatedButton(
                  onPressed: logoutProvider.state == UiStateEnum.loading
                      ? null
                      : onPressed,
                  child: logoutProvider.state == UiStateEnum.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
