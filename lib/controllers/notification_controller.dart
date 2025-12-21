import 'package:daleel_app_project/services/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  late final NotificationService notificationService;

  NotificationController({required this.notificationService});

  Future<void> addToken(String token) async {
    if (token.isEmpty) return;
    try {
      await notificationService.saveTokenIfChanged(token);
    } catch (e) {}
  }
}
