// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:exercise_5_8_26/core/di/injection.dart';
import 'package:exercise_5_8_26/core/routes/app_router.dart';
import 'package:exercise_5_8_26/features/auth/presentation/providers/auth_provider.dart';
import 'package:exercise_5_8_26/main.dart';
import 'package:exercise_5_8_26/core/providers/theme_provider.dart';
import 'package:exercise_5_8_26/core/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('app builds the splash screen', (WidgetTester tester) async {
    final authProvider = AuthProvider(
      loginUseCase: Injection.loginUseCase,
      getCurrentUserUseCase: Injection.getCurrentUserUseCase,
      storage: Injection.secureStorageService,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: authProvider),
          ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider(storage: Injection.localStorageService),
          ),
          ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ],
        child: MyApp(appRouter: createAppRouter(authProvider)),
      ),
    );

    expect(find.text('Please wait a moment.'), findsOneWidget);
  });
}
