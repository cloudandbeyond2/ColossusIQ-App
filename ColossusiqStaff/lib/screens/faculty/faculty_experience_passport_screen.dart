import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// CAMPUS LIFE: EXPERIENCE PASSPORT SCREEN
// Exactly matches screenshot 3:
// - Blueprint grid hero banner with watermark & badges (CAMPUS LIFE, Phase 3)
// - 4 Metric cards row: Activities in college (0), Verified (0), Waiting for you (0), Sent back (0)
// - Main Card with:
//     * Filter tab pills: "To verify - 0" (active navy), "Verified History - 0", "Sent back - 0", "All Activities - 0"
//     * Search input ("Search student, roll number, activity, club...") + Category dropdown ("All Categories")
//     * Blueprint graph paper empty state ("Nothing to verify / When students submit co-curricular activities, they will appear here for verification.")
// =============================================================================

class FacultyExperiencePassportScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyExperiencePassportScreen({super.key, this.onBack});

  @override
  State<FacultyExperiencePassportScreen> createState() =>
      _FacultyExperiencePassportScreenState();
}

class _FacultyExperiencePassportScreenState
    extends State<FacultyExperiencePassportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "To verify";
  String _selectedCategory = "All Categories";

  final List<String> _categories = [
    "All Categories",
    "Hackathon",
    "Volunteering",
    "Leadership",
    "Sports",
    "NSS / NCC",
    "Cultural",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 800;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 4 Metric Cards Row
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            title: "Activities in college",
                            value: "0",
                            icon: Icons.bookmark_border_rounded,
                            iconColor: const Color(0xFF2563EB),
                            iconBg: const Color(0xFFEFF6FF),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricCard(
                            title: "Verified",
                            value: "0",
                            icon: Icons.verified_user_outlined,
                            iconColor: const Color(0xFF0F766E),
                            iconBg: const Color(0xFFCCFBF1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            title: "Waiting for you",
                            value: "0",
                            icon: Icons.access_time_rounded,
                            iconColor: const Color(0xFFD97706),
                            iconBg: const Color(0xFFFEF3C7),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricCard(
                            title: "Sent back",
                            value: "0",
                            icon: Icons.replay_rounded,
                            iconColor: const Color(0xFFDC2626),
                            iconBg: const Color(0xFFFEE2E2),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: "Activities in college",
                        value: "0",
                        icon: Icons.bookmark_border_rounded,
                        iconColor: const Color(0xFF2563EB),
                        iconBg: const Color(0xFFEFF6FF),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Verified",
                        value: "0",
                        icon: Icons.verified_user_outlined,
                        iconColor: const Color(0xFF0F766E),
                        iconBg: const Color(0xFFCCFBF1),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Waiting for you",
                        value: "0",
                        icon: Icons.access_time_rounded,
                        iconColor: const Color(0xFFD97706),
                        iconBg: const Color(0xFFFEF3C7),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        title: "Sent back",
                        value: "0",
                        icon: Icons.replay_rounded,
                        iconColor: const Color(0xFFDC2626),
                        iconBg: const Color(0xFFFEE2E2),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // 3. Main Verification Desk Card
              _buildVerificationCard(),
            ],
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
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.star_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (clean, no leading arrow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Campus Life",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Experience Passport",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "CAMPUS LIFE",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "Phase 3",
                        const Color(0xFFD97706),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Experience Passport",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Record volunteering, leadership, competitions and more; faculty verify each entry.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. 4 METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN VERIFICATION DESK CARD
  // ===========================================================================
  Widget _buildVerificationCard() {
    final tabs = [
      {"label": "To verify", "count": "0"},
      {"label": "Verified History", "count": "0"},
      {"label": "Sent back", "count": "0"},
      {"label": "All Activities", "count": "0"},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Tabs & Search & Category Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 900;

              final tabsWidget = SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tabs.map((t) {
                    final isSelected = _selectedTab == t["label"];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTab = t["label"]!;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1E2865)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${t['label']} - ${t['count']}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );

              final searchWidget = Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: InputDecoration(
                          hintText:
                              "Search student, roll number, activity, club...",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            size: 16,
                            color: Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_list_rounded,
                            size: 16, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF0F172A),
                            ),
                            items: _categories.map((c) {
                              return DropdownMenuItem(value: c, child: Text(c));
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedCategory = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tabsWidget,
                    const SizedBox(height: 12),
                    searchWidget,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(flex: 5, child: tabsWidget),
                  const SizedBox(width: 16),
                  Expanded(flex: 6, child: searchWidget),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Blueprint Graph Paper Empty State Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 54, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPaperPainter(
                        gridColor:
                            const Color(0xFF6366F1).withValues(alpha: 0.07),
                        step: 22.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nothing to verify",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "When students submit co-curricular activities, they will appear\nhere for verification.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
