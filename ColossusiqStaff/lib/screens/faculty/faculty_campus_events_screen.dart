import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// CAMPUS LIFE: CAMPUS EVENTS SCREEN
// Matches screenshot exactly:
// - Blueprint grid hero banner with badges (CAMPUS LIFE, Phase 3)
//   and megaphone illustration
// - 4 Metric cards: Total Events (6), Upcoming (4), Ongoing (0), This Month (3)
// - Search events... TextField + All Types dropdown + All Status dropdown + + Create Event button
// - Event cards list with:
//     * Date box on left (Month abbreviation + Day in bold)
//     * Event title, Type pill, Status pill
//     * Meta row (time, venue, organizer with icons)
//     * Progress bar with capacity fraction (e.g. 60/60, 580/600)
//     * Actions: Edit pencil icon, Delete trash icon
// - Create Event dialog (matching Image 10) & Edit Event dialog
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
  String _selectedType = "All Types";
  String _selectedStatus = "All Status";

  final List<Map<String, dynamic>> _events = [
    {
      "id": "EVT-101",
      "title": "AI Workshop - Basics to Production",
      "type": "Workshop",
      "status": "Completed",
      "month": "OCT",
      "day": "15",
      "startDate": "10/15/2026",
      "endDate": "10/15/2026",
      "time": "10:00",
      "venue": "Lab 3, Block B",
      "organizer": "Dr. Anand V.",
      "capacity": 60,
      "registered": 60,
      "description":
          "Hands-on workshop covering fundamentals of AI models, fine-tuning, and production deployment.",
    },
    {
      "id": "EVT-102",
      "title": "Diwali Holiday",
      "type": "Holiday",
      "status": "Completed",
      "month": "OCT",
      "day": "20",
      "startDate": "10/20/2026",
      "endDate": "10/22/2026",
      "time": "",
      "venue": "",
      "organizer": "Administration",
      "capacity": 0,
      "registered": 0,
      "description": "College closed for festival of lights celebrations.",
    },
    {
      "id": "EVT-103",
      "title": "Annual Sports Meet",
      "type": "Sports",
      "status": "Upcoming",
      "month": "OCT",
      "day": "30",
      "startDate": "10/30/2026",
      "endDate": "10/31/2026",
      "time": "08:00 · ends 31 Oct 2026",
      "venue": "Sports Ground",
      "organizer": "Physical Education Dept",
      "capacity": 600,
      "registered": 580,
      "description":
          "Annual track and field athletics, inter-department tournaments, and championship award ceremony.",
    },
    {
      "id": "EVT-104",
      "title": "Tech Symposium 2026",
      "type": "Academic",
      "status": "Upcoming",
      "month": "NOV",
      "day": "5",
      "startDate": "11/05/2026",
      "endDate": "11/06/2026",
      "time": "10:00",
      "venue": "Auditorium",
      "organizer": "CSE Department",
      "capacity": 500,
      "registered": 320,
      "description":
          "Flagship technical symposium with hackathons, paper presentations, project exhibits, and keynote speakers.",
    },
    {
      "id": "EVT-105",
      "title": "Alumni Mentorship Conclave",
      "type": "Academic",
      "status": "Upcoming",
      "month": "NOV",
      "day": "12",
      "startDate": "11/12/2026",
      "endDate": "11/12/2026",
      "time": "14:00",
      "venue": "Seminar Hall A",
      "organizer": "Alumni Relations Office",
      "capacity": 200,
      "registered": 145,
      "description":
          "Connecting pre-final and final year students with industry alumni for career mentorship and resume reviews.",
    },
    {
      "id": "EVT-106",
      "title": "Inter-Collegiate Cultural Festival",
      "type": "Cultural",
      "status": "Upcoming",
      "month": "NOV",
      "day": "25",
      "startDate": "11/25/2026",
      "endDate": "11/27/2026",
      "time": "09:30",
      "venue": "Open Air Amphitheatre",
      "organizer": "Student Council & Fine Arts Club",
      "capacity": 1200,
      "registered": 850,
      "description":
          "Three days of dance, music, theater, visual arts, and literary competitions featuring colleges from across the region.",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Calculate dynamic stats
  int get _totalEvents => _events.length;
  int get _upcomingEvents =>
      _events.where((e) => e["status"] == "Upcoming").length;
  int get _ongoingEvents =>
      _events.where((e) => e["status"] == "Ongoing").length;
  int get _thisMonthEvents => _events.where((e) {
        final m = (e["month"] as String?)?.toUpperCase() ?? "";
        return m == "OCT";
      }).length;

  List<Map<String, dynamic>> get _filteredEvents {
    final q = _searchController.text.trim().toLowerCase();
    return _events.where((e) {
      if (_selectedType != "All Types" && e["type"] != _selectedType) {
        return false;
      }
      if (_selectedStatus != "All Status" && e["status"] != _selectedStatus) {
        return false;
      }
      if (q.isNotEmpty) {
        final title = (e["title"] as String).toLowerCase();
        final venue = (e["venue"] as String).toLowerCase();
        final organizer = (e["organizer"] as String).toLowerCase();
        if (!title.contains(q) && !venue.contains(q) && !organizer.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  // ===========================================================================
  // CREATE / EDIT EVENT MODAL DIALOG (Matching Image 10)
  // ===========================================================================
  void _showEventDialog({Map<String, dynamic>? eventToEdit}) {
    final isEditing = eventToEdit != null;

    final titleCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["title"] as String) : "",
    );
    String selectedType = isEditing ? (eventToEdit["type"] as String) : "Academic";
    String selectedStatus =
        isEditing ? (eventToEdit["status"] as String) : "Upcoming";

    final startDateCtrl = TextEditingController(
      text: isEditing
          ? (eventToEdit["startDate"] as String? ?? "10/30/2026")
          : "",
    );
    final endDateCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["endDate"] as String? ?? "") : "",
    );
    final timeCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["time"] as String? ?? "") : "",
    );
    final venueCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["venue"] as String? ?? "") : "",
    );
    final organizerCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["organizer"] as String? ?? "") : "",
    );
    final capacityCtrl = TextEditingController(
      text: isEditing ? "${eventToEdit["capacity"] ?? 0}" : "0",
    );
    final descCtrl = TextEditingController(
      text: isEditing ? (eventToEdit["description"] as String? ?? "") : "",
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Row: Title & Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isEditing ? "Edit Event" : "Create Event",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Event Title *
                      Text(
                        "Event Title *",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: titleCtrl,
                        style: GoogleFonts.poppins(fontSize: 13.5),
                        decoration: InputDecoration(
                          hintText: "Annual Tech Symposium",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF94A3B8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row: Type & Status
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedType,
                                      isExpanded: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                            value: "Academic",
                                            child: Text("Academic")),
                                        DropdownMenuItem(
                                            value: "Workshop",
                                            child: Text("Workshop")),
                                        DropdownMenuItem(
                                            value: "Sports",
                                            child: Text("Sports")),
                                        DropdownMenuItem(
                                            value: "Holiday",
                                            child: Text("Holiday")),
                                        DropdownMenuItem(
                                            value: "Cultural",
                                            child: Text("Cultural")),
                                        DropdownMenuItem(
                                            value: "Hackathon",
                                            child: Text("Hackathon")),
                                      ],
                                      onChanged: (val) {
                                        if (val != null) {
                                          setModalState(() {
                                            selectedType = val;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedStatus,
                                      isExpanded: true,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                            value: "Upcoming",
                                            child: Text("Upcoming")),
                                        DropdownMenuItem(
                                            value: "Ongoing",
                                            child: Text("Ongoing")),
                                        DropdownMenuItem(
                                            value: "Completed",
                                            child: Text("Completed")),
                                      ],
                                      onChanged: (val) {
                                        if (val != null) {
                                          setModalState(() {
                                            selectedStatus = val;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row: Start Date * & End Date
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date *",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: startDateCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "mm/dd/yyyy",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Color(0xFF64748B),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: endDateCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "mm/dd/yyyy",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Color(0xFF64748B),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row: Time & Venue
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: timeCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "--:-- --",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.access_time_rounded,
                                      size: 16,
                                      color: Color(0xFF64748B),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Venue",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: venueCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "Auditorium, Hall A...",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Row: Organizer & Capacity
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Organizer",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: organizerCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "Department / Faculty",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Capacity",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: capacityCtrl,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: "0",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFCBD5E1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Description
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: descCtrl,
                        maxLines: 3,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Brief event description...",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF94A3B8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons: Cancel & Create / Save Changes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final title = titleCtrl.text.trim();
                              if (title.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Event title is required"),
                                    backgroundColor: Color(0xFFEF4444),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              final parsedCapacity =
                                  int.tryParse(capacityCtrl.text.trim()) ?? 0;

                              setState(() {
                                if (isEditing) {
                                  eventToEdit["title"] = title;
                                  eventToEdit["type"] = selectedType;
                                  eventToEdit["status"] = selectedStatus;
                                  eventToEdit["startDate"] =
                                      startDateCtrl.text.trim();
                                  eventToEdit["endDate"] =
                                      endDateCtrl.text.trim();
                                  eventToEdit["time"] = timeCtrl.text.trim();
                                  eventToEdit["venue"] = venueCtrl.text.trim();
                                  eventToEdit["organizer"] =
                                      organizerCtrl.text.trim();
                                  eventToEdit["capacity"] = parsedCapacity;
                                  eventToEdit["description"] =
                                      descCtrl.text.trim();
                                } else {
                                  _events.insert(0, {
                                    "id": "EVT-${100 + _events.length + 1}",
                                    "title": title,
                                    "type": selectedType,
                                    "status": selectedStatus,
                                    "month": "NOV",
                                    "day": "28",
                                    "startDate": startDateCtrl.text.trim().isNotEmpty
                                        ? startDateCtrl.text.trim()
                                        : "11/28/2026",
                                    "endDate": endDateCtrl.text.trim(),
                                    "time": timeCtrl.text.trim().isNotEmpty
                                        ? timeCtrl.text.trim()
                                        : "10:00",
                                    "venue": venueCtrl.text.trim().isNotEmpty
                                        ? venueCtrl.text.trim()
                                        : "Main Auditorium",
                                    "organizer": organizerCtrl.text.trim().isNotEmpty
                                        ? organizerCtrl.text.trim()
                                        : "Faculty Event Committee",
                                    "capacity": parsedCapacity > 0 ? parsedCapacity : 100,
                                    "registered": 0,
                                    "description": descCtrl.text.trim(),
                                  });
                                }
                              });

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isEditing
                                        ? "Event updated successfully!"
                                        : "Event created successfully!",
                                  ),
                                  backgroundColor: const Color(0xFF10B981),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF818CF8),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isEditing ? "Save Changes" : "Create Event",
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
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
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(Map<String, dynamic> evt) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(
            "Delete Event",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: Text(
            "Are you sure you want to delete '${evt["title"]}'? This action cannot be undone.",
            style: GoogleFonts.poppins(
                fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(color: const Color(0xFF64748B)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _events.remove(evt);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Event deleted."),
                    backgroundColor: Color(0xFFDC2626),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6), // Warm off-white
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 4 Stat Counter Metric Cards
              _buildMetricCardsRow(constraints.maxWidth < 750),
              const SizedBox(height: 18),

              // 3. Search & Filter Bar with + Create Event Button
              _buildSearchAndFilterBar(),
              const SizedBox(height: 16),

              // 4. Event Cards List
              ..._filteredEvents.map((evt) => _buildEventCard(evt)),

              if (_filteredEvents.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.event_busy_rounded,
                          size: 44, color: Color(0xFF94A3B8)),
                      const SizedBox(height: 10),
                      Text(
                        "No events match the selected filters",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
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
        color: const Color(0xFF1E2865), // Deep Blueprint Navy
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.2),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Blueprint Grid Pattern Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _EventGridPainter(),
            ),
          ),

          // Faint Megaphone Watermark on right
          Positioned(
            right: -10,
            bottom: -15,
            child: Opacity(
              opacity: 0.08,
              child: const Icon(
                Icons.campaign_rounded,
                size: 160,
                color: Colors.white,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb
                Row(
                  children: [
                    if (widget.onBack != null) ...[
                      InkWell(
                        onTap: widget.onBack,
                        borderRadius: BorderRadius.circular(6),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              size: 13, color: Colors.white70),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      "Home  ›  Campus Life  ›  Campus Events",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Badges Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        "CAMPUS LIFE",
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
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
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Title with megaphone icon container
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.campaign_rounded,
                          size: 24,
                          color: Color(0xFFFBBF24),
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
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "College and department events, seminars, workshops, cultural and alumni events.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
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
    );
  }

  // ===========================================================================
  // 2. 4 STAT METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCardsRow(bool isNarrow) {
    final card1 = _buildMetricCard(
      title: "Total Events",
      value: "$_totalEvents",
      icon: Icons.calendar_month_outlined,
      iconColor: const Color(0xFF3B82F6),
    );
    final card2 = _buildMetricCard(
      title: "Upcoming",
      value: "$_upcomingEvents",
      icon: Icons.access_time_rounded,
      iconColor: const Color(0xFF06B6D4),
    );
    final card3 = _buildMetricCard(
      title: "Ongoing",
      value: "$_ongoingEvents",
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF10B981),
    );
    final card4 = _buildMetricCard(
      title: "This Month",
      value: "$_thisMonthEvents",
      icon: Icons.calendar_today_outlined,
      iconColor: const Color(0xFFF59E0B),
    );

    if (isNarrow) {
      return Column(
        children: [
          Row(children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: card3),
            const SizedBox(width: 12),
            Expanded(child: card4),
          ]),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: card1),
        const SizedBox(width: 14),
        Expanded(child: card2),
        const SizedBox(width: 14),
        Expanded(child: card3),
        const SizedBox(width: 14),
        Expanded(child: card4),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTERS BAR
  // ===========================================================================
  Widget _buildSearchAndFilterBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search TextField
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Search events...",
              hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 18,
                color: Color(0xFF94A3B8),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // All Types Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedType,
              isExpanded: true,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF1E293B),
              ),
              items: const [
                DropdownMenuItem(value: "All Types", child: Text("All Types")),
                DropdownMenuItem(value: "Academic", child: Text("Academic")),
                DropdownMenuItem(value: "Workshop", child: Text("Workshop")),
                DropdownMenuItem(value: "Sports", child: Text("Sports")),
                DropdownMenuItem(value: "Holiday", child: Text("Holiday")),
                DropdownMenuItem(value: "Cultural", child: Text("Cultural")),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedType = val;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 10),

        // All Status Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedStatus,
              isExpanded: true,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF1E293B),
              ),
              items: const [
                DropdownMenuItem(
                    value: "All Status", child: Text("All Status")),
                DropdownMenuItem(
                    value: "Upcoming", child: Text("Upcoming")),
                DropdownMenuItem(
                    value: "Ongoing", child: Text("Ongoing")),
                DropdownMenuItem(
                    value: "Completed", child: Text("Completed")),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedStatus = val;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 12),

        // + Create Event Button
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            onPressed: () => _showEventDialog(),
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text("+ Create Event"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2A72), // Deep purple pill
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. EVENT CARD ITEM
  // ===========================================================================
  Widget _buildEventCard(Map<String, dynamic> evt) {
    final month = (evt["month"] as String?) ?? "OCT";
    final day = (evt["day"] as String?) ?? "15";
    final title = evt["title"] as String;
    final type = (evt["type"] as String?) ?? "Academic";
    final status = (evt["status"] as String?) ?? "Upcoming";
    final time = (evt["time"] as String?) ?? "";
    final venue = (evt["venue"] as String?) ?? "";
    final organizer = (evt["organizer"] as String?) ?? "";
    final capacity = (evt["capacity"] as int?) ?? 0;
    final registered = (evt["registered"] as int?) ?? 0;

    // Type Colors
    Color typeBg = const Color(0xFFF1F5F9);
    Color typeFg = const Color(0xFF475569);
    if (type == "Workshop") {
      typeBg = const Color(0xFFF3E8FF);
      typeFg = const Color(0xFF7E22CE);
    } else if (type == "Holiday") {
      typeBg = const Color(0xFFFEF3C7);
      typeFg = const Color(0xFFB45309);
    } else if (type == "Sports") {
      typeBg = const Color(0xFFCCFBF1);
      typeFg = const Color(0xFF0F766E);
    } else if (type == "Academic") {
      typeBg = const Color(0xFFDBEAFE);
      typeFg = const Color(0xFF1D4ED8);
    } else if (type == "Cultural") {
      typeBg = const Color(0xFFFCE7F3);
      typeFg = const Color(0xFFBE185D);
    }

    // Status Colors
    Color statusBg = const Color(0xFFF1F5F9);
    Color statusFg = const Color(0xFF475569);
    if (status == "Upcoming") {
      statusBg = const Color(0xFFE0F2FE);
      statusFg = const Color(0xFF0284C7);
    } else if (status == "Ongoing") {
      statusBg = const Color(0xFFDCFCE7);
      statusFg = const Color(0xFF15803D);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Date Block: OCT / 15
          SizedBox(
            width: 44,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    letterSpacing: 0.6,
                  ),
                ),
                Text(
                  day,
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

          // Event Center Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Badges Wrap
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    // Type Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: typeBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: typeFg,
                        ),
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusFg,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Meta Row (time, venue, organizer)
                LayoutBuilder(
                  builder: (context, metaBox) {
                    final maxItemWidth =
                        (metaBox.maxWidth - 20).clamp(120.0, 500.0);
                    return Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (time.isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time_rounded,
                                  size: 13, color: Color(0xFF64748B)),
                              const SizedBox(width: 4),
                              Text(
                                time,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        if (venue.isNotEmpty)
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxItemWidth),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 13, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    venue,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (organizer.isNotEmpty)
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: maxItemWidth),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.apartment_rounded,
                                    size: 13, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    organizer,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),

                // Capacity Progress Bar
                if (capacity > 0) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (registered / capacity).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE11D48), // Rose pink line
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$registered/$capacity",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Right Action Icons (Edit Pencil & Delete Trash)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showEventDialog(eventToEdit: evt),
                icon: const Icon(Icons.edit_outlined, size: 16),
                color: const Color(0xFF64748B),
                splashRadius: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: "Edit Event",
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => _showDeleteDialog(evt),
                icon: const Icon(Icons.delete_outline_rounded, size: 16),
                color: const Color(0xFF64748B),
                splashRadius: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: "Delete Event",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Blueprint grid overlay painter
class _EventGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const step = 24.0;
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
