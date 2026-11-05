import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalUserManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalUserManagementScreen({super.key, this.onBack});

  @override
  State<PrincipalUserManagementScreen> createState() =>
      _PrincipalUserManagementScreenState();
}

class _PrincipalUserManagementScreenState
    extends State<PrincipalUserManagementScreen> {
  String _selectedFilter = "All";
  String _selectedRoleFilter = "All roles";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _userList = [
    {
      "id": "USR-1004",
      "name": "Imran Pillai",
      "email": ".............u.in",
      "role": "Principal /\nInstitution Admin",
      "dept": "Artificial Intelligence & Data Science",
      "status": "Suspended",
      "updated": "23 Sept 2026",
    },
    {
      "id": "USR-1003",
      "name": "Deepika Raman",
      "email": ".............u.in",
      "role": "Student",
      "dept": "Information Technology",
      "status": "Active",
      "updated": "22 Sept 2026",
    },
    {
      "id": "USR-1002",
      "name": "Manoj Khan",
      "email": ".............u.in",
      "role": "Faculty",
      "dept": "Science & Humanities",
      "status": "Active",
      "updated": "21 Sept 2026",
    },
    {
      "id": "USR-1001",
      "name": "Ananya Menon",
      "email": ".............u.in",
      "role": "Student",
      "dept": "Computer Science & Engineering",
      "status": "Active",
      "updated": "20 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredUsers {
    final query = _searchController.text.trim().toLowerCase();
    return _userList.where((u) {
      final matchesFilter = switch (_selectedFilter) {
        "Invited" => u["status"] == "Invited",
        "Active" => u["status"] == "Active",
        "Suspended" => u["status"] == "Suspended",
        _ => true,
      };

      if (!matchesFilter) return false;

      if (_selectedRoleFilter != "All roles") {
        final role = (u["role"] as String).toLowerCase();
        if (!role.contains(_selectedRoleFilter.toLowerCase())) {
          return false;
        }
      }

      if (query.isEmpty) return true;
      final name = (u["name"] as String).toLowerCase();
      final id = (u["id"] as String).toLowerCase();
      final dept = (u["dept"] as String).toLowerCase();
      final role = (u["role"] as String).toLowerCase();
      return name.contains(query) ||
          id.contains(query) ||
          dept.contains(query) ||
          role.contains(query);
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

                // 3. TABLE CARD (Search, Roles Dropdown, User Table, Pagination)
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
                  Icons.admin_panel_settings_outlined,
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
                          "User Management",
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

                  // Responsive Header Row with Icon, Badges, Title & Add User Button
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
                            Icons.admin_panel_settings_rounded,
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
                            "User Management",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Create accounts, assign roles, suspend access and enforce MFA.",
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
                          _showAddUserDialog(context);
                        },
                        icon: const Icon(Icons.add_rounded,
                            size: 18, color: Color(0xFF0F172A)),
                        label: Text(
                          "Add user",
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
      {"label": "Invited", "count": 0},
      {"label": "Active", "count": 3},
      {"label": "Suspended", "count": 1},
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
  // 3. TABLE CARD (Search, Roles Dropdown, User Table, Pagination)
  // ===========================================================================
  Widget _buildTableCard() {
    final users = _filteredUsers;

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
          // Search Bar, Role Filter Dropdown & Record Count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 14,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Search Input
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 260, maxWidth: 440),
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
                        hintText: "Search by name, ID or role...",
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

                // All roles dropdown
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRoleFilter,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E293B),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "All roles", child: Text("All roles")),
                        DropdownMenuItem(
                            value: "Principal", child: Text("Principal")),
                        DropdownMenuItem(
                            value: "Faculty", child: Text("Faculty")),
                        DropdownMenuItem(
                            value: "Student", child: Text("Student")),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedRoleFilter = val);
                        }
                      },
                    ),
                  ),
                ),

                // Count
                Text(
                  "${users.length} records",
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
              constraints: const BoxConstraints(minWidth: 1060),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                headingRowHeight: 46,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 64,
                horizontalMargin: 20,
                columnSpacing: 24,
                columns: [
                  _buildDataColumn("ID"),
                  _buildDataColumn("FULL NAME"),
                  _buildDataColumn("EMAIL"),
                  _buildDataColumn("ROLE"),
                  _buildDataColumn("DEPARTMENT"),
                  _buildDataColumn("STATUS"),
                  _buildDataColumn("UPDATED"),
                  _buildDataColumn("ACTIONS"),
                ],
                rows: users.map((u) {
                  final isSuspended = u["status"] == "Suspended";

                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          u["id"] as String,
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
                          u["name"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Email
                      DataCell(
                        Text(
                          u["email"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Role Pill
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            u["role"] as String,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4338CA),
                              height: 1.25,
                            ),
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          u["dept"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Status Pill
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: isSuspended
                                ? const Color(0xFFFEE2E2)
                                : const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            u["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSuspended
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF16A34A),
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          u["updated"] as String,
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
                                    content: Text("Viewing ${u["name"]}"),
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
                                    content: Text("Editing ${u["name"]}"),
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
                                    content: Text("Deleting ${u["name"]}"),
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

  void _showAddUserDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final roleCtrl = TextEditingController(text: "Faculty");
    final deptCtrl = TextEditingController(text: "Computer Science & Engineering");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Add User Account",
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
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: "Institutional Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: roleCtrl,
              decoration: const InputDecoration(
                labelText: "Role Assignment",
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
                  content: Text("User provision invitation generated"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF131B4D),
              foregroundColor: Colors.white,
            ),
            child: const Text("Create User"),
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
