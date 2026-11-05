import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT OFFICER: ALUMNI NETWORK SCREEN (Matches Images 4 & 5)
// - Blueprint grid hero banner with breadcrumbs & badges (CAMPUS LIFE, Phase 3)
// - 4 Metric KPI Stat Cards (Alumni Mentors, Available Now, Active Requests, Top Employers)
// - Tabs: "Alumni Mentors (8)" and "Mentorship Requests (0)" + "+ Add Alumni Mentor"
// - Search bar, topic dropdown, "Available only" checkbox, "Request mentorship" button
// - Tab 0: Table with Match scores & Request buttons
// - Tab 1: "No mentorship requests yet" blueprint empty state with "Browse Alumni Mentors"
// =============================================================================

class PlacementAlumniNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementAlumniNetworkScreen({super.key, this.onBack});

  @override
  State<PlacementAlumniNetworkScreen> createState() =>
      _PlacementAlumniNetworkScreenState();
}

class _PlacementAlumniNetworkScreenState
    extends State<PlacementAlumniNetworkScreen> {
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
              _buildKpiStatRow(),
              const SizedBox(height: 16),
              _buildTabAndActionHeader(),
              const SizedBox(height: 14),
              if (_selectedTab == 0) ...[
                _buildSearchAndFilters(),
                const SizedBox(height: 14),
                _buildMentorsTable(),
              ] else
                _buildMentorshipRequestsEmptyState(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. TOP HERO BANNER (Image 4)
  // ---------------------------------------------------------------------------
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
                painter: _AlumniGridPainter(),
              ),
            ),
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.chair_alt_outlined,
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
                          'Campus Life',
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
                          'Alumni Network',
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
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.chair_alt_outlined,
                          color: Color(0xFFFBBF24),
                          size: 24,
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
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'CAMPUS LIFE',
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
                              'Alumni Network',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Mentors, speakers, recruiters and project advisors matched to your goals.',
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

  // ---------------------------------------------------------------------------
  // 2. 4 METRIC STAT CARDS (Image 4)
  // ---------------------------------------------------------------------------
  Widget _buildKpiStatRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 960;
        final isMedium = constraints.maxWidth >= 540;

        final card1 = _buildStatCard(
          title: 'Alumni Mentors',
          value: '8',
          subtitle: 'Verified alumni directory',
          icon: Icons.people_outline_rounded,
          iconColor: const Color(0xFF64748B),
          valueColor: const Color(0xFF0F172A),
        );

        final card2 = _buildStatCard(
          title: 'Available Now',
          value: '8',
          subtitle: 'Taking new mentees',
          icon: Icons.person_add_outlined,
          iconColor: const Color(0xFF0D9488),
          valueColor: const Color(0xFF0D9488),
        );

        final card3 = _buildStatCard(
          title: 'Active Requests',
          value: '0',
          subtitle: '0 accepted',
          icon: Icons.chat_bubble_outline_rounded,
          iconColor: const Color(0xFF2563EB),
          valueColor: const Color(0xFF2563EB),
        );

        final card4 = _buildStatCard(
          title: 'Top Employers',
          value: 'Microsoft, Amazon, IBM',
          subtitle: 'Hiring partner alumni',
          icon: Icons.business_rounded,
          iconColor: const Color(0xFFD97706),
          valueColor: const Color(0xFF0F172A),
          isValueSmall: true,
        );

        if (isWide) {
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

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
    bool isValueSmall = false,
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
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Icon(icon, size: 16, color: iconColor),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: isValueSmall ? 13.5 : 22,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. TABS AND "+ Add Alumni Mentor" (Images 4 & 5)
  // ---------------------------------------------------------------------------
  Widget _buildTabAndActionHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;
        final tabsRow = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTabPill(
                title: 'Alumni Mentors',
                count: '8',
                isSelected: _selectedTab == 0,
                onTap: () => setState(() => _selectedTab = 0),
              ),
              const SizedBox(width: 8),
              _buildTabPill(
                title: 'Mentorship Requests',
                count: '0',
                isSelected: _selectedTab == 1,
                onTap: () => setState(() => _selectedTab = 1),
              ),
            ],
          ),
        );

        final addBtn = ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Add Alumni Mentor modal opened.',
                  style: GoogleFonts.poppins(),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.add, size: 14),
          label: Text(
            'Add Alumni Mentor',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tabsRow,
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: addBtn,
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: tabsRow),
            const SizedBox(width: 12),
            addBtn,
          ],
        );
      },
    );
  }

  Widget _buildTabPill({
    required String title,
    required String count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. SEARCH & FILTERS BAR (Image 4)
  // ---------------------------------------------------------------------------
  Widget _buildSearchAndFilters() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 680;

        final searchInput = Container(
          height: 38,
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
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                  decoration: InputDecoration(
                    hintText: 'Search alumni network...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: false,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        );

        final topicDropdown = Container(
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
              icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
              items: _topics
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedTopic = v!),
            ),
          ),
        );

        final availableCheck = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _availableOnly,
                activeColor: const Color(0xFF1E2865),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (v) => setState(() => _availableOnly = v ?? false),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Available only',
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
            ),
          ],
        );

        final requestBtn = ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Mentorship request modal opened.', style: GoogleFonts.poppins()),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: Text(
            'Request mentorship',
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchInput,
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: topicDropdown),
                  const SizedBox(width: 10),
                  availableCheck,
                ],
              ),
              const SizedBox(height: 10),
              requestBtn,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: searchInput),
            const SizedBox(width: 12),
            topicDropdown,
            const SizedBox(width: 12),
            availableCheck,
            const SizedBox(width: 12),
            requestBtn,
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 5. MENTORS TABLE (Image 4)
  // ---------------------------------------------------------------------------
  Widget _buildMentorsTable() {
    final query = _searchController.text.toLowerCase().trim();
    final list = _alumni.where((a) {
      if (_selectedTopic != 'All Topics' && a['topic'] != _selectedTopic) {
        return false;
      }
      if (_availableOnly && a['available'] != true) return false;
      if (query.isNotEmpty) {
        final name = (a['name'] as String).toLowerCase();
        final company = (a['company'] as String).toLowerCase();
        final position = (a['position'] as String).toLowerCase();
        if (!name.contains(query) &&
            !company.contains(query) &&
            !position.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 900),
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              headingTextStyle: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
              dataRowColor: WidgetStateProperty.all(Colors.white),
              horizontalMargin: 20,
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
              rows: list.map((a) {
                return DataRow(
                  cells: [
                    // ALUMNUS / MENTOR
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                a['initials'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF475569),
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
                                a['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    a['location'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.open_in_new_rounded,
                                      size: 10, color: Color(0xFF94A3B8)),
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
                        a['batch'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // CURRENT POSITION
                    DataCell(
                      Text(
                        a['position'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // COMPANY
                    DataCell(
                      Text(
                        a['company'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // CAN MENTOR IN
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: a['badgeBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          a['topic'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: a['badgeColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    // MATCH SCORE
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 65,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (a['match'] as int) / 100.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D9488),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${a['match']}%",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0D9488),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ACTION
                    DataCell(
                      OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Mentorship requested from ${a['name']}.",
                                style: GoogleFonts.poppins(),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Request',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
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
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. TAB 1: MENTORSHIP REQUESTS EMPTY STATE (Image 5)
  // ---------------------------------------------------------------------------
  Widget _buildMentorshipRequestsEmptyState() {
    return Container(
      height: 320,
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
                painter: _AlumniFaintGridPainter(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No mentorship requests yet',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Explore verified alumni mentors in the directory and request a 1-on-1 session or resume guidance.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedTab = 0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Browse Alumni Mentors',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
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
}

// Background painter for blueprint grid in top banner
class _AlumniGridPainter extends CustomPainter {
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
class _AlumniFaintGridPainter extends CustomPainter {
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
