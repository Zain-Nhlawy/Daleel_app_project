import 'package:daleel_app_project/screen/login_screen.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  //colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE2DEDA)),
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(theme: theme, home: LoginScreen()));
}
