import 'package:exercise_5_8_26/features/profile/presentation/providers/logout_provider.dart';
import 'package:exercise_5_8_26/features/profile/presentation/providers/avatar_provider.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/profile/presentation/widgets/logout_item.dart';
import 'package:exercise_5_8_26/features/profile/presentation/widgets/setting_item.dart';
import 'package:exercise_5_8_26/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage ?? 'Logout failed.')));
  }

  void showFeatureNotAvailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This feature is currently under development. Please try again later.',
        ),
      ),
    );
  }

  Future<void> _showAvatarOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Chụp ảnh'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Chọn từ thư viện'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source != null && mounted) {
      final avatarProvider = context.read<AvatarProvider>();
      await avatarProvider.pickAvatar(source);

      if (mounted && avatarProvider.state == UiStateEnum.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(avatarProvider.errorMessage ?? 'Không thể chọn ảnh.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<AvatarProvider>(
                builder: (context, avatarProvider, child) {
                  return GestureDetector(
                    onTap: avatarProvider.state == UiStateEnum.loading
                        ? null
                        : _showAvatarOptions,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: avatarProvider.avatarBytes == null
                          ? null
                          : MemoryImage(avatarProvider.avatarBytes!),
                      child: avatarProvider.state == UiStateEnum.loading
                          ? const CircularProgressIndicator()
                          : avatarProvider.avatarBytes == null
                          ? const Icon(Icons.person, size: 48)
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.push(
                    '/webview?url=${Uri.encodeComponent('https://dummyjson.com')}',
                  );
                },
                child: const Text('Open WebView'),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.general,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SettingsItem(
                      icon: Icons.notifications_active_outlined,
                      title: l10n.notification,
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.security_outlined,
                      title: l10n.security,
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.travel_explore_outlined,
                      title: l10n.language,
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    Text(
                      l10n.preferences,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SettingsItem(
                      icon: Icons.shield_outlined,
                      title: l10n.legalAndPolicies,
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.help_outline,
                      title: l10n.helpAndSupport,
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    Consumer<LogoutProvider>(
                      builder: (context, logoutProvider, child) {
                        final isLoading =
                            logoutProvider.state == UiStateEnum.loading;

                        return LogoutItem(
                          isLoading: isLoading,
                          onTap: () {
                            logoutProvider.logout();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
