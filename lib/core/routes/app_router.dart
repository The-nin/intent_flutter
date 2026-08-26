import 'package:exercise_5_8_26/features/auth/presentation/providers/auth_provider.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/splash_screen.dart';
import 'package:exercise_5_8_26/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/screens/detail_screen.dart';
import 'package:exercise_5_8_26/features/navigation/presentation/screens/main_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/screens/home_screen.dart';
import 'package:exercise_5_8_26/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/widgets.dart';
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
      final publicRoutes = ['/login', '/signup'];
      final isPublicRoutes = publicRoutes.contains(location);

      if (!isInitialized) {
        return isSplash ? null : '/splash';
      }

      if (!isAuthenticated) {
        return isPublicRoutes ? null : '/login';
      }

      if (isAuthenticated) {
        return isSplash || isPublicRoutes ? '/home' : null;
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
        path: '/product/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return ProductDetailScreen(productId: id);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/order',
                builder: (context, state) {
                  return const Center(child: Text('My Order'));
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorite',
                builder: (context, state) {
                  return const FavoriteScreen();
                },
              ),
            ],
          ),

          // Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
