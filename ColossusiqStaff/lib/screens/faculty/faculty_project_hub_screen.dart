import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PROJECT & INNOVATION: PROJECT HUB SCREEN
// Exactly matches screenshot 5:
// - Blueprint grid hero banner with watermark & badges (PROJECT & INNOVATION, MVP)
// - Desk Pill: "Faculty Mentorship & Milestone Evaluation Desk" + Search bar
// - Project Cards:
//     1. "Smart Campus AI" (AI/ML · IoT · Mentor: Dr. Meena Raghavan)
//        - Team members & "+ Find Teammates"
//        - "80% completed" Project Lifecycle multi-stage stepper (Idea, Team, Architecture, Milestones, Implementation, Testing, AI Review, Faculty Review, Demo, Portfolio)
//        - "AI Project Review Board" nested card with 5 score breakdown bars (Architecture 82, Documentation 64, Code Quality 76, Testing 58, Innovation 88)
//     2. "AgriSoil Sense — low-cost soil health kit" (AgriTech · Embedded · Mentor: Prof. R. Balaji)
//        - Team members, "30% completed" Project Lifecycle stepper
// =============================================================================

class FacultyProjectHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyProjectHubScreen({super.key, this.onBack});

  @override
  State<FacultyProjectHubScreen> createState() =>
      _FacultyProjectHubScreenState();
}

