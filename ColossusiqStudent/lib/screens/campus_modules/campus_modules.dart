import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/portal_page_body.dart';
import '../../core/widgets/responsive_search_bar.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Campus Events Screen [P3] (Image 4)
/// ─────────────────────────────────────────────────────────────────────────────
class CampusEventsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CampusEventsScreen({super.key, this.onBack});

  @override
  State<CampusEventsScreen> createState() => _CampusEventsScreenState();
}

class _CampusEventsScreenState extends State<CampusEventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "All";

  void _showEventDetailsDialog(Map<String, dynamic> e) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.event_note_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("${e["id"]} · ${e["type"]}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date & Venue", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${e["date"]} · ${e["venue"]}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                        child: Text(e["status"] as String, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.people_outline_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Capacity: ${e["capacity"]} attendees · Updated: ${e["updated"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Event Description & Schedule", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "All enrolled students and campus community members are invited. Please arrive 15 minutes before opening remarks.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditEventDialog(e);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Event"),
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

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Campus Event", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Event Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: venueCtrl,
                  decoration: const InputDecoration(labelText: "Venue / Ground", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dateCtrl,
                        decoration: const InputDecoration(labelText: "Date", border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: capacityCtrl,
                        decoration: const InputDecoration(labelText: "Capacity", border: OutlineInputBorder()),
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
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Event '${e["title"]}' updated!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _events = [
    {
      "id": "EVT-1063",
      "title": "Sports day",
      "type": "Cultural",
      "typeColor": Color(0xFF4F46E5),
      "typeBg": Color(0xFFEEF2FF),
      "date": "7 Oct 2026",
      "venue": "Big Ground",
      "capacity": "250",
      "status": "Published",
      "updated": "6 Oct 2026",
    },
    {
      "id": "EVT-1057",
      "title": "Annuval Day",
      "type": "Workshop",
      "typeColor": Color(0xFF475569),
      "typeBg": Color(0xFFF1F5F9),
      "date": "15 Oct 2026",
      "venue": "Auditorium",
      "capacity": "250",
      "status": "Published",
      "updated": "6 Oct 2026",
    },
    {
      "id": "EVT-1021",
      "title": "Full Stack Web Development Workshop",
      "type": "Workshop",
      "typeColor": Color(0xFF475569),
      "typeBg": Color(0xFFF1F5F9),
      "date": "10 Oct 2026",
      "venue": "Computer Lab, College Campus",
      "capacity": "100",
      "status": "Published",
      "updated": "3 Oct 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredEvents = _events.where((e) {
      final matchesSearch = query.isEmpty ||
          e["title"].toLowerCase().contains(query) ||
          e["id"].toLowerCase().contains(query) ||
          e["type"].toLowerCase().contains(query);
      final matchesTab = _selectedTab == "All" || e["status"] == _selectedTab;
      return matchesSearch && matchesTab;
    }).toList();

    return PortalPageBody(
      title: "Campus Events",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner with View Only lock badge
        BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Campus Events",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.celebration_rounded,
          title: "Campus Events",
          subtitle: "College and department events, seminars, workshops, cultural and alumni events.",
          watermarkIcon: Icons.celebration_rounded,
          action: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 13, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  "View only",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // 2. Status summary tabs (All 3, Draft 0, Published 3, Completed 0, Cancelled 0)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _statusTab("All", 3),
              const SizedBox(width: 8),
              _statusTab("Draft", 0),
              const SizedBox(width: 8),
              _statusTab("Published", 3),
              const SizedBox(width: 8),
              _statusTab("Completed", 0),
              const SizedBox(width: 8),
              _statusTab("Cancelled", 0),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Records Card with Search, Table & Pagination
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Header inside card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (_) => setState(() {}),
                                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                decoration: InputDecoration(
                                  hintText: "Search by name, ID or type...",
                                  hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () => setState(() => _searchController.clear()),
                                child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${filteredEvents.length} records",
                        style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 680) {
                    return _buildEventsMobileList(filteredEvents);
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 880),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 26,
                    columns: const [
                      DataColumn(label: SizedBox(width: 85, child: Text("ID"))),
                      DataColumn(label: Text("EVENT TITLE")),
                      DataColumn(label: Text("TYPE")),
                      DataColumn(label: Text("DATE")),
                      DataColumn(label: Text("VENUE")),
                      DataColumn(label: Text("CAPACITY")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("UPDATED")),
                      DataColumn(label: Text("ACTIONS")),
                    ],
                    rows: filteredEvents.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              e["id"],
                              style: GoogleFonts.sourceCodePro(
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
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: e["typeBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e["type"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: e["typeColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["date"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["venue"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["capacity"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e["status"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["updated"],
                              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF0F766E)),
                                  onPressed: () => _showEventDetailsDialog(e),
                                  tooltip: "View details",
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF4338CA)),
                                  onPressed: () => _showEditEventDialog(e),
                                  tooltip: "Edit event",
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Pagination Footer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Page 1 of 1",
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.chevron_left, size: 16, color: Color(0xFF94A3B8)),
                              Text("Prev", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Text("Next", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
                              const Icon(Icons.chevron_right, size: 16, color: Color(0xFF94A3B8)),
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
      ],
    );
  }

  Widget _buildEventsMobileList(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            "No events found",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE5E7EB)),
      itemBuilder: (context, index) {
        final e = events[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["id"],
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: e["typeBg"],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["type"],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: e["typeColor"],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["status"],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                e["title"],
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    e["date"],
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.place_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      e["venue"],
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 13, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        "Cap: ${e["capacity"]}",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Upd: ${e["updated"]}",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _showEventDetailsDialog(e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            "View",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _showEditEventDialog(e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4338CA),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusTab(String label, int count) {
    final isSelected = _selectedTab == label;
    return InkWell(
      onTap: () => setState(() => _selectedTab = label),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Clubs Screen [P3] (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class ClubsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ClubsScreen({super.key, this.onBack});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  void _showClubDetailsDialog(Map<String, dynamic> club) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.groups_outlined, color: Color(0xFF4F46E5), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(club["name"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(club["category"] as String, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Club Lead", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(club["lead"] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                        child: Text("${club["members"]} Members", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.event_available_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Activity: ${club["activity"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("About the Community", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Student-run club hosting workshops, hackathons, guest speakers, and project showcases across the academic calendar.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditClubMembershipDialog(club);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Membership"),
          ),
        ],
      ),
    );
  }

  void _showEditClubMembershipDialog(Map<String, dynamic> club) {
    final roleCtrl = TextEditingController(text: "Active Member");
    final interestCtrl = TextEditingController(text: "Competitive programming, open-source projects");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Club Participation", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: roleCtrl,
                  decoration: const InputDecoration(labelText: "Your Role / Contribution", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: interestCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Interest Focus Areas", border: OutlineInputBorder()),
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
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Membership preferences for '${club["name"]}' saved!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Preferences", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _clubs = [
    {
      "name": "Coding Club",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "40",
      "lead": "Arjun Varma",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "Robotics Society",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "77",
      "lead": "Meera Nair",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "AI & Data Science Circle",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "114",
      "lead": "Harish Patel",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "Tamil Mandram",
      "category": "Cultural",
      "categoryColor": Color(0xFF059669),
      "categoryBg": Color(0xFFECFDF5),
      "members": "151",
      "lead": "Kavya Gupta",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "Music Club",
      "category": "Cultural",
      "categoryColor": Color(0xFF059669),
      "categoryBg": Color(0xFFECFDF5),
      "members": "188",
      "lead": "Nikhil Sharma",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "NSS Unit",
      "category": "Social",
      "categoryColor": Color(0xFF2563EB),
      "categoryBg": Color(0xFFEFF6FF),
      "members": "65",
      "lead": "Pooja Das",
      "activity": "Weekly contest — Sat",
    },
    {
      "name": "Entrepreneurship Cell",
      "category": "Innovation",
      "categoryColor": Color(0xFFD97706),
      "categoryBg": Color(0xFFFFFBEB),
      "members": "102",
      "lead": "Sanjay Balaji",
      "activity": "Weekly contest — Sat",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredClubs = _clubs.where((c) {
      final matchesSearch = query.isEmpty ||
          c["name"].toLowerCase().contains(query) ||
          c["lead"].toLowerCase().contains(query) ||
          c["category"].toLowerCase().contains(query);
      final matchesFilter = _filter == "All" || c["category"] == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return PortalPageBody(
      title: "Clubs",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Clubs",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.flag_outlined,
          title: "Clubs",
          subtitle: "Technical, cultural and social clubs, membership and activities.",
          watermarkIcon: Icons.flag_outlined,
        ),
        const SizedBox(height: 20),

        // 2. 4 Stat Summary Cards Row
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 850) {
              return Row(
                children: [
                  Expanded(child: _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                ],
              );
            } else if (w > 500) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  const SizedBox(height: 12),
                  _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Clubs Table Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search & Filter Header (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 640;
                  if (isNarrow) {
                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (_) => setState(() {}),
                                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                    decoration: InputDecoration(
                                      hintText: "Search clubs...",
                                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () => setState(() => _searchController.clear()),
                                    child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 6),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _filter,
                                        isDense: true,
                                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                        items: const [
                                          DropdownMenuItem(value: "All", child: Text("All")),
                                          DropdownMenuItem(value: "Technical", child: Text("Technical")),
                                          DropdownMenuItem(value: "Cultural", child: Text("Cultural")),
                                          DropdownMenuItem(value: "Social", child: Text("Social")),
                                          DropdownMenuItem(value: "Innovation", child: Text("Innovation")),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _filter = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Start a club form opened.")),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "+ Start a club",
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
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 20, color: Color(0xFF64748B)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              hintText: "Search clubs...",
                              hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const Icon(Icons.filter_list_rounded, size: 18, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _filter,
                            isDense: true,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                            items: const [
                              DropdownMenuItem(value: "All", child: Text("All")),
                              DropdownMenuItem(value: "Technical", child: Text("Technical")),
                              DropdownMenuItem(value: "Cultural", child: Text("Cultural")),
                              DropdownMenuItem(value: "Social", child: Text("Social")),
                              DropdownMenuItem(value: "Innovation", child: Text("Innovation")),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _filter = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Start a club form opened.")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: Text(
                            "+ Start a club",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 780),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 32,
                    columns: const [
                      DataColumn(label: Text("CLUB")),
                      DataColumn(label: Text("CATEGORY")),
                      DataColumn(label: Text("MEMBERS")),
                      DataColumn(label: Text("STUDENT LEAD")),
                      DataColumn(label: Text("NEXT ACTIVITY")),
                      DataColumn(label: Text("ACTION")),
                    ],
                    rows: filteredClubs.map((club) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              club["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: club["categoryBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                club["category"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: club["categoryColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["members"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["lead"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["activity"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _showClubDetailsDialog(club),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "View",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F766E),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _showEditClubMembershipDialog(club),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4338CA),
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String label, String value, String sub, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
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
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}


/// ─────────────────────────────────────────────────────────────────────────────
/// Sports Screen [P3] (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class SportsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const SportsScreen({super.key, this.onBack});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  void _showSportDetailsDialog(Map<String, dynamic> sport) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sports_soccer_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sport["sport"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(sport["team"] as String, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Head Coach", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(sport["coach"] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: sport["statusBg"] as Color? ?? const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          sport["status"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: sport["statusColor"] as Color? ?? const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Schedule: ${sport["upcoming"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Varsity Team Overview", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Varsity athletic squad competing in inter-collegiate zonal championships, state tournaments, and annual intramural leagues.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditSportTrialDialog(sport);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Registration"),
          ),
        ],
      ),
    );
  }

  void _showEditSportTrialDialog(Map<String, dynamic> sport) {
    final positionCtrl = TextEditingController(text: "Forward / Midfielder");
    final jerseyCtrl = TextEditingController(text: "10");
    final experienceCtrl = TextEditingController(text: "3 years school & club level competition experience.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Sports Trial Entry", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: positionCtrl,
                  decoration: const InputDecoration(labelText: "Playing Position", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jerseyCtrl,
                  decoration: const InputDecoration(labelText: "Preferred Jersey No.", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: experienceCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Previous Sports Experience", border: OutlineInputBorder()),
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
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Trial registration for '${sport["sport"]}' saved!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Entry", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _sports = [
    {
      "sport": "Cricket",
      "team": "AIT Titans",
      "coach": "Coach Sanjay",
      "upcoming": "Zonal meet · Oct 10",
      "status": "Trials open",
      "statusBg": Color(0xFFECFDF5),
      "statusColor": Color(0xFF059669),
    },
    {
      "sport": "Football",
      "team": "AIT Strikers",
      "coach": "Coach Lakshmi",
      "upcoming": "Zonal meet · Oct 12",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
    {
      "sport": "Basketball",
      "team": "Hoopers",
      "coach": "Coach Rohan",
      "upcoming": "Zonal meet · Oct 14",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
    {
      "sport": "Volleyball",
      "team": "Spikers",
      "coach": "Coach Nandini",
      "upcoming": "Zonal meet · Oct 16",
      "status": "Trials open",
      "statusBg": Color(0xFFECFDF5),
      "statusColor": Color(0xFF059669),
    },
    {
      "sport": "Athletics",
      "team": "Track squad",
      "coach": "Coach Suresh",
      "upcoming": "Zonal meet · Oct 18",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredSports = _sports.where((s) {
      final matchesSearch = query.isEmpty ||
          s["sport"].toLowerCase().contains(query) ||
          s["team"].toLowerCase().contains(query) ||
          s["coach"].toLowerCase().contains(query);
      final matchesFilter = _filter == "All" || s["status"] == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return PortalPageBody(
      title: "Sports",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Sports",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.sports_soccer_outlined,
          title: "Sports",
          subtitle: "Teams, tournaments, registrations and achievements.",
          watermarkIcon: Icons.sports_soccer_outlined,
        ),
        const SizedBox(height: 20),

        // 2. 4 Stat Summary Cards Row
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 850) {
              return Row(
                children: [
                  Expanded(child: _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                ],
              );
            } else if (w > 500) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  const SizedBox(height: 12),
                  _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Sports Table Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search & Filter Header (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 640;
                  if (isNarrow) {
                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (_) => setState(() {}),
                                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                    decoration: InputDecoration(
                                      hintText: "Search sports...",
                                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () => setState(() => _searchController.clear()),
                                    child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 6),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _filter,
                                        isDense: true,
                                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                        items: const [
                                          DropdownMenuItem(value: "All", child: Text("All")),
                                          DropdownMenuItem(value: "Trials open", child: Text("Trials open")),
                                          DropdownMenuItem(value: "Active", child: Text("Active")),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _filter = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Register for sports trials modal opened.")),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "+ Register",
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
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 20, color: Color(0xFF64748B)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              hintText: "Search sports...",
                              hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const Icon(Icons.filter_list_rounded, size: 18, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _filter,
                            isDense: true,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                            items: const [
                              DropdownMenuItem(value: "All", child: Text("All")),
                              DropdownMenuItem(value: "Trials open", child: Text("Trials open")),
                              DropdownMenuItem(value: "Active", child: Text("Active")),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _filter = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Register for sports trials modal opened.")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: Text(
                            "+ Register",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 780),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 32,
                    columns: const [
                      DataColumn(label: Text("SPORT")),
                      DataColumn(label: Text("TEAM")),
                      DataColumn(label: Text("COACH")),
                      DataColumn(label: Text("UPCOMING")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("ACTION")),
                    ],
                    rows: filteredSports.map((sport) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              sport["sport"],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["team"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["coach"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["upcoming"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: sport["statusBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                sport["status"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: sport["statusColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _showSportDetailsDialog(sport),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "View",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F766E),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _showEditSportTrialDialog(sport),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4338CA),
                                      ),
                                    ),
                                  ),
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
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Pagination Footer (Matching screenshot)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 620;
                    final infoSection = Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 14,
                      runSpacing: 8,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            children: const [
                              TextSpan(text: "Showing "),
                              TextSpan(text: "1 to 5", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                              TextSpan(text: " of "),
                              TextSpan(text: "7", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                              TextSpan(text: " sports teams"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Per page:", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("5 ▾", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF1E293B))),
                            ),
                          ],
                        ),
                      ],
                    );

                    final controlsSection = SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Page 1 of 2", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left, size: 15, color: Color(0xFF94A3B8)),
                                Text("Prev", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("1", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("2", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                          ),
                          const SizedBox(width: 6),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              children: [
                                Text("Next", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155))),
                                const Icon(Icons.chevron_right, size: 15, color: Color(0xFF334155)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    if (isNarrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoSection,
                          const SizedBox(height: 12),
                          controlsSection,
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        infoSection,
                        controlsSection,
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String label, String value, String sub, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
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
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Experience Passport Screen [P3] (Image 2)
/// ─────────────────────────────────────────────────────────────────────────────
class ExperiencePassportScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ExperiencePassportScreen({super.key, this.onBack});

  @override
  State<ExperiencePassportScreen> createState() => _ExperiencePassportScreenState();
}

class _ExperiencePassportScreenState extends State<ExperiencePassportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Experience Passport",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Experience Passport",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.star_rounded,
          title: "Experience Passport",
          subtitle: "Volunteering, leadership, competitions, conferences and social service — verified.",
          watermarkIcon: Icons.star_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive Search & Action Bar (Image 4)
        ResponsiveSearchBar(
          controller: _searchController,
          hintText: "Search experience passport...",
          filterValue: _filter,
          filterOptions: const ["All", "Volunteering", "Leadership", "Competitions"],
          onFilterChanged: (val) {
            if (val != null) setState(() => _filter = val);
          },
          actionLabel: "Add activity",
          onActionPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Add activity form opened.")),
            );
          },
        ),
        const SizedBox(height: 20),

        // 3. Light Blueprint Grid Empty State (Image 2)
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightBlueprintGridPainter(),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No matching records",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Try a different search or filter.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Refresh Zone Screen [P3] (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class RefreshZoneScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const RefreshZoneScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Refresh Zone",
      category: "Campus Life",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Refresh Zone",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.sports_esports_rounded,
          title: "Refresh Zone",
          subtitle: "Brain, memory, logic and word games, coding challenges and quiz battles.",
          watermarkIcon: Icons.sports_esports_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Games Grid (Image 3)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final crossAxisCount = w > 850 ? 3 : (w > 540 ? 2 : 1);

            final items = [
              _GameCardData(
                category: "Memory",
                categoryBg: Color(0xFFECFDF5),
                categoryColor: Color(0xFF059669),
                duration: "3 min",
                title: "Memory Match",
                desc: "Short-term memory card game",
              ),
              _GameCardData(
                category: "Logical reasoning",
                categoryBg: Color(0xFFEEF2FF),
                categoryColor: Color(0xFF4F46E5),
                duration: "5 min",
                title: "Logic Grid",
                desc: "Deduction puzzles",
              ),
              _GameCardData(
                category: "Word",
                categoryBg: Color(0xFFFFFBEB),
                categoryColor: Color(0xFFD97706),
                duration: "3 min",
                title: "Word Ladder",
                desc: "Vocabulary builder",
              ),
              _GameCardData(
                category: "Coding challenge",
                categoryBg: Color(0xFFEFF6FF),
                categoryColor: Color(0xFF2563EB),
                duration: "10 min",
                title: "SQL Sprint",
                desc: "Race to write correct queries",
              ),
              _GameCardData(
                category: "Quiz",
                categoryBg: Color(0xFFFEF2F2),
                categoryColor: Color(0xFFDC2626),
                duration: "Live",
                title: "Quiz Battle",
                desc: "Challenge a classmate on DBMS",
              ),
              _GameCardData(
                category: "Team",
                categoryBg: Color(0xFFFFF7ED),
                categoryColor: Color(0xFFEA580C),
                duration: "This Friday",
                title: "Campus Challenge",
                desc: "Department vs department trivia",
              ),
            ];

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 130,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Launching ${item.title}...")),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: item.categoryBg,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.category,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: item.categoryColor,
                                ),
                              ),
                            ),
                            Text(
                              item.duration,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.desc,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _GameCardData {
  final String category;
  final Color categoryBg;
  final Color categoryColor;
  final String duration;
  final String title;
  final String desc;

  _GameCardData({
    required this.category,
    required this.categoryBg,
    required this.categoryColor,
    required this.duration,
    required this.title,
    required this.desc,
  });
}

/// ─────────────────────────────────────────────────────────────────────────────
/// XP & Badges Screen [P3] (Image 4)
/// ─────────────────────────────────────────────────────────────────────────────
class XpBadgesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const XpBadgesScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "XP & Badges",
      category: "Campus Life",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  XP & Badges",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.emoji_events_rounded,
          title: "XP & Badges",
          subtitle: "Streaks, badges, skill points and configurable leaderboards.",
          watermarkIcon: Icons.emoji_events_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Badges Grid (Image 4)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final crossAxisCount = w > 850 ? 3 : (w > 540 ? 2 : 1);

            final badges = [
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFFEF3C7),
                pillColor: Color(0xFFD97706),
                statusRight: "Earned",
                title: "7-Day Learning Streak",
                subtitle: "Studied every day for a week",
                progressValue: 1.0,
                progressColor: Color(0xFFD97706),
              ),
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFECFDF5),
                pillColor: Color(0xFF059669),
                statusRight: "Earned",
                title: "First Project Completed",
                subtitle: "Shipped your first project",
                progressValue: 1.0,
                progressColor: Color(0xFF0F766E),
              ),
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFEEF2FF),
                pillColor: Color(0xFF4F46E5),
                statusRight: "84 / 100",
                title: "100 Questions Solved",
                subtitle: "Across all subjects",
                progressValue: 0.84,
                progressColor: AppColors.primaryBlue,
              ),
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFEFF6FF),
                pillColor: Color(0xFF2563EB),
                statusRight: "Earned",
                title: "First Mock Interview",
                subtitle: "Completed an AI interview",
                progressValue: 1.0,
                progressColor: Color(0xFF2563EB),
              ),
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFFFFBEB),
                pillColor: Color(0xFFD97706),
                statusRight: "59 / 65",
                title: "Communication Level Up",
                subtitle: "Reach Intermediate+",
                progressValue: 59.0 / 65.0,
                progressColor: Color(0xFFC2410C),
              ),
              _BadgeData(
                pillText: "Badge",
                pillBg: Color(0xFFFEF2F2),
                pillColor: Color(0xFFDC2626),
                statusRight: "Earned",
                title: "Hackathon Participant",
                subtitle: "Joined a hackathon",
                progressValue: 1.0,
                progressColor: Color(0xFFDC2626),
              ),
            ];

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: badges.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 135,
              ),
              itemBuilder: (context, index) {
                final b = badges[index];
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: b.pillBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              b.pillText,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: b.pillColor,
                              ),
                            ),
                          ),
                          Text(
                            b.statusRight,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.title,
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            b.subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: b.progressValue,
                          minHeight: 4,
                          backgroundColor: const Color(0xFFF1F5F9),
                          valueColor: AlwaysStoppedAnimation<Color>(b.progressColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _BadgeData {
  final String pillText;
  final Color pillBg;
  final Color pillColor;
  final String statusRight;
  final String title;
  final String subtitle;
  final double progressValue;
  final Color progressColor;

  _BadgeData({
    required this.pillText,
    required this.pillBg,
    required this.pillColor,
    required this.statusRight,
    required this.title,
    required this.subtitle,
    required this.progressValue,
    required this.progressColor,
  });
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Wellness & Habits Screen [P3] (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class WellnessHabitsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const WellnessHabitsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Wellness & Habits",
      category: "Campus Life",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Wellness & Habits",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.favorite_rounded,
          title: "Wellness & Habits",
          subtitle: "Educational content on sleep, hydration, breaks, screen time and healthy routines.",
          watermarkIcon: Icons.favorite_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Notice Banner (Image 5)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 18,
                color: Color(0xFFD97706),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "This area is educational and non-diagnostic. If you are struggling, please reach out to your student counsellor or the Student Welfare Office. In an emergency, call 112 (India).",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 3. Responsive Content & Sidebars
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildRoutineCard(),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        _infoCallout("Educational guidance only — not medical advice."),
                        const SizedBox(height: 14),
                        _infoCallout("Student Welfare Office: Block C, Room 104 · Counsellor hours 10:00–17:00."),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRoutineCard(),
                  const SizedBox(height: 18),
                  _infoCallout("Educational guidance only — not medical advice."),
                  const SizedBox(height: 12),
                  _infoCallout("Student Welfare Office: Block C, Room 104 · Counsellor hours 10:00–17:00."),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildRoutineCard() {
    final routines = [
      _RoutineItem(
        time: "Morning",
        desc: "10 minutes of light movement and sunlight",
        barColor: Color(0xFF0F766E),
        tag: "Activity",
        tagBg: Color(0xFFECFDF5),
        tagColor: Color(0xFF059669),
      ),
      _RoutineItem(
        time: "Every 45 min",
        desc: "5-minute study break, look away from screens",
        barColor: Color(0xFF2563EB),
        tag: "Breaks",
        tagBg: Color(0xFFEFF6FF),
        tagColor: Color(0xFF2563EB),
      ),
      _RoutineItem(
        time: "All day",
        desc: "Aim for regular water intake",
        barColor: Color(0xFF2563EB),
        tag: "Hydration",
        tagBg: Color(0xFFEFF6FF),
        tagColor: Color(0xFF2563EB),
      ),
      _RoutineItem(
        time: "Evening",
        desc: "Screen-free wind-down 30 minutes before bed",
        barColor: AppColors.primaryBlue,
        tag: "Sleep",
        tagBg: Color(0xFFEEF2FF),
        tagColor: Color(0xFF4F46E5),
      ),
      _RoutineItem(
        time: "Night",
        desc: "Consistent 7–8 hour sleep window",
        barColor: AppColors.primaryBlue,
        tag: "Sleep",
        tagBg: Color(0xFFEEF2FF),
        tagColor: Color(0xFF4F46E5),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Healthy routine suggestions",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 18),
          ...routines.map((r) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 105,
                    child: Text(
                      r.time,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  Container(
                    width: 3.5,
                    height: 20,
                    decoration: BoxDecoration(
                      color: r.barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      r.desc,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: r.tagBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      r.tag,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: r.tagColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _infoCallout(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 18,
            color: Color(0xFF1D4ED8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E3A8A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineItem {
  final String time;
  final String desc;
  final Color barColor;
  final String tag;
  final Color tagBg;
  final Color tagColor;

  _RoutineItem({
    required this.time,
    required this.desc,
    required this.barColor,
    required this.tag,
    required this.tagBg,
    required this.tagColor,
  });
}

/// Light Blueprint Grid Painter for empty states
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/// Campus Assistant Screen [P3]
/// Matches ColossusIQ web UI design with Blueprint hero banner, context chips,
/// knowledge agent intro, suggestion prompt pills, agent sidebar/disclaimer, and interactive chat.
class CampusAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CampusAssistantScreen({super.key, this.onBack});

  @override
  State<CampusAssistantScreen> createState() => _CampusAssistantScreenState();
}

class _CampusAssistantMessage {
  final String sender; // "user" or "agent"
  final String text;
  final String? citation;
  final DateTime time;

  _CampusAssistantMessage({
    required this.sender,
    required this.text,
    this.citation,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}

class _CampusAssistantScreenState extends State<CampusAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<_CampusAssistantMessage> _messages = [];
  bool _isTyping = false;

  final List<Map<String, dynamic>> _suggestions = [
    {
      "icon": Icons.lightbulb_outline,
      "text": "Where is the placement office?",
    },
    {
      "icon": Icons.calendar_today_outlined,
      "text": "What is the exam application process?",
    },
    {
      "icon": Icons.trending_up_outlined,
      "text": "How can I register for sports?",
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final query = text.trim();
    if (query.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(_CampusAssistantMessage(
        sender: "user",
        text: query,
      ));
      _isTyping = true;
    });

    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      String reply = "";
      String citation = "";

      final lower = query.toLowerCase();
      if (lower.contains("placement")) {
        reply =
            "The Central Placement & Training Cell is located in Admin Block A, 2nd Floor (Room 204). Office hours: 9:00 AM – 5:30 PM (Mon–Fri). Verified contact: placement@ait.edu.in.";
        citation = "Campus Directory & Placement Cell Guide, p. 12";
      } else if (lower.contains("exam") || lower.contains("application")) {
        reply =
            "Semester exam applications open on November 1 through the Student Portal under 'Assessments & Examinations'. Ensure all tuition dues are cleared and minimum 75% attendance criteria are met prior to hall ticket generation.";
        citation = "Academic Regulations 2024-25 §7.1";
      } else if (lower.contains("sport") || lower.contains("register")) {
        reply =
            "Registration for varsity teams and intramural sports tournaments is handled at the Directorate of Physical Education (Indoor Sports Stadium) or online via the Campus Life > Sports tab.";
        citation = "Student Welfare Handbook §9.3";
      } else {
        reply =
            "According to verified institutional documentation, Anna Institute of Technology provides accredited coursework and campus facilities under standard academic guidelines. Please consult your academic advisor for individualized exemptions.";
        citation = "Student Handbook 2024-25 §4.2";
      }

      setState(() {
        _isTyping = false;
        _messages.add(_CampusAssistantMessage(
          sender: "agent",
          text: reply,
          citation: citation,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Campus Assistant",
      category: "Campus Life",
      onBack: widget.onBack,
      badge: const AppBadge(label: "PHASE 3", tone: BadgeTone.brand),
      children: [
        // 1. Hero Glow Blueprint Banner matching Web UI
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Campus Assistant",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          icon: Icons.school_outlined,
          watermarkIcon: Icons.school_outlined,
          title: "Campus Assistant",
          subtitle: "Ask anything about your campus — answered from institution-approved sources.",
        ),
        const SizedBox(height: 18),

        // 2. Context Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hub_outlined, size: 14, color: AppColors.ink3),
                  const SizedBox(width: 5),
                  Text(
                    "CONTEXT",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink3,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  "Knowledge base: 8 approved documents",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  "Campus: Main",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 3. Knowledge Agent Greeting Box
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bot avatar
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.smart_toy_outlined, color: Color(0xFFE5B84A), size: 19),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF162044).withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Knowledge Agent",
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.ink2, height: 1.45),
                        children: const [
                          TextSpan(text: "Ask me anything about Anna Institute of Technology. I answer from "),
                          TextSpan(
                            text: "institution-approved sources",
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1B2233)),
                          ),
                          TextSpan(text: " and cite them."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 4. Suggested Prompts Cards
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _suggestions.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => _sendMessage(s["text"] as String),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF162044).withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(s["icon"] as IconData, size: 16, color: const Color(0xFF4A5BD4)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            s["text"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF9CA3AF)),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // 5. Chat History (if user interacted)
        if (_messages.isNotEmpty) ...[
          const SizedBox(height: 12),
          ..._messages.map((m) {
            final isUser = m.sender == "user";
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser) ...[
                    Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(top: 2, right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.smart_toy_outlined, color: Color(0xFFE5B84A), size: 16),
                      ),
                    ),
                  ],
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primaryBlue : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: isUser ? null : Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.text,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: isUser ? Colors.white : AppColors.ink,
                              height: 1.45,
                            ),
                          ),
                          if (m.citation != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0ECF8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Institution source: ${m.citation!}",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1D5FA8),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],

        if (_isTyping) ...[
          Padding(
            padding: const EdgeInsets.only(left: 44, bottom: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryBlue),
                ),
                const SizedBox(width: 8),
                Text(
                  "Knowledge Agent is retrieving verified sources...",
                  style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 14),

        // 6. Side Cards (Agent Info & Disclaimer from Screenshot 1 right panel)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AGENT",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink3,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Knowledge Agent",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Institution-specific RAG assistant with source citations.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: AppColors.ink2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 7. Sky Notice Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 18, color: Color(0xFF1D5FA8)),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B), height: 1.45),
                    children: const [
                      TextSpan(text: "Answers marked "),
                      TextSpan(
                        text: "Institution source",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            " come from approved documents. Everything else is a general AI explanation — verify before relying on it.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 8. Bottom Message Input Bar matching screenshot
        Container(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF162044).withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onSubmitted: _sendMessage,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 13.5, color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: "Message Knowledge Agent...",
                    hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: const Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _sendMessage(_messageController.text),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0ECF8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.send_rounded, size: 17, color: Color(0xFF1D5FA8)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // 9. Input Footer Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                  style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${_messageController.text.length}/2000",
                style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Alumni Network Screen [P3]
/// Matches ColossusIQ web UI design with Blueprint hero banner, filter search bar,
/// "Request mentorship" action, and notebook grid empty state / verified alumni cards.
class AlumniNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AlumniNetworkScreen({super.key, this.onBack});

  @override
  State<AlumniNetworkScreen> createState() => _AlumniNetworkScreenState();
}

class AlumniRecord {
  final String name;
  final String role;
  final String company;
  final String batch;
  final String mentorship;
  final String domain;

  const AlumniRecord({
    required this.name,
    required this.role,
    required this.company,
    required this.batch,
    required this.mentorship,
    required this.domain,
  });
}

class _AlumniNetworkScreenState extends State<AlumniNetworkScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";

  static const List<AlumniRecord> _allAlumni = [
    AlumniRecord(
      name: "Priya Sundaram",
      batch: "Class of 2022",
      role: "Senior Software Engineer",
      company: "Google, Mountain View",
      mentorship: "Distributed Systems & US Masters Prep",
      domain: "Tech & Cloud",
    ),
    AlumniRecord(
      name: "Vigneshwaran K",
      batch: "Class of 2020",
      role: "Founder & CTO",
      company: "NeuralWave AI (YC W23)",
      mentorship: "Startup Fundraising & DeepTech MVPs",
      domain: "Founders",
    ),
    AlumniRecord(
      name: "Sneha Narayan",
      batch: "Class of 2023",
      role: "Cloud Infrastructure Engineer",
      company: "Microsoft IDC",
      mentorship: "Campus Placement & Resume Reviews",
      domain: "Tech & Cloud",
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AlumniRecord> get _filteredAlumni {
    final query = _searchController.text.trim().toLowerCase();
    return _allAlumni.where((a) {
      final matchesSearch = query.isEmpty ||
          a.name.toLowerCase().contains(query) ||
          a.company.toLowerCase().contains(query) ||
          a.mentorship.toLowerCase().contains(query) ||
          a.role.toLowerCase().contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilter == "Tech & Cloud") {
        return a.domain == "Tech & Cloud";
      } else if (_selectedFilter == "Founders") {
        return a.domain == "Founders";
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredAlumni;

    return PortalPageBody(
      title: "Alumni Network",
      category: "Campus Life",
      onBack: widget.onBack,
      badge: const AppBadge(label: "PHASE 3", tone: BadgeTone.brand),
      children: [
        // 1. Hero Glow Blueprint Banner matching web screenshot
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Alumni Network",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          icon: Icons.lan_outlined,
          watermarkIcon: Icons.chair_alt_outlined,
          title: "Alumni Network",
          subtitle: "Mentors, speakers, recruiters and project advisors matched to your goals.",
        ),
        const SizedBox(height: 18),

        // 2. Search, Filter, and Action Bar matching Web UI
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEBEFF4), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF162044).withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: "Search alumni network...",
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF)),
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
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.close, size: 16, color: Color(0xFF9CA3AF)),
                  ),
                ),
              Container(
                height: 22,
                width: 1,
                color: const Color(0xFFE5E7EB),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              // Filter Dropdown
              PopupMenuButton<String>(
                initialValue: _selectedFilter,
                onSelected: (val) => setState(() => _selectedFilter = val),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list, size: 15, color: Color(0xFF6B7280)),
                    const SizedBox(width: 4),
                    Text(
                      _selectedFilter,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6B7280)),
                  ],
                ),
                itemBuilder: (context) => [
                  _filterMenuItem("All"),
                  _filterMenuItem("Tech & Cloud"),
                  _filterMenuItem("Founders"),
                ],
              ),
              const SizedBox(width: 8),
              // "Request mentorship" button
              ElevatedButton(
                onPressed: _showRequestMentorshipModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Text(
                  "Request mentorship",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Results Container
        // If query is empty or simulate empty, display NotebookEmptyCard as in Screenshot 2
        if (list.isEmpty)
          const NotebookEmptyCard(
            title: "No matching records",
            subtitle: "Try a different search or filter.",
            height: 180,
          )
        else
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alumni Mentors (${list.length})",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _searchController.text = "empty_test";
                      setState(() {});
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Simulate Empty",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...list.map((alumni) => _buildAlumniCard(alumni)),
            ],
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  PopupMenuItem<String> _filterMenuItem(String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: _selectedFilter == value ? FontWeight.w600 : FontWeight.w400,
          color: _selectedFilter == value ? AppColors.primaryBlue : AppColors.ink,
        ),
      ),
    );
  }

  Widget _buildAlumniCard(AlumniRecord alumni) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEBEFF4), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF162044).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFE8EBF6),
                child: Text(
                  alumni.name[0],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${alumni.name} (${alumni.batch})",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      "${alumni.role} @ ${alumni.company}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4A5BD4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8F3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4DFD3), width: 0.8),
            ),
            child: Row(
              children: [
                const Icon(Icons.school_outlined, size: 16, color: Color(0xFF0F766E)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Mentorship: ${alumni.mentorship}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.ink2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Mentorship request sent to ${alumni.name}!"),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Request 1:1 Mentorship Session",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestMentorshipModal() {
    final topicController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Request Alumni Mentorship",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
              ),
              const SizedBox(height: 4),
              Text(
                "Connect with verified alumni for technical advice, career coaching, and interview prep.",
                style: GoogleFonts.poppins(fontSize: 12.5, color: AppColors.ink2),
              ),
              const SizedBox(height: 16),
              Text("Mentorship Topic / Goal", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextField(
                controller: topicController,
                decoration: InputDecoration(
                  hintText: "e.g., Google interview prep or YC startup guidance",
                  hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF9CA3AF)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mentorship inquiry broadcast to matched alumni mentors!"),
                        backgroundColor: AppColors.primaryBlue,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Submit Mentorship Request",
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

