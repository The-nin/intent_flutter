import 'package:exercise_5_8_26/features/profile/presentation/providers/logout_provider.dart';
import 'package:exercise_5_8_26/features/profile/presentation/providers/avatar_provider.dart';
import 'package:exercise_5_8_26/core/providers/theme_provider.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/profile/presentation/widgets/logout_item.dart';
import 'package:exercise_5_8_26/features/profile/presentation/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> onPressedLogout() async {
    final success = await context.read<LogoutProvider>().logout();

    if (!mounted) {
      return;
    }

    if (success) {
      return;
    }

    final errorMessage = context.read<LogoutProvider>().errorMessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage ?? LocaleKeys.profile.errorLogoutMessage.tr(),
        ),
      ),
    );
  }

  void showFeatureNotAvailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocaleKeys.profile.featureUnderDevelopment.tr())),
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
                title: Text(LocaleKeys.profile.camera.tr()),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(LocaleKeys.profile.gallery.tr()),
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
            content: Text(
              avatarProvider.errorMessage ??
                  LocaleKeys.profile.errorAvatarMessage.tr(),
            ),
          ),
        );
      }
    }
  }

  void _showThemeOptions() {
    final themeProvider = context.read<ThemeProvider>();
    final currentTheme = themeProvider.themeMode;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.light_mode_outlined),
                title: Text(LocaleKeys.theme.lightTheme.tr()),
                trailing: currentTheme == ThemeMode.light
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  themeProvider.changeTheme(ThemeMode.light);
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: Text(LocaleKeys.theme.darkTheme.tr()),
                trailing: currentTheme == ThemeMode.dark
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  themeProvider.changeTheme(ThemeMode.dark);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale; // Đăng ký lắng nghe sự thay đổi ngôn ngữ

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.profileTitle.tr()),
        centerTitle: true,
      ),
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
                child: Text(LocaleKeys.profile.openWebView.tr()),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.profile.general.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SettingsItem(
                      icon: Icons.notifications_active_outlined,
                      title: LocaleKeys.profile.notification.tr(),
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.security_outlined,
                      title: LocaleKeys.profile.security.tr(),
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.travel_explore_outlined,
                      title: LocaleKeys.profile.language.tr(),
                      onTap: () {
                        context.push('/language');
                      },
                    ),

                    SettingsItem(
                      icon: Icons.dark_mode_outlined,
                      title: LocaleKeys.profile.theme.tr(),
                      onTap: _showThemeOptions,
                    ),

                    Text(
                      LocaleKeys.profile.preferences.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SettingsItem(
                      icon: Icons.shield_outlined,
                      title: LocaleKeys.profile.legalAndPolicies.tr(),
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    SettingsItem(
                      icon: Icons.help_outline,
                      title: LocaleKeys.profile.helpAndSupport.tr(),
                      onTap: () => showFeatureNotAvailable(context),
                    ),

                    Consumer<LogoutProvider>(
                      builder: (context, logoutProvider, child) {
                        final isLoading =
                            logoutProvider.state == UiStateEnum.loading;

                        return LogoutItem(
                          isLoading: isLoading,
                          onTap: () => onPressedLogout(),
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
