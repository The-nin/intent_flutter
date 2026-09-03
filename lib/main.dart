import 'package:exercise_5_8_26/core/routes/app_router.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  setupLocator();

  final themeProvider = ThemeProvider(storage: locator<LocalStorageService>());
  await themeProvider.loadTheme();

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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
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
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final GoRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      routerConfig: appRouter,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

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
