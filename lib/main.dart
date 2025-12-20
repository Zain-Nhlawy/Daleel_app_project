import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreen()
    )
  );
}
