import 'package:exercise_5_8_26/pages/auth/login_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/pages/home_screen.dart';
import 'package:exercise_5_8_26/providers/auth_provider.dart';
import 'package:exercise_5_8_26/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final themeProvider = ThemeProvider();
  final authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    Future.wait([themeProvider.loadTheme(), authProvider.loadToken()]).then((
      _,
    ) {
      if (!mounted) return;

      if (authProvider.accessToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 211, 197, 197),
                strokeWidth: 2.5,
              ),
              SizedBox(height: 32),
              Text(
                "Please waiting a few minutes",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
