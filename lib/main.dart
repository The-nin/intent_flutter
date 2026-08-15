import 'core/di/injection.dart';
import 'features/product/presentation/providers/product_provider.dart';
import 'pages/auth/splash_screen.dart';
import 'services/storage/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/auth/login_screen.dart';
import 'features/product/presentation/pages/home_screen.dart';

import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  final authProvider = AuthProvider();

  await Future.wait([themeProvider.loadTheme(), authProvider.loadToken()]);

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
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),

      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,

      // home: authProvider.accessToken != null
      //     ? const HomeScreen()
      //     : const LoginScreen(),
      home: const SplashScreen(),
    );
  }
}
