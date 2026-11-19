import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: ALUMNI NETWORK SCREEN (Matches Images 4 & 5)
// - Screenshot 4:
//   * Blueprint Hero Banner: Home > Campus Life > Alumni Network, badges CAMPUS LIFE, Phase 3
//   * 4 KPI Stat Cards:
//       1. Alumni Mentors: 8, "Verified alumni directory"
//       2. Available Now: 8, "Taking new mentees"
//       3. Active Requests: 1, "0 accepted"
//       4. Top Employers: "Microsoft, Amazon, Zoho Corporation", "Hiring partner alumni"
//   * Tabs & Action Header:
//       - Tab 0: "Alumni Mentors 8" (active pill)
//       - Tab 1: "Mentorship Requests 1"
//       - "+ Add Alumni Mentor" primary button
//   * Filter & Search Row:
//       - Search box: "Search alumni network..."
//       - "All Topics" dropdown
//       - "Available only" checkbox
//       - "Request mentorship" button
//   * Data Table:
//       - Columns: ALUMNUS / MENTOR, BATCH, CURRENT POSITION, COMPANY, CAN MENTOR IN, MATCH SCORE, ACTION
//       - 8 Mentors: Anand Kumar, Fathima Nair, Karthik Sharma, Nikhil Sharma, Pooja Hegde, Revathi Srinivasan, Rohan Iyer, Priyadarshini Sundaram
// - Screenshot 5:
//   * "Register New Alumni Mentor" Modal:
//       - Alumnus Full Name
//       - Batch & Company (2-Column)
//       - Current Position
//       - Core Mentorship Area dropdown
//       - Skills (comma-separated)
//       - Short Bio / Background textarea
//       - Cancel & Save Alumni Mentor buttons
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

  // 8 Initial Alumni Mentors (matches Image 4)
  final List<Map<String, dynamic>> _alumni = [
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
      'initials': 'PH',
      'name': 'Pooja Hegde',
      'location': 'Chennai, India',
      'batch': 'Batch 2020',
      'position': 'Senior Frontend Engineer',
      'company': 'Zoho Corporation',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
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
    {
      'initials': 'PS',
      'name': 'Priyadarshini Sundaram',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2022',
      'position': 'Senior Software Engineer',
      'company': 'Google',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 90,
      'available': true,
    },
  ];

  // Requests list (Matches Image 2)
  final List<Map<String, dynamic>> _requests = [
    {
      'mentorName': 'Anand Kumar',
      'company': 'Microsoft',
      'status': 'Pending',
      'topic': 'Mock Interviews & System Design',
      'mode': 'Virtual Call',
      'date': '6 Nov 2026',
      'goals':
          'Preparing for technical interview, reviewing resume, and system design guidance.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredAlumni() {
    final query = _searchController.text.trim().toLowerCase();
    return _alumni.where((a) {
      final matchesQuery = query.isEmpty ||
          (a['name'] as String).toLowerCase().contains(query) ||
          (a['company'] as String).toLowerCase().contains(query) ||
          (a['position'] as String).toLowerCase().contains(query) ||
          (a['location'] as String).toLowerCase().contains(query);

      final matchesTopic =
          _selectedTopic == 'All Topics' || a['topic'] == _selectedTopic;

      final matchesAvailable = !_availableOnly || (a['available'] == true);

      return matchesQuery && matchesTopic && matchesAvailable;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1050;
          final isMedium = constraints.maxWidth >= 640;
          final horizPadding = constraints.maxWidth >= 1100
              ? 28.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 4)
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. 4 KPI STAT CARDS (Image 4)
                _buildKpiStatCards(isWide, isMedium),
                const SizedBox(height: 18),

                // 3. TABS + ADD ALUMNI MENTOR BUTTON (Image 4)
                _buildTabsAndActionHeader(constraints.maxWidth),
                const SizedBox(height: 16),

                // 4. MAIN CARD (Search, Filters, Data Table)
                _buildMainContentCard(constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Image 4)
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
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
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
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('›',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8))),
                        const SizedBox(width: 6),
                        Text(
                          'Campus Life',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('›',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8))),
                        const SizedBox(width: 6),
                        Text(
                          'Alumni Network',
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
                          color: Color(0xFFFBBF24), // Gold Armchair (Image 4)
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
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Mentors, speakers, recruiters and project advisors matched to your goals.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
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
  // 2. 4 KPI STAT CARDS (Image 4)
  // ===========================================================================
  Widget _buildKpiStatCards(bool isWide, bool isMedium) {
    final cards = [
      _buildStatCard(
        title: 'Alumni Mentors',
        value: '${_alumni.length}',
        subtext: 'Verified alumni directory',
        icon: Icons.groups_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF1E2865),
      ),
      _buildStatCard(
        title: 'Available Now',
        value: '${_alumni.where((a) => a['available'] == true).length}',
        valueColor: const Color(0xFF0D9488),
        subtext: 'Taking new mentees',
        icon: Icons.person_search_outlined,
        iconBg: const Color(0xFFE6F4F1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        title: 'Active Requests',
        value: '${_requests.length}',
        subtext: '0 accepted',
        icon: Icons.chat_bubble_outline_rounded,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF64748B),
      ),
      _buildStatCard(
        title: 'Top Employers',
        value: 'Microsoft, Amazon, Zoho Corporation',
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: c,
                  ),
                ))
            .toList(),
      );
    } else if (isMedium) {
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
    } else {
      return Column(
        children: cards
            .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: c,
                ))
            .toList(),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 15, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: valueFontSize ?? 22,
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. TABS + ADD ALUMNI MENTOR BUTTON (Image 4)
  // ===========================================================================
  Widget _buildTabsAndActionHeader(double maxWidth) {
    return LayoutBuilder(
      builder: (context, c) {
        final isNarrow = c.maxWidth < 620;

        final tabsRow = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tab 0: Alumni Mentors 8
            InkWell(
              onTap: () => setState(() => _selectedTab = 0),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                        fontWeight: FontWeight.w600,
                        color: _selectedTab == 0
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0
                            ? Colors.white.withValues(alpha: 0.25)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_alumni.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _selectedTab == 0
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Tab 1: Mentorship Requests 1
            InkWell(
              onTap: () => setState(() => _selectedTab = 1),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                        fontWeight: FontWeight.w600,
                        color: _selectedTab == 1
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1
                            ? Colors.white.withValues(alpha: 0.25)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_requests.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _selectedTab == 1
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        final addMentorBtn = ElevatedButton.icon(
          onPressed: () => _showAddMentorDialog(context),
          icon: const Icon(Icons.add_rounded, size: 15),
          label: Text(
            'Add Alumni Mentor',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E3A8C), // Navy / Indigo
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tabsRow,
              const SizedBox(height: 10),
              addMentorBtn,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            tabsRow,
            addMentorBtn,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 4. MAIN CONTENT CARD
  // ===========================================================================
  Widget _buildMainContentCard(double maxWidth) {
    if (_selectedTab == 1) {
      return _buildMentorshipRequestsTab();
    }

    final filteredAlumni = _getFilteredAlumni();

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
          // Filter & Search Row (Image 4)
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, c) {
                final isNarrow = c.maxWidth < 750;

                final searchBox = Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(fontSize: 12),
                    decoration: const InputDecoration(
                      hintText: 'Search alumni network...',
                      hintStyle:
                          TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      prefixIcon: Icon(Icons.search_rounded,
                          size: 16, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                );

                final filters = Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // All Topics dropdown
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedTopic,
                          isDense: true,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                            fontWeight: FontWeight.w500,
                          ),
                          items: _topics
                              .map((t) =>
                                  DropdownMenuItem(value: t, child: Text(t)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedTopic = v!),
                        ),
                      ),
                    ),

                    // Available only Checkbox
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
                            activeColor: const Color(0xFF1E2865),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Available only',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Request mentorship button (Image 1 & 4)
                    ElevatedButton(
                      onPressed: () {
                        _showRequestMentorshipDialog(context, _alumni.first);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2E3A8C), // Navy / Indigo
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 38),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchBox,
                      const SizedBox(height: 10),
                      filters,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: searchBox),
                    const SizedBox(width: 12),
                    filters,
                  ],
                );
              },
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Table of Alumni Mentors (Image 4)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 880),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                columnSpacing: 22,
                columns: const [
                  DataColumn(label: Text('ALUMNUS / MENTOR')),
                  DataColumn(label: Text('BATCH')),
                  DataColumn(label: Text('CURRENT POSITION')),
                  DataColumn(label: Text('COMPANY')),
                  DataColumn(label: Text('CAN MENTOR IN')),
                  DataColumn(label: Text('MATCH SCORE')),
                  DataColumn(label: Text('ACTION')),
                ],
                rows: filteredAlumni.map((a) {
                  final initials = a['initials'] as String;
                  final match = a['match'] as int;

                  return DataRow(
                    cells: [
                      // ALUMNUS / MENTOR (Initials avatar + Name + LinkedIn)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                initials,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF475569),
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
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${a['location']} · ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    Text(
                                      'LinkedIn ↗',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        color: const Color(0xFF2563EB),
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

                      // BATCH
                      DataCell(
                        Text(
                          a['batch'],
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // CURRENT POSITION
                      DataCell(
                        Text(
                          a['position'],
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // COMPANY (Bold)
                      DataCell(
                        Text(
                          a['company'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),

                      // CAN MENTOR IN (Pill)
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: a['badgeBg'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            a['topic'],
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: a['badgeColor'] as Color,
                            ),
                          ),
                        ),
                      ),

                      // MATCH SCORE (Progress bar + 85%)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: match / 100,
                                  minHeight: 5,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF0D9488)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$match%',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ACTION (Request button)
                      DataCell(
                        OutlinedButton(
                          onPressed: () =>
                              _showRequestMentorshipDialog(context, a),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E2865),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
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
  // TAB 1: MENTORSHIP REQUESTS PIPELINE (Matches Image 2)
  // ===========================================================================
  Widget _buildMentorshipRequestsTab() {
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
          // Header Row (Matches Image 2)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 640;
                final title = Text(
                  'Mentorship Requests Pipeline (${_requests.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                );
                final subtitle = Text(
                  'Status updates automatically with mentor response',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      const SizedBox(height: 4),
                      subtitle,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    title,
                    subtitle,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          if (_requests.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.inbox_outlined,
                        size: 40, color: Color(0xFF94A3B8)),
                    const SizedBox(height: 10),
                    Text(
                      'No mentorship requests in pipeline',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select an alumnus mentor from the directory to request 1-on-1 guidance.',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: _requests.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final r = _requests[idx];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 640;

                      final detailsCol = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                r['mentorName'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '(${r['company'] ?? 'Mentor'})',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  r['status'] as String? ?? 'Pending',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Topic: ${r['topic']}  •  Mode: ${r['mode'] ?? 'Virtual Call'}  •  Requested: ${r['date']}',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      );

                      final cancelBtn = OutlinedButton(
                        onPressed: () {
                          final mentorName = r['mentorName'];
                          setState(() {
                            _requests.removeAt(idx);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Mentorship request with $mentorName cancelled.'),
                              backgroundColor: const Color(0xFF0F172A),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFB91C1C),
                          side: const BorderSide(color: Color(0xFFFCA5A5)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'Cancel Request',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            detailsCol,
                            const SizedBox(height: 10),
                            cancelBtn,
                          ],
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: detailsCol),
                          const SizedBox(width: 14),
                          cancelBtn,
                        ],
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MODAL: REQUEST MENTORSHIP (Matches Image 1)
  // ===========================================================================
  void _showRequestMentorshipDialog(
      BuildContext context, Map<String, dynamic> a) {
    final List<String> topics = [
      'Mock Interviews & System Design',
      'Placement Prep',
      'Resume Review & Startups',
      'ML & Analytics Career Guidance',
      'Core Engineering & Hardware',
    ];
    String selectedTopic = topics.contains(a['topic'])
        ? a['topic'] as String
        : 'Mock Interviews & System Design';

    final List<String> modes = [
      'Virtual Call',
      'In-person / Campus',
      'Email / Async Review',
    ];
    String selectedMode = modes[0];

    final goalsCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Request Mentorship with ${a['name']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(dialogCtx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.close_rounded,
                                    size: 20, color: Color(0xFF64748B)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Mentor Info Card (Image 1: beige/off-white background)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBF8F2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFF1EDE4)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${a['position']} at ${a['company']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${a['batch']} • B.E. Computer Science & Engineering',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Mentorship Topic Dropdown
                        Text(
                          'Mentorship Topic',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedTopic,
                              isExpanded: true,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF0F172A),
                              ),
                              items: topics
                                  .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t,
                                          overflow: TextOverflow.ellipsis)))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => selectedTopic = v);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Preferred Mode Dropdown
                        Text(
                          'Preferred Mode',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedMode,
                              isExpanded: true,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF0F172A),
                              ),
                              items: modes
                                  .map((m) => DropdownMenuItem(
                                      value: m,
                                      child: Text(m,
                                          overflow: TextOverflow.ellipsis)))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => selectedMode = v);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Specific Questions or Goals
                        Text(
                          'Specific Questions or Goals',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: goalsCtrl,
                          maxLines: 4,
                          style: GoogleFonts.poppins(
                              fontSize: 12.5, color: const Color(0xFF0F172A)),
                          decoration: InputDecoration(
                            hintText:
                                'Share your goals (e.g. preparing for technical interview, reviewing resume, or transitioning to data science)...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xFF1E2865), width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Disclaimer Note Box (Image 1)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            '✓ Once submitted, your request is forwarded to the mentor and saved in your institution\'s alumni mentorship pipeline.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Action Buttons: Cancel & Send Request
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(dialogCtx),
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 11),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                final goals = goalsCtrl.text.trim();
                                setState(() {
                                  _requests.insert(0, {
                                    'mentorName': a['name'],
                                    'company': a['company'],
                                    'status': 'Pending',
                                    'topic': selectedTopic,
                                    'mode': selectedMode,
                                    'date': '6 Nov 2026',
                                    'goals': goals.isNotEmpty
                                        ? goals
                                        : 'Mock interviews and technical architecture guidance.',
                                  });
                                  _selectedTab =
                                      1; // Auto-switch to Mentorship Requests tab
                                });
                                Navigator.pop(dialogCtx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Mentorship request sent to ${a['name']}!'),
                                    backgroundColor: const Color(0xFF0F172A),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E3A8C),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 11),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Send Request',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
  // MODAL: REGISTER NEW ALUMNI MENTOR (Image 5)
  // ===========================================================================
  void _showAddMentorDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final batchCtrl = TextEditingController(text: 'Batch 2022');
    final companyCtrl = TextEditingController();
    final positionCtrl = TextEditingController();

    final areas = [
      'Placement Prep',
      'Mock Interviews & System Design',
      'Resume Review & Startups',
      'ML & Analytics Career Guidance',
    ];
    String selectedArea = areas[0];

    final skillsCtrl = TextEditingController();
    final bioCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modal Header (Image 5)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Register New Alumni Mentor',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(dialogCtx),
                              child: const Icon(Icons.close_rounded,
                                  size: 18, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Alumnus Full Name
                        _buildFieldLabel('Alumnus Full Name'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: nameCtrl,
                          hintText: 'e.g. Priyadarshini Sundaram',
                        ),
                        const SizedBox(height: 14),

                        // 2-Column: Batch and Company
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 420;

                            final batchField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Batch'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: batchCtrl,
                                  hintText: 'Batch 2022',
                                ),
                              ],
                            );

                            final companyField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Company'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: companyCtrl,
                                  hintText: 'e.g. Google',
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  batchField,
                                  const SizedBox(height: 12),
                                  companyField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: batchField),
                                const SizedBox(width: 12),
                                Expanded(child: companyField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // Current Position
                        _buildFieldLabel('Current Position'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: positionCtrl,
                          hintText: 'e.g. Senior Software Engineer',
                        ),
                        const SizedBox(height: 14),

                        // Core Mentorship Area
                        _buildFieldLabel('Core Mentorship Area'),
                        const SizedBox(height: 6),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedArea,
                              isDense: true,
                              isExpanded: true,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF1E293B),
                              ),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 16),
                              items: areas
                                  .map((a) => DropdownMenuItem(
                                        value: a,
                                        child: Text(a,
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => selectedArea = v);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Skills (comma-separated)
                        _buildFieldLabel('Skills (comma-separated)'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: skillsCtrl,
                          hintText:
                              'e.g. Python, Machine Learning, AWS, System Design',
                        ),
                        const SizedBox(height: 14),

                        // Short Bio / Background
                        _buildFieldLabel('Short Bio / Background'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: bioCtrl,
                          maxLines: 3,
                          style: GoogleFonts.poppins(fontSize: 12),
                          decoration: InputDecoration(
                            hintText: 'Brief bio about their career journey...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Action buttons: Cancel / Save Alumni Mentor (Image 5)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(dialogCtx),
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                final name = nameCtrl.text.trim().isEmpty
                                    ? 'Priyadarshini Sundaram'
                                    : nameCtrl.text.trim();
                                final company = companyCtrl.text.trim().isEmpty
                                    ? 'Google'
                                    : companyCtrl.text.trim();
                                final pos = positionCtrl.text.trim().isEmpty
                                    ? 'Senior Software Engineer'
                                    : positionCtrl.text.trim();
                                final batch = batchCtrl.text.trim().isEmpty
                                    ? 'Batch 2022'
                                    : batchCtrl.text.trim();

                                final initials = name
                                    .split(' ')
                                    .where((p) => p.isNotEmpty)
                                    .take(2)
                                    .map((p) => p[0].toUpperCase())
                                    .join();

                                setState(() {
                                  _alumni.insert(0, {
                                    'initials':
                                        initials.isEmpty ? 'AL' : initials,
                                    'name': name,
                                    'location': 'Bengaluru, India',
                                    'batch': batch,
                                    'position': pos,
                                    'company': company,
                                    'topic': selectedArea,
                                    'badgeColor': const Color(0xFF0D9488),
                                    'badgeBg': const Color(0xFFCCFBF1),
                                    'match': 85,
                                    'available': true,
                                  });
                                });

                                Navigator.pop(dialogCtx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Alumni Mentor "$name" registered successfully!',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2E3A8C), // Navy / Indigo
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              child: Text(
                                'Save Alumni Mentor',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF334155),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 12),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
      ),
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
