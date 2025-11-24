import 'package:daleel_app_project/screen/home_screen/home_screen_tabs.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE2DEDA)),

  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFFB34A24),
    ),
    bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.brown),
    titleMedium: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color(0xFFBE7D66),
    ),

    bodySmall: GoogleFonts.roboto(fontSize: 10, color: Colors.brown),
    titleSmall: GoogleFonts.roboto(
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
  runApp(MaterialApp(theme: theme, home: HomeScreenTabs()));
}
