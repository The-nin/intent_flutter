import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'presentation/providers/theme_provider.dart';

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
            storage: Injection.localStorageService,
          ),
        ),

        ChangeNotifierProvider.value(value: themeProvider),

        ChangeNotifierProvider.value(value: authProvider),
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
