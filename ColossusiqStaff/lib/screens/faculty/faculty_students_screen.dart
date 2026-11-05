import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: STUDENTS SCREEN
// Exactly matches Screenshot 3:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Top Action & Filter Bar (Search students, All dropdown, Export excel, Import students, + Add Student)
// - Big card with "No students registered yet" empty state and dual action buttons
// - Footer showing "Showing 0 of 0 students" and "Institutional Student Directory"
// =============================================================================

class FacultyStudentsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyStudentsScreen({super.key, this.onBack});

  @override
  State<FacultyStudentsScreen> createState() => _FacultyStudentsScreenState();
}

class _FacultyStudentsScreenState extends State<FacultyStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> _students = [
    {
      "name": "Anand Kumar",
      "roll": "2024CSE104",
      "dept": "Computer Science",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "92%",
      "cgpa": "8.72",
      "email": "anand.k@college.edu",
      "phone": "+91 98401 23456",
      "mentor": "Dr. Meena Raghavan",
    },
    {
      "name": "Bhavana Reddy",
      "roll": "2024CSE112",
      "dept": "Computer Science",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "88%",
      "cgpa": "9.15",
      "email": "bhavana.r@college.edu",
      "phone": "+91 98401 23457",
      "mentor": "Dr. Meena Raghavan",
    },
    {
      "name": "Chandran S",
      "roll": "2024CSE125",
      "dept": "Computer Science",
      "section": "CSE-B",
      "sem": "5",
      "attendance": "82%",
      "cgpa": "7.94",
      "email": "chandran.s@college.edu",
      "phone": "+91 98401 23458",
      "mentor": "Prof. R. Balaji",
    },
    {
      "name": "Deepa M",
      "roll": "2024AIDS041",
      "dept": "AI & Data Science",
      "section": "AI&DS",
      "sem": "5",
      "attendance": "95%",
      "cgpa": "9.41",
      "email": "deepa.m@college.edu",
      "phone": "+91 98401 23459",
      "mentor": "Dr. V. Srinivasan",
    },
    {
      "name": "Gokul V",
      "roll": "2024ECE063",
      "dept": "Electronics & Comm",
      "section": "ECE-B",
      "sem": "5",
      "attendance": "76%",
      "cgpa": "7.45",
      "email": "gokul.v@college.edu",
      "phone": "+91 98401 23460",
      "mentor": "Dr. S. Priya",
    },
  ];

  void _loadDemoStudents() {
    setState(() {
      _students.addAll([
        {
          "name": "Harini Subramanian",
          "roll": "2024CSE138",
          "dept": "Computer Science",
          "section": "CSE-A",
          "sem": "5",
          "attendance": "91%",
          "cgpa": "8.85",
          "email": "harini.s@college.edu",
          "phone": "+91 98401 23461",
          "mentor": "Dr. Meena Raghavan",
        },
      ]);
    });
  }

  void _showAddStudentDialog() {
    final nameCtrl = TextEditingController();
    final rollCtrl = TextEditingController();
    final deptCtrl = TextEditingController(text: "Computer Science");
    final sectionCtrl = TextEditingController(text: "CSE-A");
    final semCtrl = TextEditingController(text: "5");
    final cgpaCtrl = TextEditingController(text: "8.50");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Add New Student Record",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 440,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: "Student Full Name",
                      hintText: "e.g. Anand Kumar",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: rollCtrl,
                    decoration: const InputDecoration(
                      labelText: "Register / Roll Number",
                      hintText: "e.g. 2026CSE104",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: deptCtrl,
                          decoration: const InputDecoration(labelText: "Department"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: sectionCtrl,
                          decoration: const InputDecoration(labelText: "Section (CSE-A)"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: semCtrl,
                          decoration: const InputDecoration(labelText: "Semester"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: cgpaCtrl,
                          decoration: const InputDecoration(labelText: "CGPA"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.poppins()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.trim().isEmpty || rollCtrl.text.trim().isEmpty) return;
                final newStudent = {
                  "name": nameCtrl.text.trim(),
                  "roll": rollCtrl.text.trim().toUpperCase(),
                  "dept": deptCtrl.text.trim(),
                  "section": sectionCtrl.text.trim().toUpperCase(),
                  "sem": semCtrl.text.trim(),
                  "attendance": "90%",
                  "cgpa": cgpaCtrl.text.trim(),
                  "email": "${rollCtrl.text.trim().toLowerCase()}@college.edu",
                  "phone": "+91 98401 00000",
                  "mentor": "Faculty In-Charge",
                };
                setState(() {
                  _students.insert(0, newStudent);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Student '${newStudent["name"]}' registered successfully to directory.",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: Text("Save Student", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  void _showViewStudentDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFEEF2FF),
                child: Text(
                  s["name"][0] as String,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s["name"] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text("${s["roll"]} · ${s["section"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStudentDetailRow("Department", s["dept"] as String),
                _buildStudentDetailRow("Semester", "Semester ${s["sem"]}"),
                _buildStudentDetailRow("Cumulative GPA", "${s["cgpa"]} / 10.0", highlightColor: const Color(0xFF0F766E)),
                _buildStudentDetailRow("Attendance Rate", s["attendance"] as String, highlightColor: const Color(0xFF2563EB)),
                _buildStudentDetailRow("Email", s["email"] as String),
                _buildStudentDetailRow("Phone", s["phone"] as String),
                _buildStudentDetailRow("Faculty Mentor", s["mentor"] as String),
              ],
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _showEditStudentDialog(s);
              },
              icon: const Icon(Icons.edit_outlined, size: 14),
              label: const Text("Edit Record"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStudentDetailRow(String label, String value, {Color? highlightColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(width: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: highlightColor ?? const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditStudentDialog(Map<String, dynamic> s) {
    final nameCtrl = TextEditingController(text: s["name"] as String);
    final rollCtrl = TextEditingController(text: s["roll"] as String);
    final sectionCtrl = TextEditingController(text: s["section"] as String);
    final cgpaCtrl = TextEditingController(text: s["cgpa"] as String);
    final attCtrl = TextEditingController(text: s["attendance"] as String);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Edit Student: ${s["name"]}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Student Name"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: rollCtrl,
                  decoration: const InputDecoration(labelText: "Roll Number"),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: sectionCtrl,
                        decoration: const InputDecoration(labelText: "Section"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: cgpaCtrl,
                        decoration: const InputDecoration(labelText: "CGPA"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: attCtrl,
                        decoration: const InputDecoration(labelText: "Attendance"),
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
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  s["name"] = nameCtrl.text.trim();
                  s["roll"] = rollCtrl.text.trim();
                  s["section"] = sectionCtrl.text.trim();
                  s["cgpa"] = cgpaCtrl.text.trim();
                  s["attendance"] = attCtrl.text.trim();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Updated record for ${s["name"]}"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: const Text("Save Changes"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteStudentDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Remove Student?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to remove '${s["name"]}' (${s["roll"]}) from this directory?",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final removed = Map<String, dynamic>.from(s);
                final index = _students.indexOf(s);
                setState(() {
                  _students.remove(s);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Removed ${removed["name"]} from directory"),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _students.insert(index >= 0 ? index : 0, removed);
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
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 20),
              _buildMainCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 3)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark people outline on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.groups_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Faculty',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Students',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.groups_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'FACULTY',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F766E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Students',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Profiles, performance, skills and support recommendations.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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
  // MAIN CARD (Screenshot 3)
  // ===========================================================================
  Widget _buildMainCard() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter & Action Toolbar
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 750;

                final searchField = Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded,
                          size: 18, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: const Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            hintText: 'Search students..',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12.5, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                final filterAndButtons = Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Filter dropdown
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.filter_list_rounded,
                              size: 16, color: Color(0xFF64748B)),
                          const SizedBox(width: 6),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedFilter,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF334155),
                                fontWeight: FontWeight.w500,
                              ),
                              items: ['All', 'At Risk', 'High Performers']
                                  .map((f) => DropdownMenuItem(
                                      value: f, child: Text(f)))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedFilter = val);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Export excel
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Exporting student directory Excel...",
                                style: GoogleFonts.poppins()),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.file_download_outlined, size: 15),
                      label: Text(
                        "Export excel",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // Import students
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Select CSV/Excel roster to import...",
                                style: GoogleFonts.poppins()),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.file_upload_outlined, size: 15),
                      label: Text(
                        "Import students",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // + Add Student
                    ElevatedButton.icon(
                      onPressed: _showAddStudentDialog,
                      icon: const Icon(Icons.person_add_alt_1_rounded,
                          size: 15),
                      label: Text(
                        "Add Student",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 11),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchField,
                      const SizedBox(height: 10),
                      filterAndButtons,
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(child: searchField),
                      const SizedBox(width: 12),
                      filterAndButtons,
                    ],
                  );
                }
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Student Data Table or Empty State
          () {
            final query = _searchController.text.trim().toLowerCase();
            final filtered = _students.where((s) {
              if (_selectedFilter != "All" && s["section"] != _selectedFilter) {
                return false;
              }
              if (query.isNotEmpty) {
                final name = (s["name"] as String).toLowerCase();
                final roll = (s["roll"] as String).toLowerCase();
                final dept = (s["dept"] as String).toLowerCase();
                if (!name.contains(query) && !roll.contains(query) && !dept.contains(query)) {
                  return false;
                }
              }
              return true;
            }).toList();

            if (filtered.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.groups_outlined,
                          size: 28,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No students found",
                      style: GoogleFonts.poppins(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Use the button below to add students or load the department directory.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _loadDemoStudents,
                          icon: const Icon(Icons.refresh_rounded, size: 15),
                          label: Text(
                            "Load Sample Students",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF334155),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _showAddStudentDialog,
                          icon: const Icon(Icons.person_add_alt_1_rounded, size: 15),
                          label: Text(
                            "Add Student",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2865),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                dataRowMinHeight: 48,
                dataRowMaxHeight: 54,
                horizontalMargin: 16,
                columnSpacing: 22,
                columns: [
                  DataColumn(label: Text("ROLL NO", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("STUDENT NAME", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("SECTION", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("SEM", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("ATTENDANCE", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("CGPA", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("ACTIONS", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                ],
                rows: filtered.map((s) {
                  return DataRow(
                    cells: [
                      DataCell(Text(s["roll"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)))),
                      DataCell(Text(s["name"] as String, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)))),
                      DataCell(Text(s["section"] as String, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)))),
                      DataCell(Text("Sem ${s["sem"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s["attendance"] as String,
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF15803D)),
                          ),
                        ),
                      ),
                      DataCell(Text(s["cgpa"] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0F766E)))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _showViewStudentDialog(s),
                              icon: const Icon(Icons.person_search_rounded, size: 17, color: Color(0xFF64748B)),
                              tooltip: "View Profile",
                              splashRadius: 16,
                            ),
                            IconButton(
                              onPressed: () => _showEditStudentDialog(s),
                              icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4338CA)),
                              tooltip: "Edit Student",
                              splashRadius: 16,
                            ),
                            IconButton(
                              onPressed: () => _showDeleteStudentDialog(s),
                              icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                              tooltip: "Remove Student",
                              splashRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }(),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Footer Row (Screenshot 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing ${_students.length} students",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Institutional Student Directory",
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
}

// Background painter for blueprint grid
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
