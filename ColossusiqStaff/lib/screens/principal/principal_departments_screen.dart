import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalDepartmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalDepartmentsScreen({super.key, this.onBack});

  @override
  State<PrincipalDepartmentsScreen> createState() =>
      _PrincipalDepartmentsScreenState();
}

class _PrincipalDepartmentsScreenState
    extends State<PrincipalDepartmentsScreen> {
  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _departments = [
    {
      "id": "DEP-1008",
      "name": "Science & Humanities",
      "hod": "Dr. Nikhil Khan",
      "status": "Active",
      "programmes": 3,
      "students": 527,
      "faculty": 0,
      "readiness": 87,
      "updated": "27 Sept 2026",
    },
    {
      "id": "DEP-1007",
      "name": "Civil Engineering",
      "hod": "Dr. Kavya Menon",
      "status": "Active",
      "programmes": 2,
      "students": 346,
      "faculty": 0,
      "readiness": 81,
      "updated": "26 Sept 2026",
    },
    {
      "id": "DEP-1006",
      "name": "Mechanical Engineering",
      "hod": "Dr. Harish Kumar",
      "status": "Active",
      "programmes": 1,
      "students": 360,
      "faculty": 0,
      "readiness": 75,
      "updated": "25 Sept 2026",
    },
    {
      "id": "DEP-1005",
      "name": "Electrical & Electronics",
      "hod": "Dr. Meera Joseph",
      "status": "Active",
      "programmes": 1,
      "students": 465,
      "faculty": 0,
      "readiness": 80,
      "updated": "24 Sept 2026",
    },
    {
      "id": "DEP-1004",
      "name": "Electronics & Communication",
      "hod": "Dr. Arjun...",
      "status": "Active",
      "programmes": 3,
      "students": 335,
      "faculty": 1,
      "readiness": 80,
      "updated": "23 Sept 2026",
    },
    {
      "id": "DEP-1003",
      "name": "Artificial Intelligence & Data Science",
      "hod": "Dr. Aishwarya...",
      "status": "Active",
      "programmes": 2,
      "students": 253,
      "faculty": 0,
      "readiness": 83,
      "updated": "22 Sept 2026",
    },
    {
      "id": "DEP-1002",
      "name": "Information Technology",
      "hod": "Dr. Vignesh Rao",
      "status": "Active",
      "programmes": 2,
      "students": 442,
      "faculty": 0,
      "readiness": 82,
      "updated": "21 Sept 2026",
    },
    {
      "id": "DEP-1001",
      "name": "Computer Science & Engineering",
      "hod": "Dr. Sneha Reddy",
      "status": "Active",
      "programmes": 3,
      "students": 530,
      "faculty": 1,
      "readiness": 75,
      "updated": "20 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDepts {
    final query = _searchController.text.trim().toLowerCase();
    return _departments.where((d) {
      final matchesFilter = switch (_selectedFilter) {
        "Active" => d["status"] == "Active",
        "Inactive" => d["status"] == "Inactive",
        _ => true,
      };

      if (!matchesFilter) return false;

      if (query.isEmpty) return true;
      final name = (d["name"] as String).toLowerCase();
      final id = (d["id"] as String).toLowerCase();
      final hod = (d["hod"] as String).toLowerCase();
      return name.contains(query) || id.contains(query) || hod.contains(query);
    }).toList();
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
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. HORIZONTAL FILTER PILLS
                _buildFilterPills(),
                const SizedBox(height: 18),

                // 3. TABLE CARD (Search, Departments Table)
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
              right: 18,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.domain_outlined,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
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
                          "Institution",
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
                          "Departments",
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

                  // Responsive Header Row with Icon, Badges, Title & Add Dept Button
                  LayoutBuilder(
                    builder: (context, headerConstraints) {
                      final isCompact = headerConstraints.maxWidth < 680;

                      final iconWidget = Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26336A).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.domain_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber gold icon
                          ),
                        ),
                      );

                      final titleColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B)
                                      .withValues(alpha: 0.65),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ),
                                child: Text(
                                  "INSTITUTION",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D9488),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "MVP",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Departments",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Departments of the college, their heads and contacts, with live student, faculty and placement figures.",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFCBD5E1),
                              height: 1.4,
                            ),
                          ),
                        ],
                      );

                      final actionButton = ElevatedButton.icon(
                        onPressed: () {
                          _showAddDeptDialog(context);
                        },
                        icon: const Icon(Icons.add_rounded,
                            size: 18, color: Color(0xFF0F172A)),
                        label: Text(
                          "Add department",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEAB308), // Amber gold
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                                Expanded(child: titleColumn),
                              ],
                            ),
                            const SizedBox(height: 14),
                            actionButton,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconWidget,
                          const SizedBox(width: 14),
                          Expanded(child: titleColumn),
                          const SizedBox(width: 16),
                          actionButton,
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
  // 2. HORIZONTAL FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final filters = [
      {"label": "All", "count": 8},
      {"label": "Active", "count": 8},
      {"label": "Inactive", "count": 0},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((f) {
          final label = f["label"] as String;
          final count = f["count"] as int;
          final isSelected = _selectedFilter == label;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                setState(() => _selectedFilter = label);
              },
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.22)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$count",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
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
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD (Search, Departments Table)
  // ===========================================================================
  Widget _buildTableCard() {
    final depts = _filteredDepts;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar & Record Count Header
          Padding(
            padding: const EdgeInsets.all(16),
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
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF1E293B),
                      ),
                      decoration: InputDecoration(
                        hintText: "Search by name, ID or head of department...",
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
                  "${depts.length} records",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table Header & Rows (Horizontal scrolling on small screens)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1100),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingRowHeight: 46,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 56,
                horizontalMargin: 20,
                columnSpacing: 22,
                columns: [
                  _buildDataColumn("ID"),
                  _buildDataColumn("DEPARTMENT"),
                  _buildDataColumn("HEAD OF DEPARTMENT"),
                  _buildDataColumn("STATUS"),
                  _buildDataColumn("PROGRAMMES"),
                  _buildDataColumn("STUDENTS"),
                  _buildDataColumn("FACULTY"),
                  _buildDataColumn("PLACEMENT READINESS"),
                  _buildDataColumn("UPDATED"),
                  _buildDataColumn("ACTIONS"),
                ],
                rows: depts.map((d) {
                  final readiness = d["readiness"] as int;

                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          d["id"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          d["name"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Head of Department
                      DataCell(
                        Text(
                          d["hod"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            d["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF16A34A),
                            ),
                          ),
                        ),
                      ),
                      // Programmes
                      DataCell(
                        Center(
                          child: Text(
                            "${d["programmes"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                      // Students
                      DataCell(
                        Center(
                          child: Text(
                            "${d["students"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                      // Faculty
                      DataCell(
                        Center(
                          child: Text(
                            "${d["faculty"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                      // Placement Readiness
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: readiness / 100.0,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF0D9488)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$readiness%",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          d["updated"] as String,
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
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Viewing ${d["name"]}"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              tooltip: "View",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Editing ${d["name"]}"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              tooltip: "Edit",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Deleting ${d["name"]}"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFF64748B)),
                              tooltip: "Delete",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
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
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: const Color(0xFF64748B),
        ),
      ),
    );
  }

  void _showAddDeptDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final hodCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Add Academic Department",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Department Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: hodCtrl,
              decoration: const InputDecoration(
                labelText: "Head of Department (HOD)",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("New academic department registered"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF131B4D),
              foregroundColor: Colors.white,
            ),
            child: const Text("Create Department"),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
