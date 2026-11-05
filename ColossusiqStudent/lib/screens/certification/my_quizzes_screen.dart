import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/portal_page_body.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/certificate_grades_card.dart';
import '../../data/mock_data.dart';
import '../../data/models/assessment_model.dart';
import '../assessments/test_player_screen.dart';

/// My Quizzes Screen (matching Image 4 design)
class MyQuizzesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const MyQuizzesScreen({super.key, this.onBack});

  @override
  State<MyQuizzesScreen> createState() => _MyQuizzesScreenState();
}

class _MyQuizzesScreenState extends State<MyQuizzesScreen> {
  final List<Map<String, dynamic>> _quizzes = [
    {
      "dept": "Training & Placement",
      "hasCert": true,
      "title": "Placement aptitude — quantitative",
      "questions": 3,
      "mins": 10,
      "pass": 60,
      "bestScore": 66.67,
      "attemptsLeft": 2,
      "hasPassed": true,
    },
    {
      "dept": "Computer Science & Engineering",
      "hasCert": true,
      "title": "Computer Science & Engineering — Unit test 1",
      "questions": 3,
      "mins": 15,
      "pass": 50,
      "bestScore": 66.67,
      "attemptsLeft": 2,
      "hasPassed": true,
    },
    {
      "dept": "Civil Engineering",
      "hasCert": true,
      "title": "Basics of Structural Engineering",
      "questions": 8,
      "mins": 20,
      "pass": 50,
      "bestScore": null,
      "attemptsLeft": 3,
      "hasPassed": false,
    },
    {
      "dept": "Computer Science & Engineering",
      "hasCert": false,
      "title": "Integration attempt-limit quiz",
      "questions": 3,
      "mins": 10,
      "pass": 50,
      "bestScore": null,
      "attemptsLeft": 3,
      "hasPassed": false,
    },
    {
      "dept": "Computer Science & Engineering",
      "hasCert": true,
      "title": "Computer Science & Engineering — DBMS quiz",
      "questions": 8,
      "mins": 20,
      "pass": 50,
      "bestScore": 50.0,
      "attemptsLeft": 2,
      "hasPassed": true,
    },
  ];

