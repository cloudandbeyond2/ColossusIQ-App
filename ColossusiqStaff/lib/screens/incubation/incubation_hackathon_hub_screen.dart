import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: HACKATHON HUB SCREEN (Matches Images 3 & 4)
// - Blueprint Hero Banner: "Home > Project & Innovation > Hackathon Hub", badges PROJECT & INNOVATION, Phase 3
// - 4 KPI Stat Cards: TOTAL HACKATHONS (3), REGISTERED TEAMS (84), MY REGISTERED TEAMS (0), OPEN REGISTRATIONS (2)
// - Tab Bar: "All Hackathons" and "My Registered Teams"
// - Tab 0: Search, filter dropdown, Export CSV, "+ Register team", table with SIH, Campus AI, Tamil Nadu Innovation Challenge
// - Tab 1: Blueprint empty state with "< >" icon and "No registered teams yet" + "+ Register team" button
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
  int _selectedTab = 0; // 0: All Hackathons, 1: My Registered Teams
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
                // 1. HERO BLUEPRINT BANNER (Image 3)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. 4 KPI STAT CARDS (Image 3)
                _buildKpiStatCards(isWide, isMedium),
                const SizedBox(height: 20),

                // 3. TAB BAR: All Hackathons / My Registered Teams
                _buildTabBar(),
                const SizedBox(height: 16),

                // 4. TAB CONTENT
                if (_selectedTab == 0)
                  _buildAllHackathonsTab(constraints.maxWidth)
                else
                  _buildMyRegisteredTeamsTab(),
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

            // Decorative outline bracket on right (Image 3)
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
                        'Project & Innovation',
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
                        'Hackathon Hub',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Upcoming hackathons, teams, problem statements and results.',
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
  // 2. 4 KPI STAT CARDS (Image 3)
  // ===========================================================================
  Widget _buildKpiStatCards(bool isWide, bool isMedium) {
    final cards = [
      _buildStatCard(
        header: 'TOTAL HACKATHONS',
        value: '3',
        subtext: 'National & campus buildathons',
        icon: Icons.emoji_events_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF1E2865),
      ),
      _buildStatCard(
        header: 'REGISTERED TEAMS',
        value: '84',
        subtext: 'Live student team entries',
        subtextColor: const Color(0xFF0D9488),
        icon: Icons.groups_outlined,
        iconBg: const Color(0xFFE6F4F1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        header: 'MY REGISTERED TEAMS',
        value: '0',
        subtext: 'Stored in PostgreSQL database',
        icon: Icons.shield_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF64748B),
      ),
      _buildStatCard(
        header: 'OPEN REGISTRATIONS',
        value: '2',
        subtext: 'Accepting team applications',
        subtextColor: const Color(0xFFD97706),
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
    required String header,
    required String value,
    required String subtext,
    Color? subtextColor,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  header,
                  maxLines: 2,
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
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: subtextColor ?? const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. TAB BAR: All Hackathons / My Registered Teams
  // ===========================================================================
  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildTabHeaderItem(0, 'All Hackathons'),
            const SizedBox(width: 20),
            _buildTabHeaderItem(1, 'My Registered Teams'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabHeaderItem(int index, String label) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
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
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. TAB 0: ALL HACKATHONS TABLE (Image 3)
  // ===========================================================================
  Widget _buildAllHackathonsTab(double screenWidth) {
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
          // Filter & Action Controls Row
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
                    maxWidth: screenWidth >= 600 ? 320 : double.infinity,
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
                        hintText: 'Search hackathon hub...',
                        hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 16, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ),

                // Right actions: All dropdown, Export CSV, Register team
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // All dropdown with filter icon
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
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
                                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                                  .toList(),
                              onChanged: (v) => setState(() => _selectedFilter = v!),
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
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        minimumSize: const Size(0, 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // + Register team button (Image 3)
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
                        backgroundColor: const Color(0xFF1E2865), // Navy
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
              constraints: const BoxConstraints(minWidth: 850),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                dataRowMinHeight: 60,
                dataRowMaxHeight: 65,
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text('HACKATHON')),
                  DataColumn(label: Text('ORGANIZING BODY')),
                  DataColumn(label: Text('DATE')),
                  DataColumn(label: Text('REGISTERED TEAMS')),
                  DataColumn(label: Text('STATUS')),
                  DataColumn(label: Text('ACTION')),
                ],
                rows: _hackathons.map((h) {
                  return DataRow(
                    cells: [
                      // Hackathon title + domain
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              h['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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

                      // Organizing Body
                      DataCell(
                        Text(
                          h['organizingBody'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Date
                      DataCell(
                        Text(
                          h['date'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Registered Teams count
                      DataCell(
                        Text(
                          '${h['registeredTeams']}',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),

                      // Status Badge (Open, Active, Upcoming)
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: h['statusBg'] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            h['status'],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: h['statusColor'] as Color,
                            ),
                          ),
                        ),
                      ),

                      // Register team action button (Image 3)
                      DataCell(
                        OutlinedButton(
                          onPressed: () => _showRegisterTeamDialog(
                              context, hackathonTitle: h['title']),
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

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table Pagination Footer (Image 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Text(
                  'Showing 1–3 of 3 records',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rows:  ',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
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
                        fontSize: 12,
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
      ),
    );
  }

  // ===========================================================================
  // 5. TAB 1: MY REGISTERED TEAMS (Image 4)
  // ===========================================================================
  Widget _buildMyRegisteredTeamsTab() {
    return Container(
      constraints: const BoxConstraints(minHeight: 380),
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
            // Centered "< >" icon (Image 4)
            Text(
              '< >',
              style: GoogleFonts.firaCode(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 14),

            // Empty state title
            Text(
              'No registered teams yet',
              style: GoogleFonts.poppins(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),

            // Empty state subtitle
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'You haven\'t registered any team for upcoming hackathons. Join an active hackathon to build your innovation portfolio.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "+ Register team" button (Image 4)
            ElevatedButton.icon(
              onPressed: () => _showRegisterTeamDialog(context),
              icon: const Icon(Icons.add_rounded, size: 16),
              label: Text(
                'Register team',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865), // Dark Navy
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  // ===========================================================================
  // DIALOG: REGISTER TEAM
  // ===========================================================================
  void _showRegisterTeamDialog(BuildContext context, {String? hackathonTitle}) {
    final teamController = TextEditingController();
    final leadController = TextEditingController();
    final problemController = TextEditingController();

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
                child: const Icon(Icons.groups_outlined,
                    color: Color(0xFF1E2865), size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hackathonTitle != null
                      ? 'Register Team · $hackathonTitle'
                      : 'Register Team for Hackathon',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: teamController,
                  decoration: const InputDecoration(
                    labelText: 'Team Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: leadController,
                  decoration: const InputDecoration(
                    labelText: 'Team Leader Name & Roll No',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: problemController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Problem Statement Track / Abstract',
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
                      'Team ${teamController.text.isNotEmpty ? teamController.text : "InnoBuilders"} registered successfully!',
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
              child: const Text('Submit Registration'),
            ),
          ],
        );
      },
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
