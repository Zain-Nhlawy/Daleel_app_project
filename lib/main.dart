import 'package:daleel_app_project/core/storage/storage_keys.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';

import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

RemoteMessage? pendingNotificationMessage;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF8B5E3C),
    onPrimary: Colors.white,
    secondary: Color(0xFFBE7D66),
    onSecondary: Colors.white,
    background: Color(0xFFFDFCF9),
    onBackground: Color(0xFF4B2E2E),
    surface: Colors.white,
    onSurface: Color(0xFF4B2E2E),
    error: Colors.red,
    onError: Colors.white,
  ),
  textTheme: GoogleFonts.nunitoTextTheme(),
);
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBE7D66),
    onPrimary: Colors.black,
    secondary: Color(0xFF8B5E3C),
    onSecondary: Colors.black,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.black,
  ),
  textTheme: GoogleFonts.nunitoTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  ),
);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.requestPermission();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
    final type = message.data['type'];
    if (type == 'rate_department') {
      final departmentIdStr = message.data['department_id'];
      if (departmentIdStr != null) {
        final departmentId = int.tryParse(departmentIdStr);
        if (departmentId != null) {
          final apartments2 = await apartmentController.fetchApartment(
            departmentId,
          );
          if (apartments2 != null && navigatorKey.currentState != null) {
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (_) => ApartmentDetailsScreen(
                  apartment: apartments2,
                  withRate: true,
                ),
              ),
            );
          }
        }
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    pendingNotificationMessage = message;
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    pendingNotificationMessage = initialMessage;
  }

  final token = await appStorage.read(StorageKeys.token);
  if (token != null) {
    userController.updateProfile(await userService.getProfile());
  }

  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ),
  );
}
