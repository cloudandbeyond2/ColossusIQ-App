import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: PLACEMENT READINESS BOARD SCREEN
// Exactly matches Screenshot 1:
// - Blueprint grid hero banner with target watermark, PLACEMENT and MVP badges
// - Live indicator & Refresh button
// - 5 Metric Stat Cards (Students tracked, Placement ready, Almost ready, Needs work, Average total)
// - Formula Banner (Placement ready = total >= 70, ...)
// - Readiness Board Card with search, dropdowns, Export CSV button, and complete student table with progress bars & status chips
// =============================================================================

class PlacementReadinessBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementReadinessBoardScreen({super.key, this.onBack});

  @override
  State<PlacementReadinessBoardScreen> createState() =>
      _PlacementReadinessBoardScreenState();
}

class _PlacementReadinessBoardScreenState
    extends State<PlacementReadinessBoardScreen> {
  String _searchQuery = '';
  String _selectedDeptFilter = 'All';
  String _selectedTierFilter = 'All';
  String _selectedDriveFilter = 'Any drive';

  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Sanjay Pillai',
      'id': '••••1007',
      'dept': 'Information Technology',
      'quiz': '80%',
      'certs': '3',
      'aptitude': '78',
      'interview': '85',
      'resume': '93',
      'total': 81,
      'status': 'Placement ready',
      'statusType': 'ready',
      'gap': '',
    },
    {
      'name': 'Sneha Srinivasan',
      'id': '••••1056',
      'dept': 'Computer Science & Engineering',
      'quiz': '88%',
      'certs': '4',
      'aptitude': '67',
      'interview': '49',
      'resume': '65',
      'total': 78,
      'status': 'Almost ready',
      'statusType': 'almost',
      'gap': 'Score 50+ in a mock interview',
    },
    {
      'name': 'Deepika Das',
      'id': '••••1028',
      'dept': 'Electrical & Electronics',
      'quiz': '68%',
      'certs': '4',
      'aptitude': '78',
      'interview': '69',
      'resume': '75',
      'total': 77,
      'status': 'Placement ready',
      'statusType': 'ready',
      'gap': '',
    },
    {
      'name': 'Nandini Krishnan',
      'id': '••••1014',
      'dept': 'Artificial Intelligence & Data Science',
      'quiz': '60%',
      'certs': '4',
      'aptitude': '62',
      'interview': '76',
      'resume': '86',
      'total': 75,
      'status': 'Placement ready',
      'statusType': 'ready',
      'gap': '',
    },
    {
      'name': 'Pooja Hegde',
      'id': '••••1088',
      'dept': 'Computer Science & Engineering',
      'quiz': '72%',
      'certs': '3',
      'aptitude': '70',
      'interview': '75',
      'resume': '80',
      'total': 76,
      'status': 'Placement ready',
      'statusType': 'ready',
      'gap': '',
    },
    {
      'name': 'Gokul Rao',
      'id': '••••1035',
      'dept': 'Mechanical Engineering',
      'quiz': '65%',
      'certs': '1',
      'aptitude': '55',
      'interview': '52',
      'resume': '95',
      'total': 64,
      'status': 'Almost ready',
      'statusType': 'almost',
      'gap': 'Need ≥ 2 certificates',
    },
    {
      'name': 'Kavya Menon',
      'id': '••••1008',
      'dept': 'Computer Science & Engineering',
      'quiz': '48%',
      'certs': '1',
      'aptitude': '50',
      'interview': '75',
      'resume': '89',
      'total': 55,
      'status': 'Needs work',
      'statusType': 'needswork',
      'gap': 'Quiz avg < 60%',
    },
    {
      'name': 'Joseph Patel',
      'id': '••••1021',
      'dept': 'Electronics & Communication',
      'quiz': '47%',
      'certs': '4',
      'aptitude': '45',
      'interview': '37',
      'resume': '54',
      'total': 61,
      'status': 'Needs work',
      'statusType': 'needswork',
      'gap': 'Mock interview < 50',
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
              const SizedBox(height: 12),
              _buildLiveUpdateBar(),
              const SizedBox(height: 12),
              _buildMetricCards(),
              const SizedBox(height: 16),
              _buildFormulaBanner(),
              const SizedBox(height: 18),
              _buildReadinessBoardTableCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 1)
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
            // Watermark target
            Positioned(
              right: -15,
              bottom: -25,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.track_changes_rounded,
                  size: 200,
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
                          'Placement',
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
                          'Placement Readiness Board',
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
                      // Target Icon
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.track_changes_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
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
                                    'PLACEMENT',
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
                                    color: const Color(0xFF0D9488),
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
                              'Placement Readiness Board',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Every student's readiness total, gaps and status — filter, shortlist and export for drives.",
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
  // LIVE UPDATE BAR (Screenshot 1)
  // ===========================================================================
  Widget _buildLiveUpdateBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Live · updated 02:56:05 pm',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Refreshed placement readiness indicators.',
                    style: GoogleFonts.poppins()),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.refresh_rounded,
              size: 14, color: Color(0xFF334155)),
          label: Text(
            'Refresh',
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5 STAT METRIC CARDS (Screenshot 1) - 3-Column Based
  // ===========================================================================
  Widget _buildMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 3-Column Based (with 5-col desktop support)
        final double width = constraints.maxWidth;
        final int count = width >= 1150
            ? 5
            : (width >= 400 ? 3 : 2);
        final double spacing = width < 500 ? 8.0 : 12.0;
        final double cardWidth = (width - ((count - 1) * spacing)) / count;
        final double cardHeight = width < 500 ? 80.0 : 86.0;
        final double ratio = cardWidth / cardHeight;

        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: ratio,
          children: [
            _buildStatCard('Students tracked', '14',
                Icons.people_outline_rounded, cardWidth),
            _buildStatCard('Placement ready', '3',
                Icons.check_circle_outline_rounded, cardWidth),
            _buildStatCard(
                'Almost ready', '8', Icons.hourglass_empty_rounded, cardWidth),
            _buildStatCard(
                'Needs work', '3', Icons.warning_amber_rounded, cardWidth),
            _buildStatCard(
                'Average total', '65', Icons.trending_up_rounded, cardWidth),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, double cardWidth) {
    final isCompact = cardWidth < 145;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 14,
        vertical: isCompact ? 8 : 10,
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: isCompact ? 13 : 15, color: const Color(0xFF64748B)),
              SizedBox(width: isCompact ? 4 : 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: isCompact ? 11 : 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isCompact ? 19 : 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FORMULA BANNER (Screenshot 1)
  // ===========================================================================
  Widget _buildFormulaBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF475569),
            height: 1.4,
          ),
          children: const [
            TextSpan(
              text: 'Placement ready',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            TextSpan(
              text:
                  ' = total ≥ 70, quiz average ≥ 60%, ≥ 2 certificates and mock interview ≥ 50. ',
            ),
            TextSpan(
              text: 'Total',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            TextSpan(
              text:
                  ' = quiz 35% + certificates 20% + aptitude 15% + interview 15% + resume 15%.',
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // READINESS BOARD TABLE CARD (Screenshot 1)
  // ===========================================================================
  Widget _buildReadinessBoardTableCard() {
    final filtered = _students.where((s) {
      final name = (s['name'] as String).toLowerCase();
      final dept = (s['dept'] as String).toLowerCase();
      final q = _searchQuery.toLowerCase();
      if (q.isNotEmpty && !name.contains(q) && !dept.contains(q)) return false;
      if (_selectedDeptFilter != 'All' && s['dept'] != _selectedDeptFilter) {
        return false;
      }
      if (_selectedTierFilter != 'All' && s['status'] != _selectedTierFilter) {
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
          // Header Row with Title & Export Shortlist CSV
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 180, maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Readiness board',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Roll numbers masked · export only what a drive needs',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
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
                        content: Text('Exported shortlist as CSV.',
                            style: GoogleFonts.poppins()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.file_download_outlined,
                      size: 14, color: Color(0xFF334155)),
                  label: Text(
                    'Export shortlist (CSV)',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Filters Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Search Input
                Container(
                  width: 260,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: GoogleFonts.poppins(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: 'Search student',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      prefixIcon: const Icon(Icons.search,
                          size: 16, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                    ),
                  ),
                ),
                // Dropdown 1: Dept
                _buildSmallDropdown(
                  value: _selectedDeptFilter,
                  items: [
                    'All',
                    'Computer Science & Engineering',
                    'Information Technology',
                    'Artificial Intelligence & Data Science',
                    'Electrical & Electronics',
                    'Electronics & Communication',
                    'Mechanical Engineering',
                  ],
                  onChanged: (v) => setState(() => _selectedDeptFilter = v!),
                ),
                // Dropdown 2: Tier
                _buildSmallDropdown(
                  value: _selectedTierFilter,
                  items: ['All', 'Placement ready', 'Almost ready', 'Needs work'],
                  onChanged: (v) => setState(() => _selectedTierFilter = v!),
                ),
                // Dropdown 3: Drive
                _buildSmallDropdown(
                  value: _selectedDriveFilter,
                  items: ['Any drive', 'TCS Campus Drive', 'Zoho Tech Drive', 'Cognizant GenC'],
                  onChanged: (v) => setState(() => _selectedDriveFilter = v!),
                ),
              ],
            ),
          ),

          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFAF9F6)),
              dataRowMinHeight: 58,
              dataRowMaxHeight: 68,
              horizontalMargin: 20,
              columnSpacing: 28,
              columns: [
                DataColumn(
                  label: Text('STUDENT',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('QUIZ AVG',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('CERTS',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('APTITUDE',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('INTERVIEW',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('RESUME',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('TOTAL ↓',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('STATUS',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
              ],
              rows: filtered.map((s) {
                final statusType = s['statusType'] as String;

                return DataRow(
                  cells: [
                    // Student & Dept
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            s['name'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${s['id']} · ${s['dept']}",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Quiz
                    DataCell(
                      Text(
                        s['quiz'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
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
                    // Aptitude
                    DataCell(
                      Text(
                        s['aptitude'] as String,
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
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // Resume
                    DataCell(
                      Text(
                        s['resume'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // Total with horizontal pill progress bar
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${s['total']}",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 38,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D9488),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Status
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (statusType == 'ready')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCCFBF1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Placement ready',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F766E),
                                ),
                              ),
                            )
                          else if (statusType == 'almost')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Almost ready',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFD97706),
                                  ),
                                ),
                                if ((s['gap'] as String).isNotEmpty)
                                  Text(
                                    s['gap'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Needs work',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                                if ((s['gap'] as String).isNotEmpty)
                                  Text(
                                    s['gap'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildSmallDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          style: GoogleFonts.poppins(
            fontSize: 12,
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
