import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DATA MODELS
// =============================================================================
enum SessionStatus { pending, taught, skipped }

class CustomUnitItem {
  final TextEditingController nameCtrl;
  final TextEditingController hoursCtrl;
  final TextEditingController topicsCtrl;

  CustomUnitItem({
    required String name,
    required String hours,
    required String topics,
  })  : nameCtrl = TextEditingController(text: name),
        hoursCtrl = TextEditingController(text: hours),
        topicsCtrl = TextEditingController(text: topics);

  void dispose() {
    nameCtrl.dispose();
    hoursCtrl.dispose();
    topicsCtrl.dispose();
  }
}

class RoadmapSession {
  final String id;
  String dateStr;
  String title;
  int unitNumber;
  String unitName;
  String sessionType; // 'Lecture', 'Tutorial', 'Lab', 'Internal Assessment', 'Revision'
  SessionStatus status;
  String? note;
  bool isEditing;

  RoadmapSession({
    required this.id,
    required this.dateStr,
    required this.title,
    required this.unitNumber,
    required this.unitName,
    this.sessionType = 'Lecture',
    this.status = SessionStatus.pending,
    this.note,
    this.isEditing = false,
  });
}

class CourseRoadmap {
  final String id;
  String courseCode;
  String courseTitle;
  String curriculum;
  String section;
  String teachingDaysStr;
  List<String> teachingDays;
  String dateRangeStr;
  int totalSessions;
  int taughtCount;
  int behindCount;
  List<RoadmapSession> sessions;

  CourseRoadmap({
    required this.id,
    required this.courseCode,
    required this.courseTitle,
    required this.curriculum,
    required this.section,
    required this.teachingDaysStr,
    this.teachingDays = const ['Mon', 'Wed', 'Fri'],
    required this.dateRangeStr,
    required this.totalSessions,
    this.taughtCount = 0,
    this.behindCount = 0,
    required this.sessions,
  });

  double get progress => totalSessions > 0 ? (taughtCount / totalSessions) : 0.0;
  int get progressPercent => (progress * 100).round();
  int get toGoCount => (totalSessions - taughtCount).clamp(0, totalSessions);
}

// =============================================================================
// COURSE ROADMAP SCREEN
// =============================================================================
class CourseRoadmapScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CourseRoadmapScreen({super.key, this.onBack});

  @override
  State<CourseRoadmapScreen> createState() => _CourseRoadmapScreenState();
}

class _CourseRoadmapScreenState extends State<CourseRoadmapScreen> {
  // Navigation: 0 = Cards Overview (Image 1), 1 = New Roadmap Form (Image 2), 2 = Roadmap Detail (Images 3,4,5)
  int _currentView = 0;
  CourseRoadmap? _selectedRoadmap;

  // New Roadmap Form State
  int _sourceMode = 0; // 0 = University curriculum, 1 = My own units
  String _selectedCurriculum = 'B.Tech. Artificial Intelligence and Data Science (R2026)';
  String _selectedCourse = 'Sem 1 · AI101 Foundations of Artificial Intelligence & Machine Learning';
  final TextEditingController _sectionCtrl = TextEditingController(text: 'III CSE A');
  final TextEditingController _firstClassCtrl = TextEditingController(text: '11/13/2026');
  final Set<String> _selectedDays = {'Mon', 'Wed', 'Fri'};
  bool _addInternalAssessments = true;

  // My own units state (Image from user)
  final TextEditingController _customCourseTitleCtrl = TextEditingController();
  final List<CustomUnitItem> _customUnits = [];

  final List<String> _curriculumOptions = [
    'B.Tech. Artificial Intelligence and Data Science (R2026)',
    'B.E. Computer Science & Engineering (R2026)',
    'B.E. ECE (R2026)',
  ];

  final List<String> _courseOptions = [
    'Sem 1 · AI101 Foundations of Artificial Intelligence & Machine Learning',
    'Sem 1 · BS101 Physics and Chemistry Laboratory',
    'Sem 1 · CS101 Data Structures and Algorithms',
    'Sem 1 · CS102 Problem Solving & Python Programming',
    'Sem 3 · CS301 Advanced Java Programming',
    'Sem 1 · CS201 Object-Oriented Programming with Java',
    'Sem 6 · CS3492 Cloud Computing & Virtualization',
  ];

