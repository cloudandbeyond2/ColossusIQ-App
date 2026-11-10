import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// Exam Preparation Screen (Countdown, syllabus coverage, weak-topic remediation)
class ExamPrepScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const ExamPrepScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, screenConstraints) {
            final isMobile = screenConstraints.maxWidth < 640;
            final isDesktop = screenConstraints.maxWidth >= 960;
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

                      // 4 Top Metric Cards Row
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double width = constraints.maxWidth;
                          final int count = width >= 960
                              ? 4
                              : width >= 560
                                  ? 2
                                  : 1;

                          return GridView.count(
                            crossAxisCount: count,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isMobile ? 2.2 : 1.9,
                            children: [
                              _buildMetricCard(
                                label: "Next exam",
                                value: "9 days",
                                tag: "DBMS IA-II",
                                icon: Icons.description_outlined,
                                iconColor: const Color(0xFFD97706),
                                iconBg: const Color(0xFFFEF3C7),
                              ),
                              _buildMetricCard(
                                label: "Syllabus covered",
                                value: "0%",
                                tag: "+8% this week",
                                icon: Icons.menu_book_rounded,
                                iconColor: const Color(0xFF6366F1),
                                iconBg: const Color(0xFFEEF2FF),
                              ),
                              _buildMetricCard(
                                label: "Mock tests taken",
                                value: "7",
                                tag: "3 this week",
                                icon: Icons.assignment_turned_in_outlined,
                                iconColor: const Color(0xFF059669),
                                iconBg: const Color(0xFFECFDF5),
                              ),
                              _buildMetricCard(
                                label: "Predicted band",
                                value: "B+ to A",
                                tag: "AI estimate",
                                icon: Icons.trending_up_rounded,
                                iconColor: const Color(0xFF2563EB),
                                iconBg: const Color(0xFFEFF6FF),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: isMobile ? 16 : 22),

                      // Middle Row: 2 Charts Side-by-Side
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildTopicMasteryCard(isMobile: isMobile)),
                            const SizedBox(width: 18),
                            Expanded(child: _buildStudyMinutesCard(isMobile: isMobile)),
                          ],
                        )
                      else ...[
                        _buildTopicMasteryCard(isMobile: isMobile),
                        const SizedBox(height: 16),
                        _buildStudyMinutesCard(isMobile: isMobile),
                      ],
                      SizedBox(height: isMobile ? 16 : 22),

                      // Bottom Card: AI Insights
                      _buildAiInsightsCard(isMobile: isMobile),
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
                painter: _ExamGridPainter(),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.assignment_rounded,
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
                          "Exam Preparation",
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
                            Icons.timer_outlined,
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
                              "Exam Preparation",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 21 : 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Countdown, syllabus coverage, weak-topic remediation and last-minute revision.",
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

  Widget _buildMetricCard({
    required String label,
    required String value,
    required String tag,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E286D),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 11,
                  color: Color(0xFF059669),
                ),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    tag,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF059669),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicMasteryCard({required bool isMobile}) {
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DBMS Topic Mastery (%)",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _BarChartPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyMinutesCard({required bool isMobile}) {
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Study Minutes",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _WaveChartPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsightsCard({required bool isMobile}) {
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 16,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "AI insights",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Remediation plan",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ER Model & Relational Algebra in DBMS accounts for most of your missed questions. Prioritise it over the next 4 days.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        height: 1.45,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Evidence: Current mastery: 0% · Unit test logs",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExamGridPainter extends CustomPainter {
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

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    const double leftMargin = 20.0;
    const double bottomMargin = 24.0;
    final chartHeight = size.height - bottomMargin;
    final chartWidth = size.width - leftMargin;

    // Y Axis levels 0, 1, 2, 3, 4
    for (int i = 0; i <= 4; i++) {
      final y = chartHeight - (chartHeight * (i / 4.0));
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width, y),
        gridPaint,
      );

      textPainter.text = TextSpan(
        text: "$i",
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: const Color(0xFF94A3B8),
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - 6));
    }

    // X Axis labels
    const labels = [
      "ER Model & Relatio..",
      "Normalization & Fu..",
      "NoSQL & Distribute..",
    ];

    final colWidth = chartWidth / labels.length;
    for (int i = 0; i < labels.length; i++) {
      final x = leftMargin + (i * colWidth) + colWidth / 2;
      textPainter.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: const Color(0xFF64748B),
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (x - textPainter.width / 2).clamp(leftMargin, size.width - textPainter.width),
          chartHeight + 6,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WaveChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    const double leftMargin = 28.0;
    const double bottomMargin = 24.0;
    final chartHeight = size.height - bottomMargin;
    final chartWidth = size.width - leftMargin;

    // Y Axis levels 0, 30, 60, 90, 120
    final yLevels = [0, 30, 60, 90, 120];
    for (int i = 0; i < yLevels.length; i++) {
      final y = chartHeight - (chartHeight * (i / (yLevels.length - 1)));
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width, y),
        gridPaint,
      );

      textPainter.text = TextSpan(
        text: "${yLevels[i]}",
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: const Color(0xFF94A3B8),
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, y - 6));
    }

    // X Axis labels: Mon - Sun
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    // Values corresponding to the wave in screenshot
    final values = [75.0, 90.0, 60.0, 110.0, 85.0, 120.0, 95.0];

    final List<Offset> points = [];
    final colWidth = chartWidth / (days.length - 1);

    for (int i = 0; i < days.length; i++) {
      final x = leftMargin + (i * colWidth);
      final normalizedY = (values[i] / 120.0).clamp(0.0, 1.0);
      final y = chartHeight - (chartHeight * normalizedY);
      points.add(Offset(x, y));

      textPainter.text = TextSpan(
        text: days[i],
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: const Color(0xFF64748B),
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (x - textPainter.width / 2).clamp(leftMargin, size.width - textPainter.width),
          chartHeight + 6,
        ),
      );
    }

    if (points.isNotEmpty) {
      final wavePath = Path();
      wavePath.moveTo(points.first.dx, points.first.dy);

      for (int i = 0; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        final controlX = (p0.dx + p1.dx) / 2;
        wavePath.cubicTo(controlX, p0.dy, controlX, p1.dy, p1.dx, p1.dy);
      }

      // Fill area under curve
      final fillPath = Path.from(wavePath)
        ..lineTo(points.last.dx, chartHeight)
        ..lineTo(points.first.dx, chartHeight)
        ..close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1E286D).withValues(alpha: 0.16),
            const Color(0xFF1E286D).withValues(alpha: 0.02),
          ],
        ).createShader(Rect.fromLTWH(leftMargin, 0, chartWidth, chartHeight))
        ..style = PaintingStyle.fill;
      canvas.drawPath(fillPath, fillPaint);

      // Stroke curve
      final strokePaint = Paint()
        ..color = const Color(0xFF1E286D)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2;
      canvas.drawPath(wavePath, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Handwritten Evaluation Screen (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class HandwrittenEvaluationScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HandwrittenEvaluationScreen({super.key, this.onBack});

  @override
  State<HandwrittenEvaluationScreen> createState() => _HandwrittenEvaluationScreenState();
}

class _HandwrittenEvaluationScreenState extends State<HandwrittenEvaluationScreen> {
  int _activeTab = 1; // 0: Practice & Self-Evaluation, 1: My Evaluated Sheets (Image 1)
  String _searchQuery = "";
  String _selectedStatus = "All Statuses";
  String _selectedAssessment = "All Assessments (4)";

  // Practice & Self-Evaluation Form State
  final TextEditingController _nameController = TextEditingController(text: "Anand Kumar");
  final TextEditingController _rollController = TextEditingController(text: "110124001");
  final TextEditingController _topicController = TextEditingController(text: "Compiler Design Lexical & Syntax Analysis");
  final TextEditingController _marksController = TextEditingController(text: "10");
  PlatformFile? _uploadedFile;
  int _uploadedFileSize = 0;
  bool _isPicking = false;
  String? _uploadError;
  bool _hasSampleEvaluated = false;

  final List<Map<String, dynamic>> _evaluatedSheets = [
    {
      "id": "ES-01",
      "studentName": "Anand Kumar",
      "rollNo": "110124001",
      "status": "Approved",
      "title": "Assessment on complier design...",
      "question": "complier design",
      "faculty": "Dr. Meena",
      "remarks": "good work",
      "marksAwarded": 9.5,
      "totalMarks": 10,
      "percentage": 95,
      "aiConfidence": 87,
      "confidenceNote": "OCR & Rubric matching",
      "transcription":
          "[Transcribed from Compiler_Design_3_Page_Handwritten_Assignment.pdf]:\n"
          "Student answer covering assigned subject matter.\n"
          "Handwritten concepts and notations successfully identified (180 words extracted). Full technical terminology and illustrative example detected.",
      "rubrics": [
        {"name": "Definition & Core Concept", "scored": 3.5, "max": 3.5},
        {"name": "Technical Terminology & Accuracy", "scored": 3.0, "max": 3.0},
        {"name": "Illustrative Example / Application", "scored": 2.5, "max": 2.5},
        {"name": "Clarity, Depth & Structure", "scored": 0.5, "max": 1.0},
      ],
      "keyEvidence": [
        "Syntax-directed definitions (SDD) and parse tree annotated properly.",
        "LR parser table state transitions and shift-reduce actions accurately demonstrated.",
        "Intermediate code generation (three-address code) formatted correctly.",
      ],
      "missingPoints": [
        "Minor formatting omission in the DAG representation in Section 3.",
      ],
    },
    {
      "id": "ES-02",
      "studentName": "Anand Kumar",
      "rollNo": "110124001",
      "status": "Approved",
      "title": "Assessment on Data Structures Notes and Algo...",
      "question": "Data Structures Notes and Algorithms",
      "faculty": "Dr. Meena",
      "remarks": "good",
      "marksAwarded": 9.5,
      "totalMarks": 10,
      "percentage": 95,
      "aiConfidence": 91,
      "confidenceNote": "OCR & Rubric matching",
      "transcription":
          "[Transcribed from DS_Handwritten_Analysis_Oct.pdf]:\n"
          "Student answer demonstrates thorough understanding of AVL Tree self-balancing rotations (LL, RR, LR, RL) with balance factors calculated at each insertion step.",
      "rubrics": [
        {"name": "Definition & Core Concept", "scored": 3.5, "max": 3.5},
        {"name": "Technical Terminology & Accuracy", "scored": 3.0, "max": 3.0},
        {"name": "Illustrative Example / Application", "scored": 2.5, "max": 2.5},
        {"name": "Clarity, Depth & Structure", "scored": 0.5, "max": 1.0},
      ],
      "keyEvidence": [
        "All 4 AVL rotations illustrated with step-by-step diagrammatic proofs.",
        "Time complexity of O(log N) search, insert, and delete mathematically derived.",
      ],
      "missingPoints": [
        "Could include delete rebalance test case.",
      ],
    },
    {
      "id": "ES-03",
      "studentName": "Anand Kumar",
      "rollNo": "110124001",
      "status": "Faculty Overridden",
      "title": "Integration test",
      "question": "Explain 3NF.",
      "faculty": "Dr. Meena",
      "remarks": "Mark adjusted from 7.5 to 8.0 by Dr. Meena after re-checking transitive dependency explanation.",
      "marksAwarded": 8.0,
      "totalMarks": 10,
      "percentage": 80,
      "aiConfidence": 82,
      "confidenceNote": "OCR & Rubric matching",
      "transcription":
          "[Transcribed from Unit_Integration_Test_Sheet.pdf]:\n"
          "Student answer explains Third Normal Form (3NF) requirements: relation must be in 2NF and no non-prime attribute should be transitively dependent on the candidate key.",
      "rubrics": [
        {"name": "Definition & Core Concept", "scored": 3.0, "max": 3.5},
        {"name": "Technical Terminology & Accuracy", "scored": 2.5, "max": 3.0},
        {"name": "Illustrative Example / Application", "scored": 2.0, "max": 2.5},
        {"name": "Clarity, Depth & Structure", "scored": 0.5, "max": 1.0},
      ],
      "keyEvidence": [
        "Correct formal definition of non-transitive dependency.",
        "Student sample schema decomposed into 3NF without loss of information.",
      ],
      "missingPoints": [
        "Candidate key determinant explanation was slightly brief.",
      ],
    },
    {
      "id": "ES-04",
      "studentName": "Anand Kumar",
      "rollNo": "110124001",
      "status": "Pending",
      "title": "DBMS internal test 1",
      "question": "Explain 3NF with an example.",
      "faculty": "Dr. Meena",
      "remarks": "Awaiting final faculty review.",
      "marksAwarded": 7.0,
      "totalMarks": 10,
      "percentage": 70,
      "aiConfidence": 79,
      "confidenceNote": "OCR & Rubric matching",
      "transcription":
          "[Transcribed from DBMS_Internal_Test1_Scan.pdf]:\n"
          "Handwritten text captured successfully. Discusses student-course-department tables and removal of transitive dependencies.",
      "rubrics": [
        {"name": "Definition & Core Concept", "scored": 2.5, "max": 3.5},
        {"name": "Technical Terminology & Accuracy", "scored": 2.5, "max": 3.0},
        {"name": "Illustrative Example / Application", "scored": 1.5, "max": 2.5},
        {"name": "Clarity, Depth & Structure", "scored": 0.5, "max": 1.0},
      ],
      "keyEvidence": [
        "Identified transitive dependency X -> Y -> Z correctly in example table.",
      ],
      "missingPoints": [
        "Needs formal definition of BCNF comparison for full marks.",
      ],
    },
  ];

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  Future<void> _pickAnswerSheet() async {
    try {
      setState(() {
        _isPicking = true;
        _uploadError = null;
      });

      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      );

      if (file != null) {
        final size = file.lengthSync() ?? (await file.length()) ?? 0;
        if (size > 200 * 1024 * 1024) {
          setState(() {
            _uploadError = "File exceeds 200MB limit (${_formatFileSize(size)}). Please choose a smaller file.";
            _isPicking = false;
          });
        } else {
          setState(() {
            _uploadedFile = file;
            _uploadedFileSize = size;
            _uploadError = null;
            _isPicking = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Attached: ${file.name} (${_formatFileSize(size)})"),
                backgroundColor: const Color(0xFF059669),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      } else {
        setState(() {
          _isPicking = false;
        });
      }
    } catch (e) {
      setState(() {
        _uploadError = "Failed to select file: $e";
        _isPicking = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _topicController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  void _showEvaluationDetailsModal(Map<String, dynamic> item) {
    int activeDetailTab = 0; // 0: Key Evidence Detected, 1: Missing Points / Gaps

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setModalState) {
          final rubrics = item["rubrics"] as List<dynamic>;
          final keyEvidence = item["keyEvidence"] as List<dynamic>;
          final missingPoints = item["missingPoints"] as List<dynamic>;

          Color statusBg = const Color(0xFFECFDF5);
          Color statusTextColor = const Color(0xFF059669);
          if (item["status"] == "Faculty Overridden") {
            statusBg = const Color(0xFFEEF2FF);
            statusTextColor = const Color(0xFF4F46E5);
          } else if (item["status"] == "Pending") {
            statusBg = const Color(0xFFFFFBEB);
            statusTextColor = const Color(0xFFD97706);
          }

          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 580, maxHeight: 720),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "AK",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF4338CA),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item["studentName"] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item["rollNo"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF475569),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusBg,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item["status"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: statusTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${item["title"]} · Evaluated by ${item["faculty"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.pop(ctx),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 18,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),

                  // Dialog Scrollable Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Marks Awarded & AI Confidence Box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF9F5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFEFE8DC)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MARKS AWARDED",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${item["marksAwarded"]} ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/ ${item["totalMarks"]}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "AI CONFIDENCE",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "${item["aiConfidence"]}%",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF0D9488),
                                      ),
                                    ),
                                    Text(
                                      item["confidenceNote"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 2. Assessment Question
                          Text(
                            "ASSESSMENT QUESTION",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              item["question"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 3. Faculty Remarks
                          Text(
                            "FACULTY REMARKS",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              item["remarks"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 4. Student Handwritten Answer (OCR Transcribed)
                          Text(
                            "STUDENT HANDWRITTEN ANSWER (OCR TRANSCRIBED)",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF9F5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFEFE8DC)),
                            ),
                            child: Text(
                              item["transcription"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                height: 1.45,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 5. Rubric Criteria Evaluation
                          Text(
                            "RUBRIC CRITERIA EVALUATION",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              children: rubrics.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final r = entry.value as Map<String, dynamic>;
                                final isLast = idx == rubrics.length - 1;

                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: isLast
                                        ? null
                                        : const Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          r["name"] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF1E293B),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${r["scored"]} / ${r["max"]} marks",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // 6. Evidence / Gaps Tabs
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setModalState(() {
                                    activeDetailTab = 0;
                                  });
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: activeDetailTab == 0 ? const Color(0xFFF0FDF4) : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: activeDetailTab == 0 ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_rounded, size: 14, color: activeDetailTab == 0 ? const Color(0xFF059669) : const Color(0xFF64748B)),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Key Evidence Detected",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: activeDetailTab == 0 ? const Color(0xFF059669) : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setModalState(() {
                                    activeDetailTab = 1;
                                  });
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: activeDetailTab == 1 ? const Color(0xFFFFF7ED) : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: activeDetailTab == 1 ? const Color(0xFFF97316) : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.close_rounded, size: 14, color: activeDetailTab == 1 ? const Color(0xFFEA580C) : const Color(0xFF64748B)),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Missing Points / Gaps",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: activeDetailTab == 1 ? const Color(0xFFEA580C) : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Tab Content Container
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (activeDetailTab == 0 ? keyEvidence : missingPoints).map((point) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Icon(
                                          activeDetailTab == 0 ? Icons.check_circle_rounded : Icons.info_outline_rounded,
                                          size: 13,
                                          color: activeDetailTab == 0 ? const Color(0xFF059669) : const Color(0xFFEA580C),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          point.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            height: 1.45,
                                            color: const Color(0xFF334155),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Dialog Footer
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          ),
                          child: Text(
                            "Close",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Handwritten Evaluation",
      category: "Assessment",
      onBack: widget.onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Assessment  ›  Handwritten Evaluation",
          category: "Assessment",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.edit_outlined,
          title: "Handwritten Evaluation",
          subtitle: "Upload an answer sheet — OCR, question mapping, rubric scoring and improvement feedback.",
          watermarkIcon: Icons.draw_outlined,
        ),
        const SizedBox(height: 16),

        // 2. Alert notice banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFFD97706), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "AI scores are suggestions with a confidence value. Faculty review and can override every mark; all overrides are audit-logged.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Tab Buttons Row matching Image 1
        LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool canFitSideBySide = width >= 860;

            final tabsBar = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tab 0: Practice & Self-Evaluation
                  InkWell(
                    onTap: () => setState(() => _activeTab = 0),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.5),
                      decoration: BoxDecoration(
                        color: _activeTab == 0 ? const Color(0xFF141938) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _activeTab == 0 ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
                          width: _activeTab == 0 ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 15,
                            color: _activeTab == 0 ? Colors.white : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            "Practice & Self-Evaluation",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: _activeTab == 0 ? FontWeight.w600 : FontWeight.w500,
                              color: _activeTab == 0 ? Colors.white : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Tab 1: My Evaluated Sheets 4 (Selected in Image 1)
                  InkWell(
                    onTap: () => setState(() => _activeTab = 1),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.5),
                      decoration: BoxDecoration(
                        color: _activeTab == 1 ? const Color(0xFF141938) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _activeTab == 1 ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
                          width: _activeTab == 1 ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 15,
                            color: _activeTab == 1 ? Colors.white : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            "My Evaluated Sheets",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: _activeTab == 1 ? FontWeight.w600 : FontWeight.w500,
                              color: _activeTab == 1 ? Colors.white : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E3A8C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${_evaluatedSheets.length}",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

            final subtitleText = Text(
              "Showing your evaluated answer sheets and faculty feedback",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF94A3B8),
              ),
            );

            if (canFitSideBySide) {
              return Row(
                children: [
                  tabsBar,
                  const Spacer(),
                  subtitleText,
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabsBar,
                  const SizedBox(height: 8),
                  subtitleText,
                ],
              );
            }
          },
        ),
        const SizedBox(height: 18),

        // 4. Tab Views
        if (_activeTab == 0) ...[
          // Tab 0: Practice & Self-Evaluation Form View
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 750;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildUploadCard()),
                    const SizedBox(width: 18),
                    Expanded(child: _buildResultPane()),
                  ],
                );
              }
              return Column(
                children: [
                  _buildUploadCard(),
                  const SizedBox(height: 18),
                  _buildResultPane(),
                ],
              );
            },
          ),
        ] else ...[
          // Tab 1: My Evaluated Sheets (Image 1)
          _buildMyEvaluatedSheetsView(),
        ],
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TAB 1: MY EVALUATED SHEETS VIEW (Image 1)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildMyEvaluatedSheetsView() {
    // KPI Calculations
    final total = _evaluatedSheets.length;
    final verified = _evaluatedSheets.where((s) => s["status"] != "Pending").length;
    final reviewed = verified;
    double sumPct = 0;
    for (final s in _evaluatedSheets) {
      sumPct += (s["percentage"] as num);
    }
    final int avgPct = total > 0 ? (sumPct / total).round() : 85;

    // Filter logic
    final filtered = _evaluatedSheets.where((item) {
      if (_selectedStatus != "All Statuses" && item["status"] != _selectedStatus) {
        return false;
      }
      if (_selectedAssessment != "All Assessments (4)") {
        final q = _selectedAssessment.toLowerCase();
        final title = (item["title"] as String).toLowerCase();
        final question = (item["question"] as String).toLowerCase();
        if (!title.contains(q) && !question.contains(q)) {
          return false;
        }
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final title = (item["title"] as String).toLowerCase();
        final question = (item["question"] as String).toLowerCase();
        final remarks = (item["remarks"] as String).toLowerCase();
        if (!title.contains(q) && !question.contains(q) && !remarks.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Four KPI Metric Cards (Image 1)
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 880;
            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.description_outlined,
                      iconBg: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF475569),
                      title: "Total Evaluated",
                      value: "$total",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.school_outlined,
                      iconBg: const Color(0xFFECFDF5),
                      iconColor: const Color(0xFF059669),
                      title: "Verified by Faculty",
                      value: "$verified",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.military_tech_outlined,
                      iconBg: const Color(0xFFF0F9FF),
                      iconColor: const Color(0xFF0284C7),
                      title: "Average Score",
                      value: "$avgPct%",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.check_rounded,
                      iconBg: const Color(0xFFFFFBEB),
                      iconColor: const Color(0xFFD97706),
                      title: "Completed / Reviewed",
                      value: "$reviewed",
                    ),
                  ),
                ],
              );
            } else {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: (constraints.maxWidth - 12) / 2,
                    child: _buildKpiCard(
                      icon: Icons.description_outlined,
                      iconBg: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF475569),
                      title: "Total Evaluated",
                      value: "$total",
                    ),
                  ),
                  SizedBox(
                    width: (constraints.maxWidth - 12) / 2,
                    child: _buildKpiCard(
                      icon: Icons.school_outlined,
                      iconBg: const Color(0xFFECFDF5),
                      iconColor: const Color(0xFF059669),
                      title: "Verified by Faculty",
                      value: "$verified",
                    ),
                  ),
                  SizedBox(
                    width: (constraints.maxWidth - 12) / 2,
                    child: _buildKpiCard(
                      icon: Icons.military_tech_outlined,
                      iconBg: const Color(0xFFF0F9FF),
                      iconColor: const Color(0xFF0284C7),
                      title: "Average Score",
                      value: "$avgPct%",
                    ),
                  ),
                  SizedBox(
                    width: (constraints.maxWidth - 12) / 2,
                    child: _buildKpiCard(
                      icon: Icons.check_rounded,
                      iconBg: const Color(0xFFFFFBEB),
                      iconColor: const Color(0xFFD97706),
                      title: "Completed / Reviewed",
                      value: "$reviewed",
                    ),
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 18),

        // 2. Search and Filter Bar (Image 1)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: LayoutBuilder(
            builder: (context, barConstraints) {
              final isBarWide = barConstraints.maxWidth >= 720;

              final searchField = Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim();
                    });
                  },
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF94A3B8)),
                    hintText: "Search topic, assessment..",
                    hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: InputBorder.none,
                  ),
                ),
              );

              final statusDropdown = Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                    items: ["All Statuses", "Approved", "Faculty Overridden", "Pending"].map((s) {
                      return DropdownMenuItem<String>(
                        value: s,
                        child: Text(s),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedStatus = val);
                      }
                    },
                  ),
                ),
              );

              final assessmentDropdown = Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAssessment,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                    items: [
                      "All Assessments (4)",
                      "Compiler design",
                      "Data Structures",
                      "Integration test",
                      "DBMS",
                    ].map((s) {
                      return DropdownMenuItem<String>(
                        value: s,
                        child: Text(s),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedAssessment = val);
                      }
                    },
                  ),
                ),
              );

              if (isBarWide) {
                return Row(
                  children: [
                    Expanded(flex: 3, child: searchField),
                    const SizedBox(width: 10),
                    Expanded(flex: 2, child: statusDropdown),
                    const SizedBox(width: 10),
                    Expanded(flex: 2, child: assessmentDropdown),
                  ],
                );
              } else {
                return Column(
                  children: [
                    searchField,
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: statusDropdown),
                        const SizedBox(width: 8),
                        Expanded(child: assessmentDropdown),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
        const SizedBox(height: 14),

        // 3. Evaluated Sheet Cards List (Image 1)
        if (filtered.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Text(
                "No evaluated sheets match your filters.",
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, idx) {
              return _buildEvaluatedSheetCard(filtered[idx]);
            },
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // KPI Card Widget
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildKpiCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Evaluated Sheet Card (Image 1)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildEvaluatedSheetCard(Map<String, dynamic> item) {
    Color statusBg = const Color(0xFFECFDF5);
    Color statusTextColor = const Color(0xFF059669);
    if (item["status"] == "Faculty Overridden") {
      statusBg = const Color(0xFFEEF2FF);
      statusTextColor = const Color(0xFF4F46E5);
    } else if (item["status"] == "Pending") {
      statusBg = const Color(0xFFFFFBEB);
      statusTextColor = const Color(0xFFD97706);
    }

    final hasRemarks = item["remarks"] != null && (item["remarks"] as String).isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCardWide = constraints.maxWidth >= 600;

          final leftInfo = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar AK
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "AK",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4338CA),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Student name + roll + status badge
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          item["studentName"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item["rollNo"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: statusTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Topic / Assessment title
                    Text(
                      item["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Question subtext
                    Text(
                      item["question"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),

                    // Faculty remarks speech bubble
                    if (hasRemarks && item["status"] != "Pending") ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.chat_bubble_outline_rounded, size: 12, color: Color(0xFF64748B)),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                item["remarks"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xFF475569),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );

          final rightScore = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${item["marksAwarded"]} ",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: "/ ${item["totalMarks"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "${item["percentage"]}% score",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F766E),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              OutlinedButton.icon(
                onPressed: () => _showEvaluationDetailsModal(item),
                icon: const Icon(Icons.visibility_outlined, size: 13),
                label: const Text("View Details"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF0F766E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          );

          if (isCardWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: leftInfo),
                const SizedBox(width: 16),
                rightScore,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leftInfo,
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: rightScore,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TAB 0: PRACTICE & SELF-EVALUATION
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildUploadCard() {
    final isPdf = _uploadedFile?.extension?.toLowerCase() == 'pdf';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
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
          Text(
            "Upload student answer sheet",
            style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.ink),
          ),
          Text(
            "PDF, PNG or JPG · up to 200 MB",
            style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3),
          ),
          const SizedBox(height: 14),

          // Upload Zone / File Selected View
          if (_uploadedFile == null)
            InkWell(
              onTap: _isPicking ? null : _pickAnswerSheet,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.veryLightBlue,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _uploadError != null ? const Color(0xFFEF4444) : AppColors.border,
                    width: 1.2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: _isPicking
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation(AppColors.primaryBlue),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Opening mobile file picker...",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.ink2,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.upload_rounded, color: AppColors.primaryBlue, size: 26),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Drop student answer sheet or click to upload",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Files are type-checked and enhanced for OCR (Max 200MB)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.ink3,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF86EFAC), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isPdf ? const Color(0xFFFEE2E2) : const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                      color: isPdf ? const Color(0xFFDC2626) : const Color(0xFF2563EB),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _uploadedFile!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              _formatFileSize(_uploadedFileSize),
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569),
                              ),
                            ),
                            const Text(" · ", style: TextStyle(color: Color(0xFF94A3B8))),
                            Text(
                              "Ready for OCR",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: "Remove file",
                    icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                    onPressed: () {
                      setState(() {
                        _uploadedFile = null;
                        _uploadedFileSize = 0;
                        _uploadError = null;
                      });
                    },
                  ),
                ],
              ),
            ),

          if (_uploadError != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: Color(0xFFDC2626), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _uploadError!,
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFB91C1C)),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 18),
          _inputLabel("Student Name"),
          _customTextField(_nameController, "e.g. Anand Kumar"),
          const SizedBox(height: 12),
          _inputLabel("Roll / Register Number"),
          _customTextField(_rollController, "e.g. 110124001"),
          const SizedBox(height: 12),
          _inputLabel("Assessment Question / Topic"),
          _customTextField(_topicController, "e.g. Compiler Design"),
          const SizedBox(height: 12),
          _inputLabel("Total Marks"),
          _customTextField(_marksController, "e.g. 10"),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _hasSampleEvaluated = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Answer sheet evaluated successfully!"),
                    backgroundColor: Color(0xFF059669),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.auto_awesome_rounded, size: 16),
              label: Text("Evaluate Sheet with AI", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPane() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("AI Rubric Evaluation", style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppColors.ink)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(8)),
                child: Text("Confidence: 94%", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF15803D))),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.veryLightBlue, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _scoreItem("Proposed", _hasSampleEvaluated ? "9.0 / 10" : "8.5 / 10", AppColors.primaryBlue),
                _scoreItem("Max Score", "10", AppColors.ink),
                _scoreItem("Rubric Fit", "High", const Color(0xFF059669)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text("OCR Transcribed Answer", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Text(
              "Normalization removes update anomalies by decomposing tables into BCNF/3NF. Every determinant must be a super key for Boyce-Codd normal form.",
              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink2, height: 1.4),
            ),
          ),
          const SizedBox(height: 16),

          Text("Rubric Breakdown", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 8),
          _rubricRow("Definition & Core Concept", "3.5 / 3.5"),
          _rubricRow("Technical Terminology & Accuracy", "3.0 / 3.0"),
          _rubricRow("Illustrative Example / Application", "2.0 / 2.5"),
          _rubricRow("Clarity, Depth & Structure", "0.5 / 1.0"),
        ],
      ),
    );
  }

  Widget _scoreItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.ink3)),
      ],
    );
  }

  Widget _rubricRow(String label, String marks) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink2))),
          Text(marks, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.ink)),
        ],
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.ink)),
    );
  }

  Widget _customTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 12.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.border)),
      ),
    );
  }
}




