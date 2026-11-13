import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: AI COURSE STUDIO SCREEN
// Complete implementation matching 5 design views:
// 1. Main Dashboard: Blueprint banner, disclaimer, 4 KPI stats, department courses table.
// 2. Step 1: Course Details (Department, Title, Faculty, Level, Term, Credits, Syllabus/Title cards).
// 3. Step 2: Lessons Editor (Left sidebar chapters/lessons, right markdown editor, preview toggle).
// 4. Step 3: Final Assessment (Questions, To review, Pass mark, Time, review warning, Mark all reviewed).
// 5. Step 4: Publish Review (Ready to publish checklist with Fix button, What students see card, Publish).
// =============================================================================

class AiCourseStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiCourseStudioScreen({super.key, this.onBack});

  @override
  State<AiCourseStudioScreen> createState() => _AiCourseStudioScreenState();
}

class _AiCourseStudioScreenState extends State<AiCourseStudioScreen> {
  // Navigation State:
  // 0: Main Dashboard Table
  // 1: Step 1 Course Details
  // 2: Step 2 Lessons Editor
  // 3: Step 3 Final Assessment
  // 4: Step 4 Publish Review
  int _currentView = 0;

  // Active course currently being edited in wizard
  late StudioCourseItem _activeCourse;

  // Lessons editor state
  int _selectedChapterIndex = 0;
  int _selectedLessonIndex = 0;
  bool _isStudentPreview = false;

  // Question expansion states in Step 3
  final Set<String> _expandedQuestions = {};

  // Controllers for wizard forms
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _lessonTitleCtrl = TextEditingController();
  final TextEditingController _lessonMinutesCtrl = TextEditingController();
  final TextEditingController _lessonKeyPointsCtrl = TextEditingController();
  final TextEditingController _lessonContentCtrl = TextEditingController();
  final TextEditingController _passMarkCtrl = TextEditingController();
  final TextEditingController _timeMinutesCtrl = TextEditingController();

  // Course dataset matching screenshots
  late List<StudioCourseItem> _courses;