  late List<CourseRoadmap> _roadmaps;

  @override
  void initState() {
    super.initState();
    _customUnits.add(
      CustomUnitItem(name: 'Unit 1', hours: '9', topics: ''),
    );
    _roadmaps = [
      CourseRoadmap(
        id: '1',
        courseCode: 'CS101',
        courseTitle: 'Data Structures and Algorithms',
        curriculum: 'B.E. Computer Science & Engineering (R2026)',
        section: 'II CSE B',
        teachingDaysStr: 'Mon, Wed, Fri',
        dateRangeStr: '20 Oct – 8 Feb 2027 · 0/48 sessions',
        totalSessions: 48,
        taughtCount: 0,
        behindCount: 9,
        sessions: _generateSampleSessions('CS101', 'Data Structures and Algorithms'),
      ),
      CourseRoadmap(
        id: '2',
        courseCode: 'Own course',
        courseTitle: 'Relational Model & SQL',
        curriculum: 'B.E. Computer Science & Engineering (R2026)',
        section: 'CSA A',
        teachingDaysStr: 'Mon, Wed',
        dateRangeStr: '12 Oct – 2 Nov 2026 · 2/10 sessions',
        totalSessions: 10,
        taughtCount: 2,
        behindCount: 8,
        sessions: _generateSampleSessions('Own course', 'Relational Model & SQL'),
      ),
      CourseRoadmap(
        id: '3',
        courseCode: 'AI101',
        courseTitle: 'Foundations of Artificial Intelligence & Machine Learning',
        curriculum: 'B.Tech. Artificial Intelligence & Data Science (R2026)',
        section: 'I AI&DS A',
        teachingDaysStr: 'Tue, Thu, Fri',
        dateRangeStr: '8 Oct – 27 Jan 2027 · 3/48 sessions',
        totalSessions: 48,
        taughtCount: 3,
        behindCount: 11,
        sessions: _generateSampleSessions('AI101', 'Foundations of AI & ML'),
      ),
      CourseRoadmap(
        id: '4',
        courseCode: 'BS101',
        courseTitle: 'Physics and Chemistry Laboratory',
        curriculum: 'B.E. Computer Science & Engineering (R2026)',
        section: 'III CSE A',
        teachingDaysStr: 'Mon, Wed, Fri',
        dateRangeStr: '11 Nov – 15 Feb 2027 · 0/48 sessions',
        totalSessions: 48,
        taughtCount: 0,
        behindCount: 0,
        sessions: _buildLaboratorySessions(),
      ),
    ];
  }

  @override
  void dispose() {
    _sectionCtrl.dispose();
    _firstClassCtrl.dispose();
    _customCourseTitleCtrl.dispose();
    for (var u in _customUnits) {
      u.dispose();
    }
    super.dispose();
  }

