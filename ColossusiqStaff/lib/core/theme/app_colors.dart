import 'package:flutter/material.dart';

/// Professional Education & College Management Portal Color System
/// Clean WHITE + BLUE based design system matching requirements.
class AppColors {
  // ===========================================================================
  // 1. PRIMARY BLUE / DEEP NAVY BLUEPRINT PALETTE
  // ===========================================================================
  static const Color primaryBlue = Color(0xFF2E3A94); // Deep indigo navy (applied from second image)
  static const Color darkBlue = Color(0xFF131838);    // Deep midnight blueprint navy
  static const Color lightBlue = Color(0xFFEEF2FF);
  static const Color veryLightBlue = Color(0xFFF8FAFC);

  // ===========================================================================
  // 2. BACKGROUND & SURFACES
  // ===========================================================================
  static const Color bg = Color(0xFFF7F9FC); // Main scaffold background
  static const Color surface = Color(0xFFFFFFFF); // Card background
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surface2 = Color(0xFFF5F9FF); // Subtle alternate surface

  // ===========================================================================
  // 3. TEXT & TYPOGRAPHY
  // ===========================================================================
  static const Color textPrimary = Color(0xFF172033);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textDisabled = Color(0xFF98A2B3);

  // ===========================================================================
  // 4. BORDERS & DIVIDERS
  // ===========================================================================
  static const Color border = Color(0xFFE4E7EC);
  static const Color line = Color(0xFFE4E7EC);

  // ===========================================================================
  // 5. STATUS & SEMANTIC FEEDBACK
  // ===========================================================================
  // Success
  static const Color success = Color(0xFF2E7D32);
  static const Color successBg = Color(0xFFE8F5E9);
  static const Color successSoft = successBg;

  // Warning
  static const Color warning = Color(0xFFED6C02);
  static const Color warningBg = Color(0xFFFFF3E0);
  static const Color warningSoft = warningBg;

  // Error
  static const Color error = Color(0xFFD32F2F);
  static const Color errorBg = Color(0xFFFFEBEE);
  static const Color errorSoft = errorBg;

  // Info
  static const Color info = Color(0xFF2E3A94);
  static const Color infoBg = Color(0xFFEEF2FF);
  static const Color infoSoft = infoBg;

  // ===========================================================================
  // 6. BACKWARD COMPATIBILITY TOKENS
  // ===========================================================================
  static const Color brand = primaryBlue;
  static const Color brandStrong = darkBlue;
  static const Color brandSoft = lightBlue;
  static const Color brand2 = primaryBlue;

  static const Color ink = textPrimary;
  static const Color ink2 = textSecondary;
  static const Color ink3 = textDisabled;
  static const Color onBrand = Colors.white;

  // Semantic mappings
  static const Color teal = success;
  static const Color tealSoft = successBg;
  static const Color amber = warning;
  static const Color amberSoft = warningBg;
  static const Color rose = error;
  static const Color roseSoft = errorBg;
  static const Color sky = primaryBlue;
  static const Color skySoft = lightBlue;
  static const Color gold = warning;
  static const Color goldSoft = warningBg;
  static const Color violet = primaryBlue;
  static const Color violetSoft = lightBlue;
  static const Color ring = primaryBlue;

  // ===========================================================================
  // 7. GRADIENTS (Deep Indigo Blueprint accents matching reference)
  // ===========================================================================
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF131838),
      Color(0xFF232D6E),
    ],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF131838),
      Color(0xFF232D6E),
    ],
  );

  static const LinearGradient blueprintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF131838),
      Color(0xFF1B2358),
      Color(0xFF232D6E),
    ],
  );

  static const LinearGradient subtleBlueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF5F9FF),
      Color(0xFFFFFFFF),
    ],
  );

  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2E7D32),
      Color(0xFF388E3C),
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFED6C02),
      Color(0xFFF57C00),
    ],
  );

  // ===========================================================================
  // 8. CARD SHADOWS (Soft, non-distracting)
  // ===========================================================================
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x08172033),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x06172033),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  // ===========================================================================
  // 9. HELPER TONE RESOLVERS
  // ===========================================================================
  static Color toneForScore(int score) {
    if (score >= 75) return success;
    if (score >= 50) return warning;
    return error;
  }

  static Color softToneForScore(int score) {
    if (score >= 75) return successBg;
    if (score >= 50) return warningBg;
    return errorBg;
  }
}
