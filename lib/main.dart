import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

import 'UI/controller/adventure_controller.dart';
import 'UI/controller/adventure_form_controller.dart';
import 'UI/controller/adventure_storage_controller.dart';
import 'UI/views/adventure_details_view.dart';
import 'UI/views/checklist_view.dart';
import 'core/routes.dart';
import 'shared/locator.dart';

const GEM_API_KEY = 'AIzaSyAApC6ekhrXSZmB_dvmjmrsxB2IzyQXDJ8';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Gemini (you'll need to add your API key)
  Gemini.init(apiKey: GEM_API_KEY);

  // Setup dependency injection
  setupLocator();

  // Register GetX controllers
  Get.put(AdventureDetailsController());
  Get.put(ChecklistController());
  Get.put(AdventureStorageController());
  Get.lazyPut(() => AdventureController());
  Get.lazyPut(() => AdventureFormController());

  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adventure Hive',
      theme: _buildAppTheme(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }

  ThemeData _buildAppTheme() {
    // Define the new color palette
    const primaryColor = Color(0xFF2E6939); // Dark green
    const secondaryColor = Color(0xFF2D5F5A); // Dark teal/green
    const accentColor = Color(0xFF95EB84); // Light green (success)
    const warningColor = Color(0xFFEAEA78); // Light yellow
    const surfaceColor = Color(0xFF7B6353); // Brown

    // Light variations for backgrounds and surfaces
    const lightSurface = Color(0xFFF5F3F0); // Very light brown
    const cardSurface = Colors.white;

    // Text colors that work well with light backgrounds
    const primaryText = Color(0xFF1A202C); // Dark gray
    const secondaryText = Color(0xFF4A5568); // Medium gray
    const tertiaryText = Color(0xFF718096); // Light gray

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: lightSurface,
      background: lightSurface,
      error: const Color(0xFFE53E3E),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: primaryText,
      onSurface: primaryText,
      onBackground: primaryText,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: lightSurface,
      fontFamily: 'SFUIDisplay', // Set San Francisco as default font

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: cardSurface,
        foregroundColor: primaryText,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        // Display styles (largest)
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),

        // Title styles
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primaryText,
          fontFamily: 'SFUIDisplay',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: secondaryText,
          fontFamily: 'SFUIDisplay',
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: secondaryText,
          fontFamily: 'SFUIDisplay',
        ),

        // Body text styles
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: secondaryText,
          fontFamily: 'SFUIDisplay',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: secondaryText,
          fontFamily: 'SFUIDisplay',
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: tertiaryText,
          fontFamily: 'SFUIDisplay',
        ),

        // Label styles
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: secondaryText,
          fontFamily: 'SFUIDisplay',
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: tertiaryText,
          fontFamily: 'SFUIDisplay',
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: tertiaryText,
          fontFamily: 'SFUIDisplay',
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: cardSurface,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFUIDisplay',
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFUIDisplay',
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFUIDisplay',
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: tertiaryText.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: tertiaryText.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53E3E)),
        ),
        labelStyle:
            const TextStyle(color: secondaryText, fontFamily: 'SFUIDisplay'),
        hintStyle: TextStyle(color: tertiaryText, fontFamily: 'SFUIDisplay'),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: cardSurface,
        selectedColor: accentColor.withOpacity(0.2),
        checkmarkColor: primaryColor,
        labelStyle:
            const TextStyle(color: secondaryText, fontFamily: 'SFUIDisplay'),
        side: BorderSide(color: tertiaryText.withOpacity(0.3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: secondaryText,
        size: 24,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Additional custom colors accessible via extensions
      extensions: <ThemeExtension<dynamic>>[
        CustomColors(
          success: accentColor,
          warning: warningColor,
          surfaceVariant: surfaceColor,
          primaryContainer: primaryColor.withOpacity(0.1),
          secondaryContainer: secondaryColor.withOpacity(0.1),
        ),
      ],
    );
  }
}

// Custom color extension for additional semantic colors
class CustomColors extends ThemeExtension<CustomColors> {
  final Color success;
  final Color warning;
  final Color surfaceVariant;
  final Color primaryContainer;
  final Color secondaryContainer;

  const CustomColors({
    required this.success,
    required this.warning,
    required this.surfaceVariant,
    required this.primaryContainer,
    required this.secondaryContainer,
  });

  @override
  CustomColors copyWith({
    Color? success,
    Color? warning,
    Color? surfaceVariant,
    Color? primaryContainer,
    Color? secondaryContainer,
  }) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
    );
  }

  // Helper to access custom colors from context
  static CustomColors of(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }
}
