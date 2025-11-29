import 'dart:io';

import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp();
    await _initializeFirebaseMessaging();
    await _initializeLocalNotifications();
  }

  static Future<void> _initializeFirebaseMessaging() async {
    //دا كدا طلب الاذن بالاشعارات
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (Platform.isIOS || Platform.isMacOS) {
        String? apnsToken;
        try {
          apnsToken = await _messaging.getAPNSToken();
        } catch (e) {
        }
        if (apnsToken == null) {
         
          return;
        }
      }
    } else {
    }

    //  FCM token
    String? token;
    try {
      token = await _messaging.getToken();
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.fbToken, token??"");
    } catch (e) {
    }

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    // دي الاشعارات وانا فاتحه الابليكشن
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    // لما اضغط علي الاشعار
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    RemoteMessage? initialMessage;
    try {
      initialMessage = await _messaging.getInitialMessage();
    } catch (e) {
    }
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  // دا كدا للاندرويد والايفون
  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    //دي للاندرويد بس
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }
  }

  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    await _showLocalNotification(message);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  //دي اللي هقدر اتنقل لصفحه ما لما ااضغط ع الاشعار
  static void _onNotificationTap(NotificationResponse response) {
    //هنا
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
  }

  static Future<String?> getToken() async {
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        String? apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null) {
       
          return null;
        }
      }
      return await _messaging.getToken();
    } catch (e) {
      return null;
    }
  }

  static Future<void> sendTokenToServer(String token) async {
  }
}
