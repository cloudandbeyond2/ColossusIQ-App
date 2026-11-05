import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DEPARTMENT: SKILL INTELLIGENCE SCREEN (HOD)
// Exactly matches Images 1, 2, 3, 4, 5:
// - Fixed RenderFlex Overflow errors (Image 1) with responsive LayoutBuilder & Wrap
// - Hero banner with DEPARTMENT + Phase 2 badges & network watermark
// - Filter & Search Toolbar (Department, Cohort/Batch, Domain/Stream, Search, Actions)
// - 5 Metric / Stat Cards
// - Interactive Tabs:
//     * Tab 0: Skill Gap & Industry Demand (Images 2 & 3)
//     * Tab 1: Student Skill Inventory (Image 4)
//     * Tab 2: Recruiter Benchmarks & Trends (Image 5)
//     * Tab 3: Bridge Courses (0)
// =============================================================================

class HodSkillIntelligenceScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HodSkillIntelligenceScreen({super.key, this.onBack});

  @override
  State<HodSkillIntelligenceScreen> createState() =>
      _HodSkillIntelligenceScreenState();
}

class _HodSkillIntelligenceScreenState
    extends State<HodSkillIntelligenceScreen> {
  int _selectedTabIndex = 0;
  String _selectedDept = 'All Departments';
  String _selectedCohort = 'All Batches';
  String _selectedDomain = 'All Domains';
  final TextEditingController _searchController = TextEditingController();

  // ---------------------------------------------------------------------------
  // DATA FOR TAB 0: SKILL INTELLIGENCE MATRIX (Image 3 - 6 skills)
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> _skillsMatrix = [
    {
      'name': 'Database Management Systems (CS3492)',
      'subtitle':
          'Theory · Computer Science & Engineering Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 68,
      'deficit': -7,
      'status': 'Moderate',
      'students': 2,
    },
    {
      'name': 'Operating Systems (CS3451)',
      'subtitle':
          'Theory · Computer Science & Engineering Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 68,
      'deficit': -7,
      'status': 'Moderate',
      'students': 2,
    },
    {
      'name': 'Computer Networks (CS3591)',
      'subtitle':
          'Theory · Computer Science & Engineering Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 68,
      'deficit': -7,
      'status': 'Moderate',
      'students': 2,
    },
    {
      'name': 'Machine Learning (AL3451)',
      'subtitle':
          'Theory · Artificial Intelligence & Data Science Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 60,
      'deficit': -15,
      'status': 'High Deficit',
      'students': 2,
    },
    {
      'name': 'Control Systems (EC3351)',
      'subtitle':
          'Theory · Electronics & Communication Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 60,
      'deficit': -15,
      'status': 'High Deficit',
      'students': 2,
    },
    {
      'name': 'Theory of Machines (ME3491)',
      'subtitle':
          'Theory + Lab · Mechanical Engineering Graduate, Core Technical Associate',
      'target': 75,
      'mastery': 56,
      'deficit': -19,
      'status': 'High Deficit',
      'students': 2,
    },
  ];

  // ---------------------------------------------------------------------------
  // DATA FOR TAB 1: STUDENT SKILL INVENTORY ROSTER (Image 4)
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> _studentRoster = [
    {
      'name': 'Kavya Menon',
      'rollNo': '110121008',
      'dept': 'Computer Science & Engineering',
      'readiness': 55,
      'isHighReadiness': false,
      'topSkills': [
        'Database Management Systems',
        'Operating Systems',
        'Computer Networks',
      ],
      'gaps': [
        'Raise your quiz average to 60%',
        'Earn 1 more certificate(s)',
        'Reach a total of 70',
      ],
      'certs': 1,
    },
    {
      'name': 'Sanjay Pillai',
      'rollNo': '110121007',
      'dept': 'Information Technology',
      'readiness': 81,
      'isHighReadiness': true,
      'topSkills': [
        'Analytical Problem Solving',
        'Technical Communication',
        'Core Subject Fundamentals',
      ],
      'gaps': ['All criteria met'],
      'certs': 3,
    },
    {
      'name': 'Nandini Krishnan',
      'rollNo': '110121014',
      'dept': 'Artificial Intelligence & Data Science',
      'readiness': 75,
      'isHighReadiness': true,
      'topSkills': ['Machine Learning'],
      'gaps': ['All criteria met'],
      'certs': 4,
    },
    {
      'name': 'Rohan Verma',
      'rollNo': '110121019',
      'dept': 'Computer Science & Engineering',
      'readiness': 62,
      'isHighReadiness': false,
      'topSkills': ['Full Stack Dev', 'Cloud Computing'],
      'gaps': ['Raise your quiz average to 60%', 'Reach a total of 70'],
      'certs': 2,
    },
    {
      'name': 'Ananya Sharma',
      'rollNo': '110121003',
      'dept': 'Electronics & Communication',
      'readiness': 58,
      'isHighReadiness': false,
      'topSkills': ['Embedded C', 'Control Systems'],
      'gaps': ['Earn 1 more certificate(s)', 'Reach a total of 70'],
      'certs': 1,
    },
  ];

  // ---------------------------------------------------------------------------
  // DATA FOR TAB 2: RECRUITER BENCHMARKS THRESHOLDS (Image 5)
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> _gatewayThresholds = [
    {
      'dimension': 'Overall Placement Eligibility Gateway',
      'target': 'Total Score \u2265 70 / 100',
      'minScore': '70 score cutoff',
      'population': '14 students',
      'compliance': '3 Qualified (21%)',
    },
    {
      'dimension': 'Academic & Quiz Mastery Standard',
      'target': 'Quiz Average \u2265 60%',
      'minScore': '60 score cutoff',
      'population': '14 students',
      'compliance': 'Cohort Avg: 63%',
    },
    {
      'dimension': 'Technical Mock Interview Clearance',
      'target': 'Interview Score \u2265 50',
      'minScore': '50 score cutoff',
      'population': '14 students',
      'compliance': 'Cohort Avg: 60%',
    },
    {
      'dimension': 'ATS Resume Standard',
      'target': 'Resume ATS Score \u2265 70',
      'minScore': '70 score cutoff',
      'population': '14 students',
      'compliance': 'Cohort Avg: 78%',
    },
    {
      'dimension': 'Aptitude & Logical Assessment',
      'target': 'Aptitude Score \u2265 50',
      'minScore': '50 score cutoff',
      'population': '14 students',
      'compliance': 'Cohort Avg: 67%',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              const SizedBox(height: 18),
              _buildFilterToolbar(),
              const SizedBox(height: 18),
              _buildStatCardsRow(),
              const SizedBox(height: 22),
              _buildTabsRow(),
              const SizedBox(height: 20),
              // Dynamic Tab Body
              _buildCurrentTabContent(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildTab0SkillGapAndDemand();
      case 1:
        return _buildTab1StudentSkillInventory();
      case 2:
        return _buildTab2RecruiterBenchmarks();
      case 3:
      default:
        return _buildTab3BridgeCourses();
    }
  }

  // ===========================================================================
  // TOP HERO BANNER (Matches Screenshots 4 & 5)
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
            // Watermark hub/network on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.hub_rounded,
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
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '\u203A',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Department',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '\u203A',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Skill Intelligence',
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
                          Icons.hub_outlined,
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
                                    'DEPARTMENT',
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
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Phase 2',
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
                              'Skill Intelligence',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Skill distribution and gaps across batches versus industry demand.',
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
  // FILTER TOOLBAR CARD
  // ===========================================================================
  Widget _buildFilterToolbar() {
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
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 980;
              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildFilterDropdown(
                              label: 'DEPARTMENT',
                              value: _selectedDept,
                              items: const [
                                'All Departments',
                                'Computer Science & Engg',
                                'AI & Data Science',
                                'Information Tech',
                              ],
                              onChanged: (val) =>
                                  setState(() => _selectedDept = val!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFilterDropdown(
                              label: 'COHORT / BATCH',
                              value: _selectedCohort,
                              items: const [
                                'All Batches',
                                'Batch 2023 - 2027',
                                'Batch 2024 - 2028',
                                'Batch 2025 - 2029',
                              ],
                              onChanged: (val) =>
                                  setState(() => _selectedCohort = val!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFilterDropdown(
                              label: 'DOMAIN / STREAM',
                              value: _selectedDomain,
                              items: const [
                                'All Domains',
                                'Core Systems',
                                'AI / Machine Learning',
                                'Cloud & Full-Stack',
                              ],
                              onChanged: (val) =>
                                  setState(() => _selectedDomain = val!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildActionButtonsRow(),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 190,
                          child: _buildFilterDropdown(
                            label: 'DEPARTMENT',
                            value: _selectedDept,
                            items: const [
                              'All Departments',
                              'Computer Science & Engg',
                              'AI & Data Science',
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedDept = val!),
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: _buildFilterDropdown(
                            label: 'COHORT / BATCH',
                            value: _selectedCohort,
                            items: const [
                              'All Batches',
                              'Batch 2023 - 2027',
                              'Batch 2024 - 2028',
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedCohort = val!),
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: _buildFilterDropdown(
                            label: 'DOMAIN / STREAM',
                            value: _selectedDomain,
                            items: const [
                              'All Domains',
                              'Core Systems',
                              'AI / ML',
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedDomain = val!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildActionButtonsRow(),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 14),
          // Search Input
          SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SEARCH',
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search skill, role, student..',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 9),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: GoogleFonts.poppins(fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Active filter scope: pills
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Text(
                'Active filter scope:',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              _buildScopeChip(_selectedDept),
              _buildScopeChip(_selectedCohort),
              _buildScopeChip(_selectedDomain),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
              onChanged: onChanged,
              items: items.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtonsRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Live data synced with PostgreSQL database!',
                    style: GoogleFonts.poppins()),
                backgroundColor: const Color(0xFF0F766E),
              ),
            );
          },
          icon: const Icon(Icons.sync_rounded, size: 15),
          label: const Text('Sync Live Data'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF334155),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.file_download_outlined, size: 15),
          label: const Text('Export CSV'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF334155),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF222B68),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600),
          ),
          child: const Text('Schedule Bridge Course'),
        ),
      ],
    );
  }

  Widget _buildScopeChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5 STAT CARDS ROW
  // ===========================================================================
  Widget _buildStatCardsRow() {
    final stats = [
      {
        'title': 'Students Profiled',
        'badge': 'Across active departments',
        'badgeBg': const Color(0xFFEEF2F6),
        'badgeColor': const Color(0xFF475569),
        'value': '14',
        'sub': 'Enrolled students evaluated in active..',
      },
      {
        'title': 'Placement Ready',
        'badge': '3 of 14 qualified',
        'badgeBg': const Color(0xFFFEF3C7),
        'badgeColor': const Color(0xFFB45309),
        'value': '21%',
        'sub': 'Score \u2265 70 across quizzes, certs &..',
      },
      {
        'title': 'Identified Skill Deficits',
        'badge': 'Below target benchmark',
        'badgeBg': const Color(0xFFFEE2E2),
        'badgeColor': const Color(0xFFB91C1C),
        'value': '3',
        'sub': 'Curricular areas with < 65% cohort..',
      },
      {
        'title': 'Verified Certificates',
        'badge': 'Issued to date',
        'badgeBg': const Color(0xFFFEF3C7),
        'badgeColor': const Color(0xFFB45309),
        'value': '0',
        'sub': 'Passed proctored assessments in this..',
      },
      {
        'title': 'Avg Readiness Score',
        'badge': 'Placement bar: 70',
        'badgeBg': const Color(0xFFEDE9FE),
        'badgeColor': const Color(0xFF6D28D9),
        'value': '65 / 100',
        'sub': 'Weighted average across cohort..',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1050;
        final isTablet = constraints.maxWidth >= 650;

        if (isDesktop) {
          return Row(
            children: stats.map((s) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _buildSingleStatCard(s),
                ),
              );
            }).toList(),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildSingleStatCard(stats[0])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSingleStatCard(stats[1])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSingleStatCard(stats[2])),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildSingleStatCard(stats[3])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSingleStatCard(stats[4])),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: stats.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildSingleStatCard(s),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildSingleStatCard(Map<String, dynamic> s) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  s['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: s['badgeBg'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s['badge'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: s['badgeColor'] as Color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            s['value'] as String,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s['sub'] as String,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
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
  // 4 TABS ROW (Images 2, 4, 5)
  // ===========================================================================
  Widget _buildTabsRow() {
    final tabs = [
      {'title': 'Skill Gap & Industry Demand', 'icon': null},
      {
        'title': 'Student Skill Inventory',
        'icon': Icons.people_outline_rounded
      },
      {
        'title': 'Recruiter Benchmarks & Trends',
        'icon': Icons.radar_rounded
      },
      {'title': 'Bridge Courses (0)', 'icon': null},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (idx) {
          final isSelected = _selectedTabIndex == idx;
          final item = tabs[idx];
          return InkWell(
            onTap: () => setState(() => _selectedTabIndex = idx),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color(0xFF222B68)
                        : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (item['icon'] != null) ...[
                    Icon(
                      item['icon'] as IconData,
                      size: 16,
                      color: isSelected
                          ? const Color(0xFF222B68)
                          : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    item['title'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: SKILL GAP & INDUSTRY DEMAND (Images 2 & 3)
  // ===========================================================================
  Widget _buildTab0SkillGapAndDemand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildChartsRow(),
        const SizedBox(height: 24),
        _buildAiRecommendationsCard(),
        const SizedBox(height: 24),
        _buildMatrixTableCard(),
      ],
    );
  }

  Widget _buildChartsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1050;
        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildSyllabusBenchmarkBarChart()),
              const SizedBox(width: 20),
              Expanded(flex: 5, child: _buildCategoryCompetencyChart()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildSyllabusBenchmarkBarChart(),
              const SizedBox(height: 20),
              _buildCategoryCompetencyChart(),
            ],
          );
        }
      },
    );
  }

  // Left Chart: Syllabus Target Benchmark vs. Real Cohort Mastery (Image 2)
  Widget _buildSyllabusBenchmarkBarChart() {
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
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Syllabus Target Benchmark vs. Real Cohort Mastery',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('80', style: _axisTextStyle()),
                    Text('60', style: _axisTextStyle()),
                    Text('40', style: _axisTextStyle()),
                    Text('20', style: _axisTextStyle()),
                    Text('0', style: _axisTextStyle()),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBarCluster(
                          label: 'Operating Systems', target: 75, actual: 68),
                      _buildBarCluster(
                          label: 'Machine Learning', target: 75, actual: 60),
                      _buildBarCluster(
                          label: 'Theory of Machines', target: 75, actual: 56),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF1E2548), 'Syllabus Target'),
              const SizedBox(width: 18),
              _buildLegendItem(const Color(0xFFD97706), 'Cohort Mastery'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarCluster({
    required String label,
    required double target,
    required double actual,
  }) {
    const maxHeight = 160.0;
    final targetHeight = (target / 100) * maxHeight;
    final actualHeight = (actual / 100) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 18,
              height: targetHeight,
              decoration: const BoxDecoration(
                color: Color(0xFF1E2548),
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 18,
              height: actualHeight,
              decoration: const BoxDecoration(
                color: Color(0xFFD97706),
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 90,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCompetencyChart() {
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
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Category Competency Breakdown',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Text(
                    'Theory',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                Positioned(
                  top: 22,
                  bottom: 24,
                  child: Container(
                    width: 1.5,
                    color: const Color(0xFF1E2548),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Text(
                    'Theory + Lab',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  // ===========================================================================
  // AI CURRICULAR RECOMMENDATIONS CARD (Fixed Overflow from Image 1)
  // ===========================================================================
  Widget _buildAiRecommendationsCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, boxConstraints) {
              final isNarrow = boxConstraints.maxWidth < 650;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 18,
                        color: Color(0xFF4F46E5),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'AI Curricular Intervention Recommendations',
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      if (!isNarrow) ...[
                        const SizedBox(width: 12),
                        Text(
                          'Live recommendations based on current deficit',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isNarrow) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Live recommendations based on current deficit',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 940;
              final cards = [
                _buildRecCard(
                  tag: 'CRITICAL PRIORITY',
                  isCritical: true,
                  title: 'Curricular Deficit in Machine Learning',
                  body:
                      'Cohort readiness in Machine Learning (AL3451) is currently 60%, trailing the standard target of 75%. Remediate through structured lab assignments.',
                  footer: 'Assessed across 2 enrolled students in Theory',
                ),
                _buildRecCard(
                  tag: 'ACTIONABLE PLAN',
                  isCritical: false,
                  title: 'No Course Certificates Issued Yet',
                  body:
                      'Students have not yet passed final proctored assessments. Publishing quizzes in AI Quiz Builder will enable verifiable digital credentials.',
                  footer: '0 issued certificates in store',
                ),
                _buildRecCard(
                  tag: 'ACTIONABLE PLAN',
                  isCritical: false,
                  title: 'Placement Readiness Gateway Summary',
                  body:
                      '21% of the cohort qualifies for placement drives (Overall score \u2265 70, Quiz avg \u2265 60%, Mock interview \u2265 50).',
                  footer:
                      'Aggregated from 14 active student records on the readiness board',
                ),
              ];

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: cards[0]),
                    const SizedBox(width: 14),
                    Expanded(child: cards[1]),
                    const SizedBox(width: 14),
                    Expanded(child: cards[2]),
                  ],
                );
              } else {
                return Column(
                  children: [
                    cards[0],
                    const SizedBox(height: 12),
                    cards[1],
                    const SizedBox(height: 12),
                    cards[2],
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecCard({
    required String tag,
    required bool isCritical,
    required String title,
    required String body,
    required String footer,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isCritical
                  ? const Color(0xFFFEF2F2)
                  : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCritical
                    ? const Color(0xFFFCA5A5)
                    : const Color(0xFFBFDBFE),
              ),
            ),
            child: Text(
              tag,
              style: GoogleFonts.poppins(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: isCritical
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            footer,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SKILL INTELLIGENCE MATRIX TABLE (Fixed Overflow from Image 1, Matches Image 3)
  // ===========================================================================
  Widget _buildMatrixTableCard() {
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
          LayoutBuilder(
            builder: (context, boxConstraints) {
              final isNarrow = boxConstraints.maxWidth < 650;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Skill Intelligence Matrix',
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Comparing hiring demand score against evaluated cohort readiness score',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isNarrow) ...[
                        const SizedBox(width: 12),
                        Text(
                          'Showing ${_skillsMatrix.length} skills',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isNarrow) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Showing ${_skillsMatrix.length} skills',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1050,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 38,
                          child: Text(
                            'COURSE / CURRICULAR COMPETENCY',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 14,
                          child: Text(
                            'SYLLABUS TARGET',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 14,
                          child: Text(
                            'COHORT MASTERY',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Text(
                            'DEFICIT / GAP',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(
                            'STATUS',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Text(
                            'STUDENTS EVALUATED',
                            style: _thStyle(),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'ACTION',
                              style: _thStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  ..._skillsMatrix.map((item) {
                    return _buildTableRow(item);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> item) {
    final status = item['status'] as String;
    final isHighDeficit = status == 'High Deficit';

    final badgeBg = isHighDeficit
        ? const Color(0xFFFEF3C7) // soft peach/amber
        : const Color(0xFFFEF3C7);
    final badgeColor = isHighDeficit
        ? const Color(0xFFB45309) // amber text
        : const Color(0xFFB45309);

    final deficit = item['deficit'] as int;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: Row(
              children: [
                Text(
                  '${item['target']}%',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      height: 5,
                      color: const Color(0xFF1E2548),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: Row(
              children: [
                Text(
                  '${item['mastery']}%',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      height: 5,
                      color: const Color(0xFF1E2548),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: Text(
              '$deficit%',
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F766E),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Text(
              '${item['students']}',
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Opening Bridge Course planning studio for ${item['name']}',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: const Color(0xFF0F766E),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Plan Bridge'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 1: STUDENT SKILL INVENTORY (Image 4)
  // ===========================================================================
  Widget _buildTab1StudentSkillInventory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCohortProgressionChartCard(),
        const SizedBox(height: 24),
        _buildStudentMasteryRosterTableCard(),
      ],
    );
  }

  // Chart: Cohort Progression & Placement Qualification Rate (Image 4)
  Widget _buildCohortProgressionChartCard() {
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
            'Cohort Progression & Placement Qualification Rate',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('80', style: _axisTextStyle()),
                    Text('60', style: _axisTextStyle()),
                    Text('40', style: _axisTextStyle()),
                    Text('20', style: _axisTextStyle()),
                    Text('0', style: _axisTextStyle()),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (i) => Container(
                            height: 1,
                            color: const Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      // Two Bars for Final Year (Navy: 65, Gold: 21)
                      LayoutBuilder(
                        builder: (context, barConstraints) {
                          final spacing = (barConstraints.maxWidth * 0.35).clamp(32.0, 160.0);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 26,
                                height: (65 / 80) * 170,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1E2548),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                              SizedBox(width: spacing),
                              Container(
                                width: 26,
                                height: (21 / 80) * 170,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD97706),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Final Year',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF1E2548), 'Cohort Score'),
              const SizedBox(width: 18),
              _buildLegendItem(const Color(0xFFD97706), 'Qualifying %'),
            ],
          ),
        ],
      ),
    );
  }

  // Table: Student Skill Mastery Roster (Image 4)
  Widget _buildStudentMasteryRosterTableCard() {
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
          LayoutBuilder(
            builder: (context, boxConstraints) {
              final isNarrow = boxConstraints.maxWidth < 650;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student Skill Mastery Roster',
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Verified skill profiles, assessments completed and placement readiness status',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isNarrow) ...[
                        const SizedBox(width: 12),
                        Text(
                          'Showing 14 students',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isNarrow) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Showing 14 students',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1100,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 14,
                          child: Text('STUDENT NAME', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 11,
                          child: Text('ROLL NO', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 16,
                          child: Text('DEPARTMENT', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 14,
                          child: Text('OVERALL READINESS', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 22,
                          child: Text('TOP SKILLS', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 20,
                          child: Text('GAPS TO CLOSE', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text('CERTS', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 8,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('PROFILE', style: _thStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  ..._studentRoster.map((s) => _buildStudentRosterRow(s)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentRosterRow(Map<String, dynamic> s) {
    final readiness = s['readiness'] as int;
    final isHigh = s['isHighReadiness'] as bool;
    final topSkills = s['topSkills'] as List<String>;
    final gaps = s['gaps'] as List<String>;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Student Name
          Expanded(
            flex: 14,
            child: Text(
              s['name'] as String,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          // Roll No
          Expanded(
            flex: 11,
            child: Text(
              s['rollNo'] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          // Department
          Expanded(
            flex: 16,
            child: Text(
              s['dept'] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          // Overall Readiness
          Expanded(
            flex: 14,
            child: Row(
              children: [
                Text(
                  '$readiness',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                      height: 5,
                      color: isHigh
                          ? const Color(0xFF0D9488) // teal
                          : const Color(0xFF1E2548), // navy
                    ),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
          // Top Skills Chips
          Expanded(
            flex: 22,
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: topSkills.map((skill) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    skill,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0369A1),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Gaps to close Pills
          Expanded(
            flex: 20,
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: gaps.map((gap) {
                final isMet = gap == 'All criteria met';
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isMet
                        ? const Color(0xFFFEE2E2)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    gap,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: isMet
                          ? const Color(0xFFB91C1C)
                          : const Color(0xFFB91C1C),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Certs
          Expanded(
            flex: 7,
            child: Text(
              '${s['certs']}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          // Action button: Inspect
          Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Inspecting profile of ${s['name']}',
                          style: GoogleFonts.poppins()),
                      backgroundColor: const Color(0xFF0F766E),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Inspect'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: RECRUITER BENCHMARKS & TRENDS (Image 5)
  // ===========================================================================
  Widget _buildTab2RecruiterBenchmarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBenchmarksTopSection(),
        const SizedBox(height: 24),
        _buildPlacementGatewayThresholdsTableCard(),
      ],
    );
  }

  Widget _buildBenchmarksTopSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1050;
        final leftCard = Container(
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
                'Verified Certificates by Course',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E2548),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No Certificates Issued Yet',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E2548),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        );

        final rightCard = Container(
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
              Row(
                children: [
                  const Icon(
                    Icons.radar_rounded,
                    size: 18,
                    color: Color(0xFF222B68),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Institutional Readiness Criteria Breakdown',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Real evaluation metrics for Anna Institute of Technology measured against the standard placement threshold (Overall \u2265 70).',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              _buildReadinessCriterionCard(
                title: 'Placement Ready Cohort',
                sub:
                    'Total \u2265 70, Quiz Avg \u2265 60%, Certs \u2265 2, Interview \u2265 50',
                count: '3',
                countLabel: 'Students Qualified',
                countColor: const Color(0xFF0D9488),
              ),
              const SizedBox(height: 10),
              _buildReadinessCriterionCard(
                title: 'Almost Ready (Near Threshold)',
                sub: 'Total score between 55 and 69',
                count: '8',
                countLabel: 'In Active Remediation',
                countColor: const Color(0xFF334155),
              ),
              const SizedBox(height: 10),
              _buildReadinessCriterionCard(
                title: 'Needs Curricular Action',
                sub: 'Total score < 55 or missing multiple assessments',
                count: '3',
                countLabel: 'Intervention Needed',
                countColor: const Color(0xFF334155),
              ),
              const SizedBox(height: 14),
              Text(
                'Placement formula: Quiz marks 35% + Certificates 20% + Aptitude 15% + Mock interview 15% + Resume 15%.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        );

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: leftCard),
              const SizedBox(width: 20),
              Expanded(flex: 5, child: rightCard),
            ],
          );
        } else {
          return Column(
            children: [
              leftCard,
              const SizedBox(height: 20),
              rightCard,
            ],
          );
        }
      },
    );
  }

  Widget _buildReadinessCriterionCard({
    required String title,
    required String sub,
    required String count,
    required String countLabel,
    required Color countColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F2), // subtle warm beige container
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: countColor,
                ),
              ),
              Text(
                countLabel,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Table: Placement Gateway Thresholds & Cohort Compliance (Image 5)
  Widget _buildPlacementGatewayThresholdsTableCard() {
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
            'Placement Gateway Thresholds & Cohort Compliance',
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Official criteria enforced across students for campus recruitment readiness',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1050,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 32,
                          child: Text('EVALUATION GATE / DIMENSION',
                              style: _thStyle()),
                        ),
                        Expanded(
                          flex: 22,
                          child: Text('TARGET REQUIREMENT', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 20,
                          child: Text('MINIMUM SCORE STANDARD',
                              style: _thStyle()),
                        ),
                        Expanded(
                          flex: 16,
                          child:
                              Text('EVALUATED POPULATION', style: _thStyle()),
                        ),
                        Expanded(
                          flex: 16,
                          child: Text('COHORT COMPLIANCE', style: _thStyle()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  ..._gatewayThresholds.map((row) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFF1F5F9), width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 32,
                            child: Text(
                              row['dimension'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 22,
                            child: Text(
                              row['target'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Text(
                              row['minScore'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Text(
                              row['population'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  row['compliance'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF15803D),
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: BRIDGE COURSES (0)
  // ===========================================================================
  Widget _buildTab3BridgeCourses() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.alt_route_rounded,
                size: 28,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Bridge Courses Scheduled',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Schedule a targeted bridge course to remediate identified curricular deficits in Machine Learning and Control Systems.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Schedule Bridge Course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF222B68),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _axisTextStyle() {
    return GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF94A3B8),
    );
  }

  TextStyle _thStyle() {
    return GoogleFonts.poppins(
      fontSize: 10.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: const Color(0xFF64748B),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// BLUEPRINT GRID BACKGROUND PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const step = 28.0;
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
