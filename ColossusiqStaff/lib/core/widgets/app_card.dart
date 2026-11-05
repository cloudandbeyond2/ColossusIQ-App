import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum AppCardVariant {
  normal,
  primary,
  secondary,
  highlighted,
  danger,
  success,
}

/// Unified classic card component for the Professional Education Portal
class AppCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final Widget? action;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final Border? border;
  final double borderRadius;
  final bool clip;
  final AppCardVariant variant;

  const AppCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = 12,
    this.clip = false,
    this.variant = AppCardVariant.normal,
  });

  const AppCard.primary({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = 12,
    this.clip = false,
  }) : variant = AppCardVariant.primary;

  const AppCard.highlighted({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = 12,
    this.clip = false,
  }) : variant = AppCardVariant.highlighted;

  const AppCard.success({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = 12,
    this.clip = false,
  }) : variant = AppCardVariant.success;

  const AppCard.danger({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.border,
    this.borderRadius = 12,
    this.clip = false,
  }) : variant = AppCardVariant.danger;

  @override
  Widget build(BuildContext context) {
    Color cardBg = color ?? AppColors.cardBg;
    Border cardBorder = border ?? Border.all(color: AppColors.border, width: 1);
    Widget? indicator;

    switch (variant) {
      case AppCardVariant.primary:
        cardBg = color ?? AppColors.cardBg;
        cardBorder = border ?? Border.all(color: AppColors.border, width: 1);
        break;
      case AppCardVariant.highlighted:
        cardBg = color ?? AppColors.veryLightBlue;
        cardBorder = border ?? Border.all(color: AppColors.lightBlue, width: 1);
        break;
      case AppCardVariant.success:
        cardBg = color ?? AppColors.cardBg;
        cardBorder = border ?? Border.all(color: AppColors.success.withValues(alpha: 0.25), width: 1);
        indicator = Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.success,
            borderRadius: BorderRadius.circular(2),
          ),
        );
        break;
      case AppCardVariant.danger:
        cardBg = color ?? AppColors.cardBg;
        cardBorder = border ?? Border.all(color: AppColors.error.withValues(alpha: 0.25), width: 1);
        indicator = Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(2),
          ),
        );
        break;
      case AppCardVariant.normal:
      case AppCardVariant.secondary:
        cardBg = color ?? AppColors.cardBg;
        cardBorder = border ?? Border.all(color: AppColors.border, width: 1);
        break;
    }

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null || action != null || icon != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (indicator != null) ...[
                  indicator,
                  const SizedBox(width: 8),
                ],
                if (icon != null) ...[
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 20,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: AppTypography.cardTitle,
                        ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: AppTypography.caption,
                        ),
                      ],
                    ],
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(width: 8),
                  action!,
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
        ],
        if (child != null)
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child!,
          ),
      ],
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: cardBorder,
        boxShadow: const [
          BoxShadow(
            color: Color(0x08172033),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      child: Material(
        color: Colors.transparent,
        child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: content,
            )
          : content,
      ),
    );
  }
}

/// Specialized classic Stat / Dashboard Card
/// 📚 Title, Large Metric Value, Subtitle, optional progress
class DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final double? progress;
  final VoidCallback? onTap;

  const DashboardStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (progress != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: AppColors.lightBlue,
                valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
