import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalCampusEventsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalCampusEventsScreen({super.key, this.onBack});

  @override
  State<PrincipalCampusEventsScreen> createState() =>
      _PrincipalCampusEventsScreenState();
}

class _PrincipalCampusEventsScreenState
    extends State<PrincipalCampusEventsScreen> {
  int _activeFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _events = [
    {
      "id": "EVT-1003",
      "title": "Workshop: GenAI for Engineers",
      "type": "Workshop",
      "typeColor": const Color(0xFF6366F1),
      "typeBg": const Color(0xFFEEF2FF),
      "date": "4 Oct 2026",
      "venue": "Seminar Hall 2",
      "capacity": "180",
      "status": "Draft",
      "statusColor": const Color(0xFFD97706),
      "statusBg": const Color(0xFFFEF3C7),
      "updated": "22 Sept 2026",
    },
    {
      "id": "EVT-1002",
      "title": "Smart India Hackathon — internal",
      "type": "Hackathon",
      "typeColor": const Color(0xFF0284C7),
      "typeBg": const Color(0xFFF0F9FF),
      "date": "6 Oct 2026",
      "venue": "Innovation Lab",
      "capacity": "300",
      "status": "Published",
      "statusColor": const Color(0xFF0D9488),
      "statusBg": const Color(0xFFCCFBF1),
      "updated": "21 Sept 2026",
    },
    {
      "id": "EVT-1001",
      "title": "Techno Fest 2026",
      "type": "Cultural",
      "typeColor": const Color(0xFF8B5CF6),
      "typeBg": const Color(0xFFF5F3FF),
      "date": "10 Oct 2026",
      "venue": "Main Auditorium",
      "capacity": "1500",
      "status": "Published",
      "statusColor": const Color(0xFF0D9488),
      "statusBg": const Color(0xFFCCFBF1),
      "updated": "20 Sept 2026",
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

                // 2. FILTER PILLS
                _buildFilterPills(),
                const SizedBox(height: 18),

                // 3. TABLE CARD
                _buildTableCard(),
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
                  Icons.celebration_rounded,
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
                          "Campus Events",
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

                  // Title + Action (Responsive LayoutBuilder)
                  LayoutBuilder(
                    builder: (context, bannerConstraints) {
                      final isCompact = bannerConstraints.maxWidth < 680;

                      final iconWidget = Container(
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
                            color: Color(0xFFFBBF24), // Yellow Horn
                            size: 22,
                          ),
                        ),
                      );

                      final titleContent = Column(
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
                      );

                      final addEventButton = ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Add event modal opened",
                                  style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_rounded,
                            size: 16, color: Color(0xFF1E293B)),
                        label: Text(
                          "Add event",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5A93C),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );

                      if (isCompact) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                iconWidget,
                                const SizedBox(width: 14),
                                Expanded(child: titleContent),
                              ],
                            ),
                            const SizedBox(height: 14),
                            addEventButton,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconWidget,
                          const SizedBox(width: 14),
                          Expanded(child: titleContent),
                          const SizedBox(width: 14),
                          addEventButton,
                        ],
                      );
                    },
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
  // 2. FILTER PILLS (Image 1)
  // ===========================================================================
  Widget _buildFilterPills() {
    final pills = [
      {"label": "All", "count": 3},
      {"label": "Draft", "count": 1},
      {"label": "Published", "count": 2},
      {"label": "Completed", "count": 0},
      {"label": "Cancelled", "count": 0},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(pills.length, (index) {
          final isSelected = _activeFilterIndex == index;
          final p = pills[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _activeFilterIndex = index),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.2)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${p["count"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD (Image 1)
  // ===========================================================================
  Widget _buildTableCard() {
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
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: "Search by name, ID or type...",
                        hintStyle:
                            TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 18, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  "3 records",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 950),
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("EVENT TITLE")),
                  DataColumn(label: Text("TYPE")),
                  DataColumn(label: Text("DATE")),
                  DataColumn(label: Text("VENUE")),
                  DataColumn(label: Text("CAPACITY")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _events.map((e) {
                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          e["id"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Title
                      DataCell(
                        Text(
                          e["title"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Type Badge
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: e["typeBg"] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            e["type"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: e["typeColor"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Date
                      DataCell(
                        Text(
                          e["date"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Venue
                      DataCell(
                        Text(
                          e["venue"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Capacity
                      DataCell(
                        Text(
                          e["capacity"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Status Badge
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: e["statusBg"] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            e["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: e["statusColor"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          e["updated"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Actions
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              onPressed: () {},
                              tooltip: "View Event",
                              splashRadius: 18,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              onPressed: () {},
                              tooltip: "Edit Event",
                              splashRadius: 18,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFF64748B)),
                              onPressed: () {},
                              tooltip: "Delete Event",
                              splashRadius: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // Pagination Footer
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page 1 of 1",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: null, // Disabled
                      icon: const Icon(Icons.chevron_left_rounded, size: 14),
                      label: const Text("Prev"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF94A3B8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: null, // Disabled
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF94A3B8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        children: const [
                          Text("Next"),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right_rounded, size: 14),
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
