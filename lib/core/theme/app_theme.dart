import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: brightness,
      primary: AppColors.navy,
      secondary: AppColors.blue,
      surface: dark ? const Color(0xFF172033) : AppColors.surface,
    );
    final base = ThemeData(brightness: brightness).textTheme;
    final border = dark ? const Color(0xFF2C3A50) : const Color(0xFFE2E8F0);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          dark ? const Color(0xFF101827) : AppColors.background,
      fontFamily: 'Arial',
      textTheme: base.copyWith(
        displaySmall: base.displaySmall?.copyWith(
          fontSize: 34,
          height: 1.12,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.8,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontSize: 28,
          height: 1.18,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 20,
          height: 1.25,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontSize: 16,
          height: 1.28,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: base.bodyLarge?.copyWith(fontSize: 16, height: 1.48),
        bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, height: 1.45),
        bodySmall: base.bodySmall?.copyWith(fontSize: 12, height: 1.35),
        labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: base.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w900,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF202B3E) : const Color(0xFFF0F3F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        elevation: 0,
        indicatorColor: AppColors.navy.withValues(alpha: .11),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w600,
          ),
        ),
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