  @override
  void initState() {
    super.initState();
    _initMockCourses();
    _activeCourse = _courses[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _facultyController.dispose();
    _creditsController.dispose();
    _lessonTitleCtrl.dispose();
    _lessonMinutesCtrl.dispose();
    _lessonKeyPointsCtrl.dispose();
    _lessonContentCtrl.dispose();
    _passMarkCtrl.dispose();
    _timeMinutesCtrl.dispose();
    super.dispose();
  }

  void _initMockCourses() {
    _courses = [
      StudioCourseItem(
        id: "C107",
        title: "Emerging Technologies",
        code: "CSE107 · Computer Science & Engineering · Term 5",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "5",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 26,
        chaptersCount: 8,
        questionsCount: 30,
        toReviewCount: 0,
        students: "1 · 1 finished",
        status: "Published",
        chapters: _generateDefaultChapters("Emerging Technologies"),
        questions: _generateDefaultQuestions("Emerging Technologies", 0),
      ),
      StudioCourseItem(
        id: "C106",
        title: "Web Technologies",
        code: "CSE106 · Computer Science & Engineering · Term 1",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "1",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 18,
        chaptersCount: 8,
        questionsCount: 30,
        toReviewCount: 0,
        students: "1 · 0 finished",
        status: "Published",
        chapters: _generateDefaultChapters("Web Technologies"),
        questions: _generateDefaultQuestions("Web Technologies", 0),
      ),
      StudioCourseItem(
        id: "C105",
        title: "Data base System Applications",
        code: "CSE105 · Computer Science & Engineering · Term 1",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "1",
        credits: "4",
        builtFrom: "Custom syllabus",
        lessonsCount: 10,
        chaptersCount: 1,
        questionsCount: 30,
        toReviewCount: 0,
        students: "—",
        status: "Published",
        chapters: _generateDefaultChapters("Data base System Applications"),
        questions: _generateDefaultQuestions("Data base System Applications", 0),
      ),
      StudioCourseItem(
        id: "C104",
        title: "DBMS",
        code: "CSE104 · Computer Science & Engineering · Term 1",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "1",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 29,
        chaptersCount: 9,
        questionsCount: 30,
        toReviewCount: 0,
        students: "1 · 0 finished",
        status: "Published",
        chapters: _generateDefaultChapters("DBMS"),
        questions: _generateDefaultQuestions("DBMS", 0),
      ),
      StudioCourseItem(
        id: "C103",
        title: "DBMS",
        code: "CSE103 · Computer Science & Engineering · Term 1",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "1",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 25,
        chaptersCount: 8,
        questionsCount: 30,
        toReviewCount: 30,
        students: "—",
        status: "Draft",
        chapters: _generateDefaultChapters("DBMS"),
        questions: _generateDefaultQuestions("DBMS", 30),
      ),
      StudioCourseItem(
        id: "C201",
        title: "Machine Learning",
        code: "CSE201 · Computer Science & Engineering · Term 4",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "4",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 18,
        chaptersCount: 10,
        questionsCount: 30,
        toReviewCount: 29,
        students: "—",
        status: "Draft",
        chapters: _generateDefaultChapters("Machine Learning"),
        questions: _generateDefaultQuestions("Machine Learning", 29),
      ),
      StudioCourseItem(
        id: "C102",
        title: "Operating Systems",
        code: "CSE102 · Computer Science & Engineering · Term 3",
        department: "Computer Science & Engineering",
        faculty: "Dr. Lakshmi Sundaram",
        level: "Intermediate (UG Year 2–3)",
        term: "3",
        credits: "3",
        builtFrom: "Course title",
        lessonsCount: 24,
        chaptersCount: 8,
        questionsCount: 30,
        toReviewCount: 0,
        students: "3 · 2 finished",
        status: "Published",
        chapters: _generateDefaultChapters("Operating Systems"),
        questions: _generateDefaultQuestions("Operating Systems", 0),
      ),
    ];
  }

  static List<StudioChapterItem> _generateDefaultChapters(String title) {
    return [
      StudioChapterItem(
        name: "GETTING STARTED",
        lessons: [
          StudioLessonItem(
            id: "L1",
            title: "Welcome to $title",
            minutes: 10,
            keyPoints:
                "Each chapter moves from concepts to methods, worked examples, practice questions and an infographic summary.\nTake the lessons in sequence: each lesson unlocks the next.\nCertificates are graded (O, A+, A, B, C) based on your final assessment score.",
            contentMarkdown:
                "## About this course\n**$title** is offered by the Department of Computer Science & Engineering for undergraduate students. It builds the foundations, methods and real-world applications you need to build intelligent software.\n\n## How each chapter works\nEvery chapter covers a single core topic:\n- **Concepts & foundations** — core definitions, why the topic matters and where it is used\n- **Techniques & methods** — standard algorithms, step-by-step procedures and best practices\n- **Worked examples** — complete solved problems so you can see the theory in action\n- **Practice & recap** — short drill questions to check your understanding before moving on\n\n## Final assessment and certificate\nAfter finishing every lesson, you unlock the 30-question final assessment. Score 50% or more to earn your course certificate.\n\n## Study tips\n- Read each lesson carefully and try the worked examples yourself\n- Review the key-point summary cards at the top of each lesson\n- Check your progress on the course roadmap",
          ),
        ],
      ),
      StudioChapterItem(
        name: "INTRODUCTION TO $title".toUpperCase(),
        lessons: [
          StudioLessonItem(
            id: "L2",
            title: "Key concepts",
            minutes: 15,
            keyPoints:
                "Understand fundamental terminology and paradigm shifts.\nAnalyze the core input-output relationship.\nIdentify domain application areas in industry.",
            contentMarkdown:
                "## Introduction to $title\nIn this lesson we explore foundational architecture, historical milestones, and why modern computing environments prioritize this subject.\n\n### Key Principles\n1. Mathematical formulation\n2. Algorithmic efficiency\n3. Scalability patterns",
          ),
          StudioLessonItem(
            id: "L3",
            title: "Practice & recap",
            minutes: 10,
            keyPoints:
                "Review definitions.\nSolve sample scenarios.\nCheck understanding before Chapter 3.",
            contentMarkdown:
                "## Practice Drills\nComplete these quick scenarios to test your understanding before advancing to terminology.",
          ),
        ],
      ),
      StudioChapterItem(
        name: "BASIC CONCEPTS & TERMINOLOGY",
        lessons: [
          StudioLessonItem(
            id: "L4",
            title: "Key concepts",
            minutes: 15,
            keyPoints:
                "Terminology mapping.\nData representations.\nState transitions.",
            contentMarkdown:
                "## Core Terminology\nMastering standard technical terms across standard literature.",
          ),
          StudioLessonItem(
            id: "L5",
            title: "Practice & recap",
            minutes: 12,
            keyPoints: "Self-assessment on naming conventions.",
            contentMarkdown: "Quick terminology check-in.",
          ),
        ],
      ),
      StudioChapterItem(
        name: "CORE PRINCIPLES OF $title".toUpperCase(),
        lessons: [
          StudioLessonItem(
            id: "L6",
            title: "Key concepts",
            minutes: 20,
            keyPoints: "Invariant structures.\nOptimizations.\nError boundaries.",
            contentMarkdown: "Deep dive into core theoretical mechanisms.",
          ),
          StudioLessonItem(
            id: "L7",
            title: "Practice & recap",
            minutes: 15,
            keyPoints: "Hands-on formulation.",
            contentMarkdown: "Step-by-step problem walkthrough.",
          ),
        ],
      ),
      StudioChapterItem(
        name: "METHODS & TECHNIQUES",
        lessons: [
          StudioLessonItem(
            id: "L8",
            title: "Key concepts",
            minutes: 25,
            keyPoints: "Standard procedural techniques.\nComplexity analysis.",
            contentMarkdown: "Algorithmic pipelines and step-by-step heuristics.",
          ),
          StudioLessonItem(
            id: "L9",
            title: "Practice & recap",
            minutes: 15,
            keyPoints: "Practical implementation review.",
            contentMarkdown: "Reviewing code snippets and operational patterns.",
          ),
        ],
      ),
    ];
  }

  static List<StudioQuestionItem> _generateDefaultQuestions(
      String title, int reviewCount) {
    final List<StudioQuestionItem> list = [];
    final templates = [
      {
        "q": "What is the primary objective of Supervised Learning in $title?",
        "opts": [
          "To learn a mapping from input features to known target outputs",
          "To group unlabeled data points by inherent distance similarity",
          "To maximize cumulative rewards via trial-and-error environment signals",
          "To compress dimensionality without retaining variance"
        ],
        "ans": 0,
      },
      {
        "q": "Which metric evaluates classification performance under imbalanced class distribution?",
        "opts": [
          "Accuracy",
          "F1-Score / Area Under ROC Curve (AUC)",
          "Mean Squared Error (MSE)",
          "Euclidean Distance"
        ],
        "ans": 1,
      },
      {
        "q": "In high-dimensional feature spaces, what phenomenon causes data sparsity?",
        "opts": [
          "Central Limit Theorem",
          "Curse of Dimensionality",
          "Occam's Razor",
          "Bayes' Optimal Error"
        ],
        "ans": 1,
      },
      {
        "q": "What is the role of regularization (e.g. L1/L2) during optimization?",
        "opts": [
          "To intentionally overfit training observations",
          "To penalize large weights and enhance generalization on unseen data",
          "To eliminate the requirement for cross-validation",
          "To transform non-convex loss surfaces into linear planes"
        ],
        "ans": 1,
      },
      {
        "q": "Which data structure or algorithm provides deterministic linear scan guarantees?",
        "opts": [
          "Sequential Iterator",
          "Binary Search Tree",
          "Hash Map with Chaining",
          "Skip List"
        ],
        "ans": 0,
      },
    ];

    for (int i = 1; i <= 30; i++) {
      final t = templates[(i - 1) % templates.length];
      final isReview = i <= reviewCount;
      list.add(
        StudioQuestionItem(
          id: "Q$i",
          questionText: "Q$i. ${t["q"]}",
          options: List<String>.from(t["opts"] as List),
          correctIndex: t["ans"] as int,
          isReview: isReview,
        ),
      );
    }
    return list;
  }

  // KPI Getters
  int get _totalCoursesCount => _courses.length;
  int get _publishedCount =>
      _courses.where((c) => c.status == "Published").length;
  int get _studentsCount => 5;
  int get _certificatesCount => 3;

  // Wizard Launchers
  void _openNewCourseWizard() {
    final newCourse = StudioCourseItem(
      id: "C${DateTime.now().millisecondsSinceEpoch % 1000}",
      title: "",
      code: "CSE · Computer Science & Engineering · Term 1",
      department: "Computer Science & Engineering",
      faculty: "Dr. Lakshmi Sundaram",
      level: "Intermediate (UG Year 2–3)",
      term: "1",
      credits: "3",
      builtFrom: "Course title",
      lessonsCount: 18,
      chaptersCount: 10,
      questionsCount: 30,
      toReviewCount: 29,
      students: "—",
      status: "Draft",
      chapters: _generateDefaultChapters("New Course"),
      questions: _generateDefaultQuestions("New Course", 29),
    );

    _loadCourseIntoWizard(newCourse, targetStep: 1);
  }

  void _editCourse(StudioCourseItem course, {int targetStep = 1}) {
    _loadCourseIntoWizard(course, targetStep: targetStep);
  }

  void _loadCourseIntoWizard(StudioCourseItem course, {int targetStep = 1}) {
    setState(() {
      _activeCourse = course;
      _currentView = targetStep;

      // Populate Step 1 controllers
      _titleController.text = course.title;
      _facultyController.text = course.faculty;
      _creditsController.text = course.credits;

      // Step 2 lessons
      _selectedChapterIndex = 0;
      _selectedLessonIndex = 0;
      _isStudentPreview = false;
      _loadCurrentLessonIntoEditor();

      // Step 3 settings
      _passMarkCtrl.text = "${course.passMark}";
      _timeMinutesCtrl.text = "${course.timeMinutes}";
    });
  }

  void _loadCurrentLessonIntoEditor() {
    if (_activeCourse.chapters.isEmpty) return;
    final ch = _activeCourse.chapters[_selectedChapterIndex];
    if (ch.lessons.isEmpty) return;
    final ls = ch.lessons[_selectedLessonIndex];
    _lessonTitleCtrl.text = ls.title;
    _lessonMinutesCtrl.text = "${ls.minutes}";
    _lessonKeyPointsCtrl.text = ls.keyPoints;
    _lessonContentCtrl.text = ls.contentMarkdown;
  }

  void _saveCurrentLesson() {
    if (_activeCourse.chapters.isEmpty) return;
    final ch = _activeCourse.chapters[_selectedChapterIndex];
    if (ch.lessons.isEmpty) return;
    final ls = ch.lessons[_selectedLessonIndex];
    setState(() {
      ls.title = _lessonTitleCtrl.text.trim();
      ls.minutes = int.tryParse(_lessonMinutesCtrl.text.trim()) ?? 10;
      ls.keyPoints = _lessonKeyPointsCtrl.text.trim();
      ls.contentMarkdown = _lessonContentCtrl.text.trim();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Lesson content saved successfully."),
        backgroundColor: Color(0xFF141938),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteCourse(StudioCourseItem course) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Course",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: Text(
          "Are you sure you want to delete '${course.title}'? This action cannot be undone.",
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _courses.removeWhere((c) => c.id == course.id);
                if (_currentView != 0) {
                  _currentView = 0;
                }
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Course '${course.title}' deleted."),
                  backgroundColor: const Color(0xFFDC2626),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;

          // Render view according to navigation state
          switch (_currentView) {
            case 1:
              return _buildStep1CourseDetails(isNarrow);
            case 2:
              return _buildStep2LessonsEditor(isNarrow);
            case 3:
              return _buildStep3FinalAssessment(isNarrow);
            case 4:
              return _buildStep4PublishReview(isNarrow);
            case 0:
            default:
              return _buildMainDashboard(isNarrow);
          }
        },
      ),
    );
  }

