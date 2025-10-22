import 'package:flutter/material.dart';
import '../main.dart';

/// Helper class for accessing theme colors throughout the app
///
/// Usage Examples:
/// ```dart
/// // In build method:
/// final colors = AppColors.of(context);
///
/// // Use primary color:
/// color: colors.primary
///
/// // Use success color:
/// color: colors.success
///
/// // Use container colors:
/// backgroundColor: colors.primaryContainer
/// ```
class AppColors {
  final BuildContext context;
  late final ColorScheme _colorScheme;
  late final CustomColors _customColors;

  AppColors(this.context) {
    _colorScheme = Theme.of(context).colorScheme;
    _customColors = CustomColors.of(context);
  }

  /// Factory constructor for easy access
  static AppColors of(BuildContext context) => AppColors(context);

  // Primary Colors
  Color get primary => _colorScheme.primary; // Dark green #2E6939
  Color get secondary => _colorScheme.secondary; // Dark teal #2D5F5A
  Color get primaryContainer => _customColors.primaryContainer;
  Color get secondaryContainer => _customColors.secondaryContainer;

  // Semantic Colors
  Color get success => _customColors.success; // Light green #95EB84
  Color get warning => _customColors.warning; // Light yellow #EAEA78
  Color get error => _colorScheme.error; // Red for errors

  // Surface Colors
  Color get surface => _colorScheme.surface; // Light brown #F5F3F0
  Color get background => _colorScheme.background; // Same as surface
  Color get surfaceVariant => _customColors.surfaceVariant; // Brown #7B6353

  // Text Colors (automatically calculated to work with light backgrounds)
  Color get onPrimary => _colorScheme.onPrimary; // White
  Color get onSecondary => _colorScheme.onSecondary; // White
  Color get onSurface => _colorScheme.onSurface; // Dark text
  Color get onBackground => _colorScheme.onBackground; // Dark text

  // Convenience getters for common use cases
  Color get cardBackground => surface;
  Color get buttonPrimary => primary;
  Color get buttonSecondary => secondary;
  Color get accentColor => success;
  Color get warningColor => warning;
}

/// Color Palette Documentation
/// 
/// Primary Colors:
/// - Primary: #2E6939 (Dark Green) - Main brand color, buttons, links
/// - Secondary: #2D5F5A (Dark Teal) - Secondary actions, accents
/// 
/// Semantic Colors:
/// - Success: #95EB84 (Light Green) - Success states, positive actions
/// - Warning: #EAEA78 (Light Yellow) - Warning states, attention
/// - Error: #E53E3E (Red) - Error states, destructive actions
/// 
/// Surface Colors:
/// - Background: #F5F3F0 (Light Brown) - Main app background
/// - Surface: #FFFFFF (White) - Cards, sheets, elevated surfaces
/// - Surface Variant: #7B6353 (Brown) - Alternative surfaces, overlays
/// 
/// Usage Guidelines:
/// 1. Always use theme colors instead of hardcoded values
/// 2. Use AppColors.of(context) for easy access to all colors
/// 3. Primary color for main actions and branding
/// 4. Secondary color for supporting elements
/// 5. Success color for positive feedback and selections
/// 6. Warning color for attention and caution states
/// 7. Surface colors create proper hierarchy and depth 