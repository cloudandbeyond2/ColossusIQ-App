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

  void _showCertificateDetailsDialog(BuildContext context, dynamic cert) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.workspace_premium, color: Color(0xFFD97706), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cert.title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("ID: ${cert.id}", style: GoogleFonts.jetBrainsMono(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Grade", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${cert.grade} (${cert.gradeLabel})", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF059669))),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Score", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${cert.marks}/${cert.total} (${cert.percentage}%)", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF2563EB))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.verified_outlined, size: 16, color: Color(0xFF059669)),
                    const SizedBox(width: 6),
                    Text("Issued: ${cert.issuedDate}", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Verification Authority", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Digitally verified and tamper-proof ColossusIQ credential issued by Anna Institute of Technology.",
                  style: GoogleFonts.poppins(fontSize: 12, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showEditCertificateDialog(context, cert);
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
                child: const Text("Edit Notes"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditCertificateDialog(BuildContext context, dynamic cert) {
    final titleCtrl = TextEditingController(text: cert.title);
    final notesCtrl = TextEditingController(text: "Include in placement verified resume portfolio.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Certificate Preferences", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Certificate Display Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Portfolio / LinkedIn Note", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Certificate preferences updated!"),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
                child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
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

            // Action Links Row: View & Print | View Details | Edit | Copy link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  TextButton.icon(
                    onPressed: () => _showCertificateDialog(context, cert),
                    icon: Icon(Icons.print_outlined, size: 15, color: AppColors.primaryBlue),
                    label: Text(
                      "View & print",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showCertificateDetailsDialog(context, cert),
                    icon: const Icon(Icons.visibility_outlined, size: 15, color: Color(0xFF0F766E)),
                    label: Text(
                      "View details",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showEditCertificateDialog(context, cert),
                    icon: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFF4338CA)),
                    label: Text(
                      "Edit",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4338CA),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Verification link copied to clipboard!"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: Icon(Icons.link_rounded, size: 15, color: AppColors.textSecondary),
                    label: Text(
                      "Copy link",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
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
