import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum UserManagementViewMode {
  list,
  addUser,
  editUser,
  viewUser,
}

class PrincipalUserManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalUserManagementScreen({super.key, this.onBack});

  @override
  State<PrincipalUserManagementScreen> createState() =>
      _PrincipalUserManagementScreenState();
}

class _PrincipalUserManagementScreenState
    extends State<PrincipalUserManagementScreen> {
  UserManagementViewMode _viewMode = UserManagementViewMode.list;

  String _selectedFilter = "All";
  String _selectedRoleFilter = "All roles";
  final TextEditingController _searchController = TextEditingController();

  // Active user data list matching user reference images
  late List<Map<String, dynamic>> _userList;
  Map<String, dynamic>? _selectedUser;

  // Form Controllers & State for Add / Edit
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedRole = "Select..";
  String _selectedDepartment = "- None -";
  String _selectedStatus = "Invited";
  bool _requireMfa = true;
  bool _allowSsoOnly = false;

  final List<String> _roleOptions = [
    "Select..",
    "Principal / Institution Admin",
    "HOD / Department Head",
    "Faculty",
    "Student",
    "Staff",
  ];

  final List<String> _deptOptions = [
    "- None -",
    "Computer Science & Engineering",
    "Information Technology",
    "Electronics & Communication",
    "Mechanical Engineering",
    "Civil Engineering",
    "Artificial Intelligence & Data Science",
    "Science & Humanities",
  ];

  final List<String> _statusOptions = [
    "Invited",
    "Active",
    "Suspended",
  ];

  @override
  void initState() {
    super.initState();
    _userList = [
      {
        "id": "USR-1003",
        "name": "Dr. Lakshmi Sundaram",
        "email": "principal@ait.edu.in",
        "role": "Principal / Institution Admin",
        "dept": "- None -",
        "status": "Active",
        "updated": "24 Nov 2026",
        "created": "29 Sept 2026",
        "version": 146,
        "requireMfa": true,
        "allowSsoOnly": false,
        "notes": "",
      },
      {
        "id": "USR-1004",
        "name": "Imran Pillai",
        "email": "imran@aist.edu.in",
        "role": "Principal / Institution Admin",
        "dept": "Artificial Intelligence & Data Science",
        "status": "Suspended",
        "updated": "23 Sept 2026",
        "created": "29 Sept 2026",
        "version": 82,
        "requireMfa": true,
        "allowSsoOnly": false,
        "notes": "Temporary suspension pending audit review.",
      },
      {
        "id": "USR-1002",
        "name": "Manoj Khan",
        "email": "manoj@aist.edu.in",
        "role": "Faculty",
        "dept": "Science & Humanities",
        "status": "Active",
        "updated": "21 Sept 2026",
        "created": "20 Sept 2026",
        "version": 45,
        "requireMfa": true,
        "allowSsoOnly": false,
        "notes": "",
      },
      {
        "id": "USR-1001",
        "name": "Ananya Menon",
        "email": "ananya@aist.edu.in",
        "role": "Student",
        "dept": "Computer Science & Engineering",
        "status": "Active",
        "updated": "20 Sept 2026",
        "created": "18 Sept 2026",
        "version": 12,
        "requireMfa": false,
        "allowSsoOnly": false,
        "notes": "",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _initFormForAdd() {
    _fullNameController.clear();
    _emailController.clear();
    _notesController.clear();
    _selectedRole = "Select..";
    _selectedDepartment = "- None -";
    _selectedStatus = "Invited";
    _requireMfa = true;
    _allowSsoOnly = false;
  }

  void _initFormForEdit(Map<String, dynamic> user) {
    _selectedUser = user;
    _fullNameController.text = user["name"] as String? ?? "";
    _emailController.text = user["email"] as String? ?? "";
    _notesController.text = user["notes"] as String? ?? "";
    _selectedRole = user["role"] as String? ?? "Principal / Institution Admin";
    _selectedDepartment = user["dept"] as String? ?? "- None -";
    _selectedStatus = user["status"] as String? ?? "Active";
    _requireMfa = user["requireMfa"] as bool? ?? true;
    _allowSsoOnly = user["allowSsoOnly"] as bool? ?? false;
  }

  int _calculateRequiredFieldsFilled() {
    int filled = 0;
    if (_fullNameController.text.trim().isNotEmpty) filled++;
    if (_emailController.text.trim().isNotEmpty) filled++;
    if (_selectedRole.isNotEmpty && _selectedRole != "Select..") filled++;
    if (_selectedStatus.isNotEmpty) filled++;
    return filled;
  }

  void _saveUserChanges() {
    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      _showWarningSnackBar("Please enter full name");
      return;
    }
    if (email.isEmpty) {
      _showWarningSnackBar("Please enter email address");
      return;
    }
    if (_selectedRole == "Select..") {
      _showWarningSnackBar("Please select a role");
      return;
    }

    if (_viewMode == UserManagementViewMode.editUser && _selectedUser != null) {
      setState(() {
        _selectedUser!["name"] = name;
        _selectedUser!["email"] = email;
        _selectedUser!["role"] = _selectedRole;
        _selectedUser!["dept"] = _selectedDepartment;
        _selectedUser!["status"] = _selectedStatus;
        _selectedUser!["requireMfa"] = _requireMfa;
        _selectedUser!["allowSsoOnly"] = _allowSsoOnly;
        _selectedUser!["notes"] = _notesController.text.trim();
        _selectedUser!["updated"] = "24 Nov 2026";
        _selectedUser!["version"] = (_selectedUser!["version"] as int? ?? 1) + 1;
        _viewMode = UserManagementViewMode.viewUser;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Changes saved for '$name'"),
          backgroundColor: const Color(0xFF0D9488),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (_viewMode == UserManagementViewMode.addUser) {
      final newId = "USR-${1000 + _userList.length + 1}";
      final newUser = {
        "id": newId,
        "name": name,
        "email": email,
        "role": _selectedRole,
        "dept": _selectedDepartment,
        "status": _selectedStatus,
        "updated": "24 Nov 2026",
        "created": "24 Nov 2026",
        "version": 1,
        "requireMfa": _requireMfa,
        "allowSsoOnly": _allowSsoOnly,
        "notes": _notesController.text.trim(),
      };
      setState(() {
        _userList.insert(0, newUser);
        _selectedUser = newUser;
        _viewMode = UserManagementViewMode.viewUser;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User account '$name' ($newId) created successfully"),
          backgroundColor: const Color(0xFF0D9488),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
                _buildHeroBanner(constraints.maxWidth),
                const SizedBox(height: 18),

                // 2. VIEW CONTENT
                if (_viewMode == UserManagementViewMode.addUser)
                  _buildAddUserView(constraints.maxWidth)
                else if (_viewMode == UserManagementViewMode.editUser &&
                    _selectedUser != null)
                  _buildEditUserView(constraints.maxWidth)
                else if (_viewMode == UserManagementViewMode.viewUser &&
                    _selectedUser != null)
                  _buildViewUserDetails(constraints.maxWidth)
                else ...[
                  // Horizontal Filter Pills
                  _buildFilterPills(),
                  const SizedBox(height: 16),

                  // Table Card (Search, Roles Dropdown, User Table, Pagination)
                  _buildTableCard(),
                ],
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
  Widget _buildHeroBanner(double maxWidth) {
    final isCompact = maxWidth < 720;

    String title;
    String subtitle;
    List<Widget> crumbs;

    if (_viewMode == UserManagementViewMode.addUser) {
      title = "Add user";
      subtitle = "Fill in the details below. Fields marked * are required.";
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Staff & Users", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Add user"),
        _buildBreadcrumbSeparator(),
        Text(
          "New user",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else if (_viewMode == UserManagementViewMode.editUser &&
        _selectedUser != null) {
      final userId = _selectedUser!["id"] as String;
      title = "Edit user · $userId";
      subtitle =
          "Update the details below. Changes are validated, versioned and recorded in the audit log.";
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Staff & Users", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Edit user · $userId"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText(userId),
        _buildBreadcrumbSeparator(),
        Text(
          "Edit",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else if (_viewMode == UserManagementViewMode.viewUser &&
        _selectedUser != null) {
      final userId = _selectedUser!["id"] as String;
      final userName = _selectedUser!["name"] as String;
      final userRole = _selectedUser!["role"] as String;
      title = userName;
      subtitle = userRole;
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Staff & Users", onTap: () => setState(() => _viewMode = UserManagementViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText(userName),
        _buildBreadcrumbSeparator(),
        Text(
          userId,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else {
      title = "User Management";
      subtitle =
          "Create accounts, assign roles, suspend access and enforce MFA.";
      crumbs = [
        _buildBreadcrumbText("Home"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Staff & Users"),
        _buildBreadcrumbSeparator(),
        Text(
          "User Management",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ];
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E2865),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
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
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.supervised_user_circle_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null &&
                            _viewMode == UserManagementViewMode.list) ...[
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
                        ...crumbs,
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  if (isCompact)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroTitleBlock(title, subtitle),
                        const SizedBox(height: 14),
                        _buildHeroActionButton(),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildHeroTitleBlock(title, subtitle)),
                        const SizedBox(width: 16),
                        _buildHeroActionButton(),
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

  Widget _buildBreadcrumbText(String text, {VoidCallback? onTap}) {
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      );
    }
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        color: Colors.white.withValues(alpha: 0.75),
      ),
    );
  }

  Widget _buildBreadcrumbSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.chevron_right_rounded,
          size: 13, color: Colors.white.withValues(alpha: 0.5)),
    );
  }

  Widget _buildHeroTitleBlock(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.manage_accounts_rounded,
              size: 26,
              color: Color(0xFFFBBF24), // Amber gold
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E3B7D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "STAFF & USERS",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "MVP",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                title,
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFFCBD5E1),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroActionButton() {
    if (_viewMode == UserManagementViewMode.viewUser && _selectedUser != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _initFormForEdit(_selectedUser!);
              setState(() => _viewMode = UserManagementViewMode.editUser);
            },
            icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF0F172A)),
            label: Text(
              "Edit",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEAB308), // Amber gold
              foregroundColor: const Color(0xFF0F172A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () => _showDeleteUserModal(_selectedUser!),
            icon: const Icon(Icons.delete_outline_rounded, size: 14, color: Colors.white),
            label: Text(
              "Delete",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      );
    }

    if (_viewMode == UserManagementViewMode.addUser ||
        _viewMode == UserManagementViewMode.editUser) {
      return OutlinedButton.icon(
        onPressed: () => setState(() => _viewMode = UserManagementViewMode.list),
        icon:
            const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
        label: Text(
          "Back to user management",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF64748B)),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: () {
        _initFormForAdd();
        setState(() => _viewMode = UserManagementViewMode.addUser);
      },
      icon: const Icon(Icons.add_rounded, size: 18, color: Color(0xFF0F172A)),
      label: Text(
        "Add user",
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEAB308), // Amber gold
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. HORIZONTAL FILTER PILLS
  // ===========================================================================
  Widget _buildFilterPills() {
    final filters = [
      {"label": "All", "count": _userList.length},
      {
        "label": "Invited",
        "count": _userList.where((u) => u["status"] == "Invited").length
      },
      {
        "label": "Active",
        "count": _userList.where((u) => u["status"] == "Active").length
      },
      {
        "label": "Suspended",
        "count": _userList.where((u) => u["status"] == "Suspended").length
      },
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
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
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
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search & Filter Dropdown Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 600;

                final searchField = TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Search by name, email or roll n...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF94A3B8),
                    ),
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: Color(0xFF94A3B8)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 11),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF1E2865)),
                    ),
                  ),
                );

                final roleDropdown = Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRoleFilter,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: Color(0xFF64748B)),
                      items: [
                        "All roles",
                        "Principal",
                        "Faculty",
                        "Student",
                      ].map((r) {
                        return DropdownMenuItem<String>(
                          value: r,
                          child: Text(
                            r,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedRoleFilter = val);
                        }
                      },
                    ),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchField,
                      const SizedBox(height: 10),
                      roleDropdown,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 12),
                    roleDropdown,
                  ],
                );
              },
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // User Table with light beige header
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: const Color(0xFFF1F5F9),
              ),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingRowHeight: 46,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 68,
                horizontalMargin: 20,
                columnSpacing: 28,
                columns: [
                  _buildDataColumn("NAME"),
                  _buildDataColumn("EMAIL"),
                  _buildDataColumn("ROLE"),
                  _buildDataColumn("DEPARTMENT"),
                  _buildDataColumn("STATUS"),
                  _buildDataColumn("UPDATED"),
                  _buildDataColumn("ACTIONS"),
                ],
                rows: users.map((u) {
                  final isSuspended = u["status"] == "Suspended";
                  final role = u["role"] as String;

                  return DataRow(
                    cells: [
                      // Name & ID
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedUser = u;
                              _viewMode = UserManagementViewMode.viewUser;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                u["name"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                u["id"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
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
                              horizontal: 10, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: role.contains("Principal")
                                ? const Color(0xFFFEE2E2)
                                : role.contains("Faculty")
                                    ? const Color(0xFFEDE9FE)
                                    : const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            role,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: role.contains("Principal")
                                  ? const Color(0xFFDC2626)
                                  : role.contains("Faculty")
                                      ? const Color(0xFF6D28D9)
                                      : const Color(0xFF0284C7),
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
                                : const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            u["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSuspended
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF0D9488),
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
                                setState(() {
                                  _selectedUser = u;
                                  _viewMode = UserManagementViewMode.viewUser;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 17, color: Color(0xFF2563EB)),
                              tooltip: "View Details",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _initFormForEdit(u);
                                setState(() =>
                                    _viewMode = UserManagementViewMode.editUser);
                              },
                              icon: const Icon(Icons.edit_outlined,
                                  size: 17, color: Color(0xFFD97706)),
                              tooltip: "Edit User",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () => _showDeleteUserModal(u),
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 17, color: Color(0xFFEF4444)),
                              tooltip: "Delete User",
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
                      onPressed: null,
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
                      onPressed: null,
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

  // ===========================================================================
  // 4. ADD USER VIEW (Image 1)
  // ===========================================================================
  Widget _buildAddUserView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAccountStepCard(),
        const SizedBox(height: 18),
        _buildSecurityStepCard(),
      ],
    );

    final rightSidebarContent = _buildSidebarCard(isEdit: false);

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: leftFormContent),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: rightSidebarContent),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        rightSidebarContent,
        const SizedBox(height: 20),
        leftFormContent,
      ],
    );
  }

  // ===========================================================================
  // 5. EDIT USER VIEW (Image 2)
  // ===========================================================================
  Widget _buildEditUserView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Affiliation Alert Banner (Image 2)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDDD6FE)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_balance_outlined,
                  size: 16, color: Color(0xFF7C3AED)),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF581C87),
                    ),
                    children: const [
                      TextSpan(text: "Belongs to "),
                      TextSpan(
                        text: "Anna Institute of Technology",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: " — records cannot be moved between colleges.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildAccountStepCard(),
        const SizedBox(height: 18),
        _buildSecurityStepCard(),
      ],
    );

    final rightSidebarContent = _buildSidebarCard(isEdit: true);

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: leftFormContent),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: rightSidebarContent),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        rightSidebarContent,
        const SizedBox(height: 20),
        leftFormContent,
      ],
    );
  }

  // Step 1: Account Card
  Widget _buildAccountStepCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          // Step Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_outline_rounded,
                    size: 18, color: Color(0xFF4F46E5)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "Step 1 of 2",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row 1: Full name * & Email (sign-in ID) *
          LayoutBuilder(
            builder: (context, c) {
              final isStacked = c.maxWidth < 620;

              final nameField = _buildFormTextField(
                label: "Full name *",
                hint: "e.g. SARAVANAN-PRIN",
                controller: _fullNameController,
              );

              final emailField = _buildFormTextField(
                label: "Email (sign-in ID) *",
                hint: "e.g. principal@aist.edu.in",
                controller: _emailController,
              );

              if (isStacked) {
                return Column(
                  children: [
                    nameField,
                    const SizedBox(height: 16),
                    emailField,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 18),
                  Expanded(child: emailField),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Row 2: Role * & Department
          LayoutBuilder(
            builder: (context, c) {
              final isStacked = c.maxWidth < 620;

              final roleField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormDropdown(
                    label: "Role *",
                    value: _selectedRole,
                    items: _roleOptions,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedRole = val);
                      }
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Only the University Super Admin can grant the Super Admin role.",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              );

              final deptField = _buildFormDropdown(
                label: "Department",
                value: _selectedDepartment,
                items: _deptOptions,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedDepartment = val);
                  }
                },
              );

              if (isStacked) {
                return Column(
                  children: [
                    roleField,
                    const SizedBox(height: 16),
                    deptField,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: roleField),
                  const SizedBox(width: 18),
                  Expanded(child: deptField),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Step 2: Security Card
  Widget _buildSecurityStepCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          // Step Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school_outlined,
                    size: 18, color: Color(0xFFD97706)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "Step 2 of 2",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row 1: Status * & Require MFA Toggle
          LayoutBuilder(
            builder: (context, c) {
              final isStacked = c.maxWidth < 620;

              final statusField = _buildFormDropdown(
                label: "Status *",
                value: _selectedStatus,
                items: _statusOptions,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedStatus = val);
                  }
                },
              );

              final mfaToggle = _buildToggleCard(
                label: "Require multi-factor authentication",
                value: _requireMfa,
                onChanged: (val) => setState(() => _requireMfa = val),
              );

              if (isStacked) {
                return Column(
                  children: [
                    statusField,
                    const SizedBox(height: 16),
                    mfaToggle,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: statusField),
                  const SizedBox(width: 18),
                  Expanded(child: mfaToggle),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Row 2: Allow sign-in through institution SSO only
          _buildToggleCard(
            label: "Allow sign-in through institution SSO only",
            value: _allowSsoOnly,
            onChanged: (val) => setState(() => _allowSsoOnly = val),
          ),
          const SizedBox(height: 18),

          // Row 3: Reason / notes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reason / notes",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _notesController,
                maxLines: 3,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  hintText: "Reason for account change or role grant...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E2865)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Sidebar Summary Card for Add / Edit
  Widget _buildSidebarCard({required bool isEdit}) {
    final title = isEdit ? "Editing user" : "New user";
    final filledCount = _calculateRequiredFieldsFilled();
    final progress = (filledCount / 4.0).clamp(0.0, 1.0);
    final version = _selectedUser?["version"] ?? 146;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Required fields progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Required fields",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                isEdit ? "4/4" : "$filledCount/4",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: isEdit ? 1.0 : progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(
                isEdit || progress == 1.0
                    ? const Color(0xFF0D9488)
                    : const Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Info bullet 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_outlined,
                  size: 15, color: Color(0xFF0D9488)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Validated in the browser and on the server",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Info bullet 2
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.history_rounded,
                  size: 15, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEdit
                      ? "Version $version — conflicting edits are blocked"
                      : "Every change is audit-logged",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveUserChanges,
              icon: Icon(
                isEdit ? Icons.save_outlined : Icons.check_rounded,
                size: 16,
                color: Colors.white,
              ),
              label: Text(
                isEdit ? "Save changes" : "Create user",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isEdit
                    ? const Color(0xFF818CF8) // Soft indigo in Image 2
                    : const Color(0xFF283593), // Deep indigo in Image 1
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Cancel Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                setState(() => _viewMode = UserManagementViewMode.list);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF0D9488),
            activeTrackColor: const Color(0xFFCCFBF1),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: (v) => setState(() {}),
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF94A3B8),
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1E2865)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: items.contains(value) ? value : items.first,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF64748B)),
              items: items.map((it) {
                return DropdownMenuItem<String>(
                  value: it,
                  child: Text(
                    it,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: it.startsWith("Select")
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. VIEW USER DETAILS (Image 3)
  // ===========================================================================
  Widget _buildViewUserDetails(double maxWidth) {
    if (_selectedUser == null) {
      return const SizedBox();
    }
    final user = _selectedUser!;
    final isStacked = maxWidth < 950;

    final leftCards = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAccountDetailsCard(user),
        const SizedBox(height: 18),
        _buildSecurityDetailsCard(user),
      ],
    );

    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildUserIdentityCard(user),
        const SizedBox(height: 16),
        _buildRecordHistoryCard(user),
        const SizedBox(height: 16),
        _buildBackToUserManagementButton(),
      ],
    );

    if (isStacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          leftCards,
          const SizedBox(height: 20),
          rightColumn,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: leftCards),
        const SizedBox(width: 20),
        SizedBox(width: 290, child: rightColumn),
      ],
    );
  }

  Widget _buildAccountDetailsCard(Map<String, dynamic> user) {
    final name = user["name"] as String? ?? "—";
    final email = user["email"] as String? ?? "—";
    final role = user["role"] as String? ?? "Principal / Institution Admin";
    final dept = (user["dept"] as String? ?? "- None -").replaceAll("- None -", "—");

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Text(
            "Account",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 500;

              final col1 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailField("FULL NAME", name),
                  const SizedBox(height: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ROLE",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.account_balance_outlined,
                                size: 12, color: Color(0xFFDC2626)),
                            const SizedBox(width: 5),
                            Text(
                              role,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFDC2626),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );

              final col2 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailField("EMAIL (SIGN-IN ID)", email),
                  const SizedBox(height: 22),
                  _buildDetailField("DEPARTMENT", dept.isNotEmpty ? dept : "—"),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    col1,
                    const SizedBox(height: 22),
                    col2,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: col1),
                  const SizedBox(width: 24),
                  Expanded(child: col2),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityDetailsCard(Map<String, dynamic> user) {
    final status = user["status"] as String? ?? "Active";
    final mfa = user["requireMfa"] as bool? ?? true;
    final sso = user["allowSsoOnly"] as bool? ?? false;
    final notes = (user["notes"] as String? ?? "").trim();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Text(
            "Security",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 500;

              final col1 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "STATUS",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: status == "Active"
                              ? const Color(0xFFCCFBF1)
                              : status == "Suspended"
                                  ? const Color(0xFFFEE2E2)
                                  : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: status == "Active"
                                ? const Color(0xFF0D9488)
                                : status == "Suspended"
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _buildDetailField(
                    "ALLOW SIGN-IN THROUGH INSTITUTION SSO ONLY",
                    sso ? "Yes" : "No",
                  ),
                  const SizedBox(height: 22),
                  _buildDetailField(
                    "REASON / NOTES",
                    notes.isNotEmpty ? notes : "—",
                  ),
                ],
              );

              final col2 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REQUIRE MULTI-FACTOR AUTHENTICATION",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          mfa ? "Yes" : "No",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    col1,
                    const SizedBox(height: 22),
                    col2,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: col1),
                  const SizedBox(width: 24),
                  Expanded(child: col2),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: const Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildUserIdentityCard(Map<String, dynamic> user) {
    final name = user["name"] as String? ?? "User";
    final id = user["id"] as String? ?? "";
    final status = user["status"] as String? ?? "Active";

    // Extract initials (e.g. Dr. Lakshmi Sundaram -> LS)
    final parts = name.split(" ").where((p) => !p.endsWith(".")).toList();
    String initials = "";
    if (parts.length >= 2) {
      initials = "${parts[0][0]}${parts[1][0]}".toUpperCase();
    } else if (parts.isNotEmpty) {
      initials = parts[0].substring(0, (parts[0].length >= 2 ? 2 : 1)).toUpperCase();
    } else {
      initials = "US";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2865),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            id,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFBF1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D9488),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFDDD6FE)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_balance_outlined,
                  size: 12,
                  color: Color(0xFF7C3AED),
                ),
                const SizedBox(width: 5),
                Text(
                  "Anna Institute of Technology",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF7C3AED),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordHistoryCard(Map<String, dynamic> user) {
    final created = user["created"] as String? ?? "29 Sept 2026";
    final updated = user["updated"] as String? ?? "24 Nov 2026";
    final version = user["version"] ?? 146;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Text(
            "Record history",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildHistoryRow(
            icon: Icons.calendar_today_outlined,
            label: "Created",
            value: created,
          ),
          const SizedBox(height: 12),
          _buildHistoryRow(
            icon: Icons.history_rounded,
            label: "Last updated",
            value: updated,
          ),
          const SizedBox(height: 12),
          _buildHistoryRow(
            icon: Icons.layers_outlined,
            label: "Version",
            value: "$version",
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5EE),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: const Color(0xFF78716C)),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildBackToUserManagementButton() {
    return InkWell(
      onTap: () => setState(() => _viewMode = UserManagementViewMode.list),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, size: 14, color: Color(0xFF334155)),
            const SizedBox(width: 8),
            Text(
              "Back to User Management",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 7. DELETE CONFIRMATION MODAL (Image 4)
  // ===========================================================================
  void _showDeleteUserModal(Map<String, dynamic> user) {
    final confirmController = TextEditingController();
    final targetId = user["id"] as String;
    final userName = user["name"] as String;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isConfirmed = confirmController.text.trim() == targetId;

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: 440,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trash Icon in light red circle
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 22,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      "Delete user?",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: "$userName ",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "($targetId)",
                            style: const TextStyle(color: Color(0xFF64748B)),
                          ),
                          const TextSpan(text: " will be permanently removed."),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Warning Alert Box (Image 4)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Text(
                        "The user loses access immediately and all active sessions are revoked. This cannot be undone.",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF92400E),
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Type prompt
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                        children: [
                          const TextSpan(text: "Type "),
                          TextSpan(
                            text: targetId,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(text: " to confirm"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    TextField(
                      controller: confirmController,
                      onChanged: (v) => setDialogState(() {}),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 11),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFF1E2865)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Buttons: Cancel & Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFEAB308)), // Amber accent border
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: isConfirmed
                              ? () {
                                  setState(() {
                                    _userList.removeWhere(
                                        (u) => u["id"] == targetId);
                                    if (_viewMode ==
                                        UserManagementViewMode.viewUser) {
                                      _viewMode = UserManagementViewMode.list;
                                      _selectedUser = null;
                                    }
                                  });
                                  Navigator.of(ctx).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("User '$userName' was deleted"),
                                      backgroundColor: const Color(0xFFEF4444),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.delete_outline_rounded,
                              size: 15, color: Colors.white),
                          label: Text(
                            "Delete",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE06D6D), // Salmon coral in Image 4
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