/// ─────────────────────────────────────────────────────────────────────────────
/// 2. Viva Simulator Screen (Image 2)
/// ─────────────────────────────────────────────────────────────────────────────
class VivaSimulatorScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const VivaSimulatorScreen({super.key, this.onBack});

  @override
  State<VivaSimulatorScreen> createState() => _VivaSimulatorScreenState();
}

class _VivaSimulatorScreenState extends State<VivaSimulatorScreen> {
  // Session Mode
  bool _isInViva = false;

  // Setup Form
  String _vivaType = "Subject"; // "Subject", "Project", "Technical"
  String _selectedSubject = "Advanced Java";
  final TextEditingController _unitController = TextEditingController();
  String _level = "Standard";
  String _numQuestions = "5 questions";

  // Active Viva State
  int _currentQuestionIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  final List<String> _currentQuestions = [
    "Explain Core Principles & Architecture in your own words.",
    "What is the difference between JVM, JRE, and JDK in enterprise applications?",
    "How does Garbage Collection work with Generation algorithms in HotSpot JVM?",
    "Explain the Thread lifecycle and how synchronized blocks avoid race conditions.",
    "How do Spring IoC and Dependency Injection reduce coupling in microservices?",
  ];
  final List<String> _submittedAnswers = [];
  int _totalQuestionsCount = 5;

