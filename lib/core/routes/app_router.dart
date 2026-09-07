import 'package:exercise_5_8_26/features/auth/presentation/providers/auth_provider.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:exercise_5_8_26/features/auth/presentation/screens/splash_screen.dart';
import 'package:exercise_5_8_26/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/screens/detail_screen.dart';
import 'package:exercise_5_8_26/features/navigation/presentation/screens/main_screen.dart';
import 'package:exercise_5_8_26/features/product/presentation/screens/home_screen.dart';
import 'package:exercise_5_8_26/features/profile/presentation/screens/language_screen.dart';
import 'package:exercise_5_8_26/features/profile/presentation/screens/profile_screen.dart';
import 'package:exercise_5_8_26/features/webview/presentation/screens/web_view_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: SplashScreen.route,

    refreshListenable: authProvider,

    redirect: (context, state) {
      final isInitialized = authProvider.isInitialized;
      final isAuthenticated = authProvider.isAuthenticated;
      final location = state.matchedLocation;

      final isSplash = location == SplashScreen.route;
      final publicRoutes = [LoginScreen.route, SignUpScreen.route];
      final isPublicRoutes = publicRoutes.contains(location);

      if (!isInitialized) {
        return isSplash ? null : SplashScreen.route;
      }

      if (!isAuthenticated) {
        return isPublicRoutes ? null : LoginScreen.route;
      }

      if (isAuthenticated) {
        return isSplash || isPublicRoutes ? HomeScreen.route : null;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: SplashScreen.route,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      GoRoute(
        path: SignUpScreen.route,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: ProductDetailScreen.route,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return ProductDetailScreen(productId: id);
        },
      ),

      GoRoute(
        path: WebViewScreen.route,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';

          return WebViewScreen(url: url);
        },
      ),

      GoRoute(
        path: LanguageScreen.route,
        builder: (context, state) {
          return const LanguageScreen();
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
                path: HomeScreen.route,
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
                  return Center(
                    child: Text(LocaleKeys.bottomNavigation.order.tr()),
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FavoriteScreen.route,
                builder: (context, state) {
                  return const FavoriteScreen();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProfileScreen.route,
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
