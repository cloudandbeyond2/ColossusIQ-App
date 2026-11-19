import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: EMPLOYERS SCREEN
// Matches Screenshots 1, 2, 3, 4 & 5:
// - Blueprint grid hero banner with building watermark, PLACEMENT and MVP badges
// - 5 Metric KPI Cards:
//   1. Total Employers: 8, Registered corporate partners
//   2. Active Partners: 8, Tier-1, Preferred & Active
//   3. Tier-1 Partners: 4, Marquee corporate relationships
//   4. 3-Yr Total Hires: 374, Cumulative students hired
//   5. Average CTC: ₹14.6 LPA, Across hiring partners
// - Filter & Search Bar:
//   * Search input: "Search by company, contact person or location..."
//   * Dropdowns (Images 3, 4 & 5):
//       - All Sectors: IT & Software, Product & Tech, BFSI & Fintech, Consulting & Services,
//                      Core Engineering, Healthcare & Biotech, Manufacturing & Automotive
//       - All Tiers: Tier-1 Partner, Preferred Recruiter, Active, Prospect, Inactive
//       - All MoUs: Active MoU, Under Renewal, In Discussion, None
//   * Actions: Export CSV, + Add employer
// - Employer Cards (TCS, Zoho, Amazon, Google, Microsoft, Cisco, Cognizant, Infosys):
//   * Company name, Recruiter Tier & Sector badges
//   * Details button, Edit & Delete icons
//   * Location & Careers URL
//   * SPOC box with contact person, role, email, phone, LinkedIn
//   * 3-Yr Hires, Avg Package, Highest CTC stats
//   * MoU Status badge with valid date and Last/Next drive date
// - Add / Edit Corporate Recruiter Modal (Images 1 & 2):
//   * Header: Add Corporate Recruiter with close (✕)
//   * Company Name, Sector/Industry dropdown, Relationship Tier dropdown, Location/HQ
//   * Careers URL, MoU Status dropdown, MoU Validity datepicker, Next Scheduled Drive datepicker
//   * University Relations Contact beige card: Contact Person, Designation, Email, Phone, LinkedIn
//   * Historical Placement Statistics card: 3-Yr Total Hires, Average Package, Highest Package
//   * Relationship Notes & Feedback textarea
//   * Cancel and Add employer / Save changes buttons
// =============================================================================

class EmployersScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const EmployersScreen({super.key, this.onBack});

  @override
  State<EmployersScreen> createState() => _EmployersScreenState();
}

