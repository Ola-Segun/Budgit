import 'package:flutter/material.dart';

/// App color constants
/// All colors used throughout the app should be defined here
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color primaryLight = Color(0xFF3B82F6); // Blue 500
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue 700

  // Secondary colors
  static const Color secondary = Color(0xFF64748B); // Slate 500
  static const Color secondaryLight = Color(0xFF94A3B8); // Slate 400
  static const Color secondaryDark = Color(0xFF475569); // Slate 600

  // Semantic colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successLight = Color(0xFF34D399); // Emerald 400
  static const Color successDark = Color(0xFF059669); // Emerald 600

  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningLight = Color(0xFFFCD34D); // Amber 300
  static const Color warningDark = Color(0xFFD97706); // Amber 600

  static const Color danger = Color(0xFFEF4444); // Red 500
  static const Color dangerLight = Color(0xFFF87171); // Red 400
  static const Color dangerDark = Color(0xFFDC2626); // Red 600

  static const Color info = Color(0xFF06B6D4); // Cyan 500
  static const Color infoLight = Color(0xFF22D3EE); // Cyan 400
  static const Color infoDark = Color(0xFF0891B2); // Cyan 600

  // Neutral colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceDark = Color(0xFFF1F5F9); // Slate 100

  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400

  // Border colors
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color borderLight = Color(0xFFF1F5F9); // Slate 100
  static const Color borderDark = Color(0xFFCBD5E1); // Slate 300

  // Special colors
  static const Color income = Color(0xFF10B981); // Green for income
  static const Color expense = Color(0xFFEF4444); // Red for expenses

  // Chart colors
  static const List<Color> chartColors = [
    Color(0xFF2563EB), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Yellow
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Purple
    Color(0xFFF97316), // Orange
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
  ];

  // Category colors
  static const List<Color> categoryColors = [
    Color(0xFF2563EB), // Blue
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Yellow
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Purple
    Color(0xFFF97316), // Orange
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
    Color(0xFF84CC16), // Lime
    Color(0xFFF43F5E), // Rose
    Color(0xFF6366F1), // Indigo
    Color(0xFF14B8A6), // Teal
  ];
}