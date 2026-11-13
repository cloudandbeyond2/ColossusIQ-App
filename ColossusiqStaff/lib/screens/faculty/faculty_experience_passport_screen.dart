import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/certificate_pdf_service.dart';

// =============================================================================
// CAMPUS LIFE: EXPERIENCE PASSPORT SCREEN
// Matches screenshot exactly:
// - Blueprint grid hero banner with badges (CAMPUS LIFE, Phase 3)
//   and star illustration
// - 4 Metric cards: Activities in college (3), Verified (2), Waiting for you (0), Sent back (1)
// - Filter tabs: To verify · 0, Verified History · 2 (active navy), Sent back · 1, All Activities · 3
// - Search student, roll number, activity, club... + All Categories dropdown
// - Student verification cards (AK Anand Kumar) with Key achievement box,
//   "View Evidence Certificate" popup, and "Send back to the student" dialog
// =============================================================================

class FacultyExperiencePassportScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyExperiencePassportScreen({super.key, this.onBack});

  @override
  State<FacultyExperiencePassportScreen> createState() =>
      _FacultyExperiencePassportScreenState();
}

class _FacultyExperiencePassportScreenState
    extends State<FacultyExperiencePassportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "Verified History";
  String _selectedCategory = "All Categories";

  final List<String> _categories = [
    "All Categories",
    "Volunteering",
    "Competition",
    "Leadership",
    "Sports",
    "Hackathon",
    "Cultural",
  ];

  final List<Map<String, dynamic>> _activities = [
    {
      "id": "ACT-101",
      "student": "Anand Kumar",
      "roll": "110124001",
      "submittedDate": "6 Oct 2026",
      "title": "Blood Donation Camp",
      "category": "Volunteering",
      "status": "Verified",
      "role": "Team Lead · Event (Oct 2026)",
      "keyAchievement":
          "Organized university blood donation drive collecting 450+ units for Government Hospital Chennai; planted 1000 saplings across green campus corridor.",
      "verifier": "Dr. Meena Raghavan (Faculty)",
      "verifiedDate": "15 Oct 2026",
      "certId": "CIQ-2026-BDC091A",
      "sendBackReason": "",
    },
    {
      "id": "ACT-102",
      "student": "Anand Kumar",
      "roll": "110124001",
      "submittedDate": "15 Oct 2026",
      "title": "National Cyber Security Hackathon - First Prize",
      "category": "Competition",
      "status": "Verified",
      "role":
          "Team Lead & Security Researcher · IEEE Computer Society & IIT Madras",
      "keyAchievement":
          "Built an automated cloud vulnerability scanner with 98.4% accuracy across AWS/GCP benchmarks; presented demo in finals.",
      "verifier": "Dr. Meena Raghavan (Faculty)",
      "verifiedDate": "16 Oct 2026",
      "certId": "CIQ-2026-HCK882B",
      "sendBackReason": "",
    },
    {
      "id": "ACT-103",
      "student": "Divya Ramesh",
      "roll": "110124018",
      "submittedDate": "20 Oct 2026",
      "title": "Rotaract Club Youth Leadership Summit",
      "category": "Leadership",
      "status": "Sent back",
      "role": "Vice President · Rotaract Club",
      "keyAchievement":
          "Headed delegation of 40 students to Regional Youth Parliament; drafted policy resolution on AI ethics.",
      "verifier": "Dr. Anand V. (Faculty)",
      "verifiedDate": "22 Oct 2026",
      "certId": "CIQ-2026-ROT331C",
      "sendBackReason":
          "Please attach official participation letter with seal from the District Governor.",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Dynamic counts
  int get _totalCount => _activities.length;
  int get _verifiedCount =>
      _activities.where((a) => a["status"] == "Verified").length;
  int get _toVerifyCount =>
      _activities.where((a) => a["status"] == "To verify").length;
  int get _sentBackCount =>
      _activities.where((a) => a["status"] == "Sent back").length;

  List<Map<String, dynamic>> get _filteredActivities {
    final q = _searchController.text.trim().toLowerCase();
    return _activities.where((a) {
      // Tab filter
      if (_selectedTab == "To verify" && a["status"] != "To verify") {
        return false;
      }
      if (_selectedTab == "Verified History" && a["status"] != "Verified") {
        return false;
      }
      if (_selectedTab == "Sent back" && a["status"] != "Sent back") {
        return false;
      }

      // Category filter
      if (_selectedCategory != "All Categories" &&
          a["category"] != _selectedCategory) {
        return false;
      }

      // Search query
      if (q.isNotEmpty) {
        final student = (a["student"] as String).toLowerCase();
        final roll = (a["roll"] as String).toLowerCase();
        final title = (a["title"] as String).toLowerCase();
        final cat = (a["category"] as String).toLowerCase();
        if (!student.contains(q) &&
            !roll.contains(q) &&
            !title.contains(q) &&
            !cat.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  // ===========================================================================
  // SEND BACK TO THE STUDENT DIALOG (Matching Image 5)
  // ===========================================================================
  void _showSendBackDialog(Map<String, dynamic> act) {
    final feedbackCtrl =
        TextEditingController(text: act["sendBackReason"] as String? ?? "");

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Row: Title & Close Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send back to the student",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Subtitle: Student name & activity
                  Text(
                    "${act["student"]}: ${act["title"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Form Label
                  Text(
                    "What should the student fix?",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Textarea
                  TextField(
                    controller: feedbackCtrl,
                    maxLines: 4,
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      hintText:
                          "Explain what evidence or correction is required before this can be approved...",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Action Buttons: Cancel and Send back
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
                          final reason = feedbackCtrl.text.trim();
                          if (reason.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please provide a reason to send back."),
                                backgroundColor: Color(0xFFDC2626),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            act["status"] = "Sent back";
                            act["sendBackReason"] = reason;
                          });

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Activity sent back to ${act["student"]} with feedback.",
                              ),
                              backgroundColor: const Color(0xFFDC2626),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626), // Solid red/crimson
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Send back",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
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
        );
      },
    );
  }

  // ===========================================================================
  // VIEW EVIDENCE CERTIFICATE MODAL
  // ===========================================================================
  void _showEvidenceCertificateDialog(Map<String, dynamic> act) {
    final student = act["student"] as String;
    final title = act["title"] as String;
    final certId = act["certId"] as String;
    final verifier = act["verifier"] as String;
    final verifiedDate = act["verifiedDate"] as String;
    final keyAch = act["keyAchievement"] as String;

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: const Color(0xFFFBFBFD),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Close row
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Top Verified Banner
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF047857),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check,
                              size: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Evidence Verified & Authenticated",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF065F46),
                                ),
                              ),
                              Text(
                                "Verified by $verifier on $verifiedDate · ID: $certId",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF064E3B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await CertificatePdfService.printOrSavePdf(
                                recipient: student,
                                type: act["category"] as String? ?? "Merit",
                                event: title,
                                date: verifiedDate,
                                certId: certId,
                                citation: keyAch,
                                rollNumber: "${act["roll"]} · Computer Science",
                              );
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Print error: $e"),
                                    backgroundColor: const Color(0xFFDC2626),
                                  ),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.print_outlined, size: 14),
                          label: const Text("Print / save PDF"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2865),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Certificate Visual Card
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF8),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color(0xFF1E2865), width: 2.2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFD4AF37), width: 1.2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 28),
                      child: Column(
                        children: [
                          Text(
                            "EXPERIENCE PASSPORT VERIFICATION",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Anna Institute of Technology · Campus Life Office",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "This verifies that",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            student,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF78350F),
                            ),
                          ),
                          Text(
                            "Roll: ${act["roll"]} · Activity: $title",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              keyAch,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF334155),
                                height: 1.45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 500,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CERTIFICATE ID: $certId",
                                        style: GoogleFonts.poppins(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      Text(
                                        "Verified on: $verifiedDate",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        verifier,
                                        style: GoogleFonts.dancingScript(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1E2865),
                                        ),
                                      ),
                                      Container(
                                        width: 110,
                                        height: 1,
                                        color: const Color(0xFFCBD5E1),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                      ),
                                      Text(
                                        "Faculty Signature",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteActivityDialog(Map<String, dynamic> act) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(
            "Delete Activity Entry",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: Text(
            "Remove '${act["title"]}' for ${act["student"]}?",
            style: GoogleFonts.poppins(
                fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Cancel",
                  style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _activities.remove(act);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Activity entry removed."),
                    backgroundColor: Color(0xFFDC2626),
                    behavior: SnackBarBehavior.floating,
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
      backgroundColor: const Color(0xFFFAF9F6),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 750;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 4 Metric Cards Row
              _buildMetricCardsRow(isNarrow),
              const SizedBox(height: 18),

              // 3. Filter Tabs (To verify · 0, Verified History · 2, etc.)
              _buildFilterTabs(),
              const SizedBox(height: 14),

              // 4. Search & Category Dropdown
              _buildSearchAndCategoryRow(constraints.maxWidth < 650),
              const SizedBox(height: 16),

              // 5. Activity Verification Cards
              ..._filteredActivities.map((act) => _buildActivityCard(act)),

              if (_filteredActivities.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.verified_outlined,
                          size: 44, color: Color(0xFF94A3B8)),
                      const SizedBox(height: 10),
                      Text(
                        "No activities match this filter",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2865),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.2),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Blueprint Grid Pattern Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _PassportGridPainter(),
            ),
          ),

          // Faint Star Watermark on right
          Positioned(
            right: -10,
            bottom: -15,
            child: Opacity(
              opacity: 0.08,
              child: const Icon(
                Icons.star_rounded,
                size: 160,
                color: Colors.white,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb
                Row(
                  children: [
                    if (widget.onBack != null) ...[
                      InkWell(
                        onTap: widget.onBack,
                        borderRadius: BorderRadius.circular(6),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              size: 13, color: Colors.white70),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      "Home  ›  Campus Life  ›  Experience Passport",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Badges Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        "CAMPUS LIFE",
                        style: GoogleFonts.poppins(
                          fontSize: 9,
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
                        color: const Color(0xFFD97706),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Phase 3",
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Title with star icon container
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.star_rounded,
                          size: 24,
                          color: Color(0xFFFBBF24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Experience Passport",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Record volunteering, leadership, competitions and more; faculty verify each entry.",
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
  // 2. 4 STAT METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCardsRow(bool isNarrow) {
    final card1 = _buildMetricCard(
      title: "Activities in college",
      value: "$_totalCount",
      icon: Icons.bookmark_border_rounded,
      iconColor: const Color(0xFF3B82F6),
    );
    final card2 = _buildMetricCard(
      title: "Verified",
      value: "$_verifiedCount",
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF10B981),
    );
    final card3 = _buildMetricCard(
      title: "Waiting for you",
      value: "$_toVerifyCount",
      icon: Icons.hourglass_top_rounded,
      iconColor: const Color(0xFFF59E0B),
    );
    final card4 = _buildMetricCard(
      title: "Sent back",
      value: "$_sentBackCount",
      icon: Icons.assignment_return_outlined,
      iconColor: const Color(0xFFEF4444),
    );

    if (isNarrow) {
      return Column(
        children: [
          Row(children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: card3),
            const SizedBox(width: 12),
            Expanded(child: card4),
          ]),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: card1),
        const SizedBox(width: 14),
        Expanded(child: card2),
        const SizedBox(width: 14),
        Expanded(child: card3),
        const SizedBox(width: 14),
        Expanded(child: card4),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
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
  // 3. FILTER TABS (To verify · 0, Verified History · 2, etc.)
  // ===========================================================================
  Widget _buildFilterTabs() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildTabPill("To verify", "· $_toVerifyCount"),
        _buildTabPill("Verified History", "· $_verifiedCount"),
        _buildTabPill("Sent back", "· $_sentBackCount"),
        _buildTabPill("All Activities", "· $_totalCount"),
      ],
    );
  }

  Widget _buildTabPill(String tabName, String countSuffix) {
    final isSelected = _selectedTab == tabName;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = tabName;
        });
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          "$tabName $countSuffix",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. SEARCH & CATEGORY DROPDOWN
  // ===========================================================================
  Widget _buildSearchAndCategoryRow(bool isNarrow) {
    final searchBox = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.poppins(fontSize: 13),
        decoration: InputDecoration(
          hintText: "Search student, roll number, activity, club...",
          hintStyle: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 18,
            color: Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );

    final categoryDropdown = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF1E293B),
          ),
          items: _categories.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _selectedCategory = val;
              });
            }
          },
        ),
      ),
    );

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          searchBox,
          const SizedBox(height: 10),
          categoryDropdown,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: searchBox),
        const SizedBox(width: 12),
        categoryDropdown,
      ],
    );
  }

  // ===========================================================================
  // 5. ACTIVITY VERIFICATION CARD
  // ===========================================================================
  Widget _buildActivityCard(Map<String, dynamic> act) {
    final student = act["student"] as String;
    final roll = act["roll"] as String;
    final submittedDate = act["submittedDate"] as String;
    final title = act["title"] as String;
    final category = act["category"] as String;
    final status = act["status"] as String;
    final role = act["role"] as String;
    final keyAchievement = act["keyAchievement"] as String;
    final verifier = act["verifier"] as String;
    final verifiedDate = act["verifiedDate"] as String;

    // Category styling
    Color catBg = const Color(0xFFF1F5F9);
    Color catFg = const Color(0xFF475569);
    if (category == "Volunteering") {
      catBg = const Color(0xFFF3E8FF);
      catFg = const Color(0xFF7E22CE);
    } else if (category == "Competition") {
      catBg = const Color(0xFFDBEAFE);
      catFg = const Color(0xFF1D4ED8);
    } else if (category == "Leadership") {
      catBg = const Color(0xFFFEF3C7);
      catFg = const Color(0xFFB45309);
    }

    // Status styling
    Color statusBg = const Color(0xFFCCFBF1);
    Color statusFg = const Color(0xFF0F766E);
    if (status == "Sent back") {
      statusBg = const Color(0xFFFEE2E2);
      statusFg = const Color(0xFFB91C1C);
    }

    // Student initials
    final initials = student
        .split(" ")
        .map((p) => p.isNotEmpty ? p[0] : "")
        .take(2)
        .join();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          // Top row: Avatar + Student info + Badges
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Circle AK
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6), // Purple
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Main Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subtitle: Anand Kumar 110124001 · submitted 6 Oct 2026
                      Text(
                        "$student $roll · submitted $submittedDate",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Activity Title & Badges
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: catBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: catFg,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusFg,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),

                      // Role Subtitle: Team Lead · Event (Oct 2026)
                      Text(
                        role,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Key Achievement Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Key achievement: ",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    TextSpan(
                      text: keyAchievement,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Bottom Bar Divider
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Bottom Bar Actions & Verification Note
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                // Left: View Evidence Certificate Link
                InkWell(
                  onTap: () => _showEvidenceCertificateDialog(act),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 15,
                          color: Color(0xFF4338CA),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "View Evidence Certificate",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4338CA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Center / Right: Verifier Info & Actions
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "External proof Verified by $verifier on $verifiedDate",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    // Send back button (opens Send back dialog)
                    OutlinedButton(
                      onPressed: () => _showSendBackDialog(act),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFDC2626),
                        side: const BorderSide(color: Color(0xFFFECACA)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        "Send back",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Delete trash icon
                    IconButton(
                      onPressed: () => _showDeleteActivityDialog(act),
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 16, color: Color(0xFF94A3B8)),
                      splashRadius: 16,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: "Delete",
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
}

// Blueprint grid overlay painter
class _PassportGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const step = 24.0;
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
