import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: QUESTION BANK SCREEN (Matches Image 1)
// - Hero Blueprint Banner: "Home > Assessment > Question Bank", badges ASSESSMENT, MVP
// - Actions: "Generate with AI" (outlined), "+ Add question" (amber solid)
// - Filter pills: All 10, Active 10, Draft 0, Archived 0
// - Table card: Search bar with "10 records" counter
// - Data Table: ID, Question, Topic, Difficulty, Bloom Level, Course Outcome, Marks, Status, Updated, Actions
// =============================================================================

class PrincipalQuestionBankScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalQuestionBankScreen({super.key, this.onBack});

  @override
  State<PrincipalQuestionBankScreen> createState() =>
      _PrincipalQuestionBankScreenState();
}

class _PrincipalQuestionBankScreenState
    extends State<PrincipalQuestionBankScreen> {
  int _activeFilterIndex = 0; // 0: All 10, 1: Active 10, 2: Draft 0, 3: Archived 0
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _questions = [
    {
      "id": "Q-1049",
      "question":
          "Explain the differences between clustered and non-clustered indexes in PostgreSQL.",
      "topic": "Indexing",
      "difficulty": "Medium",
      "diffColor": const Color(0xFFD97706),
      "diffBg": const Color(0xFFFEF3C7),
      "bloom": "Understand",
      "bloomColor": const Color(0xFF4F46E5),
      "bloomBg": const Color(0xFFEEF2FF),
      "co": "CO1",
      "marks": "5",
      "status": "Active",
      "updated": "29 Sept 2026",
    },
    {
      "id": "Q-1048",
      "question":
          "Discuss conflict serializability and precedence graphs for schedule verification.",
      "topic": "Transactions",
      "difficulty": "Hard",
      "diffColor": const Color(0xFF1E293B),
      "diffBg": const Color(0xFFF1F5F9),
      "bloom": "Analyse",
      "bloomColor": const Color(0xFF7C3AED),
      "bloomBg": const Color(0xFFF5F3FF),
      "co": "CO4",
      "marks": "10",
      "status": "Active",
      "updated": "28 Sept 2026",
    },
    {
      "id": "Q-1047",
      "question":
          "Write an optimized SQL query to find the second-highest salary without using LIMIT.",
      "topic": "SQL",
      "difficulty": "Medium",
      "diffColor": const Color(0xFFD97706),
      "diffBg": const Color(0xFFFEF3C7),
      "bloom": "Apply",
      "bloomColor": const Color(0xFF2563EB),
      "bloomBg": const Color(0xFFEFF6FF),
      "co": "CO3",
      "marks": "4",
      "status": "Active",
      "updated": "27 Sept 2026",
    },
    {
      "id": "Q-1046",
      "question":
          "Construct a B+ tree for keys [10, 20, 5, 15, 30, 25] with order 3.",
      "topic": "Indexing",
      "difficulty": "Hard",
      "diffColor": const Color(0xFF1E293B),
      "diffBg": const Color(0xFFF1F5F9),
      "bloom": "Apply",
      "bloomColor": const Color(0xFF2563EB),
      "bloomBg": const Color(0xFFEFF6FF),
      "co": "CO3",
      "marks": "10",
      "status": "Active",
      "updated": "26 Sept 2026",
    },
    {
      "id": "Q-1045",
      "question":
          "Define functional dependency and state Armstrong axioms with examples.",
      "topic": "Normalization",
      "difficulty": "Medium",
      "diffColor": const Color(0xFFD97706),
      "diffBg": const Color(0xFFFEF3C7),
      "bloom": "Remember",
      "bloomColor": const Color(0xFF0D9488),
      "bloomBg": const Color(0xFFCCFBF1),
      "co": "CO2",
      "marks": "4",
      "status": "Active",
      "updated": "25 Sept 2026",
    },
    {
      "id": "Q-1044",
      "question":
          "Explain lossless-join decomposition and provide conditions to verify it.",
      "topic": "Normalization",
      "difficulty": "Hard",
      "diffColor": const Color(0xFF1E293B),
      "diffBg": const Color(0xFFF1F5F9),
      "bloom": "Apply",
      "bloomColor": const Color(0xFF2563EB),
      "bloomBg": const Color(0xFFEFF6FF),
      "co": "CO4",
      "marks": "8",
      "status": "Active",
      "updated": "24 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
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
                // 1. HERO BLUEPRINT BANNER (Image 1)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. FILTER PILLS
                _buildFilterPills(),
                const SizedBox(height: 18),

                // 3. TABLE CARD
                _buildTableCard(),
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
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.quiz_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (Scrollable on small devices)
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
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text("Home",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Assessment",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Question Bank",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges: ASSESSMENT, MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "ASSESSMENT",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "MVP",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title + Actions (Responsive LayoutBuilder)
                  LayoutBuilder(
                    builder: (context, bannerConstraints) {
                      final isCompact = bannerConstraints.maxWidth < 680;

                      final iconWidget = Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.format_list_bulleted_rounded,
                            color: Color(0xFFFBBF24), // Yellow List Icon
                            size: 22,
                          ),
                        ),
                      );

                      final titleContent = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question Bank",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Tagged questions by topic, difficulty, Bloom level and course outcome.",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFFCBD5E1),
                              height: 1.4,
                            ),
                          ),
                        ],
                      );

                      final actionButtons = Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.auto_awesome_rounded,
                                size: 14, color: Colors.white),
                            label: const Text("Generate with AI"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.25)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add_rounded,
                                size: 16, color: Color(0xFF1E293B)),
                            label: Text(
                              "Add question",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5A93C),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      );

                      if (isCompact) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                iconWidget,
                                const SizedBox(width: 14),
                                Expanded(child: titleContent),
                              ],
                            ),
                            const SizedBox(height: 14),
                            actionButtons,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconWidget,
                          const SizedBox(width: 14),
                          Expanded(child: titleContent),
                          const SizedBox(width: 14),
                          actionButtons,
                        ],
                      );
                    },
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
  // 2. FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final pills = [
      {"label": "All", "count": 10},
      {"label": "Active", "count": 10},
      {"label": "Draft", "count": 0},
      {"label": "Archived", "count": 0},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(pills.length, (index) {
          final isSelected = _activeFilterIndex == index;
          final p = pills[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _activeFilterIndex = index),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.2)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${p["count"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? Colors.white : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD
  // ===========================================================================
  Widget _buildTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: "Search by name, ID or topic...",
                        hintStyle:
                            TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 18, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  "10 records",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 22,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 64,
                dataRowMaxHeight: 72,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("QUESTION")),
                  DataColumn(label: Text("TOPIC")),
                  DataColumn(label: Text("DIFFICULTY")),
                  DataColumn(label: Text("BLOOM LEVEL")),
                  DataColumn(label: Text("COURSE OUTCOME")),
                  DataColumn(label: Text("MARKS"), numeric: true),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _questions.map((q) {
                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          q["id"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                      // Question
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                q["question"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "...more",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Topic
                      DataCell(
                        Text(
                          q["topic"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Difficulty
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: q["diffBg"] as Color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            q["difficulty"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: q["diffColor"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Bloom Level
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: q["bloomBg"] as Color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            q["bloom"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: q["bloomColor"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Course Outcome
                      DataCell(
                        Text(
                          q["co"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Marks
                      DataCell(
                        Text(
                          q["marks"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F4EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            q["status"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF047857),
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          q["updated"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Actions
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAINTER
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
