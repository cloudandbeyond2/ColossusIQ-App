import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../data/models/assessment_model.dart';
import 'test_player_screen.dart';

class AssessmentsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const AssessmentsScreen({super.key, this.onBack});

  static const List<Map<String, dynamic>> _mockTestsList = [
    {
      "category": "Question Bank",
      "difficulty": "Easy",
      "isAdaptive": false,
      "title": "Question Bank: Transactions",
      "meta": "3 questions · 15 min",
      "score": null,
    },
    {
      "category": "Question Bank",
      "difficulty": "Hard",
      "isAdaptive": false,
      "title": "Question Bank: SQL",
      "meta": "2 questions · 10 min",
      "score": null,
    },
    {
      "category": "Question Bank",
      "difficulty": "Hard",
      "isAdaptive": false,
      "title": "Question Bank: Indexing",
      "meta": "3 questions · 15 min",
      "score": null,
    },
    {
      "category": "Question Bank",
      "difficulty": "Hard",
      "isAdaptive": false,
      "title": "Question Bank: Normalization",
      "meta": "2 questions · 10 min",
      "score": null,
    },
    {
      "category": "DBMS",
      "difficulty": "Adaptive",
      "isAdaptive": true,
      "title": "Normalization & Functional Dependencies",
      "meta": "5 questions · 20 min · Last score: 58%",
      "score": 58,
    },
    {
      "category": "Operating Systems",
      "difficulty": "Medium",
      "isAdaptive": false,
      "title": "Deadlocks & Banker's Algorithm",
      "meta": "3 questions · 15 min",
      "score": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, screenConstraints) {
            final isMobile = screenConstraints.maxWidth < 640;
            final horizPadding = isMobile ? 14.0 : 24.0;
            final vertPadding = isMobile ? 14.0 : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizPadding,
                vertical: vertPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Hero Banner
                      _buildHeroBanner(context, isMobile: isMobile),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Grid of 6 Mock Test Cards (2 columns on tablet/desktop, 1 on mobile)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double width = constraints.maxWidth;
                          final int crossAxisCount = width >= 720 ? 2 : 1;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _mockTestsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              mainAxisExtent: isMobile ? 185 : 175,
                            ),
                            itemBuilder: (context, index) {
                              return _buildMockTestCard(
                                context,
                                _mockTestsList[index],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, {required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2358).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _MockTestsGridPainter(),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.quiz_rounded,
                size: isMobile ? 110 : 155,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 28,
                vertical: isMobile ? 18 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (onBack != null || Navigator.canPop(context)) ...[
                          InkWell(
                            onTap: onBack ?? () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 13,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "Assessment",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "Mock Tests",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 14 : 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: isMobile ? 44 : 50,
                        height: isMobile ? 44 : 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.quiz_rounded,
                            size: isMobile ? 22 : 26,
                            color: const Color(0xFFFBBF24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "ASSESSMENT",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF059669),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Mock Tests",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 21 : 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Adaptive topic-wise tests with AI evaluation, confidence and teacher-review flags.",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.82),
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

  void _showAssessmentDetailsDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.assignment_turned_in_outlined, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("${item["category"]} · ${item["difficulty"]}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF2563EB)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item["meta"] as String,
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.psychology_outlined, size: 16, color: Color(0xFF0D9488)),
                    const SizedBox(width: 6),
                    Text(
                      item["isAdaptive"] == true ? "Adaptive AI Evaluation Active" : "Standard Unit Test Format",
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F766E), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 10),
                Text("Assessment Syllabus & Instructions", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Contains multiple choice questions, conceptual proofs and code evaluation. Feedback will highlight confidence gaps and subject revision points.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showEditAssessmentGoalDialog(context, item);
                },
                child: const Text("Edit Target"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  final testList = MockData.mockTests;
                  final test = testList.isNotEmpty
                      ? testList.first
                      : MockTest(
                          id: "t1",
                          title: item["title"] as String,
                          subject: item["category"] as String,
                          department: "Computer Science & Engineering",
                          totalQuestions: 5,
                          durationMinutes: 15,
                          passPercentage: 50,
                          bestScore: null,
                          questions: const [],
                        );
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => TestPlayerScreen(test: test)));
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
                child: const Text("Start Test"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditAssessmentGoalDialog(BuildContext context, Map<String, dynamic> item) {
    final titleCtrl = TextEditingController(text: item["title"] as String);
    final targetCtrl = TextEditingController(text: "Target: 85% Score");
    final notesCtrl = TextEditingController(text: "Revise lecture slides and algorithm proofs before taking test.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Assessment Target", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Assessment Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: targetCtrl,
                  decoration: const InputDecoration(labelText: "Target Score", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Revision Notes", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Target for '${item["title"]}' saved!"),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
                child: Text("Save Target", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMockTestCard(BuildContext context, Map<String, dynamic> item) {
    final isAdaptive = item["isAdaptive"] == true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badges row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item["category"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isAdaptive
                      ? const Color(0xFFFEF3C7)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item["difficulty"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isAdaptive
                        ? const Color(0xFFD97706)
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            item["title"] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 3),

          // Meta row
          Text(
            item["meta"] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _showAssessmentDetailsDialog(context, item),
                icon: const Icon(Icons.visibility_outlined, size: 12),
                label: const Text("View"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF0F766E),
                  textStyle: GoogleFonts.poppins(fontSize: 11),
                ),
              ),
              const SizedBox(width: 5),
              OutlinedButton.icon(
                onPressed: () => _showEditAssessmentGoalDialog(context, item),
                icon: const Icon(Icons.edit_outlined, size: 12),
                label: const Text("Edit"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF4338CA),
                  textStyle: GoogleFonts.poppins(fontSize: 11),
                ),
              ),
              const Spacer(),

              // Start test button
          Material(
            color: const Color(0xFF2E3A94),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                final testList = MockData.mockTests;
                final test = testList.isNotEmpty
                    ? testList.first
                    : MockTest(
                        id: "t1",
                        title: item["title"] as String,
                        subject: item["category"] as String,
                        department: "Computer Science & Engineering",
                        totalQuestions: item["questions"] as int? ?? 5,
                        durationMinutes: item["duration"] as int? ?? 15,
                        passPercentage: 50,
                        bestScore: item["score"] as int?,
                        questions: const [],
                      );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TestPlayerScreen(test: test),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.play_arrow_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Start test",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MockTestsGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1;

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
