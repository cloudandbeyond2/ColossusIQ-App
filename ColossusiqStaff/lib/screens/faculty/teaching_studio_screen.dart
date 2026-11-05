import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: TEACHING STUDIO SCREEN
// Exactly matches Screenshot 5:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Notice Alert banner ("AI drafts the teaching pack from your course content...")
// - "What are you teaching?" card with course/chapter/length dropdowns & "Build teaching pack" button
// - Large blueprint graph paper empty state container ("Everything for one class, in one place")
// =============================================================================

class TeachingStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const TeachingStudioScreen({super.key, this.onBack});

  @override
  State<TeachingStudioScreen> createState() => _TeachingStudioScreenState();
}

class _TeachingStudioScreenState extends State<TeachingStudioScreen> {
  int _teachingMode = 0; // 0: From a course chapter, 1: Any topic

  String _selectedCourse = "CSE101 · Database Management Systems";
  final List<String> _courses = [
    "CSE101 · Database Management Systems",
    "CSE102 · Object Oriented Analysis & Design",
    "AI201 · Machine Learning & Neural Networks",
  ];

  String _selectedChapter = "1. Introduction to database systems";
  final List<String> _chapters = [
    "1. Introduction to database systems",
    "2. Relational Data Models & Constraints",
    "3. SQL Queries, Triggers & Views",
    "4. Normalization (1NF, 2NF, 3NF, BCNF)",
  ];

  String _selectedLength = "50 minutes";
  final List<String> _lengths = [
    "45 minutes",
    "50 minutes",
    "90 minutes (Block)",
  ];

  bool _isGenerating = false;
  Map<String, dynamic>? _generatedPack;

  void _buildTeachingPack() {
    setState(() => _isGenerating = true);
    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _generatedPack = {
          "course": _selectedCourse,
          "chapter": _selectedChapter,
          "length": _selectedLength,
          "overview":
              "Database systems provide an abstraction layer between physical storage and application queries, ensuring ACID properties, concurrent access, and data durability.",
          "timedOutline": [
            {
              "time": "00-10m",
              "title": "Hook: Why File Systems Failed at Scale",
              "desc": "Show concurrent CSV overwrite bug with bank accounts."
            },
            {
              "time": "10-25m",
              "title": "3-Schema Architecture & Data Independence",
              "desc": "Physical, Logical, and View schema layers with chalkboard diagram."
            },
            {
              "time": "25-40m",
              "title": "DBMS vs File Systems Comparison Matrix",
              "desc": "Security, Crash Recovery, Concurrency, and Integrity checks."
            },
            {
              "time": "40-50m",
              "title": "Interactive MCQ Poll & Handout Distribution",
              "desc": "Check comprehension via smart-board prompt and send PDF pack to students."
            },
          ],
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 16),
              _buildNoticeBanner(),
              const SizedBox(height: 18),
              _buildWhatAreYouTeachingCard(),
              const SizedBox(height: 18),
              if (_generatedPack == null)
                _buildBlueprintEmptyStateCard()
              else
                _buildGeneratedPackView(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 5)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark presenter outline on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.co_present_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Faculty',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Teaching Studio',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.co_present_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'FACULTY',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F766E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Teaching Studio',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Topic basics, a timed lesson outline, a semester roadmap, an infographic handout, smart-board slides and a class summary to share — for any chapter or topic.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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

  // ===========================================================================
  // NOTICE ALERT BANNER (Screenshot 5)
  // ===========================================================================
  Widget _buildNoticeBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'AI drafts the teaching pack from your course content. Review it before class; you decide what students see.',
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // "WHAT ARE YOU TEACHING?" CARD (Screenshot 5)
  // ===========================================================================
  Widget _buildWhatAreYouTeachingCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What are you teaching?',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Build a teaching pack for one class',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Toggle Pills: "From a course chapter" | "Any topic"
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => setState(() => _teachingMode = 0),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: _teachingMode == 0
                          ? const Color(0xFF1E2548)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'From a course chapter',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _teachingMode == 0
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _teachingMode = 1),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: _teachingMode == 1
                          ? const Color(0xFF1E2548)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Any topic',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _teachingMode == 1
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Responsive Row of Dropdowns + Button (Screenshot 5)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 850;

