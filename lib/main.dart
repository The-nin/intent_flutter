import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'features/auth/presentation/screen/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'core/storage/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();

  final authProvider = AuthProvider(
    loginUseCase: Injection.loginUseCase,
    storage: SecureStorageService(),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            getProductsUseCase: Injection.getProductsUseCase,
            getProductByIdUseCase: Injection.getProductByIdUseCase,
            storage: LocalStorageService(),
          ),
        ),

        ChangeNotifierProvider.value(value: themeProvider),

        ChangeNotifierProvider.value(value: authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
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

      home: const SplashScreen(),
    );
  }
}