  // Pre-loaded sessions matching Screenshots 3, 4, 5
  List<RoadmapSession> _buildLaboratorySessions() {
    return [
      // Week 1
      RoadmapSession(
        id: 's1',
        dateStr: 'Wed, 11 Nov',
        title: "Ohm's Law verification",
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's2',
        dateStr: 'Fri, 13 Nov',
        title: "Ohm's Law verification",
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's3',
        dateStr: 'Mon, 16 Nov',
        title: 'series and parallel circuits',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),

      // Week 2
      RoadmapSession(
        id: 's4',
        dateStr: 'Wed, 18 Nov',
        title: 'measurement of resistance',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's5',
        dateStr: 'Fri, 20 Nov',
        title: 'voltage',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's6',
        dateStr: 'Mon, 23 Nov',
        title: 'current using multimeter',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),

      // Week 3
      RoadmapSession(
        id: 's7',
        dateStr: 'Wed, 25 Nov',
        title: 'study of RC circuits',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's8',
        dateStr: 'Fri, 27 Nov',
        title: 'diode characteristics (continued)',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's9',
        dateStr: 'Mon, 30 Nov',
        title: 'Problem solving and recap: Basic Electrical & Electronic Measurements',
        unitNumber: 1,
        unitName: 'Basic Electrical & Electronic Measurements',
        sessionType: 'Tutorial',
      ),

      // Week 4
      RoadmapSession(
        id: 's10',
        dateStr: 'Wed, 2 Dec',
        title: 'Determination of refractive index using spectrometer',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's11',
        dateStr: 'Fri, 4 Dec',
        title: 'Determination of refractive index using spectrometer',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's12',
        dateStr: 'Mon, 7 Dec',
        title: "Newton's rings",
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),

      // Week 5
      RoadmapSession(
        id: 's13',
        dateStr: 'Wed, 9 Dec',
        title: "Newton's rings",
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's14',
        dateStr: 'Fri, 11 Dec',
        title: 'diffraction grating experiment',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's15',
        dateStr: 'Mon, 14 Dec',
        title: 'study of laser characteristics (wavelength (continued)',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),

      // Week 6 (Matches Screenshot 4 with skipped item)
      RoadmapSession(
        id: 's16',
        dateStr: 'Wed, 16 Dec',
        title: 'study of laser characteristics (wavelength (continued)',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
        status: SessionStatus.skipped,
      ),
      RoadmapSession(
        id: 's17',
        dateStr: 'Fri, 18 Dec',
        title: 'divergence) (continued)',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Lecture',
      ),
      RoadmapSession(
        id: 's18',
        dateStr: 'Mon, 21 Dec',
        title: 'Problem solving and recap: Optics and Wave Phenomena',
        unitNumber: 2,
        unitName: 'Optics and Wave Phenomena',
        sessionType: 'Tutorial',
      ),
    ];
  }

  List<RoadmapSession> _generateSampleSessions(String code, String name) {
    return List.generate(12, (index) {
      return RoadmapSession(
        id: 'gen_$index',
        dateStr: 'Day ${index + 1}',
        title: 'Session ${index + 1}: Fundamental Concepts',
        unitNumber: (index ~/ 3) + 1,
        unitName: 'Unit ${(index ~/ 3) + 1}',
        sessionType: index % 4 == 3 ? 'Tutorial' : 'Lecture',
      );
    });
  }

