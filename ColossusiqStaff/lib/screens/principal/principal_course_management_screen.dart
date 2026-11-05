import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: COURSE MANAGEMENT SCREEN (Matches Images 1 & 2)
// - Hero Blueprint Banner: "Home > Academics > Course Management", badges ACADEMICS, MVP
// - Top-right action: "+ Add course"
// - Filter pills: All (6), Draft (0), Active (5), Archived (1)
// - Table card: Search bar with "6 records" counter
// - Data Table: ID, Course Code, Course Title, Department, Semester/Phase, Credits,
//               Course Faculty, Created/Assigned By, Status, Updated, Actions
// - Pagination: Page 1 of 1, Prev, Next
// =============================================================================

class PrincipalCourseManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalCourseManagementScreen({super.key, this.onBack});

  @override
  State<PrincipalCourseManagementScreen> createState() =>
      _PrincipalCourseManagementScreenState();
}

class _PrincipalCourseManagementScreenState
    extends State<PrincipalCourseManagementScreen> {
  int _activeFilterIndex = 0; // 0: All 6, 1: Draft 0, 2: Active 5, 3: Archived 1
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allCourses = [
    {
      "id": "CRS-1006",
      "code": "ME3491",
      "title": "Theory of Machines",
      "dept": "Mechanical Engineering",
      "semester": "4",
      "credits": "4",
      "faculty": "Prof. N. Kumar",
      "assignedBy": "—",
      "status": "Archived",
      "updated": "25 Sept 2026",
    },
    {
      "id": "CRS-1005",
      "code": "EC3351",
      "title": "Control Systems",
      "dept": "Electronics & Communication",
      "semester": "3",
      "credits": "4",
      "faculty": "Dr. S. Priya",
      "assignedBy": "—",
      "status": "Active",
      "updated": "24 Sept 2026",
    },
    {
      "id": "CRS-1004",
      "code": "AL3451",
      "title": "Machine Learning",
      "dept": "Artificial Intelligence & Data Science",
      "semester": "4",
      "credits": "3",
      "faculty": "Dr. V. Srinivasan",
      "assignedBy": "—",
      "status": "Active",
      "updated": "23 Sept 2026",
    },
    {
      "id": "CRS-1003",
      "code": "CS3591",
      "title": "Computer Networks",
      "dept": "Computer Science & Engineering",
      "semester": "5",
      "credits": "4",
      "faculty": "Dr. K. Anitha",
      "assignedBy": "—",
      "status": "Active",
      "updated": "22 Sept 2026",
    },
    {
      "id": "CRS-1002",
      "code": "CS3451",
      "title": "Operating Systems",
      "dept": "Computer Science & Engineering",
      "semester": "4",
      "credits": "3",
      "faculty": "Prof. R. Balaji",
      "assignedBy": "—",
      "status": "Active",
      "updated": "21 Sept 2026",
    },
    {
      "id": "CRS-1001",
      "code": "CS3492",
      "title": "Database Management Systems",
      "dept": "Computer Science & Engineering",
      "semester": "4",
      "credits": "4",
      "faculty": "Dr. Meena Raghavan",
      "assignedBy": "—",
      "status": "Active",
      "updated": "20 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredCourses {
    var list = _allCourses;
    if (_activeFilterIndex == 1) {
      list = list.where((c) => c["status"] == "Draft").toList();
    } else if (_activeFilterIndex == 2) {
      list = list.where((c) => c["status"] == "Active").toList();
    } else if (_activeFilterIndex == 3) {
      list = list.where((c) => c["status"] == "Archived").toList();
    }

    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((c) {
        return (c["title"] as String).toLowerCase().contains(query) ||
            (c["code"] as String).toLowerCase().contains(query) ||
            (c["id"] as String).toLowerCase().contains(query) ||
            (c["dept"] as String).toLowerCase().contains(query);
      }).toList();
    }
    return list;
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

          final displayed = _filteredCourses;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP HERO BLUEPRINT BANNER (Images 1 & 2)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. FILTER PILLS: All (6), Draft (0), Active (5), Archived (1)
                _buildFilterPills(),
                const SizedBox(height: 18),

                // 3. TABLE CARD WITH SEARCH & DATA
                _buildTableCard(displayed),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER
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
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Large watermark icon on right
            Positioned(
              right: 18,
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

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs row (Scrollable on small devices)
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
                        Text("Academics",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Course Management",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges: ACADEMICS, MVP
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
                          "ACADEMICS",
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
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "MVP",
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

                  // Main Title + Action Button (Responsive LayoutBuilder)
                  LayoutBuilder(
                    builder: (context, bannerConstraints) {
                      final isCompact = bannerConstraints.maxWidth < 650;

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
                            Icons.bookmark_outline_rounded,
                            color: Color(0xFFFBBF24), // Yellow Bookmark
                            size: 22,
                          ),
                        ),
                      );

                      final titleContent = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course Management",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Create, edit and retire courses — code, credits, semester and assigned faculty.",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFFCBD5E1),
                              height: 1.4,
                            ),
                          ),
                        ],
                      );

                      final addCourseButton = ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Add Course modal opened",
                                  style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_rounded,
                            size: 16, color: Color(0xFF1E293B)),
                        label: Text(
                          "Add course",
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
                            addCourseButton,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconWidget,
                          const SizedBox(width: 14),
                          Expanded(child: titleContent),
                          const SizedBox(width: 16),
                          addCourseButton,
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
  // 2. TOP FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final pills = [
      {"label": "All", "count": 6},
      {"label": "Draft", "count": 0},
      {"label": "Active", "count": 5},
      {"label": "Archived", "count": 1},
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
              onTap: () {
                setState(() => _activeFilterIndex = index);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
                        color:
                            isSelected ? Colors.white : const Color(0xFF64748B),
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
  // 3. TABLE CARD
  // ===========================================================================
  Widget _buildTableCard(List<Map<String, dynamic>> displayed) {
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
          // Search row
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
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: "Search by name, ID or course title...",
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
                  "${displayed.length} records",
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

          // Scrollable Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 22,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 52,
                dataRowMaxHeight: 56,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("COURSE CODE")),
                  DataColumn(label: Text("COURSE TITLE")),
                  DataColumn(label: Text("DEPARTMENT")),
                  DataColumn(label: Text("SEMESTER / PHASE"), numeric: true),
                  DataColumn(label: Text("CREDITS"), numeric: true),
                  DataColumn(label: Text("COURSE FACULTY")),
                  DataColumn(label: Text("CREATED / ASSIGNED BY")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: displayed.map((c) {
                  final isArchived = c["status"] == "Archived";
                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          c["id"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                      // Course Code
                      DataCell(
                        Text(
                          c["code"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Course Title
                      DataCell(
                        Text(
                          c["title"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          c["dept"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Semester
                      DataCell(
                        Text(
                          c["semester"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Credits
                      DataCell(
                        Text(
                          c["credits"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Faculty
                      DataCell(
                        Text(
                          c["faculty"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Assigned By
                      DataCell(
                        Text(
                          c["assignedBy"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                      // Status Badge
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: isArchived
                                ? const Color(0xFFF5EFE6)
                                : const Color(0xFFE6F4EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            c["status"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: isArchived
                                  ? const Color(0xFF92400E)
                                  : const Color(0xFF047857),
                            ),
                          ),
                        ),
                      ),
                      // Updated Date
                      DataCell(
                        Text(
                          c["updated"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
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
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                              tooltip: "View",
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                              tooltip: "Edit",
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                              tooltip: "Delete",
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

          // Pagination bar
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
                      onPressed: null,
                      icon: const Icon(Icons.chevron_left_rounded, size: 14),
                      label: const Text("Prev"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.chevron_right_rounded, size: 14),
                      label: const Text("Next"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
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