class _FacultyProjectHubScreenState extends State<FacultyProjectHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showReviewDialog(String projectTitle, String currentMilestone) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.rate_review_rounded,
                    color: Color(0xFFD97706), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Faculty Milestone Review",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectTitle,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A)),
              ),
              const SizedBox(height: 4),
              Text(
                "Current Stage: $currentMilestone",
                style: GoogleFonts.poppins(
                    fontSize: 12.5, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: InputDecoration(
                  hintText: "Enter faculty mentorship remarks & milestone approval notes...",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 12, color: const Color(0xFF94A3B8)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel",
                  style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Milestone approved and signed off for $projectTitle!",
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: const Color(0xFF059669),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD97706),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Approve Milestone",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Hero Blueprint Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Desk Pill + Search Bar Row
          _buildDeskAndSearchRow(),
          const SizedBox(height: 18),

          // 3. Project Cards List
          _buildSmartCampusCard(),
          const SizedBox(height: 18),

          _buildAgriSoilSenseCard(),
        ],
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
                  Icons.lightbulb_outline_rounded,
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
                          "Project & Innovation",
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
                          "Project Hub",
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
                        "PROJECT & INNOVATION",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "MVP",
                        const Color(0xFF0F766E),
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
                          Icons.lightbulb_rounded,
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
                              "Project Hub",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Idea → team → architecture → milestones → AI review → faculty review → demo → portfolio.",
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
  // 2. DESK PILL + SEARCH BAR ROW
  // ===========================================================================
  Widget _buildDeskAndSearchRow() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 14,
      runSpacing: 10,
      children: [
        _buildDeskPill(),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320, minWidth: 200),
          child: _buildSearchInput(),
        ),
      ],
    );
  }

  Widget _buildDeskPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_outlined,
            size: 16,
            color: Color(0xFF0F766E),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              "Faculty Mentorship & Milestone Evaluation Desk",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val.trim().toLowerCase();
          });
        },
        style: GoogleFonts.poppins(fontSize: 12.5),
        decoration: InputDecoration(
          hintText: "Search projects, domains, mentors...",
          hintStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 18,
            color: Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 9),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. PROJECT CARD 1: SMART CAMPUS AI
  // ===========================================================================
  Widget _buildSmartCampusCard() {
    if (_searchQuery.isNotEmpty &&
        !"smart campus ai".contains(_searchQuery) &&
        !"meena raghavan".contains(_searchQuery) &&
        !"iot".contains(_searchQuery)) {
      return const SizedBox.shrink();
    }

    final stages = [
      {"name": "Idea", "done": true},
      {"name": "Team Formation", "done": true},
      {"name": "Architecture", "done": true},
      {"name": "Milestones", "done": true},
      {"name": "Implementation", "done": true},
      {"name": "Testing", "done": true},
      {"name": "AI Review", "done": false, "active": true},
      {"name": "Faculty Review", "done": false},
      {"name": "Demo", "done": false},
      {"name": "Portfolio", "done": false},
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
          // Header: Title & Actions (Responsive LayoutBuilder)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 580;
              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Smart Campus AI",
                    style: GoogleFonts.poppins(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "AI/ML · IoT · Mentor: Dr. Meena Raghavan",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final actionSection = Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "AI Review",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _showReviewDialog("Smart Campus AI", "AI Review"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD97706),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Review & Approve",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.push_pin_outlined,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 10),
                    actionSection,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: titleSection),
                  const SizedBox(width: 12),
                  actionSection,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Team Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.people_outline_rounded,
                  size: 16,
                  color: Color(0xFF0F766E),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Team: ",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    Text(
                      "Anand Kumar, Divya Raman, Karthik Iyer",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Opening teammate finder for Smart Campus AI...",
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Text(
                        "+ Find Teammates",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Project Lifecycle Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Project Lifecycle",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              Text(
                "80% completed",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lifecycle Horizontal Stepper
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(stages.length, (index) {
                final st = stages[index];
                final isDone = st["done"] == true;
                final isActive = st["active"] == true;
                return Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFF0F766E)
                              : (isActive
                                  ? const Color(0xFFD97706)
                                  : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isDone)
                            const Text(
                              "✓ ",
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                          Text(
                            st["name"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: (isDone || isActive)
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isDone
                                  ? const Color(0xFF0F766E)
                                  : (isActive
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 18),

          // Nested Card: AI Project Review Board
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      size: 15,
                      color: Color(0xFF1E2865),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "AI Project Review Board",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // 5 Score Breakdown Bars
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    _buildReviewScoreBar(
                        "Architecture", 82, const Color(0xFF0F766E)),
                    _buildReviewScoreBar(
                        "Documentation", 64, const Color(0xFF1E2865)),
                    _buildReviewScoreBar(
                        "Code Quality", 76, const Color(0xFF0F766E)),
                    _buildReviewScoreBar(
                        "Testing", 58, const Color(0xFF1E2865)),
                    _buildReviewScoreBar(
                        "Innovation", 88, const Color(0xFF0F766E)),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  "AI review is advisory; faculty review decides milestone approval and portfolio publication.",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewScoreBar(String label, int score, Color barColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF334155),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$score",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: 100,
          height: 4.5,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: score / 100.0,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. PROJECT CARD 2: AGRISOIL SENSE
  // ===========================================================================
  Widget _buildAgriSoilSenseCard() {
    if (_searchQuery.isNotEmpty &&
        !"agrisoil sense".contains(_searchQuery) &&
        !"r. balaji".contains(_searchQuery) &&
        !"agritech".contains(_searchQuery)) {
      return const SizedBox.shrink();
    }

    final stages = [
      {"name": "Idea", "done": true},
      {"name": "Team Formation", "done": true},
      {"name": "Architecture", "done": false, "active": true},
      {"name": "Milestones", "done": false},
      {"name": "Implementation", "done": false},
      {"name": "Testing", "done": false},
      {"name": "AI Review", "done": false},
      {"name": "Faculty Review", "done": false},
      {"name": "Demo", "done": false},
      {"name": "Portfolio", "done": false},
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
          // Header: Title & Actions (Responsive LayoutBuilder)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 580;
              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AgriSoil Sense — low-cost soil health kit",
                    style: GoogleFonts.poppins(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "AgriTech · Embedded · Mentor: Prof. R. Balaji",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final actionSection = Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Architecture",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showReviewDialog(
                        "AgriSoil Sense — low-cost soil health kit",
                        "Architecture"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD97706),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Review & Approve",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.push_pin_outlined,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 10),
                    actionSection,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: titleSection),
                  const SizedBox(width: 12),
                  actionSection,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Team Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.people_outline_rounded,
                  size: 16,
                  color: Color(0xFF0F766E),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Team: ",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    Text(
                      "Anand Kumar, Sanjay Rao",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Opening teammate finder for AgriSoil Sense...",
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Text(
                        "+ Find Teammates",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Project Lifecycle Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Project Lifecycle",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              Text(
                "30% completed",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lifecycle Horizontal Stepper
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(stages.length, (index) {
                final st = stages[index];
                final isDone = st["done"] == true;
                final isActive = st["active"] == true;
                return Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFF0F766E)
                              : (isActive
                                  ? const Color(0xFFD97706)
                                  : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isDone)
                            const Text(
                              "✓ ",
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                          Text(
                            st["name"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: (isDone || isActive)
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isDone
                                  ? const Color(0xFF0F766E)
                                  : (isActive
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
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
