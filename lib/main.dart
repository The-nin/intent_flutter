import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/connectivity_provider.dart';
import 'core/widgets/offline_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider(storage: Injection.localStorageService);
  await themeProvider.loadTheme();

  final authProvider = AuthProvider(
    loginUseCase: Injection.loginUseCase,
    storage: Injection.secureStorageService,
  );

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
          ),
        ),

        ChangeNotifierProvider.value(value: themeProvider),

        ChangeNotifierProvider.value(value: authProvider),

        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
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
          seedColor: Colors.white,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
    );
  }
}
