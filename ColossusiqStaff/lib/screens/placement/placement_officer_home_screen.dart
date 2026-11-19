import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'placement_drives_screen.dart';
import 'placement_readiness_board_screen.dart';
import 'placement_analytics_screen.dart';
import 'placement_job_matching_screen.dart';

// =============================================================================
// PLACEMENT OFFICER: HOME DASHBOARD SCREEN
// Matches Image 1 & 2:
// - Eyebrow title: PLACEMENT OFFICER • LIVE • SYNCED 10:13:48 AM
// - Header greeting: "Good morning, Mr. R. Karthikeyan · Training & Placement Office · Anna Institute of Technology"
// - Top actions: "Sync live", "Campus Drives", "Placement Board"
// - Placement Command Center Banner: Training & Placement Operations with tabs
// - 6 Top Metric KPI Cards (Offers Secured, Placement Ready, Average Package, Active Campus Drives, Resume ATS Ready, Mock Interview Average)
// - Middle section: Offers by company, Readiness by dept (grouped bar chart), Needs your attention (5 alerts)
// - Funnel & Score Distribution section: Campus hiring funnel, Readiness score distribution
// - Bottom section: AI insights card (Evidence-linked, Mock interview weakest, 1 student close)
// =============================================================================

class PlacementOfficerHomeScreen extends StatefulWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const PlacementOfficerHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  State<PlacementOfficerHomeScreen> createState() =>
      _PlacementOfficerHomeScreenState();
}

