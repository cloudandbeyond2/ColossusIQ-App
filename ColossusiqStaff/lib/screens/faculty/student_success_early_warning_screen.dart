import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DEPARTMENT: STUDENT SUCCESS & EARLY WARNING SCREEN
// Exactly matches Screenshots 2, 3, 4, 5:
// - Blueprint grid hero banner with watermark & badges (DEPARTMENT, Phase 3)
// - 2 Informational & Ethical Advisory Callout Banners
// - Filter & Search Control Toolbar with Refresh, Audit CSV, + Log Support Plan
// - 5 Stat Metric KPI Cards (Flagged for Attention, Critical Risk, Active Plans, Resolved, Readiness)
// - Tab Navigation:
//   * Tab 0: At-Risk Students Roster (14) - Full table with quiz avg, certs, interview, signals, status
//   * Tab 1: Cohort Risk Analytics & Trends - 4 Chart Cards with Y-axis gridlines & guidance
//   * Tab 2: Support Plans & Case Log (0) - Support Action Plans header + empty state
// =============================================================================

class StudentSuccessEarlyWarningScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const StudentSuccessEarlyWarningScreen({super.key, this.onBack});

  @override
  State<StudentSuccessEarlyWarningScreen> createState() =>
      _StudentSuccessEarlyWarningScreenState();
}

