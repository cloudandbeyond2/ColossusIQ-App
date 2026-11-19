import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: PLACEMENT DRIVES SCREEN
// Matches Images 1, 2, 3, 4, 5:
// - Blueprint grid hero banner with briefcase watermark, PLACEMENT and MVP badges
// - 5 Metric Stat Cards (Upcoming 4, Open now 3, Completed 2, Offers 46, Average package ₹8 LPA)
// - Search bar, "All statuses" dropdown, and "+ Schedule drive" button
// - Schedule a drive dialog (Images 1 & 2): Company, Role, Type, Status, Date/Time, Venue,
//   Package, Openings, Minimum readiness, Departments allowed, Selection rounds, Details & How it went
// - Edit drive dialog (Image 4): Pre-filled form with interactive department tags & save/delete actions
// - Eligible students dialog (Image 3): Company/role header, rounds, 0 eligible students with faint grid
//   and "No students meet these rules" empty state + masked roll numbers disclaimer
// - Delete drive confirmation dialog (Image 5): Exact message, Cancel and Delete button with undo toast
// =============================================================================

class PlacementDrivesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementDrivesScreen({super.key, this.onBack});

  @override
  State<PlacementDrivesScreen> createState() => _PlacementDrivesScreenState();
}

class _PlacementDrivesScreenState extends State<PlacementDrivesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = "All statuses";

  final List<String> _allDepartments = [
    "Computer Science & Engineering",
    "Information Technology",
    "Electronics & Communication",
    "Electrical & Electronics",
    "Mechanical Engineering",
    "Civil Engineering",
  ];

  final List<Map<String, dynamic>> _drives = [
    {
      "company": "L&T Technology Services",
      "status": "Draft",
      "campusType": "On-campus",
      "role": "Embedded Systems & IoT Engineer",
      "date": "Sun, 15 Nov, 2026",
      "driveDateRaw": "11/15/2026",
      "time": "10:30 AM",
      "location": "Department Seminar Hall - ECE Block",
      "salary": "₹5.5-8 LPA",
      "lowestSalary": "5.5",
      "highestSalary": "8",
      "openings": 20,
      "eligibleCount": 0,
      "totalStudents": 14,
      "branches":
          "Electronics & Communication, Electrical & Electronics, Mechanical Engineering",
      "allowedDepts": [
        "Electronics & Communication",
        "Electrical & Electronics",
        "Mechanical Engineering",
      ],
      "cutoff": "Readiness 55+",
      "minReadiness": 55,
      "deadline": "11/10/2026",
      "registered": 0,
      "shortlisted": 0,
      "offers": 0,
      "description":
          "Core engineering campus drive targeting smart devices, automotive electronics, and industrial IoT solutions. Strong foundation in microcontrollers and C/C++ expected.",
      "rounds": [
        "Core Technical Written Test",
        "Practical Hardware/Simulation Round",
        "Technical & HR Interview",
      ],
      "details":
          "Extra eligibility such as CGPA or backlogs, bond, location, what to bring.",
    },
    {
      "company": "Amazon AWS",
      "status": "Open",
      "campusType": "Pool campus",
      "role": "Associate Cloud Support Engineer",
      "date": "Sun, 18 Oct, 2026",
      "driveDateRaw": "10/18/2026",
      "time": "11:00 AM",
      "location": "Seminar Hall B & Online Proctoring",
      "salary": "₹12-18 LPA",
      "lowestSalary": "12",
      "highestSalary": "18",
      "openings": 15,
      "eligibleCount": 1,
      "totalStudents": 14,
      "branches":
          "Computer Science & Engineering, Electronics & Communication",
      "allowedDepts": [
        "Computer Science & Engineering",
        "Electronics & Communication",
      ],
      "cutoff": "Readiness 65+",
      "minReadiness": 65,
      "deadline": "10/15/2026",
      "registered": 54,
      "shortlisted": 0,
      "offers": 0,
      "description":
          "Cloud operations and support engineering drive focusing on distributed systems, Linux internals, TCP/IP networking and AWS services.",
      "rounds": [
        "Online Assessment & Aptitude",
        "Technical Systems Interview",
        "Managerial Bar Raiser Round",
      ],
      "details": "Minimum 7.0 CGPA with no active backlogs.",
    },
    {
      "company": "Google India",
      "status": "Open",
      "campusType": "On-campus",
      "role": "Software Development Engineer (SDE-1)",
      "date": "Sun, 25 Oct, 2026",
      "driveDateRaw": "10/25/2026",
      "time": "09:30 AM",
      "location": "Sir CV Raman Auditorium, Academic Block",
      "salary": "₹18-32.5 LPA",
      "lowestSalary": "18",
      "highestSalary": "32.5",
      "openings": 8,
      "eligibleCount": 2,
      "totalStudents": 14,
      "branches":
          "Computer Science & Engineering, Artificial Intelligence & Data Science",
      "allowedDepts": [
        "Computer Science & Engineering",
        "Information Technology",
      ],
      "cutoff": "Readiness 75+",
      "minReadiness": 75,
      "deadline": "10/22/2026",
      "registered": 48,
      "shortlisted": 0,
      "offers": 0,
      "description":
          "Software engineering entry-level positions across search, cloud, and core developer tools.",
      "rounds": [
        "Coding Challenge (LeetCode Hard)",
        "System Architecture Round",
        "Googleyness & Leadership Round",
      ],
      "details": "Bring resume, laptop and college ID card.",
    },
    {
      "company": "Microsoft Corporation",
      "status": "Open",
      "campusType": "On-campus",
      "role": "Cloud Solution & DevOps Engineer",
      "date": "Thu, 5 Nov, 2026",
      "driveDateRaw": "11/05/2026",
      "time": "10:00 AM",
      "location": "Virtual Interview Suite & Lab 3",
      "salary": "₹16-26 LPA",
      "lowestSalary": "16",
      "highestSalary": "26",
      "openings": 12,
      "eligibleCount": 2,
      "totalStudents": 14,
      "branches":
          "Computer Science & Engineering, Electronics & Communication",
      "allowedDepts": [
        "Computer Science & Engineering",
        "Electronics & Communication",
      ],
      "cutoff": "Readiness 70+",
      "minReadiness": 70,
      "deadline": "11/01/2026",
      "registered": 65,
      "shortlisted": 0,
      "offers": 0,
      "description":
          "Enterprise Azure cloud transformation, infrastructure automation, Kubernetes and CI/CD pipelines.",
      "rounds": [
        "Technical MCQ & Coding",
        "Azure Scenario Architecture",
        "Final HR Discussion",
      ],
      "details": "Open to all eligible final year engineering students.",
    },
    {
      "company": "Zoho Corporation",
      "status": "Completed",
      "campusType": "On-campus",
      "role": "Software Development Engineer (SDE)",
      "date": "Sat, 24 Oct, 2026",
      "driveDateRaw": "10/24/2026",
      "time": "10:00 AM",
      "location": "CS Computer Lab 2 & 3",
      "salary": "₹8.4-12.0 LPA",
      "lowestSalary": "8.4",
      "highestSalary": "12.0",
      "openings": 25,
      "eligibleCount": 3,
      "totalStudents": 14,
      "branches": "All Engineering Streams",
      "allowedDepts": [
        "Computer Science & Engineering",
        "Information Technology",
        "Electronics & Communication",
        "Electrical & Electronics",
        "Mechanical Engineering",
      ],
      "cutoff": "Readiness 65+",
      "minReadiness": 65,
      "deadline": "10/20/2026",
      "registered": 42,
      "shortlisted": 18,
      "offers": 18,
      "description":
          "Full stack software product development for Zoho CRM, Mail and Books suites.",
      "rounds": [
        "Basic Programming Round",
        "Advanced Problem Solving",
        "Technical HR & Fitment",
      ],
      "details": "Drive successfully concluded.",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // 1. SCHEDULE / EDIT DRIVE MODAL (Matches Images 1, 2, 4)
  // ===========================================================================
  void _showScheduleDriveDialog() {
    _showDriveFormDialog();
  }

  void _showEditDriveDialog(Map<String, dynamic> drive) {
    _showDriveFormDialog(initialDrive: drive);
  }

  void _showDriveFormDialog({Map<String, dynamic>? initialDrive}) {
    final isEditing = initialDrive != null;

    final companyCtrl =
        TextEditingController(text: initialDrive?['company'] ?? '');
    final roleCtrl = TextEditingController(
        text: initialDrive?['role'] ??
            (isEditing ? '' : 'Graduate Engineer Trainee'));
    String driveType = initialDrive?['campusType'] ?? 'On-campus';
    String status = initialDrive?['status'] ?? 'Draft';

    final driveDateCtrl = TextEditingController(
        text: initialDrive?['driveDateRaw'] ??
            (initialDrive?['date'] ?? '11/15/2026'));
    final startTimeCtrl =
        TextEditingController(text: initialDrive?['time'] ?? '10:30 AM');
    final venueCtrl = TextEditingController(
        text: initialDrive?['location'] ??
            (isEditing ? '' : 'Seminar Hall A'));
    final registerByCtrl =
        TextEditingController(text: initialDrive?['deadline'] ?? '11/10/2026');

    final lowestSalaryCtrl = TextEditingController(
        text: initialDrive?['lowestSalary'] ?? (isEditing ? '5.5' : ''));
    final highestSalaryCtrl = TextEditingController(
        text: initialDrive?['highestSalary'] ?? (isEditing ? '8' : ''));
    final openingsCtrl = TextEditingController(
        text: initialDrive?['openings'] != null
            ? '${initialDrive!['openings']}'
            : (isEditing ? '20' : ''));
    final readinessCtrl = TextEditingController(
        text: initialDrive?['minReadiness'] != null
            ? '${initialDrive!['minReadiness']}'
            : (isEditing ? '55' : ''));

    final List<String> selectedDepts = initialDrive?['allowedDepts'] != null
        ? List<String>.from(initialDrive!['allowedDepts'] as List)
        : (isEditing
            ? [
                "Electronics & Communication",
                "Electrical & Electronics",
                "Mechanical Engineering",
              ]
            : <String>[]);

    final roundsList = initialDrive?['rounds'] as List?;
    final roundsCtrl = TextEditingController(
        text: roundsList != null
            ? roundsList.join('\n')
            : (isEditing
                ? "Core Technical Written Test\nPractical Hardware/Simulation Round\nTechnical & HR Interview"
                : ""));

    final detailsCtrl = TextEditingController(
        text: initialDrive?['details'] ??
            (isEditing
                ? "Extra eligibility such as CGPA or backlogs, bond, location, what to bring."
                : ""));

    final registeredCtrl = TextEditingController(
        text: initialDrive?['registered'] != null
            ? '${initialDrive!['registered']}'
            : '0');
    final shortlistedCtrl = TextEditingController(
        text: initialDrive?['shortlisted'] != null
            ? '${initialDrive!['shortlisted']}'
            : '0');
    final offersCtrl = TextEditingController(
        text: initialDrive?['offers'] != null
            ? '${initialDrive!['offers']}'
            : '0');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with Title & Close 'X'
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isEditing ? "Edit drive" : "Schedule a drive",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 18),

                      // Row 1: Company & Role
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Company",
                          child: _buildTextField(
                            controller: companyCtrl,
                            hintText: "e.g. L&T Technology Services",
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Role",
                          child: _buildTextField(
                            controller: roleCtrl,
                            hintText: "Graduate Engineer Trainee",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 2: Drive type & Status
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Drive type",
                          child: _buildDropdown(
                            value: driveType,
                            items: const [
                              "On-campus",
                              "Virtual / Remote",
                              "Pool campus",
                              "Off-campus",
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => driveType = val);
                              }
                            },
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Status",
                          subtext:
                              "Draft is hidden from planning counts until you open it.",
                          child: _buildDropdown(
                            value: status,
                            items: const [
                              "Draft",
                              "Open",
                              "In-progress",
                              "Completed",
                              "Cancelled",
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => status = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 3: Drive date & Start time
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Drive date",
                          child: _buildTextField(
                            controller: driveDateCtrl,
                            hintText: "mm/dd/yyyy",
                            suffixIcon: Icons.calendar_today_outlined,
                            onSuffixTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2026, 11, 15),
                                firstDate: DateTime(2026, 1, 1),
                                lastDate: DateTime(2027, 12, 31),
                              );
                              if (picked != null) {
                                driveDateCtrl.text =
                                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                              }
                            },
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Start time (optional)",
                          child: _buildTextField(
                            controller: startTimeCtrl,
                            hintText: "--:-- --",
                            suffixIcon: Icons.access_time_rounded,
                            onSuffixTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 10, minute: 30),
                              );
                              if (picked != null && context.mounted) {
                                startTimeCtrl.text = picked.format(context);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 4: Venue & Register by
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Venue or meeting link (optional)",
                          child: _buildTextField(
                            controller: venueCtrl,
                            hintText: "Seminar Hall A",
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Register by (optional)",
                          child: _buildTextField(
                            controller: registerByCtrl,
                            hintText: "mm/dd/yyyy",
                            suffixIcon: Icons.calendar_today_outlined,
                            onSuffixTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2026, 11, 10),
                                firstDate: DateTime(2026, 1, 1),
                                lastDate: DateTime(2027, 12, 31),
                              );
                              if (picked != null) {
                                registerByCtrl.text =
                                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 5: Lowest package & Highest package
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Lowest package (LPA)",
                          child: _buildTextField(
                            controller: lowestSalaryCtrl,
                            hintText: "e.g. 5.5",
                            keyboardType: textInputKeyBoardNumber,
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Highest package (LPA)",
                          child: _buildTextField(
                            controller: highestSalaryCtrl,
                            hintText: "e.g. 8",
                            keyboardType: textInputKeyBoardNumber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 6: Openings & Minimum readiness total
                      _buildResponsiveRow(
                        left: _buildLabeledInput(
                          label: "Openings (optional)",
                          child: _buildTextField(
                            controller: openingsCtrl,
                            hintText: "e.g. 20",
                            keyboardType: textInputKeyBoardNumber,
                          ),
                        ),
                        right: _buildLabeledInput(
                          label: "Minimum readiness total",
                          subtext:
                              "0 to 100, from the Placement Readiness Board. Leave empty for no minimum.",
                          child: _buildTextField(
                            controller: readinessCtrl,
                            hintText: "e.g. 55",
                            keyboardType: textInputKeyBoardNumber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 7: Departments allowed (Multi-select tags)
                      Text(
                        "Departments allowed",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        selectedDepts.isEmpty
                            ? "None selected means every department is eligible."
                            : "${selectedDepts.length} selected.",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _allDepartments.map((dept) {
                          final isSelected = selectedDepts.contains(dept);
                          return InkWell(
                            onTap: () {
                              setModalState(() {
                                if (isSelected) {
                                  selectedDepts.remove(dept);
                                } else {
                                  selectedDepts.add(dept);
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFEEF2FF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF1E2865)
                                      : const Color(0xFFCBD5E1),
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Text(
                                dept,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1E2865)
                                      : const Color(0xFF475569),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Row 8: Selection rounds (optional)
                      _buildLabeledInput(
                        label: "Selection rounds (optional)",
                        subtext:
                            "One per line, in order, up to 8: Aptitude test, Technical interview, HR interview",
                        child: _buildTextField(
                          controller: roundsCtrl,
                          hintText:
                              "Aptitude test\nTechnical interview\nHR interview",
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 9: Details (optional) (Image 2)
                      _buildLabeledInput(
                        label: "Details (optional)",
                        subtext:
                            "Extra eligibility such as CGPA or backlogs, bond, location, what to bring.",
                        child: _buildTextField(
                          controller: detailsCtrl,
                          hintText:
                              "Extra eligibility such as CGPA or backlogs, bond, location...",
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 10: How it went card (Image 2)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBF8F2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFF2ECE1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How it went",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Fill these in after the drive. Shortlisted and offers cannot be more than registered.",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildLabeledInput(
                                    label: "Registered",
                                    child: _buildTextField(
                                      controller: registeredCtrl,
                                      hintText: "0",
                                      keyboardType: textInputKeyBoardNumber,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildLabeledInput(
                                    label: "Shortlisted",
                                    child: _buildTextField(
                                      controller: shortlistedCtrl,
                                      hintText: "0",
                                      keyboardType: textInputKeyBoardNumber,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildLabeledInput(
                                    label: "Offers",
                                    child: _buildTextField(
                                      controller: offersCtrl,
                                      hintText: "0",
                                      keyboardType: textInputKeyBoardNumber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Bottom Buttons: Cancel | Delete (if editing) | Save/Schedule
                      LayoutBuilder(
                        builder: (context, actionConstraints) {
                          final isNarrow = actionConstraints.maxWidth < 580;

                          void handleSave() {
                            final company = companyCtrl.text.trim();
                            final role = roleCtrl.text.trim();
                            if (company.isEmpty || role.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please enter company and role.",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            final lowest = lowestSalaryCtrl.text.trim();
                            final highest = highestSalaryCtrl.text.trim();
                            final salaryStr = (lowest.isNotEmpty &&
                                    highest.isNotEmpty)
                                ? "₹$lowest-$highest LPA"
                                : (highest.isNotEmpty
                                    ? "₹$highest LPA"
                                    : "Competitive");

                            final rawRounds = roundsCtrl.text.trim();
                            final roundsArr = rawRounds.isNotEmpty
                                ? rawRounds
                                    .split('\n')
                                    .where((r) => r.trim().isNotEmpty)
                                    .map((r) => r.trim())
                                    .toList()
                                : [
                                    "Core Technical Written Test",
                                    "Technical & HR Interview",
                                  ];

                            final minR =
                                int.tryParse(readinessCtrl.text.trim()) ?? 55;
                            final openingsNum =
                                int.tryParse(openingsCtrl.text.trim()) ?? 20;
                            final regCount =
                                int.tryParse(registeredCtrl.text.trim()) ?? 0;
                            final shortCount =
                                int.tryParse(shortlistedCtrl.text.trim()) ?? 0;
                            final offCount =
                                int.tryParse(offersCtrl.text.trim()) ?? 0;

                            setState(() {
                              if (isEditing) {
                                initialDrive['company'] = company;
                                initialDrive['role'] = role;
                                initialDrive['campusType'] = driveType;
                                initialDrive['status'] = status;
                                initialDrive['driveDateRaw'] =
                                    driveDateCtrl.text.trim();
                                initialDrive['date'] =
                                    driveDateCtrl.text.trim();
                                initialDrive['time'] =
                                    startTimeCtrl.text.trim();
                                initialDrive['location'] =
                                    venueCtrl.text.trim();
                                initialDrive['salary'] = salaryStr;
                                initialDrive['lowestSalary'] = lowest;
                                initialDrive['highestSalary'] = highest;
                                initialDrive['openings'] = openingsNum;
                                initialDrive['cutoff'] = "Readiness $minR+";
                                initialDrive['minReadiness'] = minR;
                                initialDrive['deadline'] =
                                    registerByCtrl.text.trim();
                                initialDrive['allowedDepts'] = selectedDepts;
                                initialDrive['branches'] =
                                    selectedDepts.isNotEmpty
                                        ? selectedDepts.join(', ')
                                        : "All Engineering Streams";
                                initialDrive['rounds'] = roundsArr;
                                initialDrive['details'] =
                                    detailsCtrl.text.trim();
                                initialDrive['registered'] = regCount;
                                initialDrive['shortlisted'] = shortCount;
                                initialDrive['offers'] = offCount;
                              } else {
                                _drives.insert(0, {
                                  "company": company,
                                  "status": status,
                                  "campusType": driveType,
                                  "role": role,
                                  "date": driveDateCtrl.text.trim(),
                                  "driveDateRaw": driveDateCtrl.text.trim(),
                                  "time": startTimeCtrl.text.trim(),
                                  "location": venueCtrl.text.trim().isNotEmpty
                                      ? venueCtrl.text.trim()
                                      : "Seminar Hall A",
                                  "salary": salaryStr,
                                  "lowestSalary": lowest,
                                  "highestSalary": highest,
                                  "openings": openingsNum,
                                  "eligibleCount": 0,
                                  "totalStudents": 14,
                                  "branches": selectedDepts.isNotEmpty
                                      ? selectedDepts.join(', ')
                                      : "All Engineering Streams",
                                  "allowedDepts": selectedDepts,
                                  "cutoff": "Readiness $minR+",
                                  "minReadiness": minR,
                                  "deadline": registerByCtrl.text.trim(),
                                  "registered": regCount,
                                  "shortlisted": shortCount,
                                  "offers": offCount,
                                  "description": detailsCtrl.text
                                          .trim()
                                          .isNotEmpty
                                      ? detailsCtrl.text.trim()
                                      : "Campus recruitment drive for $role.",
                                  "rounds": roundsArr,
                                  "details": detailsCtrl.text.trim(),
                                });
                              }
                            });

                            Navigator.pop(dialogCtx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded,
                                        color: Color(0xFF10B981), size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      isEditing
                                          ? "$company drive parameters updated."
                                          : "$company campus drive scheduled.",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.5),
                                    ),
                                  ],
                                ),
                                backgroundColor: const Color(0xFF0F172A),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          }

                          final saveBtn = ElevatedButton(
                            onPressed: handleSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isEditing ? "Save changes" : "Schedule drive",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );

                          final cancelBtn = OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          );

                          final deleteBtn = isEditing
                              ? TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(dialogCtx);
                                    _showDeleteDriveConfirmationDialog(
                                        initialDrive);
                                  },
                                  icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 16,
                                      color: Color(0xFFDC2626)),
                                  label: Text(
                                    "Delete drive",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFDC2626),
                                    ),
                                  ),
                                )
                              : null;

                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: cancelBtn),
                                    const SizedBox(width: 10),
                                    Expanded(child: saveBtn),
                                  ],
                                ),
                                if (deleteBtn != null) ...[
                                  const SizedBox(height: 8),
                                  Center(child: deleteBtn),
                                ],
                              ],
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (deleteBtn != null)
                                deleteBtn
                              else
                                const SizedBox.shrink(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  cancelBtn,
                                  const SizedBox(width: 12),
                                  saveBtn,
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
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
  // 2. ELIGIBLE STUDENTS MODAL (Matches Image 3)
  // ===========================================================================
  void _showEligibleStudentsDialog(Map<String, dynamic> drive) {
    final eligibleCount = drive['eligibleCount'] as int? ?? 0;
    final rounds = (drive['rounds'] as List?)?.cast<String>() ??
        [
          "Core Technical Written Test",
          "Practical Hardware/Simulation Round",
          "Technical & HR Interview",
        ];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.white,
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Company, Role & Close 'X'
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${drive['company']} · ${drive['role']}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogCtx),
                      icon: const Icon(Icons.close_rounded,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Status Badge & Metadata line (Image 3)
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: drive['status'] == 'Open'
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        drive['status'] as String? ?? 'Draft',
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: drive['status'] == 'Open'
                              ? const Color(0xFF15803D)
                              : const Color(0xFFD97706),
                        ),
                      ),
                    ),
                    Text(
                      "${drive['date']}  ·  ${drive['branches']}  ·  ${drive['cutoff']}",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description text
                Text(
                  drive['description'] as String? ??
                      "Core engineering campus drive targeting smart devices, automotive electronics, and industrial IoT solutions. Strong foundation in microcontrollers and C/C++ expected.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),

                // Selection round pills (Image 3)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(rounds.length, (idx) {
                    final r = rounds[idx];
                    final label = r.startsWith('${idx + 1}.')
                        ? r
                        : '${idx + 1}. $r';
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF8F2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF2ECE1)),
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF78350F),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // Section: Count & Download CSV Button
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    Text(
                      "$eligibleCount eligible students",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Downloading eligible students CSV...",
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 14),
                      label: Text(
                        "Download CSV",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        foregroundColor: const Color(0xFF475569),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Eligible list or Empty state with faint grid (Image 3)
                if (eligibleCount == 0) ...[
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomPaint(
                              painter: _FaintGridPainter(),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No students meet these rules",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Lower the readiness minimum or include more departments to widen the pool.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        _buildStudentRow(
                            "Sanjay Pillai", "IT (Sem 7)", "Readiness: 81%", true),
                        const Divider(height: 1, color: Color(0xFFE2E8F0)),
                        _buildStudentRow("Sneha Srinivasan", "CSE (Sem 7)",
                            "Readiness: 78%", true),
                        if (eligibleCount > 2) ...[
                          const Divider(height: 1, color: Color(0xFFE2E8F0)),
                          _buildStudentRow("Deepika Das", "EEE (Sem 7)",
                              "Readiness: 77%", true),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 14),

                // Masked Roll Number Disclaimer (Image 3)
                Text(
                  "Roll numbers are masked, as on the Placement Readiness Board. Eligibility uses departments and the readiness total only; add any other rule (such as CGPA) to the drive description.",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF94A3B8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. DELETE DRIVE CONFIRMATION MODAL (Matches Image 5)
  // ===========================================================================
  void _showDeleteDriveConfirmationDialog(Map<String, dynamic> drive) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.white,
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Title & Close 'X'
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delete this drive?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogCtx),
                      icon: const Icon(Icons.close_rounded,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(
                    height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 14),

                // Message (Image 5)
                Text(
                  "${drive['company']} · ${drive['role']} on ${drive['date']} will be removed, with its outcome counts. This cannot be undone. If the drive was called off, set its status to Cancelled instead.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF475569),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),

                // Action buttons: Cancel | Delete (Red)
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(dialogCtx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        final idx = _drives.indexOf(drive);
                        setState(() {
                          _drives.remove(drive);
                        });
                        Navigator.pop(dialogCtx);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${drive['company']} drive removed.",
                              style: GoogleFonts.poppins(),
                            ),
                            action: SnackBarAction(
                              label: "Undo",
                              textColor: const Color(0xFF38BDF8),
                              onPressed: () {
                                setState(() {
                                  if (idx >= 0 && idx <= _drives.length) {
                                    _drives.insert(idx, drive);
                                  } else {
                                    _drives.add(drive);
                                  }
                                });
                              },
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Delete",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
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

  // Helper row builder
  static Widget _buildResponsiveRow({
    required Widget left,
    required Widget right,
  }) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 460) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              const SizedBox(height: 14),
              right,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 14),
            Expanded(child: right),
          ],
        );
      },
    );
  }

  static Widget _buildLabeledInput({
    required String label,
    required Widget child,
    String? subtext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        child,
        if (subtext != null) ...[
          const SizedBox(height: 4),
          Text(
            subtext,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        color: const Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF94A3B8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, size: 16, color: const Color(0xFF64748B)),
              )
            : null,
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
          borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.4),
        ),
      ),
    );
  }

  static Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF0F172A),
          ),
          items: items
              .map((it) => DropdownMenuItem(
                    value: it,
                    child: Text(it),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  static const TextInputType textInputKeyBoardNumber =
      TextInputType.numberWithOptions(decimal: true);

  Widget _buildStudentRow(
      String name, String dept, String score, bool eligible) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF1E2865).withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E2865)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 12.5, fontWeight: FontWeight.w600)),
                Text(dept,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              score,
              style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF059669)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDrives = _drives.where((drive) {
      if (_selectedStatus != "All statuses" &&
          drive["status"] != _selectedStatus) {
        return false;
      }
      final query = _searchController.text.toLowerCase().trim();
      if (query.isNotEmpty) {
        final company = (drive["company"] as String).toLowerCase();
        final role = (drive["role"] as String).toLowerCase();
        final branches = (drive["branches"] as String).toLowerCase();
        if (!company.contains(query) &&
            !role.contains(query) &&
            !branches.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 16),
              _buildKpiStatRow(),
              const SizedBox(height: 16),
              _buildSearchAndFilterBar(),
              const SizedBox(height: 16),
              if (filteredDrives.isEmpty)
                _buildEmptyState()
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredDrives.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) =>
                      _buildDriveCard(filteredDrives[index]),
                ),
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
            Color(0xFF223075),
            Color(0xFF2E3D8F),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
          ),
          Positioned(
            right: -20,
            bottom: -30,
            child: Icon(
              Icons.business_center_rounded,
              size: 200,
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.onBack != null) ...[
                      IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(
                      'Home  ›  Placement  ›  Campus Drives',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'PLACEMENT',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD97706),
                        borderRadius: BorderRadius.circular(6),
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
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(
                        Icons.work_outline_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Placement Drives',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Schedule drives, track eligibility cutoffs, monitor registrations and manage student offers.',
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
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
    );
  }

  // ===========================================================================
  // 5 METRIC KPI STAT CARDS
  // ===========================================================================
  Widget _buildKpiStatRow() {
    final upcomingCount =
        _drives.where((d) => d["status"] != "Completed").length;
    final openCount = _drives.where((d) => d["status"] == "Open").length;
    final completedCount =
        _drives.where((d) => d["status"] == "Completed").length;
    final totalOffers = _drives.fold<int>(
        0, (sum, d) => sum + ((d["offers"] as int?) ?? 0));

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;
        final isTablet =
            constraints.maxWidth >= 540 && constraints.maxWidth < 960;

        final cards = [
          _buildStatCard(
            title: "Upcoming",
            value: "$upcomingCount",
            footer: "Drives scheduled",
            icon: Icons.calendar_month_rounded,
          ),
          _buildStatCard(
            title: "Open now",
            value: "$openCount",
            badgeText: "taking registrations",
            badgeBg: const Color(0xFFCCFBF1),
            badgeColor: const Color(0xFF0D9488),
            icon: Icons.how_to_reg_rounded,
          ),
          _buildStatCard(
            title: "Completed",
            value: "$completedCount",
            footer: "Drives held",
            icon: Icons.task_alt_rounded,
          ),
          _buildStatCard(
            title: "Offers",
            value: totalOffers > 0 ? "$totalOffers" : "46",
            badgeText: "HOD",
            badgeBg: const Color(0xFFEFF6FF),
            badgeColor: const Color(0xFF2563EB),
            footer: "Across completed drives",
            icon: Icons.stars_rounded,
          ),
          _buildStatCard(
            title: "Average package",
            value: "₹8 LPA",
            footer: "Completed drives, max ₹9.5 LPA",
            icon: Icons.monetization_on_outlined,
          ),
        ];

        if (isDesktop) {
          return Row(
            children: cards
                .map((c) => Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: c,
                    )))
                .toList(),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 8),
                Expanded(child: cards[1]),
                const SizedBox(width: 8),
                Expanded(child: cards[2]),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: cards[3]),
                const SizedBox(width: 8),
                Expanded(child: cards[4]),
              ]),
            ],
          );
        } else {
          return Column(
            children: cards
                .map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: c,
                    ))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? badgeText,
    Color? badgeBg,
    Color? badgeColor,
    String? footer,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (badgeText != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeBg ?? const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: badgeColor ?? const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (footer != null) ...[
            const SizedBox(height: 6),
            Text(
              footer,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // SEARCH & FILTER BAR
  // ===========================================================================
  Widget _buildSearchAndFilterBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;

        final searchInput = SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (val) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search,
                  size: 18, color: Color(0xFF94A3B8)),
              hintText: "Search drives by company, role or branch...",
              hintStyle: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF94A3B8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
        );

        final filterDropdown = Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCBD5E1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedStatus,
              isDense: true,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF64748B)),
              items: const [
                DropdownMenuItem(
                    value: "All statuses", child: Text("All statuses")),
                DropdownMenuItem(value: "Draft", child: Text("Draft")),
                DropdownMenuItem(value: "Open", child: Text("Open")),
                DropdownMenuItem(
                    value: "In-progress", child: Text("In-progress")),
                DropdownMenuItem(
                    value: "Completed", child: Text("Completed")),
                DropdownMenuItem(
                    value: "Cancelled", child: Text("Cancelled")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),
          ),
        );

        final scheduleBtn = ElevatedButton.icon(
          onPressed: _showScheduleDriveDialog,
          icon: const Icon(Icons.add_rounded, size: 16),
          label: Text(
            "Schedule drive",
            style: GoogleFonts.poppins(
                fontSize: 13, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    searchInput,
                    const Divider(height: 18, color: Color(0xFFF1F5F9)),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        filterDropdown,
                        scheduleBtn,
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: searchInput),
                    const SizedBox(width: 12),
                    filterDropdown,
                    const SizedBox(width: 12),
                    scheduleBtn,
                  ],
                ),
        );
      },
    );
  }

  // ===========================================================================
  // DRIVE CARD (Image 3 Background)
  // ===========================================================================
  Widget _buildDriveCard(Map<String, dynamic> drive) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Company, status badges, role & action buttons
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 16, top: 16, bottom: 8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 620;

                final infoColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          drive["company"],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: drive["status"] == "Open"
                                ? const Color(0xFFDCFCE7)
                                : (drive["status"] == "Draft"
                                    ? const Color(0xFFFEF3C7)
                                    : const Color(0xFFF1F5F9)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            drive["status"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: drive["status"] == "Open"
                                  ? const Color(0xFF15803D)
                                  : (drive["status"] == "Draft"
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFF475569)),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            drive["campusType"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drive["role"],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                );

                final actionButtons = SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _showEligibleStudentsDialog(drive),
                        icon: const Icon(Icons.people_alt_outlined, size: 16),
                        label: Text(
                          "Eligible students",
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined,
                            size: 18, color: Color(0xFF64748B)),
                        onPressed: () => _showEditDriveDialog(drive),
                        tooltip: "Edit drive",
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 18, color: Color(0xFF64748B)),
                        onPressed: () =>
                            _showDeleteDriveConfirmationDialog(drive),
                        tooltip: "Delete drive",
                      ),
                    ],
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoColumn,
                      const SizedBox(height: 12),
                      actionButtons,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: infoColumn),
                    const SizedBox(width: 12),
                    actionButtons,
                  ],
                );
              },
            ),
          ),

          // Date, time, location & salary metadata row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Wrap(
              spacing: 20,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildMetaItem(Icons.calendar_month_outlined, drive["date"]),
                _buildMetaItem(Icons.access_time_rounded, drive["time"]),
                _buildMetaItem(Icons.location_on_outlined, drive["location"]),
                _buildMetaItem(
                  Icons.currency_rupee_rounded,
                  drive["salary"],
                  isBold: true,
                  color: const Color(0xFF0F172A),
                ),
              ],
            ),
          ),

          const Divider(height: 16, color: Color(0xFFF1F5F9)),

          // Bottom Eligibility, cutoff & registration deadline section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 620;

                final leftEligibility = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${drive['eligibleCount']} of ${drive['totalStudents']} students eligible",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0D9488),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "•  ${drive['cutoff']}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drive["branches"],
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final rightDeadline = Text(
                  drive["deadline"],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFD97706),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      leftEligibility,
                      const SizedBox(height: 10),
                      rightDeadline,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: leftEligibility),
                    const SizedBox(width: 14),
                    rightDeadline,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String text,
      {bool isBold = false, Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color ?? const Color(0xFF64748B)),
        const SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: color ?? const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // Empty state when search or filter returns no results
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded,
                size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 14),
            Text(
              "No placement drives found",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting your search terms or filter status.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
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
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;

    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// FAINT GRID PAINTER FOR ELIGIBLE STUDENTS EMPTY STATE (Image 3)
// =============================================================================
class _FaintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6)
      ..strokeWidth = 0.8;

    const step = 20.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
