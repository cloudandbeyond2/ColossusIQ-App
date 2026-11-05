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
class MyQuizzesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const MyQuizzesScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final quizzes = [
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

    return PortalPageBody(
      title: "My Quizzes",
      category: "AI Course & Certification",
      onBack: onBack,
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
                      children: quizzes.map((q) => _buildQuizCard(context, q)).toList(),
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
                ...quizzes.map((q) => _buildQuizCard(context, q)),
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

          // Buttons Row
          Row(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
