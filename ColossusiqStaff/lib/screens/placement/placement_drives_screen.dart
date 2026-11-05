import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: PLACEMENT DRIVES SCREEN
// Exactly matches Screenshot 3:
// - Blueprint grid hero banner with briefcase watermark, PLACEMENT and MVP badges
// - 5 Metric Stat Cards (Upcoming 4, Open now 3, Completed 2, Offers 46, Average package ₹8 LPA)
// - Search bar, "All statuses" dropdown, and "+ Schedule drive" button
// - List of detailed drive cards (Amazon AWS, Google India, Microsoft Corporation)
//   with company name, tags, role, datetime, location, salary package,
//   eligible count, branch list, readiness cutoff, deadline & registration flow
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

  final List<Map<String, dynamic>> _drives = [
    {
      "company": "Amazon AWS",
      "status": "Open",
      "campusType": "Pool campus",
      "role": "Associate Cloud Support Engineer",
      "date": "Sun, 18 Oct, 2026",
      "time": "11:00",
      "location": "Seminar Hall B & Online Proctoring",
      "salary": "₹12-18 LPA",
      "eligibleCount": 1,
      "totalStudents": 14,
      "branches": "Computer Science & Engineering, Electronics & Communication",
      "cutoff": "Readiness 65+",
      "deadline": "Register by Thu, 15 Oct, 2026",
      "registered": 54,
      "shortlisted": 0,
      "offers": 0,
    },
    {
      "company": "Google India",
      "status": "Open",
      "campusType": "On-campus",
      "role": "Software Development Engineer (SDE-1)",
      "date": "Sun, 25 Oct, 2026",
      "time": "09:30",
      "location": "Sir CV Raman Auditorium, Academic ...",
      "salary": "₹18-32.5 LPA",
      "eligibleCount": 2,
      "totalStudents": 14,
      "branches": "Computer Science & Engineering, Artificial Intelligence & Data Science",
      "cutoff": "Readiness 75+",
      "deadline": "Register by Thu, 22 Oct, 2026",
      "registered": 48,
      "shortlisted": 0,
      "offers": 0,
    },
    {
      "company": "Microsoft Corporation",
      "status": "Open",
      "campusType": "On-campus",
      "role": "Cloud Solution & DevOps Engineer",
      "date": "Thu, 5 Nov, 2026",
      "time": "10:00",
      "location": "Virtual Interview Suite & Lab 3",
      "salary": "₹16-26 LPA",
      "eligibleCount": 2,
      "totalStudents": 14,
      "branches": "Computer Science & Engineering, Electronics & Communication, Artificial Intelligence & Data Science",
      "cutoff": "Readiness 70+",
      "deadline": "Register by Sun, 1 Nov, 2026",
      "registered": 65,
      "shortlisted": 0,
      "offers": 0,
    },
    {
      "company": "Zoho Corporation",
      "status": "Open",
      "campusType": "On-campus",
      "role": "Software Development Engineer (SDE)",
      "date": "Sat, 24 Oct, 2026",
      "time": "10:00",
      "location": "CS Computer Lab 2 & 3 (Chennai / Tenkasi / Remote)",
      "salary": "₹8.4-12.0 LPA",
      "eligibleCount": 3,
      "totalStudents": 14,
      "branches": "All Engineering Streams",
      "cutoff": "Readiness 65+",
      "deadline": "Register by Tue, 20 Oct, 2026",
      "registered": 42,
      "shortlisted": 18,
      "offers": 0,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showScheduleDriveDialog() {
    final companyCtrl = TextEditingController();
    final roleCtrl = TextEditingController();
    final salaryCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Schedule Placement Drive",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: companyCtrl,
                decoration: const InputDecoration(
                  labelText: "Company Name",
                  hintText: "e.g. Cisco Systems",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roleCtrl,
                decoration: const InputDecoration(
                  labelText: "Job Designation",
                  hintText: "e.g. Software Engineer",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: salaryCtrl,
                decoration: const InputDecoration(
                  labelText: "Salary Package (LPA)",
                  hintText: "e.g. ₹12-16 LPA",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Placement drive scheduled successfully.",
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
            child: Text("Schedule Drive", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  void _showEligibleStudentsDialog(Map<String, dynamic> drive) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Eligible Students - ${drive['company']}",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Role: ${drive['role']} · Cutoff: ${drive['cutoff']}",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildStudentRow("Sanjay Pillai", "IT (Sem 7)", "Readiness: 81%", true),
                    const Divider(height: 16),
                    _buildStudentRow("Sneha Srinivasan", "CSE (Sem 7)", "Readiness: 78%", true),
                    const Divider(height: 16),
                    _buildStudentRow("Deepika Das", "EEE (Sem 7)", "Readiness: 77%", true),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
            ),
            child: Text("Close", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentRow(String name, String dept, String score, bool eligible) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: const Color(0xFF1E2865).withValues(alpha: 0.1),
          child: Text(
            name[0],
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF1E2865)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(dept, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
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
            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF059669)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDrives = _drives.where((drive) {
      if (_selectedStatus != "All statuses" && drive["status"] != _selectedStatus) {
        return false;
      }
      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final company = (drive["company"] as String).toLowerCase();
        final role = (drive["role"] as String).toLowerCase();
        return company.contains(query) || role.contains(query);
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
              const SizedBox(height: 20),
              _buildStatCardsRow(),
              const SizedBox(height: 20),
              _buildFilterAndActionRow(),
              const SizedBox(height: 16),
              ...filteredDrives.map((drive) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildDriveCard(drive),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Image 3)
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
            // Watermark briefcase outline on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.business_center_rounded,
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
                          'Placement',
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
                          'Placement Drives',
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
                          Icons.business_center_rounded,
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
                                      color: Colors.white.withValues(alpha: 0.25),
                                    ),
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
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
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
                              'Placement Drives',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Schedule and manage campus recruitment drives.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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
  // 5 METRIC STAT CARDS (Image 3)
  // ===========================================================================
  Widget _buildStatCardsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final cards = [
          _buildStatCard("Upcoming", "4", "Draft or open, not yet held"),
          _buildStatCard("Open now", "3", "Taking registrations"),
          _buildStatCard("Completed", "2", "Drives held"),
          _buildStatCard("Offers", "46", "Across all drives"),
          _buildStatCard("Average package", "₹8 LPA", "Completed drives, mid-point"),
        ];

        if (isWide) {
          return Row(
            children: cards
                .map((card) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: card,
                      ),
                    ))
                .toList(),
          );
        } else {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards
                .map((card) => SizedBox(
                      width: (constraints.maxWidth - 12) / 2,
                      child: card,
                    ))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildStatCard(String label, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FILTER & ACTION ROW (Image 3)
  // ===========================================================================
  Widget _buildFilterAndActionRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 680;

        final searchInput = Row(
          children: [
            const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                decoration: InputDecoration(
                  hintText: "Search placement drives...",
                  hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
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
              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF0F172A)),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
              items: const [
                DropdownMenuItem(value: "All statuses", child: Text("All statuses")),
                DropdownMenuItem(value: "Open", child: Text("Open")),
                DropdownMenuItem(value: "Upcoming", child: Text("Upcoming")),
                DropdownMenuItem(value: "Completed", child: Text("Completed")),
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
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
  // DRIVE CARD (Image 3)
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
            padding: const EdgeInsets.only(left: 20, right: 16, top: 16, bottom: 8),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            drive["status"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF15803D),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF64748B)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Editing ${drive['company']} drive parameters.", style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        tooltip: "Edit drive",
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFF64748B)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Delete confirmation for ${drive['company']}.", style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
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
                      const SizedBox(height: 10),
                      actionButtons,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: infoColumn),
                    const SizedBox(width: 8),
                    actionButtons,
                  ],
                );
              },
            ),
          ),

          // Meta row: Date, time, location, salary package
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    drive["date"],
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                  ),
                  const SizedBox(width: 18),
                  const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    drive["time"],
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                  ),
                  const SizedBox(width: 18),
                  const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    drive["location"],
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                  ),
                  const SizedBox(width: 18),
                  Text(
                    drive["salary"],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Bottom stats row: eligible students, branches, cutoff, deadline, registrations
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    "${drive['eligibleCount']} of ${drive['totalStudents']} students eligible",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    drive["branches"],
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      drive["cutoff"],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    drive["deadline"],
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Registered ${drive['registered']} → shortlisted ${drive['shortlisted']} → offers ${drive['offers']}",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
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
