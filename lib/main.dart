import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/auth/login_page.dart';
import 'package:exercise8_5_25/providers/product_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'services/storage/local_storage_service.dart';

void main() async {
  final storage = LocalStorageService();

  await storage.saveThemeMode('dark');
  await storage.saveToken('fake_token_123');

  final theme = await storage.getThemeMode();
  final token = await storage.getToken();

  print('Theme: $theme');
  print('Token: $token');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
      title: 'Shop App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const HomePage(),
    );
  }
}
