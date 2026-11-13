import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// STUDENT SUBMISSION MODEL
// =============================================================================
class StudentSubmission {
  final String studentName;
  final String regNo;
  final String handedInDate;
  int marks;
  final int totalMarks;
  String reportText;
  String githubLink;
  String feedback;

  StudentSubmission({
    required this.studentName,
    required this.regNo,
    required this.handedInDate,
    required this.marks,
    this.totalMarks = 10,
    required this.reportText,
    required this.githubLink,
    required this.feedback,
  });
}

// =============================================================================
// ASSIGNMENT DATA MODEL
// =============================================================================
class AssignmentModel {
  final String id;
  String title;
  String course;
  int totalMarks;
  String instructions;
  String dueDateStr;
  String? overdueText;
  int handedInCount;
  int totalStudents;
  int markedCount;
  String status; // 'Open', 'Closed', 'Draft'
  List<StudentSubmission> submissions;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.course,
    this.totalMarks = 10,
    this.instructions = '',
    required this.dueDateStr,
    this.overdueText,
    this.handedInCount = 0,
    this.totalStudents = 5,
    this.markedCount = 0,
    required this.status,
    this.submissions = const [],
  });

  Color get statusBgColor {
    switch (status) {
      case 'Open':
        return const Color(0xFFDCFCE7); // light green
      case 'Closed':
        return const Color(0xFFFEE2E2); // light red
      case 'Draft':
        return const Color(0xFFFEF3C7); // light amber
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get statusTextColor {
    switch (status) {
      case 'Open':
        return const Color(0xFF15803D);
      case 'Closed':
        return const Color(0xFFDC2626);
      case 'Draft':
        return const Color(0xFFB45309);
      default:
        return const Color(0xFF374151);
    }
  }
}

// =============================================================================
// FACULTY ASSIGNMENTS SCREEN
// =============================================================================
class FacultyAssignmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyAssignmentsScreen({super.key, this.onBack});

  @override
  State<FacultyAssignmentsScreen> createState() => _FacultyAssignmentsScreenState();
}

