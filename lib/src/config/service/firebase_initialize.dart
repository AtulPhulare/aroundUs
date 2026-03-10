import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static AndroidNotificationChannel? _channel;
  static bool hasHandledInitialNotification = false;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Initialize local notifications
    await _initializeLocalNotifications();

    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleNotificationTap(initialMessage);
      });
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('Foreground notification: ${message.notification?.title}');
      }

      if (Platform.isAndroid) {
        _showLocalNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin!.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    if (Platform.isAndroid) {
      _channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true,
      );

      await _flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel!);
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    if (_flutterLocalNotificationsPlugin == null) return;

    final androidDetails = AndroidNotificationDetails(
      _channel?.id ?? 'default_channel',
      _channel?.name ?? 'Default',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final payload =
        '${message.data['page'] ?? ''}|${message.data['body'] ?? ''}';

    await _flutterLocalNotificationsPlugin!.show(
      Random().nextInt(100000),
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: payload,
    );
  }

  static void _handleNotificationTap(RemoteMessage message) {
    hasHandledInitialNotification = true;
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    if (kDebugMode) {
      print('Background message: ${message.notification?.title}');
    }
  }
}
