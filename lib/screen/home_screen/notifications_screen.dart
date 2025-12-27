import 'package:daleel_app_project/models/app_notification.dart';
import 'package:daleel_app_project/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final LocalNotificationStorage _storage = LocalNotificationStorage();
  late List<AppNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = _storage.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.notifications),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _storage.clearAll();
              setState(() {
                _notifications.clear();
              });
            },
            tooltip: locale.clearAll,
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(child: Text(locale.noNotifications))
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(notif.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(notif.body),
                    trailing: Text(DateFormat('hh:mm dd/MM').format(notif.date)),
                  ),
                );
              },
            ),
    );
  }
}
