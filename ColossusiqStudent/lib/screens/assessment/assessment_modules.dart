import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
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
  int _activeTab = 0; // 0: Evaluate, 1: History
  bool _hasSampleEvaluated = false;
  final TextEditingController _nameController = TextEditingController(text: "Anand Kumar");
  final TextEditingController _rollController = TextEditingController(text: "22CS104");
  final TextEditingController _topicController = TextEditingController(text: "DBMS Normalization & 3NF");
  final TextEditingController _marksController = TextEditingController(text: "10");

  PlatformFile? _uploadedFile;
  int _uploadedFileSize = 0;
  bool _isPicking = false;
  String? _uploadError;

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
        // 200MB size limit check (200 * 1024 * 1024 bytes)
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

        // 3. Tab Buttons Row
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _buildTabPill(
              index: 0,
              icon: Icons.auto_awesome_rounded,
              label: "Evaluate Answer Sheet",
            ),
            _buildTabPill(
              index: 1,
              icon: Icons.history_rounded,
              label: "Evaluation History",
            ),
          ],
        ),
        const SizedBox(height: 18),

        if (_activeTab == 0) ...[
          // Form & Result Layout
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
          // History View
          _buildHistoryList(),
        ],
      ],
    );
  }

  Widget _buildTabPill({required int index, required IconData icon, required String label}) {
    final isSelected = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isSelected ? 0.08 : 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFFB91C1C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),

          // Inputs Row 1: Student Name & Roll Number
          Row(
            children: [
              Expanded(
                child: _buildFormField("Student Name", _nameController, "e.g. Anand Kumar"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField("Roll Number", _rollController, "e.g. 116"),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Inputs Row 2: Question/Topic & Max Marks
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildFormField("Question / Topic", _topicController, "e.g. 3NF, Deadlocks..."),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: _buildFormField("Max Marks", _marksController, "10"),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _hasSampleEvaluated = true);
                    final fileName = _uploadedFile?.name ?? "Sample answer sheet";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Evaluation complete with AI OCR scoring for $fileName!"),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.auto_awesome, size: 16),
                  label: const Text("Evaluate"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _hasSampleEvaluated = true;
                    _uploadError = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Loaded sample answer sheet for demonstration."),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Use sample sheet"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.ink2),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: GoogleFonts.poppins(fontSize: 12.5, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink3),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultPane() {
    if (!_hasSampleEvaluated) {
      // Empty state matching Image 1
      return Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightGridPainter(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.document_scanner_outlined, color: Color(0xFF64748B), size: 32),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "No evaluation yet",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Upload any student handwritten answer sheet (or use the sample) to see OCR extraction and AI rubric scoring.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.ink3,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Evaluated Result Card
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
              Text("OCR Rubric Score", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Text("94% Confidence", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF059669))),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _scoreItem("Score", "8.5 / 10", const Color(0xFF4F46E5)),
                _scoreItem("Concept Match", "Full 3NF", const Color(0xFF059669)),
                _scoreItem("Legibility", "High", const Color(0xFFD97706)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text("OCR Extracted Transcript", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.ink)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: Text(
              "\"A relation R is in 3NF if it is in 2NF and every non-prime attribute is non-transitively dependent on every candidate key. X -> A holds only if X is superkey or A is prime attribute.\"",
              style: GoogleFonts.robotoMono(fontSize: 11.5, color: const Color(0xFF334155)),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mark confirmed! Logged to grade sheet.")));
                  },
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF059669))),
                  child: const Text("Confirm 8.5 Mark", style: TextStyle(color: Color(0xFF059669))),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Override dialog opened for faculty mark.")));
                },
                child: const Text("Override"),
              ),
            ],
          ),
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

  Widget _buildHistoryList() {
    return Column(
      children: [
        _historyItem("DBMS Midterm 3NF Question", "Anand Kumar (22CS104)", "8.5 / 10", "Reviewed yesterday"),
        _historyItem("Operating Systems Deadlock Proof", "Anand Kumar (22CS104)", "9.0 / 10", "Reviewed 3 days ago"),
      ],
    );
  }

  Widget _historyItem(String title, String student, String marks, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: () => _showEvaluationDetailsDialog(title, student, marks, date),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "$student · $date",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: AppColors.ink3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        marks,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _showEvaluationDetailsDialog(title, student, marks, date),
                      icon: const Icon(Icons.visibility_outlined, size: 13),
                      label: const Text("View Details"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        foregroundColor: const Color(0xFF0F766E),
                        textStyle: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => _showEditEvaluationDialog(title, student, marks, date),
                      icon: const Icon(Icons.edit_outlined, size: 13),
                      label: const Text("Edit / Re-evaluate"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        foregroundColor: const Color(0xFF4338CA),
                        textStyle: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEvaluationDetailsDialog(String title, String student, String marks, String date) {
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
              child: const Icon(Icons.draw_outlined, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("$student · $date", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Assigned Rubric Score", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                        child: Text(marks, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text("OCR Text Match: High 94% similarity against faculty model answer.", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 10),
                Text("Evaluator Notes", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "All core normalization proof derivations and schema decomposition steps were correctly articulated.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditEvaluationDialog(title, student, marks, date);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit / Re-evaluate"),
          ),
        ],
      ),
    );
  }

  void _showEditEvaluationDialog(String title, String student, String marks, String date) {
    final titleCtrl = TextEditingController(text: title);
    final marksCtrl = TextEditingController(text: marks);
    final noteCtrl = TextEditingController(text: "Requesting re-check of question step 2.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Re-evaluation Request", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Evaluation Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: marksCtrl,
                  decoration: const InputDecoration(labelText: "Current Mark", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Student / Faculty Re-evaluation Note", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Re-evaluation request for '$title' submitted!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save & Submit", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _LightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6)
      ..strokeWidth = 1;

    const step = 20.0;
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
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "sender": "agent",
      "text": "I'll act as your viva examiner for Smart Campus AI. I'll start with basics and follow up based on your answers.",
    },
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": text.trim()});
      _messages.add({
        "sender": "agent",
        "text": "Good point. How does your FastAPI architecture handle concurrent WebSockets during sudden spike traffic from 500 campus sensors?",
      });
    });
    _msgController.clear();
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
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
          category: "Assessment",
          phase: "Phase 2",
          icon: Icons.mic_none_outlined,
          title: "Viva Simulator",
          subtitle: "Project, subject and technical viva with faculty-style follow-up questions.",
          watermarkIcon: Icons.mic_rounded,
        ),
        const SizedBox(height: 16),

        // 2. Context bar pills matching Image 2
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _contextChip("CONTEXT", isTag: true),
              const SizedBox(width: 8),
              _contextChip("Project: Smart Campus AI"),
              const SizedBox(width: 8),
              _contextChip("Stack: Python, FastAPI, React"),
              const SizedBox(width: 8),
              _contextChip("Mode: Technical viva"),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Responsive Chat + Agent Sidebar Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 780;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _buildChatArea()),
                  const SizedBox(width: 18),
                  Expanded(flex: 4, child: _buildAgentSidebar()),
                ],
              );
            }
            return Column(
              children: [
                _buildAgentSidebar(),
                const SizedBox(height: 16),
                _buildChatArea(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _contextChip(String text, {bool isTag = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isTag ? const Color(0xFFF1F5F9) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: isTag ? FontWeight.w700 : FontWeight.w500,
          color: isTag ? const Color(0xFF475569) : const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dialogue messages
          ..._messages.map((m) {
            final isAgent = m["sender"] == "agent";
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isAgent) ...[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isAgent ? AppColors.veryLightBlue : AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isAgent ? AppColors.border : AppColors.primaryBlue.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isAgent) ...[
                            Text(
                              "Viva Agent",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Text(
                            m["text"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: AppColors.ink,
                              height: 1.45,
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

          // Prompt starters
          if (_messages.length == 1) ...[
            const SizedBox(height: 6),
            _promptStarter("💡 Start my project viva"),
            const SizedBox(height: 8),
            _promptStarter("📋 Ask me architecture questions"),
            const SizedBox(height: 8),
            _promptStarter("📈 Give me a tough follow-up on security"),
          ],

          const SizedBox(height: 20),

          // Input field matching Image 2
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    onSubmitted: _sendMessage,
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: const InputDecoration(
                      hintText: "Message Viva Agent...",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _sendMessage(_msgController.text),
                  icon: const Icon(Icons.send_rounded, color: Color(0xFF6366F1), size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Enter to send. Don't share passwords or personal IDs.",
            style: GoogleFonts.poppins(fontSize: 10, color: AppColors.ink3),
          ),
        ],
      ),
    );
  }

  Widget _promptStarter(String label) {
    return InkWell(
      onTap: () => _sendMessage(label),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  Widget _buildAgentSidebar() {
    return Column(
      children: [
        // Agent Card
        Container(
          width: double.infinity,
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
                "AGENT",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink3,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Viva Agent",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Project, subject and technical viva with follow-up questions.",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: AppColors.ink3,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Information Callout Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFBBF7D0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFF16A34A), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Answers marked Institution source come from approved documents. Everything else is a general AI explanation — verify before relying on it.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF15803D),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 3. Competitive Exams Screen (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class CompetitiveExamsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const CompetitiveExamsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exams = [
      {
        "category": "Engineering",
        "tagTone": BadgeTone.sky,
        "date": "Next exam: Feb 2027",
        "title": "GATE CSE",
        "desc": "Topic-wise plan, PYQs and full-length mocks",
        "progress": 0.35,
      },
      {
        "category": "Civil services",
        "tagTone": BadgeTone.gold,
        "date": "Prelims: May 2027",
        "title": "UPSC CSE",
        "desc": "Prelims GS, CSAT and daily current affairs",
        "progress": null,
      },
      {
        "category": "State",
        "tagTone": BadgeTone.teal,
        "date": "Notification awaited",
        "title": "TNPSC Group 2",
        "desc": "Tamil & English, aptitude and GS",
        "progress": null,
      },
      {
        "category": "Banking",
        "tagTone": BadgeTone.sky,
        "date": "PO prelims: Oct",
        "title": "Banking (IBPS / SBI)",
        "desc": "Quant, reasoning, English, banking awareness",
        "progress": null,
      },
      {
        "category": "Central govt.",
        "tagTone": BadgeTone.gold,
        "date": "Tier 1: Nov",
        "title": "SSC CGL",
        "desc": "Tier 1 & 2 preparation",
        "progress": null,
      },
      {
        "category": "Railways",
        "tagTone": BadgeTone.rose,
        "date": "Upcoming",
        "title": "Railway (RRB NTPC)",
        "desc": "CBT 1 & 2",
        "progress": null,
      },
      {
        "category": "Teaching",
        "tagTone": BadgeTone.sky,
        "date": "Dec cycle",
        "title": "UGC-NET",
        "desc": "Paper 1 + subject paper",
        "progress": null,
      },
      {
        "category": "Management",
        "tagTone": BadgeTone.gold,
        "date": "CAT: Nov 30",
        "title": "CAT / MBA entrance",
        "desc": "QA, DILR, VARC",
        "progress": null,
      },
      {
        "category": "Law",
        "tagTone": BadgeTone.teal,
        "date": "Dec",
        "title": "Law entrance (CLAT)",
        "desc": "Legal reasoning, GK, English",
        "progress": null,
      },
      {
        "category": "Defence",
        "tagTone": BadgeTone.sky,
        "date": "Feb",
        "title": "Defence (CDS / AFCAT)",
        "desc": "Maths, English, GK",
        "progress": null,
      },
    ];

    return PortalPageBody(
      title: "Competitive Exams",
      category: "Assessment",
      onBack: onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Assessment  ›  Competitive Exams",
          category: "Assessment",
          phase: "Phase 2",
          icon: Icons.emoji_events_outlined,
          title: "Competitive Exams",
          subtitle: "UPSC, SSC, Banking, Railway, TNPSC, GATE, UGC-NET, CAT and more.",
          watermarkIcon: Icons.emoji_events_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Exam Cards Grid Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final count = constraints.maxWidth > 950 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exams.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: count == 1 ? 2.5 : 1.85,
              ),
              itemBuilder: (context, index) {
                final ex = exams[index];
                return _buildExamCard(ex);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildExamCard(Map<String, dynamic> ex) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Top row: category badge + date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBadge(label: ex["category"] as String, tone: ex["tagTone"] as BadgeTone),
              Text(
                ex["date"] as String,
                style: GoogleFonts.poppins(fontSize: 11, color: AppColors.ink3),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            ex["title"] as String,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),

          // Description
          Expanded(
            child: Text(
              ex["desc"] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: AppColors.ink3,
                height: 1.35,
              ),
            ),
          ),

          // Progress bar if present
          if (ex["progress"] != null) ...[
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ex["progress"] as double,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

