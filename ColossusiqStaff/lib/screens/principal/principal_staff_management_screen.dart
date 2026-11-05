import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalStaffManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalStaffManagementScreen({super.key, this.onBack});

  @override
  State<PrincipalStaffManagementScreen> createState() =>
      _PrincipalStaffManagementScreenState();
}

class _PrincipalStaffManagementScreenState
    extends State<PrincipalStaffManagementScreen> {
  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _staffList = [
    {
      "id": "EMP-1004",
      "name": "Ms. Harish Kumar",
      "dept": "Administration",
      "designation": "Accountant",
      "type": "Administrative",
      "status": "Active",
      "updated": "23 Sept 2026",
    },
    {
      "id": "EMP-1003",
      "name": "Prof. Meera Joseph",
      "dept": "Electronics & Communication",
      "designation": "Associate Professor",
      "type": "Teaching",
      "status": "Active",
      "updated": "22 Sept 2026",
    },
    {
      "id": "EMP-1002",
      "name": "Dr. Arjun Subramanian",
      "dept": "Computer Science & Engineering",
      "designation": "Associate Professor",
      "type": "Teaching",
      "status": "Active",
      "updated": "21 Sept 2026",
    },
    {
      "id": "EMP-1001",
      "name": "Dr. Aishwarya Mohan",
      "dept": "Science & Humanities",
      "designation": "Associate Professor",
      "type": "Teaching",
      "status": "On leave",
      "updated": "20 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredStaff {
    final query = _searchController.text.trim().toLowerCase();
    return _staffList.where((staff) {
      final matchesFilter = switch (_selectedFilter) {
        "Active" => staff["status"] == "Active",
        "On leave" => staff["status"] == "On leave",
        "Resigned" => staff["status"] == "Resigned",
        "Retired" => staff["status"] == "Retired",
        _ => true,
      };

      if (!matchesFilter) return false;

      if (query.isEmpty) return true;
      final name = (staff["name"] as String).toLowerCase();
      final id = (staff["id"] as String).toLowerCase();
      final dept = (staff["dept"] as String).toLowerCase();
      final designation = (staff["designation"] as String).toLowerCase();
      return name.contains(query) ||
          id.contains(query) ||
          dept.contains(query) ||
          designation.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Warm neutral canvas background
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
                // 1. TOP BLUEPRINT BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. HORIZONTAL FILTER PILLS
                _buildFilterPills(),
                const SizedBox(height: 18),

                // 3. TABLE CARD (Search, Roster Table, Pagination)
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
                  Icons.badge_outlined,
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
                          "Staff & Users",
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
                          "Staff Management",
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

                  // Responsive Header Layout
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
                            Icons.badge_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber/gold ID badge
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
                                  "STAFF & USERS",
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
                            "Staff Management",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Teaching and non-teaching staff records — department, designation, employment and status.",
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
                          _showAddStaffDialog(context);
                        },
                        icon: const Icon(Icons.add_rounded,
                            size: 18, color: Color(0xFF0F172A)),
                        label: Text(
                          "Add staff member",
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
      {"label": "All", "count": 4},
      {"label": "Active", "count": 3},
      {"label": "On leave", "count": 1},
      {"label": "Resigned", "count": 0},
      {"label": "Retired", "count": 0},
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
  // 3. TABLE CARD (Search, Roster Table, Pagination)
  // ===========================================================================
  Widget _buildTableCard() {
    final staffList = _filteredStaff;

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
                    height: 42,
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
                        hintText: "Search by name, ID or department...",
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
                  "${staffList.length} records",
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
              constraints: const BoxConstraints(minWidth: 1000),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingRowHeight: 46,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 56,
                horizontalMargin: 20,
                columnSpacing: 24,
                columns: [
                  _buildDataColumn("ID"),
                  _buildDataColumn("FULL NAME"),
                  _buildDataColumn("DEPARTMENT"),
                  _buildDataColumn("DESIGNATION"),
                  _buildDataColumn("STAFF TYPE"),
                  _buildDataColumn("STATUS"),
                  _buildDataColumn("UPDATED"),
                  _buildDataColumn("ACTIONS"),
                ],
                rows: staffList.map((s) {
                  final isTeaching = s["type"] == "Teaching";
                  final isActive = s["status"] == "Active";

                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          s["id"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Full name
                      DataCell(
                        Text(
                          s["name"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          s["dept"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Designation
                      DataCell(
                        Text(
                          s["designation"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Staff Type
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: isTeaching
                                ? const Color(0xFFEEF2FF)
                                : const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s["type"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isTeaching
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFF7E22CE),
                            ),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          s["updated"] as String,
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
                                    content: Text("Viewing ${s["name"]}"),
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
                                    content: Text("Editing ${s["name"]}"),
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
                                    content: Text("Deleting ${s["name"]}"),
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
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table Footer (Page 1 of 1 and Prev/Next)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page 1 of 1",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: null, // Disabled
                      icon: const Icon(Icons.chevron_left_rounded, size: 16),
                      label: Text("Prev",
                          style: GoogleFonts.poppins(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF94A3B8),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: null, // Disabled
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF94A3B8),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text("Next",
                              style: GoogleFonts.poppins(fontSize: 12)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right_rounded, size: 16),
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

  void _showAddStaffDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final deptCtrl = TextEditingController(text: "Computer Science & Engineering");
    final desigCtrl = TextEditingController(text: "Assistant Professor");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Add Staff Member",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: deptCtrl,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: desigCtrl,
              decoration: const InputDecoration(
                labelText: "Designation",
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
                  content: Text("Staff member onboarding draft created"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF131B4D),
              foregroundColor: Colors.white,
            ),
            child: const Text("Save"),
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
