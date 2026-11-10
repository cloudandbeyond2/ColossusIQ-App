import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

class DepartmentLabItem {
  final String title;
  final String department;
  final String description;
  final String courseCode;
  final Color deptColor;
  final Color deptBgColor;

  const DepartmentLabItem({
    required this.title,
    required this.department,
    required this.description,
    required this.courseCode,
    required this.deptColor,
    required this.deptBgColor,
  });
}

/// Department Portal Screen [P2] (Matching Images 1 & 2)
class DepartmentPortalScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const DepartmentPortalScreen({super.key, this.onBack});

  @override
  State<DepartmentPortalScreen> createState() => _DepartmentPortalScreenState();
}

class _DepartmentPortalScreenState extends State<DepartmentPortalScreen> {
  String _selectedDept = "All";
  final TextEditingController _searchController = TextEditingController();

  // The complete list of 21 department labs matching Images 1 & 2
  static const List<DepartmentLabItem> _allLabs = [
    // CSE Labs (11)
    DepartmentLabItem(
      title: "Advanced Java Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CS301",
      courseCode: "CS301",
      deptColor: Color(0xFF4338CA),
      deptBgColor: Color(0xFFEEF2FF),
    ),
    DepartmentLabItem(
      title: "Cloud Computing & Virtualization Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CS3492",
      courseCode: "CS3492",
      deptColor: Color(0xFF0F766E),
      deptBgColor: Color(0xFFF0FDFA),
    ),
    DepartmentLabItem(
      title: "Data base System Applications Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE105",
      courseCode: "CSE105",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),
    DepartmentLabItem(
      title: "Database Management Systems Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE101",
      courseCode: "CSE101",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),
    DepartmentLabItem(
      title: "DBMS Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE104",
      courseCode: "CSE104",
      deptColor: Color(0xFFBE123C),
      deptBgColor: Color(0xFFFFF1F2),
    ),
    DepartmentLabItem(
      title: "Emerging Technologies Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE107",
      courseCode: "CSE107",
      deptColor: Color(0xFF4338CA),
      deptBgColor: Color(0xFFEEF2FF),
    ),
    DepartmentLabItem(
      title: "Object-Oriented Programming with Java Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CS201",
      courseCode: "CS201",
      deptColor: Color(0xFF0F766E),
      deptBgColor: Color(0xFFF0FDFA),
    ),
    DepartmentLabItem(
      title: "Operating Systems Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE102",
      courseCode: "CSE102",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),
    DepartmentLabItem(
      title: "python Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CS2354",
      courseCode: "CS2354",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),
    DepartmentLabItem(
      title: "Web Technologies Practical Lab",
      department: "Computer Science & Engineering",
      description: "Interactive practical problems, lab assignments and exercises for CSE106",
      courseCode: "CSE106",
      deptColor: Color(0xFF4338CA),
      deptBgColor: Color(0xFFEEF2FF),
    ),
    DepartmentLabItem(
      title: "Cloud Computing & Systems Lab",
      department: "Computer Science & Engineering",
      description: "Docker containers, Linux virtual machines and distributed systems practice",
      courseCode: "CSE209",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),

    // AI & DS Labs (3)
    DepartmentLabItem(
      title: "AI Ethics, Bias, and Governance Practical Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Interactive practical problems, lab assignments and exercises for AID102",
      courseCode: "AID102",
      deptColor: Color(0xFF2563EB),
      deptBgColor: Color(0xFFEFF6FF),
    ),
    DepartmentLabItem(
      title: "Machine Learning Practical Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Interactive practical problems, lab assignments and exercises for AID101",
      courseCode: "AID101",
      deptColor: Color(0xFF2563EB),
      deptBgColor: Color(0xFFEFF6FF),
    ),
    DepartmentLabItem(
      title: "AI & Neural Networks Lab",
      department: "Artificial Intelligence & Data Science",
      description: "Jupyter notebooks, GPU clusters and deep learning model benchmarking",
      courseCode: "AID201",
      deptColor: Color(0xFF2563EB),
      deptBgColor: Color(0xFFEFF6FF),
    ),

    // ECE Labs (2)
    DepartmentLabItem(
      title: "Signals and Systems Practical Lab",
      department: "Electronics & Communication",
      description: "Interactive practical problems, lab assignments and exercises for EC101",
      courseCode: "EC101",
      deptColor: Color(0xFFBE123C),
      deptBgColor: Color(0xFFFFF1F2),
    ),
    DepartmentLabItem(
      title: "Embedded Systems & IoT Lab",
      department: "Electronics & Communication",
      description: "Microcontroller emulators, sensor interface kits and signal analysis",
      courseCode: "EC205",
      deptColor: Color(0xFFBE123C),
      deptBgColor: Color(0xFFFFF1F2),
    ),

    // Civil (1)
    DepartmentLabItem(
      title: "Structural GIS & Materials Lab",
      department: "Civil Engineering",
      description: "Building information modelling (BIM), seismic analysis and GIS mapping",
      courseCode: "CE201",
      deptColor: Color(0xFF0F766E),
      deptBgColor: Color(0xFFF0FDFA),
    ),

    // EEE (1)
    DepartmentLabItem(
      title: "Power Systems & Renewable Energy Lab",
      department: "Electrical & Electronics",
      description: "Smart grid simulations, MATLAB/Simulink models and machine testing",
      courseCode: "EE203",
      deptColor: Color(0xFFB45309),
      deptBgColor: Color(0xFFFFFBEB),
    ),

    // IT (1)
    DepartmentLabItem(
      title: "Cybersecurity & Web Services Lab",
      department: "Information Technology",
      description: "Penetration testing environments, API fuzzing and web application security",
      courseCode: "IT204",
      deptColor: Color(0xFF4338CA),
      deptBgColor: Color(0xFFEEF2FF),
    ),

    // Mech (1)
    DepartmentLabItem(
      title: "Advanced CAD/CAM & Robotics Lab",
      department: "Mechanical Engineering",
      description: "Finite element analysis, 3D modelling and automated robotics simulations",
      courseCode: "ME202",
      deptColor: Color(0xFF2563EB),
      deptBgColor: Color(0xFFEFF6FF),
    ),

    // S&H (1)
    DepartmentLabItem(
      title: "Computational Mathematics & Physics Lab",
      department: "Science & Humanities",
      description: "Numerical simulations, statistical modeling and research experiments",
      courseCode: "SH101",
      deptColor: Color(0xFF0F766E),
      deptBgColor: Color(0xFFF0FDFA),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _countForDept(String dept) {
    if (dept == "All") return _allLabs.length;
    return _allLabs.where((l) => l.department == dept).length;
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredLabs = _allLabs.where((lab) {
      final matchesDept = _selectedDept == "All" || lab.department == _selectedDept;
      final matchesSearch = query.isEmpty ||
          lab.title.toLowerCase().contains(query) ||
          lab.description.toLowerCase().contains(query) ||
          lab.courseCode.toLowerCase().contains(query);
      return matchesDept && matchesSearch;
    }).toList();

    return PortalPageBody(
      title: "Department Portal",
      category: "Department",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Hero Glow Blueprint Banner matching Image 1
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Department  ›  Department Portal",
          category: "DEPARTMENT",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.layers_outlined,
          watermarkIcon: Icons.layers_outlined,
          title: "Department Portal",
          subtitle: "Department-specific labs and modules — coding lab, CAD, circuits, GIS, case studies.",
        ),
        const SizedBox(height: 18),

        // 2. Department Filters & Search Row Container (Matching Image 1)
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 950;

              final filterPills = SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_alt_outlined, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      "Department:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildDeptPill("All", "All", _countForDept("All")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Computer Science & Engineering", "Computer Science & Engineering", _countForDept("Computer Science & Engineering")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Artificial Intelligence & Data Science", "Artificial Intelligence & Data Science", _countForDept("Artificial Intelligence & Data Science")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Electronics & Communication", "Electronics & Communication", _countForDept("Electronics & Communication")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Civil Engineering", "Civil Engineering", _countForDept("Civil Engineering")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Electrical & Electronics", "Electrical & Electronics", _countForDept("Electrical & Electronics")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Information Technology", "Information Technology", _countForDept("Information Technology")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Mechanical Engineering", "Mechanical Engineering", _countForDept("Mechanical Engineering")),
                    const SizedBox(width: 6),
                    _buildDeptPill("Science & Humanities", "Science & Humanities", _countForDept("Science & Humanities")),
                  ],
                ),
              );

              final searchField = Container(
                width: isWide ? 260 : double.infinity,
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: "Search labs & practicals...",
                          hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () => setState(() => _searchController.clear()),
                        child: const Icon(Icons.close, size: 14, color: Color(0xFF94A3B8)),
                      ),
                  ],
                ),
              );

              if (isWide) {
                return Row(
                  children: [
                    Expanded(child: filterPills),
                    const SizedBox(width: 14),
                    searchField,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  filterPills,
                  const SizedBox(height: 12),
                  searchField,
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 18),

        // 3. Grid of Lab Cards (Images 1 & 2)
        if (filteredLabs.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.science_outlined, size: 36, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 8),
                  Text(
                    "No practical labs found",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Try selecting 'All' or searching for another keyword.",
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final colCount = w >= 980 ? 3 : (w >= 640 ? 2 : 1);

              if (colCount == 1) {
                return Column(
                  children: filteredLabs
                      .map((lab) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _buildLabCard(lab),
                          ))
                      .toList(),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredLabs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colCount,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: colCount == 3 ? 1.75 : 1.65,
                ),
                itemBuilder: (context, index) => _buildLabCard(filteredLabs[index]),
              );
            },
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDeptPill(String deptId, String label, int count) {
    final isSelected = _selectedDept == deptId;
    return InkWell(
      onTap: () => setState(() => _selectedDept = deptId),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$count",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabCard(DepartmentLabItem lab) {
    return InkWell(
      onTap: () => _showLabDetailModal(lab),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Dept Tag + Active Badge (Matching Images 1 & 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: lab.deptBgColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          lab.department,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: lab.deptColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Active",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF059669),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Lab Title
                Text(
                  lab.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  lab.description,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLabDetailModal(DepartmentLabItem lab) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: lab.deptBgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        lab.department,
                        style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: lab.deptColor),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  lab.title,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  lab.description,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B), height: 1.4),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      _infoRow("Course Code", lab.courseCode),
                      const SizedBox(height: 8),
                      _infoRow("Lab Status", "Active (Lab Terminal Online)"),
                      const SizedBox(height: 8),
                      _infoRow("Practical Modules", "12 Exercises & Viva Question Bank"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Close", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Launching ${lab.title} terminal..."),
                            backgroundColor: const Color(0xFF1E1B4B),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1B4B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Text("Launch Practical Lab", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
        Text(val, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
      ],
    );
  }
}
