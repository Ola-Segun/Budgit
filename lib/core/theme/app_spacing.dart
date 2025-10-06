import 'package:flutter/material.dart';

/// App spacing constants
/// All spacing values used throughout the app should be defined here
class AppSpacing {
  // Base spacing units (4px grid system)
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Screen padding
  static const EdgeInsets screenPaddingAll = EdgeInsets.all(md);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: md);

  // Card padding
  static const EdgeInsets cardPaddingAll = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets cardPaddingVertical = EdgeInsets.symmetric(vertical: md);

  // Button padding
  static const EdgeInsets buttonPaddingAll = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(horizontal: md, vertical: sm);

  // Input padding
  static const EdgeInsets inputPaddingAll = EdgeInsets.symmetric(horizontal: md, vertical: md);
  static const EdgeInsets inputPaddingHorizontal = EdgeInsets.symmetric(horizontal: md);

  // Gap sizes for Gap widget
  static const double gapXs = xs;
  static const double gapSm = sm;
  static const double gapMd = md;
  static const double gapLg = lg;
  static const double gapXl = xl;
  static const double gapXxl = xxl;

  // Icon sizes
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
  static const double iconXxl = 48;

  // Border radius
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusXxl = 32;

  // Border width
  static const double borderWidthThin = 1;
  static const double borderWidthMedium = 2;
  static const double borderWidthThick = 4;

  // Elevation
  static const double elevationNone = 0;
  static const double elevationXs = 1;
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevationLg = 8;
  static const double elevationXl = 16;

  // Touch targets (minimum 48x48 for accessibility)
  static const double touchTargetMin = 48;

  // List item heights
  static const double listItemHeightSm = 48;
  static const double listItemHeightMd = 56;
  static const double listItemHeightLg = 72;

  // App bar height
  static const double appBarHeight = 56;

  // Bottom navigation height
  static const double bottomNavHeight = 80;

  // Tab bar height
  static const double tabBarHeight = 48;

  // Dialog width constraints
  static const double dialogMaxWidth = 400;
  static const double dialogMinWidth = 280;

  // Sheet width constraints
  static const double sheetMaxWidth = 400;
}