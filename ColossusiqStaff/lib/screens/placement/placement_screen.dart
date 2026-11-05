import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

class PlacementScreen extends StatelessWidget {
  final VoidCallback? onOpenMentor;
  final VoidCallback? onBack;

  const PlacementScreen({super.key, this.onOpenMentor, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Placement Readiness",
      category: "Career",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Placement Readiness",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.track_changes_outlined,
          title: "Placement Readiness",
          subtitle: "Your total out of 100 from quiz marks, certificates, aptitude, mock interview and resume — and what is left to become placement ready.",
          watermarkIcon: Icons.track_changes_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Ring Hero Card
        _buildHeroRingCard(),
        const SizedBox(height: 20),

        // 3. Responsive 2-Column: How total is made + Checklist
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 13, child: _buildHowTotalIsMadeCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 9, child: _buildChecklistCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildHowTotalIsMadeCard(),
                const SizedBox(height: 20),
                _buildChecklistCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeroRingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Donut Progress Ring (60 out of 100)
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    value: 0.60,
                    strokeWidth: 9,
                    backgroundColor: AppColors.veryLightBlue,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "60",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "out of 100",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Header & description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.warningSoft,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Almost ready",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your placement readiness",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "One total built from your department quiz marks, earned certificates, aptitude, mock interview and resume. The placement cell sees the same number, so each step you complete here shows up on their board.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowTotalIsMadeCard() {
    final parts = [
      {"icon": Icons.analytics_outlined, "label": "Quiz average", "weight": 35, "raw": "62%", "points": 22, "pct": 0.62, "color": AppColors.primaryBlue},
      {"icon": Icons.assignment_outlined, "label": "Certificates (4 = full marks)", "weight": 20, "raw": "2 earned", "points": 10, "pct": 0.50, "color": AppColors.warning},
      {"icon": Icons.calculate_outlined, "label": "Aptitude", "weight": 15, "raw": "67%", "points": 10, "pct": 0.67, "color": AppColors.primaryBlue},
      {"icon": Icons.support_agent_outlined, "label": "Mock interview", "weight": 15, "raw": "64%", "points": 10, "pct": 0.64, "color": AppColors.primaryBlue},
      {"icon": Icons.description_outlined, "label": "Resume / profile", "weight": 15, "raw": "58%", "points": 9, "pct": 0.58, "color": AppColors.primaryBlue},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How your total is made",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Weighted score out of 100",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),

          ...parts.map((p) {
            final icon = p["icon"] as IconData;
            final label = p["label"] as String;
            final weight = p["weight"] as int;
            final raw = p["raw"] as String;
            final points = p["points"] as int;
            final pct = p["pct"] as double;
            final color = p["color"] as Color;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(icon, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                label,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "× $weight%",
                              style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.textDisabled),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$raw → ",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: "$points ",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: "/ $weight",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 7,
                      backgroundColor: AppColors.veryLightBlue,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChecklistCard() {
    final checks = [
      {"ok": false, "text": "Total of 70 or more", "now": "60"},
      {"ok": true, "text": "Quiz average of 60% or more", "now": "62%"},
      {"ok": true, "text": "At least 2 certificates", "now": "2"},
      {"ok": true, "text": "Mock interview score of 50 or more", "now": "64"},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Placement-ready checklist",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 18),

          ...checks.map((c) {
            final ok = c["ok"] as bool;
            final text = c["text"] as String;
            final now = c["now"] as String;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    ok ? Icons.check_circle_outline_rounded : Icons.radio_button_unchecked_rounded,
                    color: ok ? AppColors.success : AppColors.textDisabled,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Now: $now",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),

          // Next steps container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next steps",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "•  Complete your resume (ATS score 70+)",
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  "•  Reach a total of 70",
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
