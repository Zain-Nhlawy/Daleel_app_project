import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE2DEDA)),

  textTheme: GoogleFonts.nunitoTextTheme().copyWith(
    bodyLarge: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFFB34A24),
    ),
    bodyMedium: GoogleFonts.nunito(fontSize: 16, color: Colors.brown),
    titleMedium: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFFBE7D66),
    ),

    bodySmall: GoogleFonts.nunito(fontSize: 10, color: Colors.brown),
    titleSmall: GoogleFonts.nunito(
      fontSize: 12,
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
  runApp(MaterialApp(theme: theme, home: HomeScreenTabs()));
}
