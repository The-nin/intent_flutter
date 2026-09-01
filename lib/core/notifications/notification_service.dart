import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

typedef NotificationTapCallback = void Function(RemoteMessage message);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background notification received: ${message.messageId}');
}

class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<bool> initialize({
    NotificationTapCallback? onNotificationTap,
  }) async {
    try {
      await Firebase.initializeApp();

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      final token = await _messaging.getToken();
      debugPrint('FCM token available: ${token != null}');
      debugPrint('DCM token: ${token}');

      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM token refreshed: ${newToken.isNotEmpty}');
      });

      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('Foreground notification received: ${message.messageId}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        onNotificationTap?.call(message);
      });

      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        onNotificationTap?.call(initialMessage);
      }

      return true;
    } on FirebaseException catch (error) {
      debugPrint('Firebase is not configured: ${error.message}');
      return false;
    } catch (error) {
      debugPrint('FCM initialization failed: $error');
      return false;
    }
  }
}