              final courseField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600)),
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
                        isExpanded: true,
                        value: _selectedCourse,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                        ),
                        items: _courses
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c,
                                      overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCourse = val);
                        },
                      ),
                    ),
                  ),
                ],
              );

              final chapterField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chapter',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600)),
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
                        isExpanded: true,
                        value: _selectedChapter,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                        ),
                        items: _chapters
                            .map((ch) => DropdownMenuItem(
                                  value: ch,
                                  child: Text(ch,
                                      overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedChapter = val);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );

              final lengthField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class length',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600)),
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
                        isExpanded: true,
                        value: _selectedLength,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                        ),
                        items: _lengths
                            .map((l) => DropdownMenuItem(
                                  value: l,
                                  child: Text(l,
                                      overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedLength = val);
                        },
                      ),
                    ),
                  ),
                ],
              );

              final buildButton = SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: _isGenerating ? null : _buildTeachingPack,
                  icon: _isGenerating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome_rounded, size: 16),
                  label: Text(
                    _isGenerating ? 'Drafting...' : 'Build teaching pack',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    courseField,
                    const SizedBox(height: 12),
                    chapterField,
                    const SizedBox(height: 12),
                    lengthField,
                    const SizedBox(height: 16),
                    buildButton,
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 3, child: courseField),
                    const SizedBox(width: 12),
                    Expanded(flex: 3, child: chapterField),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: lengthField),
                    const SizedBox(width: 14),
                    buildButton,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // LARGE BLUEPRINT GRAPH PAPER EMPTY STATE (Screenshot 5)
  // ===========================================================================
  Widget _buildBlueprintEmptyStateCard() {
    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _LightGraphPaperPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.co_present_rounded,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Everything for one class, in one place',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Pick a chapter from your department\'s courses or type any topic. You get a plain-language explanation, a timed lesson outline, a semester roadmap, an infographic handout, smart-board slides and a class summary to share with students.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                        height: 1.45,
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
  }

  Widget _buildGeneratedPackView() {
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                'Generated Teaching Pack',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => setState(() => _generatedPack = null),
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: const Text('New Topic'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _generatedPack!['chapter'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF38439E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _generatedPack!['overview'],
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF475569),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Timed Lesson Outline (${_generatedPack!['length']})',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          ...(_generatedPack!['timedOutline'] as List<Map<String, String>>)
              .map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['time']!,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4338CA),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          item['desc']!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 620;

              final btnDownload = ElevatedButton.icon(
                onPressed: _showDownloadHandoutDialog,
                icon: const Icon(Icons.picture_as_pdf_rounded, size: 15),
                label: Text('Download Handout', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );

              final btnSlides = OutlinedButton.icon(
                onPressed: _showLaunchSlidesDialog,
                icon: const Icon(Icons.slideshow_rounded, size: 15),
                label: Text('Present Slides', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E2865),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );

              final btnShare = OutlinedButton.icon(
                onPressed: _shareWithStudents,
                icon: const Icon(Icons.send_rounded, size: 14),
                label: Text('Share with Class', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F766E),
                  side: const BorderSide(color: Color(0xFF99F6E4)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );

              if (isNarrow) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    btnDownload,
                    btnSlides,
                    btnShare,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: btnDownload),
                  const SizedBox(width: 8),
                  Expanded(child: btnSlides),
                  const SizedBox(width: 8),
                  Expanded(child: btnShare),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDownloadHandoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFF1E2865), size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Download Teaching Handout',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                            ),
                            Text(
                              'Compiled teaching pack & student worksheet',
                              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _generatedPack?['chapter'] ?? 'Chapter Outline',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E2865)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Includes timed 50m lesson plan, smart board chalkboard diagrams, and review questions.',
                          style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Downloaded Teaching Pack PDF for ${_generatedPack?['chapter']}', style: GoogleFonts.poppins()),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.file_download_outlined, size: 16),
                        label: Text('Download PDF', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E2865),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
  }

  void _showLaunchSlidesDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.tv_rounded, color: Color(0xFF4338CA), size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Smart Board Presentation Slides',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                            ),
                            Text(
                              '8 High-contrast classroom slides prepared by AI',
                              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Container(
                    height: 190,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'SLIDE 1 OF 8 · INTRODUCTION',
                                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.0, color: const Color(0xFF93C5FD)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('4K Ready', style: GoogleFonts.poppins(fontSize: 9.5, color: Colors.white)),
                            ),
                          ],
                        ),
                        Text(
                          _generatedPack?['chapter'] ?? 'Database Architecture',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        Text(
                          '• Physical vs Logical Data Independence\n• Concurrency & ACID guarantees\n• Real-world banking ledger case study',
                          style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFCBD5E1), height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('Close', style: GoogleFonts.poppins(fontSize: 12.5)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Entering Smart Board Fullscreen Presentation Mode...', style: GoogleFonts.poppins()),
                              backgroundColor: const Color(0xFF1E2865),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.fullscreen_rounded, size: 18),
                        label: Text('Start Fullscreen Presentation', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E2865),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
  }

  void _shareWithStudents() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Teaching summary, lecture notes and formula sheet pushed to student portal for $_selectedCourse!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Background painter for blueprint grid in top banner
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Light graph paper painter for empty state container
class _LightGraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.45)
      ..strokeWidth = 1.0;

    const double step = 20.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
