import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Color Tokens ────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color bg         = Color(0xFF0D0D14);   // void black
  static const Color surface    = Color(0xFF1A1A2E);   // deep navy
  static const Color surfaceHi  = Color(0xFF22223A);   // lifted surface
  static const Color border     = Color(0xFF2E2E4A);   // subtle border

  static const Color rose       = Color(0xFFFF3C6E);   // neon rose – primary CTA
  static const Color roseDeep   = Color(0xFFCC2255);   // pressed state
  static const Color violet     = Color(0xFFC084FC);   // electric violet – accent
  static const Color violetDim  = Color(0xFF7C3AED);   // deeper violet

  static const Color textPri    = Color(0xFFF8F8FF);   // ghost white
  static const Color textSec    = Color(0xFFAEAECC);   // muted lavender
  static const Color textDim    = Color(0xFF5A5A7A);   // disabled/placeholder

  // Gradients
  static const Gradient heroBurn = LinearGradient(
    colors: [Color(0xFFFF3C6E), Color(0xFFC084FC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient posterScrim = LinearGradient(
    colors: [Colors.transparent, Color(0xE00D0D14)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.45, 1.0],
  );

  static const Gradient cardScrim = LinearGradient(
    colors: [Colors.transparent, Color(0xCC0D0D14)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.3, 1.0],
  );
}

// ─── Theme ───────────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    const cs = ColorScheme(
      brightness: Brightness.dark,
      primary:          AppColors.rose,
      onPrimary:        AppColors.textPri,
      secondary:        AppColors.violet,
      onSecondary:      AppColors.textPri,
      error:            Color(0xFFFF5252),
      onError:          AppColors.textPri,
      background:       AppColors.bg,
      onBackground:     AppColors.textPri,
      surface:          AppColors.surface,
      onSurface:        AppColors.textPri,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.bg,

      // ── Typography (system font, weight-driven) ──────────────────────────
      textTheme: const TextTheme(
        displayLarge:  TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppColors.textPri, letterSpacing: -1.0),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPri, letterSpacing: -0.5),
        titleLarge:    TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPri),
        titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPri),
        bodyLarge:     TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textPri, height: 1.6),
        bodyMedium:    TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSec, height: 1.5),
        labelLarge:    TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPri, letterSpacing: 0.4),
        labelSmall:    TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDim, letterSpacing: 0.8),
      ),

      // ── AppBar ───────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.textPri,
        ),
        iconTheme: IconThemeData(color: AppColors.textPri),
      ),

      // ── Input ────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceHi,
        hintStyle: const TextStyle(color: AppColors.textDim, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.rose, width: 1.5),
        ),
      ),

      // ── Chips ────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceHi,
        selectedColor: AppColors.rose.withOpacity(0.2),
        labelStyle: const TextStyle(color: AppColors.textSec, fontSize: 12, fontWeight: FontWeight.w600),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── NavigationBar ────────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.rose.withOpacity(0.15),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: AppColors.rose, size: 22);
          }
          return const IconThemeData(color: AppColors.textDim, size: 22);
        }),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(color: AppColors.rose, fontSize: 11, fontWeight: FontWeight.w700);
          }
          return const TextStyle(color: AppColors.textDim, fontSize: 11, fontWeight: FontWeight.w500);
        }),
        elevation: 0,
        height: 64,
      ),

      // ── Buttons ──────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.rose,
          foregroundColor: AppColors.textPri,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}