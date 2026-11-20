import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalSportsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalSportsScreen({super.key, this.onBack});

  @override
  State<PrincipalSportsScreen> createState() => _PrincipalSportsScreenState();
}

class _SportTeamItem {
  String id;
  String sportName;
  bool isRegisteredBadge;
  String teamName;
  String coach;
  String captain;
  String upcomingMeet;
  String venue;
  String status; // "Active", "Trials open", "Off-season"
  int athletesCount;

  _SportTeamItem({
    required this.id,
    required this.sportName,
    this.isRegisteredBadge = false,
    required this.teamName,
    required this.coach,
    this.captain = "",
    required this.upcomingMeet,
    this.venue = "",
    required this.status,
    this.athletesCount = 1,
  });
}

class _PrincipalSportsScreenState extends State<PrincipalSportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";
  int _rowsPerPage = 5;
  final int _currentPage = 1;

  // Initial Seed Data matching the screenshot exactly
  final List<_SportTeamItem> _teams = [
    _SportTeamItem(
      id: "SPT-001",
      sportName: "Volley Ball",
      isRegisteredBadge: true,
      teamName: "Team A",
      coach: "Anand",
      captain: "Anand Kumar",
      upcomingMeet: "Zonal Meet",
      venue: "Main Ground Volleyball Court",
      status: "Active",
      athletesCount: 12,
    ),
    _SportTeamItem(
      id: "SPT-002",
      sportName: "Badminton",
      isRegisteredBadge: false,
      teamName: "AIT Smashers",
      coach: "Coach R. Vikram",
      captain: "Rahul Sen",
      upcomingMeet: "State Inter-Collegiate Trophy · Nov 20",
      venue: "Indoor Complex Court 1",
      status: "Trials open",
      athletesCount: 8,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SportTeamItem> get _filteredTeams {
    final query = _searchController.text.trim().toLowerCase();
    return _teams.where((team) {
      final matchesQuery = query.isEmpty ||
          team.sportName.toLowerCase().contains(query) ||
          team.teamName.toLowerCase().contains(query) ||
          team.coach.toLowerCase().contains(query) ||
          team.upcomingMeet.toLowerCase().contains(query);

      final matchesFilter = _selectedFilter == "All" ||
          team.status.toLowerCase() == _selectedFilter.toLowerCase();

      return matchesQuery && matchesFilter;
    }).toList();
  }

  int get _totalTeamsCount => _teams.length;
  int get _totalAthletesCount => _teams.isEmpty ? 0 : 2; // Matching the screenshot '2'
  int get _openTrialsCount =>
      _teams.where((t) => t.status.toLowerCase() == "trials open").length;
  int get _upcomingMeetsCount =>
      _teams.where((t) => t.upcomingMeet.isNotEmpty).length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
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
                // 1. HERO BLUEPRINT BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. 4 STAT KPI CARDS
                _buildKpiCards(isWide),
                const SizedBox(height: 20),

                // 3. MAIN SPORTS DATA TABLE PANEL
                _buildSportsPanel(),
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
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
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
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.sports_soccer_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (Scrollable on small devices)
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
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Campus Life",
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
                          "Sports",
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
                          "CAMPUS LIFE",
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
                          "Phase 3",
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

                  // Main Title & Subtitle
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
                        child: const Center(
                          child: Icon(
                            Icons.sports_soccer_rounded,
                            color: Color(0xFFFBBF24), // Warm Yellow
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sports",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Teams, tournaments, registrations and achievements.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
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
  // 2. 4 STAT KPI CARDS (Image 4)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      _buildKpiCard(
        "TOTAL TEAMS",
        "$_totalTeamsCount",
        "Competitive collegiate squads",
        Icons.emoji_events_outlined,
        const Color(0xFF6366F1),
        const Color(0xFFEEF2FF),
      ),
      _buildKpiCard(
        "TOTAL ATHLETES",
        "$_totalAthletesCount",
        "Players registered across teams",
        Icons.groups_outlined,
        const Color(0xFF0D9488),
        const Color(0xFFCCFBF1),
      ),
      _buildKpiCard(
        "OPEN TRIALS",
        "$_openTrialsCount",
        "Sports actively recruiting",
        Icons.auto_awesome_outlined,
        const Color(0xFFD97706),
        const Color(0xFFFEF3C7),
      ),
      _buildKpiCard(
        "UPCOMING MEETS",
        "$_upcomingMeetsCount",
        "Zonal & university tournaments",
        Icons.calendar_today_outlined,
        const Color(0xFF0284C7),
        const Color(0xFFE0F2FE),
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
    } else {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: cards
            .map((c) => SizedBox(
                  width: 170,
                  child: c,
                ))
            .toList(),
      );
    }
  }

  Widget _buildKpiCard(
    String label,
    String value,
    String subtext,
    IconData icon,
    Color iconColor,
    Color iconBg,
  ) {
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
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
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
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtext,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN SPORTS DATA TABLE PANEL (Image 4)
  // ===========================================================================
  Widget _buildSportsPanel() {
    final filtered = _filteredTeams;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
          // Filter Toolbar
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 650;

                final searchBox = Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: const InputDecoration(
                      hintText: "Search sports...",
                      hintStyle:
                          TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      prefixIcon: Icon(Icons.search_rounded,
                          size: 18, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                );

                final filterAndButton = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 6),
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
                          value: _selectedFilter,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 16, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF0F172A)),
                          items: ["All", "Active", "Trials open", "Off-season"]
                              .map((it) => DropdownMenuItem(
                                  value: it, child: Text(it)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedFilter = v ?? "All"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: _showRegisterSportModal,
                      icon: const Icon(Icons.add_rounded,
                          size: 16, color: Colors.white),
                      label: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF283685), // Deep Royal Navy/Indigo
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                );

                if (isSmall) {
                  return Column(
                    children: [
                      searchBox,
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filterAndButton,
                        ],
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: searchBox),
                    const SizedBox(width: 14),
                    filterAndButton,
                  ],
                );
              },
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Table / Content
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.sports_soccer_outlined,
                        size: 40, color: Color(0xFF94A3B8)),
                    const SizedBox(height: 8),
                    Text(
                      "No sports found matching your filter.",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 880),
                child: DataTable(
                  horizontalMargin: 20,
                  columnSpacing: 24,
                  headingRowHeight: 46,
                  dataRowMinHeight: 52,
                  dataRowMaxHeight: 56,
                  headingRowColor:
                      WidgetStateProperty.all(const Color(0xFFFAFBFD)),
                  dividerThickness: 1,
                  columns: [
                    DataColumn(
                      label: Text(
                        "SPORT",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "TEAM",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "COACH",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "UPCOMING",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "STATUS",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "ACTION",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                  rows: filtered.map((item) {
                    return DataRow(
                      cells: [
                        // SPORT column (with optional "Registered" badge)
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.sportName,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              if (item.isRegisteredBadge) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCCFBF1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "Registered",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0D9488),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // TEAM column
                        DataCell(
                          Text(
                            item.teamName,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),

                        // COACH column
                        DataCell(
                          Text(
                            item.coach,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),

                        // UPCOMING column
                        DataCell(
                          Text(
                            item.upcomingMeet.isEmpty
                                ? "—"
                                : item.upcomingMeet,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),

                        // STATUS column
                        DataCell(
                          _buildStatusPill(item.status),
                        ),

                        // ACTION column (View ->)
                        DataCell(
                          InkWell(
                            onTap: () => _showSportDetailsModal(item),
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.arrow_right_alt_rounded,
                                    size: 16,
                                    color: Color(0xFF0F172A),
                                  ),
                                ],
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

          // Table Footer: Showing 1 to 2 of 2 sports teams | Per page: 5 | Pagination: Page 1 of 1 < Prev 1 Next >
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 650;

                final leftInfo = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Showing 1 to ${filtered.length} of ${_teams.length} sports teams",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      "Per page:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _rowsPerPage,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 14, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(
                              fontSize: 11.5, color: const Color(0xFF0F172A)),
                          items: [5, 10, 20]
                              .map((n) => DropdownMenuItem(
                                  value: n, child: Text("$n")))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _rowsPerPage = v ?? 5),
                        ),
                      ),
                    ),
                  ],
                );

                final rightPagination = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Page $_currentPage of 1",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      "< Prev",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFFCBD5E1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2865),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Next >",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFFCBD5E1),
                      ),
                    ),
                  ],
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      leftInfo,
                      const SizedBox(height: 12),
                      rightPagination,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftInfo,
                    rightPagination,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Status badge
  Widget _buildStatusPill(String status) {
    Color bg;
    Color text;

    switch (status.toLowerCase()) {
      case "active":
        bg = const Color(0xFFE0F2FE); // Soft light blue
        text = const Color(0xFF0284C7);
        break;
      case "trials open":
        bg = const Color(0xFFDCFCE7); // Soft light mint/green
        text = const Color(0xFF16A34A);
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        text = const Color(0xFF64748B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. REGISTER SPORT / TEAM MODAL (Image 5)
  // ===========================================================================
  void _showRegisterSportModal() {
    final sportNameCtrl = TextEditingController();
    final teamNameCtrl = TextEditingController();
    final headCoachCtrl = TextEditingController();
    final captainCtrl = TextEditingController();
    final meetCtrl = TextEditingController();
    final venueCtrl = TextEditingController();
    String selectedStatus = "Trials open";

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modal Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Register Sport / Team",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(dialogCtx).pop(),
                              icon: const Icon(Icons.close_rounded,
                                  size: 20, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Add a varsity sport squad, coach, and upcoming competition schedule.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Row 1: SPORT NAME * & TEAM NAME *
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: "SPORT NAME *",
                                hint: "e.g. Badminton, Swimming",
                                controller: sportNameCtrl,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "TEAM NAME *",
                                hint: "e.g. AIT Smashers",
                                controller: teamNameCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 2: HEAD COACH * & TEAM CAPTAIN
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: "HEAD COACH *",
                                hint: "e.g. Coach Vikram",
                                controller: headCoachCtrl,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "TEAM CAPTAIN",
                                hint: "e.g. Rahul Sen",
                                controller: captainCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 3: UPCOMING MEET / EVENT * & HOME VENUE
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: "UPCOMING MEET / EVENT *",
                                hint: "e.g. Zonal meet · Nov 10",
                                controller: meetCtrl,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "HOME VENUE",
                                hint: "e.g. Indoor Complex Court 1",
                                controller: venueCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 4: STATUS DROPDOWN
                        Text(
                          "STATUS",
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedStatus,
                              isExpanded: true,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF0F172A),
                              ),
                              items: ["Trials open", "Active", "Off-season"]
                                  .map((s) => DropdownMenuItem(
                                      value: s, child: Text(s)))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setModalState(() => selectedStatus = val);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Modal Footer Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.of(dialogCtx).pop(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                side: const BorderSide(
                                    color: Color(0xFFE2E8F0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                final sportName = sportNameCtrl.text.trim();
                                final teamName = teamNameCtrl.text.trim();
                                final coach = headCoachCtrl.text.trim();

                                if (sportName.isEmpty || teamName.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Please enter both sport name and team name",
                                          style: GoogleFonts.poppins()),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xFFEF4444),
                                    ),
                                  );
                                  return;
                                }

                                final newTeam = _SportTeamItem(
                                  id: "SPT-${DateTime.now().millisecondsSinceEpoch}",
                                  sportName: sportName,
                                  isRegisteredBadge: true,
                                  teamName: teamName,
                                  coach: coach.isEmpty
                                      ? "Head Coach"
                                      : coach,
                                  captain: captainCtrl.text.trim(),
                                  upcomingMeet: meetCtrl.text.trim().isEmpty
                                      ? "Friendly Match"
                                      : meetCtrl.text.trim(),
                                  venue: venueCtrl.text.trim().isEmpty
                                      ? "Sports Ground"
                                      : venueCtrl.text.trim(),
                                  status: selectedStatus,
                                  athletesCount: 1,
                                );

                                setState(() {
                                  _teams.insert(0, newTeam);
                                });

                                Navigator.of(dialogCtx).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Team '$teamName' registered successfully!",
                                        style: GoogleFonts.poppins()),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF10B981),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E3880),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                "Submit Registration",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
  // 5. SPORT / TEAM DETAILS MODAL (View ->)
  // ===========================================================================
  void _showSportDetailsModal(_SportTeamItem item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges + Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Varsity Squad",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4338CA),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildStatusPill(item.status),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogCtx).pop(),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Sport & Team Title
                  Text(
                    item.sportName,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    item.teamName,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Details Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailField(
                                label: "Head Coach",
                                value: item.coach,
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailField(
                                label: "Team Captain",
                                value: item.captain.isEmpty
                                    ? "Not assigned"
                                    : item.captain,
                                icon: Icons.sports_score_rounded,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailField(
                                label: "Athletes / Squad",
                                value: "${item.athletesCount} athletes",
                                icon: Icons.groups_outlined,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailField(
                                label: "Home Venue",
                                value: item.venue.isEmpty
                                    ? "Main Campus Grounds"
                                    : item.venue,
                                icon: Icons.location_on_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upcoming Meet / Schedule Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded,
                                      size: 14, color: Color(0xFF64748B)),
                                  const SizedBox(width: 6),
                                  Text(
                                    "UPCOMING MEET / TOURNAMENT",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.upcomingMeet.isEmpty
                                    ? "No scheduled meet"
                                    : item.upcomingMeet,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogCtx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Meet schedule update requested",
                                    style: GoogleFonts.poppins()),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Change",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF283685),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons: Disband Team (Red) | Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _teams.removeWhere((t) => t.id == item.id);
                          });
                          Navigator.of(dialogCtx).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Team '${item.teamName}' disbanded",
                                  style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: const Color(0xFFDC2626),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 16, color: Colors.white),
                        label: Text(
                          "Disband Team",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB91C1C),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.of(dialogCtx).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Close",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
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
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF0F172A)),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
      ],
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
      ..strokeWidth = 1;

    const double step = 28;
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
