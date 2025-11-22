import 'package:daleel_app_project/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: const Color.fromARGB(255, 189, 118, 92)),
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 226, 222, 218),
  ),
  textTheme: GoogleFonts.cairoTextTheme(const TextTheme()).copyWith(
    bodyLarge: GoogleFonts.cairo(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 185, 119, 95),
    ),
    bodyMedium: GoogleFonts.cairo(fontSize: 16, color: Colors.brown),
    titleLarge: GoogleFonts.cairo(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 190, 125, 102),
    ),
  ),
);

void main() {
  runApp(MaterialApp(theme: theme, home: HomeScreen()));
}