class _PlacementOfficerHomeScreenState
    extends State<PlacementOfficerHomeScreen> {
  String _syncedTime = "10:13:48 AM";
  bool _isSyncing = false;
  int _selectedCommandTab = 1; // 0: Readiness Board, 1: Drives Schedule, 2: Analytics

  void _handleSyncLive() {
    setState(() => _isSyncing = true);
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _syncedTime = "$hour:$minute:$second $ampm";
          _isSyncing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: Color(0xFF10B981), size: 18),
                const SizedBox(width: 8),
                Text(
                  "Placement operations live synced successfully.",
                  style: GoogleFonts.poppins(fontSize: 12.5),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF0F172A),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

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
            20,
            isDesktop ? 28 : (isTablet ? 20 : 16),
            140,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Section (Matching Image 1)
              _buildHeader(isDesktop, isTablet, constraints.maxWidth),
              const SizedBox(height: 18),

              // 2. Command Center Banner (Training & Placement Operations)
              _buildCommandCenterBanner(isDesktop, isTablet),
              const SizedBox(height: 18),

              // 3. 6 Top Metric KPI Cards (Matching Image 1)
              _buildTopKpiRow(isDesktop, isTablet, constraints.maxWidth),
              const SizedBox(height: 20),

              // 4. Middle Section: Offers by company, Readiness by dept, Needs your attention
              _buildMiddleSection(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 5. Funnel & Score Distribution Section (Matching Image 2)
              _buildFunnelAndDistributionSection(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 6. AI Insights Card (Matching Image 2)
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
    final isMobile = maxWidth < 920;

    final double categorySize = isDesktop ? 11.0 : (isTablet ? 10.5 : 10.0);
    final double titleSize = maxWidth >= 1200
        ? 23.0
        : (maxWidth >= 1040
            ? 21.0
            : (maxWidth >= 768
                ? 19.0
                : (maxWidth >= 480 ? 17.0 : 15.5)));
    final double subSize = isDesktop ? 13.0 : (isTablet ? 12.5 : 12.0);

    final actionButtons = Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Sync live button
        OutlinedButton.icon(
          onPressed: _isSyncing ? null : _handleSyncLive,
          icon: _isSyncing
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Color(0xFF242C78)),
                )
              : const Icon(Icons.sync_rounded, size: 15, color: Color(0xFF242C78)),
          label: Text(
            "Sync live",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF242C78),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        // Campus Drives solid button
        ElevatedButton.icon(
          onPressed: () => widget.onOpenSubScreen(
            const PlacementDrivesScreen(),
            title: "Placement Drives",
          ),
          icon: const Icon(Icons.business_center_rounded, size: 15),
          label: Text(
            "Campus Drives",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF242C78),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),

        // Placement Board outline pill
        OutlinedButton(
          onPressed: () => widget.onOpenSubScreen(
            const PlacementReadinessBoardScreen(),
            title: "Placement Readiness Board",
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            "Placement Board",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ),

        // Job Matching button
        OutlinedButton.icon(
          onPressed: () => widget.onOpenSubScreen(
            const PlacementJobMatchingScreen(),
            title: "Job Matching",
          ),
          icon: const Icon(Icons.handshake_outlined,
              size: 15, color: Color(0xFF242C78)),
          label: Text(
            "Job Matching",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF242C78),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow with LIVE & SYNC status
        Row(
          children: [
            Text(
              "PLACEMENT OFFICER",
              style: GoogleFonts.poppins(
                fontSize: categorySize,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF16A34A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "LIVE",
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF166534),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "• SYNCED $_syncedTime",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Title Row with Action Buttons
        if (isMobile) ...[
          Text(
            "Good morning, Mr. R. Karthikeyan · Training & Placement Office · Anna Institute of Technology",
            style: GoogleFonts.poppins(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.4,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Drives, eligibility, job matching and placement analytics.",
            style: GoogleFonts.poppins(
              fontSize: subSize,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          actionButtons,
        ] else ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good morning, Mr. R. Karthikeyan · Training & Placement Office · Anna Institute of Technology",
                      style: GoogleFonts.poppins(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.4,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 5),
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
                ),
              ),
              const SizedBox(width: 16),
              actionButtons,
            ],
          ),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. PLACEMENT COMMAND CENTER BANNER (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildCommandCenterBanner(bool isDesktop, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 990;

          final infoPart = Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2865),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.business_center_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "PLACEMENT COMMAND CENTER • Live Campus Recruitment",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Training & Placement Operations",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final tabButtons = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCommandTabButton(
                  title: "Readiness Board",
                  icon: Icons.people_outline_rounded,
                  isSelected: _selectedCommandTab == 0,
                  onTap: () {
                    setState(() => _selectedCommandTab = 0);
                    widget.onOpenSubScreen(
                      const PlacementReadinessBoardScreen(),
                      title: "Placement Readiness Board",
                    );
                  },
                ),
                const SizedBox(width: 8),
                _buildCommandTabButton(
                  title: "Drives Schedule",
                  icon: Icons.calendar_month_rounded,
                  isSelected: _selectedCommandTab == 1,
                  onTap: () {
                    setState(() => _selectedCommandTab = 1);
                    widget.onOpenSubScreen(
                      const PlacementDrivesScreen(),
                      title: "Placement Drives",
                    );
                  },
                ),
                const SizedBox(width: 8),
                _buildCommandTabButton(
                  title: "Analytics",
                  icon: Icons.analytics_outlined,
                  isSelected: _selectedCommandTab == 2,
                  onTap: () {
                    setState(() => _selectedCommandTab = 2);
                    widget.onOpenSubScreen(
                      const PlacementAnalyticsScreen(),
                      title: "Placement Analytics",
                    );
                  },
                ),
              ],
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoPart,
                const SizedBox(height: 12),
                tabButtons,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: infoPart),
              const SizedBox(width: 14),
              tabButtons,
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommandTabButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E2865) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFCBD5E1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. TOP 6 METRIC CARDS (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildTopKpiRow(bool isDesktop, bool isTablet, double maxWidth) {
    final card1 = _buildTopMetricCard(
      title: "Offers Secured",
      value: "46",
      badgeText: "~ 2 drives completed · 437 applications",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFFD97706),
      icon: Icons.business_center_outlined,
      iconColor: const Color(0xFFD97706),
      iconBgColor: const Color(0xFFFEF3C7),
      onTap: () => widget.onOpenSubScreen(
        const PlacementDrivesScreen(),
        title: "Placement Drives",
      ),
    );

    final card2 = _buildTopMetricCard(
      title: "Placement Ready",
      value: "0",
      badgeText: "~ of 6 eligible (0%)",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF1E2865),
      icon: Icons.school_outlined,
      iconColor: const Color(0xFF1E2865),
      iconBgColor: const Color(0xFFEEF2FF),
      onTap: () => widget.onOpenSubScreen(
        const PlacementReadinessBoardScreen(),
        title: "Placement Readiness Board",
      ),
    );

    final card3 = _buildTopMetricCard(
      title: "Average Package",
      value: "₹8 LPA",
      badgeText: "~ Highest ₹9.5 LPA",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF0D9488),
      icon: Icons.receipt_long_outlined,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      onTap: () => widget.onOpenSubScreen(
        const PlacementAnalyticsScreen(),
        title: "Placement Analytics",
      ),
    );

    final card4 = _buildTopMetricCard(
      title: "Active Campus Drives",
      value: "0",
      badgeText: "~ 3 open for registration",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF2563EB),
      icon: Icons.domain_outlined,
      iconColor: const Color(0xFF2563EB),
      iconBgColor: const Color(0xFFEFF6FF),
      onTap: () => widget.onOpenSubScreen(
        const PlacementDrivesScreen(),
        title: "Placement Drives",
      ),
    );

    final card5 = _buildTopMetricCard(
      title: "Resume ATS Ready (70+)",
      value: "17%",
      badgeText: "~ 1 verified resumes",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF7C3AED),
      icon: Icons.trending_up_rounded,
      iconColor: const Color(0xFF7C3AED),
      iconBgColor: const Color(0xFFF3E8FF),
      onTap: () => widget.onOpenSubScreen(
        const PlacementReadinessBoardScreen(),
        title: "Placement Readiness Board",
      ),
    );

    final card6 = _buildTopMetricCard(
      title: "Mock Interview Average",
      value: "17 / 100",
      badgeText: "~ 17% student participation",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF0D9488),
      icon: Icons.record_voice_over_outlined,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      onTap: () => widget.onOpenSubScreen(
        const PlacementReadinessBoardScreen(),
        title: "Placement Readiness Board",
      ),
    );

    if (maxWidth >= 1200) {
      return Row(
        children: [
          Expanded(child: card1),
          const SizedBox(width: 12),
          Expanded(child: card2),
          const SizedBox(width: 12),
          Expanded(child: card3),
          const SizedBox(width: 12),
          Expanded(child: card4),
          const SizedBox(width: 12),
          Expanded(child: card5),
          const SizedBox(width: 12),
          Expanded(child: card6),
        ],
      );
    } else if (maxWidth >= 768) {
      return Column(
        children: [
          Row(children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
            const SizedBox(width: 12),
            Expanded(child: card3),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: card4),
            const SizedBox(width: 12),
            Expanded(child: card5),
            const SizedBox(width: 12),
            Expanded(child: card6),
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
          const SizedBox(height: 10),
          card5,
          const SizedBox(height: 10),
          card6,
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
          padding: const EdgeInsets.all(15),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top line accent
              Container(
                height: 3,
                width: 36,
                decoration: BoxDecoration(
                  color: topAccentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 10),

              // Title + Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 15),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Big Value
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),

              // Sub-badge
              if (badgeText != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeBgColor ?? const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badgeText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: badgeColor ?? const Color(0xFF0D9488),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. MIDDLE SECTION (Offers by company, Readiness by dept, Needs attention)
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
            height: 170,
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
          width: 32,
          height: 140 * heightFactor,
          decoration: const BoxDecoration(
            color: Color(0xFF1E2865),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 95,
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

  // Card 2: Readiness and mock interview by department (Matching Image 1)
  Widget _buildReadinessByDepartmentCard() {
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
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels (24, 18, 12, 6, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("24",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("18",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("12",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("6",
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
                        children: [
                          // Computer Science & Eng.
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Navy Readiness bar (22/24)
                                  Container(
                                    width: 14,
                                    height: 140 * (22 / 24.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF1E2865),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // Amber Interview bar (3/24)
                                  Container(
                                    width: 14,
                                    height: 140 * (3 / 24.0),
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
                                width: 110,
                                child: Text(
                                  "Computer Science & Eng.",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Information Tech.
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 14,
                                    height: 2,
                                    color: const Color(0xFF1E2865),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 14,
                                    height: 2,
                                    color: const Color(0xFFD97706),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 95,
                                child: Text(
                                  "Information Tech.",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Legend (Readiness & Interview)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2865),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "Readiness",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
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
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card 3: Needs your attention (5 students need readiness intervention)
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
          const SizedBox(height: 18),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => widget.onOpenSubScreen(
                const PlacementReadinessBoardScreen(),
                title: "Placement Readiness Board",
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(8),
                  border: const Border(
                    left: BorderSide(color: Color(0xFFDC2626), width: 3.5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "5 students need readiness intervention",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Targeted support on technical mock or resume ATS score",
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
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. FUNNEL & SCORE DISTRIBUTION SECTION (Image 2)
  // ---------------------------------------------------------------------------
  Widget _buildFunnelAndDistributionSection(bool isDesktop, bool isTablet) {
    final funnelCard = _buildCampusHiringFunnelCard();
    final distributionCard = _buildReadinessScoreDistributionCard();

    if (isDesktop || isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: funnelCard),
          const SizedBox(width: 14),
          Expanded(child: distributionCard),
        ],
      );
    }

    return Column(
      children: [
        funnelCard,
        const SizedBox(height: 14),
        distributionCard,
      ],
    );
  }

  // Chart 3: Campus hiring funnel (Image 2)
  Widget _buildCampusHiringFunnelCard() {
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
            "Campus hiring funnel",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels (600, 450, 300, 150, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("600",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("450",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("300",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("150",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                // Stack with grid lines and bars
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
                          _buildFunnelBar(
                            label: "Eligible batch",
                            value: 12,
                            maxValue: 600,
                          ),
                          _buildFunnelBar(
                            label: "Registered in drives",
                            value: 437,
                            maxValue: 600,
                          ),
                          _buildFunnelBar(
                            label: "Offers extended",
                            value: 46,
                            maxValue: 600,
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

  Widget _buildFunnelBar({
    required String label,
    required double value,
    required double maxValue,
  }) {
    final height = (value / maxValue) * 140;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 26,
          height: height.clamp(4.0, 140.0),
          decoration: const BoxDecoration(
            color: Color(0xFF1E2865),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 85,
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

  // Chart 4: Readiness score distribution (Image 2)
  Widget _buildReadinessScoreDistributionCard() {
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
            "Readiness score distribution",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels (4, 3, 2, 1, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("4",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("3",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("2",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("1",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                // Stack with grid lines and bars
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
                          _buildDistributionBar("0-39", 4),
                          _buildDistributionBar("40-54", 1),
                          _buildDistributionBar("55-69", 1),
                          _buildDistributionBar("70-84", 0),
                          _buildDistributionBar("85-100", 0),
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

  Widget _buildDistributionBar(String range, int count) {
    final height = (count / 4.0) * 140;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: height > 0 ? height : 2,
          decoration: BoxDecoration(
            color: count > 0 ? const Color(0xFF1E2865) : Colors.transparent,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          range,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 6. BOTTOM SECTION: AI INSIGHTS CARD (Image 2)
  // ---------------------------------------------------------------------------
  Widget _buildAiInsightsCard() {
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
          // Header Row
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

          // Insight 1 (Matching Image 2)
          _buildInsightBullet(
            bulletColor: const Color(0xFFD97706), // Orange
            title: "Mock interview is the weakest readiness area",
            subtitle:
                "Students average 3% in mock interview, against 29% in quiz average. Targeted practice here lifts the most students toward placement ready.",
            evidence: "Evidence: 6 students on the readiness board",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
          ),

          // Insight 2 (Matching Image 2)
          _buildInsightBullet(
            bulletColor: const Color(0xFF0D9488), // Teal/Green
            title: "1 student is close to placement ready",
            subtitle:
                "The most common gap among them is mock interview (1 student). A short push there moves them onto the shortlist.",
            evidence: "Evidence: Almost ready = total 55–69 or one criterion missing",
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // Bottom footer note
          Text(
            "Insights support — not replace — human decisions.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF94A3B8),
            ),
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                evidence,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
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
