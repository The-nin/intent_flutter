import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:exercise_5_8_26/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/widgets/offline_banner.dart';
import 'core/notifications/notification_service.dart';
import 'features/profile/presentation/providers/logout_provider.dart';
import 'features/profile/presentation/providers/avatar_provider.dart';
import 'core/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider(storage: Injection.localStorageService);
  await themeProvider.loadTheme();

  final localeProvider = LocaleProvider(storage: Injection.localStorageService);
  await localeProvider.loadLocale();

  final authProvider = AuthProvider(
    loginUseCase: Injection.loginUseCase,
    storage: Injection.secureStorageService,
    getCurrentUserUseCase: Injection.getCurrentUserUseCase,
  );

  final avatarProvider = AvatarProvider(storage: Injection.localStorageService);
  await avatarProvider.loadAvatar();

  Injection.dioClient.setOnSessionExpired(authProvider.clearAuth);

  final appRouter = createAppRouter(authProvider);

  await NotificationService.initialize(
    onNotificationTap: (message) {
      final route = message.data['route'];

      if (route is String && route.startsWith('/')) {
        appRouter.go(route);
      }
    },
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            getProductsUseCase: Injection.getProductsUseCase,
            getProductByIdUseCase: Injection.getProductByIdUseCase,
            toggleFavoriteUseCase: Injection.toggleFavoriteUseCase,
            getFavoriteProductIdsUseCase:
                Injection.getFavoriteProductIdsUseCase,
            getFavoriteProductsUseCase: Injection.getFavoriteProductsUseCase,
          ),
        ),

        ChangeNotifierProvider.value(value: themeProvider),

        ChangeNotifierProvider.value(value: authProvider),

        ChangeNotifierProvider.value(value: localeProvider),

        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),

        ChangeNotifierProvider(
          create: (_) => LogoutProvider(
            storage: Injection.secureStorageService,
            onLoggedOut: authProvider.clearAuth,
          ),
        ),

        ChangeNotifierProvider.value(value: avatarProvider),
      ],
      child: MyApp(appRouter: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final GoRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp.router(
      routerConfig: appRouter,
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Material(
                  type: MaterialType.transparency,
                  child: OfflineBanner(),
                ),
              ),
            ),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Shop App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6953CD),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6953CD),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      themeMode: themeProvider.themeMode,
    );
  }
}
