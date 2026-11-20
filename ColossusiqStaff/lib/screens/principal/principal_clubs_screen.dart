import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: CLUBS SCREEN (Exact implementation of Images 1, 2 & 3)
// - Hero Blueprint Banner: "Home > Campus Life > Clubs"
//   Badges: "CAMPUS LIFE", "Phase 3"
// - 4 Stat KPI Cards: TOTAL CLUBS (3), TOTAL MEMBERS (3), ACTIVE CATEGORIES (2), UPCOMING ACTIVITIES (3)
// - Search bar, Filter dropdown & "+ Start a club" button
// - Interactive Table with Category badges, Member badges, Next Activity, and View ->
// - "Start a Campus Club" Modal (Image 2)
// - "Club Details" Modal (Image 3) with Disband Club and Leave Club actions
// =============================================================================

class PrincipalClubsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalClubsScreen({super.key, this.onBack});

  @override
  State<PrincipalClubsScreen> createState() => _PrincipalClubsScreenState();
}

class _PrincipalClubsScreenState extends State<PrincipalClubsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All";

  // Data matching Image 1
  late List<Map<String, dynamic>> _clubs;

  @override
  void initState() {
    super.initState();
    _clubs = [
      {
        "id": "CLUB-101",
        "name": "fine arts",
        "isMember": true,
        "category": "Technical",
        "categoryColor": const Color(0xFF6366F1),
        "categoryBg": const Color(0xFFEEF2FF),
        "members": 1,
        "studentLead": "Anand Kumar",
        "facultyAdvisor": "Dr. Lakshmi Sundaram",
        "venue": "Venue to be announced",
        "nextActivity": "sat",
        "status": "Active",
        "mission": "Explore digital design, visual storytelling, and fine arts exhibitions.",
      },
      {
        "id": "CLUB-102",
        "name": "Sports club",
        "isMember": true,
        "category": "Sports",
        "categoryColor": const Color(0xFFD97706),
        "categoryBg": const Color(0xFFFEF3C7),
        "members": 1,
        "studentLead": "Karthik Raja",
        "facultyAdvisor": "Dr. Lakshmi Sundaram",
        "venue": "Indoor Sports Complex",
        "nextActivity": "Weekend on 4 PM",
        "status": "Active",
        "mission": "Physical fitness, athletic conditioning, and inter-collegiate tournaments.",
      },
      {
        "id": "CLUB-103",
        "name": "AI & Innovation Club",
        "isMember": false,
        "category": "Technical",
        "categoryColor": const Color(0xFF6366F1),
        "categoryBg": const Color(0xFFEEF2FF),
        "members": 1,
        "studentLead": "bala",
        "facultyAdvisor": "Dr. Anand V.",
        "venue": "CSE Lab 2 / Block B",
        "nextActivity": "Every Saturday - 10:00 AM",
        "status": "Active",
        "mission": "Hands-on projects with deep learning, robotics and campus tech solutions.",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalClubs => _clubs.length;
  int get _totalMembers =>
      _clubs.fold<int>(0, (sum, c) => sum + (c["members"] as int));
  int get _activeCategories =>
      _clubs.map((c) => c["category"]).toSet().length;
  int get _upcomingActivities =>
      _clubs.where((c) => (c["nextActivity"] as String).isNotEmpty).length;

  List<Map<String, dynamic>> get _filteredClubs {
    final query = _searchController.text.trim().toLowerCase();
    return _clubs.where((c) {
      final matchesSearch = query.isEmpty ||
          c["name"].toString().toLowerCase().contains(query) ||
          c["studentLead"].toString().toLowerCase().contains(query) ||
          c["category"].toString().toLowerCase().contains(query);

      final matchesCat = _selectedCategory == "All" ||
          c["category"].toString().toLowerCase() == _selectedCategory.toLowerCase();

      return matchesSearch && matchesCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Warm neutral canvas
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
                // 1. HERO BLUEPRINT BANNER (Image 1)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. 4 STAT KPI CARDS (Image 1: 3, 3, 2, 3)
                _buildKpiCards(isWide),
                const SizedBox(height: 20),

                // 3. MAIN CLUBS PANEL (Image 1)
                _buildClubsPanel(),
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
                  Icons.flag_rounded,
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
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text("Home",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Campus Life",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Clubs",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
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

                  // Title + Flag Icon
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
                            Icons.flag_rounded,
                            color: Color(0xFFFBBF24), // Yellow Flag
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
                              "Clubs",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Technical, cultural and social clubs, membership and activities.",
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
  // 2. 4 STAT KPI CARDS (Image 1: 3, 3, 2, 3)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      _buildKpiCard(
        "TOTAL CLUBS",
        "$_totalClubs",
        "Active campus organizations",
        Icons.flag_outlined,
        const Color(0xFF6366F1),
        const Color(0xFFEEF2FF),
      ),
      _buildKpiCard(
        "TOTAL MEMBERS",
        "$_totalMembers",
        "Students actively participating",
        Icons.people_outline_rounded,
        const Color(0xFF0D9488),
        const Color(0xFFCCFBF1),
      ),
      _buildKpiCard(
        "ACTIVE CATEGORIES",
        "$_activeCategories",
        "Technical, cultural & social",
        Icons.filter_alt_outlined,
        const Color(0xFFD97706),
        const Color(0xFFFEF3C7),
      ),
      _buildKpiCard(
        "UPCOMING ACTIVITIES",
        "$_upcomingActivities",
        "Events & meetups scheduled",
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
                  width: 165,
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
  // 3. MAIN CLUBS PANEL (Exact to Image 1)
  // ===========================================================================
  Widget _buildClubsPanel() {
    final clubs = _filteredClubs;

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
          // Filter Toolbar (Search + Category Filter + Start a Club Button, Image 1)
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
                      hintText: "Search clubs...",
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
                    const Icon(Icons.filter_alt_outlined,
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
                          value: _selectedCategory,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 16, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF0F172A)),
                          items: ["All", "Technical", "Cultural", "Sports", "Social"]
                              .map((it) => DropdownMenuItem(
                                  value: it, child: Text(it)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedCategory = v ?? "All"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () => _openStartClubDialog(),
                      icon: const Icon(Icons.add_rounded,
                          size: 16, color: Colors.white),
                      label: Text(
                        "Start a club",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF283685), // Deep Navy from Image 1
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

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Data Table (Image 1)
          clubs.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      "No clubs found matching criteria",
                      style: GoogleFonts.poppins(color: const Color(0xFF94A3B8)),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 800),
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                      headingTextStyle: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                      dataRowMinHeight: 52,
                      dataRowMaxHeight: 64,
                      horizontalMargin: 20,
                      columnSpacing: 24,
                      columns: const [
                        DataColumn(label: Text("CLUB")),
                        DataColumn(label: Text("CATEGORY")),
                        DataColumn(label: Text("MEMBERS")),
                        DataColumn(label: Text("STUDENT LEAD")),
                        DataColumn(label: Text("NEXT ACTIVITY")),
                        DataColumn(label: Text("ACTION")),
                      ],
                      rows: clubs.map((club) {
                        return DataRow(
                          cells: [
                            // 1. Club name with optional "Member" badge (Image 1)
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    club["name"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  if (club["isMember"] == true) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE6FFFA),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Member",
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0D9488),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // 2. Category badge
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 3),
                                decoration: BoxDecoration(
                                  color: club["categoryBg"] as Color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  club["category"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: club["categoryColor"] as Color,
                                  ),
                                ),
                              ),
                            ),

                            // 3. Members count
                            DataCell(
                              Text(
                                "${club["members"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),

                            // 4. Student Lead
                            DataCell(
                              Text(
                                club["studentLead"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),

                            // 5. Next Activity
                            DataCell(
                              Text(
                                club["nextActivity"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),

                            // 6. Action: View ->
                            DataCell(
                              InkWell(
                                onTap: () => _openClubDetailsDialog(club),
                                child: Text(
                                  "View ->",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF283685),
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

          // Footer (Image 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Text(
              "Showing ${clubs.length} of ${_clubs.length} clubs",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // START A CAMPUS CLUB MODAL (Exact to Image 2)
  // ===========================================================================
  void _openStartClubDialog() {
    final nameCtrl = TextEditingController();
    String categoryVal = "Technical";
    String studentLeadVal = "Select Student Lead";
    String facultyAdvisorVal = "Select Faculty Advisor";
    final scheduleCtrl = TextEditingController();
    final venueCtrl = TextEditingController();
    final missionCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header + Close X
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start a Campus Club",
                              style: GoogleFonts.poppins(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(14),
                              child: const Icon(Icons.close_rounded,
                                  size: 18, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Register a new student club with activities and faculty guidance.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // CLUB NAME *
                        _fieldHeader("CLUB NAME *"),
                        _inputBox(nameCtrl, "e.g. AI Builders Club, Fine Arts Society"),
                        const SizedBox(height: 14),

                        // CATEGORY *
                        _fieldHeader("CATEGORY *"),
                        _dropdownBox(
                          value: categoryVal,
                          items: ["Technical", "Cultural", "Sports", "Social"],
                          onChanged: (v) => setModalState(() => categoryVal = v!),
                        ),
                        const SizedBox(height: 14),

                        // STUDENT LEAD * & FACULTY ADVISOR
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _fieldHeader("STUDENT LEAD *"),
                                  _dropdownBox(
                                    value: studentLeadVal,
                                    items: [
                                      "Select Student Lead",
                                      "Anand Kumar",
                                      "Karthik Raja",
                                      "bala",
                                      "Divya Ramesh"
                                    ],
                                    onChanged: (v) => setModalState(() => studentLeadVal = v!),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _fieldHeader("FACULTY ADVISOR"),
                                  _dropdownBox(
                                    value: facultyAdvisorVal,
                                    items: [
                                      "Select Faculty Advisor",
                                      "Dr. Lakshmi Sundaram",
                                      "Dr. Anand V.",
                                      "Prof. Radhika M."
                                    ],
                                    onChanged: (v) => setModalState(() => facultyAdvisorVal = v!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // MEETING SCHEDULE * & MEETING VENUE
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _fieldHeader("MEETING SCHEDULE *"),
                                  _inputBox(scheduleCtrl, "e.g. Weekly contest — Sat"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _fieldHeader("MEETING VENUE"),
                                  _inputBox(venueCtrl, "e.g. CSE Lab 2 / Block B"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // CLUB MISSION / ABOUT
                        _fieldHeader("CLUB MISSION / ABOUT"),
                        Container(
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: TextField(
                            controller: missionCtrl,
                            maxLines: 3,
                            style: GoogleFonts.poppins(fontSize: 12),
                            decoration: const InputDecoration(
                              hintText: "What does this club do? Who should join?",
                              hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Footer Buttons: Cancel & Create Club (Image 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFE2E8F0)),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (nameCtrl.text.trim().isEmpty) return;
                                setState(() {
                                  _clubs.add({
                                    "id": "CLUB-${DateTime.now().millisecondsSinceEpoch}",
                                    "name": nameCtrl.text.trim(),
                                    "isMember": true,
                                    "category": categoryVal,
                                    "categoryColor": _getCategoryColor(categoryVal),
                                    "categoryBg": _getCategoryBg(categoryVal),
                                    "members": 1,
                                    "studentLead": studentLeadVal == "Select Student Lead"
                                        ? "Anand Kumar"
                                        : studentLeadVal,
                                    "facultyAdvisor": facultyAdvisorVal == "Select Faculty Advisor"
                                        ? "Dr. Lakshmi Sundaram"
                                        : facultyAdvisorVal,
                                    "venue": venueCtrl.text.trim().isEmpty
                                        ? "Venue to be announced"
                                        : venueCtrl.text.trim(),
                                    "nextActivity": scheduleCtrl.text.trim().isEmpty
                                        ? "Upcoming"
                                        : scheduleCtrl.text.trim(),
                                    "status": "Active",
                                    "mission": missionCtrl.text.trim(),
                                  });
                                });
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Club '${nameCtrl.text.trim()}' created!"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4338CA), // Deep Indigo (Image 2)
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                "Create Club",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
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
  // CLUB DETAILS MODAL (Exact to Image 3)
  // ===========================================================================
  void _openClubDetailsDialog(Map<String, dynamic> club) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Badges + Close X (Image 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              club["category"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6366F1),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6FFFA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              club["status"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0D9488),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(ctx),
                        child: const Icon(Icons.close_rounded,
                            size: 18, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Club Title (Image 3)
                  Text(
                    club["name"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info 2x2 Box (Image 3)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF9F5), // Light warm beige
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Student Lead",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.5, color: const Color(0xFF64748B))),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_outline_rounded,
                                          size: 14, color: Color(0xFF0F172A)),
                                      const SizedBox(width: 5),
                                      Text(
                                        club["studentLead"]!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Faculty Advisor",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.5, color: const Color(0xFF64748B))),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(Icons.auto_awesome_rounded,
                                          size: 14, color: Color(0xFFD97706)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          club["facultyAdvisor"]!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Current Members",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.5, color: const Color(0xFF64748B))),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(Icons.people_outline_rounded,
                                          size: 14, color: Color(0xFF0D9488)),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${club["members"]} students",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Meeting Venue",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.5, color: const Color(0xFF64748B))),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 14, color: Color(0xFFDC2626)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          club["venue"]!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Next Activity Box (Image 3)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded,
                                    size: 14, color: Color(0xFF475569)),
                                const SizedBox(width: 6),
                                Text(
                                  "NEXT ACTIVITY / SCHEDULE",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Change",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          club["nextActivity"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Actions: Disband Club & Leave Club (Image 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          setState(() => _clubs.remove(club));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Club '${club["name"]}' disbanded."),
                              backgroundColor: const Color(0xFFDC2626),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 15, color: Colors.white),
                        label: Text(
                          "Disband Club",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB91C1C), // Red from Image 3
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          setState(() => club["isMember"] = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Left club '${club["name"]}'."),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Leave Club",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
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

  // Modal helpers
  Widget _fieldHeader(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _inputBox(TextEditingController controller, String hint) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: 12.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _dropdownBox({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case "technical":
        return const Color(0xFF6366F1);
      case "sports":
        return const Color(0xFFD97706);
      case "cultural":
        return const Color(0xFFE11D48);
      default:
        return const Color(0xFF0D9488);
    }
  }

  Color _getCategoryBg(String cat) {
    switch (cat.toLowerCase()) {
      case "technical":
        return const Color(0xFFEEF2FF);
      case "sports":
        return const Color(0xFFFEF3C7);
      case "cultural":
        return const Color(0xFFFFE4E6);
      default:
        return const Color(0xFFCCFBF1);
    }
  }
}

// Blueprint Grid Painter
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
