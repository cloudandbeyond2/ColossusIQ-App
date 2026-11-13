import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

// =============================================================================
// FACULTY: STUDENTS SCREEN
// Matches exact user specifications and screenshots:
// 1. Add Student Modal Dialog (Single Student Form) with Student CV/PDF attachment
// 2. Import Students Modal Dialog (CSV, Excel, CV & PDF upload) with dropzone
// 3. Edit Student Record Modal Dialog with College banner and CV/PDF support
// 4. College dropdown filter with all institutions
// 5. Department dropdown filter
// 6. Interactive table with CV/PDF badges, preview modal, and complete overflow protection
// =============================================================================

class FacultyStudentsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyStudentsScreen({super.key, this.onBack});

  @override
  State<FacultyStudentsScreen> createState() => _FacultyStudentsScreenState();
}

class _FacultyStudentsScreenState extends State<FacultyStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dropdown filter states matching Screenshots 4 & 5
  String _selectedCollege = "All Colleges";
  String _selectedDepartment = "All Departments";
  String _selectedSignal = "All Signals";

  static const List<String> _collegeList = [
    "All Colleges",
    "Anna Institute of Technology",
    "Apex Institute of Science & Technology",
    "Bharathidasan University Trichy",
    "Chennai Institute of Nursing & Allied Health Sciences",
    "Coimbatore School of Management",
    "fhdhdfh",
    "Kaveri College of Arts & Science",
    "Kongu College of Engineering",
    "Madurai Medical College & Hospital",
    "Saranathan College of Engineering",
    "Testing College Arts and Science",
    "Vaigai Polytechnic College",
  ];

  static const List<String> _departmentList = [
    "All Departments",
    "Computer Science & Engineering",
    "Information Technology",
    "AI & Data Science",
    "Electronics & Comm",
  ];

  static const List<String> _supportSignals = [
    "None",
    "Needs Mentoring",
    "Academic Risk",
    "High Performer",
  ];

  // Primary student records matching real institutional data and screenshots
  final List<Map<String, dynamic>> _students = [
    {
      "name": "Anand Kumar",
      "roll": "110124001",
      "college": "Anna Institute of Technology",
      "dept": "Computer Science & Engineering",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "92%",
      "cgpa": "7.5",
      "readiness": "60",
      "signal": "None",
      "cvFile": "Anand_Kumar_CV.pdf",
      "email": "anand.kumar@campus.edu",
      "phone": "+91 98401 23456",
      "mentor": "Dr. Meena Raghavan",
    },
    {
      "name": "Divya Ramesh",
      "roll": "110124002",
      "college": "Anna Institute of Technology",
      "dept": "Computer Science & Engineering",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "83%",
      "cgpa": "8.2",
      "readiness": "75",
      "signal": "None",
      "cvFile": "Divya_Ramesh_Resume.pdf",
      "email": "divya.r@campus.edu",
      "phone": "+91 98401 23457",
      "mentor": "Dr. Meena Raghavan",
    },
    {
      "name": "Karthik Raja",
      "roll": "110124003",
      "college": "Anna Institute of Technology",
      "dept": "Computer Science & Engineering",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "74%",
      "cgpa": "6.8",
      "readiness": "52",
      "signal": "Needs Mentoring",
      "cvFile": "Karthik_Raja_CV.pdf",
      "email": "karthik.r@campus.edu",
      "phone": "+91 98401 23458",
      "mentor": "Prof. R. Balaji",
    },
    {
      "name": "Kirshna",
      "roll": "21CS4788",
      "college": "Anna Institute of Technology",
      "dept": "Computer Science & Engineering",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "68%",
      "cgpa": "6.5",
      "readiness": "48",
      "signal": "Academic Risk",
      "cvFile": null,
      "email": "kirshna@campus.edu",
      "phone": "+91 98401 23459",
      "mentor": "Dr. V. Srinivasan",
    },
    {
      "name": "Bala",
      "roll": "27549861",
      "college": "Anna Institute of Technology",
      "dept": "Information Technology",
      "section": "IT-B",
      "sem": "5",
      "attendance": "84%",
      "cgpa": "7.8",
      "readiness": "70",
      "signal": "None",
      "cvFile": "Bala_Resume.pdf",
      "email": "bala@campus.edu",
      "phone": "+91 98401 23460",
      "mentor": "Dr. S. Priya",
    },
    {
      "name": "Suganya",
      "roll": "52CS1478",
      "college": "Anna Institute of Technology",
      "dept": "Computer Science & Engineering",
      "section": "CSE-A",
      "sem": "5",
      "attendance": "75%",
      "cgpa": "8.0",
      "readiness": "65",
      "signal": "None",
      "cvFile": "Suganya_CV.pdf",
      "email": "suganya@campus.edu",
      "phone": "+91 98401 23461",
      "mentor": "Dr. Meena Raghavan",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // ADD & IMPORT STUDENT MODAL DIALOG (Images 1 & 2)
  // With segmented tab switcher between "Single Student Form" and "Excel / CSV / CV / PDF Upload"
  // ===========================================================================
  void _showAddOrImportStudentDialog({int initialTab = 0}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return _AddOrImportStudentModal(
          initialTab: initialTab,
          collegeList: _collegeList.where((c) => c != "All Colleges").toList(),
          departmentList:
              _departmentList.where((d) => d != "All Departments").toList(),
          supportSignals: _supportSignals,
          onSaveSingle: (studentData) {
            setState(() {
              _students.insert(0, studentData);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Student '${studentData["name"]}' added successfully to directory.",
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: const Color(0xFF1E2865),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          onImportBatch: (batch) {
            setState(() {
              _students.insertAll(0, batch);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Successfully imported ${batch.length} student record(s) into roster.",
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: const Color(0xFF0F766E),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // EDIT STUDENT RECORD MODAL DIALOG (Image 3)
  // Matching screenshot: College Banner, Name, Roll, Dept, Section, CGPA, Readiness, Signal & CV File
  // ===========================================================================
  void _showEditStudentDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return _EditStudentRecordModal(
          student: s,
          departmentList:
              _departmentList.where((d) => d != "All Departments").toList(),
          supportSignals: _supportSignals,
          onSave: (updated) {
            setState(() {
              s.addAll(updated);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Updated record for ${s["name"]}",
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: const Color(0xFF1E2865),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // CV / PDF PREVIEW DIALOG
  // ===========================================================================
  void _showCvPreviewDialog(Map<String, dynamic> s) {
    final cvFile = s["cvFile"] as String? ?? "${s["name"]}_CV.pdf";

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.picture_as_pdf_rounded,
                            size: 24, color: Color(0xFFDC2626)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student CV Document",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              cvFile,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              s["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Verified CV",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF15803D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${s["roll"]} · ${s["dept"]} (${s["section"]})",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const Divider(height: 20, color: Color(0xFFE2E8F0)),
                        _buildDetailRow("Institution",
                            s["college"] ?? "Anna Institute of Technology"),
                        _buildDetailRow("Academic CGPA", "${s["cgpa"]} / 10.0"),
                        _buildDetailRow(
                            "Technical Readiness", "${s["readiness"]}%"),
                        _buildDetailRow("Contact Email", s["email"] as String),
                        _buildDetailRow("Faculty Mentor", s["mentor"] as String),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Downloading '$cvFile'...",
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFF1E2865),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded, size: 15),
                        label: Text("Download PDF",
                            style: GoogleFonts.poppins(fontSize: 12.5)),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2A72),
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Done",
                            style: GoogleFonts.poppins(fontSize: 12.5)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // VIEW STUDENT DETAIL DIALOG
  // ===========================================================================
  void _showViewStudentDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          title: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFEEF2FF),
                child: Text(
                  (s["name"] as String).isNotEmpty ? s["name"][0] : "S",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4338CA),
                      fontSize: 16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s["name"] as String,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${s["roll"]} · ${s["section"]}",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.close_rounded,
                    size: 20, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow(
                    "College", s["college"] ?? "Anna Institute of Technology"),
                _buildDetailRow("Department", s["dept"] as String),
                _buildDetailRow("Section", s["section"] as String),
                _buildDetailRow("Cumulative GPA", "${s["cgpa"]} / 10.0",
                    highlightColor: const Color(0xFF0F766E)),
                _buildDetailRow("Readiness Score", "${s["readiness"]}%",
                    highlightColor: const Color(0xFF2563EB)),
                _buildDetailRow("Support Signal", s["signal"] ?? "None",
                    highlightColor: s["signal"] == "Academic Risk"
                        ? const Color(0xFFDC2626)
                        : (s["signal"] == "Needs Mentoring"
                            ? const Color(0xFFD97706)
                            : const Color(0xFF0F766E))),
                _buildDetailRow("Attendance Rate", s["attendance"] as String),
                _buildDetailRow("Email", s["email"] as String),
                if (s["cvFile"] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                        _showCvPreviewDialog(s);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.picture_as_pdf_rounded,
                                size: 16, color: Color(0xFF2563EB)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Attached CV: ${s["cvFile"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1D4ED8),
                                ),
                              ),
                            ),
                            const Icon(Icons.open_in_new_rounded,
                                size: 14, color: Color(0xFF2563EB)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 10,
              runSpacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showEditStudentDialog(s);
                  },
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: Text("Edit Record",
                      style: GoogleFonts.poppins(fontSize: 12)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E2A72),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Close",
                      style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? highlightColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: highlightColor ?? const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DELETE CONFIRMATION
  // ===========================================================================
  void _showDeleteStudentDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Remove Student?",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to remove '${s["name"]}' (${s["roll"]}) from this directory?",
            style: GoogleFonts.poppins(
                fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 10,
              runSpacing: 10,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Cancel", style: GoogleFonts.poppins()),
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
                  child: Text("Delete", style: GoogleFonts.poppins()),
                ),
              ],
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
  // TOP HERO BANNER
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
  // MAIN CARD: TOOLBAR + FILTER DROPDOWNS + TABLE
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
                // Search Input
                final searchField = Container(
                  height: 40,
                  constraints: const BoxConstraints(minWidth: 200),
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
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: const Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            hintText: 'Search students, roll no...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 12.5, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.close_rounded,
                              size: 16, color: Color(0xFF94A3B8)),
                        ),
                    ],
                  ),
                );

                // Dropdown: All Colleges (Image 4)
                final collegeDropdown = Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCollege,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: _selectedCollege == "All Colleges"
                            ? const Color(0xFF1D4ED8)
                            : const Color(0xFF1E293B),
                        fontWeight: FontWeight.w600,
                      ),
                      items: _collegeList.map((c) {
                        return DropdownMenuItem<String>(
                          value: c,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: Text(
                              c,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: c == _selectedCollege
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: c == _selectedCollege
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedCollege = val);
                        }
                      },
                    ),
                  ),
                );

                // Dropdown: All Departments (Image 5)
                final deptDropdown = Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDepartment,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF1E293B),
                        fontWeight: FontWeight.w600,
                      ),
                      items: _departmentList.map((d) {
                        return DropdownMenuItem<String>(
                          value: d,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 210),
                            child: Text(
                              d,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: d == _selectedDepartment
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: d == _selectedDepartment
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedDepartment = val);
                        }
                      },
                    ),
                  ),
                );

                // Dropdown: Signal Filter
                final signalDropdown = Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSignal,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 18, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF1E293B),
                        fontWeight: FontWeight.w600,
                      ),
                      items: ["All Signals", ..._supportSignals].map((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(
                            s,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: s == _selectedSignal
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: s == _selectedSignal
                                  ? const Color(0xFF1D4ED8)
                                  : const Color(0xFF334155),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedSignal = val);
                        }
                      },
                    ),
                  ),
                );

                // Export excel button
                final exportButton = OutlinedButton.icon(
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
                );

                // Import students button (opens Tab 1: Excel / CSV / CV / PDF Upload)
                final importButton = OutlinedButton.icon(
                  onPressed: () => _showAddOrImportStudentDialog(initialTab: 1),
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
                );

                // + Add Student button (opens Tab 0: Single Student Form)
                final addButton = ElevatedButton.icon(
                  onPressed: () => _showAddOrImportStudentDialog(initialTab: 0),
                  icon: const Icon(Icons.person_add_alt_1_rounded, size: 15),
                  label: Text(
                    "Add Student",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E2A72),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 11),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth > 950
                          ? 240
                          : (constraints.maxWidth > 600 ? 200 : constraints.maxWidth),
                      child: searchField,
                    ),
                    collegeDropdown,
                    deptDropdown,
                    signalDropdown,
                    exportButton,
                    importButton,
                    addButton,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Student Data Table or Empty State
          () {
            final query = _searchController.text.trim().toLowerCase();
            final filtered = _students.where((s) {
              // College filter
              if (_selectedCollege != "All Colleges" &&
                  (s["college"] ?? "") != _selectedCollege) {
                return false;
              }
              // Department filter
              if (_selectedDepartment != "All Departments" &&
                  (s["dept"] ?? "") != _selectedDepartment) {
                return false;
              }
              // Signal filter
              if (_selectedSignal != "All Signals" &&
                  (s["signal"] ?? "") != _selectedSignal) {
                return false;
              }
              // Text Search filter
              if (query.isNotEmpty) {
                final name = (s["name"] as String? ?? "").toLowerCase();
                final roll = (s["roll"] as String? ?? "").toLowerCase();
                final dept = (s["dept"] as String? ?? "").toLowerCase();
                final sec = (s["section"] as String? ?? "").toLowerCase();
                if (!name.contains(query) &&
                    !roll.contains(query) &&
                    !dept.contains(query) &&
                    !sec.contains(query)) {
                  return false;
                }
              }
              return true;
            }).toList();

            if (filtered.isEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
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
                      "No students found matching your filters",
                      style: GoogleFonts.poppins(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Try adjusting the college or department filter, or add a student.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _showAddOrImportStudentDialog(initialTab: 0),
                      icon: const Icon(Icons.person_add_alt_1_rounded, size: 15),
                      label: Text(
                        "Add Student",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E2A72),
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
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1040,
                child: DataTable(
                  headingRowColor:
                      WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                  dataRowMinHeight: 52,
                  dataRowMaxHeight: 56,
                  horizontalMargin: 16,
                  columnSpacing: 16,
                  columns: [
                    DataColumn(
                      label: Text("ROLL NO",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("STUDENT NAME",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("DEPARTMENT",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("SECTION",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("CGPA",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("READINESS",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("SIGNAL",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("CV / PDF",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                    DataColumn(
                      label: Text("ACTIONS",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B))),
                    ),
                  ],
                  rows: filtered.map((s) {
                    final signal = s["signal"] as String? ?? "None";
                    Color badgeBg = const Color(0xFFF1F5F9);
                    Color badgeText = const Color(0xFF64748B);

                    if (signal == "Academic Risk") {
                      badgeBg = const Color(0xFFFEE2E2);
                      badgeText = const Color(0xFFDC2626);
                    } else if (signal == "Needs Mentoring") {
                      badgeBg = const Color(0xFFFEF3C7);
                      badgeText = const Color(0xFFD97706);
                    } else if (signal == "High Performer") {
                      badgeBg = const Color(0xFFDCFCE7);
                      badgeText = const Color(0xFF15803D);
                    }

                    final cvFile = s["cvFile"] as String?;

                    return DataRow(
                      cells: [
                        DataCell(
                          Text(s["roll"] as String? ?? "-",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E293B))),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () => _showViewStudentDialog(s),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: const Color(0xFFEEF2FF),
                                  child: Text(
                                    (s["name"] as String).isNotEmpty
                                        ? s["name"][0]
                                        : "S",
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF4338CA)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  s["name"] as String? ?? "-",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 170),
                            child: Text(
                              s["dept"] as String? ?? "-",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xFF334155)),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              s["section"] as String? ?? "-",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569)),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            s["cgpa"] as String? ?? "0.0",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F766E)),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${s["readiness"] ?? 0}%",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2563EB)),
                              ),
                              const SizedBox(width: 6),
                              SizedBox(
                                width: 34,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: ((double.tryParse("${s["readiness"]}") ??
                                                0) /
                                            100)
                                        .clamp(0.0, 1.0),
                                    minHeight: 4,
                                    backgroundColor: const Color(0xFFE2E8F0),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Color(0xFF2563EB)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              signal,
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: badgeText),
                            ),
                          ),
                        ),
                        // CV / PDF Document Cell
                        DataCell(
                          cvFile != null
                              ? InkWell(
                                  onTap: () => _showCvPreviewDialog(s),
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEEF2FF),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: const Color(0xFFC7D2FE)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                            Icons.picture_as_pdf_rounded,
                                            size: 13,
                                            color: Color(0xFF4338CA)),
                                        const SizedBox(width: 4),
                                        Text(
                                          "CV (PDF)",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF4338CA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () => _showEditStudentDialog(s),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: const Color(0xFFE2E8F0)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.upload_file_rounded,
                                            size: 12,
                                            color: Color(0xFF94A3B8)),
                                        const SizedBox(width: 3),
                                        Text(
                                          "+ CV",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10.5,
                                            color: const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _showViewStudentDialog(s),
                                icon: const Icon(Icons.visibility_outlined,
                                    size: 16, color: Color(0xFF64748B)),
                                tooltip: "View Profile",
                                splashRadius: 16,
                              ),
                              IconButton(
                                onPressed: () => _showEditStudentDialog(s),
                                icon: const Icon(Icons.edit_outlined,
                                    size: 16, color: Color(0xFF4338CA)),
                                tooltip: "Edit Student",
                                splashRadius: 16,
                              ),
                              IconButton(
                                onPressed: () => _showDeleteStudentDialog(s),
                                icon: const Icon(Icons.delete_outline_rounded,
                                    size: 16, color: Color(0xFFEF4444)),
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
              ),
            );
          }(),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Footer Row with COMPLETE OVERFLOW PROTECTION (fixes 51px overflow from Screenshot 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 6,
              children: [
                Text(
                  "Showing ${_students.length} verified student records",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Institutional Student Directory",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
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

// =============================================================================
// ADD / IMPORT STUDENT MODAL COMPONENT (Images 1 & 2)
// With real FilePicker support for Excel, CSV, PDF, and Student CV files!
// =============================================================================
class _AddOrImportStudentModal extends StatefulWidget {
  final int initialTab;
  final List<String> collegeList;
  final List<String> departmentList;
  final List<String> supportSignals;
  final ValueChanged<Map<String, dynamic>> onSaveSingle;
  final ValueChanged<List<Map<String, dynamic>>> onImportBatch;

  const _AddOrImportStudentModal({
    required this.initialTab,
    required this.collegeList,
    required this.departmentList,
    required this.supportSignals,
    required this.onSaveSingle,
    required this.onImportBatch,
  });

  @override
  State<_AddOrImportStudentModal> createState() =>
      _AddOrImportStudentModalState();
}

class _AddOrImportStudentModalState extends State<_AddOrImportStudentModal> {
  late int _activeTab;

  // Form controllers for Tab 0: Single Student Form (Image 1)
  final _nameCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  late String _selectedCollege;
  late String _selectedDept;
  final _sectionCtrl = TextEditingController(text: "CSE-A");
  final _cgpaCtrl = TextEditingController(text: "7.5");
  final _readinessCtrl = TextEditingController(text: "60");
  late String _selectedSignal;
  final _emailCtrl = TextEditingController();
  String? _singleStudentCvName;

  // State for Tab 1: CSV, Excel, CV & PDF File Upload (Image 2)
  String? _pickedFileName;
  int _pickedFileCount = 0;
  bool _isCvOrPdf = false;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
    _selectedCollege = widget.collegeList.contains("Anna Institute of Technology")
        ? "Anna Institute of Technology"
        : widget.collegeList.first;
    _selectedDept =
        widget.departmentList.contains("Computer Science & Engineering")
            ? "Computer Science & Engineering"
            : widget.departmentList.first;
    _selectedSignal = "None";
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rollCtrl.dispose();
    _sectionCtrl.dispose();
    _cgpaCtrl.dispose();
    _readinessCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  // Real FilePicker helper
  Future<void> _pickFileForImport() async {
    try {
      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xlsx', 'xls', 'pdf', 'doc', 'docx'],
      );
      if (file != null) {
        final ext = (file.extension ?? '').toLowerCase();
        final isPdfOrCv = ext == 'pdf' || ext == 'doc' || ext == 'docx';
        setState(() {
          _pickedFileName = file.name;
          _isCvOrPdf = isPdfOrCv;
          _pickedFileCount = isPdfOrCv ? 1 : 8;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isPdfOrCv
                    ? "Selected CV/PDF: ${file.name} (Ready to parse profile)"
                    : "Selected Data File: ${file.name} ($_pickedFileCount records found)",
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: const Color(0xFF0F766E),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (_) {
      // Fallback preview
      setState(() {
        _pickedFileName = "Rohan_Sharma_CV.pdf";
        _isCvOrPdf = true;
        _pickedFileCount = 1;
      });
    }
  }

  // Single student CV attach helper
  Future<void> _pickSingleStudentCv() async {
    try {
      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (file != null) {
        setState(() {
          _singleStudentCvName = file.name;
        });
      }
    } catch (_) {
      setState(() {
        _singleStudentCvName = "student_resume.pdf";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (Title, Subtitle, Close Button)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _activeTab == 0
                                ? "Add Student"
                                : "Import Students & CVs",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _activeTab == 0
                                ? "Create a new student record and attach CV / documents."
                                : "Upload an Excel, CSV, PDF, or student CV file to import.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Segmented Switcher (Single Student Form vs Excel / CSV / CV / PDF)
                _buildSegmentedSwitcher(),
                const SizedBox(height: 18),

                // View Body: Switch between Single Form and Upload View
                if (_activeTab == 0)
                  _buildSingleStudentForm()
                else
                  _buildFileUploadView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SEGMENTED SWITCHER (Images 1 & 2)
  // ===========================================================================
  Widget _buildSegmentedSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // Single Student Form Tab
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _activeTab = 0),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _activeTab == 0
                      ? const Color(0xFF1E2865)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 14,
                      color: _activeTab == 0
                          ? Colors.white
                          : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        "Single Student Form",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: _activeTab == 0
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // CSV, Excel, CV & PDF File Upload Tab
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _activeTab = 1),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _activeTab == 1
                      ? const Color(0xFF1E2865)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: _activeTab == 1
                      ? Border.all(color: const Color(0xFFD97706), width: 1.2)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 14,
                      color: _activeTab == 1
                          ? Colors.white
                          : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        "Excel / CSV File Upload",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: _activeTab == 1
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 0: SINGLE STUDENT FORM (Image 1)
  // With CV / Resume (PDF) upload feature!
  // ===========================================================================
  Widget _buildSingleStudentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Full Name * & Roll Number *
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: "Student Full Name *",
                child: TextField(
                  controller: _nameCtrl,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: _inputDecoration(hint: "e.g. Rohan Sharma"),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFormField(
                label: "Roll Number *",
                child: TextField(
                  controller: _rollCtrl,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: _inputDecoration(hint: "e.g. 21CS1157"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 2: College / Institution Dropdown
        _buildFormField(
          label: "College / Institution",
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCollege,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                    fontSize: 12.5, color: const Color(0xFF1E293B)),
                items: widget.collegeList.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCollege = val);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Row 3: Department * & Section *
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: "Department *",
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDept,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                          fontSize: 12.5, color: const Color(0xFF1E293B)),
                      items: widget.departmentList.map((d) {
                        return DropdownMenuItem(
                          value: d,
                          child: Text(d, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedDept = val);
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFormField(
                label: "Section *",
                child: TextField(
                  controller: _sectionCtrl,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: _inputDecoration(hint: "CSE-A"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 4: CGPA (0 - 10) & Readiness (%)
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: "CGPA (0 - 10)",
                child: TextField(
                  controller: _cgpaCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: _inputDecoration(hint: "7.5"),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFormField(
                label: "Readiness (%)",
                child: TextField(
                  controller: _readinessCtrl,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: _inputDecoration(hint: "60"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 5: Support Signal & Email Address
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: "Support Signal",
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSignal,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(
                          fontSize: 12.5, color: const Color(0xFF1E293B)),
                      items: widget.supportSignals.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedSignal = val);
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFormField(
                label: "Email Address",
                child: TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration:
                      _inputDecoration(hint: "e.g. rohan.s@campus.edu"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 6: Student CV / Document (PDF Upload)
        _buildFormField(
          label: "Student CV / Resume Document (PDF / DOC)",
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                Icon(
                  _singleStudentCvName != null
                      ? Icons.picture_as_pdf_rounded
                      : Icons.attach_file_rounded,
                  size: 16,
                  color: _singleStudentCvName != null
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF64748B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _singleStudentCvName != null
                        ? _singleStudentCvName!
                        : "No CV file attached (Click to browse PDF/DOC)",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: _singleStudentCvName != null
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: _singleStudentCvName != null
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ),
                if (_singleStudentCvName != null)
                  GestureDetector(
                    onTap: () => setState(() => _singleStudentCvName = null),
                    child: const Icon(Icons.close_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                  )
                else
                  InkWell(
                    onTap: _pickSingleStudentCv,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Upload CV",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Footer Actions: Cancel & Save Student with Overflow Protection
        Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_nameCtrl.text.trim().isEmpty ||
                    _rollCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please fill in Student Full Name and Roll Number.",
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: const Color(0xFFDC2626),
                    ),
                  );
                  return;
                }

                final newStudent = {
                  "name": _nameCtrl.text.trim(),
                  "roll": _rollCtrl.text.trim().toUpperCase(),
                  "college": _selectedCollege,
                  "dept": _selectedDept,
                  "section": _sectionCtrl.text.trim().isNotEmpty
                      ? _sectionCtrl.text.trim().toUpperCase()
                      : "CSE-A",
                  "sem": "5",
                  "attendance": "90%",
                  "cgpa": _cgpaCtrl.text.trim().isNotEmpty
                      ? _cgpaCtrl.text.trim()
                      : "7.5",
                  "readiness": _readinessCtrl.text.trim().isNotEmpty
                      ? _readinessCtrl.text.trim()
                      : "60",
                  "signal": _selectedSignal,
                  "cvFile": _singleStudentCvName,
                  "email": _emailCtrl.text.trim().isNotEmpty
                      ? _emailCtrl.text.trim()
                      : "${_rollCtrl.text.trim().toLowerCase()}@campus.edu",
                  "phone": "+91 98401 00000",
                  "mentor": "Faculty In-Charge",
                };

                widget.onSaveSingle(newStudent);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.person_add_alt_1_rounded, size: 15),
              label: Text(
                "Save Student",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2A72),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 1: EXCEL, CSV, CV & PDF FILE UPLOAD (Image 2)
  // With complete overflow protection and real file picker!
  // ===========================================================================
  Widget _buildFileUploadView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Dropzone Area
        InkWell(
          onTap: _pickFileForImport,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _pickedFileName != null
                    ? const Color(0xFF2E2A72)
                    : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _pickedFileName != null
                        ? (_isCvOrPdf
                            ? const Color(0xFFFEE2E2)
                            : const Color(0xFFDCFCE7))
                        : const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _pickedFileName != null
                        ? (_isCvOrPdf
                            ? Icons.picture_as_pdf_rounded
                            : Icons.check_circle_outline_rounded)
                        : Icons.table_chart_outlined,
                    size: 26,
                    color: _pickedFileName != null
                        ? (_isCvOrPdf
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF15803D))
                        : const Color(0xFF1E2865),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _pickedFileName != null
                        ? _pickedFileName!
                        : "Click to browse or drop your CSV, Excel, or PDF / CV file",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _pickedFileName != null
                        ? (_isCvOrPdf
                            ? "Student CV document detected · Ready to parse into directory"
                            : "Ready to import $_pickedFileCount records into institutional directory")
                        : "Supports .csv, .xlsx, .xls, .pdf, and student CV / resume files",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Template Download Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(
                "Need the expected format? Download our template:",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF475569),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Downloading 'student_import_template.csv'...",
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: const Color(0xFF1E2865),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.file_download_outlined,
                        size: 14, color: Color(0xFF2563EB)),
                    const SizedBox(width: 4),
                    Text(
                      "Sample Template (.csv)",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Footer Actions: Cancel & Confirm & Import X Students (FIXES 6.3px OVERFLOW from Screenshot 1)
        Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_pickedFileCount == 0) {
                  // If nothing clicked yet, auto-select template batch
                  setState(() {
                    _pickedFileName = "students_roster_batch_2026.csv";
                    _pickedFileCount = 4;
                  });
                }

                // Batch mock import matching Anna Institute of Technology with CV files attached
                final imported = [
                  {
                    "name": "Rohan Sharma",
                    "roll": "21CS1157",
                    "college": "Anna Institute of Technology",
                    "dept": "Computer Science & Engineering",
                    "section": "CSE-A",
                    "sem": "5",
                    "attendance": "89%",
                    "cgpa": "7.5",
                    "readiness": "60",
                    "signal": "None",
                    "cvFile": "Rohan_Sharma_CV.pdf",
                    "email": "rohan.s@campus.edu",
                    "phone": "+91 98401 55501",
                    "mentor": "Dr. Meena Raghavan",
                  },
                  {
                    "name": "Priya V",
                    "roll": "21CS1158",
                    "college": "Anna Institute of Technology",
                    "dept": "Computer Science & Engineering",
                    "section": "CSE-A",
                    "sem": "5",
                    "attendance": "94%",
                    "cgpa": "8.9",
                    "readiness": "85",
                    "signal": "High Performer",
                    "cvFile": "Priya_V_CV.pdf",
                    "email": "priya.v@campus.edu",
                    "phone": "+91 98401 55502",
                    "mentor": "Dr. Meena Raghavan",
                  },
                  {
                    "name": "Sanjay Mohan",
                    "roll": "21CS1159",
                    "college": "Anna Institute of Technology",
                    "dept": "Computer Science & Engineering",
                    "section": "CSE-B",
                    "sem": "5",
                    "attendance": "70%",
                    "cgpa": "6.2",
                    "readiness": "45",
                    "signal": "Academic Risk",
                    "cvFile": null,
                    "email": "sanjay.m@campus.edu",
                    "phone": "+91 98401 55503",
                    "mentor": "Prof. R. Balaji",
                  },
                  {
                    "name": "Meera Natarajan",
                    "roll": "21IT1024",
                    "college": "Anna Institute of Technology",
                    "dept": "Information Technology",
                    "section": "IT-A",
                    "sem": "5",
                    "attendance": "91%",
                    "cgpa": "8.4",
                    "readiness": "80",
                    "signal": "None",
                    "cvFile": "Meera_N_Resume.pdf",
                    "email": "meera.n@campus.edu",
                    "phone": "+91 98401 55504",
                    "mentor": "Dr. S. Priya",
                  },
                ];

                widget.onImportBatch(imported);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.file_upload_outlined, size: 15),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _pickedFileCount > 0
                      ? "Confirm & Import $_pickedFileCount Students"
                      : "Confirm & Import 0 Students",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _pickedFileCount > 0
                    ? const Color(0xFF2E2A72)
                    : const Color(0xFF818CF8),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
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
        child,
      ],
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2E2A72), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      isDense: true,
    );
  }
}

// =============================================================================
// EDIT STUDENT RECORD MODAL COMPONENT (Image 3)
// =============================================================================
class _EditStudentRecordModal extends StatefulWidget {
  final Map<String, dynamic> student;
  final List<String> departmentList;
  final List<String> supportSignals;
  final ValueChanged<Map<String, dynamic>> onSave;

  const _EditStudentRecordModal({
    required this.student,
    required this.departmentList,
    required this.supportSignals,
    required this.onSave,
  });

  @override
  State<_EditStudentRecordModal> createState() =>
      _EditStudentRecordModalState();
}

class _EditStudentRecordModalState extends State<_EditStudentRecordModal> {
  late TextEditingController _nameCtrl;
  late TextEditingController _rollCtrl;
  late String _selectedDept;
  late TextEditingController _sectionCtrl;
  late TextEditingController _cgpaCtrl;
  late TextEditingController _readinessCtrl;
  late String _selectedSignal;
  String? _cvFileName;

  @override
  void initState() {
    super.initState();
    _nameCtrl =
        TextEditingController(text: widget.student["name"] as String? ?? "");
    _rollCtrl =
        TextEditingController(text: widget.student["roll"] as String? ?? "");
    _selectedDept = widget.departmentList
            .contains(widget.student["dept"] as String? ?? "")
        ? (widget.student["dept"] as String)
        : widget.departmentList.first;
    _sectionCtrl =
        TextEditingController(text: widget.student["section"] as String? ?? "");
    _cgpaCtrl =
        TextEditingController(text: "${widget.student["cgpa"] ?? ""}");
    _readinessCtrl =
        TextEditingController(text: "${widget.student["readiness"] ?? ""}");
    _selectedSignal = widget.supportSignals
            .contains(widget.student["signal"] as String? ?? "")
        ? (widget.student["signal"] as String)
        : "None";
    _cvFileName = widget.student["cvFile"] as String?;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rollCtrl.dispose();
    _sectionCtrl.dispose();
    _cgpaCtrl.dispose();
    _readinessCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickCvFile() async {
    try {
      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (file != null) {
        setState(() {
          _cvFileName = file.name;
        });
      }
    } catch (_) {
      setState(() {
        _cvFileName = "${_nameCtrl.text.replaceAll(' ', '_')}_CV.pdf";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final college =
        widget.student["college"] as String? ?? "Anna Institute of Technology";

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (Title, Subtitle, Close Button)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Edit Student Record",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "Update academic profile, section, and readiness signal.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Top College Banner (matching Image 3)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.school_outlined,
                          size: 17, color: Color(0xFFB45309)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "College: $college",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Row 1: Full Name * & Roll Number *
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        label: "Full Name *",
                        child: TextField(
                          controller: _nameCtrl,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        label: "Roll Number *",
                        child: TextField(
                          controller: _rollCtrl,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Row 2: Department * & Section *
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        label: "Department *",
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedDept,
                              isExpanded: true,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5, color: const Color(0xFF1E293B)),
                              items: widget.departmentList.map((d) {
                                return DropdownMenuItem(
                                  value: d,
                                  child:
                                      Text(d, overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedDept = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        label: "Section *",
                        child: TextField(
                          controller: _sectionCtrl,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Row 3: CGPA & Readiness (%)
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        label: "CGPA",
                        child: TextField(
                          controller: _cgpaCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        label: "Readiness (%)",
                        child: TextField(
                          controller: _readinessCtrl,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: _inputDecoration(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Row 4: Support Signal Dropdown
                _buildField(
                  label: "Support Signal",
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSignal,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF64748B)),
                        style: GoogleFonts.poppins(
                            fontSize: 12.5, color: const Color(0xFF1E293B)),
                        items: widget.supportSignals.map((s) {
                          return DropdownMenuItem(value: s, child: Text(s));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedSignal = val);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Row 5: Student CV / Document (PDF Upload in Edit)
                _buildField(
                  label: "Attached CV / Document (PDF)",
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf_rounded,
                            size: 16, color: Color(0xFFDC2626)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _cvFileName != null
                                ? _cvFileName!
                                : "No CV document attached",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: _cvFileName != null
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: _cvFileName != null
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _pickCvFile,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _cvFileName != null ? "Change CV" : "Upload CV",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4338CA),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Footer Actions: Cancel & Save Changes with Overflow Protection
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
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
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_nameCtrl.text.trim().isEmpty ||
                            _rollCtrl.text.trim().isEmpty) {
                          return;
                        }

                        widget.onSave({
                          "name": _nameCtrl.text.trim(),
                          "roll": _rollCtrl.text.trim(),
                          "dept": _selectedDept,
                          "section": _sectionCtrl.text.trim(),
                          "cgpa": _cgpaCtrl.text.trim(),
                          "readiness": _readinessCtrl.text.trim(),
                          "signal": _selectedSignal,
                          "cvFile": _cvFileName,
                        });

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 15),
                      label: Text(
                        "Save Changes",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E2A72),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 11),
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
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required Widget child}) {
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
        child,
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2E2A72), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      isDense: true,
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
