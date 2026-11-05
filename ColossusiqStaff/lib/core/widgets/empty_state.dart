import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

/// Clean, centered empty state component
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(icon, size: 32, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.cardTitle,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 18),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Subtle clean empty card for lists and tables
class NotebookEmptyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;
  final double height;
  final IconData icon;

  const NotebookEmptyCard({
    super.key,
    this.title = "No matching records",
    this.subtitle = "Try a different search or filter.",
    this.action,
    this.height = 180,
    this.icon = Icons.search_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.cardTitle,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                ),
              ),
              if (action != null) ...[
                const SizedBox(height: 14),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