  // History & Stats
  final List<Map<String, dynamic>> _vivaHistory = [
    {
      "id": "VH-01",
      "title": "Database Manag...",
      "fullTitle": "Database Management Systems",
      "meta": "Subject · Standard · 13 Oct · 5/5 answered",
      "badge": "Not marked",
      "badgeType": "neutral",
      "score": null,
    },
    {
      "id": "VH-02",
      "title": "Smart Campus Real-Ti...",
      "fullTitle": "Smart Campus Real-Time Sensor Hub",
      "meta": "Project · Standard · 9 Oct · 5/5 answered",
      "badge": "20%",
      "badgeType": "bad",
      "score": 20,
    },
    {
      "id": "VH-03",
      "title": "Solar-Powered Edge-AI ...",
      "fullTitle": "Solar-Powered Edge-AI Mesh Node",
      "meta": "Project · Tough · 9 Oct · 5/5 answered",
      "badge": "98%",
      "badgeType": "good",
      "score": 98,
    },
    {
      "id": "VH-04",
      "title": "AI Ethics, Bias, and Gove...",
      "fullTitle": "AI Ethics, Bias, and Governance",
      "meta": "Subject · Standard · 6 Oct · 1/5 answered",
      "badge": "90%",
      "badgeType": "info",
      "score": 90,
    },
  ];