class _FacultyAssignmentsScreenState extends State<FacultyAssignmentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = "All";

  final List<String> _statusOptions = ["All", "Open", "Closed", "Draft"];

  late List<AssignmentModel> _assignments;

  @override
  void initState() {
    super.initState();
    _assignments = [
      AssignmentModel(
        id: "1",
        title: "CNN Image Classification on CIFAR-10 Dataset",
        course: "AI & Data Science",
        totalMarks: 10,
        instructions:
            "1. Build and train a Convolutional Neural Network (CNN) using PyTorch or TensorFlow to classify CIFAR-10 images into 10 categories.\n2. Implement Dropout and Batch Normalization to prevent overfitting and achieve at least 75% test accuracy.",
        dueDateStr: "16 Oct, 10:00 am",
        overdueText: "Overdue by 25 days",
        handedInCount: 1,
        totalStudents: 5,
        markedCount: 1,
        status: "Open",
        submissions: [
          StudentSubmission(
            studentName: "Anand Kumar",
            regNo: "110124001",
            handedInDate: "Oct 12, 1:30 PM",
            marks: 9,
            totalMarks: 10,
            reportText:
                "ASSIGNMENT REPORT: CNN Image Classification on CIFAR-10 Dataset\nCourse: AI & Data Science\nAuthor: Anand Kumar | Reg No: 21CS0101\n\n1. MODEL ARCHITECTURE & DESIGN:\nA custom 6-layer Deep Convolutional Neural Network (VGG-style blocks) was built using PyTorch:\n- Block 1: Conv2D(3 -> 32, kernel=3, padding=1) + BatchNorm2d + ReLU + Conv2D(32 -> 32, kernel=3) + ReLU + MaxPool2d(2, 2) + Dropout(0.25)",
            githubLink: "https://github.com/anandkumar/cifar10-cnn-classifier",
            feedback: "Good work",
          ),
        ],
      ),
      AssignmentModel(
        id: "2",
        title: "Cyber Security",
        course: "Cyber Security and Ethical Hacking",
        totalMarks: 10,
        instructions:
            "Analyze network capture PCAP files for brute force attacks and report identified vulnerability vectors.",
        dueDateStr: "16 Oct, 5:00 pm",
        overdueText: "Overdue by 25 days",
        handedInCount: 1,
        totalStudents: 5,
        markedCount: 1,
        status: "Open",
        submissions: [
          StudentSubmission(
            studentName: "Priya Sharma",
            regNo: "110124018",
            handedInDate: "Oct 15, 4:10 PM",
            marks: 8,
            totalMarks: 10,
            reportText:
                "WIRESHARK LOG ANALYSIS REPORT\nCourse: Cyber Security & Ethical Hacking\nAuthor: Priya Sharma | Reg: 110124018\n\nIdentified 3 suspicious IP ranges attempting unauthorized SSH handshake bursts on port 22.",
            githubLink: "https://github.com/priyasharma/network-intrusion-analysis",
            feedback: "Comprehensive PCAP packet dissection and clear mitigation strategies.",
          ),
        ],
      ),
      AssignmentModel(
        id: "3",
        title: "OS",
        course: "OS",
        totalMarks: 10,
        instructions:
            "Implement multi-threading synchronization using semaphores and mutex locks in C/C++.",
        dueDateStr: "7 Oct, 5:00 pm",
        overdueText: "Overdue by 34 days",
        handedInCount: 1,
        totalStudents: 5,
        markedCount: 1,
        status: "Open",
        submissions: [
          StudentSubmission(
            studentName: "Rohan Gupta",
            regNo: "110124045",
            handedInDate: "Oct 6, 2:45 PM",
            marks: 10,
            totalMarks: 10,
            reportText:
                "DINING PHILOSOPHERS & PRODUCER-CONSUMER IMPLEMENTATION\nLanguage: C++20 / POSIX threads\nSolved starvation deadlock using hierarchical resource allocation.",
            githubLink: "https://github.com/rohangupta/os-concurrency-primitives",
            feedback: "Excellent semaphore synchronization and zero race conditions.",
          ),
        ],
      ),
      AssignmentModel(
        id: "4",
        title: "Scheduler simulation",
        course: "CN",
        totalMarks: 10,
        instructions: "Simulate Round Robin and Priority scheduling algorithms in Python.",
        dueDateStr: "Oct 8",
        handedInCount: 0,
        totalStudents: 5,
        markedCount: 0,
        status: "Closed",
      ),
      AssignmentModel(
        id: "5",
        title: "Subnetting problems",
        course: "DBMS",
        totalMarks: 10,
        instructions: "Calculate usable host ranges and CIDR notation masks for provided IPv4 pools.",
        dueDateStr: "Oct 11",
        handedInCount: 0,
        totalStudents: 5,
        markedCount: 0,
        status: "Open",
      ),
      AssignmentModel(
        id: "6",
        title: "Linear regression notebook",
        course: "OS",
        totalMarks: 10,
        instructions: "Implement Ordinary Least Squares linear regression from scratch using NumPy.",
        dueDateStr: "Oct 14",
        handedInCount: 0,
        totalStudents: 5,
        markedCount: 0,
        status: "Open",
      ),
      AssignmentModel(
        id: "7",
        title: "Normalization case study",
        course: "DBMS",
        totalMarks: 10,
        instructions: "Decompose unnormalized hospital database schema into 1NF, 2NF, 3NF and BCNF.",
        dueDateStr: "Oct 17",
        handedInCount: 0,
        totalStudents: 5,
        markedCount: 0,
        status: "Open",
      ),
      AssignmentModel(
        id: "8",
        title: "Mini-project proposal",
        course: "OS",
        totalMarks: 10,
        instructions: "Submit a 2-page project proposal with system design diagram and milestones.",
        dueDateStr: "Oct 23",
        handedInCount: 0,
        totalStudents: 5,
        markedCount: 0,
        status: "Draft",
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AssignmentModel> get _filteredAssignments {
    final query = _searchController.text.trim().toLowerCase();
    return _assignments.where((asg) {
      if (_selectedStatus != "All" && asg.status != _selectedStatus) {
        return false;
      }
      if (query.isNotEmpty) {
        final matchesTitle = asg.title.toLowerCase().contains(query);
        final matchesCourse = asg.course.toLowerCase().contains(query);
        return matchesTitle || matchesCourse;
      }
      return true;
    }).toList();
  }

  // ===========================================================================
  // MODAL 1: VIEW SUBMISSIONS & GRADE (IMAGE 2)
  // ===========================================================================
  void _showSubmissionsModal(AssignmentModel asg) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Submissions · ${asg.title}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E2865),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${asg.course} · out of ${asg.totalMarks} · due ${asg.dueDateStr} · ${asg.handedInCount} of ${asg.totalStudents} handed in, ${asg.markedCount} marked',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),

                        if (asg.submissions.isEmpty) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 36),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.hourglass_empty_rounded, size: 36, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                Text(
                                  'No student submissions yet',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4B5563),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          // List of student submissions
                          ...asg.submissions.map((sub) {
                            final marksCtrl = TextEditingController(text: sub.marks.toString());
                            final feedbackCtrl = TextEditingController(text: sub.feedback);

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top row: Student Name + Reg + Date + Badge
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: 8,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              sub.studentName,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF1E2865),
                                              ),
                                            ),
                                            Text(
                                              sub.regNo,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 13,
                                                color: const Color(0xFF6B7280),
                                              ),
                                            ),
                                            Text(
                                              '· handed in ${sub.handedInDate}',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 13,
                                                color: const Color(0xFF6B7280),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE0F2FE),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '${sub.marks} / ${sub.totalMarks}',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0369A1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  // Code / Report container
                                  Container(
                                    width: double.infinity,
                                    height: 140,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAF9F6),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFE5E7EB)),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        sub.reportText,
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 12,
                                          color: const Color(0xFF374151),
                                          height: 1.45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Clickable Link
                                  InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Opening ${sub.githubLink}'),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      sub.githubLink,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13,
                                        color: const Color(0xFF2563EB),
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Form: Marks & Feedback
                                  LayoutBuilder(
                                    builder: (context, formConstraints) {
                                      final isMobileForm = formConstraints.maxWidth < 460;
                                      final marksColumn = Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Marks / ${sub.totalMarks}',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF374151),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          TextField(
                                            controller: marksCtrl,
                                            keyboardType: TextInputType.number,
                                            style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );

                                      final feedbackColumn = Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Feedback for the student',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF374151),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          TextField(
                                            controller: feedbackCtrl,
                                            style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );

                                      final updateButton = ElevatedButton(
                                        onPressed: () {
                                          final newMarks = int.tryParse(marksCtrl.text.trim()) ?? sub.marks;
                                          setState(() {
                                            sub.marks = newMarks;
                                            sub.feedback = feedbackCtrl.text.trim();
                                          });
                                          setDialogState(() {});
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Grade updated for ${sub.studentName}',
                                                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                                              ),
                                              backgroundColor: const Color(0xFF1E2865),
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF3B49B8),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text(
                                          'Update',
                                          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                      );

                                      if (isMobileForm) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 95, child: marksColumn),
                                                const SizedBox(width: 12),
                                                Expanded(child: feedbackColumn),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            updateButton,
                                          ],
                                        );
                                      }

                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 100, child: marksColumn),
                                          const SizedBox(width: 12),
                                          Expanded(child: feedbackColumn),
                                          const SizedBox(width: 12),
                                          updateButton,
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
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
  // MODAL 2: EDIT ASSIGNMENT (IMAGE 3)
  // ===========================================================================
  void _showEditAssignmentModal(AssignmentModel asg) {
    final titleCtrl = TextEditingController(text: asg.title);
    final courseCtrl = TextEditingController(text: asg.course);
    final marksCtrl = TextEditingController(text: asg.totalMarks.toString());
    final instrCtrl = TextEditingController(text: asg.instructions);
    final dueCtrl = TextEditingController(text: asg.dueDateStr);
    String status = asg.status;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Edit assignment',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E2865),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Title
                        _buildLabel('Title'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: titleCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                          decoration: _inputDeco(),
                        ),
                        const SizedBox(height: 16),

                        // Two column: Course & Total marks (Responsive)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 460;
                            final courseField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Course'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: courseCtrl,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco(),
                                ),
                              ],
                            );

                            final marksField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Total marks'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: marksCtrl,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco(),
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  courseField,
                                  const SizedBox(height: 16),
                                  marksField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(flex: 2, child: courseField),
                                const SizedBox(width: 14),
                                Expanded(flex: 1, child: marksField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Instructions for students
                        _buildLabel('Instructions for students'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: instrCtrl,
                          maxLines: 4,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                          decoration: _inputDeco(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What to do, what to hand in and how it will be marked.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF9CA3AF)),
                        ),
                        const SizedBox(height: 16),

                        // Two column: Due date & time + Status (Responsive)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 460;
                            final dueField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Due date and time'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: dueCtrl,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco().copyWith(
                                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
                                  ),
                                ),
                              ],
                            );

                            final statusField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Status'),
                                const SizedBox(height: 6),
                                _buildStatusDropdown(
                                  value: status,
                                  onChanged: (val) {
                                    if (val != null) setDialogState(() => status = val);
                                  },
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  dueField,
                                  const SizedBox(height: 16),
                                  statusField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: dueField),
                                const SizedBox(width: 14),
                                Expanded(child: statusField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Students see it when it is Open.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF9CA3AF)),
                        ),
                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4B5563),
                                side: const BorderSide(color: Color(0xFFD1D5DB)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Cancel', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  asg.title = titleCtrl.text.trim();
                                  asg.course = courseCtrl.text.trim();
                                  asg.totalMarks = int.tryParse(marksCtrl.text.trim()) ?? asg.totalMarks;
                                  asg.instructions = instrCtrl.text.trim();
                                  asg.dueDateStr = dueCtrl.text.trim();
                                  asg.status = status;
                                });
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Assignment updated successfully', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600)),
                                    backgroundColor: const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B49B8),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Save changes', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
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
  // MODAL 3: DELETE CONFIRMATION (IMAGE 4)
  // ===========================================================================
  void _confirmDeleteAssignment(AssignmentModel asg) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delete assignment?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(ctx),
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  '“${asg.title}” will disappear from every student’s list, and the ${asg.submissions.length} submission(s) and marks with it. This cannot be undone.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: const Color(0xFF4B5563),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4B5563),
                        side: const BorderSide(color: Color(0xFFD1D5DB)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Cancel', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _assignments.removeWhere((e) => e.id == asg.id);
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Assignment deleted', style: GoogleFonts.plusJakartaSans(color: Colors.white)),
                            backgroundColor: const Color(0xFFB91C1C),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB91C1C),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Delete', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
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

  // ===========================================================================
  // MODAL 4: NEW ASSIGNMENT (IMAGE 5)
  // ===========================================================================
  void _showNewAssignmentModal() {
    final titleCtrl = TextEditingController();
    final courseCtrl = TextEditingController();
    final marksCtrl = TextEditingController(text: '10');
    final instrCtrl = TextEditingController();
    final dueCtrl = TextEditingController(text: '11/11/2026 05:00 PM');
    String status = 'Open';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'New assignment',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E2865),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Title
                        _buildLabel('Title'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: titleCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                          decoration: _inputDeco(hint: 'e.g. Process Scheduling Simulation'),
                        ),
                        const SizedBox(height: 16),

                        // Two column: Course & Total marks (Responsive)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 460;
                            final courseField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Course'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: courseCtrl,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco(hint: 'e.g. OS, DBMS'),
                                ),
                              ],
                            );

                            final marksField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Total marks'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: marksCtrl,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco(),
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  courseField,
                                  const SizedBox(height: 16),
                                  marksField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(flex: 2, child: courseField),
                                const SizedBox(width: 14),
                                Expanded(flex: 1, child: marksField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Instructions
                        _buildLabel('Instructions for students'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: instrCtrl,
                          maxLines: 4,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14),
                          decoration: _inputDeco(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What to do, what to hand in and how it will be marked.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF9CA3AF)),
                        ),
                        const SizedBox(height: 16),

                        // Two column: Due date & time + Status (Responsive)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 460;
                            final dueField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Due date and time'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: dueCtrl,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14),
                                  decoration: _inputDeco().copyWith(
                                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
                                  ),
                                ),
                              ],
                            );

                            final statusField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Status'),
                                const SizedBox(height: 6),
                                _buildStatusDropdown(
                                  value: status,
                                  onChanged: (val) {
                                    if (val != null) setDialogState(() => status = val);
                                  },
                                ),
                              ],
                            );

                            if (isNarrow) {
                              return Column(
                                children: [
                                  dueField,
                                  const SizedBox(height: 16),
                                  statusField,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: dueField),
                                const SizedBox(width: 14),
                                Expanded(child: statusField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Students see it when it is Open.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF9CA3AF)),
                        ),
                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4B5563),
                                side: const BorderSide(color: Color(0xFFD1D5DB)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Cancel', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                final title = titleCtrl.text.trim();
                                if (title.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please enter an assignment title', style: GoogleFonts.plusJakartaSans(color: Colors.white)), backgroundColor: Colors.redAccent),
                                  );
                                  return;
                                }

                                setState(() {
                                  _assignments.insert(
                                    0,
                                    AssignmentModel(
                                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                                      title: title,
                                      course: courseCtrl.text.trim().isEmpty ? 'General' : courseCtrl.text.trim(),
                                      totalMarks: int.tryParse(marksCtrl.text.trim()) ?? 10,
                                      instructions: instrCtrl.text.trim(),
                                      dueDateStr: dueCtrl.text.trim(),
                                      status: status,
                                    ),
                                  );
                                });
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Assignment published to students', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600)),
                                    backgroundColor: const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B49B8),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Publish to students', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
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
  // BUILD SCREEN
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Blueprint Hero Banner
              _buildHeroBanner(),
              const SizedBox(height: 20),

              // 2. Search, Status Filter & + New Assignment Bar
              _buildFilterBar(),
              const SizedBox(height: 18),

              // 3. Assignments Table Card
              _buildAssignmentsTableCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E2865),
            Color(0xFF283593),
            Color(0xFF1E2865),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.15),
            blurRadius: 16,
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
                painter: _BlueprintGridPainter(
                  gridColor: Colors.white.withValues(alpha: 0.07),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.assignment_rounded,
                size: 160,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios_new_rounded, size: 12, color: Colors.white70),
                              const SizedBox(width: 4),
                              Text(
                                'Home',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Home',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.75),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      Text(
                        '  ›  Academics  ›  ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        'Assignments',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tag badges row: ACADEMICS + MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ACADEMICS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'MVP',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Icon + Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF141B4D),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: const Icon(
                          Icons.assignment_rounded,
                          color: Color(0xFFF59E0B),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assignments',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Create, distribute and track assignments and lab submissions.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.82),
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
  // 2. SEARCH, STATUS DROPDOWN & NEW ASSIGNMENT BUTTON
  // ===========================================================================
  Widget _buildFilterBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        final searchAndDropdown = Row(
          children: [
            // Search Input
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF1F2937)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF9CA3AF)),
                    hintText: 'Search assignments...',
                    hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Status Dropdown with Image 1 styling
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFD97706),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  elevation: 6,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF1E2865)),
                  selectedItemBuilder: (context) {
                    return _statusOptions.map((st) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          st,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: const Color(0xFF1E2865),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  items: _statusOptions.map((st) {
                    final isSelected = st == _selectedStatus;
                    return DropdownMenuItem<String>(
                      value: st,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1D68D8) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          st,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: isSelected ? Colors.white : const Color(0xFF1F2937),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedStatus = val);
                  },
                ),
              ),
            ),
          ],
        );

        final newAssignmentBtn = ElevatedButton.icon(
          onPressed: _showNewAssignmentModal,
          icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
          label: Text(
            'New assignment',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchAndDropdown,
              const SizedBox(height: 12),
              newAssignmentBtn,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: searchAndDropdown),
            const SizedBox(width: 16),
            newAssignmentBtn,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 3. ASSIGNMENTS TABLE CARD (MATCHES IMAGE 1)
  // ===========================================================================
  Widget _buildAssignmentsTableCard() {
    final list = _filteredAssignments;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 880),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFFBFBFB)),
              dataRowMinHeight: 68,
              dataRowMaxHeight: 74,
              horizontalMargin: 20,
              columnSpacing: 24,
              columns: [
                DataColumn(
                  label: Text(
                    'ASSIGNMENT',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'DUE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'HANDED IN',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MARKED',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'STATUS',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ACTIONS',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
              rows: list.map((asg) {
                return DataRow(
                  cells: [
                    // 1. Assignment Title & Subtitle
                    DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 260),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asg.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E2865),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${asg.course} · ${asg.totalMarks} marks',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 2. Due Date
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            asg.dueDateStr,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: const Color(0xFF374151),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (asg.overdueText != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              asg.overdueText!,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: const Color(0xFFDC2626),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // 3. Handed in with progress bar
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: asg.totalStudents > 0
                                  ? (asg.handedInCount / asg.totalStudents).clamp(0.0, 1.0)
                                  : 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: asg.handedInCount > 0 ? const Color(0xFFB45309) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${asg.handedInCount} / ${asg.totalStudents}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: const Color(0xFF4B5563),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 4. Marked
                    DataCell(
                      Text(
                        asg.markedCount > 0 ? '${asg.markedCount} of ${asg.handedInCount}' : '—',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: const Color(0xFF4B5563),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // 5. Status Pill
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: asg.statusBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          asg.status,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: asg.statusTextColor,
                          ),
                        ),
                      ),
                    ),

                    // 6. Actions (Publish if draft, View, Edit, Delete)
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (asg.status == 'Draft') ...[
                            OutlinedButton.icon(
                              onPressed: () {
                                setState(() => asg.status = 'Open');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('“${asg.title}” published to students', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600)),
                                    backgroundColor: const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.near_me_outlined, size: 14, color: Color(0xFF1E2865)),
                              label: Text(
                                'Publish',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E2865),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFD1D5DB)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          IconButton(
                            onPressed: () => _showSubmissionsModal(asg),
                            icon: const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF6B7280)),
                            tooltip: 'View submissions',
                            splashRadius: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () => _showEditAssignmentModal(asg),
                            icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF6B7280)),
                            tooltip: 'Edit assignment',
                            splashRadius: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () => _confirmDeleteAssignment(asg),
                            icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                            tooltip: 'Delete assignment',
                            splashRadius: 18,
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
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildStatusDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF6B7280)),
          selectedItemBuilder: (context) {
            return const [
              'Open',
              'Closed',
              'Draft',
            ].map((st) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  st,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF1E2865),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList();
          },
          items: const [
            DropdownMenuItem(
              value: 'Open',
              child: Text(
                'Open (students can hand in)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
            DropdownMenuItem(
              value: 'Closed',
              child: Text(
                'Closed',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
            DropdownMenuItem(
              value: 'Draft',
              child: Text(
                'Draft',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF374151),
      ),
    );
  }

  InputDecoration _inputDeco({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF9CA3AF)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _BlueprintGridPainter({required this.gridColor, this.step = 26.0});

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
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
