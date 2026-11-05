import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalReportsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalReportsScreen({super.key, this.onBack});

  @override
  State<PrincipalReportsScreen> createState() => _PrincipalReportsScreenState();
}

class _PrincipalReportsScreenState extends State<PrincipalReportsScreen> {
  String _selectedType = "All";
  String _selectedScope = "All Scopes";
  String _selectedPeriod = "All Periods";
  int _selectedTab = 0; // 0: Generated Reports, 1: Automated Schedules

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. 4 METRIC KPI CARDS
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 3. MAIN REPORTS CARD
                _buildMainReportsCard(constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 18,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.assignment_outlined,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null) ...[
                          InkWell(
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Institution",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Reports",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Header Row with Icon, Badges, Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26336A).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.assignment_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber gold icon
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B)
                                        .withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Reports",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Student, faculty, department, course, skill, placement and institutional reports.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. 4 METRIC KPI CARDS
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    int crossAxisCount = 4;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 1050) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Card 1: REPORTS READY
        _buildSingleKpiCard(
          width: cardWidth,
          title: "REPORTS READY",
          icon: Icons.description_outlined,
          iconColor: const Color(0xFF475569),
          primaryValue: "0",
          tagWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "INSTITUTION",
              style: GoogleFonts.poppins(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4338CA),
              ),
            ),
          ),
          extraText: "All certified",
          extraTextColor: const Color(0xFF16A34A),
          bottomSubtitle: "PDF, Excel & CSV available",
        ),

        // Card 2: SCHEDULED AUTO-RUNS
        _buildSingleKpiCard(
          width: cardWidth,
          title: "SCHEDULED AUTO-RUNS",
          icon: Icons.access_time_rounded,
          iconColor: const Color(0xFF2563EB),
          primaryValue: "0",
          extraText: "active crons",
          extraTextColor: const Color(0xFF64748B),
          bottomSubtitle: "Next run: Monday 08:00 AM",
        ),

        // Card 3: DATA EXPORT VOLUME
        _buildSingleKpiCard(
          width: cardWidth,
          title: "DATA EXPORT VOLUME",
          icon: Icons.download_rounded,
          iconColor: const Color(0xFFD97706),
          primaryValue: "48.2 MB",
          extraText: "this term",
          extraTextColor: const Color(0xFF64748B),
          bottomSubtitle: "Institutional data warehouse",
        ),

        // Card 4: ACCREDITATION READY
        _buildSingleKpiCard(
          width: cardWidth,
          title: "ACCREDITATION READY",
          icon: Icons.verified_outlined,
          iconColor: const Color(0xFF0D9488),
          primaryValue: "100%",
          extraText: "compliant",
          extraTextColor: const Color(0xFF0D9488),
          bottomSubtitle: "NAAC & NBA formats supported",
        ),
      ],
    );
  }

  Widget _buildSingleKpiCard({
    required double width,
    required String title,
    required IconData icon,
    required Color iconColor,
    required String primaryValue,
    Widget? tagWidget,
    String? extraText,
    Color? extraTextColor,
    required String bottomSubtitle,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: const Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: iconColor),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                primaryValue,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              ?tagWidget,
              if (extraText != null)
                Text(
                  extraText,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: extraTextColor ?? const Color(0xFF64748B),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            bottomSubtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN REPORTS CARD (Search, Filters, Tabs & Content Area)
  // ===========================================================================
  Widget _buildMainReportsCard(double maxWidth) {
    final typeFilters = [
      "All",
      "Academic",
      "Department",
      "Placement",
      "Faculty",
      "Compliance",
      "Institution",
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Search & + Generate report button
          Padding(
            padding: const EdgeInsets.all(18),
            child: LayoutBuilder(
              builder: (context, rowConstraints) {
                final isCompact = rowConstraints.maxWidth < 620;

                final searchField = Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText:
                          "Search reports by title, scope or keyword...",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        size: 18,
                        color: Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                );

                final genButton = ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Opening Report Generator Wizard..."),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: Text(
                    "Generate report",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1B4B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchField,
                      const SizedBox(height: 12),
                      genButton,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 14),
                    genButton,
                  ],
                );
              },
            ),
          ),

          // Row 2: Filter Pills & Dropdowns
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      "TYPE:",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                ...typeFilters.map((t) {
                  final isSelected = _selectedType == t;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedType = t);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  );
                }),
                // All Scopes Dropdown
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedScope,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 16, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E293B),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "All Scopes", child: Text("All Scopes")),
                        DropdownMenuItem(
                            value: "Department Scope",
                            child: Text("Department Scope")),
                        DropdownMenuItem(
                            value: "Institutional Scope",
                            child: Text("Institutional Scope")),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedScope = val);
                      },
                    ),
                  ),
                ),
                // All Periods Dropdown
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPeriod,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 16, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E293B),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "All Periods", child: Text("All Periods")),
                        DropdownMenuItem(
                            value: "Current Term", child: Text("Current Term")),
                        DropdownMenuItem(
                            value: "Academic Year 2026",
                            child: Text("Academic Year 2026")),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedPeriod = val);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _buildReportTab(0, Icons.description_outlined,
                    "Generated Reports (0)"),
                const SizedBox(width: 20),
                _buildReportTab(1, Icons.schedule_rounded,
                    "Automated Schedules (0)"),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Content Box with Subtle Grid Pattern
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _LightGridPainter(),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No reports match your filters",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Generate a report using the button above.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Opening Report Generator Wizard..."),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_rounded, size: 16),
                            label: Text(
                              "Generate report",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E1B4B),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildReportTab(int index, IconData icon, String title) {
    final isSelected = _selectedTab == index;

    return InkWell(
      onTap: () {
        setState(() => _selectedTab = index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? const Color(0xFF1E1B4B)
                  : Colors.transparent,
              width: 2.2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 16,
                color: isSelected
                    ? const Color(0xFF1E1B4B)
                    : const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF1E1B4B)
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// LIGHT GRAPH GRID PAINTER (For Empty State Box)
// =============================================================================
class _LightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6)
      ..strokeWidth = 1.0;

    const spacing = 22.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
