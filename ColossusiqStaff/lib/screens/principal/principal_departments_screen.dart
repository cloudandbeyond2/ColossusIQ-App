import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DepartmentViewMode {
  list,
  addDepartment,
  editDepartment,
  viewDepartment,
}

class PrincipalDepartmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalDepartmentsScreen({super.key, this.onBack});

  @override
  State<PrincipalDepartmentsScreen> createState() =>
      _PrincipalDepartmentsScreenState();
}

class _PrincipalDepartmentsScreenState
    extends State<PrincipalDepartmentsScreen> {
  DepartmentViewMode _viewMode = DepartmentViewMode.list;
  int _activeTabIndex = 0; // 0: Overview, 1: Leadership, 2: Programmes, 3: Analytics

  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  // Selected Department for View/Edit
  Map<String, dynamic>? _selectedDept;

  // Form Controllers for Add / Edit
  final TextEditingController _deptNameController = TextEditingController();
  final TextEditingController _hodNameController = TextEditingController();
  final TextEditingController _yearEstController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedStream = "Engineering";
  String _selectedStatus = "Active";

  final List<String> _deptDropdownOptions = [
    "Select..",
    "Computer Science & Engineering",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Electronics & Communication",
    "Electrical & Electronics",
    "Mechanical Engineering",
    "Civil Engineering",
    "Science & Humanities",
  ];

  final List<String> _statusOptions = [
    "Active",
    "Inactive",
  ];

  late List<Map<String, dynamic>> _departments;

  @override
  void initState() {
    super.initState();
    _departments = [
      {
        "id": "DEP-1003",
        "name": "Computer Science & Engineering",
        "hod": "Dr. S. Venkatesh",
        "yearEst": "2001",
        "status": "Active",
        "email": "cse@ait.edu.in",
        "phone": "9876543210",
        "location": "Main Academic Wing",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "Tier 1 Certified (NBA / NAAC)",
        "students": 6,
        "faculty": 3,
        "programmes": 1,
        "readiness": 77,
        "ratio": "2:1",
        "updated": "5 Oct 2026",
        "created": "29 Sept 2026",
        "version": "v2",
        "notes": "Integration",
      },
      {
        "id": "DEP-1002",
        "name": "Information Technology",
        "hod": "Dr. Vignesh Rao",
        "yearEst": "2004",
        "status": "Active",
        "email": "it@ait.edu.in",
        "phone": "9876543211",
        "location": "IT Block - Level 3",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NBA Accredited",
        "students": 442,
        "faculty": 18,
        "programmes": 2,
        "readiness": 82,
        "ratio": "24:1",
        "updated": "21 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1004",
        "name": "Artificial Intelligence & Data Science",
        "hod": "Dr. Aishwarya Raman",
        "yearEst": "2021",
        "status": "Active",
        "email": "aids@ait.edu.in",
        "phone": "9876543212",
        "location": "Innovation Hub - Level 2",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NAAC A+ Certified",
        "students": 253,
        "faculty": 12,
        "programmes": 2,
        "readiness": 83,
        "ratio": "21:1",
        "updated": "22 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1005",
        "name": "Electronics & Communication",
        "hod": "Dr. Arjun Natarajan",
        "yearEst": "2001",
        "status": "Active",
        "email": "ece@ait.edu.in",
        "phone": "9876543213",
        "location": "ECE Block - Level 1",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NBA Tier 1",
        "students": 335,
        "faculty": 16,
        "programmes": 3,
        "readiness": 80,
        "ratio": "21:1",
        "updated": "23 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1006",
        "name": "Electrical & Electronics",
        "hod": "Dr. Meera Joseph",
        "yearEst": "2002",
        "status": "Active",
        "email": "eee@ait.edu.in",
        "phone": "9876543214",
        "location": "Power Systems Wing",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NBA Certified",
        "students": 465,
        "faculty": 20,
        "programmes": 1,
        "readiness": 80,
        "ratio": "23:1",
        "updated": "24 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1007",
        "name": "Mechanical Engineering",
        "hod": "Dr. Harish Kumar",
        "yearEst": "2001",
        "status": "Active",
        "email": "mech@ait.edu.in",
        "phone": "9876543215",
        "location": "Mechanical Workshops",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NBA Tier 1",
        "students": 360,
        "faculty": 19,
        "programmes": 1,
        "readiness": 75,
        "ratio": "19:1",
        "updated": "25 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1008",
        "name": "Civil Engineering",
        "hod": "Dr. Kavya Menon",
        "yearEst": "2003",
        "status": "Active",
        "email": "civil@ait.edu.in",
        "phone": "9876543216",
        "location": "Civil Structures Wing",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Engineering",
        "accreditation": "NBA Accredited",
        "students": 346,
        "faculty": 17,
        "programmes": 2,
        "readiness": 81,
        "ratio": "20:1",
        "updated": "26 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
      {
        "id": "DEP-1009",
        "name": "Science & Humanities",
        "hod": "Dr. Nikhil Khan",
        "yearEst": "2001",
        "status": "Active",
        "email": "sh@ait.edu.in",
        "phone": "9876543217",
        "location": "Basic Sciences Block",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": "Sciences",
        "accreditation": "NAAC A+",
        "students": 527,
        "faculty": 25,
        "programmes": 3,
        "readiness": 87,
        "ratio": "21:1",
        "updated": "27 Sept 2026",
        "created": "29 Sept 2026",
        "version": "v1",
        "notes": "",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _deptNameController.dispose();
    _hodNameController.dispose();
    _yearEstController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _initFormForAdd() {
    _deptNameController.clear();
    _hodNameController.clear();
    _yearEstController.clear();
    _emailController.clear();
    _phoneController.clear();
    _notesController.clear();
    _selectedStream = "Engineering";
    _selectedStatus = "Active";
  }

  void _initFormForEdit(Map<String, dynamic> dept) {
    _selectedDept = dept;
    _deptNameController.text = dept["name"] as String? ?? "";
    _hodNameController.text = dept["hod"] as String? ?? "";
    _yearEstController.text = dept["yearEst"] as String? ?? "2001";
    _emailController.text = dept["email"] as String? ?? "";
    _phoneController.text = dept["phone"] as String? ?? "";
    _notesController.text = dept["notes"] as String? ?? "";
    _selectedStream = dept["stream"] as String? ?? "Engineering";
    _selectedStatus = dept["status"] as String? ?? "Active";
  }

  int _calculateRequiredFieldsFilled() {
    int count = 0;
    if (_deptNameController.text.trim().isNotEmpty &&
        _deptNameController.text != "Select..") {
      count++;
    }
    if (_hodNameController.text.trim().isNotEmpty) count++;
    if (_yearEstController.text.trim().isNotEmpty) count++;
    if (_selectedStatus.isNotEmpty) count++;
    if (_emailController.text.trim().isNotEmpty) count++;
    if (_phoneController.text.trim().isNotEmpty) count++;
    return count;
  }

  void _saveDepartmentChanges() {
    final name = _deptNameController.text.trim();
    final hod = _hodNameController.text.trim();
    final year = _yearEstController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || name == "Select..") {
      _showWarningSnackBar("Please select or enter department name");
      return;
    }
    if (hod.isEmpty) {
      _showWarningSnackBar("Please enter Head of department");
      return;
    }

    if (_viewMode == DepartmentViewMode.editDepartment && _selectedDept != null) {
      setState(() {
        _selectedDept!["name"] = name;
        _selectedDept!["hod"] = hod;
        _selectedDept!["yearEst"] = year.isNotEmpty ? year : "2001";
        _selectedDept!["email"] = email;
        _selectedDept!["phone"] = phone;
        _selectedDept!["status"] = _selectedStatus;
        _selectedDept!["notes"] = _notesController.text.trim();
        _selectedDept!["updated"] = "24 Nov 2026";
        _viewMode = DepartmentViewMode.viewDepartment;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Department '$name' updated successfully"),
          backgroundColor: const Color(0xFF0D9488),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (_viewMode == DepartmentViewMode.addDepartment) {
      final newId = "DEP-${1000 + _departments.length + 1}";
      final newDept = {
        "id": newId,
        "name": name,
        "hod": hod,
        "yearEst": year.isNotEmpty ? year : "2026",
        "status": _selectedStatus,
        "email": email.isNotEmpty ? email : "dept@ait.edu.in",
        "phone": phone.isNotEmpty ? phone : "9876543200",
        "location": "Academic Complex",
        "hours": "Mon - Fri: 08:30 - 17:00 IST",
        "stream": _selectedStream,
        "accreditation": "Institutional Regulated",
        "students": 0,
        "faculty": 1,
        "programmes": 1,
        "readiness": 75,
        "ratio": "0:1",
        "updated": "24 Nov 2026",
        "created": "24 Nov 2026",
        "version": "v1",
        "notes": _notesController.text.trim(),
      };
      setState(() {
        _departments.insert(0, newDept);
        _selectedDept = newDept;
        _activeTabIndex = 0;
        _viewMode = DepartmentViewMode.viewDepartment;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Department '$name' ($newId) created successfully"),
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
                // 1. TOP BLUEPRINT HERO BANNER (Only on List & Add/Edit screens)
                if (_viewMode != DepartmentViewMode.viewDepartment) ...[
                  _buildHeroBanner(constraints.maxWidth),
                  const SizedBox(height: 18),
                ],

                // 2. VIEW CONTENT
                if (_viewMode == DepartmentViewMode.addDepartment)
                  _buildAddDepartmentView(constraints.maxWidth)
                else if (_viewMode == DepartmentViewMode.editDepartment &&
                    _selectedDept != null)
                  _buildEditDepartmentView(constraints.maxWidth)
                else if (_viewMode == DepartmentViewMode.viewDepartment &&
                    _selectedDept != null)
                  _buildViewDepartmentDetails(constraints.maxWidth)
                else ...[
                  // Filter Pills Bar
                  _buildFilterPills(),
                  const SizedBox(height: 16),

                  // Table Card (Search, Table)
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
  // 1. TOP BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner(double maxWidth) {
    final isCompact = maxWidth < 700;

    String title;
    String subtitle;
    List<Widget> crumbs;

    if (_viewMode == DepartmentViewMode.addDepartment) {
      title = "Add department";
      subtitle = "Fill in the details below. Fields marked * are required.";
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = DepartmentViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Institution", onTap: () => setState(() => _viewMode = DepartmentViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Add department"),
        _buildBreadcrumbSeparator(),
        Text(
          "New department",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else if (_viewMode == DepartmentViewMode.editDepartment &&
        _selectedDept != null) {
      final deptId = _selectedDept!["id"] as String;
      title = "Edit department · $deptId";
      subtitle =
          "Update the details below. Changes are validated, versioned and recorded in the audit log.";
      crumbs = [
        _buildBreadcrumbText("Home",
            onTap: () => setState(() => _viewMode = DepartmentViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Institution",
            onTap: () => setState(() => _viewMode = DepartmentViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Edit department · $deptId"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText(deptId),
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
    } else {
      title = "Departments";
      subtitle =
          "Departments of the college, their heads and contacts, with live student, faculty and placement figures.";
      crumbs = [
        _buildBreadcrumbText("Home"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Institution"),
        _buildBreadcrumbSeparator(),
        Text(
          "Departments",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ];
    }

    return Container(
      width: double.infinity,
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
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.domain_outlined,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null &&
                            _viewMode == DepartmentViewMode.list) ...[
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
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: const Center(
            child: Icon(
              Icons.domain_rounded,
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
                      "INSTITUTION",
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
                  fontSize: 23,
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
    if (_viewMode == DepartmentViewMode.addDepartment ||
        _viewMode == DepartmentViewMode.editDepartment) {
      return OutlinedButton.icon(
        onPressed: () =>
            setState(() => _viewMode = DepartmentViewMode.list),
        icon:
            const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
        label: Text(
          "Back to departments",
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
        setState(() => _viewMode = DepartmentViewMode.addDepartment);
      },
      icon: const Icon(Icons.add_rounded, size: 18, color: Color(0xFF0F172A)),
      label: Text(
        "Add department",
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
      {"label": "All", "count": _departments.length},
      {
        "label": "Active",
        "count": _departments.where((d) => d["status"] == "Active").length
      },
      {
        "label": "Inactive",
        "count": _departments.where((d) => d["status"] == "Inactive").length
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
  // 3. TABLE CARD (Search, Departments Table)
  // ===========================================================================
  Widget _buildTableCard() {
    final depts = _filteredDepts;

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
          // Search row
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 320,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Search by name, ID or HOD...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  prefixIcon: const Icon(Icons.search_rounded,
                      size: 18, color: Color(0xFF94A3B8)),
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
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: const Color(0xFFF1F5F9),
              ),
              child: DataTable(
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingRowHeight: 46,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 68,
                horizontalMargin: 20,
                columnSpacing: 26,
                columns: [
                  _buildDataColumn("DEPARTMENT"),
                  _buildDataColumn("HOD"),
                  _buildDataColumn("STATUS"),
                  _buildDataColumn("PROGRAMMES"),
                  _buildDataColumn("STUDENTS"),
                  _buildDataColumn("FACULTY"),
                  _buildDataColumn("READINESS"),
                  _buildDataColumn("UPDATED"),
                  _buildDataColumn("ACTIONS"),
                ],
                rows: depts.map((d) {
                  final readiness = (d["readiness"] as num?)?.toInt() ?? 75;

                  return DataRow(
                    cells: [
                      // Department Name & ID
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDept = d;
                              _activeTabIndex = 0;
                              _viewMode = DepartmentViewMode.viewDepartment;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                d["name"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                d["id"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // HOD
                      DataCell(
                        Text(
                          d["hod"] as String,
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
                            color: const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            d["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0D9488),
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
                              width: 65,
                              height: 6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: readiness / 100.0,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
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
                                setState(() {
                                  _selectedDept = d;
                                  _activeTabIndex = 0;
                                  _viewMode =
                                      DepartmentViewMode.viewDepartment;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 17, color: Color(0xFF2563EB)),
                              tooltip: "View Department",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _initFormForEdit(d);
                                setState(() => _viewMode =
                                    DepartmentViewMode.editDepartment);
                              },
                              icon: const Icon(Icons.edit_outlined,
                                  size: 17, color: Color(0xFFD97706)),
                              tooltip: "Edit Department",
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () => _confirmDeleteDept(d),
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 17, color: Color(0xFFEF4444)),
                              tooltip: "Delete Department",
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

  // ===========================================================================
  // 4. ADD DEPARTMENT VIEW (Image 1)
  // ===========================================================================
  Widget _buildAddDepartmentView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDeptStepCard(),
        const SizedBox(height: 18),
        _buildContactStepCard(),
      ],
    );

    final rightSidebarContent = _buildSidebarSummaryCard(isEdit: false);

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
  // 5. EDIT DEPARTMENT VIEW
  // ===========================================================================
  Widget _buildEditDepartmentView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Affiliation banner
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
        _buildDeptStepCard(),
        const SizedBox(height: 18),
        _buildContactStepCard(),
      ],
    );

    final rightSidebarContent = _buildSidebarSummaryCard(isEdit: true);

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

  // Step 1 Card: Department
  Widget _buildDeptStepCard() {
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
          // Header
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
                    "Department",
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

          // Department * dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Department *",
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
                    value: _deptDropdownOptions.contains(_deptNameController.text)
                        ? _deptNameController.text
                        : "Select..",
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 18, color: Color(0xFF64748B)),
                    items: _deptDropdownOptions.map((opt) {
                      return DropdownMenuItem<String>(
                        value: opt,
                        child: Text(
                          opt,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: opt.startsWith("Select")
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _deptNameController.text = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Departments of your college's academic stream.",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Row: HOD * & Year established *
          LayoutBuilder(
            builder: (context, c) {
              final isStacked = c.maxWidth < 620;

              final hodField = _buildFormTextField(
                label: "Head of department *",
                hint: "e.g. Dr. S. Venkatesh",
                controller: _hodNameController,
              );

              final yearField = _buildFormTextField(
                label: "Year established *",
                hint: "e.g. 1995",
                controller: _yearEstController,
              );

              if (isStacked) {
                return Column(
                  children: [
                    hodField,
                    const SizedBox(height: 16),
                    yearField,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: hodField),
                  const SizedBox(width: 18),
                  Expanded(child: yearField),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Status *
          _buildFormDropdown(
            label: "Status *",
            value: _selectedStatus,
            items: _statusOptions,
            onChanged: (val) {
              if (val != null) setState(() => _selectedStatus = val);
            },
          ),
        ],
      ),
    );
  }

  // Step 2 Card: Contact
  Widget _buildContactStepCard() {
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
          // Header
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
                    "Contact",
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

          // Row: Department email * & Office phone *
          LayoutBuilder(
            builder: (context, c) {
              final isStacked = c.maxWidth < 620;

              final emailField = _buildFormTextField(
                label: "Department email *",
                hint: "e.g. hod.cse@college.edu",
                controller: _emailController,
              );

              final phoneField = _buildFormTextField(
                label: "Office phone *",
                hint: "e.g. 9876543210",
                controller: _phoneController,
              );

              if (isStacked) {
                return Column(
                  children: [
                    emailField,
                    const SizedBox(height: 16),
                    phoneField,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: emailField),
                  const SizedBox(width: 18),
                  Expanded(child: phoneField),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Notes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
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
                  hintText:
                      "Specialisations, research focus, labs or accreditations...",
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
  Widget _buildSidebarSummaryCard({required bool isEdit}) {
    final title = isEdit ? "Editing department" : "New department";
    final filledCount = _calculateRequiredFieldsFilled();
    final progress = (filledCount / 6.0).clamp(0.0, 1.0);
    final version = _selectedDept?["version"] ?? "v2";

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
                isEdit ? "6/6" : "$filledCount/6",
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
              onPressed: _saveDepartmentChanges,
              icon: Icon(
                isEdit ? Icons.save_outlined : Icons.check_rounded,
                size: 16,
                color: Colors.white,
              ),
              label: Text(
                isEdit ? "Save changes" : "Create department",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isEdit
                    ? const Color(0xFF818CF8) // Soft indigo in edit
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
                setState(() => _viewMode = DepartmentViewMode.list);
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
                      color: const Color(0xFF0F172A),
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
  // 6. VIEW DEPARTMENT DETAILS (Images 2, 3, 4, 5)
  // ===========================================================================
  Widget _buildViewDepartmentDetails(double maxWidth) {
    if (_selectedDept == null) return const SizedBox();
    final dept = _selectedDept!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top breadcrumb row with "All Departments" link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => setState(() => _viewMode = DepartmentViewMode.list),
                    child: Text(
                      "Institution",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.chevron_right_rounded,
                        size: 14, color: Color(0xFF94A3B8)),
                  ),
                  InkWell(
                    onTap: () => setState(() => _viewMode = DepartmentViewMode.list),
                    child: Text(
                      "Departments",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.chevron_right_rounded,
                        size: 14, color: Color(0xFF94A3B8)),
                  ),
                  Text(
                    dept["name"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => setState(() => _viewMode = DepartmentViewMode.list),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 14, color: Color(0xFF334155)),
                  const SizedBox(width: 4),
                  Text(
                    "All Departments",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Department Header Card (White Card with Avatar, Badges, Title, Action Buttons)
        _buildDepartmentHeaderCard(dept),
        const SizedBox(height: 18),

        // 4 KPI Summary Cards Row
        _buildDepartmentKpiRow(dept),
        const SizedBox(height: 20),

        // 4 Navigation Tabs
        _buildDepartmentTabsBar(),
        const SizedBox(height: 20),

        // Tab Content with Right Sidebar
        LayoutBuilder(
          builder: (context, c) {
            final isStacked = c.maxWidth < 980;

            final leftContent = _buildActiveTabContent(dept);
            final rightSidebar = _buildDepartmentRightSidebar(dept);

            if (isStacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  leftContent,
                  const SizedBox(height: 20),
                  rightSidebar,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftContent),
                const SizedBox(width: 20),
                SizedBox(width: 290, child: rightSidebar),
              ],
            );
          },
        ),
      ],
    );
  }

  // Header Card matching Image 2
  Widget _buildDepartmentHeaderCard(Map<String, dynamic> dept) {
    return Container(
      width: double.infinity,
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
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 750;

          final avatarAndTitle = Row(
            children: [
              // Avatar with building icon and active green dot
              Stack(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(Icons.apartment_rounded,
                          size: 30, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badges row: Active, DEP-1003 Copy, Est. 2001
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0D9488),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Active",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0D9488),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${dept["id"]} Copy",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF5EE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Est. ${dept["yearEst"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF78716C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      dept["name"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle metadata
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        Text(
                          "🏛 Anna Institute of Technology",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          "⚙ ${dept["stream"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          "👤 Head: ${dept["hod"]}",
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
            ],
          );

          final actionButtons = Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Edit Department (amber)
              ElevatedButton.icon(
                onPressed: () {
                  _initFormForEdit(dept);
                  setState(() =>
                      _viewMode = DepartmentViewMode.editDepartment);
                },
                icon: const Icon(Icons.edit_outlined,
                    size: 14, color: Color(0xFF0F172A)),
                label: Text(
                  "Edit Department",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEAB308),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Deactivate
              OutlinedButton.icon(
                onPressed: () => _toggleDeactivateDept(dept),
                icon: const Icon(Icons.block_rounded,
                    size: 14, color: Color(0xFF334155)),
                label: Text(
                  "Deactivate",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // Trash Icon
              IconButton(
                onPressed: () => _confirmDeleteDept(dept),
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: Color(0xFFEF4444)),
                tooltip: "Delete Department",
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatarAndTitle,
                const SizedBox(height: 14),
                actionButtons,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: avatarAndTitle),
              const SizedBox(width: 14),
              actionButtons,
            ],
          );
        },
      ),
    );
  }

  // 4 KPI Cards Row (Enrolled Students, Faculty & Staff, Programmes, Placement Readiness)
  Widget _buildDepartmentKpiRow(Map<String, dynamic> dept) {
    return LayoutBuilder(
      builder: (context, c) {
        final cardWidth = c.maxWidth >= 900
            ? (c.maxWidth - 36) / 4
            : c.maxWidth >= 550
                ? (c.maxWidth - 12) / 2
                : c.maxWidth;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildKpiCard(
              width: cardWidth,
              label: "ENROLLED STUDENTS",
              icon: Icons.people_outline_rounded,
              iconColor: const Color(0xFF0D9488),
              iconBg: const Color(0xFFCCFBF1),
              value: "${dept["students"]}",
              valueSuffix: "Active",
              subtitle: "Full-time students enrolled",
              progress: 0.8,
              progressColor: const Color(0xFF0D9488),
            ),
            _buildKpiCard(
              width: cardWidth,
              label: "FACULTY & STAFF",
              icon: Icons.badge_outlined,
              iconColor: const Color(0xFF7C3AED),
              iconBg: const Color(0xFFEDE9FE),
              value: "${dept["faculty"]}",
              valueSuffix: "Teaching",
              subtitle: "${dept["ratio"]} Student-Faculty Ratio",
              progress: 0.6,
              progressColor: const Color(0xFF7C3AED),
            ),
            _buildKpiCard(
              width: cardWidth,
              label: "PROGRAMMES",
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xFF2563EB),
              iconBg: const Color(0xFFDBEAFE),
              value: "${dept["programmes"]}",
              valueSuffix: "Degrees",
              subtitle: "UG, PG & Doctoral degrees",
              progress: 0.5,
              progressColor: const Color(0xFF2563EB),
            ),
            _buildKpiCard(
              width: cardWidth,
              label: "PLACEMENT READINESS",
              icon: Icons.track_changes_rounded,
              iconColor: const Color(0xFFD97706),
              iconBg: const Color(0xFFFEF3C7),
              value: "${dept["readiness"]}%",
              pillBadge: "Top Tier",
              subtitle: "Average student capability index",
              progress: (dept["readiness"] as num) / 100.0,
              progressColor: const Color(0xFF0D9488),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required double width,
    required String label,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    String? valueSuffix,
    String? pillBadge,
    required String subtitle,
    required double progress,
    required Color progressColor,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (valueSuffix != null) ...[
                const SizedBox(width: 6),
                Text(
                  valueSuffix,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0D9488),
                  ),
                ),
              ],
              if (pillBadge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    pillBadge,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D9488),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }

  // 4 Navigation Tabs Bar
  Widget _buildDepartmentTabsBar() {
    final tabs = [
      {"icon": Icons.grid_view_rounded, "label": "Department Overview"},
      {"icon": Icons.people_outline_rounded, "label": "Leadership & Faculty"},
      {"icon": Icons.school_outlined, "label": "Programmes & Curricula"},
      {"icon": Icons.bar_chart_rounded, "label": "Performance & Analytics"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (idx) {
          final isSelected = _activeTabIndex == idx;
          final item = tabs[idx];

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => setState(() => _activeTabIndex = idx),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      item["icon"] as IconData,
                      size: 15,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF334155),
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

  // Active Tab View Content
  Widget _buildActiveTabContent(Map<String, dynamic> dept) {
    switch (_activeTabIndex) {
      case 0:
        return _buildOverviewTabContent(dept);
      case 1:
        return _buildLeadershipFacultyTabContent(dept);
      case 2:
        return _buildProgrammesCurriculaTabContent(dept);
      case 3:
      default:
        return _buildPerformanceAnalyticsTabContent(dept);
    }
  }

  // TAB 0: Department Overview (Images 2 & 3)
  Widget _buildOverviewTabContent(Map<String, dynamic> dept) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section 1: Department Mission & Notes
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined,
                      size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                  Text(
                    "Department Mission & Notes",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Integration / Mission text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (dept["notes"] as String).isNotEmpty
                      ? dept["notes"] as String
                      : "Integration of modern computational systems, machine intelligence and scalable architectures with high academic rigour.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2x2 Grid of details
              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 560;

                  final card1 = _buildOverviewInfoCard(
                    icon: Icons.feed_outlined,
                    iconBg: const Color(0xFFEEF2FF),
                    iconColor: const Color(0xFF4F46E5),
                    title: "Academic Stream",
                    value: dept["stream"] as String,
                    subtitle: "Regulated university curriculum",
                  );

                  final card2 = _buildOverviewInfoCard(
                    icon: Icons.verified_user_outlined,
                    iconBg: const Color(0xFFCCFBF1),
                    iconColor: const Color(0xFF0D9488),
                    title: "Accreditation",
                    value: dept["accreditation"] as String,
                    subtitle: "Full quality compliance",
                  );

                  final card3 = _buildOverviewInfoCard(
                    icon: Icons.calendar_today_outlined,
                    iconBg: const Color(0xFFFAF5EE),
                    iconColor: const Color(0xFFD97706),
                    title: "Year Established",
                    value: "Year ${dept["yearEst"]}",
                    subtitle: "Over 25 years of excellence",
                  );

                  final card4 = _buildOverviewInfoCard(
                    icon: Icons.account_balance_outlined,
                    iconBg: const Color(0xFFEDE9FE),
                    iconColor: const Color(0xFF7C3AED),
                    title: "Affiliated Institution",
                    value: "Anna Institute of Technology",
                    subtitle: "ColossusIQ Central Network",
                  );

                  if (isNarrow) {
                    return Column(
                      children: [
                        card1,
                        const SizedBox(height: 10),
                        card2,
                        const SizedBox(height: 10),
                        card3,
                        const SizedBox(height: 10),
                        card4,
                      ],
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: card1),
                          const SizedBox(width: 12),
                          Expanded(child: card2),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: card3),
                          const SizedBox(width: 12),
                          Expanded(child: card4),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Section 2: Department Communications & Desk
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded,
                      size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                  Text(
                    "Department Communications & Desk",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Official contact channels for students, faculty, and administrative staff",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 620;

                  final card1 = _buildCommCard(
                    icon: Icons.mail_outline_rounded,
                    iconBg: const Color(0xFFCCFBF1),
                    iconColor: const Color(0xFF0D9488),
                    label: "OFFICIAL EMAIL",
                    value: dept["email"] as String,
                    actionText: "Send Email",
                    actionIcon: Icons.send_rounded,
                  );

                  final card2 = _buildCommCard(
                    icon: Icons.phone_outlined,
                    iconBg: const Color(0xFFEDE9FE),
                    iconColor: const Color(0xFF7C3AED),
                    label: "OFFICE HOTLINE / PHONE",
                    value: dept["phone"] as String,
                    actionText: "Call Office",
                  );

                  final card3 = _buildCommCard(
                    icon: Icons.location_on_outlined,
                    iconBg: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    label: "LOCATION & HOURS",
                    value: dept["location"] as String,
                    extraText: dept["hours"] as String,
                    actionText: "Active Administrative Hours",
                    actionIcon: Icons.access_time_rounded,
                  );

                  if (isNarrow) {
                    return Column(
                      children: [
                        card1,
                        const SizedBox(height: 10),
                        card2,
                        const SizedBox(height: 10),
                        card3,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: card1),
                      const SizedBox(width: 12),
                      Expanded(child: card2),
                      const SizedBox(width: 12),
                      Expanded(child: card3),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Section 3: Specialised Department Laboratories
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.science_outlined,
                      size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                  Text(
                    "Specialised Department Laboratories",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Dedicated research and computational infrastructure",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 560;

                  final lab1 = _buildLabCard(
                    icon: Icons.computer_rounded,
                    iconBg: const Color(0xFFEEF2FF),
                    iconColor: const Color(0xFF4F46E5),
                    name: "Advanced Computing & AI Lab",
                    details: "60 High-end Workstations · GPU Clusters",
                  );

                  final lab2 = _buildLabCard(
                    icon: Icons.dns_rounded,
                    iconBg: const Color(0xFFCCFBF1),
                    iconColor: const Color(0xFF0D9488),
                    name: "Systems & Cloud Lab",
                    details: "Dedicated Server Racks · Cisco Network Pods",
                  );

                  final lab3 = _buildLabCard(
                    icon: Icons.lightbulb_outline_rounded,
                    iconBg: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    name: "Innovation & Capstone Studio",
                    details: "Collaborative space for final year teams",
                  );

                  final lab4 = _buildLabCard(
                    icon: Icons.auto_stories_outlined,
                    iconBg: const Color(0xFFEDE9FE),
                    iconColor: const Color(0xFF7C3AED),
                    name: "Department Digital Library",
                    details: "IEEE Xplore, ACM & Springer journal access",
                  );

                  if (isNarrow) {
                    return Column(
                      children: [
                        lab1,
                        const SizedBox(height: 10),
                        lab2,
                        const SizedBox(height: 10),
                        lab3,
                        const SizedBox(height: 10),
                        lab4,
                      ],
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: lab1),
                          const SizedBox(width: 12),
                          Expanded(child: lab2),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: lab3),
                          const SizedBox(width: 12),
                          Expanded(child: lab4),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewInfoCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
    String? extraText,
    required String actionText,
    IconData? actionIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          if (extraText != null) ...[
            Text(
              extraText,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              if (actionIcon != null) ...[
                Icon(actionIcon, size: 12, color: const Color(0xFF4F46E5)),
                const SizedBox(width: 4),
              ],
              Text(
                actionText,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String name,
    required String details,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  details,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 1: Leadership & Faculty (Image 4)
  Widget _buildLeadershipFacultyTabContent(Map<String, dynamic> dept) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // HOD Profile Card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with initials SV
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        "SV",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Department Head",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4F46E5),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCCFBF1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.check_circle_rounded,
                                      size: 11, color: Color(0xFF0D9488)),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Verified Administrator",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0D9488),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          dept["hod"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "Head of Department & Professor of ${dept["name"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          children: [
                            Text(
                              "✉ ${dept["email"]}",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF4F46E5),
                              ),
                            ),
                            Text(
                              "📞 ${dept["phone"]}",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),
              Text(
                "Overseeing all academic curriculums, faculty allocations, examination standards, and industry placement partnerships for the ${dept["name"]} division.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF475569),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Department Governance & Coordinators
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.groups_outlined,
                      size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                  Text(
                    "Department Governance & Coordinators",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Key administrative faculty roles assigned for academic excellence",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 620;

                  final coord1 = _buildCoordCard(
                    icon: Icons.school_outlined,
                    iconBg: const Color(0xFFCCFBF1),
                    iconColor: const Color(0xFF0D9488),
                    title: "Academic Coordinator",
                    sub1: "Curriculum & Syllabi",
                    sub2: "Semester Timetables & Exams",
                  );

                  final coord2 = _buildCoordCard(
                    icon: Icons.track_changes_rounded,
                    iconBg: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    title: "Placement Liaison",
                    sub1: "Campus Recruitment",
                    sub2: "Training & Mock Drives",
                  );

                  final coord3 = _buildCoordCard(
                    icon: Icons.science_outlined,
                    iconBg: const Color(0xFFEDE9FE),
                    iconColor: const Color(0xFF7C3AED),
                    title: "Research & Lab Head",
                    sub1: "Innovation & Patents",
                    sub2: "Industry Funded Projects",
                  );

                  if (isNarrow) {
                    return Column(
                      children: [
                        coord1,
                        const SizedBox(height: 10),
                        coord2,
                        const SizedBox(height: 10),
                        coord3,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: coord1),
                      const SizedBox(width: 12),
                      Expanded(child: coord2),
                      const SizedBox(width: 12),
                      Expanded(child: coord3),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),

              // Bottom link banner to open staff directory
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore all teaching faculty associated with this department.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Opening Faculty Directory..."),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "→ Open Staff Directory",
                        style: GoogleFonts.poppins(
                            fontSize: 11.5, fontWeight: FontWeight.w600),
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

  Widget _buildCoordCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String sub1,
    required String sub2,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub1,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          Text(
            sub2,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
    );
  }

  // TAB 2: Programmes & Curricula (Image 5)
  Widget _buildProgrammesCurriculaTabContent(Map<String, dynamic> dept) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_book_rounded,
                      size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 8),
                  Text(
                    "Academic Degrees & Tracks",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Approved degree programmes managed under ${dept["name"]}",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),

              // Degree 1: UG (B.Tech / B.E.)
              _buildDegreeProgramCard(
                tag: "UG",
                tagColor: const Color(0xFF2563EB),
                tagBg: const Color(0xFFDBEAFE),
                title: "Bachelor of Technology (B.Tech / B.E.)",
                duration: "4 Years · 8 Semesters · 160 Total Credits",
                badges: ["Core Degree", "AICTE Approved", "120 Seats / Year"],
                statusText: "✔ Admissions Open",
                statusColor: const Color(0xFF0D9488),
              ),
              const SizedBox(height: 12),

              // Degree 2: PG (M.Tech / M.E.)
              _buildDegreeProgramCard(
                tag: "PG",
                tagColor: const Color(0xFF7C3AED),
                tagBg: const Color(0xFFEDE9FE),
                title: "Master of Technology (M.Tech / M.E.)",
                duration:
                    "2 Years · 4 Semesters · Advanced Specialisation & Thesis",
                badges: ["Postgraduate", "GATE Qualified", "24 Seats"],
                statusText: "✔ Active Cohort",
                statusColor: const Color(0xFF0D9488),
              ),
              const SizedBox(height: 12),

              // Degree 3: PhD
              _buildDegreeProgramCard(
                tag: "PhD",
                tagColor: const Color(0xFFD97706),
                tagBg: const Color(0xFFFEF3C7),
                title: "Doctoral Research Scholar Program",
                duration: "Full-time & Part-time Research Fellowships",
                badges: ["Research", "University Affiliated"],
                statusText: "Rolling Admissions",
                statusColor: const Color(0xFF64748B),
              ),
              const SizedBox(height: 18),

              // Bottom Course Catalog Banner
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Looking for active course syllabi? Browse all subject modules, credits, and semester plans.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Opening Courses Catalog..."),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "View Courses Catalog",
                        style: GoogleFonts.poppins(
                            fontSize: 11.5, fontWeight: FontWeight.w600),
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

  Widget _buildDegreeProgramCard({
    required String tag,
    required Color tagColor,
    required Color tagBg,
    required String title,
    required String duration,
    required List<String> badges,
    required String statusText,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tagBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                tag,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: tagColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Text(
                      statusText,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: badges.map((b) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        b,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 3: Performance & Analytics (Image 1)
  Widget _buildPerformanceAnalyticsTabContent(Map<String, dynamic> dept) {
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
          Row(
            children: [
              const Icon(Icons.show_chart_rounded,
                  size: 18, color: Color(0xFF0F172A)),
              const SizedBox(width: 8),
              Text(
                "Placement & Competency Breakdown",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            "Aggregated evaluation of student cohorts in technical benchmarks and training",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Top Placement Readiness Score Box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Row(
              children: [
                // 77% circular gauge
                SizedBox(
                  width: 78,
                  height: 78,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(
                        width: 78,
                        height: 78,
                        child: CircularProgressIndicator(
                          value: 0.77,
                          strokeWidth: 8,
                          strokeCap: StrokeCap.round,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
                          backgroundColor: Color(0xFFE2E8F0),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "77%",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                              height: 1.1,
                            ),
                          ),
                          Text(
                            "OVERALL",
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCFBF1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Placement Ready Cohort",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0D9488),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Department Placement Readiness Score",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Evaluated across active coding tests, automated viva assessments, subject quiz results, and verified industry certificates.",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // 4 Competency Bars
          _buildCompetencyProgressBar(
            prefix: "<>",
            title: "Core Technical & Coding Assessments",
            percentage: 84,
            barColor: const Color(0xFF0D9488),
          ),
          const SizedBox(height: 14),
          _buildCompetencyProgressBar(
            icon: Icons.badge_outlined,
            title: "Verified Skill Certifications",
            percentage: 78,
            barColor: const Color(0xFF1E2865),
          ),
          const SizedBox(height: 14),
          _buildCompetencyProgressBar(
            icon: Icons.search_rounded,
            title: "Mock Technical & HR Interviews",
            percentage: 72,
            barColor: const Color(0xFFC2410C),
          ),
          const SizedBox(height: 14),
          _buildCompetencyProgressBar(
            icon: Icons.verified_user_outlined,
            title: "Practical Lab & Project Submissions",
            percentage: 88,
            barColor: const Color(0xFF0D9488),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetencyProgressBar({
    String? prefix,
    IconData? icon,
    required String title,
    required int percentage,
    required Color barColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (prefix != null) ...[
                  Text(
                    prefix,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 6),
                ] else if (icon != null) ...[
                  Icon(icon, size: 14, color: const Color(0xFF64748B)),
                  const SizedBox(width: 6),
                ],
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            Text(
              "$percentage%",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100.0,
            minHeight: 6,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }

  // Shared Right Sidebar across all 4 tabs
  Widget _buildDepartmentRightSidebar(Map<String, dynamic> dept) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Card 1: Identity Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
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
                child: const Center(
                  child: Icon(Icons.apartment_rounded,
                      size: 26, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                dept["name"] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                dept["id"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      dept["status"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D9488),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF5EE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Est. ${dept["yearEst"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: const Color(0xFF78716C),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),

              _buildSidebarKeyValue("Department Head:", dept["hod"] as String),
              const SizedBox(height: 8),
              _buildSidebarKeyValue(
                  "Institution:", "Anna Institute of Tech..."),
              const SizedBox(height: 8),
              _buildSidebarKeyValue("Stream:", dept["stream"] as String),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 2: DEPARTMENT SHORTCUTS
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DEPARTMENT SHORTCUTS",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 12),
              _buildShortcutItem(
                  icon: Icons.book_outlined,
                  title: "Browse Courses",
                  onTap: () {}),
              const SizedBox(height: 8),
              _buildShortcutItem(
                  icon: Icons.badge_outlined,
                  title: "View Faculty Directory",
                  onTap: () {}),
              const SizedBox(height: 8),
              _buildShortcutItem(
                  icon: Icons.track_changes_rounded,
                  title: "Placement Readiness",
                  onTap: () {}),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 3: RECORD DETAILS
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RECORD DETAILS",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 14),
              _buildRecordDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: "Created",
                  val: dept["created"] as String? ?? "29 Sept 2026"),
              const SizedBox(height: 10),
              _buildRecordDetailRow(
                  icon: Icons.update_rounded,
                  label: "Updated",
                  val: dept["updated"] as String? ?? "5 Oct 2026"),
              const SizedBox(height: 10),
              _buildRecordDetailRow(
                  icon: Icons.layers_outlined,
                  label: "Version",
                  val: dept["version"] as String? ?? "v2"),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Button: Back to Departments
        InkWell(
          onTap: () => setState(() => _viewMode = DepartmentViewMode.list),
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
                const Icon(Icons.arrow_back,
                    size: 14, color: Color(0xFF334155)),
                const SizedBox(width: 8),
                Text(
                  "Back to Departments",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarKeyValue(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
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

  Widget _buildShortcutItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF334155),
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 14, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordDetailRow({
    required IconData icon,
    required String label,
    required String val,
  }) {
    return Row(
      children: [
        Icon(icon, size: 13, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  void _toggleDeactivateDept(Map<String, dynamic> dept) {
    setState(() {
      final current = dept["status"] as String;
      dept["status"] = current == "Active" ? "Inactive" : "Active";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Department '${dept["name"]}' status updated to ${dept["status"]}"),
        backgroundColor: const Color(0xFF0D9488),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Delete Department Confirmation Dialog (Image 4)
  void _confirmDeleteDept(Map<String, dynamic> dept) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: Colors.white,
        child: Container(
          width: 440,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Red icon circle
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFDC2626),
                  size: 22,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Delete department?",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${dept["name"]} (${dept["id"]}) will be permanently removed.",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 16),
              // Peach warning box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  "Removing a department does not delete its staff or students. Set it to Inactive to keep it on record.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFFEAB308), width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
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
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _departments.removeWhere((d) => d["id"] == dept["id"]);
                        if (_viewMode == DepartmentViewMode.viewDepartment) {
                          _viewMode = DepartmentViewMode.list;
                          _selectedDept = null;
                        }
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Department '${dept["name"]}' deleted"),
                          backgroundColor: const Color(0xFFEF4444),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: Colors.white),
                    label: Text(
                      "Delete",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB91C1C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
