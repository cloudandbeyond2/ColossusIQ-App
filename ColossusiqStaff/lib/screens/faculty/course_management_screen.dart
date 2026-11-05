import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ACADEMICS: COURSE MANAGEMENT (FACULTY PORTAL)
// =============================================================================
class CourseManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CourseManagementScreen({super.key, this.onBack});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _courses = [
    {
      "id": "CRS-1006",
      "code": "ME3491",
      "title": "Theory of Machines",
      "dept": "Mechanical Engineering",
      "sem": "4",
      "credits": "4",
      "faculty": "Prof. N. Kumar",
      "assignedBy": "—",
      "status": "Archived",
      "updated": "19 Sept 2026",
    },
    {
      "id": "CRS-1005",
      "code": "EC3351",
      "title": "Control Systems",
      "dept": "Electronics & Communication",
      "sem": "3",
      "credits": "4",
      "faculty": "Dr. S. Priya",
      "assignedBy": "—",
      "status": "Active",
      "updated": "18 Sept 2026",
    },
    {
      "id": "CRS-1004",
      "code": "AL3451",
      "title": "Machine Learning",
      "dept": "Artificial Intelligence & Data Science",
      "sem": "4",
      "credits": "3",
      "faculty": "Dr. V. Srinivasan",
      "assignedBy": "—",
      "status": "Active",
      "updated": "17 Sept 2026",
    },
    {
      "id": "CRS-1003",
      "code": "CS3591",
      "title": "Computer Networks",
      "dept": "Computer Science & Engineering",
      "sem": "5",
      "credits": "4",
      "faculty": "Dr. K. Anitha",
      "assignedBy": "—",
      "status": "Active",
      "updated": "16 Sept 2026",
    },
    {
      "id": "CRS-1002",
      "code": "CS3451",
      "title": "Operating Systems",
      "dept": "Computer Science & Engineering",
      "sem": "4",
      "credits": "3",
      "faculty": "Prof. R. Balaji",
      "assignedBy": "—",
      "status": "Active",
      "updated": "15 Sept 2026",
    },
    {
      "id": "CRS-1001",
      "code": "CS3492",
      "title": "Database Management Systems",
      "dept": "Computer Science & Engineering",
      "sem": "4",
      "credits": "4",
      "faculty": "Dr. Meena Raghavan",
      "assignedBy": "—",
      "status": "Active",
      "updated": "14 Sept 2026",
    },
  ];

  int _currentPage = 1;
  final int _pageSize = 5;

  void _showAddCourseDialog() {
    final codeCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final deptCtrl = TextEditingController(text: "Computer Science & Engineering");
    final semCtrl = TextEditingController(text: "5");
    final creditsCtrl = TextEditingController(text: "4");
    final facultyCtrl = TextEditingController(text: "Dr. Meena Raghavan");
    String status = "Active";

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
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF4338CA), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text("Add New Course", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
                ],
              ),
              content: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: codeCtrl,
                              decoration: const InputDecoration(labelText: "Course Code", hintText: "e.g. CS3501"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: creditsCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: "Credits", hintText: "3/4"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: titleCtrl,
                        decoration: const InputDecoration(labelText: "Course Title", hintText: "e.g. Cloud Computing & DevOps"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: deptCtrl,
                        decoration: const InputDecoration(labelText: "Department"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: semCtrl,
                              decoration: const InputDecoration(labelText: "Semester", hintText: "5"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: status,
                              decoration: const InputDecoration(labelText: "Status"),
                              items: ["Active", "Archived"]
                                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
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
                        controller: facultyCtrl,
                        decoration: const InputDecoration(labelText: "Assigned Faculty", hintText: "e.g. Dr. K. Anitha"),
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
                    if (titleCtrl.text.trim().isEmpty || codeCtrl.text.trim().isEmpty) return;
                    final newCourse = {
                      "id": "CRS-${1007 + _courses.length}",
                      "code": codeCtrl.text.trim().toUpperCase(),
                      "title": titleCtrl.text.trim(),
                      "dept": deptCtrl.text.trim(),
                      "sem": semCtrl.text.trim(),
                      "credits": creditsCtrl.text.trim(),
                      "faculty": facultyCtrl.text.trim(),
                      "assignedBy": "Self",
                      "status": status,
                      "updated": "Just now",
                    };
                    setState(() {
                      _courses.insert(0, newCourse);
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Course '${newCourse["code"]}' added successfully!", style: GoogleFonts.poppins()),
                        backgroundColor: const Color(0xFF0F766E),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Create Course", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showViewCourseDialog(Map<String, dynamic> c) {
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
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.menu_book_rounded, color: Color(0xFF2563EB), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c["code"] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(c["title"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCourseInfoRow("Course ID", c["id"] as String),
                _buildCourseInfoRow("Department", c["dept"] as String),
                _buildCourseInfoRow("Semester", "Semester ${c["sem"]}"),
                _buildCourseInfoRow("Credits", "${c["credits"]} Credits"),
                _buildCourseInfoRow("Faculty In-Charge", c["faculty"] as String),
                _buildCourseInfoRow("Assigned By", c["assignedBy"] as String),
                _buildCourseInfoRow("Status", c["status"] as String),
                _buildCourseInfoRow("Last Updated", c["updated"] as String),
              ],
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _showEditCourseDialog(c);
              },
              icon: const Icon(Icons.edit_outlined, size: 15),
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

  Widget _buildCourseInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditCourseDialog(Map<String, dynamic> c) {
    final titleCtrl = TextEditingController(text: c["title"] as String);
    final facultyCtrl = TextEditingController(text: c["faculty"] as String);
    final creditsCtrl = TextEditingController(text: c["credits"] as String);
    String status = c["status"] as String;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text("Edit Course: ${c["code"]}", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
              content: Container(
                width: double.maxFinite,
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(labelText: "Course Title"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: facultyCtrl,
                      decoration: const InputDecoration(labelText: "Assigned Faculty"),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: creditsCtrl,
                            decoration: const InputDecoration(labelText: "Credits"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: status,
                            decoration: const InputDecoration(labelText: "Status"),
                            items: ["Active", "Archived"]
                                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setDlgState(() => status = val);
                            },
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
                  child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      c["title"] = titleCtrl.text.trim();
                      c["faculty"] = facultyCtrl.text.trim();
                      c["credits"] = creditsCtrl.text.trim();
                      c["status"] = status;
                      c["updated"] = "Updated just now";
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Course '${c["code"]}' updated successfully!", style: GoogleFonts.poppins()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
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

  void _showDeleteCourseDialog(Map<String, dynamic> c) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Course?", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          content: Text(
            "Are you sure you want to remove '${c["title"]}' (${c["code"]})? This action cannot be undone.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                final removedCourse = Map<String, dynamic>.from(c);
                final removedIndex = _courses.indexOf(c);
                setState(() {
                  _courses.remove(c);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Removed ${removedCourse["code"]}", style: GoogleFonts.poppins()),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _courses.insert(removedIndex >= 0 ? removedIndex : 0, removedCourse);
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
    final filtered = _courses.where((c) {
      if (_selectedFilter != "All" && c["status"] != _selectedFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final id = (c["id"] as String).toLowerCase();
        final code = (c["code"] as String).toLowerCase();
        final title = (c["title"] as String).toLowerCase();
        final dept = (c["dept"] as String).toLowerCase();
        if (!id.contains(query) && !code.contains(query) && !title.contains(query) && !dept.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
        children: [
          // 1. Top Hero Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Filter Pills Row
          _buildFilterPills(),
          const SizedBox(height: 16),

          // 3. Table Card
          _buildTableCard(filtered),
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

            // Large decorative book watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.menu_book_rounded,
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
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                              "Course Management",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // View Only Badge Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lock_outline_rounded, size: 13, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              "View only",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book icon rounded box
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
                            Icons.menu_book_rounded,
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
                              "Course Management",
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
                              "Create, edit and retire courses — code, credits, semester and assigned faculty.",
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
  // 2. FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final allCount = _courses.length;
    final draftCount = _courses.where((c) => c["status"] == "Draft").length;
    final activeCount = _courses.where((c) => c["status"] == "Active").length;
    final archivedCount = _courses.where((c) => c["status"] == "Archived").length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildPillItem("All", "All", allCount),
          const SizedBox(width: 8),
          _buildPillItem("Draft", "Draft", draftCount),
          const SizedBox(width: 8),
          _buildPillItem("Active", "Active", activeCount),
          const SizedBox(width: 8),
          _buildPillItem("Archived", "Archived", archivedCount),
        ],
      ),
    );
  }

  Widget _buildPillItem(String label, String filterKey, int count) {
    final isSelected = _selectedFilter == filterKey;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedFilter = filterKey),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.5),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF141938) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$count",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD
  // ===========================================================================
  Widget _buildTableCard(List<Map<String, dynamic>> list) {
    final totalPages = list.isEmpty ? 1 : ((list.length - 1) ~/ _pageSize) + 1;
    if (_currentPage > totalPages) {
      _currentPage = totalPages;
    }
    final startIndex = (_currentPage - 1) * _pageSize;
    final pageItems = list.skip(startIndex).take(_pageSize).toList();

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
          // Search & Add Course toolbar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 10,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360, minWidth: 200),
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {
                        _currentPage = 1;
                      }),
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "Search by name, ID or course...",
                        hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                        prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${list.length} records",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _showAddCourseDialog,
                      icon: const Icon(Icons.add_rounded, size: 15),
                      label: Text("Add Course", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Horizontal scrollable Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              dataRowMinHeight: 48,
              dataRowMaxHeight: 52,
              horizontalMargin: 16,
              columnSpacing: 22,
              columns: [
                _buildColumn("ID"),
                _buildColumn("COURSE CODE"),
                _buildColumn("COURSE TITLE"),
                _buildColumn("DEPARTMENT"),
                _buildColumn("SEMESTER / PHASE"),
                _buildColumn("CREDITS"),
                _buildColumn("COURSE FACULTY"),
                _buildColumn("CREATED / ASSIGNED BY"),
                _buildColumn("STATUS"),
                _buildColumn("UPDATED"),
                _buildColumn("ACTIONS"),
              ],
              rows: pageItems.map((c) {
                final isArchived = c["status"] == "Archived";
                return DataRow(
                  cells: [
                    DataCell(Text(c["id"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)))),
                    DataCell(Text(c["code"] as String, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)))),
                    DataCell(Text(c["title"] as String, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)))),
                    DataCell(Text(c["dept"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)))),
                    DataCell(Center(child: Text(c["sem"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))))),
                    DataCell(Center(child: Text(c["credits"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))))),
                    DataCell(Text(c["faculty"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)))),
                    DataCell(Center(child: Text(c["assignedBy"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: isArchived ? const Color(0xFFFEF3C7) : const Color(0xFFCCFBF1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          c["status"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: isArchived ? const Color(0xFF92400E) : const Color(0xFF0F766E),
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(c["updated"] as String, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _showViewCourseDialog(c),
                            icon: const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF64748B)),
                            tooltip: "View Course Details",
                            splashRadius: 16,
                          ),
                          IconButton(
                            onPressed: () => _showEditCourseDialog(c),
                            icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4338CA)),
                            tooltip: "Edit Course",
                            splashRadius: 16,
                          ),
                          IconButton(
                            onPressed: () => _showDeleteCourseDialog(c),
                            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                            tooltip: "Delete Course",
                            splashRadius: 16,
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

          // Footer Pagination
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Page $_currentPage of $totalPages (${list.length} total)",
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _currentPage > 1
                            ? () => setState(() => _currentPage--)
                            : null,
                        icon: const Icon(Icons.chevron_left_rounded, size: 16),
                        label: const Text("Prev"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: Size.zero,
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          foregroundColor: const Color(0xFF64748B),
                          textStyle: GoogleFonts.poppins(fontSize: 11.5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: _currentPage < totalPages
                            ? () => setState(() => _currentPage++)
                            : null,
                        icon: const Icon(Icons.chevron_right_rounded, size: 16),
                        label: const Text("Next"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          minimumSize: Size.zero,
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          foregroundColor: const Color(0xFF64748B),
                          textStyle: GoogleFonts.poppins(fontSize: 11.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF64748B),
          letterSpacing: 0.4,
        ),
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
