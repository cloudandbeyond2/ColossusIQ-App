import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INSTITUTION: FACULTY REPORTS SCREEN (Matches Screenshots 3 & 4)
// - Blueprint grid hero banner with breadcrumbs & badges (INSTITUTION, Phase 3)
// - 4 Metric KPI Stat Cards (Reports Ready, Scheduled Auto-Runs, Data Export Volume, Accreditation Ready)
// - Search bar + "+ Generate report" button
// - Type filter chips (All, Academic, Department, Placement, Faculty, Compliance, Institution)
// - Dropdowns: All Scopes, All Periods
// - Tab 0: Generated Reports (0) with faint blueprint grid empty state (Screenshot 3)
// - Tab 1: Automated Schedules (0) with Cron Delivery Schedules card (Screenshot 4)
// =============================================================================

class FacultyReportsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyReportsScreen({super.key, this.onBack});

  @override
  State<FacultyReportsScreen> createState() => _FacultyReportsScreenState();
}

class _FacultyReportsScreenState extends State<FacultyReportsScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';
  String _selectedType = 'All';
  String _selectedScope = 'All Scopes';
  String _selectedPeriod = 'All Periods';

  final List<String> _types = [
    'All',
    'Academic',
    'Department',
    'Placement',
    'Faculty',
    'Compliance',
    'Institution',
  ];

  final List<String> _scopes = [
    'All Scopes',
    'Institutional',
    'Departmental',
    'Faculty Workload',
    'Student Cohort',
  ];

  final List<String> _periods = [
    'All Periods',
    'Current Semester (Odd 2026)',
    'Academic Year 2025-26',
    'Past 3 Years Aggregate',
  ];

  final List<Map<String, dynamic>> _generatedReports = [];
  final List<Map<String, dynamic>> _automatedSchedules = [];

  void _showGenerateReportDialog() {
    String reportCategory = 'Academic';
    final titleController = TextEditingController(
        text: 'NBA Outcome Attainment & SAR Criterion 3 Report');
    String reportFormat = 'PDF';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Generate New Report',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Report Type / Category',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: reportCategory,
                    isDense: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: [
                      'Academic',
                      'Department',
                      'Placement',
                      'Faculty',
                      'Compliance',
                      'Institution',
                    ]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child:
                                Text(e, style: GoogleFonts.poppins(fontSize: 12))))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => reportCategory = v!),
                  ),
                  const SizedBox(height: 12),
                  Text('Report Title',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Export Format',
                      style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569))),
                  const SizedBox(height: 6),
                  Row(
                    children: ['PDF', 'Excel', 'CSV'].map((fmt) {
                      final isSel = reportFormat == fmt;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(fmt),
                          selected: isSel,
                          onSelected: (_) =>
                              setDialogState(() => reportFormat = fmt),
                          selectedColor: const Color(0xFF1E2865),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isSel ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      );
                    }).toList(),
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
                  _generatedReports.add({
                    'title': titleController.text.trim(),
                    'type': reportCategory,
                    'scope': _selectedScope,
                    'format': reportFormat,
                    'date': 'Today, 10:45 AM',
                    'size': '4.2 MB',
                    'status': 'Certified',
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Report generated successfully!',
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
              child: Text('Generate & Export',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewScheduleDialog() {
    final titleController =
        TextEditingController(text: 'Weekly Department Attainment Digest');
    String cadence = 'Weekly (Monday 08:00 AM)';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'New Automated Schedule',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Schedule Name',
                    style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569))),
                const SizedBox(height: 6),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Cadence / Cron Frequency',
                    style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569))),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: cadence,
                  isDense: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  items: [
                    'Weekly (Monday 08:00 AM)',
                    'Bi-weekly Review',
                    'Monthly Digest (1st of month)',
                    'End of Semester Archive',
                  ]
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child:
                              Text(e, style: GoogleFonts.poppins(fontSize: 12))))
                      .toList(),
                  onChanged: (v) => setDialogState(() => cadence = v!),
                ),
              ],
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
                  _automatedSchedules.add({
                    'title': titleController.text.trim(),
                    'cadence': cadence,
                    'recipients': 'Faculty & HoD Inbox',
                    'format': 'PDF & Excel',
                    'active': true,
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Automated schedule created successfully!',
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
              child: Text('Save Schedule',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
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
              _buildStatMetricCards(),
              const SizedBox(height: 18),
              _buildFilterAndSearchToolbar(),
              const SizedBox(height: 16),
              _buildTabBar(),
              const SizedBox(height: 16),
              if (_selectedTab == 0)
                _buildGeneratedReportsTab()
              else
                _buildAutomatedSchedulesTab(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 3 & 4)
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
                painter: _ReportsGridPainter(),
              ),
            ),
            // Watermark document icon on right
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.insert_drive_file_outlined,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null)
                          InkWell(
                            onTap: widget.onBack,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.arrow_back,
                                  size: 16, color: Colors.white70),
                            ),
                          ),
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
                          'Institution',
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
                          'Reports',
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
                      // Amber Icon Box
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.description_rounded,
                          color: Color(0xFFFBBF24),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges Row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'INSTITUTION',
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
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706)
                                        .withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Phase 3',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: const Color(0xFFFBBF24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Reports',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Student, faculty, department, course, skill, placement and institutional reports.',
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
  // 4 STAT METRIC KPI CARDS (Screenshot 3 - Responsive & Fitted)
  // ===========================================================================
  Widget _buildStatMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isVeryWide = constraints.maxWidth >= 1060;
        final isMedium = constraints.maxWidth >= 540;

        final card1 = _buildKpiCard(
          title: 'REPORTS READY',
          icon: Icons.description_outlined,
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${_generatedReports.length}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'FACULTY',
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'All certified',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          subtitle: 'PDF, Excel & CSV available',
        );

        final card2 = _buildKpiCard(
          title: 'SCHEDULED AUTO-RUNS',
          icon: Icons.access_time_rounded,
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${_automatedSchedules.length}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'active crons',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          subtitle: 'Next run: Monday 08:00 AM',
        );

        final card3 = _buildKpiCard(
          title: 'DATA EXPORT VOLUME',
          icon: Icons.file_download_outlined,
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '48.2 MB',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'this term',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          subtitle: 'Institutional data warehouse',
        );

        final card4 = _buildKpiCard(
          title: 'ACCREDITATION READY',
          icon: Icons.verified_outlined,
          iconColor: const Color(0xFF0D9488),
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '100%',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0D9488),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'compliant',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          subtitle: 'NAAC & NBA formats supported',
        );

        if (isVeryWide) {
          return Row(
            children: [
              Expanded(child: card1),
              const SizedBox(width: 12),
              Expanded(child: card2),
              const SizedBox(width: 12),
              Expanded(child: card3),
              const SizedBox(width: 12),
              Expanded(child: card4),
            ],
          );
        } else if (isMedium) {
          return Column(
            children: [
              Row(children: [
                Expanded(child: card1),
                const SizedBox(width: 10),
                Expanded(child: card2),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: card3),
                const SizedBox(width: 10),
                Expanded(child: card4),
              ]),
            ],
          );
        } else {
          return Column(
            children: [
              card1,
              const SizedBox(height: 10),
              card2,
              const SizedBox(height: 10),
              card3,
              const SizedBox(height: 10),
              card4,
            ],
          );
        }
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required IconData icon,
    required Widget valueWidget,
    required String subtitle,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                size: 16,
                color: iconColor ?? const Color(0xFF64748B),
              ),
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: valueWidget,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
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
  // FILTER AND SEARCH TOOLBAR (Screenshot 3 - Overflow Fixed)
  // ===========================================================================
  Widget _buildFilterAndSearchToolbar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1060;
        final isSmall = constraints.maxWidth < 520;

        final searchBar = Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search reports by title, scope or keyword...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    filled: false,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        );

        final generateBtn = Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _showGenerateReportDialog,
            child: Ink(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2865),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 14, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    'Generate report',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1: Search + Generate
            if (isSmall) ...[
              searchBar,
              const SizedBox(height: 10),
              generateBtn,
            ] else ...[
              Row(
                children: [
                  Expanded(child: searchBar),
                  const SizedBox(width: 14),
                  generateBtn,
                ],
              ),
            ],
            const SizedBox(height: 12),

            // Row 2 & 3: Filters & Dropdowns
            if (isDesktop)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTypeChips()),
                  const SizedBox(width: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 140, child: _buildScopeDropdown()),
                      const SizedBox(width: 10),
                      SizedBox(width: 180, child: _buildPeriodDropdown()),
                    ],
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTypeChips(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildScopeDropdown()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPeriodDropdown()),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildTypeChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_alt_outlined,
                  size: 13, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                'TYPE:',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          ..._types.map((t) {
            final isSel = _selectedType == t;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => setState(() => _selectedType = t),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSel
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    t,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      color: isSel ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildScopeDropdown() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedScope,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          items: _scopes
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      s,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedScope = v!),
        ),
      ),
    );
  }

  Widget _buildPeriodDropdown() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPeriod,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          items: _periods
              .map((p) => DropdownMenuItem(
                    value: p,
                    child: Text(
                      p,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedPeriod = v!),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB NAVIGATION (Screenshot 3 & 4 - Overflow Fixed)
  // ===========================================================================
  Widget _buildTabBar() {
    final tabs = [
      {
        'title': 'Generated Reports',
        'count': '${_generatedReports.length}',
        'icon': Icons.description_outlined,
      },
      {
        'title': 'Automated Schedules',
        'count': '${_automatedSchedules.length}',
        'icon': Icons.access_time_rounded,
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
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isSelected = _selectedTab == i;
            final tab = tabs[i];
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
                        tab['icon'] as IconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${tab['title']} (${tab['count']})",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF1E2865)
                              : const Color(0xFF64748B),
                        ),
                      ),
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
  // TAB 0: GENERATED REPORTS (Screenshot 3)
  // ===========================================================================
  Widget _buildGeneratedReportsTab() {
    final filtered = _generatedReports.where((r) {
      if (_selectedType != 'All' && r['type'] != _selectedType) return false;
      if (_searchQuery.isNotEmpty &&
          !(r['title'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return Container(
        height: 310,
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightBlueprintGridPainter(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No reports match your filters',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Generate a report using the button above.',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: _showGenerateReportDialog,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E2865),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  'Generate report',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (_, i) => const SizedBox(height: 12),
      itemBuilder: (context, idx) {
        final r = filtered[idx];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
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
                child: const Icon(Icons.picture_as_pdf_rounded,
                    color: Color(0xFF2563EB), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Type: ${r['type']}  |  Scope: ${r['scope']}  |  ${r['format']} • ${r['size']}  |  Generated: ${r['date']}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading ${r['title']}...'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded, size: 14),
                label: Text(
                  'Download',
                  style: GoogleFonts.poppins(fontSize: 11.5),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // TAB 1: AUTOMATED SCHEDULES (Screenshot 4)
  // ===========================================================================
  Widget _buildAutomatedSchedulesTab() {
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
          // Header Row (Screenshot 4 - Responsive Layout)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 620;

                final badgeWidget = Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_automatedSchedules.length} Schedules Active',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F766E),
                    ),
                  ),
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Automated Cron Delivery Schedules',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          badgeWidget,
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Configured reports run automatically in the background and deliver PDF/Excel digests to recipient inboxes.',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                          height: 1.35,
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Automated Cron Delivery Schedules',
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Configured reports run automatically in the background and deliver PDF/Excel digests to recipient inboxes.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    badgeWidget,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),

          // Body (Empty state or scheduled cards)
          if (_automatedSchedules.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.schedule_send_rounded,
                    size: 32,
                    color: Color(0xFF94A3B8),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No Automated Delivery Schedules Configured',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Set up recurring automated digests to deliver PDF/Excel files straight to faculty mailboxes or institutional drives.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _showNewScheduleDialog,
                    icon: const Icon(Icons.add, size: 14),
                    label: Text(
                      'Create Delivery Schedule',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1E2865)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
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
              itemCount: _automatedSchedules.length,
              separatorBuilder: (_, i) => const SizedBox(height: 10),
              itemBuilder: (context, idx) {
                final s = _automatedSchedules[idx];
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
                        child: const Icon(Icons.access_alarm_rounded,
                            color: Color(0xFF2563EB), size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s['title'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Cadence: ${s['cadence']}  |  Deliver to: ${s['recipients']}  |  Format: ${s['format']}",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: s['active'] as bool,
                        activeThumbColor: const Color(0xFF1E2865),
                        onChanged: (val) {
                          setState(() {
                            s['active'] = val;
                          });
                        },
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

// Background painter for blueprint grid in top banner
class _ReportsGridPainter extends CustomPainter {
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

// Background painter for faint grid in empty state
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6)
      ..strokeWidth = 0.8;

    const double step = 26.0;

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
