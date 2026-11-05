import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ACADEMICS: ACADEMIC CALENDAR (FACULTY PORTAL)
// =============================================================================
class AcademicCalendarScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AcademicCalendarScreen({super.key, this.onBack});

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  String _selectedFilter = "All";
  String _selectedDept = "All Departments";
  int _viewMode = 0; // 0: Timeline View, 1: Monthly Grid
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _events = [
    {
      "month": "SEP",
      "day": "29",
      "dayName": "Tue",
      "title": "IA-II Timetable Published",
      "badge": "Exam cell",
      "badgeColor": const Color(0xFFEFF6FF),
      "badgeTextColor": const Color(0xFF1D4ED8),
      "desc": "Official schedule for Internal Assessment II released for all UG and PG programs.",
      "meta": "10:00 AM  Central Exam Cell / Portal",
      "type": "Exam cell",
    },
    {
      "month": "OCT",
      "day": "14",
      "dayName": "Wed",
      "title": "Internal Assessment II Examination Window",
      "badge": "Assessment",
      "badgeColor": const Color(0xFFFEF3C7),
      "badgeTextColor": const Color(0xFFB45309),
      "desc": "Mid-term evaluations across all engineering departments for UG & PG.",
      "meta": "09:30 AM  Main Examination Halls",
      "type": "Assessment",
    },
    {
      "month": "OCT",
      "day": "24",
      "dayName": "Sat",
      "title": "Deepavali Festival Holiday",
      "badge": "Holiday",
      "badgeColor": const Color(0xFFDCFCE7),
      "badgeTextColor": const Color(0xFF15803D),
      "desc": "Institutional holiday observed across university campus.",
      "meta": "All Day  Campus Closed",
      "type": "Holiday",
    },
    {
      "month": "NOV",
      "day": "02",
      "dayName": "Mon",
      "title": "TECHVISTA 2026 National Technical Symposium",
      "badge": "Event",
      "badgeColor": const Color(0xFFF3E8FF),
      "badgeTextColor": const Color(0xFF7E22CE),
      "desc": "Inter-collegiate technical presentation and project competition.",
      "meta": "09:00 AM  APJ Abdul Kalam Auditorium",
      "type": "Event",
    },
    {
      "month": "NOV",
      "day": "14",
      "dayName": "Sat",
      "title": "Last Working Day for Theory Classes",
      "badge": "Milestone",
      "badgeColor": const Color(0xFFF1F5F9),
      "badgeTextColor": const Color(0xFF475569),
      "desc": "Submission of final internal assessment and attendance sign-off.",
      "meta": "05:00 PM  Office of Dean Academics",
      "type": "Milestone",
    },
    {
      "month": "NOV",
      "day": "18",
      "dayName": "Wed",
      "title": "Autonomous Practical Lab Examinations Begin",
      "badge": "Assessment",
      "badgeColor": const Color(0xFFFEF3C7),
      "badgeTextColor": const Color(0xFFB45309),
      "desc": "External examiner lab viva and practical sessions.",
      "meta": "08:30 AM  Department Computing & Tech Labs",
      "type": "Assessment",
    },
  ];

  void _showAddCalendarItemDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final metaCtrl = TextEditingController(text: "10:00 AM  Main Academic Block");
    final monthCtrl = TextEditingController(text: "NOV");
    final dayCtrl = TextEditingController(text: "20");
    final dayNameCtrl = TextEditingController(text: "Fri");
    String selectedType = "Assessment";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.event_available_rounded, color: Color(0xFF2563EB), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text("Add Calendar Item", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
                ],
              ),
              content: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleCtrl,
                        decoration: const InputDecoration(labelText: "Event Title", hintText: "e.g. Model Practical Exams"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: monthCtrl,
                              decoration: const InputDecoration(labelText: "Month (e.g. NOV)"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: dayCtrl,
                              decoration: const InputDecoration(labelText: "Day (e.g. 20)"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: dayNameCtrl,
                              decoration: const InputDecoration(labelText: "Day Name (Fri)"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedType,
                        decoration: const InputDecoration(labelText: "Category / Type"),
                        items: ["Assessment", "Exam cell", "Holiday", "Event", "Milestone"]
                            .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setDlgState(() => selectedType = val);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: metaCtrl,
                        decoration: const InputDecoration(labelText: "Time & Venue / Meta"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: descCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: "Event Description"),
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
                    if (titleCtrl.text.trim().isEmpty) return;
                    Color badgeColor = const Color(0xFFEFF6FF);
                    Color badgeTextColor = const Color(0xFF1D4ED8);
                    if (selectedType == "Holiday") {
                      badgeColor = const Color(0xFFDCFCE7);
                      badgeTextColor = const Color(0xFF15803D);
                    } else if (selectedType == "Assessment") {
                      badgeColor = const Color(0xFFFEF3C7);
                      badgeTextColor = const Color(0xFFB45309);
                    } else if (selectedType == "Event") {
                      badgeColor = const Color(0xFFF3E8FF);
                      badgeTextColor = const Color(0xFF7E22CE);
                    } else if (selectedType == "Milestone") {
                      badgeColor = const Color(0xFFF1F5F9);
                      badgeTextColor = const Color(0xFF475569);
                    }

                    final newItem = {
                      "month": monthCtrl.text.trim().toUpperCase(),
                      "day": dayCtrl.text.trim(),
                      "dayName": dayNameCtrl.text.trim(),
                      "title": titleCtrl.text.trim(),
                      "badge": selectedType,
                      "badgeColor": badgeColor,
                      "badgeTextColor": badgeTextColor,
                      "desc": descCtrl.text.trim(),
                      "meta": metaCtrl.text.trim(),
                      "type": selectedType,
                    };
                    setState(() {
                      _events.insert(0, newItem);
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added '${newItem["title"]}' to calendar!", style: GoogleFonts.poppins()),
                        backgroundColor: const Color(0xFF0F766E),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Add Item", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditCalendarItemDialog(Map<String, dynamic> e) {
    final titleCtrl = TextEditingController(text: e["title"] as String);
    final descCtrl = TextEditingController(text: e["desc"] as String);
    final metaCtrl = TextEditingController(text: e["meta"] as String);
    final monthCtrl = TextEditingController(text: e["month"] as String);
    final dayCtrl = TextEditingController(text: e["day"] as String);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Edit Calendar Item", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
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
                        child: TextField(
                          controller: monthCtrl,
                          decoration: const InputDecoration(labelText: "Month"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: dayCtrl,
                          decoration: const InputDecoration(labelText: "Day"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: metaCtrl,
                    decoration: const InputDecoration(labelText: "Time & Venue"),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: "Description"),
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
                  e["desc"] = descCtrl.text.trim();
                  e["meta"] = metaCtrl.text.trim();
                  e["month"] = monthCtrl.text.trim().toUpperCase();
                  e["day"] = dayCtrl.text.trim();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Calendar item updated successfully!", style: GoogleFonts.poppins()),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteCalendarItemDialog(Map<String, dynamic> e) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Calendar Item?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          content: Text(
            "Are you sure you want to delete '${e["title"]}'? This will be removed from your academic view.",
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
                    content: Text("Deleted '${removed["title"]}'", style: GoogleFonts.poppins()),
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _events.where((e) {
      if (_selectedFilter != "All" && e["type"] != _selectedFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = (e["title"] as String).toLowerCase();
        final desc = (e["desc"] as String).toLowerCase();
        if (!title.contains(query) && !desc.contains(query)) return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Top Hero Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Official Institutional Academic Calendar Card
          _buildInstitutionalCalendarCard(),
          const SizedBox(height: 18),

          // 3. Search & View Mode Card
          _buildSearchAndFilterCard(),
          const SizedBox(height: 14),

          // 4. Filter Pills Row
          _buildFilterPills(),
          const SizedBox(height: 16),

          // 5. Schedule Entries List Card
          _buildScheduleListCard(filtered),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER
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
            // Background blueprint grid texture
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative calendar watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.calendar_month_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row
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
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Academics",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Academic Calendar",
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

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calendar icon rounded box
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF3B487A),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "ACADEMICS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Academic Calendar",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle description
                            Text(
                              "Semester schedule, internal assessments, holidays and exam windows.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
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
  // 2. INSTITUTIONAL CALENDAR CARD
  // ===========================================================================
  Widget _buildInstitutionalCalendarCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Semester badge & Action buttons
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      "# Odd Semester 2026–27",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Week 11 of 21",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Academic Calendar exported (.ics) successfully!", style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF1E2865),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.file_download_outlined, size: 14),
                    label: const Text("Export .ics"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      foregroundColor: const Color(0xFF334155),
                      textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Synced events with University Academic Management System.", style: GoogleFonts.poppins()),
                          backgroundColor: const Color(0xFF0F766E),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.sync_rounded, size: 14),
                    label: const Text("Sync Events"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      foregroundColor: const Color(0xFF334155),
                      textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showAddCalendarItemDialog,
                    icon: const Icon(Icons.add_rounded, size: 14),
                    label: const Text("Add Calendar Item"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Heading & Subtitle
          Text(
            "Official Institutional Academic Calendar",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Timetables, internal assessments, national holidays, model exams and university examination windows.",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),

          // Progress Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text("Term Start: Aug 1, 2026", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
              Text("Progress: 52%", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
              Text("Term End: Dec 20, 2026", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.52,
              minHeight: 5,
              backgroundColor: Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF141938)),
            ),
          ),
          const SizedBox(height: 16),

          // 4 Metric Summary Cards (Responsive: 2x2 grid on mobile/narrow screens)
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 680) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildMetricTile("Total Items", "10", "Scheduled this semester", Icons.calendar_today_outlined, const Color(0xFF1E293B))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildMetricTile("Assessments", "3", "IA-I, IA-II & Model tests", Icons.menu_book_outlined, const Color(0xFFB45309))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildMetricTile("Holidays", "2", "National & term vacations", Icons.school_outlined, const Color(0xFF047857))),
                        const SizedBox(width: 10),
                        Expanded(child: _buildMetricTile("Workshops & Events", "3", "Symposiums & tech fests", Icons.auto_awesome_outlined, const Color(0xFFD97706))),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: _buildMetricTile("Total Items", "10", "Scheduled this semester", Icons.calendar_today_outlined, const Color(0xFF1E293B))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricTile("Assessments", "3", "IA-I, IA-II & Model tests", Icons.menu_book_outlined, const Color(0xFFB45309))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricTile("Holidays", "2", "National & term vacations", Icons.school_outlined, const Color(0xFF047857))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricTile("Workshops & Events", "3", "Symposiums & tech fests", Icons.auto_awesome_outlined, const Color(0xFFD97706))),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, String desc, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                  style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 14, color: iconColor),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A))),
          const SizedBox(height: 2),
          Text(
            desc,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & VIEW MODE CARD
  // ===========================================================================
  Widget _buildSearchAndFilterCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: InputDecoration(
                      hintText: "Search schedule, exams, venues...",
                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                      prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedDept,
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
                          items: ["All Departments", "Computer Science", "ECE", "Mechanical", "AI & DS"].map((d) {
                            return DropdownMenuItem(value: d, child: Text(d));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedDept = val);
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildViewModeButton(0, "Timeline View", Icons.view_timeline_outlined),
                          _buildViewModeButton(1, "Monthly Grid", Icons.calendar_view_month_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              // Search box
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    hintText: "Search schedule, exams, venues...",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Department Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDept,
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
                    items: ["All Departments", "Computer Science", "ECE", "Mechanical", "AI & DS"].map((d) {
                      return DropdownMenuItem(value: d, child: Text(d));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedDept = val);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // View Toggle: Timeline vs Monthly Grid
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    _buildViewModeButton(0, "Timeline View", Icons.view_timeline_outlined),
                    _buildViewModeButton(1, "Monthly Grid", Icons.calendar_view_month_outlined),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewModeButton(int mode, String label, IconData icon) {
    final isSelected = _viewMode == mode;
    return InkWell(
      onTap: () => setState(() => _viewMode = mode),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 1))]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? const Color(0xFF141938) : const Color(0xFF64748B)),
            const SizedBox(width: 5),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF141938) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final filters = [
      {"label": "All", "key": "All", "count": 10},
      {"label": "Assessment", "key": "Assessment", "count": 3},
      {"label": "Holiday", "key": "Holiday", "count": 2},
      {"label": "Exam cell", "key": "Exam cell", "count": 1},
      {"label": "Event", "key": "Event", "count": 3},
      {"label": "Milestone", "key": "Milestone", "count": 1},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text("Filter:", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
          const SizedBox(width: 8),
          ...filters.map((f) {
            final isSelected = _selectedFilter == f["key"];
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: () => setState(() => _selectedFilter = f["key"] as String),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF141938) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        f["label"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${f["count"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white70 : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. SCHEDULE ENTRIES LIST CARD
  // ===========================================================================
  Widget _buildScheduleListCard(List<Map<String, dynamic>> list) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 6,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Official Academic Schedule & Events",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "8 scheduled entries",
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "8 entries",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Entries List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF8FAFC)),
            itemBuilder: (context, i) {
              final e = list[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: LayoutBuilder(
                  builder: (context, itemConstraints) {
                    final isCompact = itemConstraints.maxWidth < 520;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date badge box
                        Container(
                          width: 52,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e["month"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                e["day"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                e["dayName"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Main info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  Text(
                                    e["title"] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: e["badgeColor"] as Color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      e["badge"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: e["badgeTextColor"] as Color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                e["desc"] as String,
                                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF94A3B8)),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      e["meta"] as String,
                                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              if (isCompact) ...[
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      onPressed: () => _showEditCalendarItemDialog(e),
                                      icon: const Icon(Icons.edit_outlined, size: 13),
                                      label: const Text("Edit"),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                                        foregroundColor: const Color(0xFF4338CA),
                                        textStyle: GoogleFonts.poppins(fontSize: 11),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    OutlinedButton.icon(
                                      onPressed: () => _showDeleteCalendarItemDialog(e),
                                      icon: const Icon(Icons.delete_outline_rounded, size: 13),
                                      label: const Text("Delete"),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                                        foregroundColor: const Color(0xFFEF4444),
                                        textStyle: GoogleFonts.poppins(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Action buttons: Edit, Delete on wide screens
                        if (!isCompact) ...[
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => _showEditCalendarItemDialog(e),
                                icon: const Icon(Icons.edit_outlined, size: 13),
                                label: const Text("Edit"),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: Size.zero,
                                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                                  foregroundColor: const Color(0xFF4338CA),
                                  textStyle: GoogleFonts.poppins(fontSize: 11),
                                ),
                              ),
                              const SizedBox(width: 6),
                              OutlinedButton.icon(
                                onPressed: () => _showDeleteCalendarItemDialog(e),
                                icon: const Icon(Icons.delete_outline_rounded, size: 13),
                                label: const Text("Delete"),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: Size.zero,
                                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                                  foregroundColor: const Color(0xFFEF4444),
                                  textStyle: GoogleFonts.poppins(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SUBTLE GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _GridPaperPainter({required this.gridColor, this.step = 28.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