  void _showQuizDetailsDialog(Map<String, dynamic> q) {
    final bestScore = q["bestScore"] as double?;
    final hasCert = q["hasCert"] as bool;

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
              child: const Icon(Icons.quiz_outlined, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(q["dept"] as String, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Questions", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${q['questions']}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Duration", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${q['mins']} min", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Pass Mark", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${q['pass']}%", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF059669))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.workspace_premium_outlined, size: 16, color: Color(0xFFD97706)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        hasCert ? "Certificate: Verifiable certificate upon passing" : "Certificate: Practice mode only",
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.history_toggle_off_rounded, size: 16, color: Color(0xFF2563EB)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Best Score: ${bestScore != null ? '${bestScore.toStringAsFixed(1)}%' : 'Not attempted yet'} · ${q['attemptsLeft']} attempts remaining",
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Examination Instructions", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "All questions are evaluated on the central server. Once started, the timer will count down. Do not refresh or exit the screen during testing.",
                  style: GoogleFonts.poppins(fontSize: 12, height: 1.45, color: const Color(0xFF475569)),
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
                  _showEditQuizGoalDialog(q);
                },
                child: const Text("Edit Goal"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditQuizGoalDialog(Map<String, dynamic> q) {
    final titleCtrl = TextEditingController(text: q["title"] as String);
    final targetScoreCtrl = TextEditingController(text: "${q["pass"]}%");
    final minsCtrl = TextEditingController(text: "${q["mins"]}");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Quiz Target & Goals", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Quiz Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: targetScoreCtrl,
                        decoration: const InputDecoration(labelText: "Target Score", border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: minsCtrl,
                        decoration: const InputDecoration(labelText: "Duration (mins)", border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
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
                  setState(() {
                    q["title"] = titleCtrl.text.trim();
                    final parsedMins = int.tryParse(minsCtrl.text.trim());
                    if (parsedMins != null) q["mins"] = parsedMins;
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Target for '${q["title"]}' updated successfully!"),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                ),
                child: Text("Save Goal", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "My Quizzes",
      category: "AI Course & Certification",
      onBack: widget.onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  AI Course & Certification  ›  My Quizzes",
          category: "AI Course & Certification",
          phase: "MVP",
          isMvp: true,
          icon: Icons.quiz_outlined,
          title: "My Quizzes",
          subtitle: "Timed department quizzes, marked on the server. Pass to earn a verifiable certificate.",
          watermarkIcon: Icons.assignment_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Responsive Quizzes + Certificate Grades Sidebar Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: _quizzes.map((q) => _buildQuizCard(context, q)).toList(),
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    flex: 4,
                    child: CertificateGradesCard(),
                  ),
                ],
              );
            }
            return Column(
              children: [
                ..._quizzes.map((q) => _buildQuizCard(context, q)),
                const SizedBox(height: 12),
                const CertificateGradesCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuizCard(BuildContext context, Map<String, dynamic> q) {
    final bestScore = q["bestScore"] as double?;
    final hasCert = q["hasCert"] as bool;
    final attemptsLeft = q["attemptsLeft"] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          // Badges row
          Row(
            children: [
              AppBadge(label: q["dept"] as String, tone: BadgeTone.sky),
              if (hasCert) ...[
                const SizedBox(width: 6),
                const AppBadge(
                  label: "Certificate",
                  tone: BadgeTone.gold,
                  icon: Icons.workspace_premium_outlined,
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            q["title"] as String,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),

          // Metadata row
          Text(
            "${q['questions']} questions   ${q['mins']} min   Pass ${q['pass']}%",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: AppColors.ink3,
            ),
          ),
          const SizedBox(height: 10),

          // Best score bar if attempted
          if (bestScore != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Best score", style: GoogleFonts.poppins(fontSize: 11, color: AppColors.ink3)),
                Text("${bestScore.toStringAsFixed(bestScore.truncateToDouble() == bestScore ? 0 : 2)}%",
                    style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.ink)),
              ],
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: bestScore / 100,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation(
                  bestScore >= 60 ? AppColors.primaryBlue : AppColors.warning,
                ),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Buttons Row: Start Quiz, View Details, Edit Goal
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  final test = MockData.mockTests.firstWhere(
                    (t) => t.title.toLowerCase() == (q['title'] as String).toLowerCase(),
                    orElse: () => MockTest(
                      id: "QUIZ-${(q['title'] as String).hashCode.abs()}",
                      title: q['title'] as String,
                      subject: q['dept'] as String,
                      department: q['dept'] as String,
                      durationMinutes: (q['mins'] as int?) ?? 15,
                      totalQuestions: (q['questions'] as int?) ?? 3,
                      passPercentage: (q['pass'] as int?) ?? 50,
                      bestScore: (q['bestScore'] as double?)?.toInt(),
                      attemptsUsed: 3 - ((q['attemptsLeft'] as int?) ?? 2),
                      maxAttempts: 3,
                      certificateEnabled: (q['hasCert'] as bool?) ?? false,
                      questions: MockData.mockTests.first.questions,
                    ),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TestPlayerScreen(test: test),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 16),
                label: Text(bestScore != null ? "Retake ($attemptsLeft left)" : "Start quiz"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showQuizDetailsDialog(q),
                icon: const Icon(Icons.visibility_outlined, size: 13),
                label: const Text("View Details"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF0F766E),
                  textStyle: GoogleFonts.poppins(fontSize: 11.5),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showEditQuizGoalDialog(q),
                icon: const Icon(Icons.edit_outlined, size: 13),
                label: const Text("Edit Goal"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF4338CA),
                  textStyle: GoogleFonts.poppins(fontSize: 11.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
