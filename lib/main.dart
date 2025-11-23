import 'package:daleel_app_project/screen/home_screen.dart';
import 'package:daleel_app_project/screen/home_screen_tabs.dart';
import 'package:daleel_app_project/screen/splash/splash_screen.dart'; 
import 'package:daleel_app_project/screen/login_screen.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color.fromARGB(255, 189, 118, 92)),
  ),
  fontFamily: 'Roboto',
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 226, 222, 218),
  ),

  textTheme: GoogleFonts.robotoTextTheme(const TextTheme()).copyWith(
    bodyLarge: GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 185, 119, 95),
    ),
    bodyMedium: GoogleFonts.roboto(fontSize: 16, color: Colors.brown),
    titleLarge: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 190, 125, 102),
    ),
  ),
);

void main() {
  runApp(MaterialApp(theme: theme, home: SplashScreen()));
}
