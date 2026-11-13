import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// CURRICULUM PROGRAMME DATA MODEL
// =============================================================================
class CurriculumProgramme {
  final String id;
  final String title;
  final String regulation;
  final String version;
  final int semesters;
  final int courses;
  final String credits;
  final int syllabusWritten;
  final int totalSyllabus;
  final String updatedDate;
  final List<CourseDetail> sampleCourses;

  const CurriculumProgramme({
    required this.id,
    required this.title,
    required this.regulation,
    required this.version,
    required this.semesters,
    required this.courses,
    required this.credits,
    required this.syllabusWritten,
    required this.totalSyllabus,
    required this.updatedDate,
    required this.sampleCourses,
  });

  double get syllabusProgress =>
      totalSyllabus > 0 ? (syllabusWritten / totalSyllabus).clamp(0.0, 1.0) : 0.0;
}

class CourseDetail {
  final String code;
  final String name;
  final int semester;
  final int credits;
  final String ltp; // Lecture - Tutorial - Practical
  final String category; // Professional Core, Basic Science, etc.
  final List<String> units;
  final List<String> outcomes;

  const CourseDetail({
    required this.code,
    required this.name,
    required this.semester,
    required this.credits,
    required this.ltp,
    required this.category,
    required this.units,
    required this.outcomes,
  });
}

// =============================================================================
// CURRICULUM STUDIO SCREEN (FACULTY PORTAL - MATCHING EXACT DESIGN)
// =============================================================================
class CurriculumStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CurriculumStudioScreen({super.key, this.onBack});

  @override
  State<CurriculumStudioScreen> createState() => _CurriculumStudioScreenState();
}