class _StudentSuccessEarlyWarningScreenState
    extends State<StudentSuccessEarlyWarningScreen> {
  int _selectedTab = 0;
  String _selectedDept = 'All Departments';
  String _selectedLevel = 'All Levels';
  String _selectedStatus = 'All Statuses';
  String _searchQuery = '';
  final List<Map<String, dynamic>> _loggedSupportPlans = [];

  final List<String> _departments = [
    'All Departments',
    'Computer Science & Engineering',
    'Information Technology',
    'Artificial Intelligence & Data Science',
    'Electronics & Communication',
    'Electrical & Electronics',
    'Mechanical Engineering',
    'Civil Engineering',
    'Science & Humanities',
  ];

  final List<String> _levels = [
    'All Levels',
    'Critical Risk',
    'Moderate',
    'Watchlist',
    'Low Risk',
  ];

  final List<String> _statuses = [
    'All Statuses',
    'Pending review',
    'Resolved',
  ];

  // Exact 14 student dataset matching Screenshot 3 & 4
  final List<Map<String, dynamic>> _rosterStudents = [
    {
      'name': 'Kavya Menon',
      'roll': '110121008',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Computer Science & Engineering',
      'quiz': '48%',
      'quizVal': 0.48,
      'certs': '1',
      'interview': '75',
      'resume': '89',
      'overall': '55',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': ['Low Quiz Average (48%)'],
      'status': 'Pending review',
    },
    {
      'name': 'Sanjay Pillai',
      'roll': '110121007',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Information Technology',
      'quiz': '80%',
      'quizVal': 0.80,
      'certs': '3',
      'interview': '85',
      'resume': '93',
      'overall': '81',
      'overallColor': const Color(0xFF0F766E),
      'overallBg': const Color(0xFFCCFBF1),
      'tier': 'Low Risk',
      'tierColor': const Color(0xFF0F766E),
      'tierBg': const Color(0xFFCCFBF1),
      'signals': <String>[],
      'status': 'Resolved',
    },
    {
      'name': 'Nandini Krishnan',
      'roll': '110121014',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Artificial Intelligence & Data Science',
      'quiz': '60%',
      'quizVal': 0.60,
      'certs': '4',
      'interview': '76',
      'resume': '86',
      'overall': '75',
      'overallColor': const Color(0xFF0F766E),
      'overallBg': const Color(0xFFCCFBF1),
      'tier': 'Low Risk',
      'tierColor': const Color(0xFF0F766E),
      'tierBg': const Color(0xFFCCFBF1),
      'signals': <String>[],
      'status': 'Resolved',
    },
    {
      'name': 'Joseph Patel',
      'roll': '110121021',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Electronics & Communication',
      'quiz': '47%',
      'quizVal': 0.47,
      'certs': '4',
      'interview': '37',
      'resume': '54',
      'overall': '61',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': ['Low Quiz Average (47%)', 'Low Interview Score (37/100)'],
      'status': 'Pending review',
    },
    {
      'name': 'Deepika Das',
      'roll': '110121028',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Electrical & Electronics',
      'quiz': '68%',
      'quizVal': 0.68,
      'certs': '4',
      'interview': '69',
      'resume': '75',
      'overall': '77',
      'overallColor': const Color(0xFF0F766E),
      'overallBg': const Color(0xFFCCFBF1),
      'tier': 'Low Risk',
      'tierColor': const Color(0xFF0F766E),
      'tierBg': const Color(0xFFCCFBF1),
      'signals': <String>[],
      'status': 'Resolved',
    },
    {
      'name': 'Gokul Rao',
      'roll': '110121035',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Mechanical Engineering',
      'quiz': '65%',
      'quizVal': 0.65,
      'certs': '1',
      'interview': '52',
      'resume': '95',
      'overall': '64',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': <String>[],
      'status': 'Pending review',
    },
    {
      'name': 'Keerthana Joseph',
      'roll': '110121042',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Civil Engineering',
      'quiz': '66%',
      'quizVal': 0.66,
      'certs': '1',
      'interview': '49',
      'resume': '52',
      'overall': '53',
      'overallColor': const Color(0xFFB45309),
      'overallBg': const Color(0xFFFEF3C7),
      'tier': 'Moderate',
      'tierColor': const Color(0xFFD97706),
      'tierBg': const Color(0xFFFEF3C7),
      'signals': [
        'Low Interview Score (49/100)',
        'Placement Readiness Alert (53/100)'
      ],
      'status': 'Pending review',
    },
    {
      'name': 'Karthik Khan',
      'roll': '110121049',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Science & Humanities',
      'quiz': '77%',
      'quizVal': 0.77,
      'certs': '0',
      'interview': '47',
      'resume': '76',
      'overall': '52',
      'overallColor': const Color(0xFFB45309),
      'overallBg': const Color(0xFFFEF3C7),
      'tier': 'Moderate',
      'tierColor': const Color(0xFFD97706),
      'tierBg': const Color(0xFFFEF3C7),
      'signals': [
        'No Verified Certifications',
        'Low Interview Score (47/100)'
      ],
      'status': 'Pending review',
    },
    {
      'name': 'Pooja Hegde',
      'roll': '110121056',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Computer Science & Engineering',
      'quiz': '72%',
      'quizVal': 0.72,
      'certs': '3',
      'interview': '75',
      'resume': '80',
      'overall': '76',
      'overallColor': const Color(0xFF0F766E),
      'overallBg': const Color(0xFFCCFBF1),
      'tier': 'Low Risk',
      'tierColor': const Color(0xFF0F766E),
      'tierBg': const Color(0xFFCCFBF1),
      'signals': <String>[],
      'status': 'Resolved',
    },
    {
      'name': 'Manoj Kumar',
      'roll': '110121063',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Electronics & Communication',
      'quiz': '54%',
      'quizVal': 0.54,
      'certs': '2',
      'interview': '58',
      'resume': '62',
      'overall': '58',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': ['Borderline Quiz (<55)'],
      'status': 'Pending review',
    },
    {
      'name': 'Deepak Joshi',
      'roll': '110121070',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Information Technology',
      'quiz': '58%',
      'quizVal': 0.58,
      'certs': '1',
      'interview': '60',
      'resume': '62',
      'overall': '60',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': <String>[],
      'status': 'Pending review',
    },
    {
      'name': 'Anupama V',
      'roll': '110121077',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Mechanical Engineering',
      'quiz': '55%',
      'quizVal': 0.55,
      'certs': '1',
      'interview': '56',
      'resume': '65',
      'overall': '59',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': <String>[],
      'status': 'Pending review',
    },
    {
      'name': 'Arun Varman',
      'roll': '110121084',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Civil Engineering',
      'quiz': '46%',
      'quizVal': 0.46,
      'certs': '0',
      'interview': '44',
      'resume': '50',
      'overall': '48',
      'overallColor': const Color(0xFFB45309),
      'overallBg': const Color(0xFFFEF3C7),
      'tier': 'Moderate',
      'tierColor': const Color(0xFFD97706),
      'tierBg': const Color(0xFFFEF3C7),
      'signals': [
        'No Verified Certifications',
        'Low Quiz Average (46%)'
      ],
      'status': 'Pending review',
    },
    {
      'name': 'Meera Nair',
      'roll': '110121091',
      'batch': '2023-2027 (Final Year)',
      'dept': 'Computer Science & Engineering',
      'quiz': '59%',
      'quizVal': 0.59,
      'certs': '2',
      'interview': '62',
      'resume': '66',
      'overall': '62',
      'overallColor': const Color(0xFF1E40AF),
      'overallBg': const Color(0xFFEFF6FF),
      'tier': 'Watchlist',
      'tierColor': const Color(0xFF2563EB),
      'tierBg': const Color(0xFFEFF6FF),
      'signals': <String>[],
      'status': 'Pending review',
    },
  ];

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
              const SizedBox(height: 14),
              _buildInformationalCallout(),
              const SizedBox(height: 12),
              _buildEthicalAdvisoryBanner(),
              const SizedBox(height: 16),
              _buildFilterAndControlToolbar(),
              const SizedBox(height: 16),
              _buildStatMetricCards(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 18),
              if (_selectedTab == 0)
                _buildRosterTab()
              else if (_selectedTab == 1)
                _buildAnalyticsTab()
              else
                _buildSupportPlansTab(),
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
            // Background Watermark Warning Icon
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.12,
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 210,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null) ...[
                          InkWell(
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Department',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Student Success & Early Warning',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Alert Icon Box
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFFBBF24),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    'DEPARTMENT',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Phase 3',
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
                              'Student Success & Early Warning',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Support recommendations for faculty and counsellors to review — never automatic labels.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
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
  // CALLOUT BANNER 1: INFORMATIONAL PRINCIPLE (Screenshot 2)
  // ===========================================================================
  Widget _buildInformationalCallout() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 16, color: Color(0xFFB45309)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Signals are suggestions for human review. Students are never automatically labelled, and decisions rest with faculty and counsellors.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF92400E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CALLOUT BANNER 2: ETHICAL ADVISORY & DECISION PRINCIPLE (Screenshot 2)
  // ===========================================================================
  Widget _buildEthicalAdvisoryBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEDD5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_user_outlined,
                size: 16, color: Color(0xFFC2410C)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ethical Advisory & Decision Principle:',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF9A3412),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Signals shown here are algorithmic suggestions for proactive human review based on continuous assessments and learning outcomes. Students are never automatically penalised or labelled. All advisory actions, tutoring, and support plans rest solely with faculty advisors and counsellors.',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF7C2D12),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FILTER & ACTION TOOLBAR (Screenshot 2)
  // ===========================================================================
  Widget _buildFilterAndControlToolbar() {
    return Container(
      padding: const EdgeInsets.all(14),
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
          final isNarrow = constraints.maxWidth < 980;

          final dropdowns = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildDropdown(
                value: _selectedDept,
                items: _departments,
                onChanged: (v) => setState(() => _selectedDept = v!),
              ),
              _buildDropdown(
                value: _selectedLevel,
                items: _levels,
                onChanged: (v) => setState(() => _selectedLevel = v!),
              ),
              _buildDropdown(
                value: _selectedStatus,
                items: _statuses,
                onChanged: (v) => setState(() => _selectedStatus = v!),
              ),
              Container(
                width: 220,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: GoogleFonts.poppins(fontSize: 11.5),
                  decoration: InputDecoration(
                    hintText: 'Search student or roll no...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF94A3B8),
                    ),
                    prefixIcon: const Icon(Icons.search,
                        size: 16, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    filled: false,
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Refreshed early warning indicators.',
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.refresh_rounded,
                    size: 15, color: Color(0xFF334155)),
                label: Text(
                  'Refresh',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Exported audit report as CSV.',
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined,
                    size: 14, color: Color(0xFF334155)),
                label: Text(
                  'Audit CSV',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showScheduleSupportActionDialog,
                icon: const Icon(Icons.add, size: 14),
                label: Text(
                  'Log Support Plan',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dropdowns,
                const SizedBox(height: 12),
                actions,
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: dropdowns),
                const SizedBox(width: 14),
                actions,
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
          ),
          items: items
              .map((i) => DropdownMenuItem(
                    value: i,
                    child: Text(i, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 5 STAT METRIC KPI CARDS (Screenshot 2)
  // ===========================================================================
  Widget _buildStatMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1050
            ? 5
            : (constraints.maxWidth >= 650
                ? 3
                : (constraints.maxWidth >= 420 ? 2 : 1));
        final ratio = constraints.maxWidth >= 1050
            ? 2.1
            : (constraints.maxWidth >= 650
                ? 1.85
                : (constraints.maxWidth >= 420 ? 1.45 : 2.4));

        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: ratio,
          children: [
            _buildKpiCard(
              title: 'Flagged for Attention',
              badge: '0 critical',
              badgeColor: const Color(0xFFD97706),
              badgeBg: const Color(0xFFFEF3C7),
              value: '10',
              subtitle: 'Students with academic, certification...',
            ),
            _buildKpiCard(
              title: 'Critical Risk Flags',
              badge: 'Urgent review',
              badgeColor: const Color(0xFF0F766E),
              badgeBg: const Color(0xFFCCFBF1),
              value: '0',
              subtitle: 'Requires faculty counsellor or tutor in...',
            ),
            _buildKpiCard(
              title: 'Active Support Plans',
              badge: '0 total logged',
              badgeColor: const Color(0xFF2563EB),
              badgeBg: const Color(0xFFEFF6FF),
              value: '0',
              subtitle: 'Interventions currently assigned and ...',
            ),
            _buildKpiCard(
              title: 'Resolved / On Track',
              badge: '29% cohort',
              badgeColor: const Color(0xFF10B981),
              badgeBg: const Color(0xFFDCFCE7),
              value: '4',
              subtitle: 'Students cleared of risk flags or met r...',
            ),
            _buildKpiCard(
              title: 'Cohort Avg Readiness',
              badge: 'Satisfactory',
              badgeColor: const Color(0xFF0F766E),
              badgeBg: const Color(0xFFCCFBF1),
              value: '65 / 100',
              subtitle: 'Combined index across quiz, certs, in...',
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeBg,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
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
  // TAB BAR (Screenshot 2, 3, 4, 5)
  // ===========================================================================
  Widget _buildTabBar() {
    final tabItems = [
      {
        'title': 'At-Risk Students Roster',
        'icon': Icons.people_outline_rounded,
        'badge': '14',
      },
      {
        'title': 'Cohort Risk Analytics & Trends',
        'icon': Icons.insights_rounded,
        'badge': null,
      },
      {
        'title': 'Support Plans & Case Log',
        'icon': Icons.assignment_outlined,
        'badge': '${_loggedSupportPlans.length}',
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabItems.length, (i) {
            final isSelected = _selectedTab == i;
            final item = tabItems[i];
            return Padding(
              padding: const EdgeInsets.only(right: 28),
              child: InkWell(
                onTap: () => setState(() => _selectedTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF1E2865)
                              : const Color(0xFF64748B),
                        ),
                      ),
                      if (item['badge'] != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            item['badge'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: AT-RISK STUDENTS ROSTER (Screenshot 3)
  // ===========================================================================
  Widget _buildRosterTab() {
    final filtered = _rosterStudents.where((s) {
      final name = (s['name'] as String).toLowerCase();
      final roll = (s['roll'] as String).toLowerCase();
      final q = _searchQuery.toLowerCase();
      if (q.isNotEmpty && !name.contains(q) && !roll.contains(q)) return false;

      if (_selectedDept != 'All Departments' &&
          s['dept'] != _selectedDept) {
        return false;
      }
      if (_selectedLevel != 'All Levels' &&
          s['tier'] != _selectedLevel.replaceAll(' Risk', '')) {
        return false;
      }
      if (_selectedStatus != 'All Statuses' && s['status'] != _selectedStatus) {
        return false;
      }
      return true;
    }).toList();

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 650;
                final textCol = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flagged Students Requiring Advisory Attention',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Real-time algorithmic risk indicators across continuous assessments, verified credentials, and interview benchmarks.',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );
                final countText = Text(
                  'Showing ${filtered.length} student(s)',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textCol,
                      const SizedBox(height: 8),
                      countText,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: textCol),
                    const SizedBox(width: 16),
                    countText,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table matching Screenshot 3 exactly
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFAF9F6)),
              dataRowMinHeight: 62,
              dataRowMaxHeight: 74,
              horizontalMargin: 20,
              columnSpacing: 22,
              columns: [
                DataColumn(
                  label: Text(
                    'STUDENT & ROLL NO',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'DEPARTMENT',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'QUIZ AVG',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CERTS',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'INTERVIEW',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'RESUME',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'OVERALL',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'RISK TIER',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'SIGNALS OBSERVED',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'REVIEW STATUS',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ACTIONS',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
              rows: filtered.map((s) {
                final sigs = (s['signals'] as List<dynamic>).cast<String>();
                final isPending = s['status'] == 'Pending review';

                return DataRow(
                  cells: [
                    // Student & Roll No
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            s['name'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${s['roll']}   ${s['batch']}",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Department
                    DataCell(
                      Text(
                        s['dept'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // Quiz Avg
                    DataCell(
                      Text(
                        s['quiz'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: (s['quizVal'] as double) < 0.50
                              ? const Color(0xFFDC2626)
                              : const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // Certs
                    DataCell(
                      Text(
                        s['certs'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // Interview
                    DataCell(
                      Text(
                        s['interview'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // Resume
                    DataCell(
                      Text(
                        s['resume'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // Overall Pill
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['overallBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          s['overall'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: s['overallColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    // Risk Tier
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['tierBg'] as Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          s['tier'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: s['tierColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    // Signals Observed (Chips)
                    DataCell(
                      sigs.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: sigs.map((sig) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF7ED),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: const Color(0xFFFED7AA)),
                                  ),
                                  child: Text(
                                    sig,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF9A3412),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    // Review Status Dropdown
                    DataCell(
                      PopupMenuButton<String>(
                        onSelected: (val) {
                          setState(() {
                            s['status'] = val;
                          });
                        },
                        itemBuilder: (ctx) => const [
                          PopupMenuItem(
                            value: 'Pending review',
                            child: Text('Pending review'),
                          ),
                          PopupMenuItem(
                            value: 'Resolved',
                            child: Text('Resolved'),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isPending
                                ? const Color(0xFFFEF2F2)
                                : const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isPending
                                  ? const Color(0xFFFECACA)
                                  : const Color(0xFFBBF7D0),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                s['status'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isPending
                                      ? const Color(0xFFDC2626)
                                      : const Color(0xFF16A34A),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 14,
                                color: isPending
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFF16A34A),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Actions: Details & + Plan
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => _showStudentDetailsModal(s),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Details',
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Material(
                            color: const Color(0xFF1E2865),
                            borderRadius: BorderRadius.circular(6),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () => _showCreateSupportPlanDialog(
                                  s['name'] as String),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  '+ Plan',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 1: COHORT RISK ANALYTICS & TRENDS (Screenshot 4)
  // ===========================================================================
  Widget _buildAnalyticsTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        final chart1 = _buildTierDistributionCard();
        final chart2 = _buildDeficitSignalsCard();
        final chart3 = _buildDeptCasesCard();
        final chart4 = _buildInstitutionalGuidanceCard();

        if (isDesktop) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chart1),
                  const SizedBox(width: 18),
                  Expanded(child: chart2),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chart3),
                  const SizedBox(width: 18),
                  Expanded(child: chart4),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              chart1,
              const SizedBox(height: 16),
              chart2,
              const SizedBox(height: 16),
              chart3,
              const SizedBox(height: 16),
              chart4,
            ],
          );
        }
      },
    );
  }

  // Generic Reusable Bar Chart with Y-Axis and Gridlines matching Screenshot 4
  Widget _buildYAxisChart({
    required String title,
    required List<double> yLabels,
    required double maxY,
    required List<Map<String, dynamic>> items,
    Widget? footer,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 310),
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
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 175,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-Axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: yLabels.map((y) {
                    final label = y == y.roundToDouble()
                        ? y.toInt().toString()
                        : y.toString();
                    return SizedBox(
                      height: 14,
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                // Gridlines & Bars
                Expanded(
                  child: Stack(
                    children: [
                      // Gridlines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(yLabels.length, (_) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          );
                        }),
                      ),
                      // Bars
                      Positioned.fill(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: items.map((item) {
                            final val = (item['val'] as num).toDouble();
                            final fraction = maxY > 0
                                ? (val / maxY).clamp(0.0, 1.0)
                                : 0.0;
                            final barColor = item['color'] as Color? ??
                                const Color(0xFF1E2865);
                            final barWidth =
                                (item['width'] as num?)?.toDouble() ?? 32.0;

                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (val > 0)
                                    Container(
                                      width: barWidth,
                                      height: 135 * fraction,
                                      decoration: BoxDecoration(
                                        color: barColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(3),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 2),
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
            ),
          ),
          const SizedBox(height: 8),
          // X-Axis labels
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) {
                return Expanded(
                  child: Text(
                    item['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (footer != null) ...[
            const SizedBox(height: 10),
            footer,
          ],
        ],
      ),
    );
  }

  // Chart 1: Student Risk & Watchlist Tier Distribution (Screenshot 4)
  Widget _buildTierDistributionCard() {
    return _buildYAxisChart(
      title: 'Student Risk & Watchlist Tier Distribution',
      yLabels: [8.0, 6.0, 4.0, 2.0, 0.0],
      maxY: 8.0,
      items: [
        {
          'label': 'Critical',
          'val': 0.0,
          'color': const Color(0xFF1E2865),
          'width': 34
        },
        {
          'label': 'Moderate',
          'val': 3.0,
          'color': const Color(0xFF1E2865),
          'width': 34
        },
        {
          'label': 'Watchlist',
          'val': 7.0,
          'color': const Color(0xFF1E2865),
          'width': 34
        },
        {
          'label': 'Low Risk',
          'val': 4.0,
          'color': const Color(0xFF1E2865),
          'width': 34
        },
      ],
    );
  }

  // Chart 2: Observed Deficit Signals Across Cohort (Screenshot 4)
  Widget _buildDeficitSignalsCard() {
    return _buildYAxisChart(
      title: 'Observed Deficit Signals Across Cohort',
      yLabels: [8.0, 6.0, 4.0, 2.0, 0.0],
      maxY: 8.0,
      items: [
        {
          'label': 'Low Quiz Avg (<50%)',
          'val': 4.0,
          'color': const Color(0xFF1E2865),
          'width': 28
        },
        {
          'label': '',
          'val': 2.0,
          'color': const Color(0xFF1E2865),
          'width': 28
        },
        {
          'label': 'Interview Gap (<50)',
          'val': 5.0,
          'color': const Color(0xFF1E2865),
          'width': 28
        },
        {
          'label': 'Readiness Alert (<55)',
          'val': 3.0,
          'color': const Color(0xFF1E2865),
          'width': 28
        },
      ],
    );
  }

  // Chart 3: Flagged Cases by Department (Screenshot 4)
  Widget _buildDeptCasesCard() {
    return _buildYAxisChart(
      title: 'Flagged Cases by Department',
      yLabels: [1.0, 0.75, 0.5, 0.25, 0.0],
      maxY: 1.0,
      items: [
        {
          'label': 'Information Te...',
          'val': 0.0,
          'color': const Color(0xFFD97706),
          'width': 22
        },
        {
          'label': 'Electronics & ..',
          'val': 1.0,
          'color': const Color(0xFFD97706),
          'width': 22
        },
        {
          'label': 'Mechanical Eng...',
          'val': 0.0,
          'color': const Color(0xFFD97706),
          'width': 22
        },
        {
          'label': 'Science & Huma...',
          'val': 1.0,
          'color': const Color(0xFFD97706),
          'width': 22
        },
      ],
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF1E2865),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text('critical',
              style: GoogleFonts.poppins(
                  fontSize: 10.5, color: const Color(0xFF64748B))),
          const SizedBox(width: 14),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFD97706),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text('moderate',
              style: GoogleFonts.poppins(
                  fontSize: 10.5, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  // Chart 4: Institutional Observations & Guidance (Screenshot 4)
  Widget _buildInstitutionalGuidanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 310),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Institutional Observations & Guidance',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          // Guidance Box 1 (Amber Theme)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFED7AA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded,
                        size: 15, color: Color(0xFFC2410C)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '2 Flagged Students Have Zero Practical Certifications',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF9A3412),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Verified course certifications are a strong predictor of campus placement. Fast-track these students into departmental skill booster tracks.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF7C2D12),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Data evidence: 2 out of 14 assessed students lack verified credentials.',
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF9A3412),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Guidance Box 2 (Clean Grey/Blue Theme)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded,
                        size: 15, color: Color(0xFF475569)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Establish Proactive Support Plans',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "No active mentorship cases have been scheduled yet. Use 'Create Support Plan' on flagged student records to assign faculty mentors.",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF475569),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Data evidence: 0 support plans currently in progress.',
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: SUPPORT PLANS & CASE LOG (Screenshot 5)
  // ===========================================================================
  Widget _buildSupportPlansTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row (Screenshot 5)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 620;

                final textBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support Action Plans & Mentorship Log',
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Active interventions scheduled by academic advisors, department heads, and counsellors.',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ],
                );

                final actionBtn = Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: _showScheduleSupportActionDialog,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E2865), Color(0xFF38439E)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add, size: 14, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            'Schedule Support Action',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBlock,
                      const SizedBox(height: 12),
                      actionBtn,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: textBlock),
                    const SizedBox(width: 16),
                    actionBtn,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),

          // Body Content (Empty State or List - Screenshot 5)
          if (_loggedSupportPlans.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.assignment_outlined,
                    size: 32,
                    color: Color(0xFF94A3B8),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No Support Plans Logged Yet',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Click 'Schedule Support Action' to log 1-on-1 mentorship, remedial sessions, or counselling reviews.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: _loggedSupportPlans.length,
              separatorBuilder: (_, i) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final plan = _loggedSupportPlans[index];
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
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.support_agent_rounded,
                            color: Color(0xFF2563EB), size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${plan['student']} (${plan['roll']}) - ${plan['title']}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Mentor: ${plan['mentor']}  |  Scheduled: ${plan['date']}  |  Type: ${plan['type']}",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          plan['status'] ?? 'Scheduled',
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFD97706),
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

  void _showStudentDetailsModal(Map<String, dynamic> s) {
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person, color: Color(0xFF1E2865), size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['name'] as String,
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${s['roll']} • ${s['dept']}",
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Quiz Average', s['quiz'] as String),
              _buildDetailRow('Certifications', s['certs'] as String),
              _buildDetailRow('Interview Score', "${s['interview']}/100"),
              _buildDetailRow('Resume Score', "${s['resume']}/100"),
              _buildDetailRow('Overall Readiness', "${s['overall']}/100"),
              _buildDetailRow('Risk Tier', s['tier'] as String),
              _buildDetailRow('Review Status', s['status'] as String),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close',
                style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showCreateSupportPlanDialog(s['name'] as String);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('+ Create Plan',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF64748B))),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A))),
        ],
      ),
    );
  }

  void _showCreateSupportPlanDialog(String studentName) {
    final actionController = TextEditingController(
        text: 'Targeted Remedial Support & Weekly Review');
    final mentorController = TextEditingController(text: 'Assigned Advisor');
    String selectedType = 'Remedial Mentorship';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Create Support Plan for $studentName',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          content: SizedBox(
            width: 440,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Intervention Strategy',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: selectedType,
                    isDense: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: [
                      'Remedial Mentorship',
                      'Skill Booster Track',
                      'Academic Counselling',
                      'Interview Prep Coaching',
                    ]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: GoogleFonts.poppins(fontSize: 12))))
                        .toList(),
                    onChanged: (v) => setDialogState(() => selectedType = v!),
                  ),
                  const SizedBox(height: 12),
                  Text('Action Description',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: actionController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Assigned Faculty / Mentor',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: mentorController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  _loggedSupportPlans.add({
                    'student': studentName,
                    'roll': 'Flagged',
                    'title': actionController.text.trim(),
                    'mentor': mentorController.text.trim(),
                    'type': selectedType,
                    'date': 'Today, 04:00 PM',
                    'status': 'Scheduled',
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Support plan created for $studentName!',
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Create Plan',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showScheduleSupportActionDialog() {
    final studentController =
        TextEditingController(text: 'Kavya Menon (110121008)');
    final actionController = TextEditingController(
        text: '1-on-1 Remedial Mentorship & Certification Roadmap');
    final mentorController =
        TextEditingController(text: 'Dr. Meena Raghavan');
    String selectedType = 'Remedial Mentorship';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Schedule Support Action',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Target',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: studentController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Intervention Type',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: selectedType,
                    isDense: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: [
                      'Remedial Mentorship',
                      'Skill Booster Track',
                      'Academic Counselling',
                      'Interview Prep Coaching',
                    ]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: GoogleFonts.poppins(fontSize: 12))))
                        .toList(),
                    onChanged: (v) => setDialogState(() => selectedType = v!),
                  ),
                  const SizedBox(height: 12),
                  Text('Action Description',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: actionController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Assigned Faculty / Mentor',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: mentorController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  _loggedSupportPlans.add({
                    'student': 'Kavya Menon',
                    'roll': '110121008',
                    'title': actionController.text.trim(),
                    'mentor': mentorController.text.trim(),
                    'type': selectedType,
                    'date': 'Today, 03:30 PM',
                    'status': 'Scheduled',
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Support action logged successfully!',
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Save & Schedule',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
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
