import 'package:daleel_app_project/core/storage/storage_keys.dart';
import 'package:daleel_app_project/dependencies.dart';

import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

  textTheme: GoogleFonts.nunitoTextTheme().copyWith(
    bodyLarge: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFFB34A24),
    ),
    bodyMedium: GoogleFonts.nunito(fontSize: 16, color: Colors.brown),
    titleMedium: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color(0xFFBE7D66),
    ),

    bodySmall: GoogleFonts.nunito(fontSize: 10, color: Colors.brown),
    titleSmall: GoogleFonts.nunito(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: Color(0xFFBE7D66),
    ),
  ),

  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Color(0xFFBD765C))),

  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final token = await appStorage.read(StorageKeys.token);
  if(token != null) {
    await userService.getProfile();
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(
    MaterialApp(
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreen(isLoggedIn: token != null),
    ),
  );
}