class _CurriculumStudioScreenState extends State<CurriculumStudioScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String _selectedRegulation = "All Regulations";

  final List<CurriculumProgramme> _programmes = const [
    // 1. CSE
    CurriculumProgramme(
      id: "prog_cse",
      title: "B.E. Computer Science & Engineering",
      regulation: "Regulation R2026",
      version: "Published · v9",
      semesters: 8,
      courses: 8,
      credits: "23",
      syllabusWritten: 8,
      totalSyllabus: 8,
      updatedDate: "Updated 13 Oct 2026 by University Super Admin",
      sampleCourses: [
        CourseDetail(
          code: "CS3491",
          name: "Artificial Intelligence and Machine Learning",
          semester: 4,
          credits: 4,
          ltp: "3-0-2-4",
          category: "Professional Core",
          units: [
            "Unit I: Problem Solving & Search Algorithms",
            "Unit II: Knowledge Representation & Reasoning",
            "Unit III: Supervised Learning & Regression",
            "Unit IV: Neural Networks & Deep Learning",
            "Unit V: Ethics & Governance in AI Systems",
          ],
          outcomes: [
            "CO1: Formulate search heuristics for complex constraint satisfaction problems.",
            "CO2: Apply probabilistic models and inference in uncertain domains.",
            "CO3: Construct supervised models using real-world tabular data.",
            "CO4: Deploy neural classifiers with PyTorch/TensorFlow runtimes.",
          ],
        ),
        CourseDetail(
          code: "CS3401",
          name: "Algorithms and Data Structures",
          semester: 3,
          credits: 4,
          ltp: "3-1-0-4",
          category: "Professional Core",
          units: [
            "Unit I: Asymptotic Complexity & Divide-and-Conquer",
            "Unit II: Greedy Methods & Dynamic Programming",
            "Unit III: Graph Algorithms & Minimum Spanning Trees",
            "Unit IV: Advanced Trees & Heap Data Structures",
            "Unit V: NP-Completeness and Approximation",
          ],
          outcomes: [
            "CO1: Analyze worst-case and amortized algorithm complexities.",
            "CO2: Synthesize dynamic programming solutions for optimization problems.",
            "CO3: Implement graph traversals and shortest path algorithms.",
          ],
        ),
      ],
    ),

    // 2. ECE
    CurriculumProgramme(
      id: "prog_ece",
      title: "B.E. ECE",
      regulation: "Regulation R2026",
      version: "Published · v1",
      semesters: 8,
      courses: 58,
      credits: "155.5",
      syllabusWritten: 0,
      totalSyllabus: 58,
      updatedDate: "Updated 30 Oct 2026 by University Super Admin",
      sampleCourses: [
        CourseDetail(
          code: "EC3351",
          name: "Signals and Systems",
          semester: 3,
          credits: 4,
          ltp: "3-1-0-4",
          category: "Professional Core",
          units: [
            "Unit I: Classification of Signals and Systems",
            "Unit II: Continuous Time Fourier & Laplace Transforms",
            "Unit III: Linear Time Invariant Continuous Systems",
            "Unit IV: Discrete Time Fourier Transform and Z-Transform",
            "Unit V: Linear Time Invariant Discrete Systems",
          ],
          outcomes: [
            "CO1: Classify continuous and discrete signals and systems.",
            "CO2: Compute Fourier and Laplace transform representations.",
            "CO3: Determine stability and causality of LTI systems.",
          ],
        ),
      ],
    ),

    // 3. AI & DS
    CurriculumProgramme(
      id: "prog_aids",
      title: "B.Tech. Artificial Intelligence and Data Science",
      regulation: "Regulation R2026",
      version: "Published · v1",
      semesters: 8,
      courses: 1,
      credits: "4",
      syllabusWritten: 1,
      totalSyllabus: 1,
      updatedDate: "Updated 8 Oct 2026 by University Super Admin",
      sampleCourses: [
        CourseDetail(
          code: "AD3492",
          name: "Foundations of Data Science & Big Data Platforms",
          semester: 4,
          credits: 4,
          ltp: "3-0-2-4",
          category: "Professional Core",
          units: [
            "Unit I: Introduction to Data Wrangling & Pipelines",
            "Unit II: Statistical Inference and Hypothesis Testing",
            "Unit III: Distributed Storage with HDFS and Object Stores",
            "Unit IV: MapReduce and Spark Resilient Distributed Datasets",
            "Unit V: Real-time Streaming & Dashboarding",
          ],
          outcomes: [
            "CO1: Implement end-to-end data pipelines for structured/unstructured sources.",
            "CO2: Perform inferential statistics on sample populations.",
            "CO3: Write distributed transformations using Apache Spark.",
          ],
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openProgrammeDetails(CurriculumProgramme prog) {
    showDialog(
      context: context,
      builder: (ctx) => _ProgrammeDetailDialog(programme: prog),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _programmes.where((p) {
      if (_selectedRegulation != "All Regulations" && p.regulation != _selectedRegulation) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = p.title.toLowerCase();
        final reg = p.regulation.toLowerCase();
        if (!title.contains(query) && !reg.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP HERO BLUEPRINT BANNER
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. SECTION INTRO SUBTEXT (MATCHING SCREENSHOT)
                Text(
                  "Your university's published curricula. Open a programme to see each course's syllabus, and plan your teaching from it.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),

                // 3. RESPONSIVE CURRICULA CARDS GRID
                if (filtered.isEmpty)
                  _buildEmptyState()
                else
                  _buildProgrammesGrid(filtered, constraints),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
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
            // Background blueprint grid texture
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative stack watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.layers_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (Scrollable for mobile safety)
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
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "University",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Curriculum Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Layered stack icon rounded box
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF3B487A),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.layers_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges: UNIVERSITY, MVP
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "UNIVERSITY",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Curriculum Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle description
                            Text(
                              "Prepare programme curricula: semesters, courses, credits, L-T-P, syllabus units and course outcomes, drafted with AI and published to every college.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
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
  // 2. PROGRAMMES GRID (RESPONSIVE)
  // ===========================================================================
  Widget _buildProgrammesGrid(List<CurriculumProgramme> list, BoxConstraints constraints) {
    final width = constraints.maxWidth;

    if (width >= 1050) {
      // 3 Columns matching exact screenshot layout
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list.map((prog) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildProgrammeCard(prog),
            ),
          );
        }).toList(),
      );
    } else if (width >= 680) {
      // 2 Columns for tablets
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: list.map((prog) {
          return SizedBox(
            width: (width - 56) / 2,
            child: _buildProgrammeCard(prog),
          );
        }).toList(),
      );
    } else {
      // 1 Column for mobile
      return Column(
        children: list.map((prog) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildProgrammeCard(prog),
          );
        }).toList(),
      );
    }
  }

  // ===========================================================================
  // 3. INDIVIDUAL PROGRAMME CARD (MATCHES IMAGE EXACTLY)
  // ===========================================================================
  Widget _buildProgrammeCard(CurriculumProgramme prog) {
    return InkWell(
      onTap: () => _openProgrammeDetails(prog),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Document Icon + Published Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.article_outlined,
                      size: 17,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFA7F3D0).withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    prog.version,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D9488),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Programme Title
            Text(
              prog.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),

            // Regulation Subtitle
            Text(
              prog.regulation,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),

            // 3 Stat Tiles Box (Semesters / Courses / Credits)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  _buildStatTile("Semesters", "${prog.semesters}"),
                  _buildStatTile("Courses", "${prog.courses}"),
                  _buildStatTile("Credits", prog.credits),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Syllabus Written Progress Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Syllabus written",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  "${prog.syllabusWritten}/${prog.totalSyllabus}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: prog.syllabusProgress,
                minHeight: 4,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
              ),
            ),
            const SizedBox(height: 14),

            // Card Footer
            Text(
              prog.updatedDate,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EMPTY STATE FALLBACK
  // ===========================================================================
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.school_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(
              "No curricula found",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting search criteria or selecting another regulation.",
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// PROGRAMME SYLLABUS DETAIL MODAL
// =============================================================================
class _ProgrammeDetailDialog extends StatefulWidget {
  final CurriculumProgramme programme;
  const _ProgrammeDetailDialog({required this.programme});

  @override
  State<_ProgrammeDetailDialog> createState() => _ProgrammeDetailDialogState();
}

class _ProgrammeDetailDialogState extends State<_ProgrammeDetailDialog> {
  int _selectedSem = 1;

  @override
  Widget build(BuildContext context) {
    final prog = widget.programme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.menu_book_rounded, color: Color(0xFF4F46E5), size: 22),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prog.title,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "${prog.regulation} · ${prog.version} · ${prog.credits} Total Credits",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 16),

              // Semester Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(prog.semesters, (index) {
                    final semNum = index + 1;
                    final isSelected = _selectedSem == semNum;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setState(() => _selectedSem = semNum),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF141938) : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            "Semester $semNum",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? Colors.white : const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // Courses List in Semester
              Expanded(
                child: prog.sampleCourses.isEmpty
                    ? Center(
                        child: Text(
                          "Curriculum drafting for Semester $_selectedSem in progress.",
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                        ),
                      )
                    : ListView.separated(
                        itemCount: prog.sampleCourses.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 14),
                        itemBuilder: (context, i) {
                          final c = prog.sampleCourses[i];
                          return Container(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        c.code,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF4338CA),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${c.credits} Credits · L-T-P: ${c.ltp}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F766E),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  c.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Syllabus Units:",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...c.units.map((u) => Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text(
                                        "• $u",
                                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
                                      ),
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Bottom Actions
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                    ),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SUBTLE GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _GridPaperPainter({required this.gridColor, this.step = 28.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
