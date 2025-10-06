import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  // Common padding values
  static const EdgeInsets screenPaddingAll = EdgeInsets.all(16);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: 16);

  // Light theme
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.primary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsSchemeColor: SchemeColor.primary,
      textButtonSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.primary,
      chipSchemeColor: SchemeColor.primary,
      popupMenuSchemeColor: SchemeColor.primary,
      appBarBackgroundSchemeColor: SchemeColor.primary,
      tabBarItemSchemeColor: SchemeColor.primary,
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.primary,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.primary,
      navigationBarUnselectedIconSchemeColor: SchemeColor.primary,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailUnselectedIconSchemeColor: SchemeColor.primary,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
    ),
    tones: FlexTones.jolly(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Roboto',
  ).copyWith(
    // Override with custom colors and typography
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.surface,

    // Text theme
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: AppColors.textPrimary),
      displayMedium: AppTypography.displayMedium.copyWith(color: AppColors.textPrimary),
      displaySmall: AppTypography.displaySmall.copyWith(color: AppColors.textPrimary),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColors.textPrimary),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: AppColors.textPrimary),
      titleLarge: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
      titleMedium: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
      titleSmall: AppTypography.titleSmall.copyWith(color: AppColors.textPrimary),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
      labelLarge: AppTypography.labelLarge.copyWith(color: AppColors.textPrimary),
      labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary),
      labelSmall: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.danger, width: 2),
      ),
      contentPadding: AppSpacing.inputPaddingAll,
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
      labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.danger),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: AppSpacing.buttonPaddingAll,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        textStyle: AppTypography.buttonMedium,
        elevation: AppSpacing.elevationSm,
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: AppSpacing.buttonPaddingAll,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        textStyle: AppTypography.buttonMedium,
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: AppSpacing.buttonPaddingAll,
        textStyle: AppTypography.buttonMedium,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: AppSpacing.elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      margin: EdgeInsets.zero,
    ),

    // App bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      elevation: AppSpacing.elevationMd,
      type: BottomNavigationBarType.fixed,
    ),

    // Floating action button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: AppSpacing.elevationMd,
    ),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: AppSpacing.borderWidthThin,
    ),

    // Chip theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedColor: AppColors.primary.withValues(alpha: 0.1),
      checkmarkColor: AppColors.primary,
      deleteIconColor: AppColors.textSecondary,
      labelStyle: AppTypography.bodyMedium,
      secondaryLabelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
    ),
  );

  // Dark theme
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.primary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsSchemeColor: SchemeColor.primary,
      textButtonSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.primary,
      chipSchemeColor: SchemeColor.primary,
      popupMenuSchemeColor: SchemeColor.primary,
      appBarBackgroundSchemeColor: SchemeColor.primary,
      tabBarItemSchemeColor: SchemeColor.primary,
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.primary,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.primary,
      navigationBarUnselectedIconSchemeColor: SchemeColor.primary,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailUnselectedIconSchemeColor: SchemeColor.primary,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    tones: FlexTones.jolly(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Roboto',
  ).copyWith(
    // Override with custom colors for dark theme
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark slate
    cardColor: const Color(0xFF1E293B), // Darker slate

    // Text theme for dark theme
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: Colors.white),
      displayMedium: AppTypography.displayMedium.copyWith(color: Colors.white),
      displaySmall: AppTypography.displaySmall.copyWith(color: Colors.white),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: Colors.white),
      titleLarge: AppTypography.titleLarge.copyWith(color: Colors.white),
      titleMedium: AppTypography.titleMedium.copyWith(color: Colors.white),
      titleSmall: AppTypography.titleSmall.copyWith(color: Colors.white),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: Colors.white),
      bodySmall: AppTypography.bodySmall.copyWith(color: const Color(0xFFCBD5E1)), // Light gray for secondary text
      labelLarge: AppTypography.labelLarge.copyWith(color: Colors.white),
      labelMedium: AppTypography.labelMedium.copyWith(color: const Color(0xFFCBD5E1)),
      labelSmall: AppTypography.labelSmall.copyWith(color: const Color(0xFFCBD5E1)),
    ),

    // Input decoration theme for dark
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: Color(0xFF334155)), // Dark border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      contentPadding: AppSpacing.inputPaddingAll,
    ),

    // Card theme for dark
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: AppSpacing.elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      margin: EdgeInsets.zero,
    ),

    // Bottom navigation bar theme for dark
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E293B),
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: Color(0xFF94A3B8),
      elevation: AppSpacing.elevationMd,
      type: BottomNavigationBarType.fixed,
    ),
  );
}