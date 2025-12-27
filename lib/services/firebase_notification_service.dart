import 'package:daleel_app_project/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/app_notification.dart';

class FirebaseNotificationService {
  final LocalNotificationStorage _storage = LocalNotificationStorage();

  void saveNotification(RemoteMessage message) {
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
  }
}
