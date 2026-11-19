import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT OFFICER: JOB MATCHING & CORPORATE OPENINGS
// Matches Screenshots 1, 2, 3 & 4:
// - Hero Blueprint banner: Home > Placement > Job Matching (PLACEMENT, MVP badges)
// - Section Header: Job Matching & Corporate Openings (● Live Matched)
//     Actions: Sync Matches, + Post Corporate Opening
// - 5 KPI Metric Cards:
//     1. Active Openings: 13 (1 corporate · 10 drives)
//     2. Eligible Matches: 7 (Cohort candidate opportunities)
//     3. Partner Employers: 12 (Registered hiring partners)
//     4. Highest CTC: ₹32.5 LPA (Peak annual compensation)
//     5. Average CTC: ₹14.5 LPA (Median cohort benchmark)
// - Filter Bar:
//     - Search input: "Search by company, role title, skills, or location..."
//     - Category dropdown: All Categories, Full-Time Corporate, Internship, Campus Drive
//     - Department dropdown (Image 4): All Departments, CSE, IT, ECE, EEE, MECH, CIVIL, BME
//     - Package dropdown: All Packages, < ₹6 LPA, ₹6-10 LPA, ₹10-15 LPA, > ₹15 LPA
// - Responsive Job Cards Grid (Image 1):
//     - Company avatar, name, category badge (Campus Drive / Corporate Opening), package, role, openings
//     - Description paragraph
//     - Metadata tags: location, deadline, min readiness, min CGPA
//     - Candidate Matching Cohort container: "1 candidates eligible" + Targeting list
//     - Action buttons: "View Matching (N)", "Export CSV"
// - Modal 1: Post Corporate Job Opening (Image 2):
//     - Company Name, Role Title, Category, Min/Max Package, Location, Total Openings,
//       Application Deadline, Eligible Departments (checkbox grid), Min Readiness, Min CGPA,
//       Key Skills, Job Description, Cancel & Publish Job Opening
// - Modal 2: Matching Candidates (Image 3):
//     - Criteria: Min Readiness Score ≥ X · Min CGPA ≥ Y, N candidates meet eligibility rules
//     - Search filter: "Filter student name, roll n"
//     - Download CSV button
//     - Table: Student Name, Roll No, Department, Readiness, CGPA, ATS Resume, Status
//     - Showing 1 of 1 candidates, Close button
// =============================================================================

class PlacementJobMatchingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementJobMatchingScreen({super.key, this.onBack});

  @override
  State<PlacementJobMatchingScreen> createState() =>
      _PlacementJobMatchingScreenState();
}

