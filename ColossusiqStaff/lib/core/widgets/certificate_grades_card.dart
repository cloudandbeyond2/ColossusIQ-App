import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

/// Professional Grade Scale & Certificate criteria card
class CertificateGradesCard extends StatelessWidget {
  const CertificateGradesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Certificate Grades",
                      style: AppTypography.cardTitle,
                    ),
                    Text(
                      "Based on your marks in the quiz",
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _gradeRow("O", "Outstanding", "90 - 100%", isFail: false),
          _gradeRow("A+", "Distinction", "80 - 89%", isFail: false),
          _gradeRow("A", "First Class", "70 - 79%", isFail: false),
          _gradeRow("B", "Second Class", "60 - 69%", isFail: false),
          _gradeRow("C", "Pass", "Pass mark - 59%", isFail: false),
          _gradeRow("RA", "Re-appear (no certificate)", "Below pass mark", isFail: true),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 15,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "3 attempts per quiz. Your best mark counts, and a higher mark re-issues the certificate.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gradeRow(String grade, String title, String range, {required bool isFail}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isFail ? AppColors.errorBg : AppColors.lightBlue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isFail ? AppColors.error.withValues(alpha: 0.25) : AppColors.primaryBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                grade,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isFail ? AppColors.error : AppColors.primaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isFail ? AppColors.error : AppColors.textPrimary,
                  ),
                ),
                Text(
                  range,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable Certificate Item Card
class CertificateItemCard extends StatelessWidget {
  final String title;
  final String courseName;
  final String grade;
  final String date;
  final VoidCallback? onViewCertificate;

  const CertificateItemCard({
    super.key,
    required this.title,
    required this.courseName,
    required this.grade,
    required this.date,
    this.onViewCertificate,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.card_membership_rounded,
                  color: AppColors.primaryBlue,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      courseName,
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
                ),
                child: Text(
                  "Grade: $grade",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
              if (onViewCertificate != null)
                OutlinedButton(
                  onPressed: onViewCertificate,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text("View Certificate", style: TextStyle(fontSize: 12)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
