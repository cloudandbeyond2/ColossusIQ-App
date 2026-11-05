import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

enum BadgeTone {
  brand,
  gold,
  teal,
  rose,
  amber,
  sky,
  neutral,
  success,
  warning,
  error,
  info,
}

/// Unified Status Badge component for the Professional Education Portal
class AppBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;
  final IconData? icon;
  final VoidCallback? onTap;

  const AppBadge({
    super.key,
    required this.label,
    this.tone = BadgeTone.brand,
    this.icon,
    this.onTap,
  });

  const AppBadge.success({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : tone = BadgeTone.success;

  const AppBadge.warning({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : tone = BadgeTone.warning;

  const AppBadge.info({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : tone = BadgeTone.info;

  const AppBadge.error({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  }) : tone = BadgeTone.error;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color border;

    switch (tone) {
      case BadgeTone.brand:
      case BadgeTone.sky:
      case BadgeTone.info:
        // Info / Completed: Light Blue + Blue
        bg = AppColors.lightBlue;
        fg = AppColors.primaryBlue;
        border = AppColors.primaryBlue.withValues(alpha: 0.25);
        break;

      case BadgeTone.teal:
      case BadgeTone.success:
        // Active / Success: Light Green + Green
        bg = AppColors.successBg;
        fg = AppColors.success;
        border = AppColors.success.withValues(alpha: 0.25);
        break;

      case BadgeTone.amber:
      case BadgeTone.gold:
      case BadgeTone.warning:
        // Pending / Warning: Light Orange + Orange
        bg = AppColors.warningBg;
        fg = AppColors.warning;
        border = AppColors.warning.withValues(alpha: 0.3);
        break;

      case BadgeTone.rose:
      case BadgeTone.error:
        // Failed / Danger: Light Red + Red
        bg = AppColors.errorBg;
        fg = AppColors.error;
        border = AppColors.error.withValues(alpha: 0.25);
        break;

      case BadgeTone.neutral:
        // Neutral: Very Light Blue / Grey + Secondary text
        bg = AppColors.veryLightBlue;
        fg = AppColors.textSecondary;
        border = AppColors.border;
        break;
    }

    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: fg,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: content,
      );
    }
    return content;
  }
}