class _PlacementJobMatchingScreenState
    extends State<PlacementJobMatchingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All Categories";
  String _selectedDepartment = "All Departments";
  String _selectedPackage = "All Packages";

  // Pre-configured students cohort for realistic live matching
  final List<Map<String, dynamic>> _studentsPool = [
    {
      "name": "Anand Kumar",
      "roll": "110124001",
      "dept": "Computer Science & Engineering",
      "readiness": 69,
      "cgpa": 7.8,
      "ats": "72%",
      "status": "Almost ready",
      "statusBg": 0xFFFEF3C7,
      "statusColor": 0xFFD97706,
    },
    {
      "name": "Priya Sharma",
      "roll": "110124018",
      "dept": "Information Technology",
      "readiness": 74,
      "cgpa": 8.4,
      "ats": "85%",
      "status": "Ready",
      "statusBg": 0xFFDCFCE7,
      "statusColor": 0xFF15803D,
    },
    {
      "name": "Karthik Raja",
      "roll": "110124045",
      "dept": "Electronics & Communication Engineering",
      "readiness": 62,
      "cgpa": 7.2,
      "ats": "68%",
      "status": "In progress",
      "statusBg": 0xFFE0E7FF,
      "statusColor": 0xFF4338CA,
    },
    {
      "name": "Divya M",
      "roll": "110124032",
      "dept": "Computer Science & Engineering",
      "readiness": 78,
      "cgpa": 8.9,
      "ats": "88%",
      "status": "Placement Ready",
      "statusBg": 0xFFDCFCE7,
      "statusColor": 0xFF15803D,
    },
    {
      "name": "Rahul V",
      "roll": "110124056",
      "dept": "Mechanical Engineering",
      "readiness": 54,
      "cgpa": 6.8,
      "ats": "60%",
      "status": "Needs attention",
      "statusBg": 0xFFFEE2E2,
      "statusColor": 0xFFDC2626,
    },
    {
      "name": "Sneha P",
      "roll": "110124077",
      "dept": "Civil Engineering",
      "readiness": 52,
      "cgpa": 6.5,
      "ats": "58%",
      "status": "Needs attention",
      "statusBg": 0xFFFEE2E2,
      "statusColor": 0xFFDC2626,
    },
    {
      "name": "Vignesh K",
      "roll": "110124089",
      "dept": "Biomedical Engineering",
      "readiness": 66,
      "cgpa": 7.5,
      "ats": "70%",
      "status": "Almost ready",
      "statusBg": 0xFFFEF3C7,
      "statusColor": 0xFFD97706,
    },
  ];

  // Active Job Openings List (Initial values match Screenshot 1)
  late List<Map<String, dynamic>> _jobOpenings;

  @override
  void initState() {
    super.initState();
    _jobOpenings = [
      {
        "id": "tcs-digital",
        "avatar": "TAT",
        "company": "Tata Consultancy Services (TCS)",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹7-9.5 LPA",
        "minSalary": 7.0,
        "maxSalary": 9.5,
        "role": "Digital Innovator & Prime Engineer",
        "openings": 45,
        "description":
            "TCS Digital and Prime cadence hiring drive. High-performing students selected across enterprise modernization, AI, and cybersecurity initiatives.",
        "location": "Auditorium & Distributed Labs",
        "deadline": "2026-09-10",
        "minReadiness": 50,
        "minCgpa": 6.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Electronics & Communication Engineering",
          "Mechanical Engineering",
          "Civil Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Electronics & Communication, Mechanical Engineering, Civil Engineering",
        "skills": "Java, Python, Cloud Fundamentals, Data Structures",
      },
      {
        "id": "zoho-sde",
        "avatar": "ZOH",
        "company": "Zoho Corporation",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹6.5-9 LPA",
        "minSalary": 6.5,
        "maxSalary": 9.0,
        "role": "Software Engineer",
        "openings": 25,
        "description":
            "Comprehensive product development role. Primary focus on problem solving, C/Java proficiency, and web application architecture.",
        "location": "Main Computing Center",
        "deadline": "2026-09-24",
        "minReadiness": 60,
        "minCgpa": 6.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Electronics & Communication Engineering",
          "Mechanical Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Electronics & Communication, Mechanical Engineering",
        "skills": "C, Java, Data Structures, Web Technologies",
      },
      {
        "id": "google-cloud",
        "avatar": "GOO",
        "company": "Google India",
        "badge": "Full-Time Corporate",
        "category": "Full-Time Corporate",
        "package": "₹28-32.5 LPA",
        "minSalary": 28.0,
        "maxSalary": 32.5,
        "role": "Cloud Solutions Architect Trainee",
        "openings": 8,
        "description":
            "Join Google Cloud engineering team to build next-generation distributed systems, Kubernetes orchestration, and AI-driven infrastructure platforms.",
        "location": "Bengaluru / Hybrid",
        "deadline": "2026-11-15",
        "minReadiness": 75,
        "minCgpa": 7.5,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology",
        "skills": "Go, Python, Distributed Systems, Kubernetes, Cloud",
      },
      {
        "id": "amazon-aws",
        "avatar": "AMA",
        "company": "Amazon AWS",
        "badge": "Full-Time Corporate",
        "category": "Full-Time Corporate",
        "package": "₹22-26 LPA",
        "minSalary": 22.0,
        "maxSalary": 26.0,
        "role": "Associate Cloud & Systems Engineer",
        "openings": 15,
        "description":
            "Design highly resilient, scalable cloud architectures. Partner with tier-1 enterprise customers implementing serverless event-driven systems.",
        "location": "Hyderabad / Remote",
        "deadline": "2026-10-30",
        "minReadiness": 70,
        "minCgpa": 7.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
          "Electronics & Communication Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology, Electronics & Communication Engineering",
        "skills": "AWS Lambda, Python, Java, Networking, Docker",
      },
      {
        "id": "lt-embedded",
        "avatar": "L&T",
        "company": "L&T Technology Services",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹5.5-8 LPA",
        "minSalary": 5.5,
        "maxSalary": 8.0,
        "role": "Embedded Systems & IoT Engineer",
        "openings": 20,
        "description":
            "Design embedded firmware, RTOS drivers, and automotive telemetry sensors for smart mobility and industrial aerospace applications.",
        "location": "Seminar Hall A",
        "deadline": "2026-11-10",
        "minReadiness": 55,
        "minCgpa": 6.5,
        "allowedDepts": [
          "Electronics & Communication Engineering",
          "Electrical & Electronics Engineering",
          "Mechanical Engineering",
        ],
        "targetingText":
            "Targeting: Electronics & Communication Engineering, Electrical & Electronics Engineering, Mechanical Engineering",
        "skills": "Embedded C, Microcontrollers, RTOS, CAN Protocol",
      },
      {
        "id": "infosys-sp",
        "avatar": "INF",
        "company": "Infosys Limited",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹6.2-9.5 LPA",
        "minSalary": 6.2,
        "maxSalary": 9.5,
        "role": "Specialist Programmer",
        "openings": 35,
        "description":
            "Elite coding cadre for rapid application prototyping, microservices modernization, and full-stack generative AI implementations.",
        "location": "CSE Computer Lab 1 & 2",
        "deadline": "2026-10-18",
        "minReadiness": 65,
        "minCgpa": 6.5,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology",
        "skills": "Data Structures, Algorithms, React, Node.js, Spring Boot",
      },
      {
        "id": "microsoft-azure",
        "avatar": "MSF",
        "company": "Microsoft India",
        "badge": "Full-Time Corporate",
        "category": "Full-Time Corporate",
        "package": "₹26-30 LPA",
        "minSalary": 26.0,
        "maxSalary": 30.0,
        "role": "Azure Core Systems Trainee",
        "openings": 10,
        "description":
            "Work on hyper-scale infrastructure underpinning Azure Core compute, network virtualization, and hardware acceleration clusters.",
        "location": "Bengaluru / Hybrid",
        "deadline": "2026-12-01",
        "minReadiness": 75,
        "minCgpa": 7.5,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology",
        "skills": "C++, Rust, Linux Kernel, Distributed Systems, Azure",
      },
      {
        "id": "cisco-network",
        "avatar": "CIS",
        "company": "Cisco Systems",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹12-16 LPA",
        "minSalary": 12.0,
        "maxSalary": 16.0,
        "role": "Associate Network Security Engineer",
        "openings": 12,
        "description":
            "Analyze software-defined networking paradigms, zero-trust cryptographic handshakes, and enterprise firewall rule engines.",
        "location": "Sir CV Raman Auditorium",
        "deadline": "2026-11-20",
        "minReadiness": 68,
        "minCgpa": 7.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
          "Electronics & Communication Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology, Electronics & Communication Engineering",
        "skills": "TCP/IP, Routing Protocols, Python, Wireshark, Linux",
      },
      {
        "id": "cognizant-dse",
        "avatar": "COG",
        "company": "Cognizant Technology Solutions",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹5.5-7.5 LPA",
        "minSalary": 5.5,
        "maxSalary": 7.5,
        "role": "Digital Specialist Engineer",
        "openings": 40,
        "description":
            "Develop modern responsive web applications, secure REST APIs, and automated cloud CI/CD delivery pipelines.",
        "location": "Academic Block 3 Halls",
        "deadline": "2026-10-25",
        "minReadiness": 55,
        "minCgpa": 6.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
          "Electronics & Communication Engineering",
          "Mechanical Engineering",
          "Civil Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology, Electronics & Communication Engineering, Mechanical Engineering, Civil Engineering",
        "skills": "Full-stack Web, SQL, Java, Git, Cloud Basics",
      },
      {
        "id": "qualcomm-vlsi",
        "avatar": "QCO",
        "company": "Qualcomm India",
        "badge": "Full-Time Corporate",
        "category": "Full-Time Corporate",
        "package": "₹18-22 LPA",
        "minSalary": 18.0,
        "maxSalary": 22.0,
        "role": "ASIC Design & Verification Trainee",
        "openings": 6,
        "description":
            "Perform SystemVerilog functional verification, UVM testbench authoring, and silicon timing closure for 5G Snapdragon silicon.",
        "location": "Chennai / On-site",
        "deadline": "2026-11-28",
        "minReadiness": 70,
        "minCgpa": 7.5,
        "allowedDepts": [
          "Electronics & Communication Engineering",
          "Electrical & Electronics Engineering",
        ],
        "targetingText":
            "Targeting: Electronics & Communication Engineering, Electrical & Electronics Engineering",
        "skills": "SystemVerilog, UVM, Digital Design, VHDL, Timing Analysis",
      },
      {
        "id": "wipro-turbo",
        "avatar": "WIP",
        "company": "Wipro Limited",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹6.5-8.5 LPA",
        "minSalary": 6.5,
        "maxSalary": 8.5,
        "role": "Turbo Next-Gen Engineer",
        "openings": 30,
        "description":
            "Accelerated talent stream building enterprise AI workflows, automated test suites, and SAP/Salesforce modern cloud integration.",
        "location": "Auditorium Annex",
        "deadline": "2026-10-12",
        "minReadiness": 55,
        "minCgpa": 6.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
          "Electronics & Communication Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology, Electronics & Communication Engineering",
        "skills": "Python, Java, Cloud, Data Structures, Automation",
      },
      {
        "id": "biomed-tech",
        "avatar": "BMT",
        "company": "HealthTech Diagnostics",
        "badge": "Full-Time Corporate",
        "category": "Full-Time Corporate",
        "package": "₹7-10 LPA",
        "minSalary": 7.0,
        "maxSalary": 10.0,
        "role": "Biomedical Equipment & Systems Engineer",
        "openings": 10,
        "description":
            "Calibrate clinical imaging instrumentation, biosensors, and telehealth edge devices complying with FDA regulatory quality systems.",
        "location": "Bengaluru / Medical Park",
        "deadline": "2026-12-10",
        "minReadiness": 60,
        "minCgpa": 6.5,
        "allowedDepts": [
          "Biomedical Engineering",
          "Electronics & Communication Engineering",
        ],
        "targetingText":
            "Targeting: Biomedical Engineering, Electronics & Communication Engineering",
        "skills": "Medical Instrumentation, Sensors, MATLAB, Signal Processing",
      },
      {
        "id": "hcl-cloud",
        "avatar": "HCL",
        "company": "HCLTech",
        "badge": "Campus Drive",
        "category": "Campus Drive",
        "package": "₹5-7 LPA",
        "minSalary": 5.0,
        "maxSalary": 7.0,
        "role": "Full Stack Cloud Trainee",
        "openings": 25,
        "description":
            "Build agile microservices, cloud telemetry pipelines, and enterprise user interfaces for global manufacturing clients.",
        "location": "Computing Lab 4",
        "deadline": "2026-11-05",
        "minReadiness": 50,
        "minCgpa": 6.0,
        "allowedDepts": [
          "Computer Science & Engineering",
          "Information Technology",
          "Mechanical Engineering",
          "Civil Engineering",
        ],
        "targetingText":
            "Targeting: Computer Science & Engineering, Information Technology, Mechanical Engineering, Civil Engineering",
        "skills": "JavaScript, React, SQL, Java, Agile Tools",
      },
    ];
  }

  // Calculate matching candidates for a job
  List<Map<String, dynamic>> _getMatchingCandidates(
      Map<String, dynamic> job) {
    final minR = job['minReadiness'] as int? ?? 50;
    final minC = (job['minCgpa'] as num?)?.toDouble() ?? 6.0;
    final allowed = (job['allowedDepts'] as List?)?.cast<String>() ?? [];

    return _studentsPool.where((student) {
      final sReadiness = student['readiness'] as int? ?? 0;
      final sCgpa = (student['cgpa'] as num?)?.toDouble() ?? 0.0;
      final sDept = student['dept'] as String? ?? '';

      final meetsReadiness = sReadiness >= minR;
      final meetsCgpa = sCgpa >= minC;
      final meetsDept = allowed.isEmpty || allowed.contains(sDept);

      return meetsReadiness && meetsCgpa && meetsDept;
    }).toList();
  }

  // ===========================================================================
  // MODAL 1: POST CORPORATE JOB OPENING (Matches Image 2)
  // ===========================================================================
  void _showPostCorporateOpeningDialog() {
    final companyCtrl = TextEditingController();
    final roleCtrl = TextEditingController();
    String category = "Full-Time Corporate";
    final minSalaryCtrl = TextEditingController(text: "7");
    final maxSalaryCtrl = TextEditingController(text: "12");
    final locationCtrl = TextEditingController(text: "Bengaluru / Hybrid");
    final openingsCtrl = TextEditingController(text: "20");
    final deadlineCtrl = TextEditingController(text: "12/07/2026");

    final minReadinessCtrl = TextEditingController(text: "65");
    final minCgpaCtrl = TextEditingController(text: "6.5");
    final skillsCtrl = TextEditingController(
        text: "Data Structures, SQL, Python, Problem Solving");
    final descCtrl = TextEditingController(
        text:
            "Work on high-throughput microservices, scalable distributed databases, and customer-facing cloud APIs. Competitive compensation with fast-track performance appraisals.");

    final List<String> allDepts = [
      "Computer Science & Engineering",
      "Information Technology",
      "Electronics & Communication Engineering",
      "Electrical & Electronics Engineering",
      "Mechanical Engineering",
      "Civil Engineering",
      "Biomedical Engineering",
    ];

    final Set<String> selectedDepts = {
      "Computer Science & Engineering",
      "Information Technology",
    };

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
                constraints: const BoxConstraints(maxWidth: 700),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Post Corporate Job Opening",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
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
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 18),

                      // Row 1: Company Name & Role Title (Image 2)
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "Company Name *",
                          child: _buildTextField(
                            controller: companyCtrl,
                            hintText: "e.g. Google India, Infosys, Zoho",
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "Role Title *",
                          child: _buildTextField(
                            controller: roleCtrl,
                            hintText: "e.g. Software Development Engineer",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 2: Category, Min Package, Max Package (Image 2)
                      LayoutBuilder(
                        builder: (context, c) {
                          if (c.maxWidth < 500) {
                            return Column(
                              children: [
                                _buildFieldLabel(
                                  label: "Category",
                                  child: _buildCategoryDropdown(
                                    value: category,
                                    onChanged: (val) {
                                      if (val != null) {
                                        setModalState(() => category = val);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Min Package (LPA)",
                                        child: _buildTextField(
                                          controller: minSalaryCtrl,
                                          hintText: "7",
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Max Package (LPA)",
                                        child: _buildTextField(
                                          controller: maxSalaryCtrl,
                                          hintText: "12",
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildFieldLabel(
                                  label: "Category",
                                  child: _buildCategoryDropdown(
                                    value: category,
                                    onChanged: (val) {
                                      if (val != null) {
                                        setModalState(() => category = val);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: _buildFieldLabel(
                                  label: "Min Package (LPA)",
                                  child: _buildTextField(
                                    controller: minSalaryCtrl,
                                    hintText: "7",
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: _buildFieldLabel(
                                  label: "Max Package (LPA)",
                                  child: _buildTextField(
                                    controller: maxSalaryCtrl,
                                    hintText: "12",
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Row 3: Location, Total Openings, Application Deadline
                      LayoutBuilder(
                        builder: (context, c) {
                          if (c.maxWidth < 500) {
                            return Column(
                              children: [
                                _buildFieldLabel(
                                  label: "Location",
                                  child: _buildTextField(
                                    controller: locationCtrl,
                                    hintText: "Bengaluru / Hybrid",
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Total Openings",
                                        child: _buildTextField(
                                          controller: openingsCtrl,
                                          hintText: "20",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Application Deadline",
                                        child: _buildTextField(
                                          controller: deadlineCtrl,
                                          hintText: "12/07/2026",
                                          suffixIcon:
                                              Icons.calendar_today_outlined,
                                          onSuffixTap: () async {
                                            final d = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now().add(
                                                  const Duration(days: 30)),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 365)),
                                            );
                                            if (d != null) {
                                              deadlineCtrl.text =
                                                  "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildFieldLabel(
                                  label: "Location",
                                  child: _buildTextField(
                                    controller: locationCtrl,
                                    hintText: "Bengaluru / Hybrid",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: _buildFieldLabel(
                                  label: "Total Openings",
                                  child: _buildTextField(
                                    controller: openingsCtrl,
                                    hintText: "20",
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: _buildFieldLabel(
                                  label: "Application Deadline",
                                  child: _buildTextField(
                                    controller: deadlineCtrl,
                                    hintText: "12/07/2026",
                                    suffixIcon: Icons.calendar_today_outlined,
                                    onSuffixTap: () async {
                                      final d = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now()
                                            .add(const Duration(days: 30)),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)),
                                      );
                                      if (d != null) {
                                        deadlineCtrl.text =
                                            "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 18),

                      // Row 4: Eligible Departments * (Checkbox Grid matching Image 2)
                      Text(
                        "Eligible Departments *",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      LayoutBuilder(
                        builder: (context, c) {
                          final columns = c.maxWidth < 450 ? 1 : (c.maxWidth < 620 ? 2 : 3);
                          final itemWidth = (c.maxWidth - (columns - 1) * 12) / columns;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: allDepts.map((dept) {
                              final isChecked = selectedDepts.contains(dept);
                              return SizedBox(
                                width: itemWidth,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    setModalState(() {
                                      if (isChecked) {
                                        selectedDepts.remove(dept);
                                      } else {
                                        selectedDepts.add(dept);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Checkbox(
                                            value: isChecked,
                                            activeColor:
                                                const Color(0xFF2563EB),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            onChanged: (val) {
                                              setModalState(() {
                                                if (val == true) {
                                                  selectedDepts.add(dept);
                                                } else {
                                                  selectedDepts.remove(dept);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            dept,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF334155),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 18),

                      // Row 5: Min Readiness Score & Min CGPA
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "Min Readiness Score (0-100)",
                          child: _buildTextField(
                            controller: minReadinessCtrl,
                            hintText: "65",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "Min CGPA (0-10)",
                          child: _buildTextField(
                            controller: minCgpaCtrl,
                            hintText: "6.5",
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 6: Key Skills (comma-separated)
                      _buildFieldLabel(
                        label: "Key Skills (comma-separated)",
                        child: _buildTextField(
                          controller: skillsCtrl,
                          hintText:
                              "Data Structures, SQL, Python, Problem Solving",
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 7: Job Description & Responsibilities
                      _buildFieldLabel(
                        label: "Job Description & Responsibilities",
                        child: _buildTextField(
                          controller: descCtrl,
                          hintText:
                              "Work on high-throughput microservices, scalable distributed databases, and customer-facing cloud APIs. Competitive compensation with fast-track performance appraisals.",
                          maxLines: 4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action buttons: Cancel & Publish Job Opening (Image 2)
                      LayoutBuilder(
                        builder: (context, actionBox) {
                          final isNarrow = actionBox.maxWidth < 440;

                          void handlePublish() {
                            final comp = companyCtrl.text.trim();
                            final role = roleCtrl.text.trim();
                            if (comp.isEmpty || role.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please provide company name and role title.",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            final minS =
                                double.tryParse(minSalaryCtrl.text.trim()) ??
                                    7.0;
                            final maxS =
                                double.tryParse(maxSalaryCtrl.text.trim()) ??
                                    12.0;
                            final minR =
                                int.tryParse(minReadinessCtrl.text.trim()) ??
                                    65;
                            final minC =
                                double.tryParse(minCgpaCtrl.text.trim()) ?? 6.5;
                            final ops =
                                int.tryParse(openingsCtrl.text.trim()) ?? 20;

                            final avatar = comp.length >= 3
                                ? comp.substring(0, 3).toUpperCase()
                                : comp.toUpperCase();

                            final allowedList = selectedDepts.toList();
                            final targetingStr = allowedList.isNotEmpty
                                ? "Targeting: ${allowedList.join(', ')}"
                                : "Targeting: All Departments";

                            setState(() {
                              _jobOpenings.insert(0, {
                                "id": "job-${DateTime.now().millisecondsSinceEpoch}",
                                "avatar": avatar,
                                "company": comp,
                                "badge": category,
                                "category": category,
                                "package": "₹$minS-$maxS LPA",
                                "minSalary": minS,
                                "maxSalary": maxS,
                                "role": role,
                                "openings": ops,
                                "description": descCtrl.text.trim(),
                                "location": locationCtrl.text.trim().isNotEmpty
                                    ? locationCtrl.text.trim()
                                    : "Bengaluru / Hybrid",
                                "deadline": deadlineCtrl.text.trim().isNotEmpty
                                    ? deadlineCtrl.text.trim()
                                    : "12/07/2026",
                                "minReadiness": minR,
                                "minCgpa": minC,
                                "allowedDepts": allowedList,
                                "targetingText": targetingStr,
                                "skills": skillsCtrl.text.trim(),
                              });
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
                                      "Corporate opening for $comp published live.",
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

                          final cancelBtn = OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          );

                          final publishBtn = ElevatedButton(
                            onPressed: handlePublish,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Publish Job Opening",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );

                          if (isNarrow) {
                            return Row(
                              children: [
                                Expanded(child: cancelBtn),
                                const SizedBox(width: 10),
                                Expanded(child: publishBtn),
                              ],
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              cancelBtn,
                              const SizedBox(width: 12),
                              publishBtn,
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
  // MODAL 2: MATCHING CANDIDATES (Matches Image 3)
  // ===========================================================================
  void _showMatchingCandidatesDialog(Map<String, dynamic> job) {
    final candidateFilterCtrl = TextEditingController();
    final allCandidates = _getMatchingCandidates(job);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filterQuery = candidateFilterCtrl.text.toLowerCase().trim();
            final filteredCandidates = allCandidates.where((c) {
              if (filterQuery.isEmpty) return true;
              final name = (c['name'] as String).toLowerCase();
              final roll = (c['roll'] as String).toLowerCase();
              final dept = (c['dept'] as String).toLowerCase();
              return name.contains(filterQuery) ||
                  roll.contains(filterQuery) ||
                  dept.contains(filterQuery);
            }).toList();

            final minR = job['minReadiness'] ?? 50;
            final minC = job['minCgpa'] ?? 6.0;

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Matching Candidates — ${job['company']} (${job['role']})",
                              style: GoogleFonts.poppins(
                                fontSize: 16.5,
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
                      const SizedBox(height: 14),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 16),

                      // Criteria row with Search & CSV Download button (Image 3)
                      LayoutBuilder(
                        builder: (context, c) {
                          final isNarrow = c.maxWidth < 620;

                          final criteriaWidget = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Criteria: Min Readiness Score ≥ $minR · Min CGPA ≥ $minC",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${allCandidates.length} candidates meet eligibility rules",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ],
                          );

                          final actionsWidget = Row(
                            mainAxisSize:
                                isNarrow ? MainAxisSize.max : MainAxisSize.min,
                            children: [
                              if (isNarrow)
                                Expanded(
                                  child: SizedBox(
                                    height: 38,
                                    child: TextField(
                                      controller: candidateFilterCtrl,
                                      onChanged: (_) => setModalState(() {}),
                                      style: GoogleFonts.poppins(fontSize: 12),
                                      decoration: InputDecoration(
                                        hintText: "Filter student name, roll n",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            color: const Color(0xFF94A3B8)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFE2E8F0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFE2E8F0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  width: 190,
                                  height: 38,
                                  child: TextField(
                                    controller: candidateFilterCtrl,
                                    onChanged: (_) => setModalState(() {}),
                                    style: GoogleFonts.poppins(fontSize: 12),
                                    decoration: InputDecoration(
                                      hintText: "Filter student name, roll n",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          color: const Color(0xFF94A3B8)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFE2E8F0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFE2E8F0)),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Downloading matching candidates CSV for ${job['company']}...",
                                        style: GoogleFonts.poppins(),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.file_download_outlined,
                                    size: 16),
                                label: Text(
                                  "Download CSV",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E2865),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                ),
                              ),
                            ],
                          );

                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                criteriaWidget,
                                const SizedBox(height: 12),
                                actionsWidget,
                              ],
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              criteriaWidget,
                              actionsWidget,
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Candidates Table (Image 3)
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 780),
                              child: SingleChildScrollView(
                                child: DataTable(
                                  headingRowColor: WidgetStateProperty.all(
                                      const Color(0xFFF8FAFC)),
                                  headingRowHeight: 44,
                                  dataRowMinHeight: 48,
                                  dataRowMaxHeight: 56,
                                  horizontalMargin: 16,
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Student Name",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Roll No",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Department",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Readiness",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "CGPA",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "ATS Resume",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Status",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF475569),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: filteredCandidates.map((c) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            c['name'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            c['roll'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF475569),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            c['dept'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF334155),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${c['readiness']}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF059669),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "${c['cgpa']}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            c['ats'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: const Color(0xFF475569),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Color(c['statusBg']),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              c['status'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Color(c['statusColor']),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Footer: Showing count & Close button (Image 3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Showing ${filteredCandidates.length} of ${allCandidates.length} candidates",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Close",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase().trim();

    final filteredJobs = _jobOpenings.where((job) {
      if (_selectedCategory != "All Categories" &&
          job["category"] != _selectedCategory) {
        return false;
      }

      if (_selectedDepartment != "All Departments") {
        final allowed =
            (job["allowedDepts"] as List?)?.cast<String>() ?? [];
        if (!allowed.contains(_selectedDepartment)) {
          return false;
        }
      }

      if (_selectedPackage != "All Packages") {
        final minS = (job["minSalary"] as num?)?.toDouble() ?? 0.0;
        final maxS = (job["maxSalary"] as num?)?.toDouble() ?? 0.0;
        if (_selectedPackage == "< ₹6 LPA" && minS >= 6.0) return false;
        if (_selectedPackage == "₹6-10 LPA" && (maxS < 6.0 || minS > 10.0)) {
          return false;
        }
        if (_selectedPackage == "₹10-15 LPA" &&
            (maxS < 10.0 || minS > 15.0)) {
          return false;
        }
        if (_selectedPackage == "> ₹15 LPA" && maxS < 15.0) return false;
      }

      if (query.isNotEmpty) {
        final comp = (job["company"] as String).toLowerCase();
        final role = (job["role"] as String).toLowerCase();
        final skills = (job["skills"] as String? ?? '').toLowerCase();
        final loc = (job["location"] as String? ?? '').toLowerCase();
        if (!comp.contains(query) &&
            !role.contains(query) &&
            !skills.contains(query) &&
            !loc.contains(query)) {
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
              // Top Hero Blueprint Banner (Image 1)
              _buildTopHeroBanner(),
              const SizedBox(height: 20),

              // Section Header: Job Matching & Corporate Openings (● Live Matched) (Image 1)
              _buildSectionHeader(),
              const SizedBox(height: 18),

              // 5 Metric KPI Cards (Image 1)
              _buildMetricCardsRow(),
              const SizedBox(height: 18),

              // Filter Row: Search, All Categories, All Departments, All Packages (Image 1 & 4)
              _buildFilterRow(),
              const SizedBox(height: 18),

              // Job Cards Grid (Image 1)
              if (filteredJobs.isEmpty)
                _buildEmptyState()
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMultiColumn = constraints.maxWidth >= 900;
                    if (isMultiColumn) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 335,
                        ),
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, idx) =>
                            _buildJobCard(filteredJobs[idx]),
                      );
                    }
                    return Column(
                      children: filteredJobs
                          .map((job) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _buildJobCard(job),
                              ))
                          .toList(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BLUEPRINT BANNER (Matches Image 1)
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
              Icons.handshake_outlined,
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
                    Expanded(
                      child: Text(
                        'Home  ›  Placement  ›  Job Matching',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2865),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        'PLACEMENT',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'MVP',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFF59E0B)
                                .withValues(alpha: 0.4)),
                      ),
                      child: const Icon(
                        Icons.handshake_outlined,
                        color: Color(0xFFFBBF24),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Job Matching',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Open roles matched to verified student profiles and eligibility.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.8),
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
  // SECTION HEADER: TITLE & ACTIONS (Matches Image 1)
  // ===========================================================================
  Widget _buildSectionHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;

        final titleCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Job Matching & Corporate Openings",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF16A34A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Live Matched",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              "Corporate job listings dynamically mapped to student readiness benchmarks, skills, and eligibility.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        );

        final actionButtons = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Cohort matching refreshed across ${_studentsPool.length} verified candidate profiles.",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.sync_rounded, size: 16),
              label: Text(
                "Sync Matches",
                style: GoogleFonts.poppins(
                    fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF334155),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _showPostCorporateOpeningDialog,
              icon: const Icon(Icons.add, size: 16),
              label: Text(
                "Post Corporate Opening",
                style: GoogleFonts.poppins(
                    fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCol,
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: actionButtons,
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: titleCol),
            const SizedBox(width: 14),
            actionButtons,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 5 KPI METRIC CARDS (Matches Image 1)
  // ===========================================================================
  Widget _buildMetricCardsRow() {
    final activeOpenings = _jobOpenings.length;
    final corporateCount =
        _jobOpenings.where((j) => j['category'] != 'Campus Drive').length;
    final driveCount = _jobOpenings.length - corporateCount;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;
        final cardList = [
          _buildKpiCard(
            title: "Active Openings",
            value: "$activeOpenings",
            subtitle: "$corporateCount corporate · $driveCount drives",
            icon: Icons.business_center_rounded,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
          ),
          _buildKpiCard(
            title: "Eligible Matches",
            value: "7",
            subtitle: "Cohort candidate opportunities",
            icon: Icons.people_outline_rounded,
            iconBg: const Color(0xFFF0FDF4),
            iconColor: const Color(0xFF16A34A),
          ),
          _buildKpiCard(
            title: "Partner Employers",
            value: "12",
            subtitle: "Registered hiring partners",
            icon: Icons.badge_outlined,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
          ),
          _buildKpiCard(
            title: "Highest CTC",
            value: "₹32.5 LPA",
            subtitle: "Peak annual compensation",
            icon: Icons.trending_up_rounded,
            iconBg: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFD97706),
          ),
          _buildKpiCard(
            title: "Average CTC",
            value: "₹14.5 LPA",
            subtitle: "Median cohort benchmark",
            icon: Icons.auto_awesome_rounded,
            iconBg: const Color(0xFFFFF7ED),
            iconColor: const Color(0xFFEA580C),
          ),
        ];

        if (isMobile) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: cardList
                  .map((card) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(width: 175, child: card),
                      ))
                  .toList(),
            ),
          );
        }

        return Row(
          children: cardList
              .map((card) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: card,
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FILTER ROW: SEARCH, CATEGORY, DEPARTMENTS, PACKAGES (Matches Image 1 & 4)
  // ===========================================================================
  Widget _buildFilterRow() {
    final List<String> categories = [
      "All Categories",
      "Full-Time Corporate",
      "Internship",
      "Campus Drive",
    ];

    // Image 4 exact list
    final List<String> departments = [
      "All Departments",
      "Computer Science & Engineering",
      "Information Technology",
      "Electronics & Communication Engineering",
      "Electrical & Electronics Engineering",
      "Mechanical Engineering",
      "Civil Engineering",
      "Biomedical Engineering",
    ];

    final List<String> packages = [
      "All Packages",
      "< ₹6 LPA",
      "₹6-10 LPA",
      "₹10-15 LPA",
      "> ₹15 LPA",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 750;

          final searchField = TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: "Search by company, role title, skills, or location...",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF94A3B8)),
              prefixIcon: const Icon(Icons.search_rounded,
                  size: 18, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          );

          final filterPills = Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _buildFilterDropdown(
                value: _selectedCategory,
                items: categories,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              _buildFilterDropdown(
                value: _selectedDepartment,
                items: departments,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDepartment = val);
                },
              ),
              _buildFilterDropdown(
                value: _selectedPackage,
                items: packages,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedPackage = val);
                },
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                const Divider(height: 12, color: Color(0xFFF1F5F9)),
                filterPills,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: searchField),
              const SizedBox(width: 14),
              filterPills,
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
          selectedItemBuilder: (context) => items
              .map((it) => ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: Text(
                      it,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          items: items
              .map((it) => DropdownMenuItem(
                    value: it,
                    child: Text(
                      it,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // JOB CARD (Matches Image 1)
  // ===========================================================================
  Widget _buildJobCard(Map<String, dynamic> job) {
    final matchingCandidates = _getMatchingCandidates(job);
    final eligibleCount = matchingCandidates.length;

    return Container(
      padding: const EdgeInsets.all(18),
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
          // Header Row: Avatar, Company, Badge, Package
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                alignment: Alignment.center,
                child: Text(
                  job['avatar'] ?? 'COM',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          job['company'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            job['badge'],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job['role'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    job['package'],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "${job['openings']} openings",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description Paragraph
          Text(
            job['description'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),

          // Metadata Chips Row: Location, Deadline, Min Readiness, Min CGPA
          Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildMetaTag(Icons.location_on_outlined, job['location']),
              _buildMetaTag(
                  Icons.access_time_rounded, "Apply by ${job['deadline']}"),
              _buildMetaPill("Min Readiness: ${job['minReadiness']}"),
              _buildMetaPill("Min CGPA: ${job['minCgpa']}"),
            ],
          ),
          const SizedBox(height: 12),

          // Candidate Matching Cohort Box (Image 1)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBF8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF2ECE1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Candidate Matching Cohort",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "$eligibleCount candidates eligible",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  job['targetingText'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Action Buttons: View Matching (N) | Export CSV (Image 1)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => _showMatchingCandidatesDialog(job),
                icon: const Icon(Icons.people_outline_rounded, size: 15),
                label: Text(
                  "View Matching ($eligibleCount)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Exporting CSV for ${job['company']}...",
                        style: GoogleFonts.poppins(),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined, size: 15),
                label: Text(
                  "Export CSV",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaTag(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  // ===========================================================================
  // EMPTY STATE
  // ===========================================================================
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.search_off_rounded,
                size: 36, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),
          Text(
            "No Job Openings Found",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Try clearing your search query or switching department/category filters.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _selectedCategory = "All Categories";
                _selectedDepartment = "All Departments";
                _selectedPackage = "All Packages";
              });
            },
            child: Text(
              "Reset Filters",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FORM HELPERS
  // ===========================================================================
  static Widget _buildResponsiveRow({
    required Widget left,
    required Widget right,
  }) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 480) {
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

  static Widget _buildFieldLabel({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontSize: 12, color: const Color(0xFF94A3B8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, size: 18, color: const Color(0xFF64748B)),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
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
          borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
        ),
      ),
    );
  }

  static Widget _buildCategoryDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    const items = [
      "Full-Time Corporate",
      "Internship",
      "Campus Drive",
      "Remote Contract",
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          style: GoogleFonts.poppins(
              fontSize: 12.5, color: const Color(0xFF0F172A)),
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
