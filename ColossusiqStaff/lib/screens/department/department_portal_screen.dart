import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

class DepartmentLabItem {
  final String title;
  final String department;
  final String description;
  final String meta;
  final Color deptColor;
  final Color deptBgColor;

  const DepartmentLabItem({
    required this.title,
    required this.department,
    required this.description,
    this.meta = "Active (PostgreSQL)",
    required this.deptColor,
    required this.deptBgColor,
  });
}

/// Department Portal Screen [P2]
/// Matches ColossusIQ web UI design with Blueprint hero banner and practical labs gallery
class DepartmentPortalScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const DepartmentPortalScreen({super.key, this.onBack});

  @override
  State<DepartmentPortalScreen> createState() => _DepartmentPortalScreenState();
}

class _DepartmentPortalScreenState extends State<DepartmentPortalScreen> {
  static const List<DepartmentLabItem> _labs = [
    DepartmentLabItem(
      title: "AI Ethics, Bias, and Governance Practical Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Interactive practical problems, lab assignments and exercises for AID102",
      deptColor: Color(0xFF7C3AED),
      deptBgColor: Color(0xFFF3E8FF),
    ),
    DepartmentLabItem(
      title: "Database Management Systems Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE101",
      deptColor: Color(0xFF0284C7),
      deptBgColor: Color(0xFFE0F2FE),
    ),
    DepartmentLabItem(
      title: "DBMS Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE104",
      deptColor: Color(0xFF0284C7),
      deptBgColor: Color(0xFFE0F2FE),
    ),
    DepartmentLabItem(
      title: "Machine Learning Practical Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Interactive practical problems, lab assignments and exercises for AID101",
      deptColor: Color(0xFF7C3AED),
      deptBgColor: Color(0xFFF3E8FF),
    ),
    DepartmentLabItem(
      title: "Operating Systems Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE102",
      deptColor: Color(0xFF0284C7),
      deptBgColor: Color(0xFFE0F2FE),
    ),
    DepartmentLabItem(
      title: "Signals and Systems Practical Lab",
      department: "Electronics & Communication",
      description: "Interactive practical problems, lab assignments and exercises for EC101",
      deptColor: Color(0xFFDC2626),
      deptBgColor: Color(0xFFFEE2E2),
    ),
    DepartmentLabItem(
      title: "Web Technologies Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE106",
      deptColor: Color(0xFF0284C7),
      deptBgColor: Color(0xFFE0F2FE),
    ),
    DepartmentLabItem(
      title: "AI & Neural Networks Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Jupyter notebooks, GPU clusters and deep learning model benchmarking",
      deptColor: Color(0xFF7C3AED),
      deptBgColor: Color(0xFFF3E8FF),
    ),
    DepartmentLabItem(
      title: "Structural GIS & Materials Lab",
      department: "Civil Engineering",
      description: "Building information modelling (BIM), seismic analysis and GIS mapping",
      deptColor: Color(0xFF0D9488),
      deptBgColor: Color(0xFFCCFBF1),
    ),
    DepartmentLabItem(
      title: "Cloud Computing & Systems Lab",
      department: "Computer Science & Engineering",
      description: "Docker containers, Linux virtual machines and distributed systems practice",
      deptColor: Color(0xFFD97706),
      deptBgColor: Color(0xFFFEF3C7),
    ),
    DepartmentLabItem(
      title: "Power Systems & Renewable Energy Lab",
      department: "Electrical & Electronics",
      description: "Smart grid simulations, MATLAB/Simulink models and machine testing",
      deptColor: Color(0xFFD97706),
      deptBgColor: Color(0xFFFEF3C7),
    ),
    DepartmentLabItem(
      title: "Embedded Systems & IoT Lab",
      department: "Electronics & Communication",
      description: "Microcontroller emulators, sensor interface kits and signal analysis",
      deptColor: Color(0xFFDC2626),
      deptBgColor: Color(0xFFFEE2E2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Department Portal",
      category: "Department",
      onBack: widget.onBack,
      badge: const AppBadge(label: "PHASE 2", tone: BadgeTone.brand),
      children: [
        // Hero Glow Blueprint Banner matching web UI
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Department  ›  Department Portal",
          category: "DEPARTMENT",
          phase: "Phase 2",
          icon: Icons.layers_outlined,
          watermarkIcon: Icons.layers_outlined,
          title: "Department Portal",
          subtitle:
              "Department-specific labs and modules — coding lab, CAD, circuits, GIS, case studies.",
        ),
        const SizedBox(height: 20),

        // Gallery Grid of Department Labs
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 640;
            if (isWide) {
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _labs.map((lab) {
                  final cardWidth = (constraints.maxWidth - 16) / 2;
                  return SizedBox(
                    width: cardWidth,
                    child: _buildLabCard(lab),
                  );
                }).toList(),
              );
            }
            return Column(
              children: _labs.map((lab) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildLabCard(lab),
              )).toList(),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLabCard(DepartmentLabItem lab) {
    return InkWell(
      onTap: () => _showLabDetailModal(lab),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEBEFF4), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF162044).withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Dept Pill + Active Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: lab.deptBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        lab.department,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: lab.deptColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  lab.meta,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Lab Title
            Text(
              lab.title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 6),

            // Description
            Text(
              lab.description,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: AppColors.ink2,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLabDetailModal(DepartmentLabItem lab) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: lab.deptBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lab.department,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: lab.deptColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const AppBadge(label: "Active (PostgreSQL)", tone: BadgeTone.teal),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              lab.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lab.description,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                color: AppColors.ink2,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.line),
              ),
              child: Row(
                children: [
                  const Icon(Icons.terminal_outlined, color: AppColors.primaryBlue, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cloud Sandbox Environment",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text("Isolated PostgreSQL 16 container preloaded with dataset",
                            style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Launching ${lab.title} cloud workspace..."),
                      backgroundColor: AppColors.primaryBlue,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                label: Text(
                  "Launch Interactive Practical Lab",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.5, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