  // ===========================================================================
  // VIEW 0: MAIN DASHBOARD
  // ===========================================================================
  Widget _buildMainDashboard(bool isNarrow) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
      children: [
        _buildHeroBanner(),
        const SizedBox(height: 14),
        _buildDisclaimerAlert(),
        const SizedBox(height: 18),
        _buildMetricCardsRow(isNarrow),
        const SizedBox(height: 20),
        _buildDepartmentCoursesCard(isNarrow),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course & Certification",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
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
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "AI COURSE & CERTIFICATION",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AI Course Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Build a department course from a title or your own syllabus: lessons, outcomes and a 30-question final assessment. Then publish it to students.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
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

  Widget _buildDisclaimerAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "AI drafts lessons and questions. Review them before publishing; only the HOD or Principal can publish to students.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCardsRow(bool isNarrow) {
    final cards = [
      _buildMetricCard(
        icon: Icons.menu_book_outlined,
        title: "Courses",
        value: "$_totalCoursesCount",
      ),
      _buildMetricCard(
        icon: Icons.check_box_outlined,
        title: "Published to students",
        value: "$_publishedCount",
      ),
      _buildMetricCard(
        icon: Icons.groups_outlined,
        title: "Students learning",
        value: "$_studentsCount",
      ),
      _buildMetricCard(
        icon: Icons.military_tech_outlined,
        title: "Certificates issued",
        value: "$_certificatesCount",
      ),
    ];

    if (isNarrow) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 12),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 14),
        Expanded(child: cards[1]),
        const SizedBox(width: 14),
        Expanded(child: cards[2]),
        const SizedBox(width: 14),
        Expanded(child: cards[3]),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentCoursesCard(bool isNarrow) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with + New course button
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department courses",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Create a course, review its lessons and 30-question assessment, then publish it to students.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _openNewCourseWizard,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  "New course",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Scrollable table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1000),
              child: DataTable(
                dataRowMinHeight: 64,
                dataRowMaxHeight: 74,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                ),
                horizontalMargin: 16,
                columnSpacing: 28,
                columns: const [
                  DataColumn(label: Text("COURSE")),
                  DataColumn(label: Text("BUILT FROM")),
                  DataColumn(label: Text("LESSONS")),
                  DataColumn(label: Text("ASSESSMENT")),
                  DataColumn(label: Text("STUDENTS")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _courses.map((course) {
                  final isPublished = course.status == "Published";
                  final isCustom = course.builtFrom == "Custom syllabus";

                  return DataRow(
                    cells: [
                      // Course Name & Code
                      DataCell(
                        SizedBox(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                course.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                course.code,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Built From Pill
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isCustom
                                ? const Color(0xFFE0F2FE)
                                : const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isCustom
                                  ? const Color(0xFFBAE6FD)
                                  : const Color(0xFFBFDBFE),
                            ),
                          ),
                          child: Text(
                            course.builtFrom,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isCustom
                                  ? const Color(0xFF0369A1)
                                  : const Color(0xFF1E40AF),
                            ),
                          ),
                        ),
                      ),

                      // Lessons
                      DataCell(
                        Text(
                          "${course.lessonsCount} in ${course.chaptersCount} chapters",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Assessment
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${course.questionsCount} questions",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF334155),
                              ),
                            ),
                            if (course.toReviewCount > 0)
                              Text(
                                "${course.toReviewCount} to review",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFFD97706),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Students
                      DataCell(
                        Text(
                          course.students,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),

                      // Status Pill
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: isPublished
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            course.status,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isPublished
                                  ? const Color(0xFF15803D)
                                  : const Color(0xFFB45309),
                            ),
                          ),
                        ),
                      ),

                      // Actions: Edit, Open ->, Delete
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _editCourse(course, targetStep: 1),
                              icon: const Icon(Icons.edit_outlined, size: 14),
                              label: const Text("Edit"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () => _editCourse(course, targetStep: 2),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Open"),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.arrow_forward_rounded,
                                      size: 14),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _deleteCourse(course),
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 18, color: Color(0xFFEF4444)),
                              tooltip: "Delete course",
                              splashRadius: 18,
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

  // ===========================================================================
  // WIZARD STEP HEADER / NAVIGATION
  // Matches Step indicators in Screenshots 2, 3, 4, 5
  // ===========================================================================
  Widget _buildWizardStepBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStepTabItem(stepNumber: 1, title: "Course details"),
            _buildStepDivider(),
            _buildStepTabItem(stepNumber: 2, title: "Lessons"),
            _buildStepDivider(),
            _buildStepTabItem(stepNumber: 3, title: "Final assessment"),
            _buildStepDivider(),
            _buildStepTabItem(stepNumber: 4, title: "Publish"),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTabItem({required int stepNumber, required String title}) {
    final bool isActive = _currentView == stepNumber;
    final bool isCompleted = _currentView > stepNumber;

    return InkWell(
      onTap: () {
        setState(() {
          _currentView = stepNumber;
          if (stepNumber == 2) {
            _loadCurrentLessonIntoEditor();
          }
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCompleted)
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                ),
              )
            else
              Text(
                "$stepNumber ",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? Colors.white
                      : (isCompleted
                          ? const Color(0xFF10B981)
                          : const Color(0xFF94A3B8)),
                ),
              ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : (isCompleted
                        ? const Color(0xFF334155)
                        : const Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 24,
      alignment: Alignment.center,
      child: const Icon(Icons.chevron_right, size: 16, color: Color(0xFFCBD5E1)),
    );
  }

  Widget _buildWizardTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => setState(() => _currentView = 0),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_rounded,
                    size: 16, color: Color(0xFF475569)),
                const SizedBox(width: 6),
                Text(
                  "All courses",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _activeCourse.title.isNotEmpty
                  ? _activeCourse.title
                  : "New Course",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _activeCourse.status == "Published"
                    ? const Color(0xFFDCFCE7)
                    : const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _activeCourse.status,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _activeCourse.status == "Published"
                      ? const Color(0xFF15803D)
                      : const Color(0xFFB45309),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // VIEW 1: STEP 1 - COURSE DETAILS
  // Matches Screenshot 2: Course details card, department, title, faculty,
  // level, term, credits, radio option cards, generate course & continue button.
  // ===========================================================================
  Widget _buildStep1CourseDetails(bool isNarrow) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
      children: [
        _buildWizardTopBar(),
        const SizedBox(height: 14),
        _buildWizardStepBar(),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Course details",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Engineering & Technology · choose the department and how the lessons should be built",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _currentView = 0),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Row 1: Department, Title, Faculty
              if (isNarrow) ...[
                _buildDepartmentDropdown(),
                const SizedBox(height: 14),
                _buildCourseTitleInput(),
                const SizedBox(height: 14),
                _buildCourseFacultyInput(),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildDepartmentDropdown()),
                    const SizedBox(width: 14),
                    Expanded(flex: 4, child: _buildCourseTitleInput()),
                    const SizedBox(width: 14),
                    Expanded(flex: 3, child: _buildCourseFacultyInput()),
                  ],
                ),
              const SizedBox(height: 18),

              // Row 2: Level, Term, Credits
              if (isNarrow) ...[
                _buildLevelDropdown(),
                const SizedBox(height: 14),
                _buildTermDropdown(),
                const SizedBox(height: 14),
                _buildCreditsInput(),
              ] else
                Row(
                  children: [
                    Expanded(flex: 4, child: _buildLevelDropdown()),
                    const SizedBox(width: 14),
                    Expanded(flex: 3, child: _buildTermDropdown()),
                    const SizedBox(width: 14),
                    Expanded(flex: 3, child: _buildCreditsInput()),
                  ],
                ),
              const SizedBox(height: 24),

              // Build lessons from (radio cards) - Responsive Layout
              Text(
                "Build lessons from",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 10),

              LayoutBuilder(
                builder: (context, cardConstraints) {
                  final stackCards = cardConstraints.maxWidth < 680;
                  if (stackCards) {
                    return Column(
                      children: [
                        _buildLessonSourceCard(
                          isSelected: _activeCourse.builtFrom == "Course title",
                          badgeTitle: "✦ The course title",
                          description:
                              "AI drafts chapters, lessons, key terms, worked examples and practice questions. You review and edit them next.",
                          onTap: () {
                            setState(() {
                              _activeCourse.builtFrom = "Course title";
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildLessonSourceCard(
                          isSelected: _activeCourse.builtFrom == "Custom syllabus",
                          badgeTitle: "📄 Our own syllabus",
                          description:
                              "Paste your university syllabus. Each unit becomes a unit, and each topic becomes a lesson.",
                          onTap: () {
                            setState(() {
                              _activeCourse.builtFrom = "Custom syllabus";
                            });
                          },
                        ),
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildLessonSourceCard(
                          isSelected: _activeCourse.builtFrom == "Course title",
                          badgeTitle: "✦ The course title",
                          description:
                              "AI drafts chapters, lessons, key terms, worked examples and practice questions. You review and edit them next.",
                          onTap: () {
                            setState(() {
                              _activeCourse.builtFrom = "Course title";
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildLessonSourceCard(
                          isSelected: _activeCourse.builtFrom == "Custom syllabus",
                          badgeTitle: "📄 Our own syllabus",
                          description:
                              "Paste your university syllabus. Each unit becomes a unit, and each topic becomes a lesson.",
                          onTap: () {
                            setState(() {
                              _activeCourse.builtFrom = "Custom syllabus";
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),

              // Footer
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome,
                          size: 14, color: Color(0xFF7C3AED)),
                      const SizedBox(width: 6),
                      Text(
                        "AI-generated — verify important details",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final title = _titleController.text.trim();
                      if (title.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a course title first"),
                            backgroundColor: Color(0xFFDC2626),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        _activeCourse.title = title;
                        _activeCourse.faculty = _facultyController.text.trim();
                        _activeCourse.credits = _creditsController.text.trim();
                        _activeCourse.code =
                            "CSE${DateTime.now().millisecondsSinceEpoch % 100 + 100} · ${_activeCourse.department} · Term ${_activeCourse.term}";

                        if (!_courses.any((c) => c.id == _activeCourse.id)) {
                          _courses.insert(0, _activeCourse);
                        }

                        _currentView = 2; // Move to Lessons editor
                        _selectedChapterIndex = 0;
                        _selectedLessonIndex = 0;
                        _loadCurrentLessonIntoEditor();
                      });
                    },
                    icon: const Icon(Icons.auto_awesome, size: 16),
                    label: Text(
                      "Generate course & continue →",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D28D9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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

  Widget _buildDepartmentDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Department",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _activeCourse.department,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                  fontSize: 12.5, color: const Color(0xFF1E293B)),
              items: [
                "Computer Science & Engineering",
                "Information Technology",
                "Artificial Intelligence & DS",
                "Electronics & Communication",
              ]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _activeCourse.department = val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Course title",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextField(
            controller: _titleController,
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText:
                  "e.g. Database Management Systems, Machine Learning...",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF94A3B8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseFacultyInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Course faculty",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextField(
            controller: _facultyController,
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Level",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _activeCourse.level,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                  fontSize: 12.5, color: const Color(0xFF1E293B)),
              items: [
                "Foundation (UG Year 1)",
                "Intermediate (UG Year 2–3)",
                "Advanced (UG Year 4 / PG)",
              ]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _activeCourse.level = val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Term",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _activeCourse.term,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                  fontSize: 12.5, color: const Color(0xFF1E293B)),
              items: ["1", "2", "3", "4", "5", "6", "7", "8"]
                  .map((e) => DropdownMenuItem(value: e, child: Text("Term $e")))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _activeCourse.term = val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Credits",
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155))),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextField(
            controller: _creditsController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonSourceCard({
    required bool isSelected,
    required String badgeTitle,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF5F3FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7C3AED)
                : const Color(0xFFCBD5E1),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 18,
                  color: isSelected
                      ? const Color(0xFF7C3AED)
                      : const Color(0xFF94A3B8),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    badgeTitle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? const Color(0xFF6D28D9)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // VIEW 2: STEP 2 - LESSONS EDITOR
  // Matches Screenshot 3: Two-column layout (sidebar chapters & lesson editor)
  // ===========================================================================
  Widget _buildStep2LessonsEditor(bool isNarrow) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
      children: [
        _buildWizardTopBar(),
        const SizedBox(height: 14),
        _buildWizardStepBar(),
        const SizedBox(height: 20),

        if (isNarrow)
          Column(
            children: [
              _buildLessonsSidebar(),
              const SizedBox(height: 16),
              _buildLessonDetailEditor(),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 320, child: _buildLessonsSidebar()),
              const SizedBox(width: 20),
              Expanded(child: _buildLessonDetailEditor()),
            ],
          ),

        const SizedBox(height: 24),

        // Bottom action bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _currentView = 1),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text("Back"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: _saveCurrentLesson,
                    icon: const Icon(Icons.save_outlined, size: 16),
                    label: const Text("Save"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      foregroundColor: const Color(0xFF334155),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveCurrentLesson();
                      setState(() => _currentView = 3); // Move to Step 3
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next: final assessment",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 15),
                      ],
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

  Widget _buildLessonsSidebar() {
    int totalLessons = 0;
    for (var ch in _activeCourse.chapters) {
      totalLessons += ch.lessons.length;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
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
                    "Lessons",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    "$totalLessons lessons in ${_activeCourse.chapters.length} chapters",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: _addNewChapterDialog,
                icon: const Icon(Icons.add, size: 14),
                label: const Text("Chapter"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 10),

          // Chapters tree
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _activeCourse.chapters.length,
            itemBuilder: (context, cIdx) {
              final chapter = _activeCourse.chapters[cIdx];
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.name,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ...chapter.lessons.asMap().entries.map((entry) {
                      final lIdx = entry.key;
                      final lesson = entry.value;
                      final isSelected = _selectedChapterIndex == cIdx &&
                          _selectedLessonIndex == lIdx;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEEF2FF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(color: const Color(0xFF818CF8))
                              : null,
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          leading: const Icon(Icons.description_outlined,
                              size: 16, color: Color(0xFF4F46E5)),
                          title: Text(
                            lesson.title,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? const Color(0xFF1E1B4B)
                                  : const Color(0xFF334155),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedChapterIndex = cIdx;
                              _selectedLessonIndex = lIdx;
                              _loadCurrentLessonIntoEditor();
                            });
                          },
                        ),
                      );
                    }),
                    InkWell(
                      onTap: () => _addNewLessonDialog(cIdx),
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add,
                                size: 14, color: Color(0xFF6366F1)),
                            const SizedBox(width: 4),
                            Text(
                              "Add lesson",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6366F1),
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
          ),
        ],
      ),
    );
  }

  void _addNewChapterDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Add Chapter",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            labelText: "Chapter Name",
            hintText: "e.g. ADVANCED TOPICS & CASE STUDIES",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                setState(() {
                  _activeCourse.chapters.add(
                    StudioChapterItem(
                      name: ctrl.text.trim().toUpperCase(),
                      lessons: [
                        StudioLessonItem(
                          id: "L${DateTime.now().millisecondsSinceEpoch % 1000}",
                          title: "Key concepts",
                          minutes: 15,
                          keyPoints: "Overview and fundamentals",
                          contentMarkdown: "## Overview",
                        ),
                      ],
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938)),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addNewLessonDialog(int chapterIndex) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Add Lesson",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            labelText: "Lesson Title",
            hintText: "e.g. Algorithmic Complexity & Profiling",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                setState(() {
                  _activeCourse.chapters[chapterIndex].lessons.add(
                    StudioLessonItem(
                      id: "L${DateTime.now().millisecondsSinceEpoch % 1000}",
                      title: ctrl.text.trim(),
                      minutes: 15,
                      keyPoints: "Core outcomes and takeaways",
                      contentMarkdown: "## ${ctrl.text.trim()}\nLesson content here.",
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938)),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonDetailEditor() {
    if (_activeCourse.chapters.isEmpty ||
        _activeCourse.chapters[_selectedChapterIndex].lessons.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text("No lessons available. Add one from the sidebar.")),
      );
    }

    final currentLesson =
        _activeCourse.chapters[_selectedChapterIndex].lessons[_selectedLessonIndex];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subheader: START HERE · LESSON 1, Toggle [Edit | Student preview], Trash
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                "START HERE · LESSON ${_selectedLessonIndex + 1}",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4F46E5),
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _isStudentPreview = false),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: !_isStudentPreview
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: !_isStudentPreview
                                  ? [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 4,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              "Edit",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: !_isStudentPreview
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: !_isStudentPreview
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => _isStudentPreview = true),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: _isStudentPreview
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: _isStudentPreview
                                  ? [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 4,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              "Student preview",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: _isStudentPreview
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: _isStudentPreview
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        final ch = _activeCourse.chapters[_selectedChapterIndex];
                        ch.lessons.removeAt(_selectedLessonIndex);
                        if (_selectedLessonIndex >= ch.lessons.length) {
                          _selectedLessonIndex = ch.lessons.isNotEmpty ? ch.lessons.length - 1 : 0;
                        }
                        _loadCurrentLessonIntoEditor();
                      });
                    },
                    icon: const Icon(Icons.delete_outline,
                        size: 18, color: Color(0xFFEF4444)),
                    tooltip: "Delete lesson",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          if (_isStudentPreview) ...[
            // Student Preview Mode
            Container(
              padding: const EdgeInsets.all(16),
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
                      Text(
                        currentLesson.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "⏱ ${currentLesson.minutes} min read",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4F46E5)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (currentLesson.keyPoints.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFBBF7D0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.lightbulb_outline,
                                  size: 16, color: Color(0xFF16A34A)),
                              const SizedBox(width: 6),
                              Text(
                                "KEY POINTS INFOGRAPHIC",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF166534),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...currentLesson.keyPoints.split("\n").map(
                                (pt) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("• ",
                                          style: TextStyle(
                                              color: Color(0xFF16A34A))),
                                      Expanded(
                                        child: Text(
                                          pt,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: const Color(0xFF14532D),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    currentLesson.contentMarkdown,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF334155),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Edit Mode Form
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lesson title",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155))),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 44,
                        child: TextField(
                          controller: _lessonTitleCtrl,
                          style: GoogleFonts.poppins(fontSize: 12.5),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                SizedBox(
                  width: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Minutes",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155))),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 44,
                        child: TextField(
                          controller: _lessonMinutesCtrl,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 12.5),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Key points
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Key points (one per line)",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155))),
                const SizedBox(height: 6),
                TextField(
                  controller: _lessonKeyPointsCtrl,
                  maxLines: 4,
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Shown as an infographic panel in this lesson.",
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B)),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Lesson content (Markdown)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lesson content (Markdown)",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155))),
                const SizedBox(height: 6),
                TextField(
                  controller: _lessonContentCtrl,
                  maxLines: 12,
                  style: GoogleFonts.robotoMono(fontSize: 12),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // VIEW 3: STEP 3 - FINAL ASSESSMENT
  // Matches Screenshot 4: 4 Stat/config cards, Final assessment questions,
  // Review warning alert with "Mark all reviewed", question list.
  // ===========================================================================
  Widget _buildStep3FinalAssessment(bool isNarrow) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
      children: [
        _buildWizardTopBar(),
        const SizedBox(height: 14),
        _buildWizardStepBar(),
        const SizedBox(height: 20),

        // 4 Stat / Config Cards
        _buildAssessmentConfigCardsRow(isNarrow),
        const SizedBox(height: 20),

        // Questions Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              LayoutBuilder(
                builder: (context, headerBox) {
                  final isWide = headerBox.maxWidth >= 720;

                  final titleCol = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Final assessment questions",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Built from the lessons' key points and your department question bank. Students see these only after finishing every lesson.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  );

                  final buttons = Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _activeCourse.questions = _generateDefaultQuestions(
                                _activeCourse.title, 29);
                            _activeCourse.toReviewCount = 29;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Regenerated 30 questions from lesson key points."),
                              backgroundColor: Color(0xFF141938),
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, size: 14),
                        label: const Text("Regenerate from lessons"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          foregroundColor: const Color(0xFF334155),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _addAssessmentQuestionDialog,
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text("Add question"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF141938),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: titleCol),
                        const SizedBox(width: 16),
                        buttons,
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleCol,
                      const SizedBox(height: 12),
                      buttons,
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),

              // Review Warning Banner (Amber)
              if (_activeCourse.toReviewCount > 0)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, bannerBox) {
                      final isWide = bannerBox.maxWidth >= 720;

                      final warningText = Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              size: 18, color: Color(0xFFD97706)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "${_activeCourse.toReviewCount} questions are marked review. Edit them, or confirm you have checked them, before publishing.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF92400E),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      );

                      final actions = Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _activeCourse.allQuestionsChecked,
                                  activeColor: const Color(0xFFD97706),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (val) {
                                    setState(() {
                                      _activeCourse.allQuestionsChecked =
                                          val ?? false;
                                      if (val == true) {
                                        _markAllReviewed();
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "I have checked every question",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF92400E),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: _markAllReviewed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD97706),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text("Mark all reviewed"),
                          ),
                        ],
                      );

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: warningText),
                            const SizedBox(width: 16),
                            actions,
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          warningText,
                          const SizedBox(height: 12),
                          actions,
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),

              // Questions List (30 questions)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _activeCourse.questions.length,
                itemBuilder: (context, qIdx) {
                  final q = _activeCourse.questions[qIdx];
                  final isExpanded = _expandedQuestions.contains(q.id);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: LayoutBuilder(
                            builder: (context, qBox) {
                              final isNarrow = qBox.maxWidth < 560;

                              final numberBadge = CircleAvatar(
                                radius: 13,
                                backgroundColor: const Color(0xFFF1F5F9),
                                child: Text(
                                  "${qIdx + 1}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              );

                              final questionTitle = Text(
                                q.questionText,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1E293B),
                                  height: 1.45,
                                ),
                              );

                              final actionPills = Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: q.isReview
                                          ? const Color(0xFFFEF3C7)
                                          : const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      q.isReview ? "Review" : "Reviewed",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w600,
                                        color: q.isReview
                                            ? const Color(0xFFB45309)
                                            : const Color(0xFF15803D),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: const Color(0xFF64748B),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isExpanded) {
                                          _expandedQuestions.remove(q.id);
                                        } else {
                                          _expandedQuestions.add(q.id);
                                        }
                                      });
                                    },
                                    splashRadius: 18,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(4),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 17, color: Color(0xFF94A3B8)),
                                    onPressed: () {
                                      setState(() {
                                        _activeCourse.questions.removeAt(qIdx);
                                        _activeCourse.questionsCount =
                                            _activeCourse.questions.length;
                                        _activeCourse.toReviewCount = _activeCourse
                                            .questions
                                            .where((item) => item.isReview)
                                            .length;
                                      });
                                    },
                                    splashRadius: 18,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(4),
                                  ),
                                ],
                              );

                              if (isNarrow) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        numberBadge,
                                        const SizedBox(width: 10),
                                        Expanded(child: questionTitle),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [actionPills],
                                    ),
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  numberBadge,
                                  const SizedBox(width: 12),
                                  Expanded(child: questionTitle),
                                  const SizedBox(width: 12),
                                  actionPills,
                                ],
                              );
                            },
                          ),
                        ),
                        if (isExpanded) ...[
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...q.options.asMap().entries.map((opt) {
                                  final isCorrect = opt.key == q.correctIndex;
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isCorrect
                                          ? const Color(0xFFF0FDF4)
                                          : const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isCorrect
                                            ? const Color(0xFF86EFAC)
                                            : const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${String.fromCharCode(65 + opt.key)}. ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                            color: isCorrect
                                                ? const Color(0xFF15803D)
                                                : const Color(0xFF475569),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            opt.value,
                                            style: GoogleFonts.poppins(
                                              fontSize: 11.5,
                                              color: isCorrect
                                                  ? const Color(0xFF166534)
                                                  : const Color(0xFF334155),
                                            ),
                                          ),
                                        ),
                                        if (isCorrect)
                                          const Icon(Icons.check_circle,
                                              size: 14,
                                              color: Color(0xFF16A34A)),
                                      ],
                                    ),
                                  );
                                }),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          q.isReview = !q.isReview;
                                          _activeCourse.toReviewCount =
                                              _activeCourse.questions
                                                  .where((item) => item.isReview)
                                                  .length;
                                        });
                                      },
                                      icon: Icon(
                                        q.isReview
                                            ? Icons.check
                                            : Icons.refresh,
                                        size: 14,
                                      ),
                                      label: Text(
                                        q.isReview
                                            ? "Mark as checked"
                                            : "Mark for review",
                                        style: GoogleFonts.poppins(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Bottom Bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _currentView = 2),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text("Back"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      _activeCourse.passMark =
                          int.tryParse(_passMarkCtrl.text.trim()) ?? 50;
                      _activeCourse.timeMinutes =
                          int.tryParse(_timeMinutesCtrl.text.trim()) ?? 45;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Assessment configuration saved."),
                          backgroundColor: Color(0xFF141938),
                        ),
                      );
                    },
                    icon: const Icon(Icons.save_outlined, size: 16),
                    label: const Text("Save"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      foregroundColor: const Color(0xFF334155),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _activeCourse.passMark =
                          int.tryParse(_passMarkCtrl.text.trim()) ?? 50;
                      _activeCourse.timeMinutes =
                          int.tryParse(_timeMinutesCtrl.text.trim()) ?? 45;
                      setState(() => _currentView = 4); // Move to Step 4
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next: publish",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 15),
                      ],
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

  void _markAllReviewed() {
    setState(() {
      for (var q in _activeCourse.questions) {
        q.isReview = false;
      }
      _activeCourse.toReviewCount = 0;
      _activeCourse.allQuestionsChecked = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All questions have been marked as reviewed."),
        backgroundColor: Color(0xFF15803D),
      ),
    );
  }

  void _addAssessmentQuestionDialog() {
    final qCtrl = TextEditingController();
    final opt1Ctrl = TextEditingController();
    final opt2Ctrl = TextEditingController();
    final opt3Ctrl = TextEditingController();
    final opt4Ctrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Add Assessment Question",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: qCtrl,
                decoration: const InputDecoration(labelText: "Question Text"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: opt1Ctrl,
                decoration: const InputDecoration(labelText: "Option A (Correct)"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: opt2Ctrl,
                decoration: const InputDecoration(labelText: "Option B"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: opt3Ctrl,
                decoration: const InputDecoration(labelText: "Option C"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: opt4Ctrl,
                decoration: const InputDecoration(labelText: "Option D"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (qCtrl.text.trim().isNotEmpty) {
                setState(() {
                  _activeCourse.questions.add(
                    StudioQuestionItem(
                      id: "Q${_activeCourse.questions.length + 1}",
                      questionText: qCtrl.text.trim(),
                      options: [
                        opt1Ctrl.text.trim().isNotEmpty
                            ? opt1Ctrl.text.trim()
                            : "Option A",
                        opt2Ctrl.text.trim().isNotEmpty
                            ? opt2Ctrl.text.trim()
                            : "Option B",
                        opt3Ctrl.text.trim().isNotEmpty
                            ? opt3Ctrl.text.trim()
                            : "Option C",
                        opt4Ctrl.text.trim().isNotEmpty
                            ? opt4Ctrl.text.trim()
                            : "Option D",
                      ],
                      correctIndex: 0,
                      isReview: false,
                    ),
                  );
                  _activeCourse.questionsCount = _activeCourse.questions.length;
                });
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938)),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentConfigCardsRow(bool isNarrow) {
    final card1 = _buildConfigValueCard(
      title: "Questions",
      value: "${_activeCourse.questionsCount}",
    );

    final card2 = _buildConfigValueCard(
      title: "To review",
      value: "${_activeCourse.toReviewCount}",
      valueColor: _activeCourse.toReviewCount > 0
          ? const Color(0xFFD97706)
          : const Color(0xFF15803D),
    );

    final card3 = _buildConfigInputCard(
      title: "Pass mark %",
      controller: _passMarkCtrl,
    );

    final card4 = _buildConfigInputCard(
      title: "Time (minutes)",
      controller: _timeMinutesCtrl,
    );

    if (isNarrow) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: card1),
              const SizedBox(width: 12),
              Expanded(child: card2),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: card3),
              const SizedBox(width: 12),
              Expanded(child: card4),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: card1),
        const SizedBox(width: 14),
        Expanded(child: card2),
        const SizedBox(width: 14),
        Expanded(child: card3),
        const SizedBox(width: 14),
        Expanded(child: card4),
      ],
    );
  }

  Widget _buildConfigValueCard({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: valueColor ?? const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigInputCard({
    required String title,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 38,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // VIEW 4: STEP 4 - PUBLISH REVIEW
  // Matches Screenshot 5: Two-column layout (Ready to publish card & What students see)
  // ===========================================================================
  Widget _buildStep4PublishReview(bool isNarrow) {
    int totalLessons = 0;
    for (var ch in _activeCourse.chapters) {
      totalLessons += ch.lessons.length;
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
      children: [
        _buildWizardTopBar(),
        const SizedBox(height: 14),
        _buildWizardStepBar(),
        const SizedBox(height: 20),

        if (isNarrow)
          Column(
            children: [
              _buildReadyToPublishCard(totalLessons),
              const SizedBox(height: 20),
              _buildWhatStudentsSeeCard(totalLessons),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildReadyToPublishCard(totalLessons)),
              const SizedBox(width: 20),
              Expanded(flex: 4, child: _buildWhatStudentsSeeCard(totalLessons)),
            ],
          ),

        const SizedBox(height: 24),

        // Bottom bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _currentView = 3),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text("Back"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadyToPublishCard(int totalLessons) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ready to publish?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Students in this college see published courses in My Courses. They read the lessons, then take the final assessment to earn a certificate.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Checklist Item 1: Lessons
          _buildPublishChecklistItem(
            isSuccess: true,
            title:
                "$totalLessons lessons in ${_activeCourse.chapters.length} chapters",
          ),
          const SizedBox(height: 10),

          // Checklist Item 2: Assessment
          _buildPublishChecklistItem(
            isSuccess: true,
            title:
                "${_activeCourse.questionsCount} final assessment questions (pass mark ${_activeCourse.passMark}%, ${_activeCourse.timeMinutes} min)",
          ),
          const SizedBox(height: 10),

          // Checklist Item 3: Review Warning
          if (_activeCourse.toReviewCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 16, color: Color(0xFFD97706)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${_activeCourse.toReviewCount} question(s) still marked for review",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() => _currentView = 3),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      side: const BorderSide(color: Color(0xFFD97706)),
                      foregroundColor: const Color(0xFF92400E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text("Fix"),
                  ),
                ],
              ),
            )
          else
            _buildPublishChecklistItem(
              isSuccess: true,
              title: "All assessment questions verified and reviewed",
            ),

          const SizedBox(height: 28),

          // Action Buttons
          Wrap(
            spacing: 14,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _activeCourse.status = "Published";
                    _currentView = 0; // Return to dashboard
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Course '${_activeCourse.title}' published to students!"),
                      backgroundColor: const Color(0xFF15803D),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Publish to students",
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton.icon(
                onPressed: () => _deleteCourse(_activeCourse),
                icon: const Icon(Icons.delete_outline,
                    size: 16, color: Color(0xFFEF4444)),
                label: Text(
                  "Delete course",
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, color: const Color(0xFFEF4444)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPublishChecklistItem({
    required bool isSuccess,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.warning_amber_rounded,
            size: 16,
            color: isSuccess
                ? const Color(0xFF10B981)
                : const Color(0xFFD97706),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatStudentsSeeCard(int totalLessons) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What students see",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 18),
          _buildNumberedBullet(
            number: "1",
            text: "$totalLessons lessons, read one after another",
          ),
          const SizedBox(height: 12),
          _buildNumberedBullet(
            number: "2",
            text: "Each lesson is marked complete to unlock the next",
          ),
          const SizedBox(height: 12),
          _buildNumberedBullet(
            number: "3",
            text:
                "${_activeCourse.questionsCount}-question final assessment, ${_activeCourse.timeMinutes} min, 3 attempts",
          ),
          const SizedBox(height: 12),
          _buildNumberedBullet(
            number: "4",
            text:
                "Certificate graded O / A+ / A / B / C when they score ${_activeCourse.passMark}% or more",
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedBullet({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4F46E5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// DATA MODELS
// =============================================================================
class StudioCourseItem {
  String id;
  String title;
  String code;
  String department;
  String faculty;
  String level;
  String term;
  String credits;
  String builtFrom; // "Course title" or "Custom syllabus"
  int lessonsCount;
  int chaptersCount;
  int questionsCount;
  int toReviewCount;
  String students;
  String status; // "Published" or "Draft"
  List<StudioChapterItem> chapters;
  List<StudioQuestionItem> questions;
  int passMark;
  int timeMinutes;
  bool allQuestionsChecked;

  StudioCourseItem({
    required this.id,
    required this.title,
    required this.code,
    required this.department,
    required this.faculty,
    required this.level,
    required this.term,
    required this.credits,
    required this.builtFrom,
    required this.lessonsCount,
    required this.chaptersCount,
    required this.questionsCount,
    required this.toReviewCount,
    required this.students,
    required this.status,
    required this.chapters,
    required this.questions,
    this.passMark = 50,
    this.timeMinutes = 45,
    this.allQuestionsChecked = false,
  });
}

class StudioChapterItem {
  String name;
  List<StudioLessonItem> lessons;

  StudioChapterItem({required this.name, required this.lessons});
}

class StudioLessonItem {
  String id;
  String title;
  int minutes;
  String keyPoints;
  String contentMarkdown;

  StudioLessonItem({
    required this.id,
    required this.title,
    required this.minutes,
    required this.keyPoints,
    required this.contentMarkdown,
  });
}

class StudioQuestionItem {
  String id;
  String questionText;
  List<String> options;
  int correctIndex;
  bool isReview;

  StudioQuestionItem({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.isReview,
  });
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
