import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/app_progress.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../data/models/course_model.dart';
import '../../data/mock_data.dart';

// =============================================================================
// STUDENT: COURSE READER & LESSON PLAYER SCREEN
// Matches Image 4 (media_1793783519644_65c8419b.jpg) & Image 5 (media_1793783531790_b55f4c7f.jpg)
// =============================================================================

class CourseReaderScreen extends StatefulWidget {
  final Course course;

  const CourseReaderScreen({super.key, required this.course});

  @override
  State<CourseReaderScreen> createState() => _CourseReaderScreenState();
}

class _CourseReaderScreenState extends State<CourseReaderScreen> {
  late List<CourseUnit> _units;
  late List<Lesson> _linearLessons;
  late Set<String> _completedLessonIds;
  int _currentLessonIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final Map<String, bool> _revealedAnswers = {};

  @override
  void initState() {
    super.initState();
    final latestCourse = MockData.getCourse(widget.course.id);
    _units = latestCourse.units;

    // Flatten all lessons into linear list
    _linearLessons = [];
    for (final u in _units) {
      _linearLessons.addAll(u.lessons);
    }

    _completedLessonIds = {};
    for (final l in _linearLessons) {
      if (l.isCompleted) {
        _completedLessonIds.add(l.id);
      }
    }

    // Default to first unfinished lesson, or first lesson
    final firstUnfinished =
        _linearLessons.indexWhere((l) => !_completedLessonIds.contains(l.id));
    _currentLessonIndex = firstUnfinished >= 0 ? firstUnfinished : 0;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Lesson get _currentLesson => _linearLessons[_currentLessonIndex];

  bool _isLessonUnlocked(int index) {
    if (index == 0) return true;
    return _completedLessonIds.contains(_linearLessons[index - 1].id) ||
        _completedLessonIds.contains(_linearLessons[index].id);
  }

  void _onSelectLesson(int index) {
    if (!_isLessonUnlocked(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complete previous lessons to unlock this lesson."),
          backgroundColor: Color(0xFF1E2865),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _currentLessonIndex = index;
    });

    _scrollToTop();
  }

  void _markCompleteAndNext() {
    final cur = _currentLesson;
    final bool hasNext = _currentLessonIndex < _linearLessons.length - 1;

    if (!_completedLessonIds.contains(cur.id)) {
      MockData.markLessonComplete(widget.course.id, cur.id);
    }

    setState(() {
      _completedLessonIds.add(cur.id);

      if (hasNext) {
        _currentLessonIndex++;
      }
    });

    final nextTitle = _linearLessons[_currentLessonIndex].title;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          hasNext
              ? "Opening next lesson: $nextTitle"
              : "Course completed! 30-question final assessment unlocked.",
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 2000),
      ),
    );

    _scrollToTop();
  }

  void _goToPrevious() {
    if (_currentLessonIndex > 0) {
      setState(() {
        _currentLessonIndex--;
      });
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _completedLessonIds.length;
    final totalCount = _linearLessons.length;
    final pct =
        totalCount > 0 ? ((completedCount / totalCount) * 100).round() : 0;
    final isAllDone = completedCount >= totalCount;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F5),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 95),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Blueprint Hero Banner matching Image 4
              const BlueprintHeroBanner(
                breadcrumb: "Home  ›  Academics  ›  My Courses",
                category: "ACADEMICS",
                phase: "MVP",
                isMvp: true,
                icon: Icons.auto_stories_rounded,
                title: "My Courses",
                subtitle:
                    "Courses published by your department — read each lesson, then take the 30-question final assessment for your certificate.",
                watermarkIcon: Icons.auto_stories_rounded,
              ),
              const SizedBox(height: 16),

              // 2. Sub-navigation Bar: ← All courses + Course Meta
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back,
                              size: 15, color: Color(0xFF1E2865)),
                          const SizedBox(width: 6),
                          Text(
                            "All courses",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${widget.course.code} · ${widget.course.department} · ${widget.course.facultyName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3. Responsive 2-Column Desktop / Stacked Mobile Layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 920;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Sidebar: Curriculum Outline Card (310px)
                        SizedBox(
                          width: 310,
                          child: _buildCurriculumCard(
                              completedCount, totalCount, pct, isAllDone),
                        ),
                        const SizedBox(width: 20),

                        // Right Main Lesson Content
                        Expanded(
                          child: _buildMainLessonCard(pct),
                        ),
                      ],
                    );
                  }

                  // Mobile / Tablet View
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCurriculumAccordion(
                          completedCount, totalCount, pct, isAllDone),
                      const SizedBox(height: 16),
                      _buildMainLessonCard(pct),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Left Sidebar: Curriculum Card matching Image 4
  // ---------------------------------------------------------------------------
  Widget _buildCurriculumCard(
      int completed, int total, int pct, bool isAllDone) {
    return Container(
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
          // Header: Course Title & Progress
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$completed of $total lessons",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      "$pct%",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppLinearProgress(
                  value: pct.toDouble(),
                  color: isAllDone
                      ? const Color(0xFF0F766E)
                      : const Color(0xFF1E2865),
                  height: 5,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Chapters & Lessons List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final unit in _units) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 12, bottom: 6),
                    child: Text(
                      "${unit.part.toUpperCase()} · ${unit.title.toUpperCase()}",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  for (final lesson in unit.lessons)
                    _buildCurriculumLessonTile(lesson),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumAccordion(
      int completed, int total, int pct, bool isAllDone) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            widget.course.title,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$completed of $total lessons",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    "$pct%",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AppLinearProgress(
                value: pct.toDouble(),
                color: isAllDone
                    ? const Color(0xFF0F766E)
                    : const Color(0xFF1E2865),
                height: 4,
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                children: [
                  for (final unit in _units) ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 10, bottom: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${unit.part.toUpperCase()} · ${unit.title.toUpperCase()}",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                    for (final lesson in unit.lessons)
                      _buildCurriculumLessonTile(lesson),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumLessonTile(Lesson lesson) {
    final index = _linearLessons.indexWhere((l) => l.id == lesson.id);
    final isSelected = index == _currentLessonIndex;
    final isDone = _completedLessonIds.contains(lesson.id);
    final isUnlocked = _isLessonUnlocked(index);

    return InkWell(
      onTap: () => _onSelectLesson(index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (isDone)
              const Icon(Icons.check_circle_rounded,
                  size: 15, color: Color(0xFF0F766E))
            else if (!isUnlocked)
              const Icon(Icons.lock_outline,
                  size: 15, color: Color(0xFF94A3B8))
            else if (isSelected)
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2E3A94), width: 1.5),
                ),
              )
            else
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                lesson.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF1E2865)
                      : isUnlocked
                          ? const Color(0xFF334155)
                          : const Color(0xFF94A3B8),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              lesson.duration,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: isSelected
                    ? const Color(0xFF1E2865)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Right Main Lesson Content Card matching Image 4 & Image 5
  // ---------------------------------------------------------------------------
  Widget _buildMainLessonCard(int coursePct) {
    final cur = _currentLesson;
    final isLast = _currentLessonIndex == _linearLessons.length - 1;

    return Container(
      width: double.infinity,
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
          // Header Category & Main Title
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cur.chapterTitle.toUpperCase()} · LESSON ${_currentLessonIndex + 1} OF ${_linearLessons.length} · ~${cur.duration.toUpperCase()}",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${cur.chapterTitle} — ${cur.title.toLowerCase()}",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Render dynamic lesson body based on layoutKind
                if (cur.layoutKind == 'overview') ...[
                  _buildOverviewContent(cur),
                ] else if (cur.layoutKind == 'concepts') ...[
                  _buildConceptsContent(cur),
                ] else if (cur.layoutKind == 'example') ...[
                  _buildWorkedExampleContent(cur),
                ] else ...[
                  _buildPracticeAndRecapContent(cur),
                ],
              ],
            ),
          ),

          // Bottom Bar: Responsive Previous + Mark complete & next (Never Overflows)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 460;

                final prevBtn = OutlinedButton(
                  onPressed: _currentLessonIndex > 0 ? _goToPrevious : null,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    foregroundColor: const Color(0xFF334155),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "← Previous",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );

                final isCurrentDone = _completedLessonIds.contains(_currentLesson.id);
                final nextBtn = ElevatedButton(
                  onPressed: _markCompleteAndNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isLast
                        ? (isCurrentDone ? "Course completed" : "Mark complete & finish course")
                        : (isCurrentDone ? "Next lesson →" : "Mark complete & next →"),
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      nextBtn,
                      if (_currentLessonIndex > 0) ...[
                        const SizedBox(height: 10),
                        prevBtn,
                      ],
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentLessonIndex > 0)
                      prevBtn
                    else
                      const SizedBox.shrink(),
                    nextBtn,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Practice & Recap Layout (Images 4 & 5)
  // ---------------------------------------------------------------------------
  Widget _buildPracticeAndRecapContent(Lesson cur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTealHeroBanner(cur),
        const SizedBox(height: 20),
        _buildObjectivesBox(cur),
        const SizedBox(height: 22),
        Text(
          "Recap",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Before moving on, make sure you can explain every item in the checklist without looking back.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF475569),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          "Practice",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Write or say your answer first, then reveal the model answer and compare. If you missed something, reopen the concepts lesson of this chapter.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF475569),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 22),
        _buildRecallSection(cur),
        const SizedBox(height: 20),
        _buildPracticeQuestionsSection(cur),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Key Concepts Layout
  // ---------------------------------------------------------------------------
  Widget _buildConceptsContent(Lesson cur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTealHeroBanner(cur),
        const SizedBox(height: 20),
        _buildObjectivesBox(cur),
        const SizedBox(height: 22),
        Text(
          "Concept Overview",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          cur.body,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF334155),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 22),
        if (cur.keyPoints.isNotEmpty) ...[
          Text(
            "Key Points & Principles",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          for (final kp in cur.keyPoints)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(Icons.check_circle_rounded,
                        size: 14, color: Color(0xFF0F766E)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      kp,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
        ],
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDBEAFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline,
                  color: Color(0xFF2E3A94), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Faculty Advice: Review each point carefully. Questions on the final assessment are drawn directly from these concepts.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF1E3A8A),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. Worked Example Layout
  // ---------------------------------------------------------------------------
  Widget _buildWorkedExampleContent(Lesson cur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTealHeroBanner(cur),
        const SizedBox(height: 20),
        _buildObjectivesBox(cur),
        const SizedBox(height: 22),
        Text(
          "Worked Implementation",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            cur.body,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12.5,
              color: const Color(0xFF1E293B),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. Overview Layout (Lesson 1)
  // ---------------------------------------------------------------------------
  Widget _buildOverviewContent(Lesson cur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTealHeroBanner(cur),
        const SizedBox(height: 20),
        _buildObjectivesBox(cur),
        const SizedBox(height: 22),
        Text(
          "About this course",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          cur.body,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF334155),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "How each chapter works",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        _buildNumberedStep("1. Key concepts",
            "the ideas, the key points and the vocabulary, with a concept map."),
        _buildNumberedStep("2. Worked example",
            "the ideas applied step by step, and the mistakes students most often make."),
        _buildNumberedStep("3. Practice & recap",
            "questions with model answers and a checklist of what you should now know."),
      ],
    );
  }

  Widget _buildNumberedStep(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title — ",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            TextSpan(
              text: desc,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Teal Hero Banner matching Image 4
  // ---------------------------------------------------------------------------
  Widget _buildTealHeroBanner(Lesson cur) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxPillWidth = math.max(160.0, constraints.maxWidth - 48);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F766E),
                Color(0xFF0D9488),
                Color(0xFF14B8A6),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  cur.chapterPart.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                cur.chapterTitle.isNotEmpty ? cur.chapterTitle : cur.title,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxPillWidth),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.track_changes_rounded,
                          size: 13, color: Colors.white),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          cur.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
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
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Objectives Box matching Image 4
  // ---------------------------------------------------------------------------
  Widget _buildObjectivesBox(Lesson cur) {
    final objectives = cur.objectives.isNotEmpty
        ? cur.objectives
        : [
            "Check your understanding of ${cur.chapterTitle.isNotEmpty ? cur.chapterTitle : cur.title}",
            "Recall the key points without notes",
          ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "By the end of this lesson you can",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          for (final obj in objectives)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.track_changes_rounded,
                        size: 14, color: Color(0xFF2E3A94)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      obj,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF334155),
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

  // ---------------------------------------------------------------------------
  // YOU SHOULD NOW BE ABLE TO RECALL matching Image 5
  // ---------------------------------------------------------------------------
  Widget _buildRecallSection(Lesson cur) {
    final title = cur.chapterTitle.isNotEmpty ? cur.chapterTitle : cur.title;

    return Container(
      width: double.infinity,
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
            children: [
              const Icon(Icons.notes_rounded,
                  size: 15, color: Color(0xFFD97706)),
              const SizedBox(width: 8),
              Text(
                "YOU SHOULD NOW BE ABLE TO RECALL",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 520;
              if (isWide) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildRecallCard(
                        1,
                        "Explain $title in your own words",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildRecallCard(
                        2,
                        "Give an example of $title from ${widget.course.department}",
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildRecallCard(
                    1,
                    "Explain $title in your own words",
                  ),
                  const SizedBox(height: 10),
                  _buildRecallCard(
                    2,
                    "Give an example of $title from ${widget.course.department}",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecallCard(int num, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCFCE7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF0F766E), width: 1.5),
            ),
            child: Center(
              child: Text(
                "$num",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F766E),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PRACTICE QUESTIONS with Interactive Reveal matching Image 5
  // ---------------------------------------------------------------------------
  Widget _buildPracticeQuestionsSection(Lesson cur) {
    final title = cur.chapterTitle.isNotEmpty ? cur.chapterTitle : cur.title;

    return Container(
      width: double.infinity,
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
            children: [
              const Icon(Icons.help_outline_rounded,
                  size: 15, color: Color(0xFFD97706)),
              const SizedBox(width: 8),
              Text(
                "PRACTICE QUESTIONS",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildQuestionTile(
            qNum: "Q1",
            question:
                "In two or three sentences, explain $title to a first-year student.",
            answer:
                "$title introduces the essential foundational models, design principles, and syntax used to build scalable modern computing solutions. It establishes the bridge between abstract data manipulation and practical real-world execution.",
          ),
          const SizedBox(height: 12),

          _buildQuestionTile(
            qNum: "Q2",
            question:
                "Where is $title used in ${widget.course.department}?",
            answer:
                "It serves as a core competency in software engineering, distributed systems, RESTful API design, database backends, and cloud deployment pipelines across curriculum projects and industry applications.",
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile({
    required String qNum,
    required String question,
    required String answer,
  }) {
    final isRevealed = _revealedAnswers[qNum] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$qNum  ",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFD97706),
                  ),
                ),
                TextSpan(
                  text: question,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          InkWell(
            onTap: () {
              setState(() {
                _revealedAnswers[qNum] = !isRevealed;
              });
            },
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isRevealed
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 15,
                    color: const Color(0xFF2E3A94),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isRevealed ? "Hide model answer" : "Show model answer",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E3A94),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isRevealed) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFDCFCE7)),
              ),
              child: Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF166534),
                  height: 1.45,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
