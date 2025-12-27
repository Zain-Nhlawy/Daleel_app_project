import 'package:hive/hive.dart';
import '../models/app_notification.dart';

class LocalNotificationStorage {
  final Box box = Hive.box('notifications');

  void saveNotification(AppNotification notification) {
    box.add(notification.toMap());
  }

  List<AppNotification> getAllNotifications() {
    return box.values.map((e) {
      return AppNotification.fromMap(Map<String, dynamic>.from(e));
    }).toList().reversed.toList(); 
  }

  void clearAll() {
    box.clear();
  }

  
}