  @override
  void dispose() {
    _unitController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _startViva() {
    int count = int.tryParse(_numQuestions.split(" ")[0]) ?? 5;
    setState(() {
      _totalQuestionsCount = count;
      _currentQuestionIndex = 0;
      _submittedAnswers.clear();
      _answerController.clear();
      _isInViva = true;
    });
  }

  void _submitAnswer() {
    final ans = _answerController.text.trim();
    setState(() {
      _submittedAnswers.add(ans.isNotEmpty ? ans : "(Skipped)");
      if (_currentQuestionIndex + 1 < _totalQuestionsCount &&
          _currentQuestionIndex + 1 < _currentQuestions.length) {
        _currentQuestionIndex++;
        _answerController.clear();
      } else {
        _finishViva();
      }
    });
  }

  void _skipQuestion() {
    setState(() {
      _submittedAnswers.add("(Skipped)");
      if (_currentQuestionIndex + 1 < _totalQuestionsCount &&
          _currentQuestionIndex + 1 < _currentQuestions.length) {
        _currentQuestionIndex++;
        _answerController.clear();
      } else {
        _finishViva();
      }
    });
  }

  void _finishViva() {
    setState(() {
      _isInViva = false;
      // Add to history
      _vivaHistory.insert(0, {
        "id": "VH-${DateTime.now().millisecondsSinceEpoch}",
        "title": _selectedSubject.length > 20
            ? "${_selectedSubject.substring(0, 18)}..."
            : _selectedSubject,
        "fullTitle": _selectedSubject,
        "meta":
            "$_vivaType · $_level · Just now · ${_submittedAnswers.length}/$_totalQuestionsCount answered",
        "badge": "85%",
        "badgeType": "good",
        "score": 85,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Viva completed successfully! Evaluator feedback saved to history."),
        backgroundColor: Color(0xFF15803D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Viva Simulator",
      category: "Assessment",
      onBack: widget.onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Assessment  ›  Viva Simulator",
          category: "ASSESSMENT",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.mic_none_outlined,
          title: "Viva Simulator",
          subtitle:
              "Project, subject and technical viva: an examiner asks, marks each answer and follows up.",
          watermarkIcon: Icons.mic_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive Two Column View (Main Viva Card + Right Sidebar)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 880;

            final mainContent = _isInViva ? _buildActiveVivaCard() : _buildStartVivaCard();
            final sidebarContent = _buildSidebar();

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: mainContent),
                  const SizedBox(width: 18),
                  SizedBox(width: 310, child: sidebarContent),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  mainContent,
                  const SizedBox(height: 18),
                  sidebarContent,
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 1. START A VIVA SETUP CARD (Image 1)
  // ===========================================================================
  Widget _buildStartVivaCard() {
    return Container(
      padding: const EdgeInsets.all(22),
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
          Text(
            "Start a viva",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Answer one question at a time, like a real examiner sitting across from you",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // Section: Type of viva
          Text(
            "Type of viva",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          LayoutBuilder(
            builder: (context, cardConstraints) {
              final isWide = cardConstraints.maxWidth >= 540;
              final types = [
                {
                  "type": "Subject",
                  "desc": "Questions from one of your own subjects and its syllabus units.",
                },
                {
                  "type": "Project",
                  "desc": "The examiner questions you about your own project, like a project review.",
                },
                {
                  "type": "Technical",
                  "desc": "Any technical topic you choose, for interview-style questions.",
                },
              ];

              if (isWide) {
                return Row(
                  children: types.map((t) {
                    final isSel = _vivaType == t["type"];
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: t["type"] != "Technical" ? 10 : 0),
                        child: _vivaTypeCard(t["type"]!, t["desc"]!, isSel),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: types.map((t) {
                    final isSel = _vivaType == t["type"];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _vivaTypeCard(t["type"]!, t["desc"]!, isSel),
                    );
                  }).toList(),
                );
              }
            },
          ),
          const SizedBox(height: 18),

          // Section: Subject
          Text(
            "Subject",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSubject,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
                items: [
                  "Advanced Java",
                  "Database Management Systems",
                  "Operating Systems",
                  "Computer Networks",
                  "AI & Machine Learning",
                  "Compiler Design",
                ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSubject = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Section: Focus on a unit (optional)
          Text(
            "Focus on a unit (optional)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: _unitController,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: "Leave blank to cover the whole subject",
                hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Units: Core Principles & Architecture, Design & Analysis Methodology, Applications & Optimization, Advanced Implementations, Case Studies & Modern Trends",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18),

          // Section: Level & Number of questions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _level,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF0F172A)),
                          items: ["Beginner", "Standard", "Tough"]
                              .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _level = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "A normal university viva.",
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of questions",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _numQuestions,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF0F172A)),
                          items: ["3 questions", "5 questions", "10 questions"]
                              .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _numQuestions = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Disclaimer note
          Text(
            "The AI examiner marks each answer out of 10 and may ask follow-ups. AI marks are practice feedback, not an official grade, so check important points with your faculty.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          // Start viva Button
          ElevatedButton.icon(
            onPressed: _startViva,
            icon: const Icon(Icons.mic_rounded, size: 16, color: Colors.white),
            label: Text(
              "Start viva",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E3A8C),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vivaTypeCard(String title, String desc, bool isSelected) {
    return InkWell(
      onTap: () => setState(() => _vivaType = title),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 82,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8FAFC) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                desc,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFF64748B),
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. ACTIVE VIVA SCREEN (Image 2)
  // ===========================================================================
  Widget _buildActiveVivaCard() {
    final qNumber = _currentQuestionIndex + 1;
    final questionText = _currentQuestionIndex < _currentQuestions.length
        ? _currentQuestions[_currentQuestionIndex]
        : "Explain the implementation steps in detail.";
    final double progress = qNumber / _totalQuestionsCount;

    return Column(
      children: [
        // Top subject banner with progress
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedSubject,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        "$_vivaType viva · $_level · answers are not marked",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Question $qNumber of $_totalQuestionsCount",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF2E3A8C)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Examiner Question Card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Examiner pill
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Examiner",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Question $qNumber",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Question Text
              Text(
                questionText,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 18),

              // Label: Your answer
              Text(
                "Your answer",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),

              // Textarea
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  controller: _answerController,
                  minLines: 6,
                  maxLines: 8,
                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                  decoration: InputDecoration(
                    hintText: "Answer as you would out loud: define it, give an example, say why.",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.all(14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${_answerController.text.length}/2000 · Ctrl+Enter to send",
                style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 20),

              // Action Buttons Row
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submitAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF818CF8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Submit answer",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: _skipQuestion,
                    icon: const Icon(Icons.skip_next_outlined, size: 14),
                    label: const Text("Skip"),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      foregroundColor: const Color(0xFF334155),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _isInViva = false;
                      });
                    },
                    icon: const Icon(Icons.flag_outlined, size: 14, color: Color(0xFF64748B)),
                    label: Text(
                      "End viva",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. RIGHT SIDEBAR (Your vivas + History)
  // ===========================================================================
  Widget _buildSidebar() {
    return Column(
      children: [
        // Card 1: Your vivas
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your vivas",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "AI examiner",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Only completed vivas are counted",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 12),

              // 2x2 Grid of stats
              Row(
                children: [
                  Expanded(
                    child: _miniStatBox("Completed", "4"),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _miniStatBox("Best score", "98%"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _miniStatBox("Average", "69%"),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _miniStatBox("Latest", "—"),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 2: History
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "History",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                "Newest first",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 12),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _vivaHistory.length,
                separatorBuilder: (_, index) => const SizedBox(height: 8),
                itemBuilder: (context, idx) {
                  final h = _vivaHistory[idx];
                  return _historyItemCard(h);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniStatBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF9F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyItemCard(Map<String, dynamic> h) {
    Color badgeBg = const Color(0xFFF1F5F9);
    Color badgeText = const Color(0xFF475569);
    if (h["badgeType"] == "bad") {
      badgeBg = const Color(0xFFFEF2F2);
      badgeText = const Color(0xFFDC2626);
    } else if (h["badgeType"] == "good") {
      badgeBg = const Color(0xFFECFDF5);
      badgeText = const Color(0xFF059669);
    } else if (h["badgeType"] == "info") {
      badgeBg = const Color(0xFFEFF6FF);
      badgeText = const Color(0xFF2563EB);
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  h["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  h["meta"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              h["badge"] as String,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: badgeText,
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFF94A3B8)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 14,
            onPressed: () {
              setState(() {
                _vivaHistory.remove(h);
              });
            },
          ),
        ],
      ),
    );
  }
}


class CompetitiveExamsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CompetitiveExamsScreen({super.key, this.onBack});

  @override
  State<CompetitiveExamsScreen> createState() => _CompetitiveExamsScreenState();
}

class _CompetitiveExamsScreenState extends State<CompetitiveExamsScreen> {
  // Navigation Tabs
  int _selectedTabIndex = 0; // 0: My plan, 1: Syllabus & notes, 2: Daily test, 3: Topic practice, 4: Practice mocks, 5: English, 6: Current affairs, 7: Exams & eligibility
  final List<String> _tabs = [
    "My plan",
    "Syllabus & notes",
    "Daily test",
    "Topic practice",
    "Practice mocks",
    "English",
    "Current affairs",
    "Exams & eligibility"
  ];

  // Selected Target Exam for Syllabus Tab
  String _selectedSyllabusExam = "UPSC CSE (target)";
  final List<String> _syllabusExams = [
    "UPSC CSE (target)",
    "SSC CGL (target)",
    "GATE CSE",
    "Banking (IBPS / SBI)",
    "TNPSC Group 2"
  ];

  // Active Studying Topic View (null when in list mode)
  Map<String, dynamic>? _studyingTopic;

  // Active Live Test Mode (null when not in test)
  Map<String, dynamic>? _activeTest;
  int _currentTestQIndex = 0;
  final Map<int, int?> _testUserAnswers = {}; // questionIndex -> optionIndex
  int _testSecondsRemaining = 600; // 10 minutes
  Timer? _testTimer;

  @override
  void dispose() {
    _testTimer?.cancel();
    super.dispose();
  }

  // Track studied & practiced topics state
  final Set<String> _studiedTopics = {};
  final Set<String> _practicedTopics = {"Direction sense", "Data Structures & Asymptotic Analysis"};

  // Target Exams in "My Plan"
  final List<Map<String, dynamic>> _targetExams = [
    {
      "id": "upsc",
      "name": "UPSC CSE",
      "eligibility": "Not yet eligible",
      "note": "You can apply in your final year (you are in year 2).",
      "examDate": null,
      "readiness": 40,
      "tags": [
        {"label": "General Studies Paper I: 80%", "color": Color(0xFFCCFBF1), "textColor": Color(0xFF0F766E)},
        {"label": "CSAT (Paper II, qualifying): 20%", "color": Color(0xFFFEE2E2), "textColor": Color(0xFFB91C1C)},
      ]
    },
    {
      "id": "ssc",
      "name": "SSC CGL",
      "eligibility": "Not yet eligible",
      "note": "You can apply in your final year (you are in year 2).",
      "examDate": null,
      "readiness": 16,
      "tags": [
        {"label": "General Intelligence & Reasoning: 20%", "color": Color(0xFFFEE2E2), "textColor": Color(0xFFB91C1C)},
        {"label": "General Awareness: not practised", "color": Color(0xFFF1F5F9), "textColor": Color(0xFF64748B)},
        {"label": "Quantitative Aptitude: not practised", "color": Color(0xFFF1F5F9), "textColor": Color(0xFF64748B)},
        {"label": "English Comprehension: not practised", "color": Color(0xFFF1F5F9), "textColor": Color(0xFF64748B)},
      ]
    }
  ];

  // "Today" tasks state
  final Map<String, bool> _todayTasksChecked = {
    "Daily aptitude test": false,
    "Topic drill: Direction sense": false,
    "Word of the day: diligent": false,
    "This week's current-affairs quiz": false,
  };

  // Syllabus list data
  final List<Map<String, dynamic>> _generalStudiesTopics = [
    {
      "title": "Indian polity",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "General awareness",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "The Constitution of India came into force on: 26 January 1950.",
        "Fundamental Rights are listed in which Part of the Constitution: Part III.",
        "The Directive Principles of State Policy are in: Part IV.",
        "Article 21 guarantees: Protection of life and personal liberty.",
        "Dr B. R. Ambedkar called which Article the 'heart and soul' of the Constitution: Article 32.",
        "The President of India is elected by: An electoral college of elected MPs and elected MLAs.",
        "The maximum strength of the Rajya Sabha is: 250.",
        "The minimum age to become a member of the Lok Sabha is: 25 years.",
        "Who chaired the Drafting Committee of the Constituent Assembly: Dr B. R. Ambedkar.",
        "Fundamental Duties were added by the: 42nd Amendment (1976).",
        "Article 356 deals with: President's Rule in a State.",
        "The Governor of a State is appointed by the: President.",
        "A Money Bill can be introduced only in the: Lok Sabha.",
        "Constitutional status was given to Panchayati Raj by the: 73rd Amendment.",
        "The Right to Education is provided under: Article 21A.",
      ],
      "examTip": "Revise these facts again the day after you study them, and once more a week later."
    },
    {
      "title": "Indian history",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "History & Culture",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "Indus Valley Civilization was a Bronze Age civilization (2500 BCE - 1700 BCE).",
        "Maurya Empire was founded by Chandragupta Maurya with guidance from Chanakya.",
        "Ashoka embraced Buddhism after the Kalinga War in 261 BCE.",
        "Gupta Period is regarded as the Golden Age of ancient Indian history.",
        "First Battle of Panipat occurred in 1526, establishing Mughal rule by Babur.",
        "Revolt of 1857 started from Meerut and marked the end of Company Rule.",
        "Non-Cooperation Movement was launched by Mahatma Gandhi in 1920.",
        "Quit India Movement resolution was passed on 8 August 1942."
      ],
      "examTip": "Focus on timelines, reform movements, and constitutional development under British rule."
    },
    {
      "title": "Geography",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "Geography & Environment",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "Standard Meridian of India passes through Mirzapur (82°30' E).",
        "Southernmost point of mainland India is Cape Comorin (Kanyakumari).",
        "Himalayas are young fold mountains formed by Indo-Australian and Eurasian tectonic collision.",
        "Tropic of Cancer passes through 8 Indian states.",
        "Godavari is the longest river of peninsular India (Dakshin Ganga).",
        "Western Ghats is one of the world's eight biodiversity hotspots."
      ],
      "examTip": "Practice map-based questions for river tributaries, national parks, and mountain passes."
    },
    {
      "title": "Indian economy",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "Economics & Development",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "NITI Aayog replaced the Planning Commission on 1 January 2015.",
        "Monetary Policy Committee (MPC) is headed by the Governor of RBI.",
        "Fiscal Deficit is the excess of total expenditure over total receipts excluding borrowings.",
        "Goods and Services Tax (GST) came into effect on 1 July 2017 under the 101st Amendment.",
        "Headline Inflation in India is measured using the Consumer Price Index (CPI Combined)."
      ],
      "examTip": "Connect key static concepts with recent Union Budget numbers and Economic Survey trends."
    },
    {
      "title": "General science",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "Science & Tech",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "Mitochondria is known as the powerhouse of the cell due to ATP generation.",
        "Speed of light in vacuum is approximately 3 × 10^8 m/s.",
        "Ozone layer in the stratosphere protects Earth from harmful UV-B radiation.",
        "pH of pure water is 7, human blood is slightly alkaline around 7.4.",
        "ISRO successfully landed Chandrayaan-3 near the lunar South Pole."
      ],
      "examTip": "Emphasize daily science applications, biotechnology breakthroughs, and space missions."
    },
    {
      "title": "Tamil Nadu history & culture",
      "status": "Not started",
      "answersCount": "No answers yet",
      "category": "Regional Culture",
      "isFaculty": false,
      "isCollegeAdded": false,
      "notes": [
        "Sangam literature flourished under the patronage of Pandya kings.",
        "Thiruvalluvar authored the revered ethical work Thirukkural containing 1330 couplets.",
        "Brihadisvara Temple at Thanjavur was built by Raja Raja Chola I (1010 CE).",
        "Self-Respect Movement was founded by Periyar E. V. Ramasamy in 1925."
      ],
      "examTip": "Memorize Sangam archeological sites (Keezhadi) and major temple architecture styles."
    },
    {
      "title": "Data Structures & Asymptotic Analysis",
      "status": "Strong",
      "answersCount": "80% of 10 answers",
      "category": "Core Engineering & CS",
      "isFaculty": true,
      "isCollegeAdded": true,
      "notes": [
        "Big-O notation specifies an asymptotic upper bound on function growth.",
        "Binary Search requires a sorted collection with O(log n) worst-case time complexity.",
        "Hash tables provide average O(1) lookups, with chaining or open addressing for collisions.",
        "Dijkstra's algorithm solves single-source shortest path using a min-priority queue in O(E + V log V).",
        "AVL Trees maintain strict height balance with balance factors in {-1, 0, 1}."
      ],
      "examTip": "Master recurrence relations using Master Theorem and worst vs amortized complexity."
    },
  ];

  final List<Map<String, dynamic>> _csatTopics = [
    {"title": "Percentage", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Profit, loss & discount", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Simple & compound interest", "status": "Not started", "answersCount": "No answers yet", "isFaculty": true},
    {"title": "Time & work", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Time, speed & distance", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Ratio, proportion & mixtures", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Averages & ages", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Number system & LCM", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Number series", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Letter & number series", "status": "Not started", "answersCount": "No answers yet", "isFaculty": false},
    {"title": "Coding-decoding", "status": "Not started", "answersCount": "No answers yet", "isFaculty": true},
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Competitive Exam Prep Hub",
      category: "Assessment",
      onBack: widget.onBack,
      children: [
        // 1. Blueprint Hero Banner (only if not in active test)
        if (_activeTest == null) ...[
          const BlueprintHeroBanner(
            breadcrumb: "Home  ›  Assessment  ›  Competitive Exam Prep Hub",
            category: "ASSESSMENT",
            phase: "MVP",
            icon: Icons.emoji_events_outlined,
            title: "Competitive Exam Prep Hub",
            subtitle:
                "Your personal guide for UPSC, SSC, banking, railways, TNPSC, defence, teaching eligibility and UG / PG entrance exams: eligibility check, daily aptitude test, topic drills, English, practice mocks and current affairs.",
            watermarkIcon: Icons.emoji_events_rounded,
          ),
          const SizedBox(height: 16),
        ],

        // 2. Indicative Notice Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 18, color: Color(0xFF92400E)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Exam patterns and eligibility are indicative. Always confirm dates, eligibility and age limits in the official notification.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF92400E),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Mode Check: Live Test Mode (Image 1)
        if (_activeTest != null) ...[
          _buildLiveTestScreen(),
        ]
        // Mode Check: Topic Study Mode (Image 5 from previous batch)
        else if (_studyingTopic != null) ...[
          _buildTopicStudyView(_studyingTopic!),
        ]
        // Mode Check: Hub View with Tabs
        else ...[
          _buildCapsuleTabBar(),
          const SizedBox(height: 18),
          _buildTabContent(),
        ],
      ],
    );
  }

  // --- TAB BAR ---
  Widget _buildCapsuleTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (idx) {
            final isSelected = _selectedTabIndex == idx;
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: InkWell(
                onTap: () {
                  _testTimer?.cancel();
                  setState(() {
                    _selectedTabIndex = idx;
                    _studyingTopic = null;
                    _activeTest = null;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? Border.all(color: const Color(0xFFD97706), width: 1.4)
                        : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    _tabs[idx],
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // --- TAB CONTENT DISPATCHER ---
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildMyPlanTab();
      case 1:
        return _buildSyllabusTab();
      case 2:
        return _buildDailyTestTab();
      case 3:
        return _buildTopicPracticeTab();
      case 4:
        return _buildPracticeMocksTab();
      case 5:
        return _buildEnglishTab();
      case 6:
        return _buildCurrentAffairsTab();
      case 7:
        return _buildExamsEligibilityTab();
      default:
        return _buildMyPlanTab();
    }
  }

  // ===========================================================================
  // LIVE TEST / PRACTICE QUIZ SCREEN (Image 1)
  // ===========================================================================
  Widget _buildLiveTestScreen() {
    final title = _activeTest!["title"] as String;
    final questions = (_activeTest!["questions"] as List<Map<String, dynamic>>);
    final totalQ = questions.length;
    final currentQ = questions[_currentTestQIndex];
    final options = (currentQ["options"] as List<String>);
    final currentAns = _testUserAnswers[_currentTestQIndex];
    final answeredCount = _testUserAnswers.values.where((v) => v != null).length;

    final minutes = (_testSecondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_testSecondsRemaining % 60).toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Header Bar (Responsive Layout to prevent overflow)
        LayoutBuilder(
          builder: (context, headerConstraints) {
            final timerAndLeave = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF0F172A)),
                      const SizedBox(width: 6),
                      Text(
                        "$minutes:$seconds",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Leave Test?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                        content: Text("Are you sure you want to leave this test? Your answers will not be saved.", style: GoogleFonts.poppins()),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Stay")),
                          ElevatedButton(
                            onPressed: () {
                              _testTimer?.cancel();
                              Navigator.pop(ctx);
                              setState(() => _activeTest = null);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
                            child: const Text("Leave", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "Leave",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            );

            if (headerConstraints.maxWidth < 480) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  timerAndLeave,
                  const SizedBox(height: 8),
                  Text(
                    "$totalQ questions with explanations at the end. No negative marking in practice.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );
            }

            if (headerConstraints.maxWidth < 720) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      timerAndLeave,
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$totalQ questions with explanations at the end. No negative marking in practice.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "$totalQ questions with explanations at the end. No negative marking in practice.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                timerAndLeave,
              ],
            );
          },
        ),
        const SizedBox(height: 18),

        // Two Column Layout: Left Question Card & Right Palette Card
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _buildQuestionCard(currentQ, options, currentAns, totalQ)),
                  const SizedBox(width: 18),
                  Expanded(flex: 3, child: _buildPaletteCard(totalQ, answeredCount)),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildQuestionCard(currentQ, options, currentAns, totalQ),
                  const SizedBox(height: 18),
                  _buildPaletteCard(totalQ, answeredCount),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> currentQ, List<String> options, int? currentAns, int totalQ) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Text(
            "Question ${_currentTestQIndex + 1} of $totalQ",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: const Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 16),

          // Question prompt
          Text(
            currentQ["prompt"] as String,
            style: GoogleFonts.poppins(
              fontSize: 16.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Option Tiles
          ...List.generate(options.length, (optIdx) {
            final optLetter = String.fromCharCode(65 + optIdx); // A, B, C, D
            final isSelected = currentAns == optIdx;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _testUserAnswers[_currentTestQIndex] = optIdx;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          optLetter,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          options[optIdx],
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),

          // Action Navigation Row
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              // Previous
              InkWell(
                onTap: _currentTestQIndex > 0
                    ? () => setState(() => _currentTestQIndex--)
                    : null,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 6),
                      Text(
                        "Previous",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: _currentTestQIndex > 0 ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Clear Answer
              InkWell(
                onTap: () {
                  setState(() {
                    _testUserAnswers.remove(_currentTestQIndex);
                  });
                },
                child: Text(
                  "Clear answer",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),

              // Next
              InkWell(
                onTap: _currentTestQIndex < totalQ - 1
                    ? () => setState(() => _currentTestQIndex++)
                    : null,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Next",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaletteCard(int totalQ, int answeredCount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$answeredCount of $totalQ answered",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // Palette buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(totalQ, (i) {
              final isCurrent = _currentTestQIndex == i;
              final isAnswered = _testUserAnswers.containsKey(i) && _testUserAnswers[i] != null;

              return InkWell(
                onTap: () => setState(() => _currentTestQIndex = i),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isAnswered
                        ? const Color(0xFF10B981)
                        : (isCurrent ? Colors.white : const Color(0xFFF1F5F9)),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCurrent
                          ? const Color(0xFF1E3A8A)
                          : (isAnswered ? const Color(0xFF059669) : const Color(0xFFCBD5E1)),
                      width: isCurrent ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    "${i + 1}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: isCurrent || isAnswered ? FontWeight.w700 : FontWeight.w500,
                      color: isAnswered ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Submit test button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitActiveTest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Submit test",
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitActiveTest() {
    _testTimer?.cancel();
    final title = _activeTest!["title"] as String;
    final questions = (_activeTest!["questions"] as List<Map<String, dynamic>>);
    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_testUserAnswers[i] == questions[i]["correct"]) {
        correctCount++;
      }
    }
    final scorePercent = ((correctCount / questions.length) * 100).toInt();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Color(0xFF10B981)),
            const SizedBox(width: 8),
            Text("Test Completed", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Topic: $title", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Text("Score: $correctCount / ${questions.length} ($scorePercent%)", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF1E3A8A))),
            const SizedBox(height: 8),
            Text("Your readiness and syllabus tracker have been updated with this attempt.", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _practicedTopics.add(title);
                _activeTest = null;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A)),
            child: const Text("Done", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _startLiveTest(String title) {
    _testTimer?.cancel();
    _testSecondsRemaining = 600;
    _testTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_testSecondsRemaining > 0) {
        setState(() {
          _testSecondsRemaining--;
        });
      } else {
        timer.cancel();
        if (_activeTest != null) {
          _submitActiveTest();
        }
      }
    });

    setState(() {
      _activeTest = {
        "title": title,
        "questions": [
          {
            "prompt": "The minimum age to become a member of the Lok Sabha is",
            "options": ["30 years", "21 years", "25 years", "35 years"],
            "correct": 2, // 25 years
          },
          {
            "prompt": "Which Article of the Constitution of India is known as the 'heart and soul' of the Constitution?",
            "options": ["Article 19", "Article 21", "Article 32", "Article 14"],
            "correct": 2, // Article 32
          },
          {
            "prompt": "In which part of the Constitution are Fundamental Rights enumerated?",
            "options": ["Part II", "Part III", "Part IV", "Part IV-A"],
            "correct": 1, // Part III
          },
          {
            "prompt": "What is the maximum sanctioned strength of the Rajya Sabha?",
            "options": ["245", "250", "252", "260"],
            "correct": 1, // 250
          },
          {
            "prompt": "The Right to Education was incorporated under which Article via the 86th Amendment?",
            "options": ["Article 21A", "Article 19B", "Article 31C", "Article 45A"],
            "correct": 0, // Article 21A
          },
          {
            "prompt": "Who acts as the ex-officio Chairman of the Rajya Sabha?",
            "options": ["The President", "The Vice-President", "The Prime Minister", "The Chief Justice"],
            "correct": 1, // Vice-President
          },
          {
            "prompt": "A Money Bill can be introduced exclusively in which house?",
            "options": ["Rajya Sabha", "Lok Sabha", "Joint Session only", "Either House"],
            "correct": 1, // Lok Sabha
          },
          {
            "prompt": "The Directive Principles of State Policy are borrowed from the constitution of which country?",
            "options": ["USA", "Ireland", "Australia", "Canada"],
            "correct": 1, // Ireland
          },
          {
            "prompt": "Article 356 of the Constitution deals with:",
            "options": ["National Emergency", "Financial Emergency", "President's Rule in a State", "Constitutional Amendments"],
            "correct": 2, // President's Rule
          },
          {
            "prompt": "Which Constitutional Amendment added Fundamental Duties to the Indian Constitution?",
            "options": ["42nd Amendment (1976)", "44th Amendment (1978)", "73rd Amendment (1992)", "86th Amendment (2002)"],
            "correct": 0, // 42nd Amendment
          },
        ]
      };
      _currentTestQIndex = 0;
      _testUserAnswers.clear();
      _testSecondsRemaining = 600;
    });
  }

  // ===========================================================================
  // TAB 0: MY PLAN
  // ===========================================================================
  Widget _buildMyPlanTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGuideHeaderCard(),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _buildTargetExamsCard()),
                  const SizedBox(width: 18),
                  Expanded(flex: 4, child: _buildTodayCard()),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildTargetExamsCard(),
                  const SizedBox(height: 18),
                  _buildTodayCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _buildWeakTopicsCard()),
                  const SizedBox(width: 18),
                  Expanded(flex: 5, child: _buildNext7DaysCard()),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildWeakTopicsCard(),
                  const SizedBox(height: 18),
                  _buildNext7DaysCard(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildGuideHeaderCard() {
    final days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 650;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "B.E. Computer Science & Engineering · Semester 3 · year 2",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Your exam preparation guide",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.spa_outlined, size: 16, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                "Start a streak today · best 1 · 50% accuracy over 20 questions",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!isCompact) ...[
                    const SizedBox(width: 20),
                    _buildStreakBoxes(days),
                  ],
                ],
              ),
              if (isCompact) ...[
                const SizedBox(height: 16),
                _buildStreakBoxes(days),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildStreakBoxes(List<String> days) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: days.map((day) {
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  day,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTargetExamsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My target exams",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              InkWell(
                onTap: _showChangeTargetExamsDialog,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.settings_outlined, size: 14, color: Color(0xFF475569)),
                      const SizedBox(width: 4),
                      Text(
                        "Change",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Up to 3. Enter the exam date you are aiming for, from the official notification.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ..._targetExams.map((exam) => _buildTargetExamItem(exam)),
        ],
      ),
    );
  }

  Widget _buildTargetExamItem(Map<String, dynamic> exam) {
    final tags = (exam["tags"] as List<dynamic>?) ?? [];
    final readiness = exam["readiness"] as int;
    final dateStr = exam["examDate"] != null ? exam["examDate"] as String : "No date set";

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exam["name"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exam["eligibility"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            exam["note"] as String,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                dateStr,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 14),
              InkWell(
                onTap: () => _showSetDateDialog(exam),
                child: Text(
                  "Set date",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Readiness (estimate from your practice)",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "$readiness/100",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: readiness / 100.0,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFDC2626)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: tags.map((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: t["color"] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  t["label"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: t["textColor"] as Color,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayCard() {
    final tasks = [
      {
        "title": "Daily aptitude test",
        "subtitle": "10 questions, 10 minutes. The same test for everyone in your college today.",
        "tabIndex": 2,
      },
      {
        "title": "Topic drill: Direction sense",
        "subtitle": "Your weakest topic right now.",
        "tabIndex": 3,
      },
      {
        "title": "Word of the day: diligent",
        "subtitle": "Learn it, then play one English round.",
        "tabIndex": 5,
      },
      {
        "title": "This week's current-affairs quiz",
        "subtitle": "Read the week's items from your college, then take the quiz.",
        "tabIndex": 6,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Small daily steps add up.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ...tasks.map((task) {
            final tTitle = task["title"] as String;
            final isChecked = _todayTasksChecked[tTitle] ?? false;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _todayTasksChecked[tTitle] = !isChecked;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, right: 10),
                      child: Icon(
                        isChecked ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                        size: 20,
                        color: isChecked ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = task["tabIndex"] as int;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tTitle,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isChecked ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
                              decoration: isChecked ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            task["subtitle"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeakTopicsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weak topics",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Topics with at least 5 answers and under 70% accuracy.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.trending_down, size: 18, color: Color(0xFFEA580C)),
                const SizedBox(width: 10),
                Text(
                  "Direction sense",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                Text(
                  "20% of 10",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => _startLiveTest("Direction sense"),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Text(
                      "Drill",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNext7DaysCard() {
    final schedule = [
      {"day": "Today", "text": "Daily test · Direction sense drill · one English round"},
      {"day": "Fri", "text": "Daily test · Indian polity drill · one English round"},
      {"day": "Sat", "text": "Daily test · Indian history drill · one English round"},
      {"day": "Sun", "text": "Practice mock (UPSC CSE) and the weekly current-affairs quiz"},
      {"day": "Mon", "text": "Daily test · Indian economy drill · one English round"},
      {"day": "Tue", "text": "Daily test · General science drill · one English round"},
      {"day": "Wed", "text": "Daily test · Tamil Nadu history & culture drill · one English round"},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your next 7 days",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "A simple routine built from your targets and weak spots.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),
          ...schedule.map((item) {
            final isToday = item["day"] == "Today";
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 54,
                    child: Text(
                      item["day"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w600,
                        color: isToday ? const Color(0xFF0F172A) : const Color(0xFF475569),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item["text"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Divider(color: const Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 8),
          Text(
            "0 daily tests · 0 mocks · 2 practice rounds so far",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 1: SYLLABUS & NOTES
  // ===========================================================================
  Widget _buildSyllabusTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSyllabusTopProgressCard(),
        const SizedBox(height: 18),
        _buildSyllabusSectionCard(
          title: "General Studies Paper I",
          subtitle: "100 questions in the real paper",
          topics: _generalStudiesTopics,
        ),
        const SizedBox(height: 18),
        _buildSyllabusSectionCard(
          title: "CSAT (Paper II, qualifying)",
          subtitle: "80 questions in the real paper",
          topics: _csatTopics,
        ),
      ],
    );
  }

  Widget _buildSyllabusTopProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 14,
            runSpacing: 8,
            children: [
              Text(
                "Syllabus for",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSyllabusExam,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF0F172A)),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                    items: _syllabusExams.map((exam) {
                      return DropdownMenuItem(value: exam, child: Text(exam));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedSyllabusExam = val);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 840;
              final legendPills = Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildLegendPill("Not started: 21", const Color(0xFFF1F5F9), const Color(0xFF475569)),
                  _buildLegendPill("Studied: 0", const Color(0xFFDBEAFE), const Color(0xFF1D4ED8)),
                  _buildLegendPill("Practised: 1", const Color(0xFFFEF3C7), const Color(0xFFB45309)),
                  _buildLegendPill("Strong: 1", const Color(0xFFCCFBF1), const Color(0xFF0F766E)),
                ],
              );
              final metrics = Wrap(
                spacing: 16,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Syllabus covered", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                      const SizedBox(width: 8),
                      Text("9%", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Topics strong", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                      const SizedBox(width: 8),
                      Text("4%", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                    ],
                  ),
                ],
              );
              if (isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrics,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: legendPills,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    metrics,
                    const SizedBox(height: 12),
                    legendPills,
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 7,
              child: Row(
                children: [
                  Expanded(flex: 9, child: Container(color: const Color(0xFF1E3A8A))),
                  Expanded(flex: 4, child: Container(color: const Color(0xFF0D9488))),
                  Expanded(flex: 87, child: Container(color: const Color(0xFFF1F5F9))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Study a topic's notes, then practise it. A topic becomes strong at 75% accuracy over 10 or more answers.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendPill(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  Widget _buildSyllabusSectionCard({
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> topics,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topics.length,
            separatorBuilder: (context, i) => Divider(color: const Color(0xFFF1F5F9), height: 1),
            itemBuilder: (context, idx) {
              final t = topics[idx];
              final tTitle = t["title"] as String;
              final isFaculty = (t["isFaculty"] as bool?) ?? false;
              final isCollegeAdded = (t["isCollegeAdded"] as bool?) ?? false;
              final isStudied = _studiedTopics.contains(tTitle);
              final isPracticed = _practicedTopics.contains(tTitle);

              String statusLabel = t["status"] as String;
              Color statusBg = const Color(0xFFF1F5F9);
              Color statusText = const Color(0xFF64748B);
              if (isPracticed && statusLabel == "Not started") {
                statusLabel = "Practised";
                statusBg = const Color(0xFFFEF3C7);
                statusText = const Color(0xFFB45309);
              } else if (isStudied && statusLabel == "Not started") {
                statusLabel = "Studied";
                statusBg = const Color(0xFFDBEAFE);
                statusText = const Color(0xFF1D4ED8);
              } else if (statusLabel == "Strong") {
                statusBg = const Color(0xFFCCFBF1);
                statusText = const Color(0xFF0F766E);
              }

              final topicInfoColumn = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          tTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      if (isCollegeAdded) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Added by your college",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6D28D9),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          statusLabel,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: statusText,
                          ),
                        ),
                      ),
                      Text(
                        t["answersCount"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      if (isFaculty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lock_person_outlined, size: 13, color: Color(0xFF0D9488)),
                            const SizedBox(width: 4),
                            Text(
                              "faculty notes",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF0D9488),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              );

              final studyBtn = InkWell(
                onTap: () {
                  setState(() {
                    _studyingTopic = t;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Text(
                    "Study",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              );

              final practiseBtn = InkWell(
                onTap: () => _startLiveTest(tTitle),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Practise",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              );

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: LayoutBuilder(
                  builder: (context, itemConstraints) {
                    final isNarrow = itemConstraints.maxWidth < 620;
                    if (isNarrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          topicInfoColumn,
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              studyBtn,
                              const SizedBox(width: 8),
                              practiseBtn,
                            ],
                          ),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: topicInfoColumn),
                        const SizedBox(width: 14),
                        studyBtn,
                        const SizedBox(width: 8),
                        practiseBtn,
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TOPIC STUDY DETAIL VIEW
  // ===========================================================================
  Widget _buildTopicStudyView(Map<String, dynamic> topic) {
    final title = topic["title"] as String;
    final category = topic["category"] as String? ?? "General awareness";
    final notes = (topic["notes"] as List<dynamic>?) ?? [
      "The Constitution of India came into force on: 26 January 1950.",
      "Fundamental Rights are listed in Part III of the Constitution.",
      "The Directive Principles of State Policy are in Part IV.",
      "Article 21 guarantees Protection of life and personal liberty.",
      "Article 32 is termed the 'heart and soul' of the Constitution.",
    ];
    final examTip = topic["examTip"] as String? ?? "Revise these facts again the day after you study them, and once more a week later.";
    final isStudied = _studiedTopics.contains(title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Action Bar: Back and Study/Practise actions (Responsive Layout)
        LayoutBuilder(
          builder: (context, barConstraints) {
            final isNarrow = barConstraints.maxWidth < 520;

            final backBtn = InkWell(
              onTap: () {
                setState(() => _studyingTopic = null);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, size: 16, color: Color(0xFF0F172A)),
                    const SizedBox(width: 6),
                    Text(
                      "Back",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            );

            final studyActions = Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isStudied) {
                        _studiedTopics.remove(title);
                      } else {
                        _studiedTopics.add(title);
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isStudied ? "Removed from studied topics" : "Marked '$title' as studied!"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isStudied ? const Color(0xFF1E3A8A) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF1E3A8A)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, size: 15, color: isStudied ? Colors.white : const Color(0xFF1E3A8A)),
                        const SizedBox(width: 6),
                        Text(
                          isStudied ? "Studied ✓" : "Mark as studied",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: isStudied ? Colors.white : const Color(0xFF1E3A8A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _startLiveTest(title),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.help_outline, size: 15, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          "Practise 10 questions",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backBtn,
                  const SizedBox(height: 10),
                  studyActions,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backBtn,
                studyActions,
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.menu_book_outlined, size: 13, color: Color(0xFF475569)),
                        const SizedBox(width: 4),
                        Text(
                          "ColossusiQ notes",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      _practicedTopics.contains(title) ? "Practised" : "Not practised yet",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Key facts for $title, taken from the reviewed question bank. Read them, then practise the topic.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key points",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),
              ...notes.map((point) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 10),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F172A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          point as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF1E3A8B),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Exam tips",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, size: 18, color: Color(0xFFD97706)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      examTip,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 2: DAILY TEST (Image 2)
  // ===========================================================================
  Widget _buildDailyTestTab() {
    final days14 = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card 1: Today's Daily Test Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 620;
              final testInfo = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thursday, 5 November",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Daily aptitude test",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "10 questions in 10 minutes: quantitative aptitude, reasoning and English. Everyone in your college gets the same test today, so you can compare notes after.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.spa_outlined, size: 15, color: Color(0xFF64748B)),
                      const SizedBox(width: 6),
                      Text(
                        "No streak yet · best 0",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              );

              final startBtn = ElevatedButton.icon(
                onPressed: () => _startLiveTest("Daily aptitude test"),
                icon: const Icon(Icons.timer_outlined, size: 16),
                label: const Text("Start today's test"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    testInfo,
                    const SizedBox(height: 16),
                    startBtn,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: testInfo),
                  const SizedBox(width: 20),
                  startBtn,
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 18),

        // Card 2: Last 14 days
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last 14 days",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Your score in each daily test.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: days14.map((day) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 38,
                            height: 72,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F5EE),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 3: TOPIC PRACTICE (Images 3 & 4)
  // ===========================================================================
  Widget _buildTopicPracticeTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subtitle note
        Text(
          "Study a topic's notes, then take a 10-question drill with explanations. Your accuracy per topic feeds your weak-topic list, syllabus tracker and readiness.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF475569),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),

        // 1. Quantitative Aptitude Section (Image 3)
        _buildTopicGridSection(
          sectionTitle: "Quantitative aptitude",
          topics: [
            {"title": "Percentage", "sub": "generated fresh each time"},
            {"title": "Profit, loss & discount", "sub": "generated fresh each time"},
            {"title": "Simple & compound interest", "sub": "generated fresh each time"},
            {"title": "Time & work", "sub": "generated fresh each time + 10 from your college"},
            {"title": "Time, speed & distance", "sub": "generated fresh each time"},
            {"title": "Ratio, proportion & mixtures", "sub": "generated fresh each time"},
            {"title": "Averages & ages", "sub": "generated fresh each time"},
            {"title": "Number system & LCM", "sub": "generated fresh each time"},
            {"title": "Number series", "sub": "generated fresh each time + 10 from your college"},
          ],
        ),
        const SizedBox(height: 18),

        // 2. Reasoning Section (Image 3)
        _buildTopicGridSection(
          sectionTitle: "Reasoning",
          topics: [
            {"title": "Letter & number series", "sub": "generated fresh each time + 10 from your college"},
            {"title": "Coding-decoding", "sub": "generated fresh each time"},
            {"title": "Direction sense", "sub": "generated fresh each time · 10 answered", "badge": "20%"},
            {"title": "Analogy & odd one out", "sub": "generated fresh each time"},
            {"title": "Ranking & order", "sub": "generated fresh each time"},
            {"title": "Blood relations", "sub": "10 questions"},
            {"title": "Syllogism", "sub": "10 questions"},
          ],
        ),
        const SizedBox(height: 18),

        // 3. English Section (Image 4)
        _buildTopicGridSection(
          sectionTitle: "English",
          topics: [
            {"title": "Word meanings", "sub": "40 words"},
            {"title": "Synonyms", "sub": "30 words"},
            {"title": "Antonyms", "sub": "30 words"},
            {"title": "Idioms & phrases", "sub": "25 idioms + 10 from your college"},
            {"title": "One-word substitution", "sub": "25 items"},
            {"title": "Error spotting", "sub": "20 sentences"},
            {"title": "Fill in the blanks", "sub": "20 sentences"},
            {"title": "Sentence improvement", "sub": "15 sentences"},
          ],
        ),
        const SizedBox(height: 18),

        // 4. General Awareness Section (Image 4)
        _buildTopicGridSection(
          sectionTitle: "General awareness",
          topics: [
            {"title": "Indian polity", "sub": "15 questions"},
            {"title": "Indian history", "sub": "15 questions"},
            {"title": "Geography", "sub": "15 questions"},
            {"title": "Indian economy", "sub": "15 questions"},
            {"title": "General science", "sub": "15 questions"},
            {"title": "Tamil Nadu history & culture", "sub": "15 questions"},
            {"title": "Computer awareness", "sub": "12 questions"},
            {"title": "Banking awareness", "sub": "12 questions"},
          ],
        ),
        const SizedBox(height: 18),

        // 5. Subjects Section (Image 4)
        _buildTopicGridSection(
          sectionTitle: "Subjects",
          topics: [
            {"title": "Physics", "sub": "12 questions"},
            {"title": "Chemistry", "sub": "12 questions"},
            {"title": "Biology", "sub": "12 questions"},
            {"title": "Mathematics", "sub": "12 questions"},
            {"title": "Legal reasoning & legal GK", "sub": "12 questions"},
            {"title": "Child development & pedagogy", "sub": "12 questions"},
            {"title": "Teaching & research aptitude", "sub": "12 questions"},
            {"title": "Computer science core", "sub": "8 questions"},
            {"title": "Electronics & communication c...", "sub": "5 questions"},
          ],
        ),
      ],
    );
  }

  Widget _buildTopicGridSection({
    required String sectionTitle,
    required List<Map<String, dynamic>> topics,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final colCount = constraints.maxWidth >= 950 ? 3 : (constraints.maxWidth >= 650 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topics.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: colCount == 1 ? 3.4 : 2.5,
                ),
                itemBuilder: (context, idx) {
                  final t = topics[idx];
                  final tTitle = t["title"] as String;
                  final tSub = t["sub"] as String;
                  final badge = t["badge"] as String?;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tSub,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                                if (badge != null) ...[
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEE2E2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      badge,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFB91C1C),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _studyingTopic = {
                                    "title": tTitle,
                                    "category": sectionTitle,
                                    "notes": [
                                      "Key conceptual framework and fundamental formulas for $tTitle.",
                                      "Standard patterns frequently tested in national recruitment examinations.",
                                      "Shortcut calculations and time-saving eliminating strategies.",
                                    ],
                                    "examTip": "Revise key formulas and repeat speed drills for $tTitle."
                                  };
                                });
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                ),
                                child: Text(
                                  "Study",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () => _startLiveTest(tTitle),
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                ),
                                child: Text(
                                  "Practise",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 4: PRACTICE MOCKS (Image 5)
  // ===========================================================================
  Widget _buildPracticeMocksTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Notice banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Every mock follows the exam's real sections and marking, including negative marking. Choose a short mock (up to 10 questions per section, time scaled) for daily practice, or a full-length mock with the real paper's size and time before the exam. Your result shows section scores, accuracy and where you stand among classmates.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Target Mocks Cards Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 750;
            if (isDesktop) {
              return Row(
                children: [
                  Expanded(
                    child: _buildMockCard(
                      examTitle: "UPSC CSE",
                      category: "Central government jobs",
                      shortLabel: "Short · 20 Qs · 27 min",
                      fullLabel: "Full · 180 Qs · 240 min",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMockCard(
                      examTitle: "SSC CGL",
                      category: "Central government jobs",
                      shortLabel: "Short · 40 Qs · 24 min",
                      fullLabel: "Full · 100 Qs · 60 min",
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildMockCard(
                    examTitle: "UPSC CSE",
                    category: "Central government jobs",
                    shortLabel: "Short · 20 Qs · 27 min",
                    fullLabel: "Full · 180 Qs · 240 min",
                  ),
                  const SizedBox(height: 16),
                  _buildMockCard(
                    examTitle: "SSC CGL",
                    category: "Central government jobs",
                    shortLabel: "Short · 40 Qs · 24 min",
                    fullLabel: "Full · 100 Qs · 60 min",
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 18),

        // Show all 30 exams button
        Center(
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Loaded all 30 national competitive exam mock test series.")),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: Text(
                "Show all 30 exams",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),

        // "Your recent mocks" Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your recent mocks",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No mocks yet",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Take your first practice mock to see your scores here.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
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

  Widget _buildMockCard({
    required String examTitle,
    required String category,
    required String shortLabel,
    required String fullLabel,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF0F172A), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                examTitle,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Target",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6D28D9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(category, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
          const SizedBox(height: 8),
          Text("Negative marking as in the real exam", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF0F172A))),
          const SizedBox(height: 2),
          Text("Not attempted yet", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, btnConstraints) {
              final isTight = btnConstraints.maxWidth < 300;
              if (isTight) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () => _startLiveTest("$examTitle Short Mock"),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: Text(
                            shortLabel,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () => _startLiveTest("$examTitle Full Mock"),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            fullLabel,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _startLiveTest("$examTitle Short Mock"),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Text(
                          shortLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => _startLiveTest("$examTitle Full Mock"),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          fullLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 5: ENGLISH (Image 1)
  // ===========================================================================
  Widget _buildEnglishTab() {
    final modules = [
      {
        "title": "Word meanings",
        "sub": "Advanced words seen in CAT, GRE-style and bank exams. (40 words)",
        "status": "Not tried yet"
      },
      {
        "title": "Synonyms",
        "sub": "Pick the word closest in meaning. (30 words)",
        "status": "Not tried yet"
      },
      {
        "title": "Antonyms",
        "sub": "Pick the word opposite in meaning. (30 words)",
        "status": "Not tried yet"
      },
      {
        "title": "Idioms & phrases",
        "sub": "What the expression really means. (25 idioms)",
        "status": "Not tried yet"
      },
      {
        "title": "One-word substitution",
        "sub": "One word for a whole phrase. (25 items)",
        "status": "Not tried yet"
      },
      {
        "title": "Error spotting",
        "sub": "Find the part of the sentence with a grammar error. (20 sentences)",
        "status": "Not tried yet"
      },
      {
        "title": "Fill in the blanks",
        "sub": "Prepositions, tenses and agreement in context. (20 sentences)",
        "status": "Not tried yet"
      },
      {
        "title": "Sentence improvement",
        "sub": "Replace the part in brackets with the correct form. (15 sentences)",
        "status": "Not tried yet"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Card: Word of the day
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_book_outlined, size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Text(
                    "Word of the day",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "diligent",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "careful and hard-working",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Similar: industrious",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Opposite: lazy",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB91C1C),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 4-Column Grid of English Modules
        LayoutBuilder(
          builder: (context, constraints) {
            final colCount = constraints.maxWidth >= 1000
                ? 4
                : (constraints.maxWidth >= 700 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: modules.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1 ? 3.0 : 1.7,
              ),
              itemBuilder: (context, idx) {
                final m = modules[idx];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m["title"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            m["sub"]!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            m["status"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                          InkWell(
                            onTap: () => _startLiveTest(m["title"]!),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: Text(
                                "Start",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 6: CURRENT AFFAIRS (Image 2)
  // ===========================================================================
  String _selectedNewsCategory = "All";
  final List<String> _newsCategories = [
    "All",
    "National",
    "Tamil Nadu",
    "International",
    "Economy",
    "Science & Tech",
    "Environment",
    "Sports",
    "Awards",
    "Schemes",
    "Appointments"
  ];

  Widget _buildCurrentAffairsTab() {
    final newsList = [
      {
        "date": "Fri, 30 Oct, 2026",
        "category": "National",
        "title": "ISRO Launches Chandrayaan-4 Lunar Sample Return Mission",
        "body":
            "The Indian Space Research Organisation (ISRO) has successfully launched the Chandrayaan-4 mission from Sriharikota. The mission objective is to collect soil and rock samples from the lunar south pole and safely return them to Earth for advanced scientific research.",
        "source": "ISRO / PIB",
        "question": null
      },
      {
        "date": "Wed, 14 Oct, 2026",
        "category": "National",
        "title": "India Achieves 100% Electrification of Broad-Gauge Railway Network Under Mission 100%",
        "body":
            "Indian Railways has completed 100% electrification of its broad-gauge railway network, making it the largest electrified rail network in the world. The transition reduces annual carbon emissions by over 14 million tonnes and substantially lowers crude oil import bills. The milestone directly supports India's target of achieving Net Zero Carbon emissions by 2030.",
        "source": "PIB",
        "question":
            "Under Mission 100% Electrification, Indian Railways aims to become a Net Zero Carbon emitter by which target year?"
      },
      {
        "date": "Thu, 8 Oct, 2026",
        "category": "Environment",
        "title": "India adds 3 more wetlands to Ramsar list, taking national tally to 85",
        "body":
            "India has added 3 more wetlands to the global Ramsar List of Wetlands of International Importance, taking the total tally to 85. The newly designated sites are located in Tamil Nadu and Madhya Pradesh, enhancing preservation of unique wetland biodiversity.",
        "source": "Ministry of Environment / PIB",
        "question": "What is India's total number of designated Ramsar wetland sites as of October 2026?"
      },
    ];

    final filteredNews = _selectedNewsCategory == "All"
        ? newsList
        : newsList.where((n) => n["category"] == _selectedNewsCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Card: Weekly quiz announcement
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Week 45",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Weekly current-affairs quiz",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Opens once your college has published at least 3 questions this week.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _startLiveTest("Weekly Current Affairs Quiz"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Take the quiz"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _newsCategories.map((cat) {
              final isSelected = _selectedNewsCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedNewsCategory = cat),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // News Items Grouped by Date
        ...filteredNews.map((news) {
          final isEnvironment = news["category"] == "Environment";
          final tagBg = isEnvironment ? const Color(0xFFCCFBF1) : const Color(0xFFEDE9FE);
          final tagText = isEnvironment ? const Color(0xFF0F766E) : const Color(0xFF6D28D9);

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news["date"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: tagBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          news["category"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: tagText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2, right: 8),
                            child: Icon(Icons.feed_outlined, size: 16, color: Color(0xFF475569)),
                          ),
                          Expanded(
                            child: Text(
                              news["title"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news["body"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF475569),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            news["source"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.open_in_new, size: 12, color: Color(0xFF64748B)),
                        ],
                      ),
                      if (news["question"] != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F5EE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Quiz question this week: ${news["question"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ===========================================================================
  // TAB 7: EXAMS & ELIGIBILITY (Image 3)
  // ===========================================================================
  String _selectedExamFilter = "All exams";
  final List<String> _examFilters = [
    "All exams",
    "I can apply",
    "Central government jobs",
    "Tamil Nadu government jobs",
    "Banking & insurance",
    "Railways",
    "Defence",
    "Teaching & eligibility tests",
    "UG entrance (after 12th)",
    "PG entrance (after a degree)"
  ];
  String _examSearchQuery = "";
  final Set<String> _followedExams = {"UPSC CSE", "SSC CGL"};

  Widget _buildExamsEligibilityTab() {
    final allExams = [
      {
        "name": "UPSC CSE",
        "category": "Central government jobs",
        "eligibility": "Not yet eligible",
        "desc":
            "Gateway to the IAS, IPS, IFS and other central services. The prelims screen candidates for the mains and interview.",
        "edu": "You can apply in your final year (you are in year 2).",
        "pattern": "180 questions · 240 min · negative marking"
      },
      {
        "name": "SSC CGL",
        "category": "Central government jobs",
        "eligibility": "Not yet eligible",
        "desc":
            "Group B and C posts in central ministries: assistant section officer, inspector, auditor and more.",
        "edu": "You can apply in your final year (you are in year 2).",
        "pattern": "100 questions · 60 min · negative marking"
      },
      {
        "name": "SSC CHSL",
        "category": "Central government jobs",
        "eligibility": "Eligible",
        "desc":
            "Lower division clerk, postal and sorting assistant and data entry operator posts.",
        "edu": "You meet the education requirement (12th pass). Check any subject requirements.",
        "pattern": "100 questions · 60 min · negative marking"
      },
      {
        "name": "SSC MTS",
        "category": "Central government jobs",
        "eligibility": "Eligible",
        "desc": "Multi-tasking staff and havaldar posts in central departments.",
        "edu": "You meet the education requirement (10th pass).",
        "pattern": "90 questions · 90 min · negative marking"
      },
      {
        "name": "TNPSC Group 1",
        "category": "Tamil Nadu government jobs",
        "eligibility": "Not yet eligible",
        "desc": "Deputy Collector, DSP, Assistant Commissioner and other top state posts.",
        "edu": "You can apply once you hold your degree.",
        "pattern": "200 questions · 180 min"
      },
      {
        "name": "TNPSC Group 2",
        "category": "Tamil Nadu government jobs",
        "eligibility": "Not yet eligible",
        "desc":
            "Interview and non-interview posts such as sub-registrar, assistant section officer and revenue assistant.",
        "edu": "You can apply once you hold your degree.",
        "pattern": "100 questions · 180 min"
      },
      {
        "name": "TNPSC Group 4",
        "category": "Tamil Nadu government jobs",
        "eligibility": "Eligible",
        "desc": "Junior Assistant, Bill Collector, Typist and Village Administrative Officer (VAO).",
        "edu": "You meet the education requirement (10th pass).",
        "pattern": "200 questions · 180 min"
      },
      {
        "name": "IBPS PO",
        "category": "Banking & insurance",
        "eligibility": "Not yet eligible",
        "desc": "Probationary Officer recruitment across participating public sector commercial banks.",
        "edu": "You can apply once you complete your graduation.",
        "pattern": "100 questions · 60 min · negative marking"
      },
      {
        "name": "IBPS Clerk",
        "category": "Banking & insurance",
        "eligibility": "Not yet eligible",
        "desc": "Clerical cadre positions across nationalized banks in regional languages.",
        "edu": "Degree in any discipline from a recognized University.",
        "pattern": "100 questions · 60 min · negative marking"
      },
    ];

    final filtered = allExams.where((e) {
      final matchesSearch = _examSearchQuery.isEmpty ||
          e["name"]!.toLowerCase().contains(_examSearchQuery.toLowerCase()) ||
          e["category"]!.toLowerCase().contains(_examSearchQuery.toLowerCase()) ||
          e["desc"]!.toLowerCase().contains(_examSearchQuery.toLowerCase());

      if (!matchesSearch) return false;

      if (_selectedExamFilter == "All exams") return true;
      if (_selectedExamFilter == "I can apply") return e["eligibility"] == "Eligible";
      return e["category"] == _selectedExamFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Notice banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Patterns and eligibility are indicative and change from year to year. Always confirm the dates, eligibility, age limits and pattern in the official notification before you apply.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Filter chips wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _examFilters.map((flt) {
            final isSelected = _selectedExamFilter == flt;
            return InkWell(
              onTap: () => setState(() => _selectedExamFilter = flt),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  flt,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Search exams field
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: TextField(
            onChanged: (val) => setState(() => _examSearchQuery = val),
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              icon: const Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
              hintText: "Search exams...",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Exam Cards Grid
        LayoutBuilder(
          builder: (context, constraints) {
            Widget buildCard(Map<String, String> ex) {
              final isFollowing = _followedExams.contains(ex["name"]);
              final isEligible = ex["eligibility"] == "Eligible";

              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isFollowing ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                    width: isFollowing ? 1.4 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ex["name"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isEligible
                                    ? const Color(0xFFCCFBF1)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                ex["eligibility"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: isEligible
                                      ? const Color(0xFF0F766E)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ex["category"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ex["desc"]!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ex["edu"]!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ex["pattern"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        if (isFollowing) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 14, color: Color(0xFFD97706)),
                                const SizedBox(width: 4),
                                Text(
                                  "Following",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _followedExams.add(ex["name"]!);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added ${ex["name"]} to your target exams!")),
                              );
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E3A8A),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star_border, size: 14, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Add to my targets",
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
                        ],
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTabIndex = 1;
                              _selectedSyllabusExam = "${ex["name"]!} (target)";
                            });
                          },
                          child: Text(
                            "Pattern & syllabus",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            if (constraints.maxWidth < 650) {
              return Column(
                children: filtered.map((ex) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: buildCard(ex),
                )).toList(),
              );
            }

            final colCount = constraints.maxWidth >= 980 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 3 ? 1.08 : 1.25,
              ),
              itemBuilder: (context, idx) => buildCard(filtered[idx]),
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // INTERACTIVE DIALOGS
  // ===========================================================================
  void _showChangeTargetExamsDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Change Target Exams", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select up to 3 target exams you are actively preparing for:", style: GoogleFonts.poppins(fontSize: 12.5)),
              const SizedBox(height: 12),
              ...["UPSC CSE", "SSC CGL", "GATE CSE", "Banking (IBPS/SBI)", "TNPSC Group 2"].map((name) {
                final isSelected = _targetExams.any((e) => e["name"] == name);
                return CheckboxListTile(
                  title: Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                  value: isSelected,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Target exams updated with $name")),
                    );
                  },
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showSetDateDialog(Map<String, dynamic> exam) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 90)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    ).then((selected) {
      if (selected != null && mounted) {
        setState(() {
          exam["examDate"] = "${selected.day}/${selected.month}/${selected.year}";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Exam date updated to ${exam["examDate"]}")),
        );
      }
    });
  }
}
