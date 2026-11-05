import '../../core/theme/app_colors.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Shared Component: Animated Dimension Progress Bar
/// ─────────────────────────────────────────────────────────────────────────────
class AnimatedDimensionProgressBar extends StatelessWidget {
  final String name;
  final int score;
  final int target;
  final Color color;
  final int index;
  final Key? replayKey;

  const AnimatedDimensionProgressBar({
    super.key,
    required this.name,
    required this.score,
    required this.target,
    required this.color,
    this.index = 0,
    this.replayKey,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: replayKey ?? ValueKey("${name}_$score"),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 700 + (index * 70)),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, _) {
        final animatedScore = (score * animValue).round();
        final widthFactor = ((score / 100.0) * animValue).clamp(0.0, 1.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$animatedScore ",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      TextSpan(
                        text: "/ target $target",
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
            const SizedBox(height: 7),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    height: 7,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Career Planner & Twin Screen (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class CareerPlannerScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const CareerPlannerScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Career Planner & Twin",
      category: "Career",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Career Planner & Twin",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.explore_outlined,
          title: "Career Planner & Twin",
          subtitle: "Compare your current profile with your target role and close every gap.",
          watermarkIcon: Icons.explore_outlined,
        ),
        const SizedBox(height: 20),

        // Responsive Top Row: Radar Chart + Dimensions
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 12, child: _buildRadarCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 10, child: _buildDimensionsCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildRadarCard(),
                const SizedBox(height: 16),
                _buildDimensionsCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Bottom Row: Strengths, Gaps, Improvement plan
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildStrengthsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGapsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPlanCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildStrengthsCard(),
                const SizedBox(height: 16),
                _buildGapsCard(),
                const SizedBox(height: 16),
                _buildPlanCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRadarCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You vs. Data Scientist (entry level)",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: LayoutBuilder(
              builder: (context, c) {
                final chartWidth = math.min(c.maxWidth, 320.0);
                return SizedBox(
                  height: 280,
                  width: chartWidth,
                  child: CustomPaint(
                    painter: _RadarChartPainter(
                      labels: const ["Skills", "Experience", "Portfolio", "Communication", "Certifications", "Interview"],
                      currentValues: const [62, 35, 55, 59, 50, 48],
                      targetValues: const [80, 60, 75, 75, 60, 75],
                      maxValue: 100,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Current", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
              const SizedBox(width: 20),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD97706), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Target", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFFD97706))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsCard() => const _CareerPlannerDimensionsCard();

  Widget _buildStrengthsCard() {
    const items = [
      "Strong Python and a real AI project",
      "Good academic record (8.21)",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF0D9488), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        it,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGapsCard() {
    const items = [
      "No internship yet",
      "Interview readiness below target",
      "Portfolio lacks a deployed project",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Color(0xFFD97706), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        it,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    const items = [
      "Apply to 5 matched internships",
      "Deploy Smart Campus AI demo",
      "Two mock interviews per week for 4 weeks",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${entry.key + 1}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _CareerPlannerDimensionsCard extends StatefulWidget {
  const _CareerPlannerDimensionsCard();

  @override
  State<_CareerPlannerDimensionsCard> createState() => _CareerPlannerDimensionsCardState();
}

class _CareerPlannerDimensionsCardState extends State<_CareerPlannerDimensionsCard> {
  int _animVersion = 0;

  @override
  Widget build(BuildContext context) {
    final dimensions = [
      {"name": "Skills", "score": 62, "target": 80, "color": AppColors.primaryBlue},
      {"name": "Experience", "score": 35, "target": 60, "color": const Color(0xFFDC2626)},
      {"name": "Portfolio", "score": 55, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Communication", "score": 59, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Certifications", "score": 50, "target": 60, "color": const Color(0xFFD97706)},
      {"name": "Interview", "score": 48, "target": 75, "color": const Color(0xFFD97706)},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                    "Dimensions",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  TweenAnimationBuilder<double>(
                    key: ValueKey("overall_$_animVersion"),
                    tween: Tween<double>(begin: 0.0, end: 52.0),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) => Text(
                      "Overall ${val.round()}%",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => setState(() => _animVersion++),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh_rounded, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Text(
                        "Replay",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...dimensions.asMap().entries.map((entry) {
            final index = entry.key;
            final d = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AnimatedDimensionProgressBar(
                name: d["name"] as String,
                score: d["score"] as int,
                target: d["target"] as int,
                color: d["color"] as Color,
                index: index,
                replayKey: ValueKey("dim_${index}_$_animVersion"),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Custom Radar Chart Painter matching Image 1 exactly
class _RadarChartPainter extends CustomPainter {
  final List<String> labels;
  final List<double> currentValues;
  final List<double> targetValues;
  final double maxValue;

  _RadarChartPainter({
    required this.labels,
    required this.currentValues,
    required this.targetValues,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 40;
    final count = labels.length;

    // Web background rings
    final webPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int step = 1; step <= 4; step++) {
      final r = radius * (step / 4.0);
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = -math.pi / 2 + (i * 2 * math.pi / count);
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, webPaint);
    }

    // Spokes
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), webPaint);

      // Label
      final labelX = center.dx + (radius + 22) * math.cos(angle);
      final labelY = center.dy + (radius + 22) * math.sin(angle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(labelX - (textPainter.width / 2), labelY - (textPainter.height / 2)),
      );
    }

    // Target polygon (Gold/Amber)
    final targetPath = Path();
    for (int i = 0; i < count; i++) {
      final r = radius * (targetValues[i] / maxValue);
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFillPaint = Paint()
      ..color = const Color(0xFFD97706).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final targetStrokePaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(targetPath, targetFillPaint);
    canvas.drawPath(targetPath, targetStrokePaint);

    // Current polygon (Dark Navy/Slate)
    final currentPath = Path();
    for (int i = 0; i < count; i++) {
      final r = radius * (currentValues[i] / maxValue);
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();

    final currentFillPaint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final currentStrokePaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(currentPath, currentFillPaint);
    canvas.drawPath(currentPath, currentStrokePaint);
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) => false;
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 2. Resume Builder Screen (Image 2 & 3)
/// ─────────────────────────────────────────────────────────────────────────────
class ResumeBuilderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ResumeBuilderScreen({super.key, this.onBack});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  String _selectedTemplate = "Classic";
  String _activeTab = "Basics";
  String _selectedTargetRole = "Software Engineer";
  bool _isAnalysing = false;
  int _atsScore = 53;

  String? _uploadedPdfName;
  String? _uploadedPdfSize;

  final TextEditingController _nameController = TextEditingController(text: "Anand Kumar");
  final TextEditingController _headlineController = TextEditingController(
      text: "B.E. Computer Science & Engineering student · Computer Science & Engineering");
  final TextEditingController _emailController = TextEditingController(text: "you@example.com");
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController(text: "Tiruchirappalli, Tamil Nadu");
  final TextEditingController _linksController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _eduController = TextEditingController(
      text: "B.E. Computer Science & Engineering, Computer Science & Engineering — Anna Institute of Technology");
  final TextEditingController _skillsController = TextEditingController(
      text: "Database Management Systems · Operating Systems · Computer Networks · Machine Learning · Algorithms & Complexity · Problem Solving with Python");
  final TextEditingController _projectsController = TextEditingController(
      text: "Smart Campus AI — attendance & energy insights using face embeddings and IoT meters; reduced manual attendance time by 70% for 3 sections.\nAgriSoil Sense — low-cost soil sensor with Tamil voice app (prototype).");
  final TextEditingController _expController = TextEditingController(
      text: "Coding Club Secretary (2025–26) — organised 12 weekly contests.");
  final TextEditingController _achieveController = TextEditingController(
      text: "Smart India Hackathon 2025 finalist · SQL fundamentals certification");

  final List<String> _roles = [
    "Software Engineer",
    "Data Scientist",
    "Full Stack Developer",
    "Cloud Engineer",
    "DevOps Engineer",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _headlineController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _linksController.dispose();
    _summaryController.dispose();
    _eduController.dispose();
    _skillsController.dispose();
    _projectsController.dispose();
    _expController.dispose();
    _achieveController.dispose();
    super.dispose();
  }

  void _fillFromProfile() {
    setState(() {
      _nameController.text = "Anand Kumar";
      _headlineController.text = "B.E. Computer Science & Engineering student · Computer Science & Engineering";
      _emailController.text = "anand.k@ait.edu.in";
      _phoneController.text = "+91 98765 43210";
      _locationController.text = "Tiruchirappalli, Tamil Nadu";
      _linksController.text = "github.com/anandk\nlinkedin.com/in/anandk";
      _summaryController.text = "Aspiring Software Engineer with a solid foundation in data structures, algorithms, and full-stack web applications.";
      _eduController.text = "B.E. Computer Science & Engineering, Computer Science & Engineering — Anna Institute of Technology";
      _skillsController.text = "Database Management Systems · Operating Systems · Computer Networks · Machine Learning · Algorithms & Complexity · Problem Solving with Python";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Profile details imported into resume draft!", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveResume() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Resume draft saved successfully!", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: const Color(0xFF0D9488),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _checkResume() {
    setState(() {
      _isAnalysing = true;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _isAnalysing = false;
          _atsScore = 53;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ATS scan complete for $_selectedTargetRole! Score: $_atsScore/100",
                style: GoogleFonts.poppins(color: Colors.white)),
            backgroundColor: const Color(0xFF2A3B8F),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  Future<void> _showUploadResumePdfDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        String? localFileName = _uploadedPdfName;
        String? localFileSize = _uploadedPdfSize;
        bool isPicking = false;
        bool isUploading = false;
        double uploadProgress = 0.0;
        String? errorMessage;

        String formatSize(int bytes) {
          if (bytes < 1024) return "$bytes B";
          if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
          return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
        }

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A3B8F).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.file_upload_outlined,
                                  color: Color(0xFF2A3B8F),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Upload Existing Resume",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "Select and upload your existing resume in PDF format. We will extract and parse your experience, projects, and skills for ATS optimization.",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 18),
                      InkWell(
                        onTap: (isPicking || isUploading)
                            ? null
                            : () async {
                                setDialogState(() {
                                  isPicking = true;
                                  errorMessage = null;
                                });
                                try {
                                  final PlatformFile? pickedFile = await FilePicker.pickFile(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                  );

                                  if (pickedFile != null) {
                                    final sizeBytes = pickedFile.lengthSync() ?? (await pickedFile.length()) ?? 0;
                                    const int maxBytes = 200 * 1024 * 1024; // 200 MB

                                    if (sizeBytes > maxBytes) {
                                      setDialogState(() {
                                        errorMessage = "File size exceeds 200 MB limit (${formatSize(sizeBytes)}).";
                                        isPicking = false;
                                      });
                                      return;
                                    }

                                    final sizeStr = formatSize(sizeBytes);

                                    setDialogState(() {
                                      localFileName = pickedFile.name;
                                      localFileSize = sizeStr;
                                      isPicking = false;
                                      isUploading = true;
                                      uploadProgress = 0.0;
                                    });

                                    for (int i = 1; i <= 10; i++) {
                                      await Future.delayed(const Duration(milliseconds: 60));
                                      if (context.mounted) {
                                        setDialogState(() {
                                          uploadProgress = i / 10.0;
                                        });
                                      }
                                    }

                                    setDialogState(() {
                                      isUploading = false;
                                    });
                                  } else {
                                    setDialogState(() {
                                      isPicking = false;
                                    });
                                  }
                                } catch (e) {
                                  setDialogState(() {
                                    isPicking = false;
                                    errorMessage = "Error selecting file: $e";
                                  });
                                }
                              },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: errorMessage != null
                                  ? const Color(0xFFEF4444)
                                  : (localFileName != null ? const Color(0xFF10B981) : const Color(0xFFCBD5E1)),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                localFileName != null ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
                                size: 38,
                                color: localFileName != null ? const Color(0xFF10B981) : const Color(0xFF2A3B8F),
                              ),
                              const SizedBox(height: 10),
                              if (localFileName != null) ...[
                                Text(
                                  localFileName!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Size: $localFileSize · Click to change file",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  isPicking ? "Opening file selector..." : "Click to browse and upload PDF",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Supported format: PDF (Max: 200 MB)",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                              if (isUploading) ...[
                                const SizedBox(height: 14),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: uploadProgress,
                                    minHeight: 6,
                                    backgroundColor: const Color(0xFFE2E8F0),
                                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2A3B8F)),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Uploading & analyzing... ${(uploadProgress * 100).toInt()}%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.error_outline, size: 16, color: Color(0xFFEF4444)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFEF4444)),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: (localFileName == null || isUploading)
                                ? null
                                : () {
                                    setState(() {
                                      _uploadedPdfName = localFileName;
                                      _uploadedPdfSize = localFileSize;
                                    });
                                    Navigator.of(dialogContext).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Uploaded $localFileName ($localFileSize) successfully!",
                                          style: GoogleFonts.poppins(color: Colors.white),
                                        ),
                                        backgroundColor: const Color(0xFF10B981),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A3B8F),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            ),
                            child: Text(
                              "Confirm & Parse",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Resume Builder",
      category: "Career",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Resume Builder",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.article_outlined,
          title: "Resume Builder",
          subtitle: "ATS-oriented resumes and role-specific versions with keyword and structure analysis.",
          watermarkIcon: Icons.article_outlined,
        ),
        const SizedBox(height: 20),

        // Top Profile Bar Card
        _buildProfileBarCard(),
        const SizedBox(height: 20),

        // Main 2-column builder area
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 920;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTemplateCard(),
                        const SizedBox(height: 20),
                        _buildTabbedFormCard(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDownloadBarCard(),
                        const SizedBox(height: 20),
                        _buildResumeDocumentPreview(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTemplateCard(),
                  const SizedBox(height: 20),
                  _buildDownloadBarCard(),
                  const SizedBox(height: 20),
                  _buildResumeDocumentPreview(),
                  const SizedBox(height: 20),
                  _buildTabbedFormCard(),
                ],
              );
            }
          },
        ),

        const SizedBox(height: 24),

        // Bottom Section: Completeness and ATS Check
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 920;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildCompletenessCard(),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 7,
                    child: _buildAtsCheckCard(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompletenessCard(),
                  const SizedBox(height: 20),
                  _buildAtsCheckCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // 1. Top Profile Bar Card
  Widget _buildProfileBarCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          final isWrap = constraints.maxWidth < 750;
          final titleCol = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _nameController.text.isNotEmpty ? _nameController.text : "Anand Kumar",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Draft made from your profile. Save it to keep it.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _showUploadResumePdfDialog,
                icon: const Icon(Icons.file_upload_outlined, size: 15),
                label: Text("Upload existing resume",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _fillFromProfile,
                icon: const Icon(Icons.refresh_rounded, size: 15),
                label: Text("Fill from my profile",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _saveResume,
                icon: const Icon(Icons.bookmark_border_rounded, size: 15),
                label: Text("Save resume",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A3B8F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          );

          if (isWrap) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleCol,
                const SizedBox(height: 14),
                actions,
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleCol,
              actions,
            ],
          );
        },
      ),
    );
  }

  // 2. Template Card
  Widget _buildTemplateCard() {
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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Template",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "All three are single-column with real text, so applicant-tracking systems can read them.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 500;
              final templates = [
                {
                  "name": "Classic",
                  "desc": "Serif, centred header. The safe choice for most campus drives.",
                },
                {
                  "name": "Modern",
                  "desc": "Clean sans-serif with a teal accent.",
                },
                {
                  "name": "Compact",
                  "desc": "Smaller type to fit more on one page.",
                },
              ];

              if (isNarrow) {
                return Column(
                  children: templates.map((tpl) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildTemplateOption(tpl["name"]!, tpl["desc"]!),
                  )).toList(),
                );
              }

              return Row(
                children: templates.map((tpl) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: tpl["name"] != "Compact" ? 12 : 0),
                      child: _buildTemplateOption(tpl["name"]!, tpl["desc"]!),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateOption(String name, String desc) {
    final isSelected = _selectedTemplate == name;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTemplate = name;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 104,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2A3B8F) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF2A3B8F) : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                desc,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Tabbed Resume Form Card
  Widget _buildTabbedFormCard() {
    final tabs = ["Basics", "Education", "Skills", "Projects", "Experience", "More"];

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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs.map((tab) {
                final isSelected = _activeTab == tab;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _activeTab = tab;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? const Color(0xFF2A3B8F) : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      tab,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 20),

          // Tab Content
          if (_activeTab == "Basics") ...[
            _buildBasicsTabContent(),
          ] else if (_activeTab == "Education") ...[
            _buildFieldLabel("Education Summary"),
            _buildCustomTextField(
              controller: _eduController,
              maxLines: 4,
              hint: "Degree, Major, Institution, CGPA & Graduation Year",
            ),
          ] else if (_activeTab == "Skills") ...[
            _buildFieldLabel("Skills"),
            _buildCustomTextField(
              controller: _skillsController,
              maxLines: 4,
              hint: "Comma or dot separated skills",
            ),
          ] else if (_activeTab == "Projects") ...[
            _buildFieldLabel("Projects"),
            _buildCustomTextField(
              controller: _projectsController,
              maxLines: 6,
              hint: "Project title, role, tech stack, and impact bullets",
            ),
          ] else if (_activeTab == "Experience") ...[
            _buildFieldLabel("Experience / Internships"),
            _buildCustomTextField(
              controller: _expController,
              maxLines: 5,
              hint: "Roles, club leadership, internships or open source contributions",
            ),
          ] else ...[
            _buildFieldLabel("Certifications & Achievements"),
            _buildCustomTextField(
              controller: _achieveController,
              maxLines: 5,
              hint: "List verified certifications and competition awards",
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBasicsTabContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 480;

        Widget nameField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Full name"),
            _buildCustomTextField(
              controller: _nameController,
              hint: "Anand Kumar",
              onChanged: (_) => setState(() {}),
            ),
          ],
        );

        Widget headlineField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Headline"),
            _buildCustomTextField(
              controller: _headlineController,
              hint: "e.g. B.E. Computer Science student",
              onChanged: (_) => setState(() {}),
            ),
          ],
        );

        Widget emailField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Email"),
            _buildCustomTextField(
              controller: _emailController,
              hint: "you@example.com",
              onChanged: (_) => setState(() {}),
            ),
          ],
        );

        Widget phoneField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Phone"),
            _buildCustomTextField(
              controller: _phoneController,
              hint: "+91 98765 43210",
              onChanged: (_) => setState(() {}),
            ),
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isNarrow) ...[
              nameField,
              const SizedBox(height: 14),
              headlineField,
              const SizedBox(height: 14),
              emailField,
              const SizedBox(height: 14),
              phoneField,
            ] else ...[
              Row(
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 16),
                  Expanded(child: headlineField),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: emailField),
                  const SizedBox(width: 16),
                  Expanded(child: phoneField),
                ],
              ),
            ],
            const SizedBox(height: 14),
            _buildFieldLabel("Location"),
            _buildCustomTextField(
              controller: _locationController,
              hint: "Tiruchirappalli, Tamil Nadu",
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Links"),
            _buildCustomTextField(
              controller: _linksController,
              maxLines: 3,
              hint: "",
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            Text(
              "One per line, up to 5: GitHub, LinkedIn, portfolio.",
              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            _buildFieldLabel("Summary"),
            _buildCustomTextField(
              controller: _summaryController,
              maxLines: 4,
              hint: "",
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            Text(
              "${_summaryController.text.length}/700. Two or three lines on what you do and what you are looking for.",
              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E293B),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }

  // 4. Download Bar Card
  Widget _buildDownloadBarCard() {
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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 450;
              final downloadTitle = Text(
                "Download",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              );

              final downloadButtons = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Preparing PDF download...", style: GoogleFonts.poppins(color: Colors.white)),
                          backgroundColor: const Color(0xFF2A3B8F),
                        ),
                      );
                    },
                    icon: const Icon(Icons.picture_as_pdf, size: 14, color: Colors.white),
                    label: Text("PDF", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A3B8F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Downloading Word document...", style: GoogleFonts.poppins(color: Colors.white)),
                          backgroundColor: const Color(0xFF334155),
                        ),
                      );
                    },
                    icon: const Icon(Icons.description_outlined, size: 14, color: Color(0xFF334155)),
                    label: Text("Word", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Downloading plain text version...", style: GoogleFonts.poppins(color: Colors.white)),
                          backgroundColor: const Color(0xFF334155),
                        ),
                      );
                    },
                    icon: const Icon(Icons.text_snippet_outlined, size: 14, color: Color(0xFF334155)),
                    label: Text("Text", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    downloadTitle,
                    const SizedBox(height: 10),
                    downloadButtons,
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  downloadTitle,
                  downloadButtons,
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            "PDF opens your browser's print window; choose \"Save as PDF\" as the destination. Word opens in Word, Google Docs and Pages.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // 5. Live Document Preview Container
  Widget _buildResumeDocumentPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F5F0), // Ivory / sandy surface from screenshot
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered Header
            Text(
              _nameController.text.isNotEmpty ? _nameController.text : "Anand Kumar",
              textAlign: TextAlign.center,
              style: _selectedTemplate == "Classic"
                  ? GoogleFonts.merriweather(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    )
                  : GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _selectedTemplate == "Modern" ? const Color(0xFF0D9488) : const Color(0xFF0F172A),
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              _headlineController.text.isNotEmpty
                  ? _headlineController.text
                  : "B.E. Computer Science & Engineering student · Computer Science & Engineering",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF334155),
              ),
            ),
            if (_emailController.text.isNotEmpty || _locationController.text.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                [
                  if (_emailController.text.isNotEmpty) _emailController.text,
                  if (_phoneController.text.isNotEmpty) _phoneController.text,
                  if (_locationController.text.isNotEmpty) _locationController.text,
                ].join(" · "),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
            const SizedBox(height: 22),

            // Education Section
            _buildResumeSection(
              title: "EDUCATION",
              content: _eduController.text.isNotEmpty
                  ? _eduController.text
                  : "B.E. Computer Science & Engineering, Computer Science & Engineering — Anna Institute of Technology",
            ),
            const SizedBox(height: 18),

            // Skills Section
            _buildResumeSection(
              title: "SKILLS",
              content: _skillsController.text.isNotEmpty
                  ? _skillsController.text
                  : "Database Management Systems · Operating Systems · Computer Networks · Machine Learning · Algorithms & Complexity · Problem Solving with Python",
            ),

            if (_projectsController.text.trim().isNotEmpty) ...[
              const SizedBox(height: 18),
              _buildResumeSection(
                title: "PROJECTS",
                content: _projectsController.text,
              ),
            ],

            if (_expController.text.trim().isNotEmpty) ...[
              const SizedBox(height: 18),
              _buildResumeSection(
                title: "EXPERIENCE",
                content: _expController.text,
              ),
            ],

            if (_achieveController.text.trim().isNotEmpty) ...[
              const SizedBox(height: 18),
              _buildResumeSection(
                title: "CERTIFICATIONS & ACHIEVEMENTS",
                content: _achieveController.text,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResumeSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        const Divider(height: 1, thickness: 1, color: Color(0xFFCBD5E1)),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF334155),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // 6. Completeness Card (Bottom Left)
  Widget _buildCompletenessCard() {
    final items = [
      {"label": "Name and email", "done": false},
      {"label": "A short summary", "done": false},
      {"label": "Education", "done": true},
      {"label": "At least 6 skills", "done": true},
      {"label": "A project with bullet points", "done": false},
      {"label": "Experience or leadership", "done": false},
      {"label": "A link (GitHub or LinkedIn)", "done": false},
      {"label": "Certifications or achievements", "done": false},
    ];

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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Completeness",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "2 of 8 done",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 2.0 / 8.0,
              minHeight: 5,
              backgroundColor: Color(0xFFFEE2E2),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB91C1C)),
            ),
          ),
          const SizedBox(height: 18),
          ...items.map((item) {
            final bool isDone = item["done"] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Row(
                children: [
                  isDone
                      ? const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF0D9488))
                      : Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF94A3B8), width: 1.5),
                          ),
                        ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDone ? const Color(0xFF0D9488) : const Color(0xFF475569),
                        fontWeight: isDone ? FontWeight.w500 : FontWeight.w400,
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

  // 7. ATS Check Card (Bottom Right)
  Widget _buildAtsCheckCard() {
    final keywords = [
      {"name": "algorithms", "matched": true},
      {"name": "python", "matched": true},
      {"name": "+ data structures", "matched": false},
      {"name": "+ java", "matched": false},
      {"name": "+ sql", "matched": false},
      {"name": "+ git", "matched": false},
      {"name": "+ rest", "matched": false},
      {"name": "+ api", "matched": false},
      {"name": "+ testing", "matched": false},
      {"name": "+ docker", "matched": false},
    ];

    final diagnostics = [
      {
        "status": "fail",
        "title": "Contact & links",
        "desc": "Add GitHub / portfolio link.",
      },
      {
        "status": "pass",
        "title": "Education",
        "desc": "Include CGPA and expected graduation.",
      },
      {
        "status": "warn",
        "title": "Skills",
        "desc": "2 of 10 role keywords found.",
      },
      {
        "status": "fail",
        "title": "Projects",
        "desc": "Quantify impact (e.g. \"reduced latency 30%\").",
      },
      {
        "status": "warn",
        "title": "Experience / internships",
        "desc": "List internships, freelance or open-source work.",
      },
      {
        "status": "warn",
        "title": "Certifications & achievements",
        "desc": "Add verified certifications and competition results.",
      },
    ];

    final bullets = [
      "Start each bullet with a strong action verb (Built, Designed, Reduced).",
      "Keep to one page for fresher roles; use a simple single-column layout for ATS parsing.",
      "Where genuinely true, mention: data structures, java, sql, git.",
      "Avoid tables, text boxes and images — many ATS parsers skip them.",
    ];

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
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ATS check",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Keywords, structure and missing sections, read from the text of this resume.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Role dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTargetRole,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedTargetRole = val;
                    });
                  }
                },
                items: _roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Check my resume button
          ElevatedButton.icon(
            onPressed: _isAnalysing ? null : _checkResume,
            icon: _isAnalysing
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.crop_free, size: 16),
            label: Text(
              _isAnalysing ? "Analyzing resume..." : "Check my resume",
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A3B8F),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
          ),
          const SizedBox(height: 20),

          // ATS readiness section
          Text(
            "ATS readiness for $_selectedTargetRole",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$_atsScore",
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _atsScore / 100.0,
              minHeight: 6,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC2410C)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "An indicator of parse-ability and keyword coverage, not a hiring prediction.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Keyword chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: keywords.map((kw) {
              final isMatched = kw["matched"] as bool;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isMatched ? const Color(0xFFCCFBF1) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  kw["name"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isMatched ? const Color(0xFF0F766E) : const Color(0xFF475569),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // 6 Diagnostics Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth > 580;
              if (isTwoCol) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDiagnosticTile(diagnostics[0])),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDiagnosticTile(diagnostics[1])),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDiagnosticTile(diagnostics[2])),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDiagnosticTile(diagnostics[3])),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDiagnosticTile(diagnostics[4])),
                        const SizedBox(width: 12),
                        Expanded(child: _buildDiagnosticTile(diagnostics[5])),
                      ],
                    ),
                  ],
                );
              }

              return Column(
                children: diagnostics.map((d) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildDiagnosticTile(d),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Recommendations Bullets
          ...bullets.map((bullet) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("•  ", style: TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.4)),
                  Expanded(
                    child: Text(
                      bullet,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),

          // AI generated disclaimer
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: Color(0xFFD97706)),
              const SizedBox(width: 6),
              Text(
                "AI-generated — verify important details",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFD97706),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosticTile(Map<String, String> item) {
    IconData iconData;
    Color iconColor;

    switch (item["status"]) {
      case "pass":
        iconData = Icons.check_circle_outline;
        iconColor = const Color(0xFF0D9488);
        break;
      case "warn":
        iconData = Icons.info_outline;
        iconColor = const Color(0xFFD97706);
        break;
      case "fail":
      default:
        iconData = Icons.cancel_outlined;
        iconColor = const Color(0xFFDC2626);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: 16, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item["desc"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// ─────────────────────────────────────────────────────────────────────────────
class JobPrepScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const JobPrepScreen({super.key, this.onBack});

  @override
  State<JobPrepScreen> createState() => _JobPrepScreenState();
}

class _JobPrepScreenState extends State<JobPrepScreen> {
  String _selectedRole = "Software Engineer";
  String _selectedCompany = "Product company";
  final TextEditingController _weeksController = TextEditingController(text: "8");
  bool _isGenerating = false;
  bool _hasGenerated = false;

  @override
  void dispose() {
    _weeksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Job Preparation",
      category: "Career",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Job Preparation",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.work_outline,
          title: "Job Preparation",
          subtitle: "Pick a role and company type — get skills, roadmap, coding, aptitude and interview prep.",
          watermarkIcon: Icons.work_outline,
        ),
        const SizedBox(height: 20),

        // 2-Column Responsive Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 320, child: _buildInputsCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildOutputCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildInputsCard(),
                const SizedBox(height: 20),
                _buildOutputCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInputsCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Inputs",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Career Coach",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // Target Role
          Text("Target role", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedRole,
                isExpanded: true,
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                items: const [
                  DropdownMenuItem(value: "Software Engineer", child: Text("Software Engineer")),
                  DropdownMenuItem(value: "Data Analyst", child: Text("Data Analyst")),
                  DropdownMenuItem(value: "Data Scientist", child: Text("Data Scientist")),
                  DropdownMenuItem(value: "Cloud Engineer", child: Text("Cloud Engineer")),
                  DropdownMenuItem(value: "Product Manager", child: Text("Product Manager")),
                  DropdownMenuItem(value: "Core Engineering (GET)", child: Text("Core Engineering (GET)")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRole = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Company type
          Text("Company type", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCompany,
                isExpanded: true,
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                items: const [
                  DropdownMenuItem(value: "Product company", child: Text("Product company")),
                  DropdownMenuItem(value: "IT services", child: Text("IT services")),
                  DropdownMenuItem(value: "Startup", child: Text("Startup")),
                  DropdownMenuItem(value: "PSU / Government", child: Text("PSU / Government")),
                  DropdownMenuItem(value: "Core engineering", child: Text("Core engineering")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCompany = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Weeks available
          Text("Weeks available", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          TextField(
            controller: _weeksController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
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
          const SizedBox(height: 20),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isGenerating
                  ? null
                  : () async {
                      setState(() => _isGenerating = true);
                      await Future.delayed(const Duration(milliseconds: 800));
                      setState(() {
                        _isGenerating = false;
                        _hasGenerated = true;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF283675),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              icon: _isGenerating
                  ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
              label: Text(
                _isGenerating ? "Building plan..." : "Build my preparation plan",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 340),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Output",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          if (!_hasGenerated)
            Container(
              width: double.infinity,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _LightBlueprintGridPainter(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Nothing generated yet",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Fill in the inputs and generate. Output is a draft for you to review\nand edit.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else ...[
            Container(
              padding: const EdgeInsets.all(18),
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
                      Expanded(
                        child: Text(
                          "$_selectedRole — $_selectedCompany Roadmap (${_weeksController.text} Weeks)",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(6)),
                        child: Text("Ready to follow", style: GoogleFonts.poppins(color: const Color(0xFF4338CA), fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildPrepStep("Weeks 1-2", "Core Data Structures & Complexity", "Arrays, Strings, HashMaps, Two-Pointer problems on LeetCode / HackerRank."),
                  _buildPrepStep("Weeks 3-4", "Advanced Algorithms & Trees", "Binary Trees, BFS/DFS traversals, Dynamic Programming fundamentals."),
                  _buildPrepStep("Weeks 5-6", "System Design & CS Fundamentals", "OS Paging, DB Indexing, REST API design, caching and concurrency."),
                  _buildPrepStep("Weeks 7-8", "Mock Interviews & Behavioral Polish", "Live technical mock interviews, STAR stories, company-specific past questions."),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrepStep(String timing, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(6)),
            child: Text(timing, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                Text(desc, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 4. AI Mock Interview Screen (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class MockInterviewScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const MockInterviewScreen({super.key, this.onBack});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  String _selectedMode = "Technical";
  bool _isInInterview = false;
  final TextEditingController _answerController = TextEditingController();

  final List<Map<String, String>> _modes = [
    {"id": "Technical", "title": "Technical", "desc": "Projects, CS fundamentals, design"},
    {"id": "HR", "title": "HR", "desc": "Motivation, fit, career goals"},
    {"id": "Behavioural", "title": "Behavioural", "desc": "STAR-format situations"},
  ];

  final List<String> _otherPills = [
    "Domain-specific · Phase 2",
    "Placement · Phase 2",
    "Internship · Phase 2",
    "Startup · Phase 2",
    "Management · Phase 2",
    "Government job · Phase 2",
  ];

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "AI Mock Interview",
      category: "Career",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  AI Mock Interview",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.mic_none_outlined,
          title: "AI Mock Interview",
          subtitle: "Technical, HR, behavioural and domain interviews with a readiness scorecard.",
          watermarkIcon: Icons.mic_none_outlined,
        ),
        const SizedBox(height: 20),

        if (!_isInInterview)
          // Setup View (Matching Image 5)
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 14, child: _buildModeChooserCard()),
                    const SizedBox(width: 20),
                    Expanded(flex: 8, child: _buildNoticesColumn()),
                  ],
                );
              }
              return Column(
                children: [
                  _buildModeChooserCard(),
                  const SizedBox(height: 16),
                  _buildNoticesColumn(),
                ],
              );
            },
          )
        else
          // Live Interview Simulation
          _buildActiveInterviewCard(),
      ],
    );
  }

  Widget _buildModeChooserCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose an interview",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "The AI asks follow-up questions based on your previous answers.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // 3 Selectable Mode Cards in a row / column
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 550;
              if (isWide) {
                return Row(
                  children: _modes.map((m) {
                    final isSelected = _selectedMode == m["id"];
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _buildModeItem(m, isSelected),
                      ),
                    );
                  }).toList(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _modes.map((m) {
                  final isSelected = _selectedMode == m["id"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildModeItem(m, isSelected),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 16),

          // Secondary pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _otherPills.map((pill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  pill,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),

          // Start button
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 450;
              return SizedBox(
                width: isSmall ? double.infinity : null,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isInInterview = true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                  label: Text(
                    "Start mock interview",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModeItem(Map<String, String> m, bool isSelected) {
    return InkWell(
      onTap: () => setState(() => _selectedMode = m["id"]!),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4338CA) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              m["title"]!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF4338CA) : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              m["desc"]!,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticesColumn() {
    return Column(
      children: [
        // Notice 1: Sky Blue
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "The AI analyses content, technical accuracy, clarity, structure, filler words, response time and relevance. Confidence indicators are coaching hints, not judgements about you.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF1E3A8A),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Notice 2: Green / Mint
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBBF7D0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user_outlined, color: Color(0xFF16A34A), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Voice practice uses your microphone only while you are recording, and audio is not stored by default.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF14532D),
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

  Widget _buildActiveInterviewCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "$_selectedMode Interview Session",
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => setState(() => _isInInterview = false),
                icon: const Icon(Icons.close, size: 16, color: Color(0xFFDC2626)),
                label: const Text("End Interview", style: TextStyle(color: Color(0xFFDC2626))),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 14),
          // Question bubble
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primaryBlue,
                  child: Icon(Icons.smart_toy_outlined, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Interviewer", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFF1E293B))),
                      const SizedBox(height: 4),
                      Text(
                        _selectedMode == "Technical"
                            ? "Tell me about the architecture of Smart Campus AI. How did you handle face embeddings at scale without high latency?"
                            : "Can you tell me about a time you faced a difficult conflict in a group project and how you resolved it using the STAR approach?",
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF334155), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Answer field
          TextField(
            controller: _answerController,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Type your answer or use microphone to speak...",
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
            ),
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Answer submitted. Scoring feedback in progress...")));
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                icon: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
                label: const Text("Submit Answer", style: TextStyle(color: Colors.white)),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Microphone active... speak clearly.")));
                },
                icon: const Icon(Icons.mic, size: 16),
                label: const Text("Record Voice"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 5. Opportunity Marketplace Screen (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class OpportunityMarketplaceScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const OpportunityMarketplaceScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final opportunities = [
      {
        "tag": "Internship",
        "tagColor": const Color(0xFF0D9488),
        "tagBg": const Color(0xFFF0FDFA),
        "badge": "92% match",
        "title": "Data Analyst Intern — Tiger Analytics",
        "desc": "SQL, Python, dashboards · Chennai",
        "progress": 0.92,
      },
      {
        "tag": "Hackathon",
        "tagColor": const Color(0xFFD97706),
        "tagBg": const Color(0xFFFFFBEB),
        "badge": "Registrations close Oct 12",
        "title": "HackTN 2026",
        "desc": "State-level hackathon, ₹5L prize pool",
      },
      {
        "tag": "Mentor",
        "tagColor": const Color(0xFF6366F1),
        "tagBg": const Color(0xFFEEF2FF),
        "badge": "Accepting mentees",
        "title": "Mentor: Priya S. (Data Scientist, Freshworks)",
        "desc": "Alumnus, batch 2016",
      },
      {
        "tag": "Workshop",
        "tagColor": const Color(0xFF0284C7),
        "tagBg": const Color(0xFFF0F9FF),
        "badge": "Free",
        "title": "Workshop: Kaggle for beginners",
        "desc": "Coding Club · Oct 9",
      },
      {
        "tag": "Certification",
        "tagColor": const Color(0xFFD97706),
        "tagBg": const Color(0xFFFFFBEB),
        "badge": "Sponsored seats: 20",
        "title": "Cloud fundamentals certification",
        "desc": "Recommended by your skill graph",
      },
      {
        "tag": "Project",
        "tagColor": const Color(0xFF0D9488),
        "tagBg": const Color(0xFFF0FDFA),
        "badge": "Stipend",
        "title": "Research assistant — IoT lab",
        "desc": "Faculty project, 6 months",
      },
    ];

    return PortalPageBody(
      title: "Opportunity Marketplace",
      category: "Career",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Opportunity Marketplace",
          category: "CAREER",
          phase: "Phase 4",
          isMvp: false,
          icon: Icons.storefront_outlined,
          title: "Opportunity Marketplace",
          subtitle: "Internships, jobs, hackathons, mentors and workshops matched to your verified profile.",
          watermarkIcon: Icons.storefront_outlined,
        ),
        const SizedBox(height: 20),

        // Responsive Cards Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth >= 950 ? 3 : (constraints.maxWidth >= 600 ? 2 : 1);
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: opportunities.map((op) {
                final width = crossAxisCount == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - (16 * (crossAxisCount - 1))) / crossAxisCount;

                return SizedBox(
                  width: width,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: op["tagBg"] as Color,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  op["tag"] as String,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: op["tagColor"] as Color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                op["badge"] as String,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          op["title"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          op["desc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        if (op["progress"] != null) ...[
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: op["progress"] as double,
                              minHeight: 5,
                              backgroundColor: const Color(0xFFF1F5F9),
                              valueColor: const AlwaysStoppedAnimation(Color(0xFF0D9488)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 6. Career Readiness Screen (Image 2)
/// ─────────────────────────────────────────────────────────────────────────────
class CareerReadinessScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const CareerReadinessScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Career Readiness",
      category: "Career",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Career  ›  Career Readiness",
          category: "CAREER",
          phase: "MVP",
          isMvp: true,
          icon: Icons.speed_outlined,
          title: "Career Readiness",
          subtitle: "Dimension-level readiness — not a single score that decides hiring.",
          watermarkIcon: Icons.speed_outlined,
        ),
        const SizedBox(height: 20),

        // Top Row: Radar Chart + Dimensions
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 12, child: _buildRadarCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 10, child: _buildDimensionsCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildRadarCard(),
                const SizedBox(height: 16),
                _buildDimensionsCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Bottom Row: Strengths, Gaps, Improvement plan
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildStrengthsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGapsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPlanCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildStrengthsCard(),
                const SizedBox(height: 16),
                _buildGapsCard(),
                const SizedBox(height: 16),
                _buildPlanCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRadarCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Career readiness by dimension",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: LayoutBuilder(
              builder: (context, c) {
                final chartWidth = math.min(c.maxWidth, 320.0);
                return SizedBox(
                  height: 290,
                  width: chartWidth,
                  child: CustomPaint(
                    painter: _RadarChartPainter(
                      labels: const [
                        "Academic",
                        "Technical skills",
                        "Communication",
                        "Projects",
                        "Certifications",
                        "Resume",
                        "Interview",
                        "Industry exposure"
                      ],
                      currentValues: const [78, 71, 59, 74, 50, 82, 48, 30],
                      targetValues: const [75, 80, 75, 70, 60, 80, 75, 60],
                      maxValue: 100,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Current", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
              const SizedBox(width: 20),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD97706), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Target", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFFD97706))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsCard() => const _CareerReadinessDimensionsCard();

  Widget _buildStrengthsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF0D9488), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Academic and project dimensions meet target",
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGapsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error_outline_rounded, color: Color(0xFFD97706), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Interview and industry exposure are the largest gaps",
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    const items = [
      "Mock interviews: technical + HR",
      "Attend 2 alumni sessions",
      "Apply for one internship this month",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${entry.key + 1}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.4),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _CareerReadinessDimensionsCard extends StatefulWidget {
  const _CareerReadinessDimensionsCard();

  @override
  State<_CareerReadinessDimensionsCard> createState() => _CareerReadinessDimensionsCardState();
}

class _CareerReadinessDimensionsCardState extends State<_CareerReadinessDimensionsCard> {
  int _animVersion = 0;

  @override
  Widget build(BuildContext context) {
    final dimensions = [
      {"name": "Academic", "score": 78, "target": 75, "color": const Color(0xFF0D9488)},
      {"name": "Technical skills", "score": 71, "target": 80, "color": AppColors.primaryBlue},
      {"name": "Communication", "score": 59, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Projects", "score": 74, "target": 70, "color": const Color(0xFF0D9488)},
      {"name": "Certifications", "score": 50, "target": 60, "color": const Color(0xFFD97706)},
      {"name": "Resume", "score": 82, "target": 80, "color": const Color(0xFF0D9488)},
      {"name": "Interview", "score": 48, "target": 75, "color": const Color(0xFFD97706)},
      {"name": "Industry exposure", "score": 30, "target": 60, "color": const Color(0xFFDC2626)},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                    "Dimensions",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  TweenAnimationBuilder<double>(
                    key: ValueKey("overall_$_animVersion"),
                    tween: Tween<double>(begin: 0.0, end: 62.0),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) => Text(
                      "Overall ${val.round()}%",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => setState(() => _animVersion++),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh_rounded, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Text(
                        "Replay",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...dimensions.asMap().entries.map((entry) {
            final index = entry.key;
            final d = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnimatedDimensionProgressBar(
                name: d["name"] as String,
                score: d["score"] as int,
                target: d["target"] as int,
                color: d["color"] as Color,
                index: index,
                replayKey: ValueKey("dim_${index}_$_animVersion"),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Light Blueprint Grid Painter for empty states
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
