import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ACADEMICS: ASSIGNMENTS (FACULTY PORTAL)
// =============================================================================
class FacultyAssignmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyAssignmentsScreen({super.key, this.onBack});

  @override
  State<FacultyAssignmentsScreen> createState() => _FacultyAssignmentsScreenState();
}

class _FacultyAssignmentsScreenState extends State<FacultyAssignmentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = "All";
  int _rowsPerPage = 10;
  bool _showSampleData = false;

  final List<Map<String, dynamic>> _assignments = [
    {
      "name": "Assignment 2: BCNF Decomposition & Functional Dependencies",
      "course": "CS3492 · DBMS",
      "due": "Oct 28, 2026",
      "handedIn": "122 / 128",
      "marked": "110 / 128",
      "status": "Open",
    },
    {
      "name": "Lab Mini-Project: A* Pathfinding Grid Worlds",
      "course": "AL3451 · Machine Learning",
      "due": "Nov 04, 2026",
      "handedIn": "58 / 64",
      "marked": "20 / 64",
      "status": "Open",
    },
    {
      "name": "Assignment 1: ER Modeling & Relational Schema Mapping",
      "course": "CS3492 · DBMS",
      "due": "Oct 10, 2026",
      "handedIn": "128 / 128",
      "marked": "128 / 128",
      "status": "Graded",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showNewAssignmentDialog() {
    final titleCtrl = TextEditingController();
    final courseCtrl = TextEditingController(text: "CS3492 · Database Management Systems");
    final dueCtrl = TextEditingController(text: "Nov 15, 2026");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Create New Assignment",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Assignment Title", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
              const SizedBox(height: 4),
              TextField(
                controller: titleCtrl,
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: InputDecoration(
                  hintText: "e.g., Assignment 3: SQL Indexing & Query Tuning",
                  hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 12),
              Text("Course Section", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
              const SizedBox(height: 4),
              TextField(
                controller: courseCtrl,
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 12),
              Text("Due Date", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
              const SizedBox(height: 4),
              TextField(
                controller: dueCtrl,
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isNotEmpty) {
                setState(() {
                  _assignments.insert(0, {
                    "name": titleCtrl.text.trim(),
                    "course": courseCtrl.text.trim(),
                    "due": dueCtrl.text.trim(),
                    "handedIn": "0 / 128",
                    "marked": "0 / 128",
                    "status": "Open",
                  });
                  _showSampleData = true;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Assignment published! Students can now submit.")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141938),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Publish", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ROW ACTIONS: VIEW, EDIT, DELETE HANDLERS
  // ===========================================================================
  void _showViewAssignmentDialog(Map<String, dynamic> a, int index) {
    final isOpen = a["status"] == "Open";
    final isGraded = a["status"] == "Graded";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: const EdgeInsets.all(22),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Icon, Title and Status Chip
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: const Icon(Icons.assignment_rounded, color: Color(0xFF2563EB), size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a["name"] as String,
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a["course"] as String,
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isOpen
                          ? const Color(0xFFDCFCE7)
                          : isGraded
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      a["status"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isOpen
                            ? const Color(0xFF15803D)
                            : isGraded
                                ? const Color(0xFF1D4ED8)
                                : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Metric Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildDetailMetricCard("Due Date", a["due"] as String, Icons.calendar_today_rounded, const Color(0xFF3B82F6)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDetailMetricCard("Handed In", a["handedIn"] as String, Icons.file_upload_outlined, const Color(0xFF10B981)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDetailMetricCard("Evaluated", a["marked"] as String, Icons.grading_rounded, const Color(0xFF8B5CF6)),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Description / Overview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Submission Guidelines", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF334155))),
                    const SizedBox(height: 4),
                    Text(
                      "Submissions are accepted in PDF or SQL script format with automated plagiarism detection and AI rubrics matching Bloom's taxonomy.",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B), height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _showDeleteAssignmentDialog(a, index);
            },
            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFDC2626)),
            label: Text("Delete", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFFDC2626))),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditAssignmentDialog(a, index);
            },
            icon: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFF141938)),
            label: Text("Edit", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF141938))),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141938),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Done", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showEditAssignmentDialog(Map<String, dynamic> a, int index) {
    final titleCtrl = TextEditingController(text: a["name"]);
    final courseCtrl = TextEditingController(text: a["course"]);
    final dueCtrl = TextEditingController(text: a["due"]);
    String statusVal = a["status"] ?? "Open";

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.edit_note_rounded, color: Color(0xFF2563EB), size: 22),
              const SizedBox(width: 8),
              Text(
                "Edit Assignment",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assignment Title", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                const SizedBox(height: 4),
                TextField(
                  controller: titleCtrl,
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Course", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                const SizedBox(height: 4),
                TextField(
                  controller: courseCtrl,
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Due Date", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                          const SizedBox(height: 4),
                          TextField(
                            controller: dueCtrl,
                            style: GoogleFonts.poppins(fontSize: 12.5),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                          const SizedBox(height: 4),
                          Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: statusVal,
                                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                                items: ["Open", "Graded", "Closed"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setModalState(() => statusVal = val);
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleCtrl.text.trim().isNotEmpty) {
                  setState(() {
                    _assignments[index] = {
                      ...a,
                      "name": titleCtrl.text.trim(),
                      "course": courseCtrl.text.trim(),
                      "due": dueCtrl.text.trim(),
                      "status": statusVal,
                    };
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Assignment '${titleCtrl.text.trim()}' updated successfully!"),
                      backgroundColor: const Color(0xFF10B981),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Save Changes", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAssignmentDialog(Map<String, dynamic> a, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              "Delete Assignment?",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you sure you want to delete:",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                a["name"] as String,
                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "This action will remove all student submission records and marks for this assignment.",
              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              final deleted = a;
              setState(() {
                _assignments.removeAt(index);
                if (_assignments.isEmpty) {
                  _showSampleData = false;
                }
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Assignment deleted."),
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        _assignments.insert(index, deleted);
                        _showSampleData = true;
                      });
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Delete", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailMetricCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
        children: [
          // 1. Top Hero Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Action Bar Row (Search + Dropdown + New Assignment Button)
          _buildActionBarRow(),
          const SizedBox(height: 16),

          // 3. Assignments Table Card with Graph Paper Background
          _buildTableCard(),
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

            // Large decorative checklist watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.assignment_rounded,
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
                          "Assignments",
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
                      // Checklist icon rounded box
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
                            Icons.assignment_rounded,
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
                              "Assignments",
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
                              "Create, distribute and track assignments and lab submissions.",
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
  // 2. ACTION BAR ROW
  // ===========================================================================
  Widget _buildActionBarRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    hintText: "Search assignments...",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedStatus,
                          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                          items: ["All", "Open", "Graded", "Closed"].map((s) {
                            return DropdownMenuItem(value: s, child: Text(s));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedStatus = val);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _showNewAssignmentDialog,
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text("New assignment"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Row(
          children: [
            // Search Input
            Expanded(
              flex: 3,
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12.5),
                  decoration: InputDecoration(
                    hintText: "Search assignments...",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Status Dropdown
            Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                  items: ["All", "Open", "Graded", "Closed"].map((s) {
                    return DropdownMenuItem(value: s, child: Text(s));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedStatus = val);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),

            // New Assignment Button
            ElevatedButton.icon(
              onPressed: _showNewAssignmentDialog,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text("New assignment"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 3. TABLE CARD WITH GRAPH PAPER BACKGROUND
  // ===========================================================================
  Widget _buildTableCard() {
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 650;

          if (!_showSampleData) {
            return Column(
              children: [
                if (isNarrow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: 650,
                      child: _buildTableHeaderRow(),
                    ),
                  )
                else
                  _buildTableHeaderRow(),

                _buildEmptyState(),

                const Divider(height: 1, color: Color(0xFFE5E7EB)),

                _buildResponsiveFooter(isNarrow),
              ],
            );
          }

          final tableDataContent = Column(
            children: [
              _buildTableHeaderRow(),
              _buildAssignmentRows(),
            ],
          );

          return Column(
            children: [
              if (isNarrow)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: 650,
                    child: tableDataContent,
                  ),
                )
              else
                tableDataContent,

              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              _buildResponsiveFooter(isNarrow),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTableHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildHeaderText("ASSIGNMENT")),
          Expanded(flex: 2, child: _buildHeaderText("DUE")),
          Expanded(flex: 2, child: _buildHeaderText("HANDED IN")),
          Expanded(flex: 2, child: _buildHeaderText("MARKED")),
          Expanded(flex: 2, child: _buildHeaderText("STATUS")),
          Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: _buildHeaderText("ACTIONS"))),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 280),
      child: Stack(
        children: [
          // Faint graph paper / blueprint grid background
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPaperPainter(
                gridColor: const Color(0xFFF1F5F9),
                step: 24.0,
              ),
            ),
          ),

          // Content centered in visible card width
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No assignments yet",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: Text(
                      "Create an assignment and publish it. Students will see it straight away.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _showSampleData = true),
                    icon: const Icon(Icons.dataset_outlined, size: 15),
                    label: const Text("Preview Published Assignments"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF141938),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentRows() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _assignments.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
      itemBuilder: (context, i) {
        final a = _assignments[i];
        final isOpen = a["status"] == "Open";
        final isGraded = a["status"] == "Graded";
        return Material(
          color: Colors.white.withValues(alpha: 0.85),
          child: InkWell(
            onTap: () => _showViewAssignmentDialog(a, i),
            hoverColor: const Color(0xFFF8FAFC),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a["name"] as String,
                          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          a["course"] as String,
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(a["due"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(a["handedIn"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(a["marked"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isOpen
                              ? const Color(0xFFDCFCE7)
                              : isGraded
                                  ? const Color(0xFFEFF6FF)
                                  : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          a["status"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: isOpen
                                ? const Color(0xFF15803D)
                                : isGraded
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz_rounded, size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Assignment Actions",
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        color: Colors.white,
                        elevation: 6,
                        onSelected: (val) {
                          if (val == "view") {
                            _showViewAssignmentDialog(a, i);
                          } else if (val == "edit") {
                            _showEditAssignmentDialog(a, i);
                          } else if (val == "delete") {
                            _showDeleteAssignmentDialog(a, i);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "view",
                            child: Row(
                              children: [
                                const Icon(Icons.visibility_outlined, size: 17, color: Color(0xFF2563EB)),
                                const SizedBox(width: 10),
                                Text(
                                  "View Details",
                                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: "edit",
                            child: Row(
                              children: [
                                const Icon(Icons.edit_outlined, size: 17, color: Color(0xFF0F766E)),
                                const SizedBox(width: 10),
                                Text(
                                  "Edit Assignment",
                                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(height: 1),
                          PopupMenuItem(
                            value: "delete",
                            child: Row(
                              children: [
                                const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFFDC2626)),
                                const SizedBox(width: 10),
                                Text(
                                  "Delete",
                                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFFDC2626)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveFooter(bool isNarrow) {
    if (isNarrow) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showSampleData ? "${_assignments.length} assignments" : "No assignments",
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Rows per page: ", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _rowsPerPage,
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
                        items: [10, 20, 50].map((r) => DropdownMenuItem(value: r, child: Text("$r"))).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _rowsPerPage = val);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page 1 of 1",
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left_rounded, size: 14),
                      label: const Text("Prev"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        foregroundColor: const Color(0xFF64748B),
                        textStyle: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded, size: 14),
                      label: const Text("Next"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        foregroundColor: const Color(0xFF64748B),
                        textStyle: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _showSampleData ? "${_assignments.length} assignments" : "No assignments",
            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Rows per page: ", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _rowsPerPage,
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
                  items: [10, 20, 50].map((r) => DropdownMenuItem(value: r, child: Text("$r"))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _rowsPerPage = val);
                  },
                ),
              ),
              const SizedBox(width: 14),
              Text("Page 1 of 1", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_left_rounded, size: 15),
                label: const Text("Prev"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF64748B),
                  textStyle: GoogleFonts.poppins(fontSize: 11),
                ),
              ),
              const SizedBox(width: 6),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_rounded, size: 15),
                label: const Text("Next"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF64748B),
                  textStyle: GoogleFonts.poppins(fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF64748B),
        letterSpacing: 0.4,
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
