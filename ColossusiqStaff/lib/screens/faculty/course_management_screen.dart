import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// COURSE MODEL
// =============================================================================
class CourseItem {
  final String id;
  String code;
  String name;
  String type; // Theory, Lab, Theory + Lab, Elective, Project, etc.
  String semester; // Semester 1 - Semester 8
  int credits;
  int hours;
  String faculty;
  int enrolled;
  String status; // Active, Archived, Draft
  String description;

  CourseItem({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.semester,
    required this.credits,
    required this.hours,
    required this.faculty,
    required this.enrolled,
    required this.status,
    this.description = "",
  });
}

// =============================================================================
// COURSE MANAGEMENT SCREEN (FACULTY PORTAL - MATCHING EXACT DESIGN)
// =============================================================================
class CourseManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CourseManagementScreen({super.key, this.onBack});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedType = "All Types";
  String _selectedSemester = "All Semesters";

  final List<String> _typeOptions = [
    "All Types",
    "Theory",
    "Lab",
    "Theory + Lab",
    "Elective",
    "Project",
    "Clinical posting",
    "Practical / skills lab",
  ];

  final List<String> _semesterOptions = [
    "All Semesters",
    "Semester 1",
    "Semester 2",
    "Semester 3",
    "Semester 4",
    "Semester 5",
    "Semester 6",
    "Semester 7",
    "Semester 8",
  ];

  late List<CourseItem> _courses;

  @override
  void initState() {
    super.initState();
    _initCourses();
  }

  void _initCourses() {
    _courses = [
      // 1. Advanced Java
      CourseItem(
        id: "crs_1",
        code: "CS301",
        name: "Advanced Java",
        type: "Theory + Lab",
        semester: "Semester 1",
        credits: 5,
        hours: 100,
        faculty: "Dr. R. Meenakshi",
        enrolled: 54,
        status: "Active",
        description: "Advanced Java Enterprise edition, Spring Boot, microservices architecture and reactive streams.",
      ),

      // 2. OOP with Java
      CourseItem(
        id: "crs_2",
        code: "CS201",
        name: "Object-Oriented Programming with Java",
        type: "Theory",
        semester: "Semester 1",
        credits: 3,
        hours: 45,
        faculty: "Dr. R. Rajesh",
        enrolled: 54,
        status: "Active",
        description: "Object-oriented software principles, collections framework, exception handling and GUI design.",
      ),

      // 3. Cloud Computing & Virtualization
      CourseItem(
        id: "crs_3",
        code: "CS3492",
        name: "Cloud Computing & Virtualization",
        type: "Theory",
        semester: "Semester 6",
        credits: 3,
        hours: 45,
        faculty: "Dr. Meena Raghavan",
        enrolled: 54,
        status: "Active",
        description: "Cloud deployment models, hypervisors, containers, Kubernetes cluster management and AWS/GCP cloud services.",
      ),

      // 4. Emerging Technologies
      CourseItem(
        id: "crs_4",
        code: "CSE107",
        name: "Emerging Technologies",
        type: "Theory",
        semester: "Semester 5",
        credits: 3,
        hours: 45,
        faculty: "Dr. Meena Raghavan",
        enrolled: 54,
        status: "Active",
        description: "Exploration of Web3, Edge Computing, IoT ecosystems and generative intelligence in enterprise stacks.",
      ),

      // 5. python
      CourseItem(
        id: "crs_5",
        code: "CS2354",
        name: "python",
        type: "Theory",
        semester: "Semester 1",
        credits: 4,
        hours: 60,
        faculty: "far",
        enrolled: 54,
        status: "Active",
        description: "Python syntax, scientific computation with NumPy, dataframes in Pandas, and backend APIs with FastAPI.",
      ),

      // 6. Database Management Systems
      CourseItem(
        id: "crs_6",
        code: "CS3402",
        name: "Database Management Systems",
        type: "Theory + Lab",
        semester: "Semester 3",
        credits: 4,
        hours: 60,
        faculty: "Dr. Meena Raghavan",
        enrolled: 54,
        status: "Active",
        description: "Relational database modeling, SQL DDL/DML, normalization, indexing, transaction processing and ACID.",
      ),

      // 7. Data Structures & Algorithms
      CourseItem(
        id: "crs_7",
        code: "CS3301",
        name: "Data Structures & Algorithms",
        type: "Theory + Lab",
        semester: "Semester 3",
        credits: 4,
        hours: 60,
        faculty: "Dr. S. Venkatesh",
        enrolled: 54,
        status: "Active",
        description: "Linear and non-linear data structures, trees, heaps, graphs, sorting and asymptotic analysis.",
      ),

      // 8. Artificial Intelligence
      CourseItem(
        id: "crs_8",
        code: "AI3401",
        name: "Artificial Intelligence Foundations",
        type: "Theory",
        semester: "Semester 4",
        credits: 3,
        hours: 45,
        faculty: "Dr. V. Srinivasan",
        enrolled: 54,
        status: "Active",
        description: "State space search, game playing, constraint satisfaction, propositional logic and inference engines.",
      ),

      // 9. Web Development Frameworks
      CourseItem(
        id: "crs_9",
        code: "IT3501",
        name: "Full Stack Web Development",
        type: "Lab",
        semester: "Semester 5",
        credits: 3,
        hours: 45,
        faculty: "Prof. N. Kumar",
        enrolled: 54,
        status: "Active",
        description: "HTML5, CSS3, modern JavaScript, React frontend development and Node.js REST API engineering.",
      ),

      // 10. Computer Networks
      CourseItem(
        id: "crs_10",
        code: "CS3591",
        name: "Computer Networks & Security",
        type: "Theory",
        semester: "Semester 5",
        credits: 4,
        hours: 60,
        faculty: "Dr. K. Anitha",
        enrolled: 54,
        status: "Active",
        description: "OSI and TCP/IP stack, routing protocols, flow control, transport layer protocols and public key crypto.",
      ),

      // 11. Mobile App Development
      CourseItem(
        id: "crs_11",
        code: "CS3602",
        name: "Mobile App Development with Flutter",
        type: "Elective",
        semester: "Semester 6",
        credits: 3,
        hours: 45,
        faculty: "Dr. R. Rajesh",
        enrolled: 0,
        status: "Archived",
        description: "Cross-platform mobile application development using Flutter, Dart and Firebase cloud integration.",
      ),

      // 12. Capstone Project
      CourseItem(
        id: "crs_12",
        code: "CS3811",
        name: "Major Capstone Project",
        type: "Project",
        semester: "Semester 8",
        credits: 2,
        hours: 30,
        faculty: "Dr. Meena Raghavan",
        enrolled: 0,
        status: "Archived",
        description: "Multi-disciplinary team research project, system design, implementation, testing and viva voce.",
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // ADD COURSE MODAL (MATCHES IMAGE 2)
  // ===========================================================================
  void _showAddCourseDialog() {
    final codeCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final creditsCtrl = TextEditingController(text: "3");
    final hoursCtrl = TextEditingController(text: "45");
    final facultyCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String selectedType = "Theory";
    String selectedStatus = "Active";
    String selectedSem = "Semester 1";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Close X
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add Course",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(ctx),
                              icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Row 1: Course Code * & Course Name *
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildFormField(
                                label: "Course Code *",
                                hint: "e.g. CS201",
                                controller: codeCtrl,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 1,
                              child: _buildFormField(
                                label: "Course Name *",
                                hint: "e.g. Database Management Syst",
                                controller: nameCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 2: Type & Status
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: "Type",
                                value: selectedType,
                                items: _typeOptions.where((t) => t != "All Types").toList(),
                                onChanged: (v) => setDlgState(() => selectedType = v!),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildDropdownField(
                                label: "Status",
                                value: selectedStatus,
                                items: const ["Active", "Archived", "Draft"],
                                onChanged: (v) => setDlgState(() => selectedStatus = v!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 3: Credits (1 - 6) & Hours / Semester
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: "Credits (1 - 6)",
                                hint: "3",
                                controller: creditsCtrl,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "Hours / Semester",
                                hint: "45",
                                controller: hoursCtrl,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 4: Semester & Faculty Assigned
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: "Semester",
                                value: selectedSem,
                                items: _semesterOptions.where((s) => s != "All Semesters").toList(),
                                onChanged: (v) => setDlgState(() => selectedSem = v!),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "Faculty Assigned",
                                hint: "e.g. Dr. R. Rajesh",
                                controller: facultyCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 5: Description
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: descCtrl,
                          maxLines: 3,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Brief course description...",
                            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Buttons Row: Cancel and Add Course
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                if (codeCtrl.text.trim().isEmpty || nameCtrl.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please fill course code and name")),
                                  );
                                  return;
                                }

                                final newCourse = CourseItem(
                                  id: "crs_${DateTime.now().millisecondsSinceEpoch}",
                                  code: codeCtrl.text.trim().toUpperCase(),
                                  name: nameCtrl.text.trim(),
                                  type: selectedType,
                                  semester: selectedSem,
                                  credits: int.tryParse(creditsCtrl.text.trim()) ?? 3,
                                  hours: int.tryParse(hoursCtrl.text.trim()) ?? 45,
                                  faculty: facultyCtrl.text.trim().isEmpty ? "Dr. Meena Raghavan" : facultyCtrl.text.trim(),
                                  enrolled: 54,
                                  status: selectedStatus,
                                  description: descCtrl.text.trim(),
                                );

                                setState(() {
                                  _courses.insert(0, newCourse);
                                });

                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Course '${newCourse.code}' added successfully!"),
                                    backgroundColor: const Color(0xFF0F766E),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF818CF8),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Add Course",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
          },
        );
      },
    );
  }

  // ===========================================================================
  // EDIT COURSE MODAL (MATCHES IMAGE 3)
  // ===========================================================================
  void _showEditCourseDialog(CourseItem course) {
    final codeCtrl = TextEditingController(text: course.code);
    final nameCtrl = TextEditingController(text: course.name);
    final creditsCtrl = TextEditingController(text: "${course.credits}");
    final hoursCtrl = TextEditingController(text: "${course.hours}");
    final facultyCtrl = TextEditingController(text: course.faculty);
    final descCtrl = TextEditingController(text: course.description);
    String selectedType = course.type;
    String selectedStatus = course.status;
    String selectedSem = course.semester;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Close X
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Course",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(ctx),
                              icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Row 1: Course Code * & Course Name *
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildFormField(
                                label: "Course Code *",
                                hint: "CS301",
                                controller: codeCtrl,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 1,
                              child: _buildFormField(
                                label: "Course Name *",
                                hint: "Advanced Java",
                                controller: nameCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 2: Type & Status
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: "Type",
                                value: selectedType,
                                items: _typeOptions.where((t) => t != "All Types").toList(),
                                onChanged: (v) => setDlgState(() => selectedType = v!),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildDropdownField(
                                label: "Status",
                                value: selectedStatus,
                                items: const ["Active", "Archived", "Draft"],
                                onChanged: (v) => setDlgState(() => selectedStatus = v!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 3: Credits (1 - 6) & Hours / Semester
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: "Credits (1 - 6)",
                                hint: "5",
                                controller: creditsCtrl,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "Hours / Semester",
                                hint: "100",
                                controller: hoursCtrl,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 4: Semester & Faculty Assigned
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: "Semester",
                                value: selectedSem,
                                items: _semesterOptions.where((s) => s != "All Semesters").toList(),
                                onChanged: (v) => setDlgState(() => selectedSem = v!),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildFormField(
                                label: "Faculty Assigned",
                                hint: "Dr. R. Meenakshi",
                                controller: facultyCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Row 5: Description
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: descCtrl,
                          maxLines: 3,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Brief course description...",
                            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Buttons Row: Cancel and Save Changes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  course.code = codeCtrl.text.trim().toUpperCase();
                                  course.name = nameCtrl.text.trim();
                                  course.type = selectedType;
                                  course.status = selectedStatus;
                                  course.credits = int.tryParse(creditsCtrl.text.trim()) ?? course.credits;
                                  course.hours = int.tryParse(hoursCtrl.text.trim()) ?? course.hours;
                                  course.semester = selectedSem;
                                  course.faculty = facultyCtrl.text.trim();
                                  course.description = descCtrl.text.trim();
                                });

                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Course '${course.code}' updated successfully!"),
                                    backgroundColor: const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF283685),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Save Changes",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
          },
        );
      },
    );
  }

  // ===========================================================================
  // DELETE COURSE MODAL (MATCHES IMAGE 4)
  // ===========================================================================
  void _showDeleteCourseDialog(CourseItem course) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Red trash icon + close X
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Color(0xFFDC2626),
                            size: 24,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Title & Subtitle
                  Text(
                    "Delete Course",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "This action cannot be undone.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Prompt question
                  Text(
                    "Are you sure you want to remove ${course.name} (${course.code})?",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF334155),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Action Buttons: Cancel and Delete Course
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final idx = _courses.indexOf(course);
                          setState(() {
                            _courses.remove(course);
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Removed ${course.name} (${course.code})"),
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                label: "Undo",
                                textColor: const Color(0xFFFBBF24),
                                onPressed: () {
                                  setState(() {
                                    _courses.insert(idx >= 0 ? idx : 0, course);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB91C1C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Delete Course",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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
  // FORM FIELD HELPERS
  // ===========================================================================
  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
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
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              isExpanded: true,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _courses.where((c) {
      if (_selectedType != "All Types" && c.type != _selectedType) {
        return false;
      }
      if (_selectedSemester != "All Semesters" && c.semester != _selectedSemester) {
        return false;
      }
      if (query.isNotEmpty) {
        final code = c.code.toLowerCase();
        final name = c.name.toLowerCase();
        final faculty = c.faculty.toLowerCase();
        if (!code.contains(query) && !name.contains(query) && !faculty.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    // Metric Calculations
    final totalCourses = _courses.length;
    final activeCourses = _courses.where((c) => c.status == "Active").length;
    final totalCredits = _courses.fold<int>(0, (sum, c) => sum + c.credits);
    final totalEnrolled = _courses.fold<int>(0, (sum, c) => sum + c.enrolled);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. 4 METRIC KPI CARDS ROW (MATCHING IMAGE 1)
                _buildKpiMetricsGrid(
                  constraints: constraints,
                  totalCourses: totalCourses,
                  activeCourses: activeCourses,
                  totalCredits: totalCredits,
                  totalEnrolled: totalEnrolled,
                ),
                const SizedBox(height: 18),

                // 3. SEARCH & FILTERS SECTION
                _buildFilterControls(),
                const SizedBox(height: 16),

                // 4. ADD COURSE ACTION BUTTON
                _buildAddCourseButton(),
                const SizedBox(height: 18),

                // 5. COURSE MANAGEMENT TABLE (MATCHING IMAGE 1)
                _buildCourseTableCard(filtered),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
                  const SizedBox(height: 14),

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book/crest icon rounded box
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
                            Icons.school_rounded,
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
                            // Badges: ACADEMICS, MVP
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
  // 2. 4 METRIC KPI CARDS ROW (IMAGE 1)
  // ===========================================================================
  Widget _buildKpiMetricsGrid({
    required BoxConstraints constraints,
    required int totalCourses,
    required int activeCourses,
    required int totalCredits,
    required int totalEnrolled,
  }) {
    final width = constraints.maxWidth;

    final cards = [
      _buildMetricCard(
        label: "Total Courses",
        value: "$totalCourses",
        icon: Icons.menu_book_outlined,
        iconColor: const Color(0xFF2563EB),
      ),
      _buildMetricCard(
        label: "Active",
        value: "$activeCourses",
        icon: Icons.check_circle_outline_rounded,
        iconColor: const Color(0xFF0D9488),
      ),
      _buildMetricCard(
        label: "Total Credits",
        value: "$totalCredits",
        icon: Icons.layers_outlined,
        iconColor: const Color(0xFF8B5CF6),
      ),
      _buildMetricCard(
        label: "Total Enrolled",
        value: "$totalEnrolled",
        icon: Icons.group_outlined,
        iconColor: const Color(0xFFF59E0B),
      ),
    ];

    if (width >= 980) {
      return Row(
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: c,
                  ),
                ))
            .toList(),
      );
    } else if (width >= 560) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: cards.map((c) {
          return SizedBox(
            width: (width - 52) / 2,
            child: c,
          );
        }).toList(),
      );
    } else {
      return Column(
        children: cards
            .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: c,
                ))
            .toList(),
      );
    }
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTERS SECTION (IMAGE 1 & 5)
  // ===========================================================================
  Widget _buildFilterControls() {
    return Column(
      children: [
        // Search Input Bar
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Search course name or code...",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Dropdown 1: All Types (With 8 exact options from Image 5)
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedType,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              items: _typeOptions.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedType = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Dropdown 2: All Semesters
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSemester,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              items: _semesterOptions.map((sem) {
                return DropdownMenuItem(
                  value: sem,
                  child: Text(sem),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedSemester = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. ADD COURSE ACTION BUTTON
  // ===========================================================================
  Widget _buildAddCourseButton() {
    return ElevatedButton.icon(
      onPressed: _showAddCourseDialog,
      icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
      label: Text(
        "Add Course",
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF283685),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ===========================================================================
  // 5. COURSE MANAGEMENT TABLE (MATCHES IMAGE 1)
  // ===========================================================================
  Widget _buildCourseTableCard(List<CourseItem> list) {
    if (list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off_rounded, size: 44, color: Color(0xFF94A3B8)),
              const SizedBox(height: 12),
              Text(
                "No courses match your filter criteria",
                style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 4),
              Text(
                "Try clearing search queries or switching type/semester filters.",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      );
    }

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 920),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF9F9FB)),
              headingRowHeight: 46,
              dataRowMinHeight: 58,
              dataRowMaxHeight: 64,
              horizontalMargin: 20,
              columnSpacing: 24,
              columns: [
                DataColumn(
                  label: Text(
                    "COURSE",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "TYPE",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "SEMESTER",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "CREDITS",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "FACULTY",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "ENROLLED",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "STATUS",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const DataColumn(
                  label: SizedBox(width: 48),
                ),
              ],
              rows: list.map((course) {
                return DataRow(
                  cells: [
                    // Course Title & Code
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            course.name,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            course.code,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Type Badge
                    DataCell(_buildTypeChip(course.type)),

                    // Semester
                    DataCell(
                      Text(
                        course.semester,
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                      ),
                    ),

                    // Credits / Hours
                    DataCell(
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${course.credits} ",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            TextSpan(
                              text: "/ ${course.hours}h",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Faculty
                    DataCell(
                      Text(
                        course.faculty,
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                      ),
                    ),

                    // Enrolled Count
                    DataCell(
                      Text(
                        "${course.enrolled}",
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                      ),
                    ),

                    // Status: Green dot + Active / Grey Archived
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: course.status == "Active"
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            course.status,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: course.status == "Active"
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Actions: Edit pencil & Delete trash
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF94A3B8)),
                            tooltip: "Edit Course",
                            splashRadius: 16,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _showEditCourseDialog(course),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFF94A3B8)),
                            tooltip: "Delete Course",
                            splashRadius: 16,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _showDeleteCourseDialog(course),
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
      ),
    );
  }

  // Helper chip for Course Type
  Widget _buildTypeChip(String type) {
    Color bg = const Color(0xFFF1F5F9);
    Color fg = const Color(0xFF475569);

    if (type == "Theory + Lab") {
      bg = const Color(0xFFF3E8FF);
      fg = const Color(0xFF7E22CE);
    } else if (type == "Theory") {
      bg = const Color(0xFFE0F2FE);
      fg = const Color(0xFF0284C7);
    } else if (type == "Lab") {
      bg = const Color(0xFFECFDF5);
      fg = const Color(0xFF059669);
    } else if (type == "Elective") {
      bg = const Color(0xFFFEF3C7);
      fg = const Color(0xFFB45309);
    } else if (type == "Project") {
      bg = const Color(0xFFFFEDD5);
      fg = const Color(0xFFC2410C);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
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
