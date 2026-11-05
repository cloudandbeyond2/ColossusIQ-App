import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// CAMPUS LIFE: CAMPUS EVENTS SCREEN
// Exactly matches screenshot 4:
// - Blueprint grid hero banner with watermark & badges (CAMPUS LIFE, Phase 3)
//   and "+ Add event" amber button in banner
// - Filter tab pills: All 3, Draft 1, Published 2, Completed 0, Cancelled 0
// - Main Card with Table:
//     * Search input ("Search by name, ID or type...") and "3 records" counter
//     * Responsive Data Table with 9 columns: ID, EVENT TITLE, TYPE, DATE, VENUE,
//       CAPACITY, STATUS, UPDATED, ACTIONS (View, Edit, Delete)
//     * Pagination footer: "Page 1 of 1" with "< Prev" and "Next >"
// =============================================================================

class FacultyCampusEventsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyCampusEventsScreen({super.key, this.onBack});

  @override
  State<FacultyCampusEventsScreen> createState() =>
      _FacultyCampusEventsScreenState();
}

class _FacultyCampusEventsScreenState extends State<FacultyCampusEventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";
  String _searchQuery = "";

  final List<Map<String, dynamic>> _events = [
    {
      "id": "EVT-1003",
      "title": "Workshop: GenAI for Engineers",
      "type": "Workshop",
      "date": "4 Oct 2026",
      "venue": "Seminar Hall 2",
      "capacity": "180",
      "status": "Draft",
      "updated": "16 Sept 2026",
    },
    {
      "id": "EVT-1002",
      "title": "Smart India Hackathon — internal",
      "type": "Hackathon",
      "date": "6 Oct 2026",
      "venue": "Innovation Lab",
      "capacity": "300",
      "status": "Published",
      "updated": "15 Sept 2026",
    },
    {
      "id": "EVT-1001",
      "title": "Techno Fest 2026",
      "type": "Cultural",
      "date": "10 Oct 2026",
      "venue": "Main Auditorium",
      "capacity": "1500",
      "status": "Published",
      "updated": "14 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddEventDialog() {
    final titleCtrl = TextEditingController();
    final venueCtrl = TextEditingController(text: "Seminar Hall 1");
    final capacityCtrl = TextEditingController(text: "150");
    String typeVal = "Workshop";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.celebration_rounded,
                  color: Color(0xFFD97706), size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              "Plan Campus Event",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Event Title",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextField(
                controller: titleCtrl,
                style: GoogleFonts.poppins(fontSize: 13),
                decoration: InputDecoration(
                  hintText: "e.g. AI Symposium 2026",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Venue",
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: venueCtrl,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Capacity",
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: capacityCtrl,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel",
                style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isNotEmpty) {
                setState(() {
                  _events.insert(0, {
                    "id": "EVT-${1004 + _events.length}",
                    "title": titleCtrl.text.trim(),
                    "type": typeVal,
                    "date": "24 Oct 2026",
                    "venue": venueCtrl.text.trim(),
                    "capacity": capacityCtrl.text.trim(),
                    "status": "Draft",
                    "updated": "Today",
                  });
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Event created successfully!",
                        style: GoogleFonts.poppins()),
                    backgroundColor: const Color(0xFF0F766E),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD97706),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Create Event",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showViewEventDialog(Map<String, dynamic> e) {
    final isDraft = e["status"] == "Draft";
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_note_rounded, color: Color(0xFFD97706), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e["title"] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(e["id"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEventDetailRow("Type", e["type"] as String),
                _buildEventDetailRow("Date", e["date"] as String),
                _buildEventDetailRow("Venue", e["venue"] as String),
                _buildEventDetailRow("Expected Capacity", e["capacity"] as String),
                _buildEventDetailRow("Current Status", e["status"] as String,
                    statusColor: isDraft ? const Color(0xFFD97706) : const Color(0xFF15803D)),
                _buildEventDetailRow("Last Updated", e["updated"] as String),
              ],
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _showEditEventDialog(e);
              },
              icon: const Icon(Icons.edit_outlined, size: 14),
              label: Text("Edit", style: GoogleFonts.poppins()),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                foregroundColor: const Color(0xFF334155),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: Text("Close", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventDetailRow(String label, String value, {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(width: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: statusColor ?? const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditEventDialog(Map<String, dynamic> e) {
    final titleCtrl = TextEditingController(text: e["title"] as String);
    final venueCtrl = TextEditingController(text: e["venue"] as String);
    final dateCtrl = TextEditingController(text: e["date"] as String);
    final capacityCtrl = TextEditingController(text: e["capacity"] as String);
    String type = e["type"] as String;
    String status = e["status"] as String;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text("Edit Campus Event", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleCtrl,
                        decoration: const InputDecoration(labelText: "Event Title"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: type,
                              decoration: const InputDecoration(labelText: "Type"),
                              items: ["Academic", "Workshop", "Sports", "Cultural", "Hackathon"]
                                  .map((t) => DropdownMenuItem(value: t, child: Text(t, style: GoogleFonts.poppins(fontSize: 12.5))))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => type = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: status,
                              decoration: const InputDecoration(labelText: "Status"),
                              items: ["Published", "Draft"]
                                  .map((s) => DropdownMenuItem(value: s, child: Text(s, style: GoogleFonts.poppins(fontSize: 12.5))))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => status = val);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: venueCtrl,
                        decoration: const InputDecoration(labelText: "Venue"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: dateCtrl,
                              decoration: const InputDecoration(labelText: "Date & Time"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: capacityCtrl,
                              decoration: const InputDecoration(labelText: "Capacity"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      e["title"] = titleCtrl.text.trim();
                      e["venue"] = venueCtrl.text.trim();
                      e["date"] = dateCtrl.text.trim();
                      e["capacity"] = capacityCtrl.text.trim();
                      e["type"] = type;
                      e["status"] = status;
                      e["updated"] = "Today";
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Event '${e["title"]}' updated successfully!", style: GoogleFonts.poppins()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD97706),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteEventDialog(Map<String, dynamic> e) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Event?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to delete '${e["title"]}' (${e["id"]})? This cannot be undone.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                final removed = Map<String, dynamic>.from(e);
                final index = _events.indexOf(e);
                setState(() {
                  _events.remove(e);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Event '${removed["title"]}' deleted", style: GoogleFonts.poppins()),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _events.insert(index >= 0 ? index : 0, removed);
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: Text("Delete", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter events
    final filtered = _events.where((e) {
      final matchesFilter = _selectedFilter == "All" ||
          e["status"].toString().toLowerCase() ==
              _selectedFilter.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          e["title"].toString().toLowerCase().contains(_searchQuery) ||
          e["id"].toString().toLowerCase().contains(_searchQuery) ||
          e["type"].toString().toLowerCase().contains(_searchQuery) ||
          e["venue"].toString().toLowerCase().contains(_searchQuery);
      return matchesFilter && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Hero Blueprint Banner with "+ Add event" button
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Filter Pills Row
          _buildFilterPillsRow(),
          const SizedBox(height: 16),

          // 3. Main Card with Table
          _buildTableCard(filtered),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
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
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (clean, no leading arrow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Campus Life",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Campus Events",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "CAMPUS LIFE",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "Phase 3",
                        const Color(0xFFD97706),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title + Subtitle + Action Button
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 650;
                      final titleWidget = Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF232F6E),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                            ),
                            child: const Icon(
                              Icons.celebration_rounded,
                              color: Color(0xFFFBBF24),
                              size: 26,
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
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "College and department events, seminars, workshops, cultural and alumni events.",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );

                      final btnWidget = ElevatedButton.icon(
                        onPressed: _showAddEventDialog,
                        icon: const Icon(Icons.add_rounded, size: 16),
                        label: Text(
                          "Add event",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD97706),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleWidget,
                            const SizedBox(height: 14),
                            btnWidget,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: titleWidget),
                          const SizedBox(width: 16),
                          btnWidget,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. FILTER PILLS ROW
  // ===========================================================================
  Widget _buildFilterPillsRow() {
    final draftCount = _events.where((e) => e["status"] == "Draft").length;
    final publishedCount =
        _events.where((e) => e["status"] == "Published").length;
    final completedCount =
        _events.where((e) => e["status"] == "Completed").length;
    final cancelledCount =
        _events.where((e) => e["status"] == "Cancelled").length;

    final filters = [
      {"label": "All", "count": "${_events.length}"},
      {"label": "Draft", "count": "$draftCount"},
      {"label": "Published", "count": "$publishedCount"},
      {"label": "Completed", "count": "$completedCount"},
      {"label": "Cancelled", "count": "$cancelledCount"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter == f["label"];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = f["label"]!;
                });
              },
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f["label"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      f["count"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.8)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD
  // ===========================================================================
  Widget _buildTableCard(List<Map<String, dynamic>> filtered) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Bar + Record count
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val.trim().toLowerCase();
                        });
                      },
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: "Search by name, ID or type...",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF94A3B8),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "${filtered.length} records",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Data Table with Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 20,
              columnSpacing: 24,
              dataRowMinHeight: 56,
              dataRowMaxHeight: 64,
              headingRowHeight: 44,
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFAF9F6)),
              columns: [
                _buildDataColumn("ID"),
                _buildDataColumn("EVENT TITLE"),
                _buildDataColumn("TYPE"),
                _buildDataColumn("DATE"),
                _buildDataColumn("VENUE"),
                _buildDataColumn("CAPACITY"),
                _buildDataColumn("STATUS"),
                _buildDataColumn("UPDATED"),
                _buildDataColumn("ACTIONS"),
              ],
              rows: filtered.map((e) {
                final isDraft = e["status"] == "Draft";
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        e["id"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e["title"],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          e["type"],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4338CA),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e["date"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e["venue"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e["capacity"],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: isDraft
                              ? const Color(0xFFFEF3C7)
                              : const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          e["status"],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDraft
                                ? const Color(0xFF92400E)
                                : const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        e["updated"],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility_outlined,
                                size: 16, color: Color(0xFF64748B)),
                            onPressed: () => _showViewEventDialog(e),
                            tooltip: "View Event Details",
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined,
                                size: 16, color: Color(0xFF4338CA)),
                            onPressed: () => _showEditEventDialog(e),
                            tooltip: "Edit Event",
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded,
                                size: 16, color: Color(0xFFEF4444)),
                            onPressed: () => _showDeleteEventDialog(e),
                            tooltip: "Delete Event",
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Pagination Footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                    OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                        "‹ Prev",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: const Color(0xFF94A3B8)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                        "Next ›",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: const Color(0xFF94A3B8)),
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

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF64748B),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
