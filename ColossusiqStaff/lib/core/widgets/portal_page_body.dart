import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Clean, responsive page body wrapper for all student portal screens.
/// Enforces consistent horizontal padding (16 mobile / 24 tablet / 32 desktop),
/// maximum content width (1280px), and clear hierarchical structure.
class PortalPageBody extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? category;
  final Widget? badge;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Widget? searchOrFilter;
  final List<Widget> children;
  final Widget? customBody;
  final EdgeInsetsGeometry? customPadding;

  const PortalPageBody({
    super.key,
    required this.title,
    this.subtitle,
    this.category,
    this.badge,
    this.actions,
    this.onBack,
    this.searchOrFilter,
    this.children = const [],
    this.customBody,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double horizPadding = width >= 1024
            ? 32.0
            : width >= 600
                ? 24.0
                : 16.0;

        Widget content;
        if (customBody != null) {
          content = customBody!;
        } else {
          content = ListView(
            padding: customPadding ??
                EdgeInsets.fromLTRB(horizPadding, 16, horizPadding, 90),
            children: [
              if (subtitle != null && title.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (onBack != null) ...[
                      IconButton(
                        onPressed: onBack,
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: AppColors.textPrimary,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (category != null)
                            Text(
                              category!.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlue,
                                letterSpacing: 0.5,
                              ),
                            ),
                          Text(
                            title,
                            style: AppTypography.pageTitle,
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 3),
                            Text(
                              subtitle!,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    ?badge,
                    if (actions != null) ...[
                      const SizedBox(width: 12),
                      ...actions!,
                    ],
                  ],
                ),
                const SizedBox(height: 16),
              ],
              if (searchOrFilter != null) ...[
                searchOrFilter!,
                const SizedBox(height: 16),
              ],
              ...children,
            ],
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: content,
          ),
        );
      },
    );
  }
}
