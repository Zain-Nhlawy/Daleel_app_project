import 'package:daleel_app_project/core/storage/storage_keys.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/providers.dart';
import 'package:daleel_app_project/screen/home_screen/notifications_screen.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:provider/provider.dart';
import 'package:daleel_app_project/services/firebase_notification_service.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

RemoteMessage? pendingNotificationMessage;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 208, 158, 120),
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
    primary: Color.fromARGB(255, 170, 115, 95),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 168, 118, 80),
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

  await Hive.initFlutter();
  await Hive.openBox('notifications');

  final firebaseService = FirebaseNotificationService();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
    firebaseService.saveNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    pendingNotificationMessage = message;
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
    );
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    pendingNotificationMessage = initialMessage;
  }

  final token = await appStorage.read(StorageKeys.token);
  if (token != null) {
    User? user = await userService.getProfile();
    if (user != null) {
      userController.updateProfile(user);
    }
  }

  language = await appStorage.read(StorageKeys.language) ?? 'en';
  final themeValue = await appStorage.read(StorageKeys.theme);
  if (themeValue != null) {
    appTheme = themeValue;
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: provider.currentTheme,
      home: HomeScreenTabs(),
      locale: provider.currentLocale,
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
