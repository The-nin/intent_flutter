import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/widgets/offline_banner.dart';
import 'features/profile/presentation/providers/logout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider(storage: Injection.localStorageService);
  await themeProvider.loadTheme();

  final authProvider = AuthProvider(
    loginUseCase: Injection.loginUseCase,
    storage: Injection.secureStorageService,
    getCurrentUserUseCase: Injection.getCurrentUserUseCase,
  );

  Injection.dioClient.setOnSessionExpired(authProvider.clearAuth);

  final appRouter = createAppRouter(authProvider);

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

        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),

        ChangeNotifierProvider(
          create: (_) => LogoutProvider(
            storage: Injection.secureStorageService,
            onLoggedOut: authProvider.clearAuth,
          ),
        ),
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

    return MaterialApp.router(
      routerConfig: appRouter,
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
