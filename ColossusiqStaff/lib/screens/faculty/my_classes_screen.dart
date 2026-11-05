import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: MY CLASSES SCREEN
// Exactly matches Screenshot 2:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - 4 Metric Stat Cards (Teaching Load, Assigned Sections, Enrolled Students, Avg. Attendance)
// - Profile Action Strip (Dr. Meena Raghavan, Take Attendance, + Add Extra Class, Export CSV)
// - Tab Pills (Assigned Sections, Weekly Timetable, Live Attendance, etc.)
// - Search & Semester Filter
// - 3 Class Cards Grid with syllabus mastery bars & action buttons
// =============================================================================

class MyClassesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const MyClassesScreen({super.key, this.onBack});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = [
    'Assigned Sections (4)',
    'Weekly Timetable',
    'Live Attendance Register',
    'Class Performance & Mastery',
    'Attendance History (3)',
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedSemester = 'All Semesters';

  final List<Map<String, dynamic>> _classes = [
    {
      'code': 'CS3492',
      'section': 'CSE-A · Sem 5',
      'hours': '4 hrs/wk',
      'title': 'Database Management Systems',
      'venue': 'LH-204',
      'next': 'Next: Today 09:00',
      'students': '64',
      'attendance': '88%',
      'avgScore': '68%',
      'units': '5 Units',
      'colors': [
        const Color(0xFF06B6D4),
        const Color(0xFFF43F5E),
        const Color(0xFFF59E0B),
        const Color(0xFF10B981),
      ],
    },
    {
      'code': 'CS3492',
      'section': 'CSE-B · Sem 5',
      'hours': '4 hrs/wk',
      'title': 'Database Management Systems',
      'venue': 'LH-206',
      'next': 'Next: Today 14:00',
      'students': '62',
      'attendance': '84%',
      'avgScore': '64%',
      'units': '5 Units',
      'colors': [
        const Color(0xFF06B6D4),
        const Color(0xFF10B981),
        const Color(0xFFF59E0B),
        const Color(0xFFF43F5E),
      ],
    },
    {
      'code': 'CS3492L',
      'section': 'AI&DS · Sem 5',
      'hours': '3 hrs/wk',
      'title': 'DBMS Laboratory & SQL Studio',
      'venue': 'Computing Lab 3',
      'next': 'Next: Tomorrow 10:00',
      'students': '58',
      'attendance': '91%',
      'avgScore': '74%',
      'units': '3 Units',
      'colors': [
        const Color(0xFF06B6D4),
        const Color(0xFF10B981),
      ],
    },
  ];

  // Section rosters database
  final Map<String, List<Map<String, dynamic>>> _sectionRosters = {
    'CSE-A · Sem 5': [
      {'roll': '22CS101', 'name': 'Aarav Sharma', 'attendance': '94%', 'cgpa': '8.9', 'status': 'Present'},
      {'roll': '22CS102', 'name': 'Aditi Rao', 'attendance': '91%', 'cgpa': '9.2', 'status': 'Present'},
      {'roll': '22CS103', 'name': 'Bhavin Patel', 'attendance': '78%', 'cgpa': '7.4', 'status': 'Absent'},
      {'roll': '22CS104', 'name': 'Deepika Verma', 'attendance': '86%', 'cgpa': '8.5', 'status': 'Present'},
      {'roll': '22CS105', 'name': 'Farhan Khan', 'attendance': '82%', 'cgpa': '8.0', 'status': 'Late'},
      {'roll': '22CS106', 'name': 'Ishita Gupta', 'attendance': '96%', 'cgpa': '9.5', 'status': 'Present'},
      {'roll': '22CS107', 'name': 'Karthik Raja', 'attendance': '72%', 'cgpa': '6.9', 'status': 'Absent'},
      {'roll': '22CS108', 'name': 'Meera Nambiar', 'attendance': '98%', 'cgpa': '9.8', 'status': 'Present'},
    ],
    'CSE-B · Sem 5': [
      {'roll': '22CS151', 'name': 'Nikhil Reddy', 'attendance': '88%', 'cgpa': '8.2', 'status': 'Present'},
      {'roll': '22CS152', 'name': 'Pooja Hegde', 'attendance': '92%', 'cgpa': '8.8', 'status': 'Present'},
      {'roll': '22CS153', 'name': 'Rahul Nair', 'attendance': '75%', 'cgpa': '7.1', 'status': 'Late'},
      {'roll': '22CS154', 'name': 'Sneha Kulkarni', 'attendance': '95%', 'cgpa': '9.4', 'status': 'Present'},
      {'roll': '22CS155', 'name': 'Vikramaditya S.', 'attendance': '70%', 'cgpa': '6.8', 'status': 'Absent'},
      {'roll': '22CS156', 'name': 'Zoya Akhtar', 'attendance': '89%', 'cgpa': '8.4', 'status': 'Present'},
    ],
    'AI&DS · Sem 5': [
      {'roll': '22AD001', 'name': 'Ananya Deshmukh', 'attendance': '96%', 'cgpa': '9.4', 'status': 'Present'},
      {'roll': '22AD002', 'name': 'Chirag Jain', 'attendance': '88%', 'cgpa': '8.1', 'status': 'Present'},
      {'roll': '22AD003', 'name': 'Divya Pillai', 'attendance': '93%', 'cgpa': '8.9', 'status': 'Present'},
      {'roll': '22AD004', 'name': 'Gautam Menon', 'attendance': '68%', 'cgpa': '6.5', 'status': 'Absent'},
      {'roll': '22AD005', 'name': 'Harini Sundar', 'attendance': '99%', 'cgpa': '9.7', 'status': 'Present'},
    ],
  };

  final List<Map<String, dynamic>> _attendanceHistory = [
    {
      'date': 'Yesterday 14:00',
      'code': 'CS3492',
      'subject': 'Database Management Systems',
      'section': 'CSE-B · Sem 5',
      'venue': 'LH-206',
      'present': 58,
      'total': 62,
      'pct': '93.5%',
    },
    {
      'date': '20 Oct 2026, 09:00',
      'code': 'CS3492',
      'subject': 'Database Management Systems',
      'section': 'CSE-A · Sem 5',
      'venue': 'LH-204',
      'present': 60,
      'total': 64,
      'pct': '93.7%',
    },
    {
      'date': '19 Oct 2026, 10:00',
      'code': 'CS3492L',
      'subject': 'DBMS Laboratory & SQL Studio',
      'section': 'AI&DS · Sem 5',
      'venue': 'Computing Lab 3',
      'present': 55,
      'total': 58,
      'pct': '94.8%',
    },
  ];

  final List<Map<String, dynamic>> _timetable = [
    {'day': 'Monday', 'time': '09:00 - 10:00', 'code': 'CS3492', 'title': 'DBMS Lecture', 'sec': 'CSE-A', 'room': 'LH-204', 'type': 'Lecture'},
    {'day': 'Monday', 'time': '14:00 - 17:00', 'code': 'CS3492L', 'title': 'DBMS Laboratory', 'sec': 'AI&DS', 'room': 'Comp Lab 3', 'type': 'Practical'},
    {'day': 'Tuesday', 'time': '11:15 - 12:15', 'code': 'CS3492', 'title': 'DBMS Lecture', 'sec': 'CSE-B', 'room': 'LH-206', 'type': 'Lecture'},
    {'day': 'Wednesday', 'time': '09:00 - 10:00', 'code': 'CS3492', 'title': 'DBMS Lecture', 'sec': 'CSE-A', 'room': 'LH-204', 'type': 'Lecture'},
    {'day': 'Thursday', 'time': '14:00 - 15:00', 'code': 'CS3492', 'title': 'DBMS Tutorial', 'sec': 'CSE-B', 'room': 'LH-206', 'type': 'Tutorial'},
    {'day': 'Friday', 'time': '10:15 - 11:15', 'code': 'CS3492', 'title': 'DBMS Doubt Clearing', 'sec': 'CSE-A', 'room': 'Seminar Hall', 'type': 'Mentoring'},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredClasses {
    final query = _searchController.text.trim().toLowerCase();
    return _classes.where((c) {
      final matchesQuery = query.isEmpty ||
          c['code'].toString().toLowerCase().contains(query) ||
          c['title'].toString().toLowerCase().contains(query) ||
          c['section'].toString().toLowerCase().contains(query) ||
          c['venue'].toString().toLowerCase().contains(query);

      final matchesSemester = _selectedSemester == 'All Semesters' ||
          c['section'].toString().toLowerCase().contains(_selectedSemester.toLowerCase());

      return matchesQuery && matchesSemester;
    }).toList();
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
              const SizedBox(height: 20),
              _buildMetricCards(),
              const SizedBox(height: 20),
              _buildProfileStrip(),
              const SizedBox(height: 20),
              _buildTabPills(),
              const SizedBox(height: 16),
              if (_selectedTab == 0) ...[
                _buildSearchAndFilter(),
                const SizedBox(height: 18),
                _buildClassesGrid(),
              ] else if (_selectedTab == 1) ...[
                _buildWeeklyTimetable(),
              ] else if (_selectedTab == 2) ...[
                _buildLiveAttendanceTab(),
              ] else if (_selectedTab == 3) ...[
                _buildClassPerformanceTab(),
              ] else ...[
                _buildAttendanceHistoryTab(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 2)
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
            // Watermark graduation cap on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.school_rounded,
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
                          'My Classes',
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
                          Icons.school_rounded,
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
                              'My Classes',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Sections, timetable, attendance and class performance.',
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
  // 4 METRIC STAT CARDS (Screenshot 2)
  // ===========================================================================
  Widget _buildMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isTablet = constraints.maxWidth >= 550;

        int crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);
        double childAspectRatio =
            isDesktop ? 2.3 : (isTablet ? 2.4 : 3.0);

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: childAspectRatio,
          children: [
            _buildStatCard(
              title: 'Teaching Load',
              value: '14',
              valueUnit: 'hrs / week',
              subtext: 'Department: CSE',
              icon: Icons.access_time_rounded,
              iconColor: const Color(0xFF2563EB),
              iconBgColor: const Color(0xFFEFF6FF),
            ),
            _buildStatCard(
              title: 'Assigned Sections',
              value: '4',
              badge: 'Active',
              badgeColor: const Color(0xFF10B981),
              subtext: 'Across Computer Science & Engineering',
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xFF0F766E),
              iconBgColor: const Color(0xFFCCFBF1),
            ),
            _buildStatCard(
              title: 'Enrolled Students',
              value: '244',
              valueUnit: 'students',
              subtext: 'In your lecture batches',
              icon: Icons.groups_rounded,
              iconColor: const Color(0xFF0284C7),
              iconBgColor: const Color(0xFFF0F9FF),
            ),
            _buildStatCard(
              title: 'Avg. Attendance',
              value: '86%',
              badge: 'Healthy',
              badgeColor: const Color(0xFF10B981),
              subtext: 'Institution benchmark: 75%',
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF10B981),
              iconBgColor: const Color(0xFFDCFCE7),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? valueUnit,
    String? badge,
    Color? badgeColor,
    required String subtext,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (valueUnit != null) ...[
                const SizedBox(width: 5),
                Text(
                  valueUnit,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
              if (badge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (badgeColor ?? const Color(0xFF10B981))
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: badgeColor ?? const Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PROFILE & ACTION STRIP (Screenshot 2)
  // ===========================================================================
  Widget _buildProfileStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
          final isNarrow = constraints.maxWidth < 750;
          final profileInfo = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Color(0xFF38439E),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          'Dr. Meena Raghavan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Associate Professor',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Computer Science & Engineering · ENGINEERING Stream',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          );

          final actionButtons = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (_classes.isNotEmpty) {
                    _showTakeAttendanceDialog(_classes.first);
                  }
                },
                icon: const Icon(Icons.how_to_reg_rounded, size: 15),
                label: Text(
                  'Take Attendance',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38439E),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
              OutlinedButton.icon(
                onPressed: _showAddExtraClassDialog,
                icon: const Icon(Icons.add, size: 15),
                label: Text(
                  'Add Extra Class',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _showExportCsvDialog,
                icon: const Icon(Icons.file_download_outlined, size: 15),
                label: Text(
                  'Export CSV',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                profileInfo,
                const SizedBox(height: 14),
                actionButtons,
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: profileInfo),
                const SizedBox(width: 16),
                actionButtons,
              ],
            );
          }
        },
      ),
    );
  }

  // ===========================================================================
  // TAB PILLS (Screenshot 2)
  // ===========================================================================
  Widget _buildTabPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final isSelected = _selectedTab == i;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedTab = i),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E2548)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (i == 0)
                      Icon(
                        Icons.collections_bookmark_outlined,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      )
                    else if (i == 1)
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      )
                    else if (i == 2)
                      Icon(
                        Icons.person_pin_outlined,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      )
                    else if (i == 3)
                      Icon(
                        Icons.leaderboard_outlined,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      )
                    else
                      Icon(
                        Icons.history_rounded,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                    const SizedBox(width: 6),
                    Text(
                      _tabs[i],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // SEARCH & SEMESTER FILTER (Screenshot 2)
  // ===========================================================================
  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 18,
                  color: Color(0xFF94A3B8),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search my classes, subjects, rooms...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      filled: false,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSemester,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
              ),
              items: ['All Semesters', 'Semester 5', 'Semester 7']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedSemester = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // CLASSES GRID (Screenshot 2)
  // ===========================================================================
  Widget _buildClassesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 950;
        final isTablet = constraints.maxWidth >= 600;
        final count = isDesktop ? 3 : (isTablet ? 2 : 1);

        final classes = _filteredClasses;
        if (classes.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.school_outlined,
                    size: 28,
                    color: Color(0xFF4338CA),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'No classes found',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Try searching for a different course code, title or clear the filter.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _selectedSemester = 'All Semesters';
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 14),
                  label: Text('Reset Filters', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38439E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 330,
          ),
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return _buildClassCard(classes[index]);
          },
        );
      },
    );
  }

  Widget _buildClassCard(Map<String, dynamic> c) {
    final colors = c['colors'] as List<Color>;

    return Container(
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      c['code'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4338CA),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      c['section'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  c['hours'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            c['title'] as String,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Venue & Next
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    c['venue'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    c['next'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Stats Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    Text('Students',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF64748B))),
                    const SizedBox(height: 2),
                    Text(c['students'] as String,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A))),
                  ],
                ),
                Container(
                    width: 1, height: 26, color: const Color(0xFFCBD5E1)),
                Column(
                  children: [
                    Text('Attendance',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF64748B))),
                    const SizedBox(height: 2),
                    Text(c['attendance'] as String,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF10B981))),
                  ],
                ),
                Container(
                    width: 1, height: 26, color: const Color(0xFFCBD5E1)),
                Column(
                  children: [
                    Text('Avg Score',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF64748B))),
                    const SizedBox(height: 2),
                    Text(c['avgScore'] as String,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0284C7))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Syllabus Mastery bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Syllabus Mastery',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                c['units'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: colors.map((col) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: col,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }).toList(),
          ),
          const Spacer(),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showTakeAttendanceDialog(c),
                  icon: const Icon(Icons.how_to_reg_rounded, size: 14),
                  label: Text(
                    'Take Attendance',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38439E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showViewRosterDialog(c),
                  icon: const Icon(Icons.people_outline_rounded, size: 14),
                  label: Text(
                    'View Roster',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF334155),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // INTERACTIVE ACTION DIALOGS
  // ===========================================================================

  void _showTakeAttendanceDialog(Map<String, dynamic> c) {
    final sectionKey = c['section'] as String;
    final rosterSource = _sectionRosters[sectionKey] ?? [
      {'roll': '22CS201', 'name': 'Aditya Verma', 'attendance': '90%', 'cgpa': '8.5', 'status': 'Present'},
      {'roll': '22CS202', 'name': 'Divya Sundaram', 'attendance': '95%', 'cgpa': '9.1', 'status': 'Present'},
      {'roll': '22CS203', 'name': 'Kavya Raman', 'attendance': '78%', 'cgpa': '7.2', 'status': 'Absent'},
      {'roll': '22CS204', 'name': 'Manish Paul', 'attendance': '84%', 'cgpa': '8.0', 'status': 'Present'},
      {'roll': '22CS205', 'name': 'Rohan Das', 'attendance': '88%', 'cgpa': '8.3', 'status': 'Late'},
    ];

    // Work on mutable copy
    List<Map<String, dynamic>> students = rosterSource
        .map((s) => Map<String, dynamic>.from(s))
        .toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final presentCount = students.where((s) => s['status'] == 'Present').length;
            final absentCount = students.where((s) => s['status'] == 'Absent').length;
            final lateCount = students.where((s) => s['status'] == 'Late').length;

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680, maxHeight: 720),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.how_to_reg_rounded, color: Color(0xFF38439E), size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Text(
                                      'Take Attendance Register',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        c['code'] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF4338CA),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${c['title']} · Section ${c['section']} · Room ${c['venue']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
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
                      const SizedBox(height: 16),

                      // Stat counts & quick actions
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Present: $presentCount',
                                    style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF15803D)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE2E2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Absent: $absentCount',
                                    style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFFB91C1C)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Late: $lateCount',
                                    style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFFB45309)),
                                  ),
                                ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setModalState(() {
                                  for (var s in students) {
                                    s['status'] = 'Present';
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.done_all_rounded, size: 15, color: Color(0xFF38439E)),
                              label: Text('All Present', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF38439E))),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Student list
                      Expanded(
                        child: ListView.separated(
                          itemCount: students.length,
                          separatorBuilder: (_, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          itemBuilder: (context, i) {
                            final student = students[i];
                            final status = student['status'] as String;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundColor: const Color(0xFFEEF2FF),
                                    child: Text(
                                      student['name'].toString().substring(0, 1),
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          student['name'] as String,
                                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                                        ),
                                        Text(
                                          '${student['roll']} · Historic: ${student['attendance']}',
                                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 3 Toggle buttons (P / A / L)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildStatusChoiceChip(
                                        label: 'P',
                                        isSelected: status == 'Present',
                                        activeColor: const Color(0xFF10B981),
                                        onTap: () => setModalState(() => student['status'] = 'Present'),
                                      ),
                                      const SizedBox(width: 6),
                                      _buildStatusChoiceChip(
                                        label: 'A',
                                        isSelected: status == 'Absent',
                                        activeColor: const Color(0xFFEF4444),
                                        onTap: () => setModalState(() => student['status'] = 'Absent'),
                                      ),
                                      const SizedBox(width: 6),
                                      _buildStatusChoiceChip(
                                        label: 'L',
                                        isSelected: status == 'Late',
                                        activeColor: const Color(0xFFF59E0B),
                                        onTap: () => setModalState(() => student['status'] = 'Late'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Footer Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF475569),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              final total = students.length;
                              final pct = ((presentCount / total) * 100).round();

                              setState(() {
                                // Update cached roster
                                _sectionRosters[sectionKey] = students;
                                // Update class attendance display
                                c['attendance'] = '$pct%';

                                // Insert history log
                                _attendanceHistory.insert(0, {
                                  'date': 'Today ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                                  'code': c['code'],
                                  'subject': c['title'],
                                  'section': c['section'],
                                  'venue': c['venue'],
                                  'present': presentCount,
                                  'total': total,
                                  'pct': '$pct%',
                                });
                              });

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Attendance recorded for ${c['section']}: $presentCount Present, $absentCount Absent, $lateCount Late ($pct%)',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF10B981),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
                            label: Text('Save & Submit Register', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38439E),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
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

  Widget _buildStatusChoiceChip({
    required String label,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? activeColor : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  void _showViewRosterDialog(Map<String, dynamic> c) {
    final sectionKey = c['section'] as String;
    final roster = _sectionRosters[sectionKey] ?? [
      {'roll': '22CS101', 'name': 'Aarav Sharma', 'attendance': '94%', 'cgpa': '8.9', 'status': 'Present'},
      {'roll': '22CS102', 'name': 'Aditi Rao', 'attendance': '91%', 'cgpa': '9.2', 'status': 'Present'},
      {'roll': '22CS103', 'name': 'Bhavin Patel', 'attendance': '78%', 'cgpa': '7.4', 'status': 'Absent'},
      {'roll': '22CS104', 'name': 'Deepika Verma', 'attendance': '86%', 'cgpa': '8.5', 'status': 'Present'},
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720, maxHeight: 680),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.people_outline_rounded, color: Color(0xFF15803D), size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enrolled Student Roster',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${c['title']} (${c['code']}) · Section ${c['section']} · ${c['students']} Students',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
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
                  const SizedBox(height: 16),

                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text('ROLL NO', style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B))),
                        ),
                        Expanded(
                          child: Text('STUDENT NAME', style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B))),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text('ATTENDANCE', style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B))),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text('CGPA', style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Table Body
                  Expanded(
                    child: ListView.separated(
                      itemCount: roster.length,
                      separatorBuilder: (_, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      itemBuilder: (context, i) {
                        final student = roster[i];
                        final attVal = int.tryParse(student['attendance'].toString().replaceAll('%', '')) ?? 80;
                        final attColor = attVal >= 85 ? const Color(0xFF10B981) : (attVal >= 75 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  student['roll'] as String,
                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF38439E)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  student['name'] as String,
                                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(color: attColor, shape: BoxShape.circle),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      student['attendance'] as String,
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: attColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  student['cgpa'] as String,
                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Exported roster CSV for ${c['section']}', style: GoogleFonts.poppins()),
                              backgroundColor: const Color(0xFF38439E),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded, size: 15),
                        label: Text('Export Roster CSV', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF38439E),
                          side: const BorderSide(color: Color(0xFF38439E)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38439E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Close', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
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

  void _showAddExtraClassDialog() {
    final titleController = TextEditingController(text: 'Database Management Systems');
    final roomController = TextEditingController(text: 'LH-205');
    final topicController = TextEditingController(text: 'Query Optimization & B+ Tree Indexing');
    String selectedSection = 'CSE-A · Sem 5';
    String selectedTime = 'Today 15:30 - 16:30';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
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
                            child: const Icon(Icons.add_task_rounded, color: Color(0xFF38439E), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Schedule Extra Class',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Notify enrolled students and reserve classroom',
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

                      Text('Course & Subject', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: titleController,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Section', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  initialValue: selectedSection,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                                  items: ['CSE-A · Sem 5', 'CSE-B · Sem 5', 'AI&DS · Sem 5']
                                      .map((s) => DropdownMenuItem(value: s, child: Text(s, overflow: TextOverflow.ellipsis)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) setModalState(() => selectedSection = val);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Room / Venue', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: roomController,
                                  style: GoogleFonts.poppins(fontSize: 12),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text('Time Slot', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        initialValue: selectedTime,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        items: [
                          'Today 15:30 - 16:30',
                          'Tomorrow 09:00 - 10:00',
                          'Tomorrow 14:00 - 15:00',
                          'Saturday 10:00 - 12:00',
                        ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        onChanged: (val) {
                          if (val != null) setModalState(() => selectedTime = val);
                        },
                      ),
                      const SizedBox(height: 12),

                      Text('Class Topic / Purpose', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: topicController,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: InputDecoration(
                          hintText: 'e.g. Remedial lecture for Unit 3',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _timetable.insert(0, {
                                  'day': 'Special Session',
                                  'time': selectedTime,
                                  'code': 'CS3492',
                                  'title': topicController.text.trim(),
                                  'sec': selectedSection,
                                  'room': roomController.text.trim(),
                                  'type': 'Extra Class',
                                });
                              });
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Extra class scheduled for $selectedSection in ${roomController.text} ($selectedTime)! Notification sent to students.',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF10B981),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.check, size: 16),
                            label: Text('Schedule Class', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38439E),
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
      },
    );
  }

  void _showExportCsvDialog() {
    String format = 'CSV Spreadsheet (.csv)';
    String scope = 'All Enrolled Batches (244 Students)';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
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
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.file_download_outlined, color: Color(0xFF15803D), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Export Class Register',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Download official attendance and score sheets',
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

                      Text('Scope & Data Filter', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        initialValue: scope,
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        items: [
                          'All Enrolled Batches (244 Students)',
                          'CSE-A · Sem 5 (64 Students)',
                          'CSE-B · Sem 5 (62 Students)',
                          'AI&DS · Sem 5 (58 Students)',
                        ].map((s) => DropdownMenuItem(value: s, child: Text(s, overflow: TextOverflow.ellipsis))).toList(),
                        onChanged: (val) {
                          if (val != null) setModalState(() => scope = val);
                        },
                      ),
                      const SizedBox(height: 14),

                      Text('Export Format', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        initialValue: format,
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        items: [
                          'CSV Spreadsheet (.csv)',
                          'Microsoft Excel (.xlsx)',
                          'PDF Printable Report (.pdf)',
                        ].map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                        onChanged: (val) {
                          if (val != null) setModalState(() => format = val);
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Downloaded "$scope" as $format', style: GoogleFonts.poppins()),
                                  backgroundColor: const Color(0xFF10B981),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.download_rounded, size: 16),
                            label: Text('Download Now', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38439E),
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
      },
    );
  }

  // ===========================================================================
  // ADDITIONAL TAB VIEWS
  // ===========================================================================

  Widget _buildWeeklyTimetable() {
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
                'Weekly Teaching Schedule',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              OutlinedButton.icon(
                onPressed: _showAddExtraClassDialog,
                icon: const Icon(Icons.add, size: 14),
                label: Text('Schedule Session', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _timetable.length,
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final slot = _timetable[i];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        slot['day'] as String,
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${slot['code']} · ${slot['title']}',
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  slot['sec'] as String,
                                  style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Time: ${slot['time']} · Room: ${slot['room']} (${slot['type']})',
                            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Starting ${slot['code']} session in ${slot['room']}', style: GoogleFonts.poppins()),
                            backgroundColor: const Color(0xFF38439E),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38439E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 0,
                      ),
                      child: Text('Start Class', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600)),
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

  Widget _buildLiveAttendanceTab() {
    final activeClass = _classes.first;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('ACTIVE LECTURE SESSION', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            activeClass['title'] as String,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
          ),
          Text(
            '${activeClass['section']} · Venue: ${activeClass['venue']}',
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                const Icon(Icons.qr_code_2_rounded, size: 120, color: Color(0xFF38439E)),
                const SizedBox(height: 8),
                Text(
                  'Dynamic Student Check-in QR Code',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                ),
                Text(
                  'Project on smart board. Refreshes every 15 seconds.',
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () => _showTakeAttendanceDialog(activeClass),
            icon: const Icon(Icons.edit_note_rounded, size: 18),
            label: Text('Open Manual Register Kiosk', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF38439E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassPerformanceTab() {
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
          Text(
            'Class Performance & Syllabus Mastery',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Text(
            'Unit-wise attainment rates across assigned sections',
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 18),
          ..._classes.map((cls) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
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
                        '${cls['code']} · ${cls['section']}',
                        style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Avg Score: ${cls['avgScore']}',
                          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.72,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF38439E)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Unit 1 to 4 Complete', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                      Text('72% Covered', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAttendanceHistoryTab() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Attendance Records',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              OutlinedButton.icon(
                onPressed: _showExportCsvDialog,
                icon: const Icon(Icons.download_rounded, size: 14),
                label: Text('Export All', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _attendanceHistory.length,
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final item = _attendanceHistory[i];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check_circle_rounded, color: Color(0xFF15803D), size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['code']} · ${item['section']}',
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          ),
                          Text(
                            '${item['date']} · Room ${item['venue']}',
                            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item['present']} / ${item['total']} (${item['pct']})',
                        style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
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
}

// Background painter for blueprint grid
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
