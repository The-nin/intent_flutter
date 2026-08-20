import 'package:exercise_5_8_26/features/auth/presentation/providers/auth_provider.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/splash_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/screens/detail_screen.dart';
import 'package:exercise_5_8_26/presentation/main_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/splash',

    refreshListenable: authProvider,

    redirect: (context, state) {
      final isInitialized = authProvider.isInitialized;

      final isAuthenticated = authProvider.isAuthenticated;

      final location = state.matchedLocation;

      final isSplash = location == '/splash';

      final isLogin = location == '/login';

      if (!isInitialized) {
        return isSplash ? null : '/splash';
      }

      if (!isAuthenticated) {
        return isLogin ? null : '/login';
      }

      if (isAuthenticated) {
        return isSplash || isLogin ? '/main' : null;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: '/main',
        builder: (context, state) {
          return const MainScreen();
        },
      ),

      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return ProductDetailScreen(productId: id);
        },
      ),
    ],
  );
}
