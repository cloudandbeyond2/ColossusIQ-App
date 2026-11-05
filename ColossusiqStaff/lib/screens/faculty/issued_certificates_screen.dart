import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: ISSUED CERTIFICATES SCREEN
// Matches screenshot 5: Blueprint grid hero banner, 6 grade metric cards
// (Issued 0, Grade O 0, Grade A+ 0, Grade A 0, Grade B 0, Grade C 0),
// and "Course & quiz certificates" card with search/filter and blueprint graph paper empty state.
// =============================================================================
class IssuedCertificatesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IssuedCertificatesScreen({super.key, this.onBack});

  @override
  State<IssuedCertificatesScreen> createState() =>
      _IssuedCertificatesScreenState();
}

class _IssuedCertificatesScreenState extends State<IssuedCertificatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGrade = "All";

  final List<Map<String, dynamic>> _certificates = [
    {
      "id": "CERT-AI-2026-101",
      "student": "Priya Sharma",
      "roll": "2024CSE042",
      "quiz": "Deep Learning & Neural Networks",
      "grade": "Grade O",
      "score": "98%",
      "date": "21 Oct 2026",
      "verifiableUrl": "https://university.edu/verify/CERT-AI-2026-101",
    },
    {
      "id": "CERT-DB-2026-104",
      "student": "Rahul Verma",
      "roll": "2024CSE058",
      "quiz": "Database Architecture & Optimization",
      "grade": "Grade A+",
      "score": "92%",
      "date": "19 Oct 2026",
      "verifiableUrl": "https://university.edu/verify/CERT-DB-2026-104",
    },
    {
      "id": "CERT-CL-2026-077",
      "student": "Ananya Iyer",
      "roll": "2024AIDS019",
      "quiz": "Cloud Infrastructure with Kubernetes",
      "grade": "Grade A",
      "score": "86%",
      "date": "18 Oct 2026",
      "verifiableUrl": "https://university.edu/verify/CERT-CL-2026-077",
    },
    {
      "id": "CERT-OS-2026-052",
      "student": "Karthik Sundaram",
      "roll": "2024CSE081",
      "quiz": "Operating Systems Kernel Internals",
      "grade": "Grade B",
      "score": "78%",
      "date": "15 Oct 2026",
      "verifiableUrl": "https://university.edu/verify/CERT-OS-2026-052",
    },
  ];

  void _loadDemoCertificates() {
    setState(() {
      _certificates.addAll([
        {
          "id": "CERT-NET-2026-061",
          "student": "Divya Krishnan",
          "roll": "2024ECE033",
          "quiz": "Advanced Computer Networks & Security",
          "grade": "Grade A+",
          "score": "94%",
          "date": "Today",
          "verifiableUrl": "https://university.edu/verify/CERT-NET-2026-061",
        },
      ]);
    });
  }

  void _showIssueCertificateDialog() {
    final nameCtrl = TextEditingController();
    final rollCtrl = TextEditingController();
    final quizCtrl = TextEditingController(text: "Full Stack Web Development & APIs");
    final scoreCtrl = TextEditingController(text: "95");
    String grade = "Grade O";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD97706), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text("Issue Certificate", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 440,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(labelText: "Student Name", hintText: "e.g. S. Vignesh"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: rollCtrl,
                        decoration: const InputDecoration(labelText: "Register / Roll No", hintText: "e.g. 2024CSE110"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: quizCtrl,
                        decoration: const InputDecoration(labelText: "Course or Quiz Title"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: grade,
                              decoration: const InputDecoration(labelText: "Grade Awarded"),
                              items: ["Grade O", "Grade A+", "Grade A", "Grade B", "Grade C"]
                                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => grade = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: scoreCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: "Score (%)"),
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
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Cancel", style: GoogleFonts.poppins()),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty || rollCtrl.text.trim().isEmpty) return;
                    final certId = "CERT-MAN-${1000 + _certificates.length}";
                    final newCert = {
                      "id": certId,
                      "student": nameCtrl.text.trim(),
                      "roll": rollCtrl.text.trim().toUpperCase(),
                      "quiz": quizCtrl.text.trim(),
                      "grade": grade,
                      "score": "${scoreCtrl.text.trim()}%",
                      "date": "Today",
                      "verifiableUrl": "https://university.edu/verify/$certId",
                    };
                    setState(() {
                      _certificates.insert(0, newCert);
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Certificate $certId issued for ${newCert["student"]}!"),
                        backgroundColor: const Color(0xFF0F766E),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Issue Now", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showViewCertificateDialog(Map<String, dynamic> c) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 480,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Gold header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF141A46),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.military_tech_rounded, color: Color(0xFFFBBF24), size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CERTIFICATE OF ACHIEVEMENT",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.6,
                              ),
                            ),
                            Text(
                              "Autonomous University Academic Council",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                color: const Color(0xFF93C5FD),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          c["grade"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Certificate Body
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "This is proudly presented to",
                        style: GoogleFonts.poppins(fontSize: 12, fontStyle: FontStyle.italic, color: const Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        c["student"] as String,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        "Register No: ${c["roll"]}",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "for successfully completing and mastering the curriculum of",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c["quiz"] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w700, color: const Color(0xFF1E2865)),
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Certificate ID: ${c["id"]}", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                              Text("Issued: ${c["date"]}", style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Dr. Lakshmi Sundaram", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF1E2865))),
                              Text("Principal & Dean", style: GoogleFonts.poppins(fontSize: 10.5, fontStyle: FontStyle.italic, color: const Color(0xFF64748B))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Downloading PDF certificate for ${c["student"]}..."),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.file_download_outlined, size: 15),
              label: const Text("Download PDF"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141A46),
                foregroundColor: Colors.white,
              ),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showRevokeCertificateDialog(Map<String, dynamic> c) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Revoke Certificate?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to revoke certificate '${c["id"]}' for ${c["student"]}? The verification link will be permanently invalidated.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final removed = Map<String, dynamic>.from(c);
                final index = _certificates.indexOf(c);
                setState(() {
                  _certificates.remove(c);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Revoked certificate ${removed["id"]}"),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _certificates.insert(index >= 0 ? index : 0, removed);
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
              child: const Text("Revoke"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final issuedCount = "${_certificates.length}";
    final gradeOCount = "${_certificates.where((c) => c["grade"] == "Grade O").length}";
    final gradeAPlusCount = "${_certificates.where((c) => c["grade"] == "Grade A+").length}";
    final gradeACount = "${_certificates.where((c) => c["grade"] == "Grade A").length}";
    final gradeBCount = "${_certificates.where((c) => c["grade"] == "Grade B").length}";
    final gradeCCount = "${_certificates.where((c) => c["grade"] == "Grade C").length}";

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 750;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 6 Grade Metric Cards
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildGradeMetric("Issued", issuedCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade O", gradeOCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade A+", gradeAPlusCount)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildGradeMetric("Grade A", gradeACount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade B", gradeBCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade C", gradeCCount)),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildGradeMetric("Issued", issuedCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade O", gradeOCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade A+", gradeAPlusCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade A", gradeACount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade B", gradeBCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade C", gradeCCount)),
                  ],
                ),
              const SizedBox(height: 20),

              _buildCertificatesCard(),
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
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.military_tech_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course & Certification",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Issued Certificates",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.military_tech_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "AI COURSE & CERTIFICATION",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Issued Certificates",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Every certificate issued in your college, with grade, marks and verification status.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
                    ),
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
  // 2. 6 GRADE METRIC CARDS
  // ===========================================================================
  Widget _buildGradeMetric(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN CARD: COURSE & QUIZ CERTIFICATES
  // ===========================================================================
  Widget _buildCertificatesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Course & quiz certificates",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Issued automatically when students pass · signed under the Principal's authority · verifiable by QR at /verify",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          // Search + Dropdown Filter + Issue Button (Responsive & No-Overflow)
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 640;

              final searchField = Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Search student, quiz or ID",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: false,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );

              final gradeDropdown = Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedGrade,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 18, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF334155)),
                    items: [
                      "All",
                      "Grade O",
                      "Grade A+",
                      "Grade A",
                      "Grade B",
                      "Grade C"
                    ]
                        .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text(g, overflow: TextOverflow.ellipsis)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedGrade = val);
                    },
                  ),
                ),
              );

              final issueButton = ElevatedButton.icon(
                onPressed: _showIssueCertificateDialog,
                icon: const Icon(Icons.add_rounded, size: 15),
                label: Text("Issue Certificate",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141A46),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              );

              if (isDesktop) {
                return Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 10),
                    gradeDropdown,
                    const SizedBox(width: 12),
                    issueButton,
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: searchField),
                        const SizedBox(width: 10),
                        gradeDropdown,
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: issueButton,
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 18),

          // Blueprint Graph Paper Empty State Container or Data Table
          () {
            final query = _searchController.text.trim().toLowerCase();
            final filtered = _certificates.where((c) {
              if (_selectedGrade != "All" && c["grade"] != _selectedGrade) {
                return false;
              }
              if (query.isNotEmpty) {
                final student = (c["student"] as String).toLowerCase();
                final roll = (c["roll"] as String).toLowerCase();
                final quiz = (c["quiz"] as String).toLowerCase();
                final id = (c["id"] as String).toLowerCase();
                if (!student.contains(query) && !roll.contains(query) && !quiz.contains(query) && !id.contains(query)) {
                  return false;
                }
              }
              return true;
            }).toList();

            if (filtered.isEmpty) {
              return Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 260),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPaperPainter(
                            gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
                            step: 24.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No certificates found",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Certificates appear here when students pass certificate-enabled quizzes or when manually issued.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton.icon(
                              onPressed: _loadDemoCertificates,
                              icon: const Icon(Icons.refresh_rounded, size: 14),
                              label: const Text("Load Sample Certificates"),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF1E2865),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                horizontalMargin: 16,
                columnSpacing: 22,
                columns: [
                  DataColumn(label: Text("ID", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("STUDENT", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("COURSE / QUIZ", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("GRADE", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("SCORE", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("ISSUED DATE", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                  DataColumn(label: Text("ACTIONS", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)))),
                ],
                rows: filtered.map((c) {
                  return DataRow(
                    cells: [
                      DataCell(Text(c["id"] as String, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(c["student"] as String, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                            Text(c["roll"] as String, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      DataCell(Text(c["quiz"] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155)))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            c["grade"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(c["score"] as String, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF15803D)))),
                      DataCell(Text(c["date"] as String, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _showViewCertificateDialog(c),
                              icon: const Icon(Icons.workspace_premium_rounded, size: 18, color: Color(0xFFD97706)),
                              tooltip: "View Certificate",
                              splashRadius: 16,
                            ),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Downloading PDF certificate for ${c["student"]}..."),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.file_download_outlined, size: 16, color: Color(0xFF4338CA)),
                              tooltip: "Download PDF",
                              splashRadius: 16,
                            ),
                            IconButton(
                              onPressed: () => _showRevokeCertificateDialog(c),
                              icon: const Icon(Icons.remove_circle_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                              tooltip: "Revoke Certificate",
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
        ],
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
