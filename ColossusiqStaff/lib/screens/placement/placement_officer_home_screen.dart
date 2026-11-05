import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'placement_drives_screen.dart';
import 'placement_readiness_board_screen.dart';
import 'placement_analytics_screen.dart';

// =============================================================================
// PLACEMENT OFFICER: HOME DASHBOARD SCREEN
// Matches Image 1:
// - Eyebrow title: PLACEMENT OFFICER
// - Header greeting: "Good morning, Ms. Priya Nair · Training & Placement"
// - 4 Top Metric KPI Cards (Offers, Placement ready, Readiness, Upcoming drives)
// - Middle section: Offers by company (bar chart), Readiness & mock interview (grouped bar chart), Needs your attention (5 alerts)
// - Bottom section: AI insights card (Evidence-linked, Certificates weakest, 8 students close)
// =============================================================================

class PlacementOfficerHomeScreen extends StatelessWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const PlacementOfficerHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1040;
        final isTablet =
            constraints.maxWidth >= 640 && constraints.maxWidth < 1040;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 28 : (isTablet ? 20 : 16),
            22,
            isDesktop ? 28 : (isTablet ? 20 : 16),
            120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Section (Fully responsive)
              _buildHeader(isDesktop, isTablet, constraints.maxWidth),
              const SizedBox(height: 20),

              // 2. Top 4 Metric KPI Cards
              _buildTopKpiRow(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 3. Middle Section: Offers by company, Readiness by dept, Needs your attention
              _buildMiddleSection(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 4. Bottom Section: AI Insights Card
              _buildAiInsightsCard(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 1. HEADER (Image 1) - Responsive across mobile, tablet & desktop
  // ---------------------------------------------------------------------------
  Widget _buildHeader(bool isDesktop, bool isTablet, double maxWidth) {
    final isMobile = maxWidth < 640;

    final double categorySize = isDesktop ? 11.0 : (isTablet ? 10.5 : 10.0);
    final double titleSize = maxWidth >= 1200
        ? 24.0
        : (maxWidth >= 1040
            ? 22.0
            : (maxWidth >= 768
                ? 20.0
                : (maxWidth >= 480 ? 18.0 : 16.5)));
    final double subSize = isDesktop ? 13.0 : (isTablet ? 12.5 : 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PLACEMENT OFFICER",
          style: GoogleFonts.poppins(
            fontSize: categorySize,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: const Color(0xFF64748B),
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              "Good morning, Ms. Priya Nair",
              style: GoogleFonts.poppins(
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.4,
                height: 1.25,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF64748B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Training & Placement",
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.4,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isMobile ? 4 : 5),
        Text(
          "Drives, eligibility, job matching and placement analytics.",
          style: GoogleFonts.poppins(
            fontSize: subSize,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. TOP 4 METRIC CARDS (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildTopKpiRow(bool isDesktop, bool isTablet) {
    final card1 = _buildTopMetricCard(
      title: "Offers",
      value: "46",
      badgeText: "~ 2 drives completed",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFFD97706),
      icon: Icons.business_center_outlined,
      iconColor: const Color(0xFFD97706),
      iconBgColor: const Color(0xFFFEF3C7),
      onTap: () => onOpenSubScreen(
        const PlacementDrivesScreen(),
        title: "Placement Drives",
      ),
    );

    final card2 = _buildTopMetricCard(
      title: "Placement ready",
      value: "3",
      badgeText: "~ of 14 students",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF1E2865),
      icon: Icons.assignment_ind_outlined,
      iconColor: const Color(0xFF1E2865),
      iconBgColor: const Color(0xFFEEF2FF),
      onTap: () => onOpenSubScreen(
        const PlacementReadinessBoardScreen(),
        title: "Placement Readiness Board",
      ),
    );

    final card3 = _buildTopMetricCard(
      title: "Readiness",
      value: "65%",
      topAccentColor: const Color(0xFF0D9488),
      icon: Icons.trending_up_rounded,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      onTap: () => onOpenSubScreen(
        const PlacementAnalyticsScreen(),
        title: "Placement Analytics",
      ),
    );

    final card4 = _buildTopMetricCard(
      title: "Upcoming drives",
      value: "4",
      badgeText: "~ 3 open now",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF2563EB),
      icon: Icons.calendar_today_outlined,
      iconColor: const Color(0xFF2563EB),
      iconBgColor: const Color(0xFFEFF6FF),
      onTap: () => onOpenSubScreen(
        const PlacementDrivesScreen(),
        title: "Placement Drives",
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: card1),
          const SizedBox(width: 14),
          Expanded(child: card2),
          const SizedBox(width: 14),
          Expanded(child: card3),
          const SizedBox(width: 14),
          Expanded(child: card4),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: card3),
            const SizedBox(width: 12),
            Expanded(child: card4),
          ]),
        ],
      );
    } else {
      return Column(
        children: [
          card1,
          const SizedBox(height: 10),
          card2,
          const SizedBox(height: 10),
          card3,
          const SizedBox(height: 10),
          card4,
        ],
      );
    }
  }

  Widget _buildTopMetricCard({
    required String title,
    required String value,
    required Color topAccentColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    String? badgeText,
    Color? badgeColor,
    Color? badgeBgColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top colored accent bar
              Container(
                height: 3.5,
                decoration: BoxDecoration(
                  color: topAccentColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          if (badgeText != null) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeBgColor ?? const Color(0xFFCCFBF1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up_rounded,
                                    size: 11,
                                    color: badgeColor ?? const Color(0xFF0D9488),
                                  ),
                                  const SizedBox(width: 3),
                                  Flexible(
                                    child: Text(
                                      badgeText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: badgeColor ??
                                            const Color(0xFF0D9488),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. MIDDLE SECTION (Offers by company, Readiness by dept, Needs attention)
  // ---------------------------------------------------------------------------
  Widget _buildMiddleSection(bool isDesktop, bool isTablet) {
    final chart1 = _buildOffersByCompanyCard();
    final chart2 = _buildReadinessByDepartmentCard();
    final attentionCard = _buildNeedsAttentionCard();

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: chart1),
          const SizedBox(width: 14),
          Expanded(flex: 7, child: chart2),
          const SizedBox(width: 14),
          Expanded(flex: 6, child: attentionCard),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: chart1),
              const SizedBox(width: 14),
              Expanded(child: chart2),
            ],
          ),
          const SizedBox(height: 14),
          attentionCard,
        ],
      );
    } else {
      return Column(
        children: [
          chart1,
          const SizedBox(height: 14),
          chart2,
          const SizedBox(height: 14),
          attentionCard,
        ],
      );
    }
  }

  // Card 1: Offers by company (TCS: 28, Zoho: 18)
  Widget _buildOffersByCompanyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Offers by company",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels (28, 21, 14, 7, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("28",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("21",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("14",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("7",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                // Bars Row with Grid Lines
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (i) => const Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      // Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildSingleBar(
                            label: "Tata Consultancy Services (TCS)",
                            heightFactor: 1.0, // 28/28
                          ),
                          _buildSingleBar(
                            label: "Zoho Corporation",
                            heightFactor: 18 / 28.0, // 18/28
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleBar({
    required String label,
    required double heightFactor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 135 * heightFactor,
          decoration: const BoxDecoration(
            color: Color(0xFF161E4A),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 90,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  // Card 2: Readiness and mock interview by department (Grouped bar chart)
  Widget _buildReadinessByDepartmentCard() {
    final depts = [
      {'name': 'Information Tech.', 'readiness': 0.76, 'interview': 0.85},
      {'name': 'Electronics & Communicat', 'readiness': 0.75, 'interview': 0.67},
      {'name': 'Mechanical Eng.', 'readiness': 0.61, 'interview': 0.45},
      {'name': 'Civil Eng.', 'readiness': 0.59, 'interview': 0.65},
      {'name': 'Science & Humanities', 'readiness': 0.52, 'interview': 0.47},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Readiness and mock interview by department",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels (100, 75, 50, 25, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("100",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("75",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("50",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("25",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                // Stack with grid lines and double bars
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (i) => const Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      // Grouped Bars Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: depts.map((d) {
                          final double rHeight = 135 * (d['readiness'] as double);
                          final double iHeight = 135 * (d['interview'] as double);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Navy Readiness bar
                                  Container(
                                    width: 10,
                                    height: rHeight,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF161E4A),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  // Amber Interview bar
                                  Container(
                                    width: 10,
                                    height: iHeight,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD97706),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 44,
                                child: Text(
                                  d['name'] as String,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF161E4A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Readiness",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 14),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Interview",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card 3: Needs your attention (5 items matching Image 1)
  Widget _buildNeedsAttentionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Needs your attention",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildAttentionItem(
            barColor: const Color(0xFF161E4A), // Navy
            title: "Amazon AWS drive — shortlist",
            subtitle: "18 Oct · 1 eligible · 54 registered",
            onTap: () => onOpenSubScreen(
              const PlacementDrivesScreen(),
              title: "Placement Drives",
            ),
          ),
          const SizedBox(height: 10),
          _buildAttentionItem(
            barColor: const Color(0xFF161E4A), // Navy
            title: "Google India drive — shortlist",
            subtitle: "25 Oct · 2 eligible · 48 registered",
            onTap: () => onOpenSubScreen(
              const PlacementDrivesScreen(),
              title: "Placement Drives",
            ),
          ),
          const SizedBox(height: 10),
          _buildAttentionItem(
            barColor: const Color(0xFF161E4A), // Navy
            title: "Microsoft Corporation drive — shortlist",
            subtitle: "5 Nov · 2 eligible · 65 registered",
            onTap: () => onOpenSubScreen(
              const PlacementDrivesScreen(),
              title: "Placement Drives",
            ),
          ),
          const SizedBox(height: 10),
          _buildAttentionItem(
            barColor: const Color(0xFFDC2626), // Red
            title: "3 students need work",
            subtitle: "Open the readiness board to see their gaps",
            onTap: () => onOpenSubScreen(
              const PlacementReadinessBoardScreen(),
              title: "Placement Readiness Board",
            ),
          ),
          const SizedBox(height: 10),
          _buildAttentionItem(
            barColor: const Color(0xFFD97706), // Amber
            title: "1 draft drive to publish",
            subtitle: "Open registrations when ready",
            onTap: () => onOpenSubScreen(
              const PlacementDrivesScreen(),
              title: "Placement Drives",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionItem({
    required Color barColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Colored left indicator bar
            Container(
              width: 3.5,
              height: 38,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. BOTTOM SECTION: AI INSIGHTS CARD (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildAiInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with bulb and Evidence-linked badge
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFFD97706),
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "AI insights",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Insight 1
          _buildInsightBullet(
            bulletColor: const Color(0xFFDC2626), // Red
            title: "Certificates is the weakest readiness area",
            subtitle:
                "Students average 59% in certificates, against 78% in resume. Targeted practice here lifts the most students toward placement ready.",
            evidence: "Evidence: 14 students on the readiness board",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
          ),

          // Insight 2
          _buildInsightBullet(
            bulletColor: const Color(0xFF0D9488), // Teal
            title: "8 students are close to placement ready",
            subtitle:
                "The most common gap among them is quiz average (5 students). A short push there moves them onto the shortlist.",
            evidence: "Evidence: 14 students on the readiness board",
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBullet({
    required Color bulletColor,
    required String title,
    required String subtitle,
    required String evidence,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: bulletColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                evidence,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
