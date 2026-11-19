import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: HACKATHON HUB SCREEN (Matches Images 1, 2, 3)
// - Screenshot 1:
//   * Blueprint Hero Banner: Home > Project & Innovation > Hackathon Hub, badges PROJECT & INNOVATION, Phase 3
//   * 4 KPI Stat Cards:
//       1. TOTAL HACKATHONS: 3, "National & campus buildathons", Trophy icon
//       2. REGISTERED TEAMS: 84, "Live student team entries", People icon
//       3. REGISTERED TEAMS: 0, "Stored in PostgreSQL database", Shield icon
//       4. OPEN REGISTRATIONS: 2, "Accepting team applications", Calendar icon
//   * White Card Container:
//       - Tabs: All Hackathons | Registered Teams
//       - Search: "Search hackathon hub..."
//       - Filter dropdown: funnel icon + All
//       - Export CSV button
//       - "+ Register team" primary button
//       - Table: HACKATHON, ORGANIZING BODY, DATE, REGISTERED TEAMS, STATUS, ACTION (Register team)
//       - Pagination footer: Showing 1–3 of 3 records, Rows: 10 ▾, Page 1 of 1, < >
// - Screenshot 2:
//   * "Register Hackathon Team" Modal:
//       - Sparkle icon, "Register Hackathon Team", "Official campus team entry recorded directly into PostgreSQL database."
//       - TARGET HACKATHON * dropdown
//       - TEAM NAME * and TEAM SIZE (MEMBERS) * (2-Column)
//       - TEAM LEAD NAME * and ROLL NO / STUDENT ID (2-Column)
//       - LEAD EMAIL and INNOVATION DOMAIN / TRACK * dropdown (2-Column)
//       - TEAM MEMBER NAMES
//       - PROBLEM STATEMENT / PROJECT CONCEPT * (textarea)
//       - GITHUB REPO / PROTOTYPE LINK
//       - Cancel and Register Team buttons
// - Screenshot 3:
//   * "Registered Teams" Tab:
//       - Empty state with < > icon, "No registered teams yet", description, "+ Register team" button
//       - When teams exist: dynamic interactive registered teams list
// =============================================================================

class IncubationHackathonHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IncubationHackathonHubScreen({super.key, this.onBack});

  @override
  State<IncubationHackathonHubScreen> createState() =>
      _IncubationHackathonHubScreenState();
}

