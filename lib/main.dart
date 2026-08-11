import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/auth/login_page.dart';
import 'package:exercise8_5_25/providers/product_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';

void main() async {
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
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const LoginPage(),
    );
  }
}
