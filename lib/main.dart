import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:exercise_5_8_26/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:exercise_5_8_26/core/di/locator.dart';
import 'package:exercise_5_8_26/core/storage/local_storage_service.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:exercise_5_8_26/core/network/dio_client.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_products_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/toggle_favorite_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_product_ids_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_products_use_case.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/widgets/offline_banner.dart';
import 'core/notifications/notification_service.dart';
import 'features/profile/presentation/providers/logout_provider.dart';
import 'features/profile/presentation/providers/avatar_provider.dart';
import 'core/providers/locale_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  final themeProvider = ThemeProvider(storage: locator<LocalStorageService>());
  await themeProvider.loadTheme();

  final localeProvider = LocaleProvider(
    storage: locator<LocalStorageService>(),
  );
  await localeProvider.loadLocale();

  final authProvider = AuthProvider(
    loginUseCase: locator<LoginUseCase>(),
    storage: locator<SecureStorageService>(),
    getCurrentUserUseCase: locator<GetCurrentUserUseCase>(),
  );

  final avatarProvider = AvatarProvider(
    storage: locator<LocalStorageService>(),
  );
  await avatarProvider.loadAvatar();

  locator<DioClient>().setOnSessionExpired(authProvider.clearAuth);

  final appRouter = createAppRouter(authProvider);

  await NotificationService.initialize(
    onNotificationTap: (message) {
      final route = message.data['route'];

      if (route is String && route.startsWith('/')) {
        appRouter.go(route);
      }
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            getProductsUseCase: locator<GetProductsUseCase>(),
            getProductByIdUseCase: locator<GetProductByIdUseCase>(),
            toggleFavoriteUseCase: locator<ToggleFavoriteUseCase>(),
            getFavoriteProductIdsUseCase:
                locator<GetFavoriteProductIdsUseCase>(),
            getFavoriteProductsUseCase: locator<GetFavoriteProductsUseCase>(),
          ),
        ),

        ChangeNotifierProvider.value(value: themeProvider),

        ChangeNotifierProvider.value(value: authProvider),

        ChangeNotifierProvider.value(value: localeProvider),

        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),

        ChangeNotifierProvider(
          create: (_) => LogoutProvider(
            storage: locator<SecureStorageService>(),
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
