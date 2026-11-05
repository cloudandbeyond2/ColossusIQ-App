import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ASSESSMENT: AI EVALUATION REVIEW SCREEN
// Matches screenshots 1 & 2: Blueprint grid hero banner, AI disclaimer alert banner,
// review queue list (Anand Kumar, Divya Raman, Karthik Raja, Meera Nair, etc.),
// student answer card, AI provisional score breakdown, rubric match table,
// evidence found / missing concepts, decision status, and audit trail.
// =============================================================================
class AiEvaluationReviewScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiEvaluationReviewScreen({super.key, this.onBack});

  @override
  State<AiEvaluationReviewScreen> createState() =>
      _AiEvaluationReviewScreenState();
}

class _AiEvaluationReviewScreenState extends State<AiEvaluationReviewScreen> {
  int _selectedStudentIndex = 0;
  int _auditTab = 0; // 0 = Evaluation only (0), 1 = All activity (0)

  final List<Map<String, dynamic>> _students = [
    {
      "name": "Anand Kumar",
      "roll": "....0101",
      "aiScore": "8.5/10",
      "conf": "0.92",
      "finalScore": "8.5",
      "status": "Approved",
      "statusColor": "green",
      "answer":
          "3NF: A relation is in 3NF if it is in 2NF and has no transitive dependency. For every non-trivial FD X -> A, either X is a superkey or A is prime attribute.\nExample: Student(RollNo, Name, DeptId, DeptName). DeptId -> DeptName is transitive via DeptId.\nDecomposition: Student(RollNo, Name, DeptId) and Department(DeptId, DeptName). Lossless join justified.",
      "scoreVal": "8.5",
      "percentage": "85%",
      "percentVal": 0.85,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "3 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "2.5 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "2 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Defines 3NF using superkeys & prime attributes",
        "Shows relation Student with DeptId transitive dependency",
        "Decomposes into two relations with shared key",
      ],
      "missing": "None — all expected points covered.",
      "summary": "Complete answer covering expected points.",
    },
    {
      "name": "Divya Raman",
      "roll": "....0108",
      "aiScore": "9/10",
      "conf": "0.94",
      "finalScore": "9",
      "status": "Approved",
      "statusColor": "green",
      "answer":
          "3NF requires relations to be in 2NF with no non-prime attribute transitively dependent on any candidate key. Formally for X -> Y, X must be a super key or Y is a prime attribute. Provided full normalization breakdown and dependency preservation proof.",
      "scoreVal": "9.0",
      "percentage": "90%",
      "percentVal": 0.90,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "3 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "3 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "2 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Accurate formal non-transitivity definition",
        "Strong dependency preservation proof",
        "Clear table decomposition examples",
      ],
      "missing": "None — exceptionally detailed.",
      "summary": "Exemplary answer with robust analytical proof.",
    },
    {
      "name": "Karthik Raja",
      "roll": "....0115",
      "aiScore": "5/10",
      "conf": "0.72",
      "finalScore": "6.5",
      "status": "Overridden",
      "statusColor": "cyan",
      "answer":
          "3NF means no transitive dependency in the database. When A determines B and B determines C, A determines C is transitive. To fix it we split the table into two separate tables.",
      "scoreVal": "6.5",
      "percentage": "65%",
      "percentVal": 0.65,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "2 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "1.5 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "2 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Basic transitive definition provided",
        "Table splitting stated",
      ],
      "missing": "Candidate key / prime attribute formal condition omitted.",
      "summary": "Partial answer; faculty gave benefit of doubt on schematic splitting.",
    },
    {
      "name": "Meera Nair",
      "roll": "....0122",
      "aiScore": "8/10",
      "conf": "0.88",
      "finalScore": "8",
      "status": "Approved",
      "statusColor": "green",
      "answer":
          "A schema is in 3NF if whenever a functional dependency X -> A holds, either X is a superkey or A is prime. Example: Emp_Dept table decomposed into Emp and Dept tables.",
      "scoreVal": "8.0",
      "percentage": "80%",
      "percentVal": 0.80,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "3 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "2 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "2 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Correct standard textbook definition",
        "Clear decomposition schema",
      ],
      "missing": "Lossless join testing algorithm brief.",
      "summary": "Solid responses with accurate syntax.",
    },
    {
      "name": "Rahul Sharma",
      "roll": "....0129",
      "aiScore": "4/10",
      "conf": "0.61",
      "status": "Low confidence",
      "statusColor": "orange",
      "answer":
          "3NF removes duplicate columns from database. Tables are broken into 1st, 2nd and 3rd forms.",
      "scoreVal": "4.0",
      "percentage": "40%",
      "percentVal": 0.40,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "1 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "1 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "1 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Mentions normalization stages",
      ],
      "missing": "Missing formal definitions, functional dependencies, and proof.",
      "summary": "Underdeveloped answer requiring faculty manual inspection.",
    },
    {
      "name": "Sneha Iyer",
      "roll": "....0136",
      "aiScore": "7.5/10",
      "conf": "0.89",
      "finalScore": "7.5",
      "status": "Approved",
      "statusColor": "green",
      "answer":
          "Third Normal Form ensures that non-key attributes are independent. For every X -> Y, X is superkey or Y is prime. Example: OrderDetails separated from CustomerAddress.",
      "scoreVal": "7.5",
      "percentage": "75%",
      "percentVal": 0.75,
      "rubrics": [
        {"criterion": "3NF Formal Definition", "awarded": "2.5 / 3"},
        {"criterion": "Transitive Dependency Example", "awarded": "2 / 3"},
        {"criterion": "Lossless Decomposition", "awarded": "2 / 3"},
        {"criterion": "Technical Clarity & Presentation", "awarded": "1 / 1"},
      ],
      "evidences": [
        "Defines non-key independence",
        "Practical business example provided",
      ],
      "missing": "Armstrong axiom derivation not included.",
      "summary": "Well structured practical answer.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedStudent = _students[_selectedStudentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 960;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 18),

              // 3. Two-Column Layout (Review queue + Evaluation Detail)
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: _buildReviewQueueCard(),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _buildEvaluationDetailColumn(selectedStudent),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildReviewQueueCard(),
                    const SizedBox(height: 18),
                    _buildEvaluationDetailColumn(selectedStudent),
                  ],
                ),
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
            // Blueprint grid background
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative watermark on the right
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.fact_check_rounded,
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
                  // Breadcrumb row (Home clickable without leading arrow)
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
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Assessment",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Evaluation Review",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges + Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Document Icon Box
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.fact_check_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "ASSESSMENT",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "AI Evaluation Review",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    "Review AI-suggested scores, evidence and missing concepts; approve or override.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
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

  // ===========================================================================
  // 2. DISCLAIMER ALERT
  // ===========================================================================
  Widget _buildDisclaimerAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Teachers always have the final say. AI output includes confidence and evidence and never publishes marks without approval.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. LEFT COLUMN: REVIEW QUEUE
  // ===========================================================================
  Widget _buildReviewQueueCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review queue",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "1 pending",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Student Items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _students.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final student = _students[index];
              final isSelected = _selectedStudentIndex == index;
              return _buildStudentQueueItem(student, index, isSelected);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudentQueueItem(
    Map<String, dynamic> student,
    int index,
    bool isSelected,
  ) {
    Color badgeBg;
    Color badgeFg;
    if (student["statusColor"] == "green") {
      badgeBg = const Color(0xFFDCFCE7);
      badgeFg = const Color(0xFF15803D);
    } else if (student["statusColor"] == "cyan") {
      badgeBg = const Color(0xFFCCFBF1);
      badgeFg = const Color(0xFF0F766E);
    } else {
      badgeBg = const Color(0xFFFEF3C7);
      badgeFg = const Color(0xFFD97706);
    }

    return InkWell(
      onTap: () => setState(() => _selectedStudentIndex = index),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : const Color(0xFFFAFAFD),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF93C5FD) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    student["name"],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    student["status"],
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: badgeFg,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              student["roll"],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              student["finalScore"] != null
                  ? "AI: ${student["aiScore"]} · conf. ${student["conf"]} · Final: ${student["finalScore"]}"
                  : "AI: ${student["aiScore"]} · conf. ${student["conf"]}",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. RIGHT COLUMN: DETAILED EVALUATION
  // ===========================================================================
  Widget _buildEvaluationDetailColumn(Map<String, dynamic> student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Question & Student Answer Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DBMS Internal Assessment I",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "Explain Third Normal Form (3NF) with a suitable example and decomposition. (10 marks)",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "STUDENT ANSWER",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF94A3B8),
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFD),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  student["answer"],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.55,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. AI evaluation (provisional) Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "AI evaluation (provisional)",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "High confidence",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3 Stat Blocks
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 550;
                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildStatBox("Suggested score", "${student["scoreVal"]} / 10")),
                            const SizedBox(width: 10),
                            Expanded(child: _buildStatBox("Confidence", student["conf"])),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildPercentageBox(student["percentage"], student["percentVal"]),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: _buildStatBox("Suggested score", "${student["scoreVal"]} / 10")),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatBox("Confidence", student["conf"])),
                      const SizedBox(width: 12),
                      Expanded(child: _buildPercentageBox(student["percentage"], student["percentVal"])),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Rubric match table
              Text(
                "Rubric match",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Criterion",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Awarded",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Rubric Rows
                    ...List.generate(
                      (student["rubrics"] as List).length,
                      (i) {
                        final r = student["rubrics"][i];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            border: i > 0
                                ? const Border(top: BorderSide(color: Color(0xFFF1F5F9)))
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                r["criterion"],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                              Text(
                                r["awarded"],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Evidence found & Missing concepts
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 600;
                  final left = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Evidence found",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                        (student["evidences"] as List).length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16,
                                color: Color(0xFF0D9488),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  student["evidences"][i],
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );

                  final right = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Missing concepts",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        student["missing"],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  );

                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        left,
                        const SizedBox(height: 14),
                        right,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 18),
                      Expanded(child: right),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),

              // Summary Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  student["summary"],
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Warning note
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 15,
                    color: Color(0xFFD97706),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Marks are provisional until your faculty approves or overrides them. Every override is audit-logged.",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // AI Confidence footnote pill
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 14,
                        color: Color(0xFFD97706),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "AI-generated — verify important details",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "confidence 92%",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Your decision Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your decision",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Teachers always have the final say",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Approved — final score ${student["scoreVal"]} / 10. Recorded in the audit log.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 4. Audit trail Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 560;
                  final titleCol = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audit trail",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Recorded evaluation decisions and oversight actions",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  );

                  final filterRow = SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildAuditFilterPill("Evaluation only (0)", 0),
                        const SizedBox(width: 8),
                        _buildAuditFilterPill("All activity (0)", 1),
                      ],
                    ),
                  );

                  if (isNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleCol,
                        const SizedBox(height: 10),
                        filterRow,
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: titleCol),
                      const SizedBox(width: 10),
                      filterRow,
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // Empty state
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.history_rounded,
                      size: 26,
                      color: Color(0xFFCBD5E1),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "No evaluation decisions recorded yet in this session.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageBox(String text, double val) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Percentage",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: val,
              minHeight: 5,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditFilterPill(String title, int idx) {
    final isSelected = _auditTab == idx;
    return InkWell(
      onTap: () => setState(() => _auditTab = idx),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F5F9) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFCBD5E1) : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

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
