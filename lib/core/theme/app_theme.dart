import 'package:flutter/material.dart';

/// Misma identidad que la web: oscuro industrial + acento volt.
abstract final class MvColors {
  static const bg = Color(0xFF0C1017);
  static const surface = Color(0xFF151B26);
  static const border = Color(0xFF2A3446);
  static const text = Color(0xFFE9EDF4);
  static const muted = Color(0xFF9AA6B8);
  static const accent = Color(0xFFFFD60A);
  static const accentInk = Color(0xFF14120A);
  static const signal = Color(0xFF40A9FF);
  static const error = Color(0xFFF87171);
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: MvColors.bg,
    colorScheme: base.colorScheme.copyWith(
      primary: MvColors.accent,
      onPrimary: MvColors.accentInk,
      secondary: MvColors.signal,
      surface: MvColors.surface,
      error: MvColors.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MvColors.bg,
      foregroundColor: MvColors.text,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MvColors.bg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MvColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MvColors.border),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: MvColors.accent,
        foregroundColor: MvColors.accentInk,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      color: MvColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: MvColors.border),
      ),
    ),
  );
}
