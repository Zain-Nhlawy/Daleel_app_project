import 'package:daleel_app_project/screen/home_screen/notifications_screen.dart';
import 'package:daleel_app_project/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../models/app_notification.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationStorage _storage = LocalNotificationStorage();

  void initFCM(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _storage.saveNotification(
          AppNotification(
            title: notification.title ?? 'Notification',
            body: notification.body ?? '',
            date: DateTime.now(),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
        ),
      );
    });
  }
}