class _EmployersScreenState extends State<EmployersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSector = 'All Sectors';
  String _selectedTier = 'All Tiers';
  String _selectedMou = 'All MoUs';

  // Dropdown options matching Images 3, 4 & 5
  final List<String> _sectors = [
    'All Sectors',
    'IT & Software',
    'Product & Tech',
    'BFSI & Fintech',
    'Consulting & Services',
    'Core Engineering',
    'Healthcare & Biotech',
    'Manufacturing & Automotive',
  ];

  final List<String> _tiers = [
    'All Tiers',
    'Tier-1 Partner',
    'Preferred Recruiter',
    'Active',
    'Prospect',
    'Inactive',
  ];

  final List<String> _mous = [
    'All MoUs',
    'Active MoU',
    'Under Renewal',
    'In Discussion',
    'None',
  ];

  late List<Map<String, dynamic>> _employers;

  @override
  void initState() {
    super.initState();
    _employers = [
      {
        'id': 'tcs',
        'name': 'Tata Consultancy Services (TCS)',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Chennai, Tamil Nadu',
        'website': 'https://tcs.com/careers',
        'spocName': 'Suresh Raman',
        'spocRole': 'Regional Head - Campus Hiring',
        'spocEmail': 'suresh.raman@tcs.com',
        'spocPhone': '+91 94440 98765',
        'linkedIn': 'https://linkedin.com/in/suresh-raman',
        'threeYrHires': '142',
        'avgPackage': '₹8.2 LPA',
        'highestCtc': '₹11.0 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '08/31/2028',
        'lastDrive': 'Last drive: 15 Sept 2026',
        'nextDrive': '10/24/2026',
        'notes': 'Strong affinity for CSE and ECE students. Consistently hires in large numbers across Digital and Prime tracks.',
      },
      {
        'id': 'zoho',
        'name': 'Zoho Corporation',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Chennai, Tamil Nadu',
        'website': 'https://zoho.com/careers',
        'spocName': 'Priyadarshini K.',
        'spocRole': 'University Relations Specialist',
        'spocEmail': 'priyadarshini.k@zohocorp.com',
        'spocPhone': '+91 97910 23456',
        'linkedIn': 'https://linkedin.com/in/priyadarshini-k',
        'threeYrHires': '68',
        'avgPackage': '₹7.8 LPA',
        'highestCtc': '₹9.5 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '03/31/2028',
        'lastDrive': 'Last drive: 28 Sept 2026',
        'nextDrive': '11/15/2026',
        'notes': 'High focus on hands-on coding and problem solving in C/Java. Product-first mindset required.',
      },
      {
        'id': 'amazon',
        'name': 'Amazon AWS India',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Product & Tech',
        'location': 'Bengaluru, Karnataka',
        'website': 'https://amazon.jobs',
        'spocName': 'Pooja V. Nair',
        'spocRole': 'Campus Talent Acquisition Lead',
        'spocEmail': 'pooja-campus@amazon.com',
        'spocPhone': '+91 98401 22334',
        'linkedIn': 'https://linkedin.com/in/pooja-nair',
        'threeYrHires': '42',
        'avgPackage': '₹22.5 LPA',
        'highestCtc': '₹44.0 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '12/31/2027',
        'lastDrive': 'Last drive: 05 Oct 2026',
        'nextDrive': '12/01/2026',
        'notes': 'Leadership principles interview round is decisive. Targets top 5% coding talent.',
      },
      {
        'id': 'google',
        'name': 'Google India',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Product & Tech',
        'location': 'Bengaluru, Karnataka',
        'website': 'https://careers.google.com',
        'spocName': 'Anandita Sen',
        'spocRole': 'University Relations Lead',
        'spocEmail': 'anandita@google.com',
        'spocPhone': '+91 98840 12345',
        'linkedIn': 'https://linkedin.com/in/anandita-sen',
        'threeYrHires': '18',
        'avgPackage': '₹28.0 LPA',
        'highestCtc': '₹32.5 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '06/30/2029',
        'lastDrive': 'Last drive: 12 Aug 2026',
        'nextDrive': '11/20/2026',
        'notes': 'Google Cloud and Android core platforms. Requires strong algorithms and concurrency fundamentals.',
      },
      {
        'id': 'microsoft',
        'name': 'Microsoft India',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Product & Tech',
        'location': 'Hyderabad, Telangana',
        'website': 'https://careers.microsoft.com',
        'spocName': 'Vikramaditya Rao',
        'spocRole': 'Director - University Recruiting',
        'spocEmail': 'vikram.rao@microsoft.com',
        'spocPhone': '+91 99001 55667',
        'linkedIn': 'https://linkedin.com/in/vikram-rao',
        'threeYrHires': '24',
        'avgPackage': '₹24.0 LPA',
        'highestCtc': '₹38.0 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '10/31/2028',
        'lastDrive': 'Last drive: 22 Sept 2026',
        'nextDrive': '12/10/2026',
        'notes': 'Azure Core Systems and Office 365 services. Values system design and collaborative problem solving.',
      },
      {
        'id': 'cisco',
        'name': 'Cisco Systems',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Core Engineering',
        'location': 'Bengaluru, Karnataka',
        'website': 'https://cisco.com/careers',
        'spocName': 'Kavitha Balan',
        'spocRole': 'Lead Campus Specialist - APJC',
        'spocEmail': 'kavitha.b@cisco.com',
        'spocPhone': '+91 91760 33445',
        'linkedIn': 'https://linkedin.com/in/kavitha-balan',
        'threeYrHires': '31',
        'avgPackage': '₹14.5 LPA',
        'highestCtc': '₹19.0 LPA',
        'mouStatus': 'Under Renewal',
        'mouValidTill': '11/30/2026',
        'lastDrive': 'Last drive: 18 Aug 2026',
        'nextDrive': '11/18/2026',
        'notes': 'Networking lab sponsorship and summer internship track. Renewal meeting scheduled for next week.',
      },
      {
        'id': 'cognizant',
        'name': 'Cognizant Technology Solutions',
        'recruiterType': 'Active',
        'sector': 'Consulting & Services',
        'location': 'Chennai, Tamil Nadu',
        'website': 'https://cognizant.com/careers',
        'spocName': 'Arun Karthik',
        'spocRole': 'Manager - Talent Acquisition',
        'spocEmail': 'arun.karthik@cognizant.com',
        'spocPhone': '+91 98844 77889',
        'linkedIn': 'https://linkedin.com/in/arun-karthik',
        'threeYrHires': '180',
        'avgPackage': '₹6.5 LPA',
        'highestCtc': '₹8.5 LPA',
        'mouStatus': 'In Discussion',
        'mouValidTill': '',
        'lastDrive': 'Last drive: 02 Oct 2026',
        'nextDrive': '11/25/2026',
        'notes': 'Hiring for Digital Specialist Engineer and GenC Elevate roles.',
      },
      {
        'id': 'infosys',
        'name': 'Infosys Limited',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Bengaluru, Karnataka',
        'website': 'https://infosys.com/careers',
        'spocName': 'Deepak Verma',
        'spocRole': 'AVP - Campus Hiring Operations',
        'spocEmail': 'deepak_verma@infosys.com',
        'spocPhone': '+91 97400 11223',
        'linkedIn': 'https://linkedin.com/in/deepak-verma',
        'threeYrHires': '125',
        'avgPackage': '₹7.2 LPA',
        'highestCtc': '₹10.5 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': '05/31/2029',
        'lastDrive': 'Last drive: 10 Sept 2026',
        'nextDrive': '12/05/2026',
        'notes': 'InfyTQ certified students are eligible for direct technical interview for Specialist Programmer.',
      },
    ];
  }

  // Filter calculation
  List<Map<String, dynamic>> _getFilteredEmployers() {
    final query = _searchController.text.toLowerCase().trim();

    return _employers.where((emp) {
      final name = (emp['name'] as String? ?? '').toLowerCase();
      final spoc = (emp['spocName'] as String? ?? '').toLowerCase();
      final loc = (emp['location'] as String? ?? '').toLowerCase();

      final searchMatches = query.isEmpty ||
          name.contains(query) ||
          spoc.contains(query) ||
          loc.contains(query);

      final sectorMatches = _selectedSector == 'All Sectors' ||
          emp['sector'] == _selectedSector;

      final tierMatches = _selectedTier == 'All Tiers' ||
          emp['recruiterType'] == _selectedTier;

      final mouMatches = _selectedMou == 'All MoUs' ||
          emp['mouStatus'] == _selectedMou;

      return searchMatches && sectorMatches && tierMatches && mouMatches;
    }).toList();
  }

  // ===========================================================================
  // ADD / EDIT CORPORATE RECRUITER MODAL (Matches Images 1 & 2)
  // ===========================================================================
  void _showAddEmployerDialog({Map<String, dynamic>? initialEmployer}) {
    final isEditing = initialEmployer != null;

    final companyCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['name'] ?? '') : '');
    String sector = isEditing
        ? (initialEmployer['sector'] ?? 'IT & Software')
        : 'IT & Software';
    String tier = isEditing
        ? (initialEmployer['recruiterType'] ?? 'Active')
        : 'Active';
    final locationCtrl = TextEditingController(
        text: isEditing
            ? (initialEmployer['location'] ?? '')
            : 'Bengaluru, Karnataka');
    final careersUrlCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['website'] ?? '') : '');
    String mouStatus = isEditing
        ? (initialEmployer['mouStatus'] ?? 'None')
        : 'None';
    final mouValidityCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['mouValidTill'] ?? '') : '');
    final nextDriveCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['nextDrive'] ?? '') : '');

    // University Relations Contact Fields (Cream Card)
    final contactPersonCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['spocName'] ?? '') : '');
    final designationCtrl = TextEditingController(
        text: isEditing
            ? (initialEmployer['spocRole'] ?? '')
            : 'University Relations Lead');
    final emailCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['spocEmail'] ?? '') : '');
    final phoneCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['spocPhone'] ?? '') : '');
    final linkedInCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['linkedIn'] ?? '') : '');

    // Historical Placement Statistics Fields (White Card)
    final totalHiresCtrl = TextEditingController(
        text: isEditing ? '${initialEmployer['threeYrHires'] ?? 0}' : '0');
    final avgPackageCtrl = TextEditingController(
        text: isEditing
            ? (initialEmployer['avgPackage'] ?? '12.5')
                .toString()
                .replaceAll('₹', '')
                .replaceAll(' LPA', '')
            : '12.5');
    final highestPackageCtrl = TextEditingController(
        text: isEditing
            ? (initialEmployer['highestCtc'] ?? '18.0')
                .toString()
                .replaceAll('₹', '')
                .replaceAll(' LPA', '')
            : '18.0');

    // Relationship Notes & Feedback
    final notesCtrl = TextEditingController(
        text: isEditing ? (initialEmployer['notes'] ?? '') : '');

    final availableSectors = _sectors.where((s) => s != 'All Sectors').toList();
    final availableTiers = _tiers.where((t) => t != 'All Tiers').toList();
    final availableMous = _mous.where((m) => m != 'All MoUs').toList();

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
                constraints: const BoxConstraints(maxWidth: 720),
                child: SingleChildScrollView(
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
                              isEditing
                                  ? "Edit Corporate Recruiter"
                                  : "Add Corporate Recruiter",
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
                      const SizedBox(height: 16),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 18),

                      // Row 1: Company Name & Sector / Industry (Image 1)
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "Company Name",
                          child: _buildTextField(
                            controller: companyCtrl,
                            hintText: "e.g. Google India",
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "Sector / Industry",
                          child: _buildFormDropdown(
                            value: sector,
                            items: availableSectors,
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => sector = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 2: Relationship Tier & Location / HQ (Image 1)
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "Relationship Tier",
                          child: _buildFormDropdown(
                            value: tier,
                            items: availableTiers,
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => tier = val);
                              }
                            },
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "Location / HQ",
                          child: _buildTextField(
                            controller: locationCtrl,
                            hintText: "e.g. Bengaluru, Karnataka",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 3: Company Careers URL & MoU Status (Image 1)
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "Company Careers URL (optional)",
                          child: _buildTextField(
                            controller: careersUrlCtrl,
                            hintText: "https://company.com/careers",
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "MoU Status",
                          child: _buildFormDropdown(
                            value: mouStatus,
                            items: availableMous,
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => mouStatus = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Row 4: MoU Validity Until & Next Scheduled Drive (Image 1)
                      _buildResponsiveRow(
                        left: _buildFieldLabel(
                          label: "MoU Validity Until (optional)",
                          child: _buildTextField(
                            controller: mouValidityCtrl,
                            hintText: "mm/dd/yyyy",
                            suffixIcon: Icons.calendar_today_outlined,
                            onSuffixTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.now().add(const Duration(days: 365)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365 * 5)),
                              );
                              if (d != null) {
                                mouValidityCtrl.text =
                                    "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";
                              }
                            },
                          ),
                        ),
                        right: _buildFieldLabel(
                          label: "Next Scheduled Drive (optional)",
                          child: _buildTextField(
                            controller: nextDriveCtrl,
                            hintText: "mm/dd/yyyy",
                            suffixIcon: Icons.calendar_today_outlined,
                            onSuffixTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.now().add(const Duration(days: 30)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365 * 2)),
                              );
                              if (d != null) {
                                nextDriveCtrl.text =
                                    "${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Section 1: University Relations Contact Card (Cream Container - Image 1)
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
                              "University Relations Contact",
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Contact Person & Designation
                            _buildResponsiveRow(
                              left: _buildFieldLabel(
                                label: "Contact Person",
                                child: _buildTextField(
                                  controller: contactPersonCtrl,
                                  hintText: "e.g. Anandita Sen",
                                ),
                              ),
                              right: _buildFieldLabel(
                                label: "Designation",
                                child: _buildTextField(
                                  controller: designationCtrl,
                                  hintText: "University Relations Lead",
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Official Email & Phone / Mobile
                            _buildResponsiveRow(
                              left: _buildFieldLabel(
                                label: "Official Email",
                                child: _buildTextField(
                                  controller: emailCtrl,
                                  hintText: "recruiter@company.com",
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              right: _buildFieldLabel(
                                label: "Phone / Mobile (optional)",
                                child: _buildTextField(
                                  controller: phoneCtrl,
                                  hintText: "+91 98840 12345",
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // LinkedIn Profile URL
                            _buildFieldLabel(
                              label: "LinkedIn Profile URL (optional)",
                              child: _buildTextField(
                                controller: linkedInCtrl,
                                hintText:
                                    "https://linkedin.com/in/recruiter-profile",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Section 2: Historical Placement Statistics Card (White Container - Image 1)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Historical Placement Statistics",
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 14),
                            LayoutBuilder(
                              builder: (context, c) {
                                if (c.maxWidth < 480) {
                                  return Column(
                                    children: [
                                      _buildFieldLabel(
                                        label: "3-Yr Total Hires",
                                        child: _buildTextField(
                                          controller: totalHiresCtrl,
                                          hintText: "0",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildFieldLabel(
                                        label: "Average Package (LPA)",
                                        child: _buildTextField(
                                          controller: avgPackageCtrl,
                                          hintText: "12.5",
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildFieldLabel(
                                        label: "Highest Package (LPA)",
                                        child: _buildTextField(
                                          controller: highestPackageCtrl,
                                          hintText: "18.0",
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  children: [
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "3-Yr Total Hires",
                                        child: _buildTextField(
                                          controller: totalHiresCtrl,
                                          hintText: "0",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Average Package (LPA)",
                                        child: _buildTextField(
                                          controller: avgPackageCtrl,
                                          hintText: "12.5",
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFieldLabel(
                                        label: "Highest Package (LPA)",
                                        child: _buildTextField(
                                          controller: highestPackageCtrl,
                                          hintText: "18.0",
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Section 3: Relationship Notes & Feedback (optional) (Image 2)
                      _buildFieldLabel(
                        label: "Relationship Notes & Feedback (optional)",
                        child: _buildTextField(
                          controller: notesCtrl,
                          hintText:
                              "Key discussion points, target departments, student feedback, or recruiter preferences...",
                          maxLines: 4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Bottom Action Buttons: Cancel | Add employer (Image 2)
                      LayoutBuilder(
                        builder: (context, actionBox) {
                          final isNarrow = actionBox.maxWidth < 500;

                          void handleSave() {
                            final compName = companyCtrl.text.trim();
                            if (compName.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please enter company name.",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            final hires = totalHiresCtrl.text.trim().isNotEmpty
                                ? totalHiresCtrl.text.trim()
                                : "0";
                            final avgP = avgPackageCtrl.text.trim().isNotEmpty
                                ? "₹${avgPackageCtrl.text.trim()} LPA"
                                : "₹12.5 LPA";
                            final highP = highestPackageCtrl.text.trim().isNotEmpty
                                ? "₹${highestPackageCtrl.text.trim()} LPA"
                                : "₹18.0 LPA";

                            setState(() {
                              if (isEditing) {
                                initialEmployer['name'] = compName;
                                initialEmployer['sector'] = sector;
                                initialEmployer['recruiterType'] = tier;
                                initialEmployer['location'] =
                                    locationCtrl.text.trim();
                                initialEmployer['website'] =
                                    careersUrlCtrl.text.trim();
                                initialEmployer['mouStatus'] = mouStatus;
                                initialEmployer['mouValidTill'] =
                                    mouValidityCtrl.text.trim();
                                initialEmployer['nextDrive'] =
                                    nextDriveCtrl.text.trim();
                                initialEmployer['spocName'] =
                                    contactPersonCtrl.text.trim();
                                initialEmployer['spocRole'] =
                                    designationCtrl.text.trim();
                                initialEmployer['spocEmail'] =
                                    emailCtrl.text.trim();
                                initialEmployer['spocPhone'] =
                                    phoneCtrl.text.trim();
                                initialEmployer['linkedIn'] =
                                    linkedInCtrl.text.trim();
                                initialEmployer['threeYrHires'] = hires;
                                initialEmployer['avgPackage'] = avgP;
                                initialEmployer['highestCtc'] = highP;
                                initialEmployer['notes'] = notesCtrl.text.trim();
                              } else {
                                _employers.insert(0, {
                                  'id':
                                      'emp-${DateTime.now().millisecondsSinceEpoch}',
                                  'name': compName,
                                  'recruiterType': tier,
                                  'sector': sector,
                                  'location': locationCtrl.text.trim().isNotEmpty
                                      ? locationCtrl.text.trim()
                                      : 'Bengaluru, Karnataka',
                                  'website': careersUrlCtrl.text.trim().isNotEmpty
                                      ? careersUrlCtrl.text.trim()
                                      : 'https://company.com/careers',
                                  'spocName': contactPersonCtrl.text.trim().isNotEmpty
                                      ? contactPersonCtrl.text.trim()
                                      : 'Campus HR',
                                  'spocRole': designationCtrl.text.trim().isNotEmpty
                                      ? designationCtrl.text.trim()
                                      : 'University Relations Lead',
                                  'spocEmail': emailCtrl.text.trim().isNotEmpty
                                      ? emailCtrl.text.trim()
                                      : 'recruiter@company.com',
                                  'spocPhone': phoneCtrl.text.trim().isNotEmpty
                                      ? phoneCtrl.text.trim()
                                      : '+91 98840 12345',
                                  'linkedIn': linkedInCtrl.text.trim().isNotEmpty
                                      ? linkedInCtrl.text.trim()
                                      : 'https://linkedin.com',
                                  'threeYrHires': hires,
                                  'avgPackage': avgP,
                                  'highestCtc': highP,
                                  'mouStatus': mouStatus,
                                  'mouValidTill': mouValidityCtrl.text.trim(),
                                  'lastDrive': 'Upcoming: Nov 2026',
                                  'nextDrive': nextDriveCtrl.text.trim(),
                                  'notes': notesCtrl.text.trim(),
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
                                          ? "$compName profile updated."
                                          : "$compName added to hiring partners.",
                                      style: GoogleFonts.poppins(fontSize: 12.5),
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
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          );

                          final saveBtn = ElevatedButton(
                            onPressed: handleSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                isEditing ? "Save changes" : "Add employer",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );

                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                saveBtn,
                                const SizedBox(height: 8),
                                cancelBtn,
                              ],
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              cancelBtn,
                              const SizedBox(width: 12),
                              saveBtn,
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
  // MAIN BUILD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    final filtered = _getFilteredEmployers();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Hero Banner
              _buildTopHeroBanner(),
              const SizedBox(height: 18),

              // 2. 5 Metric Cards
              _buildMetricCards(),
              const SizedBox(height: 18),

              // 3. Search & Filter Bar (Images 3, 4, 5)
              _buildSearchAndFilterBar(),
              const SizedBox(height: 18),

              // 4. Employers Grid
              _buildEmployersGrid(filtered),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER (Image 1)
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
            right: 15,
            bottom: -20,
            child: Opacity(
              opacity: 0.10,
              child: const Icon(
                Icons.apartment_rounded,
                size: 190,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.arrow_back,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('>',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.5))),
                      const SizedBox(width: 6),
                      Text(
                        'Placement',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('>',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.5))),
                      const SizedBox(width: 6),
                      Text(
                        'Employers',
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.apartment_rounded,
                        color: Color(0xFFFBBF24),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
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
                            'Employers',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Recruiter relationships, history and hiring outcomes.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
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
    );
  }

  // ===========================================================================
  // 2. 5 METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCards() {
    final totalEmp = _employers.length;
    final activePartners = _employers
        .where((e) =>
            e['recruiterType'] == 'Tier-1 Partner' ||
            e['recruiterType'] == 'Preferred Recruiter' ||
            e['recruiterType'] == 'Active')
        .length;
    final tier1Partners =
        _employers.where((e) => e['recruiterType'] == 'Tier-1 Partner').length;

    int totalHires = 0;
    for (var emp in _employers) {
      totalHires += int.tryParse('${emp['threeYrHires']}') ?? 0;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int count = 1;
        if (constraints.maxWidth >= 1050) {
          count = 5;
        } else if (constraints.maxWidth >= 700) {
          count = 3;
        } else if (constraints.maxWidth >= 460) {
          count = 2;
        }

        final double cardWidth =
            (constraints.maxWidth - (count - 1) * 12) / count;

        final cards = [
          _buildStatCard('Total Employers', '$totalEmp',
              'Registered corporate partners', Icons.article_outlined),
          _buildStatCard('Active Partners', '$activePartners',
              'Tier-1, Preferred & Active', Icons.handshake_outlined),
          _buildStatCard('Tier-1 Partners', '$tier1Partners',
              'Marquee corporate relationships', Icons.auto_awesome_outlined),
          _buildStatCard('3-Yr Total Hires', '$totalHires',
              'Cumulative students hired', Icons.groups_outlined),
          _buildStatCard('Average CTC', '₹14.6 LPA', 'Across hiring partners',
              Icons.trending_up),
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards
              .map((c) => SizedBox(width: cardWidth, child: c))
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTERS BAR (Images 3, 4, 5)
  // ===========================================================================
  Widget _buildSearchAndFilterBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;

        final searchInput = Container(
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF9F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'Search by company, contact person or location...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: const Icon(Icons.search,
                  size: 18, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            ),
          ),
        );

        final sectorDropdown = _buildSmallDropdown(
          value: _selectedSector,
          items: _sectors,
          onChanged: (v) => setState(() => _selectedSector = v!),
        );

        final tierDropdown = _buildSmallDropdown(
          value: _selectedTier,
          items: _tiers,
          onChanged: (v) => setState(() => _selectedTier = v!),
        );

        final mouDropdown = _buildSmallDropdown(
          value: _selectedMou,
          items: _mous,
          onChanged: (v) => setState(() => _selectedMou = v!),
        );

        final exportCsvBtn = OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Exporting employers roster as CSV...',
                    style: GoogleFonts.poppins()),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.file_download_outlined,
              size: 15, color: Color(0xFF334155)),
          label: Text(
            'Export CSV',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );

        final addEmployerBtn = ElevatedButton.icon(
          onPressed: () => _showAddEmployerDialog(),
          icon: const Icon(Icons.add, size: 16),
          label: Text(
            'Add employer',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        );

        if (isNarrow) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchInput,
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    sectorDropdown,
                    tierDropdown,
                    mouDropdown,
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    exportCsvBtn,
                    addEmployerBtn,
                  ],
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Expanded(flex: 3, child: searchInput),
              const SizedBox(width: 10),
              sectorDropdown,
              const SizedBox(width: 8),
              tierDropdown,
              const SizedBox(width: 8),
              mouDropdown,
              const SizedBox(width: 12),
              exportCsvBtn,
              const SizedBox(width: 8),
              addEmployerBtn,
            ],
          ),
        );
      },
    );
  }

  Widget _buildSmallDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: false,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. EMPLOYERS GRID
  // ===========================================================================
  Widget _buildEmployersGrid(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded,
                size: 40, color: Color(0xFF94A3B8)),
            const SizedBox(height: 10),
            Text(
              'No employers match your search or filter criteria.',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: const Color(0xFF64748B)),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTwoCol = constraints.maxWidth >= 820;
        final cardWidth = isTwoCol
            ? (constraints.maxWidth - 16) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map((emp) => SizedBox(
                    width: cardWidth,
                    child: _buildEmployerCard(emp),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildEmployerCard(Map<String, dynamic> emp) {
    return Container(
      padding: const EdgeInsets.all(18),
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
          // Top row: Name, badges, details, edit, delete
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      emp['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        emp['recruiterType'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        emp['sector'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => _showEmployerDetailsDialog(emp),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F172A),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      minimumSize: const Size(0, 28),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      'Details',
                      style: GoogleFonts.poppins(
                          fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        size: 16, color: Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _showAddEmployerDialog(initialEmployer: emp),
                    tooltip: 'Edit employer',
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      final removedEmp = emp;
                      final idx = _employers.indexOf(emp);
                      setState(() {
                        _employers.remove(emp);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${emp['name']} removed from roster.",
                              style: GoogleFonts.poppins()),
                          action: SnackBarAction(
                            label: "Undo",
                            textColor: const Color(0xFF38BDF8),
                            onPressed: () {
                              setState(() {
                                _employers.insert(idx, removedEmp);
                              });
                            },
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    tooltip: 'Delete employer',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Location & Website
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 13, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                emp['location'],
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.language_rounded,
                  size: 13, color: Color(0xFF2563EB)),
              const SizedBox(width: 4),
              Text(
                'Website',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // SPOC Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF9F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      emp['spocName'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      emp['spocRole'],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.email_outlined,
                            size: 12, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          emp['spocEmail'],
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.phone_outlined,
                            size: 12, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          emp['spocPhone'],
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'LinkedIn',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Placement Stats Row: 3-Yr Hires, Avg Package, Highest CTC
          Row(
            children: [
              Expanded(
                child: _buildMetricMini(
                    '3-Yr Total Hires', '${emp['threeYrHires']}'),
              ),
              Expanded(
                child: _buildMetricMini('Average Package', emp['avgPackage']),
              ),
              Expanded(
                child: _buildMetricMini('Highest Offered', emp['highestCtc']),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Footer: MoU badge and last drive
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: emp['mouStatus'] == 'Active MoU'
                      ? const Color(0xFFECFDF5)
                      : (emp['mouStatus'] == 'Under Renewal'
                          ? const Color(0xFFFEF3C7)
                          : const Color(0xFFF1F5F9)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  emp['mouStatus'] == 'None'
                      ? 'No MoU'
                      : "${emp['mouStatus']}${emp['mouValidTill'] != null && emp['mouValidTill'].isNotEmpty ? ' · ${emp['mouValidTill']}' : ''}",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: emp['mouStatus'] == 'Active MoU'
                        ? const Color(0xFF059669)
                        : (emp['mouStatus'] == 'Under Renewal'
                            ? const Color(0xFFD97706)
                            : const Color(0xFF475569)),
                  ),
                ),
              ),
              Text(
                emp['lastDrive'] ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricMini(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // DETAILS MODAL
  // ===========================================================================
  void _showEmployerDetailsDialog(Map<String, dynamic> emp) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  emp['name'],
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  emp['recruiterType'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _detailRow('Sector', emp['sector']),
                  _detailRow('Headquarters', emp['location']),
                  _detailRow('Campus SPOC', emp['spocName']),
                  _detailRow('Designation', emp['spocRole']),
                  _detailRow('Email', emp['spocEmail']),
                  _detailRow('Phone', emp['spocPhone']),
                  const Divider(height: 20),
                  _detailRow(
                      '3-Year Total Hires', '${emp['threeYrHires']} students'),
                  _detailRow('Average Compensation', emp['avgPackage']),
                  _detailRow('Highest Offered CTC', emp['highestCtc']),
                  _detailRow('MoU Status',
                      '${emp['mouStatus']} · ${emp['mouValidTill']}'),
                  _detailRow('Latest Activity', emp['lastDrive']),
                  if (emp['notes'] != null && (emp['notes'] as String).isNotEmpty) ...[
                    const Divider(height: 20),
                    _detailRow('Relationship Notes', emp['notes']),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Close', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FORM COMPONENT HELPERS
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
      style:
          GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontSize: 12, color: const Color(0xFF94A3B8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixTap,
                child:
                    Icon(suffixIcon, size: 18, color: const Color(0xFF64748B)),
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

  static Widget _buildFormDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 44,
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
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 18, color: Color(0xFF64748B)),
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
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