  // ===========================================================================
  // ROOT BUILD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. Active View Switch
              if (_currentView == 0) ...[
                _buildOverviewView(),
              ] else if (_currentView == 1) ...[
                _buildNewRoadmapFormView(),
              ] else if (_currentView == 2 && _selectedRoadmap != null) ...[
                _buildRoadmapDetailView(_selectedRoadmap!),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E2865),
            Color(0xFF283593),
            Color(0xFF1E2865),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(
                  gridColor: Colors.white.withValues(alpha: 0.07),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.explore_rounded,
                size: 160,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_currentView != 0) {
                            setState(() => _currentView = 0);
                          } else if (widget.onBack != null) {
                            widget.onBack!();
                          }
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_new_rounded, size: 12, color: Colors.white70),
                            const SizedBox(width: 4),
                            Text(
                              'Home',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.75),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '  ›  Academics  ›  ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        'Course Roadmap',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tag badges row: ACADEMICS + MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ACADEMICS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'MVP',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Icon + Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF141B4D),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: const Icon(
                          Icons.explore_rounded,
                          color: Color(0xFFF59E0B),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Roadmap',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Turn a course\'s syllabus into a dated, session-by-session teaching plan and track what you have covered.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
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

  // ===========================================================================
  // VIEW 1: CARDS OVERVIEW (IMAGE 1)
  // ===========================================================================
  Widget _buildOverviewView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sub-bar description + "+ New roadmap" button
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 620;

            final descriptionText = Text(
              'Pick a course and the days you teach it; the roadmap spreads the syllabus over dated sessions with tutorials, internal assessments and revision. Tick sessions off as you teach.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            );

            final newRoadmapBtn = ElevatedButton.icon(
              onPressed: () => setState(() => _currentView = 1),
              icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
              label: Text(
                'New roadmap',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            );

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  descriptionText,
                  const SizedBox(height: 12),
                  Align(alignment: Alignment.centerLeft, child: newRoadmapBtn),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: descriptionText),
                const SizedBox(width: 20),
                newRoadmapBtn,
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Roadmap Cards Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            double itemWidth;
            if (width >= 960) {
              itemWidth = (width - 32) / 3;
            } else if (width >= 620) {
              itemWidth = (width - 16) / 2;
            } else {
              itemWidth = width;
            }

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _roadmaps.map((roadmap) {
                return _buildRoadmapCard(roadmap, itemWidth);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRoadmapCard(CourseRoadmap roadmap, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRoadmap = roadmap;
          _currentView = 2;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
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
            // Top Row: Code + Circular Progress Ring
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roadmap.courseCode,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                _buildCircularProgressBadge(roadmap.progressPercent),
              ],
            ),
            const SizedBox(height: 8),

            // Course Title
            Text(
              roadmap.courseTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2865),
              ),
            ),
            const SizedBox(height: 4),

            // Section
            Text(
              roadmap.section,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),

            // Schedule info
            Text(
              roadmap.dateRangeStr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),

            // Sessions Behind Pill
            if (roadmap.behindCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFFB45309)),
                    const SizedBox(width: 5),
                    Text(
                      '${roadmap.behindCount} sessions behind',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
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

  Widget _buildCircularProgressBadge(int percent) {
    return SizedBox(
      width: 38,
      height: 38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent / 100,
            strokeWidth: 3.5,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(
              percent > 0 ? const Color(0xFF0D9488) : const Color(0xFFE2E8F0),
            ),
          ),
          Text(
            '$percent%',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E2865),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // VIEW 2: NEW COURSE ROADMAP FORM (IMAGE 2)
  // ===========================================================================
  Widget _buildNewRoadmapFormView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
          // Header + Cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New course roadmap',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E2865),
                ),
              ),
              InkWell(
                onTap: () => setState(() => _currentView = 0),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tabs: University curriculum / My own units
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTabPill(title: 'University curriculum', index: 0),
                const SizedBox(width: 4),
                _buildTabPill(title: 'My own units', index: 1),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // TAB 0: UNIVERSITY CURRICULUM
          if (_sourceMode == 0) ...[
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 620;

                final curriculumWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Curriculum'),
                    const SizedBox(height: 6),
                    _buildDropdown<String>(
                      value: _selectedCurriculum,
                      items: _curriculumOptions,
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedCurriculum = val);
                      },
                    ),
                  ],
                );

                final courseWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Course'),
                    const SizedBox(height: 6),
                    _buildDropdown<String>(
                      value: _selectedCourse,
                      items: _courseOptions,
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedCourse = val);
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '5 units · 45 hours',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF9CA3AF)),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    children: [
                      curriculumWidget,
                      const SizedBox(height: 16),
                      courseWidget,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: curriculumWidget),
                    const SizedBox(width: 16),
                    Expanded(child: courseWidget),
                  ],
                );
              },
            ),
          ] else ...[
            // TAB 1: MY OWN UNITS (MATCHES USER SCREENSHOT EXACTLY)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel('Course title'),
                const SizedBox(height: 6),
                TextField(
                  controller: _customCourseTitleCtrl,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                  decoration: _inputDeco(),
                ),
                const SizedBox(height: 16),

                // Dynamic Unit Cards List
                ..._customUnits.asMap().entries.map((entry) {
                  final index = entry.key;
                  final unit = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: Unit Name (flexible) & Hours
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: unit.nameCtrl,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E2865),
                                ),
                                decoration: _inputDeco(hint: 'Unit title'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 55,
                              child: TextField(
                                controller: unit.hoursCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E2865),
                                ),
                                decoration: _inputDeco(),
                              ),
                            ),
                            if (_customUnits.length > 1) ...[
                              const SizedBox(width: 6),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _customUnits.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.remove_circle_outline_rounded, size: 18, color: Color(0xFF9CA3AF)),
                                tooltip: 'Remove unit',
                                splashRadius: 16,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Bottom Row: Topics, comma-separated
                        TextField(
                          controller: unit.topicsCtrl,
                          maxLines: 2,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                          decoration: _inputDeco(hint: 'Topics, comma-separated'),
                        ),
                      ],
                    ),
                  );
                }),

                // + Add unit button
                InkWell(
                  onTap: () {
                    setState(() {
                      final nextNum = _customUnits.length + 1;
                      _customUnits.add(
                        CustomUnitItem(name: 'Unit $nextNum', hours: '9', topics: ''),
                      );
                    });
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add_rounded, size: 18, color: Color(0xFF1E2865)),
                        const SizedBox(width: 4),
                        Text(
                          'Add unit',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E2865),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),

          // Row 2: Class/section, First class on, Teaching days (Responsive)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 880;

              final sectionWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Class / section'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _sectionCtrl,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    decoration: _inputDeco(hint: 'e.g. III CSE A'),
                  ),
                ],
              );

              final dateWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('First class on'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _firstClassCtrl,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    decoration: _inputDeco().copyWith(
                      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
                    ),
                  ),
                ],
              );

              final daysWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Teaching days'),
                  const SizedBox(height: 6),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 6,
                      children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
                        final isSelected = _selectedDays.contains(day);
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                if (_selectedDays.length > 1) _selectedDays.remove(day);
                              } else {
                                _selectedDays.add(day);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFD1D5DB),
                              ),
                            ),
                            child: Text(
                              day,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : const Color(0xFF374151),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionWidget,
                    const SizedBox(height: 16),
                    dateWidget,
                    const SizedBox(height: 16),
                    daysWidget,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: sectionWidget),
                  const SizedBox(width: 16),
                  Expanded(flex: 3, child: dateWidget),
                  const SizedBox(width: 16),
                  Expanded(flex: 4, child: daysWidget),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Checkbox: Add internal assessments after units 2 and 4
          InkWell(
            onTap: () => setState(() => _addInternalAssessments = !_addInternalAssessments),
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Checkbox(
                    value: _addInternalAssessments,
                    activeColor: const Color(0xFF1E2865),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (v) => setState(() => _addInternalAssessments = v ?? false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Add internal assessments after units 2 and 4',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: const Color(0xFF374151),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Build roadmap button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                final isCustom = _sourceMode == 1;
                final customTitle = _customCourseTitleCtrl.text.trim();
                final title = isCustom
                    ? (customTitle.isEmpty ? 'Relational Model & SQL' : customTitle)
                    : 'Physics and Chemistry Laboratory';
                final code = isCustom ? 'Own course' : 'BS101';
                final section = _sectionCtrl.text.trim().isEmpty ? 'III CSE A' : _sectionCtrl.text.trim();

                List<RoadmapSession> sessionsList;
                int totalSessionCount;

                if (isCustom) {
                  sessionsList = [];
                  int sId = 1;
                  for (int uIdx = 0; uIdx < _customUnits.length; uIdx++) {
                    final u = _customUnits[uIdx];
                    final unitNum = uIdx + 1;
                    final rawTopics = u.topicsCtrl.text.trim();
                    final topics = rawTopics.isEmpty
                        ? [
                            'Introduction and relational schema',
                            'Queries and operations',
                            'Integrity constraints and optimization'
                          ]
                        : rawTopics.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();

                    for (var t in topics) {
                      sessionsList.add(
                        RoadmapSession(
                          id: 'custom_s$sId',
                          dateStr: 'Session $sId',
                          title: t,
                          unitNumber: unitNum,
                          unitName: u.nameCtrl.text.trim().isEmpty ? 'Unit $unitNum' : u.nameCtrl.text.trim(),
                          sessionType: sId % 4 == 0 ? 'Tutorial' : 'Lecture',
                        ),
                      );
                      sId++;
                    }
                  }
                  totalSessionCount = sessionsList.isNotEmpty ? sessionsList.length : 10;
                } else {
                  sessionsList = _buildLaboratorySessions();
                  totalSessionCount = 48;
                }

                final newRoadmap = CourseRoadmap(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  courseCode: code,
                  courseTitle: title,
                  curriculum: isCustom ? 'Custom Syllabus' : _selectedCurriculum,
                  section: section,
                  teachingDaysStr: _selectedDays.join(', '),
                  teachingDays: _selectedDays.toList(),
                  dateRangeStr: '11 Nov – 15 Feb 2027 · 0/$totalSessionCount sessions',
                  totalSessions: totalSessionCount,
                  taughtCount: 0,
                  behindCount: 0,
                  sessions: sessionsList,
                );

                setState(() {
                  _roadmaps.insert(0, newRoadmap);
                  _selectedRoadmap = newRoadmap;
                  _currentView = 2; // Jump to Roadmap Detail Tracker
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Course roadmap built successfully!',
                      style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: const Color(0xFF1E2865),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.alt_route_rounded, size: 17, color: Colors.white),
              label: Text(
                'Build roadmap',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill({required String title, required int index}) {
    final isSelected = _sourceMode == index;
    final isCustomAmber = index == 1 && isSelected;
    return InkWell(
      onTap: () => setState(() => _sourceMode = index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: isCustomAmber ? const Color(0xFFD97706) : const Color(0xFFCBD5E1),
                  width: isCustomAmber ? 1.5 : 1.0,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // VIEW 3: ROADMAP DETAIL SESSION TRACKER (IMAGES 3, 4, 5)
  // ===========================================================================
  Widget _buildRoadmapDetailView(CourseRoadmap roadmap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Card with Metrics and Actions
        _buildDetailHeaderCard(roadmap),
        const SizedBox(height: 24),

        // 2. Sessions by Weeks
        _buildWeekSessionsSection(roadmap),
      ],
    );
  }

  Widget _buildDetailHeaderCard(CourseRoadmap roadmap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
          // Top Row: Back button, Code, Title, Actions
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 650;

              final titleBlock = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _currentView = 0),
                    icon: const Icon(Icons.arrow_back_rounded, size: 20, color: Color(0xFF4B5563)),
                    tooltip: 'Back to all roadmaps',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roadmap.courseCode,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          roadmap.courseTitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E2865),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${roadmap.curriculum} · ${roadmap.teachingDaysStr}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final actionsBlock = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCircularProgressBadge(roadmap.progressPercent),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rescheduling dates aligned with university holiday calendar.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month_outlined, size: 15, color: Color(0xFF374151)),
                    label: Text('Reschedule', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF374151))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preparing printable course roadmap...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.print_outlined, size: 15, color: Color(0xFF374151)),
                    label: Text('Print', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF374151))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _roadmaps.removeWhere((e) => e.id == roadmap.id);
                        _currentView = 0;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Roadmap removed')),
                      );
                    },
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                    tooltip: 'Delete roadmap',
                    splashRadius: 18,
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBlock,
                    const SizedBox(height: 14),
                    actionsBlock,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: titleBlock),
                  const SizedBox(width: 14),
                  actionsBlock,
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Stat boxes: 0 taught, 48 to go, 0 behind
          Row(
            children: [
              _buildStatBox(
                value: '${roadmap.taughtCount}',
                label: 'taught',
                bg: const Color(0xFFE8F5E9),
                textColor: const Color(0xFF1B5E20),
              ),
              const SizedBox(width: 12),
              _buildStatBox(
                value: '${roadmap.toGoCount}',
                label: 'to go',
                bg: const Color(0xFFF1F5F9),
                textColor: const Color(0xFF334155),
              ),
              const SizedBox(width: 12),
              _buildStatBox(
                value: '${roadmap.behindCount}',
                label: 'behind',
                bg: const Color(0xFFF1F5F9),
                textColor: const Color(0xFF334155),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Unit breakdown pills: Unit 1: 0/9, Unit 2: 0/9 ...
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [1, 2, 3, 4, 5].map((u) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Text(
                    'Unit $u: 0/9',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox({
    required String value,
    required String label,
    required Color bg,
    required Color textColor,
  }) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // WEEKS AND SESSIONS
  // ===========================================================================
  Widget _buildWeekSessionsSection(CourseRoadmap roadmap) {
    // Group sessions into weeks (3 sessions per week)
    final sessions = roadmap.sessions;
    final int weekCount = (sessions.length / 3).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(weekCount, (wIndex) {
        final startIdx = wIndex * 3;
        final endIdx = (startIdx + 3).clamp(0, sessions.length);
        final weekSessions = sessions.sublist(startIdx, endIdx);
        final weekNumber = wIndex + 1;

        return Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WEEK $weekNumber',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),

              // Sessions container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weekSessions.length,
                  separatorBuilder: (_, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  itemBuilder: (context, sIdx) {
                    final session = weekSessions[sIdx];
                    return _buildSessionRow(roadmap, session);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSessionRow(CourseRoadmap roadmap, RoadmapSession session) {
    final titleCtrl = TextEditingController(text: session.title);
    final noteCtrl = TextEditingController(text: session.note ?? '');
    String selectedType = session.sessionType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 620;

          // If in inline editing mode (Image 5)
          if (session.isEditing) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        session.dateStr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E2865),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.person_outline_rounded, size: 18, color: Color(0xFF3B82F6)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: titleCtrl,
                            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                            decoration: _inputDeco(),
                          ),
                          const SizedBox(height: 8),
                          _buildDropdown<String>(
                            value: selectedType,
                            items: const ['Lecture', 'Tutorial', 'Lab', 'Internal Assessment', 'Revision'],
                            onChanged: (val) {
                              if (val != null) selectedType = val;
                            },
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: noteCtrl,
                            style: GoogleFonts.plusJakartaSans(fontSize: 13),
                            decoration: _inputDeco(hint: 'Note (what was covered, homework...)'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                session.title = titleCtrl.text.trim();
                                session.sessionType = selectedType;
                                session.note = noteCtrl.text.trim();
                                session.isEditing = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Text('Save', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          // Normal session row
          final leftSection = Row(
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  session.dateStr,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: session.sessionType == 'Tutorial' ? const Color(0xFFF3E8FF) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  session.sessionType == 'Tutorial' ? Icons.groups_outlined : Icons.person_outline_rounded,
                  size: 18,
                  color: session.sessionType == 'Tutorial' ? const Color(0xFF9333EA) : const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: session.status == SessionStatus.skipped
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF1F2937),
                        decoration: session.status == SessionStatus.skipped
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Unit ${session.unitNumber} · ${session.unitName} · ${session.sessionType}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final rightActions = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // If skipped, show Skipped pill with undo button (Image 4)
              if (session.status == SessionStatus.skipped) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skipped',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          setState(() {
                            session.status = SessionStatus.pending;
                          });
                        },
                        child: const Icon(Icons.undo_rounded, size: 14, color: Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ] else ...[
                // ✓ Taught button
                InkWell(
                  onTap: () {
                    setState(() {
                      if (session.status == SessionStatus.taught) {
                        session.status = SessionStatus.pending;
                        roadmap.taughtCount = (roadmap.taughtCount - 1).clamp(0, roadmap.totalSessions);
                      } else {
                        session.status = SessionStatus.taught;
                        roadmap.taughtCount = (roadmap.taughtCount + 1).clamp(0, roadmap.totalSessions);
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: session.status == SessionStatus.taught ? const Color(0xFFDCFCE7) : Colors.white,
                      border: Border.all(
                        color: session.status == SessionStatus.taught ? const Color(0xFF16A34A) : const Color(0xFFD1D5DB),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: session.status == SessionStatus.taught ? const Color(0xFF16A34A) : const Color(0xFF374151),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Taught',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: session.status == SessionStatus.taught ? const Color(0xFF16A34A) : const Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Skip button
                InkWell(
                  onTap: () {
                    setState(() {
                      session.status = SessionStatus.skipped;
                    });
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFD1D5DB)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],

              // Edit Pencil Icon
              IconButton(
                onPressed: () {
                  setState(() {
                    session.isEditing = true;
                  });
                },
                icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF6B7280)),
                tooltip: 'Edit session',
                splashRadius: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leftSection,
                const SizedBox(height: 10),
                Align(alignment: Alignment.centerRight, child: rightActions),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: leftSection),
              const SizedBox(width: 12),
              rightActions,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF374151),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF6B7280)),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                '$item',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF1E2865), fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  InputDecoration _inputDeco({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF9CA3AF)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _BlueprintGridPainter({required this.gridColor, this.step = 26.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