class _IncubationHackathonHubScreenState
    extends State<IncubationHackathonHubScreen> {
  int _selectedTab = 0; // 0: All Hackathons, 1: Registered Teams
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _hackathons = [
    {
      'title': 'Smart India Hackathon 2026',
      'domain': 'National Innovation',
      'organizingBody': 'AICTE & MoE',
      'date': 'Nov 15–16',
      'registeredTeams': 24,
      'status': 'Open',
      'statusBg': const Color(0xFFDCFCE7),
      'statusColor': const Color(0xFF15803D),
    },
    {
      'title': 'Campus AI Buildathon',
      'domain': 'AI & Machine Learning',
      'organizingBody': 'Computer Science & Engineering & Incubation Cell',
      'date': 'Oct 28',
      'registeredTeams': 18,
      'status': 'Active',
      'statusBg': const Color(0xFFE0F2FE),
      'statusColor': const Color(0xFF0369A1),
    },
    {
      'title': 'Tamil Nadu State Student Innovation Challenge',
      'domain': 'Startup & GovTech',
      'organizingBody': 'TANSIM',
      'date': 'Dec 05',
      'registeredTeams': 42,
      'status': 'Upcoming',
      'statusBg': const Color(0xFFFEF3C7),
      'statusColor': const Color(0xFFB45309),
    },
  ];

  // User Registered Teams (Matches Image 1)
  final List<Map<String, dynamic>> _registeredTeams = [
    {
      'teamName': 'NeuralSentinels',
      'hackathon': 'Smart India Hackathon 2026',
      'status': 'Registered',
      'statusColor': const Color(0xFF15803D),
      'statusBg': const Color(0xFFDCFCE7),
      'problem':
          'AI-powered drone surveillance and anomaly detection for disaster management pipelines.',
      'lead': 'Karthik Iyer (2022-CSE-045)',
      'members':
          '6 students — Karthik Iyer, Sneha Varma, Rohan Das, Priya K., Anish M., Kavya S.',
      'track': 'National Innovation',
      'repo': 'Repository / Demo Link',
      'date': '10/14/2026',
    },
    {
      'teamName': 'AgentCraft Labs',
      'hackathon': 'Campus AI Buildathon',
      'status': 'Shortlisted',
      'statusColor': const Color(0xFF0369A1),
      'statusBg': const Color(0xFFE0F2FE),
      'problem':
          'Multi-agent autonomous diagnostic copilots for clinical triage and OPD patient workflow routing.',
      'lead': 'Kavya Krishnan (2023-AIDS-012)',
      'members':
          '4 students — Kavya Krishnan, Rahul Nair, Swetha R., Bhuvanesh P.',
      'track': 'AI & Machine Learning',
      'repo': 'Repository / Demo Link',
      'date': '10/18/2026',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredHackathons() {
    final query = _searchController.text.trim().toLowerCase();
    return _hackathons.where((h) {
      final matchesQuery = query.isEmpty ||
          (h['title'] as String).toLowerCase().contains(query) ||
          (h['domain'] as String).toLowerCase().contains(query) ||
          (h['organizingBody'] as String).toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == 'All' ||
          (h['status'] as String).toLowerCase() == _selectedFilter.toLowerCase();

      return matchesQuery && matchesFilter;
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
                // 1. HERO BLUEPRINT BANNER (Image 1)
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. 4 KPI STAT CARDS (Image 1)
                _buildKpiStatCards(isWide, isMedium),
                const SizedBox(height: 18),

                // 3. MAIN WHITE CONTAINER (Enclosing Tabs, Controls & Table)
                _buildMainCard(constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Image 1)
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
              right: 18,
              top: 10,
              bottom: 10,
              child: Opacity(
                opacity: 0.08,
                child: Center(
                  child: Text(
                    '{ }',
                    style: GoogleFonts.firaCode(
                      fontSize: 100,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  ),
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
                          'Project & Innovation',
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
                          'Hackathon Hub',
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

                  // Badges: PROJECT & INNOVATION, Phase 3
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
                          'PROJECT & INNOVATION',
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

                  // Icon (< >) + Title & Subtitle
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
                        child: Center(
                          child: Text(
                            '< >',
                            style: GoogleFonts.firaCode(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFBBF24), // Amber/Yellow
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hackathon Hub',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Upcoming hackathons, teams, problem statements and results.',
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
  // 2. 4 KPI STAT CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiStatCards(bool isWide, bool isMedium) {
    final cards = [
      _buildStatCard(
        header: 'TOTAL HACKATHONS',
        value: '${_hackathons.length}',
        subtext: 'National & campus buildathons',
        icon: Icons.emoji_events_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF6366F1),
      ),
      _buildStatCard(
        header: 'REGISTERED TEAMS',
        value: '84',
        subtext: 'Live student team entries',
        icon: Icons.groups_outlined,
        iconBg: const Color(0xFFE6F4F1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        header: 'REGISTERED TEAMS',
        value: '${_registeredTeams.length}',
        subtext: 'Stored in PostgreSQL database',
        icon: Icons.shield_outlined,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
      ),
      _buildStatCard(
        header: 'OPEN REGISTRATIONS',
        value: '2',
        subtext: 'Accepting team applications',
        icon: Icons.calendar_today_outlined,
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
    required String header,
    required String value,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  header,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(width: 6),
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
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN CARD (Tabs + Controls + Content)
  // ===========================================================================
  Widget _buildMainCard(double maxWidth) {
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
          // A. Tabs Header (All Hackathons | Registered Teams) (Image 1 & 3)
          _buildTabBar(),

          // B. Content
          if (_selectedTab == 0)
            _buildAllHackathonsContent(maxWidth)
          else
            _buildRegisteredTeamsContent(maxWidth),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildTabItem(0, 'All Hackathons'),
            const SizedBox(width: 16),
            _buildTabItem(1, 'Registered Teams'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF1E2865), width: 2.5),
                )
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color:
                isSelected ? const Color(0xFF1E2865) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: ALL HACKATHONS (Image 1)
  // ===========================================================================
  Widget _buildAllHackathonsContent(double maxWidth) {
    final filtered = _getFilteredHackathons();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Controls Row: Search + All dropdown + Export CSV + Register team
        Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 680;

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
                    hintText: 'Search hackathon hub...',
                    hintStyle:
                        TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    prefixIcon: Icon(Icons.search_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              );

              final rightActions = Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Filter dropdown
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.filter_list_rounded,
                            size: 15, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedFilter,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF334155),
                              fontWeight: FontWeight.w500,
                            ),
                            items: ['All', 'Open', 'Active', 'Upcoming']
                                .map((f) => DropdownMenuItem(
                                    value: f, child: Text(f)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedFilter = v!),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Export CSV
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Exporting hackathons list to CSV...',
                              style: GoogleFonts.poppins()),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 14),
                    label: Text(
                      'Export CSV',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      minimumSize: const Size(0, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  // + Register team button (Image 1)
                  ElevatedButton.icon(
                    onPressed: () => _showRegisterTeamDialog(context),
                    icon: const Icon(Icons.add_rounded, size: 15),
                    label: Text(
                      'Register team',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A8C), // Navy / Indigo
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(0, 38),
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
                    searchBox,
                    const SizedBox(height: 10),
                    rightActions,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: searchBox),
                  const SizedBox(width: 12),
                  rightActions,
                ],
              );
            },
          ),
        ),

        const Divider(height: 1, color: Color(0xFFE2E8F0)),

        // Data Table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 860),
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
              columnSpacing: 24,
              columns: const [
                DataColumn(label: Text('HACKATHON')),
                DataColumn(label: Text('ORGANIZING BODY')),
                DataColumn(label: Text('DATE')),
                DataColumn(label: Text('REGISTERED TEAMS')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: filtered.map((h) {
                return DataRow(
                  cells: [
                    // HACKATHON
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            h['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            h['domain'],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ORGANIZING BODY
                    DataCell(
                      Text(
                        h['organizingBody'],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),

                    // DATE
                    DataCell(
                      Text(
                        h['date'],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),

                    // REGISTERED TEAMS
                    DataCell(
                      Text(
                        '${h['registeredTeams']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),

                    // STATUS
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: h['statusBg'] as Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          h['status'],
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: h['statusColor'] as Color,
                          ),
                        ),
                      ),
                    ),

                    // ACTION (Register team button)
                    DataCell(
                      OutlinedButton(
                        onPressed: () => _showRegisterTeamDialog(
                            context, hackathonTitle: h['title']),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1E2865),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          minimumSize: const Size(0, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Register team',
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

        const Divider(height: 1, color: Color(0xFFE2E8F0)),

        // Pagination Footer (Image 1)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                'Showing 1–${filtered.length} of ${filtered.length} records',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rows:  ',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      '10 ▾',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Page 1 of 1',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.chevron_left_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.chevron_right_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 1: REGISTERED TEAMS (Image 3)
  // ===========================================================================
  Widget _buildRegisteredTeamsContent(double maxWidth) {
    if (_registeredTeams.isEmpty) {
      return Container(
        constraints: const BoxConstraints(minHeight: 340),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Centered "< >" icon (Image 3)
              Text(
                '< >',
                style: GoogleFonts.firaCode(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 12),

              // Empty state title
              Text(
                'No registered teams yet',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),

              // Empty state subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Text(
                  'You haven\'t registered any team for upcoming hackathons. Join an active hackathon to build your innovation portfolio.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // "+ Register team" button (Image 3)
              ElevatedButton.icon(
                onPressed: () => _showRegisterTeamDialog(context),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(
                  'Register team',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3A8C), // Navy
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // When teams exist, display registered teams cards (Matches Image 1)
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMultiCol = constraints.maxWidth >= 820;

          Widget buildTeamCard(Map<String, dynamic> team) {
            return Container(
              padding: const EdgeInsets.all(18),
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
                  // Header Row: Team Name & Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          team['teamName'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: team['statusBg'] as Color? ??
                              const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          team['status'] as String? ?? 'Registered',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: team['statusColor'] as Color? ??
                              const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // Hackathon Subtitle
                  Text(
                    team['hackathon'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Problem / Project
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'Problem / Project: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(text: team['problem'] as String),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Lead
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                      ),
                      children: [
                        TextSpan(
                          text: 'Lead: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(text: team['lead'] as String),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Members
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                      ),
                      children: [
                        TextSpan(
                          text: 'Members: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(text: team['members'] as String),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Track
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                      ),
                      children: [
                        TextSpan(
                          text: 'Track: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(text: team['track'] as String),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Repository / Demo Link
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Opening ${team['teamName']} repository/demo link...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.open_in_new_rounded,
                            size: 13, color: Color(0xFF2563EB)),
                        const SizedBox(width: 4),
                        Text(
                          'Repository / Demo Link',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2563EB),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 10),

                  // Bottom Row: Date & Delete Team
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registered ${team['date']}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final tName = team['teamName'];
                          setState(() {
                            _registeredTeams.remove(team);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Team "$tName" deleted.'),
                              backgroundColor: const Color(0xFF0F172A),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.delete_outline_rounded,
                                  size: 14, color: Color(0xFFDC2626)),
                              const SizedBox(width: 4),
                              Text(
                                'Delete Team',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFDC2626),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          if (isMultiCol) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _registeredTeams
                  .map((t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: buildTeamCard(t),
                        ),
                      ))
                  .toList(),
            );
          }

          return Column(
            children: _registeredTeams
                .map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildTeamCard(t),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // MODAL: REGISTER HACKATHON TEAM (Image 2)
  // ===========================================================================
  void _showRegisterTeamDialog(BuildContext context, {String? hackathonTitle}) {
    final hackathonOptions = [
      'Smart India Hackathon 2026 (Open — Nov 15–16)',
      'Campus AI Buildathon (Active — Oct 28)',
      'Tamil Nadu State Student Innovation Challenge (Upcoming — Dec 05)',
    ];

    String selectedHackathon = hackathonOptions[0];
    if (hackathonTitle != null) {
      final match = hackathonOptions.firstWhere(
        (h) => h.contains(hackathonTitle.split(' ').take(3).join(' ')),
        orElse: () => hackathonOptions[0],
      );
      selectedHackathon = match;
    }

    final teamNameCtrl = TextEditingController();
    final teamSizeCtrl = TextEditingController(text: '4');
    final leadNameCtrl = TextEditingController();
    final rollNoCtrl = TextEditingController();
    final leadEmailCtrl = TextEditingController(text: 'lead@college.edu');

    final domains = [
      'AI & Machine Learning',
      'Web3 & Blockchain',
      'Smart Automation / IoT',
      'Healthcare & MedTech',
      'FinTech & GovTech',
      'CleanTech & Sustainability',
    ];
    String selectedDomain = domains[0];

    final memberNamesCtrl = TextEditingController();
    final problemConceptCtrl = TextEditingController();
    final repoLinkCtrl =
        TextEditingController(text: 'https://github.com/team/project');

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
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header (Image 2)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.auto_awesome_rounded,
                                size: 18,
                                color: Color(0xFF4338CA),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Register Hackathon Team',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Official campus team entry recorded directly into PostgreSQL database.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
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

                        // TARGET HACKATHON *
                        _buildFieldLabel('TARGET HACKATHON *'),
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
                              value: selectedHackathon,
                              isDense: true,
                              isExpanded: true,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF1E293B),
                              ),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 16),
                              items: hackathonOptions
                                  .map((h) => DropdownMenuItem(
                                        value: h,
                                        child: Text(h,
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => selectedHackathon = v);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // 2-Column: TEAM NAME * and TEAM SIZE (MEMBERS) *
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 420;

                            final teamNameField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('TEAM NAME *'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: teamNameCtrl,
                                  hintText: 'e.g. Neural Knights',
                                ),
                              ],
                            );

                            final teamSizeField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('TEAM SIZE (MEMBERS) *'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: teamSizeCtrl,
                                  hintText: '4',
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  teamNameField,
                                  const SizedBox(height: 12),
                                  teamSizeField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: teamNameField),
                                const SizedBox(width: 12),
                                Expanded(child: teamSizeField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // 2-Column: TEAM LEAD NAME * and ROLL NO / STUDENT ID
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 420;

                            final leadNameField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('TEAM LEAD NAME *'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: leadNameCtrl,
                                  hintText: 'e.g. Bala Kumar',
                                ),
                              ],
                            );

                            final rollNoField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('ROLL NO / STUDENT ID'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: rollNoCtrl,
                                  hintText: 'e.g. 23CS104',
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  leadNameField,
                                  const SizedBox(height: 12),
                                  rollNoField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: leadNameField),
                                const SizedBox(width: 12),
                                Expanded(child: rollNoField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // 2-Column: LEAD EMAIL and INNOVATION DOMAIN / TRACK *
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 420;

                            final emailField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('LEAD EMAIL'),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: leadEmailCtrl,
                                  hintText: 'lead@college.edu',
                                ),
                              ],
                            );

                            final domainField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('INNOVATION DOMAIN / TRACK *'),
                                const SizedBox(height: 6),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFCBD5E1)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedDomain,
                                      isDense: true,
                                      isExpanded: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFF1E293B),
                                      ),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 16),
                                      items: domains
                                          .map((d) => DropdownMenuItem(
                                                value: d,
                                                child: Text(d,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ))
                                          .toList(),
                                      onChanged: (v) {
                                        if (v != null) {
                                          setDialogState(
                                              () => selectedDomain = v);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  emailField,
                                  const SizedBox(height: 12),
                                  domainField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: emailField),
                                const SizedBox(width: 12),
                                Expanded(child: domainField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // TEAM MEMBER NAMES
                        _buildFieldLabel('TEAM MEMBER NAMES'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: memberNamesCtrl,
                          hintText: 'e.g. Anand K., Priya S., Rahul M.',
                        ),
                        const SizedBox(height: 14),

                        // PROBLEM STATEMENT / PROJECT CONCEPT *
                        _buildFieldLabel(
                            'PROBLEM STATEMENT / PROJECT CONCEPT *'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: problemConceptCtrl,
                          maxLines: 3,
                          style: GoogleFonts.poppins(fontSize: 12),
                          decoration: InputDecoration(
                            hintText:
                                'Describe the problem statement you are solving or your project idea...',
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
                        const SizedBox(height: 14),

                        // GITHUB REPO / PROTOTYPE LINK
                        _buildFieldLabel('GITHUB REPO / PROTOTYPE LINK'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: repoLinkCtrl,
                          hintText: 'https://github.com/team/project',
                        ),
                        const SizedBox(height: 20),

                        // Action buttons: Cancel / Register Team (Image 2)
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
                                final tName = teamNameCtrl.text.trim().isEmpty
                                    ? 'Neural Knights'
                                    : teamNameCtrl.text.trim();
                                final lName = leadNameCtrl.text.trim().isEmpty
                                    ? 'Bala Kumar'
                                    : leadNameCtrl.text.trim();
                                final rNo = rollNoCtrl.text.trim().isEmpty
                                    ? '23CS104'
                                    : rollNoCtrl.text.trim();

                                setState(() {
                                  _registeredTeams.insert(0, {
                                    'teamName': tName,
                                    'hackathon':
                                        selectedHackathon.split(' (').first,
                                    'status': 'Registered',
                                    'statusBg': const Color(0xFFDCFCE7),
                                    'statusColor': const Color(0xFF15803D),
                                    'problem':
                                        problemConceptCtrl.text.trim().isNotEmpty
                                            ? problemConceptCtrl.text.trim()
                                            : 'AI-driven campus innovation prototype.',
                                    'lead': '$lName ($rNo)',
                                    'leadName': lName,
                                    'rollNo': rNo,
                                    'members':
                                        memberNamesCtrl.text.trim().isNotEmpty
                                            ? memberNamesCtrl.text.trim()
                                            : '$lName and team members',
                                    'teamSize': teamSizeCtrl.text.trim().isEmpty
                                        ? '4'
                                        : teamSizeCtrl.text.trim(),
                                    'track': selectedDomain,
                                    'domain': selectedDomain,
                                    'repo': repoLinkCtrl.text.trim().isNotEmpty
                                        ? repoLinkCtrl.text.trim()
                                        : 'Repository / Demo Link',
                                    'date': '10/24/2026',
                                  });
                                  _selectedTab = 1; // Switch to Registered Teams tab
                                });

                                Navigator.pop(dialogCtx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Team "$tName" registered successfully into database!',
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
                                'Register Team',
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
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: const Color(0xFF475569),
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
// GRID PAINTER
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
