import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: ALUMNI NETWORK SCREEN (Matches Image 5)
// - Blueprint Hero Banner: "Home > Campus Life > Alumni Network", badges CAMPUS LIFE, Phase 3
// - 4 KPI Stat Cards: Alumni Mentors (8), Available Now (8), Active Requests (0), Top Employers (Microsoft, Amazon, IBM)
// - Tabs & Action Header: "Alumni Mentors 8", "Mentorship Requests 0" + "+ Add Alumni Mentor"
// - Filter & Search Row: Search box, All Topics dropdown, "Available only" checkbox, "Request mentorship" button
// - Table: ALUMNUS / MENTOR, BATCH, CURRENT POSITION, COMPANY, CAN MENTOR IN, MATCH SCORE (progress bar 85%), ACTION (Request)
// =============================================================================

class IncubationAlumniNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IncubationAlumniNetworkScreen({super.key, this.onBack});

  @override
  State<IncubationAlumniNetworkScreen> createState() =>
      _IncubationAlumniNetworkScreenState();
}

class _IncubationAlumniNetworkScreenState
    extends State<IncubationAlumniNetworkScreen> {
  int _selectedTab = 0; // 0: Alumni Mentors, 1: Mentorship Requests
  final TextEditingController _searchController = TextEditingController();
  String _selectedTopic = 'All Topics';
  bool _availableOnly = false;

  final List<String> _topics = [
    'All Topics',
    'Placement Prep',
    'Mock Interviews & System Design',
    'Resume Review & Startups',
    'ML & Analytics Career Guidance',
  ];

  final List<Map<String, dynamic>> _alumni = [
    {
      'initials': 'KS',
      'name': 'Karthik Sharma',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2021',
      'position': 'System Analyst',
      'company': 'Microsoft',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'AK',
      'name': 'Anand Kumar',
      'location': 'Hyderabad, India',
      'batch': 'Batch 2019',
      'position': 'Tech Lead',
      'company': 'Microsoft',
      'topic': 'Mock Interviews & System Design',
      'badgeColor': const Color(0xFF7C3AED),
      'badgeBg': const Color(0xFFEDE9FE),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'NS',
      'name': 'Nikhil Sharma',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2021',
      'position': 'Data Scientist',
      'company': 'Amazon',
      'topic': 'Resume Review & Startups',
      'badgeColor': const Color(0xFFD97706),
      'badgeBg': const Color(0xFFFEF3C7),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'FN',
      'name': 'Fathima Nair',
      'location': 'Chennai, India',
      'batch': 'Batch 2021',
      'position': 'Product Manager',
      'company': 'Amazon',
      'topic': 'ML & Analytics Career Guidance',
      'badgeColor': const Color(0xFF2563EB),
      'badgeBg': const Color(0xFFEFF6FF),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'RS',
      'name': 'Revathi Srinivasan',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2019',
      'position': 'Tech Lead',
      'company': 'IBM',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'RI',
      'name': 'Rohan Iyer',
      'location': 'Bengaluru / Singapore',
      'batch': 'Batch 2022',
      'position': 'Data Scientist',
      'company': 'Google',
      'topic': 'ML & Analytics Career Guidance',
      'badgeColor': const Color(0xFF2563EB),
      'badgeBg': const Color(0xFFEFF6FF),
      'match': 85,
      'available': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1050;
          final isMedium = constraints.maxWidth >= 720;
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 5)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. 4 KPI STAT CARDS (Image 5)
                _buildKpiStatCards(isWide, isMedium),
                const SizedBox(height: 20),

                // 3. TABS + ADD ALUMNI MENTOR BUTTON (Image 5)
                _buildTabsAndActionHeader(constraints.maxWidth),
                const SizedBox(height: 18),

                // 4. TAB CONTENT
                if (_selectedTab == 0)
                  _buildAlumniDirectoryTab(constraints.maxWidth)
                else
                  _buildMentorshipRequestsTab(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF273680)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Decorative outline armchair silhouette on right (Image 5)
            Positioned(
              right: 20,
              top: 8,
              bottom: 8,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.chair_rounded,
                  size: 96,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs & Back
                  Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        'Campus Life',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        'Alumni Network',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Badges: CAMPUS LIFE, Phase 3
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          'CAMPUS LIFE',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706),
                          borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(height: 12),

                  // Icon + Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Icon(
                          Icons.chair_rounded,
                          color: Color(0xFFFBBF24), // Gold Armchair (Image 5)
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alumni Network',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Mentors, speakers, recruiters and project advisors matched to your goals.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
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
  // 2. 4 KPI STAT CARDS (Image 5)
  // ===========================================================================
  Widget _buildKpiStatCards(bool isWide, bool isMedium) {
    final cards = [
      _buildStatCard(
        title: 'Alumni Mentors',
        value: '8',
        subtext: 'Verified alumni directory',
        icon: Icons.groups_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF1E2865),
      ),
      _buildStatCard(
        title: 'Available Now',
        value: '8',
        valueColor: const Color(0xFF0D9488),
        subtext: 'Taking new mentees',
        icon: Icons.person_search_outlined,
        iconBg: const Color(0xFFE6F4F1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        title: 'Active Requests',
        value: '0',
        subtext: '0 accepted',
        icon: Icons.chat_bubble_outline_rounded,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF64748B),
      ),
      _buildStatCard(
        title: 'Top Employers',
        value: 'Microsoft, Amazon, IBM',
        valueFontSize: 13.5,
        subtext: 'Hiring partner alumni',
        icon: Icons.apartment_rounded,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
      ),
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: c,
                  ),
                ))
            .toList(),
      );
    } else {
      // 2 columns, 2 rows (2x2 grid)
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 10),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 10),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    double? valueFontSize,
    Color? valueColor,
    required String subtext,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
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
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: valueFontSize ?? 24,
              fontWeight: FontWeight.w700,
              color: valueColor ?? const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. TABS + ADD ALUMNI MENTOR BUTTON (Image 5)
  // ===========================================================================
  Widget _buildTabsAndActionHeader(double screenWidth) {
    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tab 0: Alumni Mentors (8)
          InkWell(
            onTap: () => setState(() => _selectedTab = 0),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: _selectedTab == 0
                    ? const Color(0xFF1E2865)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    'Alumni Mentors',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight:
                          _selectedTab == 0 ? FontWeight.w600 : FontWeight.w500,
                      color: _selectedTab == 0
                          ? Colors.white
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: _selectedTab == 0
                          ? Colors.white.withValues(alpha: 0.2)
                          : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '8',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _selectedTab == 0
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Tab 1: Mentorship Requests (0)
          InkWell(
            onTap: () => setState(() => _selectedTab = 1),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: _selectedTab == 1
                    ? const Color(0xFF1E2865)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    'Mentorship Requests',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight:
                          _selectedTab == 1 ? FontWeight.w600 : FontWeight.w500,
                      color: _selectedTab == 1
                          ? Colors.white
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '0',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final addMentorBtn = ElevatedButton.icon(
      onPressed: () => _showAddMentorDialog(context),
      icon: const Icon(Icons.add_rounded, size: 15),
      label: Text(
        'Add Alumni Mentor',
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E2865), // Navy
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    if (screenWidth < 600) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tabs,
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerRight, child: addMentorBtn),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: tabs),
        addMentorBtn,
      ],
    );
  }

  // ===========================================================================
  // 4. TAB 0: ALUMNI DIRECTORY TABLE (Image 5)
  // ===========================================================================
  Widget _buildAlumniDirectoryTab(double screenWidth) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter Controls: Search box, All Topics, Available only, Request mentorship
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 10,
              children: [
                // Search box
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth >= 640 ? 340 : double.infinity,
                  ),
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: const InputDecoration(
                        hintText: 'Search alumni network...',
                        hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 16, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ),

                // Right Filter controls
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // All Topics Dropdown
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedTopic,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                            fontWeight: FontWeight.w500,
                          ),
                          items: _topics
                              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedTopic = v!),
                        ),
                      ),
                    ),

                    // Available only checkbox (Image 5)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _availableOnly,
                            onChanged: (v) =>
                                setState(() => _availableOnly = v ?? false),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Available only',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),

                    // Request mentorship button (Image 5)
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Request Mentorship dialog opened.',
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Request mentorship',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Data Table with Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 920),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                dataRowMinHeight: 64,
                dataRowMaxHeight: 70,
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text('ALUMNUS / MENTOR')),
                  DataColumn(label: Text('BATCH')),
                  DataColumn(label: Text('CURRENT POSITION')),
                  DataColumn(label: Text('COMPANY')),
                  DataColumn(label: Text('CAN MENTOR IN')),
                  DataColumn(label: Text('MATCH SCORE')),
                  DataColumn(label: Text('ACTION')),
                ],
                rows: _alumni.map((a) {
                  return DataRow(
                    cells: [
                      // Alumnus name + location + LinkedIn link
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  a['initials'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  a['name'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      a['location'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'LinkedIn ↗',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF1E2865),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Batch
                      DataCell(
                        Text(
                          a['batch'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Current Position
                      DataCell(
                        Text(
                          a['position'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Company (Bold)
                      DataCell(
                        Text(
                          a['company'],
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),

                      // Can Mentor In Badge
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 3),
                          decoration: BoxDecoration(
                            color: a['badgeBg'] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            a['topic'],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: a['badgeColor'] as Color,
                            ),
                          ),
                        ),
                      ),

                      // Match Score Progress Bar (Image 5)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: const LinearProgressIndicator(
                                  value: 0.85,
                                  backgroundColor: Color(0xFFE2E8F0),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF0D9488), // Teal progress bar
                                  ),
                                  minHeight: 5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '85%',
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0D9488),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action button: Request (Image 5)
                      DataCell(
                        OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Mentorship request sent to ${a['name']}',
                                  style: GoogleFonts.poppins(),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E2865),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            minimumSize: const Size(0, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Request',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
  // 5. TAB 1: MENTORSHIP REQUESTS EMPTY STATE
  // ===========================================================================
  Widget _buildMentorshipRequestsTab() {
    return Container(
      constraints: const BoxConstraints(minHeight: 360),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 44,
              color: Color(0xFF94A3B8),
            ),
            const SizedBox(height: 14),
            Text(
              'No mentorship requests yet',
              style: GoogleFonts.poppins(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Text(
                'Browse verified alumni mentors and connect with seasoned founders, tech leads and industry specialists.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _selectedTab = 0),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Browse Alumni Mentors',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // DIALOG: ADD ALUMNI MENTOR
  // ===========================================================================
  void _showAddMentorDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final companyCtrl = TextEditingController();
    final topicCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_add_alt_1_outlined,
                    color: Color(0xFF1E2865), size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Add Alumni Mentor',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: companyCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Company & Designation',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: topicCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mentorship Specialization / Domain',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Alumni Mentor added successfully!',
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Mentor'),
            ),
          ],
        );
      },
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
