import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAgentStoreScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalAgentStoreScreen({super.key, this.onBack});

  @override
  State<PrincipalAgentStoreScreen> createState() => _PrincipalAgentStoreScreenState();
}

class _PrincipalAgentStoreScreenState extends State<PrincipalAgentStoreScreen> {
  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _agents = [
    // --- Student (17) ---
    {
      "name": "AI Mentor",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Master student assistant: answers questions, coordinates other agents and recommends the next best action. Used in AI Mentor.",
    },
    {
      "name": "Academic Tutor",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Explains topics with examples, simplification, questions and practice.",
    },
    {
      "name": "Study Planner",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Daily, weekly and semester plans with revision scheduling and exam countdowns. Used in AI Study Planner.",
    },
    {
      "name": "Revision Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Decides what, when and how deeply to revise from your performance.",
    },
    {
      "name": "Exam Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Mock tests, question generation and adaptive difficulty. Used in Question Paper Generator.",
    },
    {
      "name": "Viva Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Project, subject and technical viva with follow-up questions. Used in Viva Simulator.",
    },
    {
      "name": "Career Coach",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Maps goal → target role → required vs current skills → gap → learning plan. Used in Job Preparation.",
    },
    {
      "name": "Resume Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Generation, rewriting, skill extraction and ATS-oriented scoring.",
    },
    {
      "name": "Interview Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Dynamic conversational interview that adapts to candidate responses.",
    },
    {
      "name": "GD Agent",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Simulated multi-person group discussions and communication analysis.",
    },
    {
      "name": "Coding Sandbox Tutor",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Interactive code debugger, execution time optimizer and algorithm coach.",
    },
    {
      "name": "GATE Exam Coach",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Full syllabus engineering aptitude, branch core concepts and timed mock series.",
    },
    {
      "name": "NEET / JEE Prep Assistant",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Physics, chemistry, math and biology problem breakdown with speed shortcuts.",
    },
    {
      "name": "Aptitude & Reasoning Coach",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Quantitative aptitude, logical deductions, and data interpretation practice.",
    },
    {
      "name": "Lab Practicals Bot",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Step-by-step virtual experiment guide, observations calculation and viva prep.",
    },
    {
      "name": "Soft Skills Mentor",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Body language tips, presentation skills, voice modulation and workplace etiquette.",
    },
    {
      "name": "Capstone Project Assistant",
      "department": "Student",
      "status": "Live • Google Gemini",
      "desc": "Literature review compilation, architecture design, and IEEE paper drafting.",
    },

    // --- Faculty (4) ---
    {
      "name": "Answer Evaluation",
      "department": "Faculty",
      "status": "Live • Google Gemini",
      "desc": "Evaluates short, long, case-study and descriptive answers against rubrics.",
    },
    {
      "name": "Handwritten Evaluation",
      "department": "Faculty",
      "status": "Live • Google Gemini",
      "desc": "Enhancement → OCR → segmentation → semantic and rubric scoring → feedback.",
    },
    {
      "name": "Question Paper Generator",
      "department": "Faculty",
      "status": "Live • Google Gemini",
      "desc": "Bloom's taxonomy balanced test builder with marking scheme and answer key.",
    },
    {
      "name": "Curriculum Syllabus Synthesizer",
      "department": "Faculty",
      "status": "Live • Google Gemini",
      "desc": "OBE attainment mapping, CO-PO matrix alignment, and credit load balancer.",
    },

    // --- Institution (6) ---
    {
      "name": "NAAC / NBA SSR Synthesizer",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Self Study Report metric synthesizer with documentary evidence linking.",
    },
    {
      "name": "NIRF Ranking Analytics",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Research citation indices, graduation outcomes, and peer perception analytics.",
    },
    {
      "name": "AICTE Compliance Auditor",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Faculty-student ratios, laboratory square-footage, and mandatory disclosure compiler.",
    },
    {
      "name": "Placement Predictor & BI",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Batch-wide placement readiness scoring and corporate recruiting heatmaps.",
    },
    {
      "name": "Student Early Warning Bot",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Detects drop-out risk, chronic absenteeism, and fee default triggers early.",
    },
    {
      "name": "Campus Event Publicist",
      "department": "Institution",
      "status": "Live • Google Gemini",
      "desc": "Generates brochures, press releases, social promos, and schedules.",
    },

    // --- Platform (3) ---
    {
      "name": "Multilingual Speech Agent",
      "department": "Platform",
      "status": "Live • Google Gemini",
      "desc": "Real-time speech-to-text and voice translation for regional lecture broadcasts.",
    },
    {
      "name": "Anti-Tamper Document Notary",
      "department": "Platform",
      "status": "Live • Google Gemini",
      "desc": "Cryptographic SHA-256 verification and QR digital seal generator for certificates.",
    },
    {
      "name": "Campus Knowledge Retrieval",
      "department": "Platform",
      "status": "Live • Google Gemini",
      "desc": "Vector search over institutional handbooks, circulars, syllabi, and codes.",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter agents
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _agents.where((agent) {
      final matchesDept = _selectedFilter == "All" || agent["department"] == _selectedFilter;
      final matchesSearch = query.isEmpty ||
          (agent["name"] as String).toLowerCase().contains(query) ||
          (agent["desc"] as String).toLowerCase().contains(query);
      return matchesDept && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Image 5)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 3. Department Filters & Search Row (Matches Image 5)
              _buildFiltersAndSearchRow(),
              const SizedBox(height: 20),

              // 4. Agent Cards Grid (Matches Image 5)
              LayoutBuilder(
                builder: (context, constraints) {
                  final colCount = constraints.maxWidth >= 1050
                      ? 3
                      : constraints.maxWidth >= 680
                          ? 2
                          : 1;

                  if (filtered.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 40, color: Color(0xFF94A3B8)),
                          const SizedBox(height: 12),
                          Text(
                            "No agents found",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "Try adjusting your department filter or search keywords",
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: colCount == 1 ? 2.4 : 1.75,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildAgentCard(filtered[index]);
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BREADCRUMBS
  // ===========================================================================
  Widget _buildBreadcrumbs() {
    return Row(
      children: [
        if (widget.onBack != null) ...[
          InkWell(
            onTap: widget.onBack,
            borderRadius: BorderRadius.circular(6),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF64748B)),
            ),
          ),
          const SizedBox(width: 6),
        ],
        Text(
          "Home",
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
        ),
        Text(
          "Platform",
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
        ),
        Text(
          "Agent Store",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. BLUEPRINT HERO BANNER (Matches Image 5)
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1E5C), Color(0xFF1E3A8A), Color(0xFF2E3D85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1E5C).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Blueprint grid overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Background watermark microchip
            Positioned(
              right: -10,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.memory_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Microchip Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.memory_rounded,
                    color: Color(0xFFFBBF24),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),

                // Title, Badges & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "PLATFORM",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD97706),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Phase 4",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Agent Store",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Enable domain agents per institution — GATE, NEET, coding, accounting, law and more.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFFE2E8F0),
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
    );
  }

  // ===========================================================================
  // 3. DEPARTMENT FILTERS & SEARCH ROW (Matches Image 5)
  // ===========================================================================
  Widget _buildFiltersAndSearchRow() {
    final filters = [
      {"label": "All", "count": "30"},
      {"label": "Student", "count": "17"},
      {"label": "Faculty", "count": "4"},
      {"label": "Institution", "count": "6"},
      {"label": "Platform", "count": "3"},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 760;

          final filterPills = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 8),
                Text(
                  "Department:",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
                const SizedBox(width: 10),
                ...filters.map((f) {
                  final label = f["label"]!;
                  final count = f["count"]!;
                  final isSelected = _selectedFilter == label;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFilter = label),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF131B4D) : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF131B4D) : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? Colors.white : const Color(0xFF334155),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              count,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.white70 : const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );

          final searchBox = Container(
            width: isDesktop ? 260 : double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: "Search labs & practicals...",
                hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 14, color: Color(0xFF94A3B8)),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          );

          if (isDesktop) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: filterPills),
                const SizedBox(width: 14),
                searchBox,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filterPills,
              const SizedBox(height: 12),
              searchBox,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 4. AGENT CARD (Matches Image 5 Cards)
  // ===========================================================================
  Widget _buildAgentCard(Map<String, dynamic> agent) {
    final dept = agent["department"] as String;

    Color deptBg;
    Color deptText;
    if (dept == "Student") {
      deptBg = const Color(0xFFEEF2FF);
      deptText = const Color(0xFF4F46E5);
    } else if (dept == "Faculty") {
      deptBg = const Color(0xFFECFDF5);
      deptText = const Color(0xFF059669);
    } else if (dept == "Institution") {
      deptBg = const Color(0xFFFFFBEB);
      deptText = const Color(0xFFD97706);
    } else {
      deptBg = const Color(0xFFEFF6FF);
      deptText = const Color(0xFF2563EB);
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Department pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: deptBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  dept,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: deptText,
                  ),
                ),
              ),

              // Live Google Gemini pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF059669),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      agent["status"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF047857),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Name
          Text(
            agent["name"] as String,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),

          // Description
          Expanded(
            child: Text(
              agent["desc"] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
                height: 1.45,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAINTER (Matches Blueprint background in Images 3, 4, 5)
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

typedef AgentStoreScreen = PrincipalAgentStoreScreen;
