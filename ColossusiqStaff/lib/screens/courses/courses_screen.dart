import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_progress.dart';
import '../../data/mock_data.dart';
import '../../data/models/course_model.dart';
import 'course_reader_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _selectedDept = "All";

  @override
  void initState() {
    super.initState();
    MockData.courseUpdateNotifier.addListener(_onCoursesChanged);
  }

  @override
  void dispose() {
    MockData.courseUpdateNotifier.removeListener(_onCoursesChanged);
    super.dispose();
  }

  void _onCoursesChanged() {
    if (mounted) setState(() {});
  }

  static const List<Map<String, dynamic>> _steps = [
    {
      "step": "1. Read the lessons",
      "desc": "Published by your department, unit by unit.",
      "icon": Icons.auto_stories_outlined,
    },
    {
      "step": "2. Complete each lesson",
      "desc": "Mark it complete to unlock the next one.",
      "icon": Icons.check_circle_outline,
    },
    {
      "step": "3. Final assessment",
      "desc": "30 questions from what you read.",
      "icon": Icons.quiz_outlined,
    },
    {
      "step": "4. Get your certificate",
      "desc": "Graded by your marks, verifiable online.",
      "icon": Icons.workspace_premium_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final allCourses = MockData.courses;
    final depts = [
      "All",
      "Artificial Intelligence & Data Science",
      "Computer Science & Engineering",
    ];

    final filteredCourses = _selectedDept == "All"
        ? allCourses
        : allCourses.where((c) => c.department == _selectedDept).toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 95),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blueprint Hero Header Banner matching Image 1
            _buildBlueprintHero(),
            const SizedBox(height: 18),

            // 4 Steps Row
            _buildStepsBar(),
            const SizedBox(height: 20),

            // Department Filters
            _buildDeptFilters(depts),
            const SizedBox(height: 18),

            // Course Cards Grid/List
            LayoutBuilder(
              builder: (context, constraints) {
                // If wide enough (tablet / desktop), show grid, otherwise list
                if (constraints.maxWidth > 900) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) =>
                        _buildCourseCard(context, filteredCourses[index]),
                  );
                } else if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) =>
                        _buildCourseCard(context, filteredCourses[index]),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredCourses.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];
                    return _buildCourseCard(context, course);
                  },
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBlueprintHero() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
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
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Blueprint Grid overlay pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Large watermark icon on right
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.auto_stories_rounded,
                size: 155,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
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
                          "Academics",
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
                          "My Courses",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_stories_rounded,
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
                            Row(
                              children: [
                                _buildPillBadge("ACADEMICS",
                                    bg: Colors.white.withValues(alpha: 0.14),
                                    fg: Colors.white),
                                const SizedBox(width: 6),
                                _buildPillBadge("MVP",
                                    bg: const Color(0xFF059669),
                                    fg: Colors.white),
                              ],
                            ),
                            const SizedBox(height: 5),

                            // Title
                            Text(
                              "My Courses",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle
                            Text(
                              "Courses published by your department — read each lesson, then take the 30-question final assessment for your certificate.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: Colors.white.withValues(alpha: 0.82),
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
          ],
        ),
      ),
    );
  }

  Widget _buildPillBadge(String label, {required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildStepsBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 750) {
          return Row(
            children: _steps.map((s) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(s["icon"] as IconData,
                            size: 18, color: const Color(0xFF475569)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s["step"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              s["desc"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.ink3,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }

        return Column(
          children: _steps.map((s) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.line),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(s["icon"] as IconData,
                        size: 18, color: AppColors.brand),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s["step"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          s["desc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.ink3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildDeptFilters(List<String> depts) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: depts.map((d) {
          final isSelected = _selectedDept == d;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedDept = d),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryBlue : AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.border,
                  ),
                ),
                child: Text(
                  d,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    final latestCourse = MockData.getCourse(course.id);
    final completedCount = latestCourse.currentCompletedCount;
    final totalCount = latestCourse.totalLessons;
    final pct =
        totalCount > 0 ? ((completedCount / totalCount) * 100).round() : 0;
    final isDone = pct == 100;
    final hasCertificate = latestCourse.certificateId != null;

    String actionLabel = "Start course →";
    Color btnColor = const Color(0xFF1E2865);
    Color btnFgColor = Colors.white;

    if (hasCertificate || isDone) {
      actionLabel = "Review course →";
    } else if (latestCourse.finalUnlocked) {
      actionLabel = "Take final assessment →";
    } else if (completedCount > 0) {
      actionLabel = "Continue →";
    }

    return AppCard(
      clip: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indigo Header Block matching reference design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF2E3A94),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        course.department,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ),
                    Text(
                      course.code,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  course.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${course.facultyName} · ${course.term} · ${course.credits} credits",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Body Block
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.ink2,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),

                // Meta Info Row
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    _buildMetaChip(Icons.layers_outlined,
                        "${course.totalChapters} chapters"),
                    _buildMetaChip(Icons.menu_book_outlined,
                        "${course.totalLessons} lessons"),
                    _buildMetaChip(Icons.schedule_rounded, course.hours),
                  ],
                ),
                const SizedBox(height: 14),

                // Progress Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "$completedCount of $totalCount lessons",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.ink3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$pct%",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppLinearProgress(
                  value: pct.toDouble(),
                  color: isDone ? AppColors.teal : AppColors.brand,
                  height: 5,
                ),
                const SizedBox(height: 12),

                // Lock/Certificate Status
                if (hasCertificate)
                  Row(
                    children: [
                      const Icon(Icons.workspace_premium,
                          color: AppColors.teal, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Certificate earned · best 100%",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.teal,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (latestCourse.finalUnlocked)
                  Row(
                    children: [
                      const Icon(Icons.lock_open_rounded,
                          color: AppColors.brand, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Final assessment unlocked",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.lock_outline,
                          color: AppColors.ink3, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Final assessment unlocks after all lessons",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.ink3,
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseReaderScreen(course: latestCourse),
                        ),
                      ).then((_) {
                        // Refresh screen on return in case lessons were completed
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      foregroundColor: btnFgColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      actionLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
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

  Widget _buildMetaChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.ink3),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.ink3,
          ),
        ),
      ],
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
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
