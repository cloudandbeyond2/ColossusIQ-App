import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: CAMPUS EVENTS SCREEN (Exact implementation of Images 1, 2 & 3)
// - Hero Blueprint Banner: "Home > Campus Life > Campus Events"
//   Badges: "CAMPUS LIFE", "Phase 3"
// - 4 Stat KPI Cards: Total Events (6), Upcoming (4), Ongoing (0), This Month (3)
// - Search bar, "All Types" dropdown, "All Status" dropdown & "+ Create Event" button
// - Interactive Event Cards with Date box, category/status badges, time, location,
//   organizer, progress bar for capacity, Edit pencil (modal) & Delete trash.
// =============================================================================

class PrincipalCampusEventsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalCampusEventsScreen({super.key, this.onBack});

  @override
  State<PrincipalCampusEventsScreen> createState() =>
      _PrincipalCampusEventsScreenState();
}

class _PrincipalCampusEventsScreenState
    extends State<PrincipalCampusEventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedType = "All Types";
  String _selectedStatus = "All Status";

  // Data matching Image 1
  late List<Map<String, dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _events = [
      {
        "id": "EVT-1001",
        "month": "OCT",
        "day": "15",
        "title": "AI Workshop - Basics to Production",
        "type": "Workshop",
        "typeColor": const Color(0xFF9333EA),
        "typeBg": const Color(0xFFF5F3FF),
        "status": "Completed",
        "statusColor": const Color(0xFF64748B),
        "statusBg": const Color(0xFFF1F5F9),
        "startDate": "10/15/2026",
        "endDate": "",
        "time": "10:00 AM",
        "venue": "Lab 3, Block B",
        "organizer": "Dr. Anand V.",
        "capacity": 60,
        "enrolled": 60,
        "showProgress": true,
        "description": "Comprehensive hands-on workshop covering LLMs, RAG architectures and enterprise deployment.",
      },
      {
        "id": "EVT-1002",
        "month": "OCT",
        "day": "20",
        "title": "Diwali Holiday",
        "type": "Holiday",
        "typeColor": const Color(0xFFD97706),
        "typeBg": const Color(0xFFFEF3C7),
        "status": "Completed",
        "statusColor": const Color(0xFF64748B),
        "statusBg": const Color(0xFFF1F5F9),
        "startDate": "10/20/2026",
        "endDate": "10/20/2026",
        "time": "",
        "venue": "",
        "organizer": "Administration",
        "capacity": 0,
        "enrolled": 0,
        "showProgress": false,
        "description": "College holiday on account of Deepavali festival.",
      },
      {
        "id": "EVT-1003",
        "month": "OCT",
        "day": "30",
        "title": "Annual Sports Meet",
        "type": "Sports",
        "typeColor": const Color(0xFF0D9488),
        "typeBg": const Color(0xFFCCFBF1),
        "status": "Upcoming",
        "statusColor": const Color(0xFF0284C7),
        "statusBg": const Color(0xFFE0F2FE),
        "startDate": "10/30/2026",
        "endDate": "10/31/2026",
        "time": "08:00 - ends 31 Oct 2026",
        "venue": "Sports Ground",
        "organizer": "Physical Education Dept",
        "capacity": 600,
        "enrolled": 580,
        "showProgress": true,
        "description": "Inter-department athletic tournaments, track and field events, and championship trophies.",
      },
      {
        "id": "EVT-1004",
        "month": "NOV",
        "day": "5",
        "title": "Tech Symposium 2026",
        "type": "Academic",
        "typeColor": const Color(0xFF2563EB),
        "typeBg": const Color(0xFFEFF6FF),
        "status": "Upcoming",
        "statusColor": const Color(0xFF0284C7),
        "statusBg": const Color(0xFFE0F2FE),
        "startDate": "11/05/2026",
        "endDate": "11/05/2026",
        "time": "10:00 AM",
        "venue": "Auditorium",
        "organizer": "CSE Department",
        "capacity": 350,
        "enrolled": 210,
        "showProgress": false,
        "description": "Flagship national level student symposium featuring project displays and paper presentations.",
      },
      {
        "id": "EVT-1005",
        "month": "NOV",
        "day": "14",
        "title": "Children's Day & Community Outreach",
        "type": "Cultural",
        "typeColor": const Color(0xFFE11D48),
        "typeBg": const Color(0xFFFFE4E6),
        "status": "Upcoming",
        "statusColor": const Color(0xFF0284C7),
        "statusBg": const Color(0xFFE0F2FE),
        "startDate": "11/14/2026",
        "endDate": "11/14/2026",
        "time": "09:30 AM",
        "venue": "Campus Quadrangle",
        "organizer": "NSS Cell",
        "capacity": 200,
        "enrolled": 140,
        "showProgress": false,
        "description": "Educational outreach and interactive workshops for neighboring school children.",
      },
      {
        "id": "EVT-1006",
        "month": "NOV",
        "day": "25",
        "title": "Research & Innovation Expo",
        "type": "Academic",
        "typeColor": const Color(0xFF2563EB),
        "typeBg": const Color(0xFFEFF6FF),
        "status": "Upcoming",
        "statusColor": const Color(0xFF0284C7),
        "statusBg": const Color(0xFFE0F2FE),
        "startDate": "11/25/2026",
        "endDate": "11/25/2026",
        "time": "10:00 AM",
        "venue": "Library Exhibition Hall",
        "organizer": "R&D Cell",
        "capacity": 400,
        "enrolled": 310,
        "showProgress": false,
        "description": "Annual institutional expo showcasing faculty-student patented research prototypes.",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalEvents => _events.length;
  int get _upcomingEvents =>
      _events.where((e) => e["status"] == "Upcoming").length;
  int get _ongoingEvents =>
      _events.where((e) => e["status"] == "Ongoing").length;
  int get _thisMonthEvents =>
      _events.where((e) => e["month"] == "OCT").length;

  List<Map<String, dynamic>> get _filteredEvents {
    final query = _searchController.text.trim().toLowerCase();
    return _events.where((e) {
      final matchesSearch = query.isEmpty ||
          e["title"].toString().toLowerCase().contains(query) ||
          e["venue"].toString().toLowerCase().contains(query) ||
          e["organizer"].toString().toLowerCase().contains(query);

      final matchesType = _selectedType == "All Types" ||
          e["type"].toString().toLowerCase() == _selectedType.toLowerCase();

      final matchesStatus = _selectedStatus == "All Status" ||
          e["status"].toString().toLowerCase() == _selectedStatus.toLowerCase();

      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 950;
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
                const SizedBox(height: 18),

                // 2. 4 STAT KPI CARDS (Image 1: 6, 4, 0, 3)
                _buildKpiCards(isWide),
                const SizedBox(height: 18),

                // 3. SEARCH & FILTERS SECTION (Image 1)
                _buildFilterControls(),
                const SizedBox(height: 16),

                // 4. CREATE EVENT BUTTON (Image 1)
                _buildCreateEventButton(),
                const SizedBox(height: 16),

                // 5. EVENT CARDS LIST (Image 1)
                _buildEventsList(),
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
                  Icons.celebration_rounded,
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
                        Text("Campus Events",
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

                  // Title + Celebration Icon
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
                            Icons.celebration_rounded,
                            color: Color(0xFFFBBF24), // Yellow Party Horn
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
                              "Campus Events",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "College and department events, seminars, workshops, cultural and alumni events.",
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
  // 2. 4 STAT KPI CARDS (Image 1: 6, 4, 0, 3)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      _buildSingleKpi("Total Events", "$_totalEvents",
          Icons.calendar_today_outlined, const Color(0xFF2563EB)),
      _buildSingleKpi("Upcoming", "$_upcomingEvents",
          Icons.access_time_rounded, const Color(0xFF0284C7)),
      _buildSingleKpi("Ongoing", "$_ongoingEvents",
          Icons.check_circle_outline_rounded, const Color(0xFF10B981)),
      _buildSingleKpi("This Month", "$_thisMonthEvents",
          Icons.date_range_outlined, const Color(0xFFD97706)),
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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

  Widget _buildSingleKpi(String label, String value, IconData icon, Color color) {
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
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTERS SECTION (Image 1)
  // ===========================================================================
  Widget _buildFilterControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search bar
        Container(
          height: 42,
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
              hintText: "Search events...",
              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              prefixIcon: Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Dropdown: All Types
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedType,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
              items: [
                "All Types",
                "Workshop",
                "Holiday",
                "Sports",
                "Academic",
                "Cultural"
              ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedType = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Dropdown: All Status
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedStatus,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
              items: [
                "All Status",
                "Upcoming",
                "Ongoing",
                "Completed",
                "Cancelled"
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. CREATE EVENT BUTTON (Image 1)
  // ===========================================================================
  Widget _buildCreateEventButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton.icon(
        onPressed: () => _openCreateEventDialog(),
        icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
        label: Text(
          "Create Event",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF283685), // Purple/Navy Button (Image 1)
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. EVENT CARDS LIST (Image 1)
  // ===========================================================================
  Widget _buildEventsList() {
    final list = _filteredEvents;

    if (list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Center(
          child: Text(
            "No campus events match your filters.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          ),
        ),
      );
    }

    return Column(
      children: list.map((event) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date Box (Image 1)
              Container(
                width: 52,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event["month"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF475569),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      event["day"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // Event Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Badges
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          event["title"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        // Type Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: event["typeBg"] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            event["type"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: event["typeColor"] as Color,
                            ),
                          ),
                        ),
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: event["statusBg"] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            event["status"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: event["statusColor"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Metadata Subtitle: time, location, organizer
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if ((event["time"] as String).isNotEmpty) ...[
                            const Icon(Icons.access_time_rounded,
                                size: 12, color: Color(0xFF94A3B8)),
                            const SizedBox(width: 4),
                            Text(
                              event["time"]!,
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: const Color(0xFF64748B)),
                            ),
                            const SizedBox(width: 10),
                          ],
                          if ((event["venue"] as String).isNotEmpty) ...[
                            const Icon(Icons.location_on_outlined,
                                size: 12, color: Color(0xFF94A3B8)),
                            const SizedBox(width: 4),
                            Text(
                              event["venue"]!,
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: const Color(0xFF64748B)),
                            ),
                            const SizedBox(width: 10),
                          ],
                          if ((event["organizer"] as String).isNotEmpty) ...[
                            const Icon(Icons.person_outline_rounded,
                                size: 12, color: Color(0xFF94A3B8)),
                            const SizedBox(width: 4),
                            Text(
                              event["organizer"]!,
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Capacity Progress Bar (Image 1: pink line e.g. 60/60, 580/600)
                    if (event["showProgress"] == true && event["capacity"] > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (event["enrolled"] / event["capacity"]).clamp(0.0, 1.0),
                                minHeight: 4,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFFE11D48)), // Pinkish red bar from Image 1
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${event["enrolled"]}/${event["capacity"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Action Buttons: Edit (Pencil) & Delete (Trash)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _openEditEventDialog(event),
                    icon: const Icon(Icons.edit_outlined,
                        size: 16, color: Color(0xFF64748B)),
                    tooltip: "Edit event",
                    splashRadius: 18,
                  ),
                  IconButton(
                    onPressed: () => _confirmDelete(event),
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    tooltip: "Delete event",
                    splashRadius: 18,
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ===========================================================================
  // CREATE EVENT DIALOG (Exact to Image 2)
  // ===========================================================================
  void _openCreateEventDialog() {
    final titleCtrl = TextEditingController(text: "Annual Tech Symposium");
    String typeVal = "Academic";
    String statusVal = "Upcoming";
    final startDateCtrl = TextEditingController();
    final endDateCtrl = TextEditingController();
    final timeCtrl = TextEditingController();
    final venueCtrl = TextEditingController(text: "Auditorium, Hall A...");
    final organizerCtrl = TextEditingController(text: "Department / Faculty");
    final capacityCtrl = TextEditingController(text: "0");
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with close X (Image 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Event",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
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
                        const SizedBox(height: 18),

                        // Event Title *
                        _modalLabel("Event Title *"),
                        _modalInput(titleCtrl, "Annual Tech Symposium"),
                        const SizedBox(height: 14),

                        // Type & Status Dropdowns
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Type"),
                                  _modalDropdown(
                                    value: typeVal,
                                    items: ["Academic", "Workshop", "Sports", "Cultural", "Holiday"],
                                    onChanged: (v) => setModalState(() => typeVal = v!),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Status"),
                                  _modalDropdown(
                                    value: statusVal,
                                    items: ["Upcoming", "Ongoing", "Completed", "Cancelled"],
                                    onChanged: (v) => setModalState(() => statusVal = v!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Start Date * & End Date
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Start Date *"),
                                  _modalDateInput(startDateCtrl, "mm/dd/yyyy"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("End Date"),
                                  _modalDateInput(endDateCtrl, "mm/dd/yyyy"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Time & Venue
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Time"),
                                  _modalTimeInput(timeCtrl, "--:-- --"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Venue"),
                                  _modalInput(venueCtrl, "Auditorium, Hall A..."),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Organizer & Capacity
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Organizer"),
                                  _modalInput(organizerCtrl, "Department / Faculty"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Capacity"),
                                  _modalInput(capacityCtrl, "0", isNumber: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Description
                        _modalLabel("Description"),
                        _modalTextArea(descCtrl, "Brief event description..."),
                        const SizedBox(height: 22),

                        // Footer Buttons: Cancel & Create Event (Image 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (titleCtrl.text.trim().isEmpty) return;
                                final newEvent = {
                                  "id": "EVT-${DateTime.now().millisecondsSinceEpoch}",
                                  "month": "NOV",
                                  "day": "30",
                                  "title": titleCtrl.text.trim(),
                                  "type": typeVal,
                                  "typeColor": _getTypeColor(typeVal),
                                  "typeBg": _getTypeBg(typeVal),
                                  "status": statusVal,
                                  "statusColor": _getStatusColor(statusVal),
                                  "statusBg": _getStatusBg(statusVal),
                                  "startDate": startDateCtrl.text.trim(),
                                  "endDate": endDateCtrl.text.trim(),
                                  "time": timeCtrl.text.trim(),
                                  "venue": venueCtrl.text.trim(),
                                  "organizer": organizerCtrl.text.trim(),
                                  "capacity": int.tryParse(capacityCtrl.text.trim()) ?? 0,
                                  "enrolled": 0,
                                  "showProgress": (int.tryParse(capacityCtrl.text.trim()) ?? 0) > 0,
                                  "description": descCtrl.text.trim(),
                                };
                                setState(() => _events.insert(0, newEvent));
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Event '${titleCtrl.text.trim()}' created successfully!"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF818CF8), // Soft purple button from Image 2
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Create Event",
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
  // EDIT EVENT DIALOG (Exact to Image 3)
  // ===========================================================================
  void _openEditEventDialog(Map<String, dynamic> event) {
    final titleCtrl = TextEditingController(text: event["title"]);
    String typeVal = event["type"];
    String statusVal = event["status"];
    final startDateCtrl = TextEditingController(text: event["startDate"]);
    final endDateCtrl = TextEditingController(text: event["endDate"]);
    final timeCtrl = TextEditingController(text: event["time"]);
    final venueCtrl = TextEditingController(text: event["venue"]);
    final organizerCtrl = TextEditingController(text: event["organizer"]);
    final capacityCtrl = TextEditingController(text: "${event["capacity"]}");
    final descCtrl = TextEditingController(text: event["description"]);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with close X (Image 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Event",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
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
                        const SizedBox(height: 18),

                        // Event Title *
                        _modalLabel("Event Title *"),
                        _modalInput(titleCtrl, "AI Workshop - Basics to Production"),
                        const SizedBox(height: 14),

                        // Type & Status Dropdowns
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Type"),
                                  _modalDropdown(
                                    value: typeVal,
                                    items: ["Academic", "Workshop", "Sports", "Cultural", "Holiday"],
                                    onChanged: (v) => setModalState(() => typeVal = v!),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Status"),
                                  _modalDropdown(
                                    value: statusVal,
                                    items: ["Upcoming", "Ongoing", "Completed", "Cancelled"],
                                    onChanged: (v) => setModalState(() => statusVal = v!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Start Date * & End Date
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Start Date *"),
                                  _modalDateInput(startDateCtrl, "10/15/2026"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("End Date"),
                                  _modalDateInput(endDateCtrl, "mm/dd/yyyy"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Time & Venue
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Time"),
                                  _modalTimeInput(timeCtrl, "10:00 AM"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Venue"),
                                  _modalInput(venueCtrl, "Lab 3, Block B"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Organizer & Capacity
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Organizer"),
                                  _modalInput(organizerCtrl, "Dr. Anand V."),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _modalLabel("Capacity"),
                                  _modalInput(capacityCtrl, "60", isNumber: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Description
                        _modalLabel("Description"),
                        _modalTextArea(descCtrl, "Brief event description..."),
                        const SizedBox(height: 22),

                        // Footer Buttons: Cancel & Save Changes (Image 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  event["title"] = titleCtrl.text.trim();
                                  event["type"] = typeVal;
                                  event["typeColor"] = _getTypeColor(typeVal);
                                  event["typeBg"] = _getTypeBg(typeVal);
                                  event["status"] = statusVal;
                                  event["statusColor"] = _getStatusColor(statusVal);
                                  event["statusBg"] = _getStatusBg(statusVal);
                                  event["startDate"] = startDateCtrl.text.trim();
                                  event["endDate"] = endDateCtrl.text.trim();
                                  event["time"] = timeCtrl.text.trim();
                                  event["venue"] = venueCtrl.text.trim();
                                  event["organizer"] = organizerCtrl.text.trim();
                                  event["capacity"] = int.tryParse(capacityCtrl.text.trim()) ?? 0;
                                  event["description"] = descCtrl.text.trim();
                                });
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Event updated successfully!"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF283685), // Deep navy from Image 3
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Save Changes",
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

  void _confirmDelete(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Event", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text("Are you sure you want to delete '${event["title"]}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _events.remove(event));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Event deleted successfully.")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Modal Input Helpers
  Widget _modalLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _modalInput(TextEditingController controller, String hint, {bool isNumber = false}) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: GoogleFonts.poppins(fontSize: 12.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _modalDateInput(TextEditingController controller, String hint) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF64748B)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
      ),
    );
  }

  Widget _modalTimeInput(TextEditingController controller, String hint) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          suffixIcon: const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF64748B)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
      ),
    );
  }

  Widget _modalDropdown({
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
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _modalTextArea(TextEditingController controller, String hint) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: GoogleFonts.poppins(fontSize: 12, height: 1.4),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "workshop":
        return const Color(0xFF9333EA);
      case "holiday":
        return const Color(0xFFD97706);
      case "sports":
        return const Color(0xFF0D9488);
      case "academic":
        return const Color(0xFF2563EB);
      case "cultural":
        return const Color(0xFFE11D48);
      default:
        return const Color(0xFF475569);
    }
  }

  Color _getTypeBg(String type) {
    switch (type.toLowerCase()) {
      case "workshop":
        return const Color(0xFFF5F3FF);
      case "holiday":
        return const Color(0xFFFEF3C7);
      case "sports":
        return const Color(0xFFCCFBF1);
      case "academic":
        return const Color(0xFFEFF6FF);
      case "cultural":
        return const Color(0xFFFFE4E6);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "upcoming":
        return const Color(0xFF0284C7);
      case "ongoing":
        return const Color(0xFF16A34A);
      case "completed":
        return const Color(0xFF64748B);
      case "cancelled":
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF475569);
    }
  }

  Color _getStatusBg(String status) {
    switch (status.toLowerCase()) {
      case "upcoming":
        return const Color(0xFFE0F2FE);
      case "ongoing":
        return const Color(0xFFDCFCE7);
      case "completed":
        return const Color(0xFFF1F5F9);
      case "cancelled":
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }
}

// Blueprint Grid Painter
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
