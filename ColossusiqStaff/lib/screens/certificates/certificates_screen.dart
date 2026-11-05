import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/certificate_grades_card.dart';
import '../../core/widgets/portal_page_body.dart';
import '../../data/mock_data.dart';
import '../../data/models/placement_model.dart';

class CertificatesScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CertificatesScreen({super.key, this.onBack});

  void _showCertificateDialog(BuildContext context, CertificateItem cert) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Blue Badge Header
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                "COLOSSUSIQ CREDENTIAL",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Certificate of Achievement",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "This certifies that Anand R has satisfactorily passed the rigorous department examination with Grade ${cert.grade} (${cert.gradeLabel}) in:",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  cert.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("SCORE",
                          style: GoogleFonts.poppins(
                              fontSize: 10, color: AppColors.textSecondary)),
                      Text("${cert.percentage}%",
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("GRADE",
                          style: GoogleFonts.poppins(
                              fontSize: 10, color: AppColors.textSecondary)),
                      Text(cert.grade,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("DATE",
                          style: GoogleFonts.poppins(
                              fontSize: 10, color: AppColors.ink3)),
                      Text(cert.issuedDate,
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Credential ID: ${cert.id}",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: AppColors.ink3,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(ctx).pop(),
                icon: const Icon(Icons.close, size: 16),
                label: const Text("Close Certificate"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final certs = MockData.certificates;

    return PortalPageBody(
      title: "My Certificates",
      category: "AI Course & Certification",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  AI Course & Certification  ›  My Certificates",
          category: "AI Course & Certification",
          phase: "MVP",
          isMvp: true,
          icon: Icons.workspace_premium_outlined,
          title: "My Certificates",
          subtitle: "Mark-based certificates (O, A+, A, B, C) with a public verification link for employers.",
          watermarkIcon: Icons.military_tech_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Responsive Certificates + Certificate Grades Sidebar Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: certs.map((c) => _buildCertificateCard(context, c)).toList(),
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    flex: 4,
                    child: CertificateGradesCard(),
                  ),
                ],
              );
            }
            return Column(
              children: [
                ...certs.map((c) => _buildCertificateCard(context, c)),
                const SizedBox(height: 12),
                const CertificateGradesCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCertificateCard(BuildContext context, CertificateItem cert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Primary Blue Ribbon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CERTIFICATE OF ACHIEVEMENT",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cert.title,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cert.department,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.workspace_premium_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Grade badge box
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        cert.grade,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${cert.marks}/${cert.total} · ${cert.percentage}% · ${cert.gradeLabel}",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          "${cert.id} · ${cert.issuedDate}",
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.border, height: 1),

            // Action Links Row: View & Print | Copy verification link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showCertificateDialog(context, cert),
                    icon: Icon(Icons.print_outlined, size: 16, color: AppColors.primaryBlue),
                    label: Text(
                      "View & print",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Verification link copied to clipboard!"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: Icon(Icons.link_rounded, size: 16, color: AppColors.textSecondary),
                    label: Text(
                      "Copy verification link",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
