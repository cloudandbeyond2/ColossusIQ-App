import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

class CertificatesScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const CertificatesScreen({super.key, this.onBack});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  String _selectedFilter = "All";
  final List<String> _filters = [
    "All",
    "Course completion",
    "Assessment achievement",
    "Merit",
    "Appreciation"
  ];

  final List<Map<String, dynamic>> _certificates = [
    {
      "id": "CIQ-2026-E4A7CF18",
      "type": "Course completion",
      "ribbon": "OF COURSE COMPLETION",
      "headerTitle": "CERTIFICATE OF COURSE COMPLETION",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'has successfully completed the course "Emerging Technologies" offered by the Department of Computer Science & Engineering, and passed its final assessment with 26 out of 30 marks.',
      "shortDesc":
          'has successfully completed the course "Emerging Technologies" offered by the Department of...',
      "grade": "A+ - Distinction",
      "score": "87%",
      "date": "21 October 2026",
      "box1Label": "GRADE",
      "box1Value": "A+ - Distinction",
      "box2Label": "SCORE",
      "box2Value": "87%",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "21 October 2026",
      "verified": true,
    },
    {
      "id": "CIQ-2026-E1453EBA",
      "type": "Assessment achievement",
      "ribbon": "OF ACHIEVEMENT",
      "headerTitle": "CERTIFICATE OF ACHIEVEMENT",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'has successfully completed the assessment "Computer Science & Engineering – Data Structures and Algorithms quiz" in Data Structures and Algorithms, Department of Computer Science & Engineering, securing 9 out of 10 marks.',
      "shortDesc":
          'has successfully completed the assessment "Computer Science & Engineering – Data Structures...',
      "grade": "O - Outstanding",
      "score": "90%",
      "date": "12 October 2026",
      "box1Label": "GRADE",
      "box1Value": "O - Outstanding",
      "box2Label": "SCORE",
      "box2Value": "90%",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "12 October 2026",
      "verified": true,
    },
    {
      "id": "CIQ-2026-031207A0",
      "type": "Merit",
      "ribbon": "OF MERIT",
      "headerTitle": "CERTIFICATE OF MERIT",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'has secured the First Rank in the Department of Computer Science and Engineering for the academic year 2025-26.',
      "shortDesc":
          'has secured the First Rank in the Department of Computer Science and Engineering for the academi...',
      "grade": "Rank 1",
      "score": "98%",
      "date": "9 October 2026",
      "box1Label": "EVENT",
      "box1Value": "Annual Academic Honors 2026",
      "box2Label": "FIELD",
      "box2Value": "CSE Rank 1",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "9 October 2026",
      "verified": true,
    },
    {
      "id": "CIQ-2026-FDD7F0F5",
      "type": "Appreciation",
      "ribbon": "OF APPRECIATION",
      "headerTitle": "CERTIFICATE OF APPRECIATION",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.',
      "shortDesc":
          'in recognition of the outstanding contribution as a student coordinator of the National Level Technical...',
      "grade": "Outstanding",
      "score": "100%",
      "date": "7 October 2026",
      "box1Label": "EVENT",
      "box1Value": "Technova2026",
      "box2Label": "ROLE",
      "box2Value": "Student Coordinator",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "7 October 2026",
      "verified": true,
    },
    {
      "id": "CIQ-2026-9A82D01F",
      "type": "Assessment achievement",
      "ribbon": "OF ACHIEVEMENT",
      "headerTitle": "CERTIFICATE OF ACHIEVEMENT",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'has successfully completed the assessment "Computer Science & Engineering – Web Technologies quiz" in Web Technologies, Department of Computer Science & Engineering, securing 8 out of 10 marks.',
      "shortDesc":
          'has successfully completed the assessment "Computer Science & Engineering – Web Technologies quiz"...',
      "grade": "A+ - Distinction",
      "score": "80%",
      "date": "5 October 2026",
      "box1Label": "GRADE",
      "box1Value": "A+ - Distinction",
      "box2Label": "SCORE",
      "box2Value": "80%",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "5 October 2026",
      "verified": true,
    },
    {
      "id": "CIQ-2026-538B0F2A",
      "type": "Assessment achievement",
      "ribbon": "OF ACHIEVEMENT",
      "headerTitle": "CERTIFICATE OF ACHIEVEMENT",
      "studentName": "Anand Kumar",
      "rollDept": "110124001 · Computer Science & Engineering",
      "description":
          'has successfully completed the assessment "Computer Science & Engineering – DBMS quiz" in DBMS, Department of Computer Science & Engineering, securing 6 out of 10 marks.',
      "shortDesc":
          'has successfully completed the assessment "Computer Science & Engineering – DBMS quiz" in DBMS...',
      "grade": "B - Second Class",
      "score": "60%",
      "date": "3 October 2026",
      "box1Label": "GRADE",
      "box1Value": "B - Second Class",
      "box2Label": "SCORE",
      "box2Value": "60%",
      "box3Label": "DATE OF ISSUE",
      "box3Value": "3 October 2026",
      "verified": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCerts = _selectedFilter == "All"
        ? _certificates
        : _certificates.where((c) => c["type"] == _selectedFilter).toList();

    return PortalPageBody(
      title: "My Certificates",
      category: "AI Course & Certification",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  AI Course & Certification  ›  My Certificates",
          category: "AI COURSE & CERTIFICATION",
          phase: "MVP",
          icon: Icons.workspace_premium_outlined,
          title: "My Certificates",
          subtitle:
              "Mark-based certificates (O, A+, A, B, C) with a public verification link for employers.",
          watermarkIcon: Icons.article_outlined,
        ),
        const SizedBox(height: 18),

        // 2. Filter Chips Bar
        _buildFilterChipsBar(),
        const SizedBox(height: 18),

        // 3. Main Area: Certificates Grid + Right Sidebar
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 950;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: _buildCertificatesGrid(filteredCerts),
                  ),
                  const SizedBox(width: 18),
                  SizedBox(
                    width: 250,
                    child: _buildCertificateGradesSidebar(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCertificatesGrid(filteredCerts),
                  const SizedBox(height: 24),
                  _buildCertificateGradesSidebar(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // --- FILTER CHIPS BAR ---
  Widget _buildFilterChipsBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.map((flt) {
          final isSelected = _selectedFilter == flt;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedFilter = flt),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  flt,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- CERTIFICATES GRID ---
  Widget _buildCertificatesGrid(List<Map<String, dynamic>> certs) {
    if (certs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.workspace_premium_outlined, size: 40, color: Color(0xFF94A3B8)),
              const SizedBox(height: 10),
              Text(
                "No certificates found in this category",
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final colCount = constraints.maxWidth >= 720 ? 2 : 1;
        if (colCount == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: certs.map((cert) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildCertificateCard(cert),
              );
            }).toList(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: certs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, idx) {
            final cert = certs[idx];
            return _buildCertificateCard(cert);
          },
        );
      },
    );
  }

  // --- CERTIFICATE CARD ---
  Widget _buildCertificateCard(Map<String, dynamic> cert) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Classical Academic Certificate Document Visual Preview
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: _buildCertificateVisualDocument(cert),
          ),

          // 2. Metadata & Actions
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cert["headerTitle"] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCFBF1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Verified",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  cert["shortDesc"] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF334155),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFF1F5F9), height: 1),
                const SizedBox(height: 8),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => _showFullCertificateModal(cert),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.print_outlined, size: 14, color: Color(0xFF0F172A)),
                              const SizedBox(width: 4),
                              Text(
                                "View & print",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () => _copyVerificationLink(cert["id"] as String),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.link, size: 14, color: Color(0xFF64748B)),
                              const SizedBox(width: 4),
                              Text(
                                "Copy verification link",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      cert["id"] as String,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
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

  // --- CLASSICAL PARCHMENT CERTIFICATE DOCUMENT VISUAL PREVIEW ---
  Widget _buildCertificateVisualDocument(Map<String, dynamic> cert) {
    return AspectRatio(
      aspectRatio: 1.48,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDF8),
        ),
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD4AF37), width: 1.8),
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8B6B23).withValues(alpha: 0.4), width: 0.8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Institution Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Institution Crest
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFB45309), width: 1),
                        color: const Color(0xFFFEF3C7),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "AIT",
                        style: GoogleFonts.cinzel(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF78350F),
                        ),
                      ),
                    ),
                    // Centered Institution Text
                    Column(
                      children: [
                        Text(
                          "ANNA INSTITUTE OF TECHNOLOGY",
                          style: GoogleFonts.cinzel(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "Affiliated to Tamil Nadu Technical University",
                          style: GoogleFonts.poppins(
                            fontSize: 6.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          "Chennai, Tamil Nadu",
                          style: GoogleFonts.poppins(
                            fontSize: 5.5,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                    // NAAC Accredited stamp
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 0.6),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        "NAAC\nACCREDITED",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 4.5,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),

                // Certificate Title
                Column(
                  children: [
                    Text(
                      "C E R T I F I C A T E",
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Gold Ribbon Banner
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF92400E),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB45309).withValues(alpha: 0.3),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        cert["ribbon"] as String,
                        style: GoogleFonts.cinzel(
                          fontSize: 6.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // Presentation & Student Name
                Column(
                  children: [
                    Text(
                      "This is to certify that",
                      style: GoogleFonts.tangerine(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      cert["studentName"] as String,
                      style: GoogleFonts.cinzel(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      cert["rollDept"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 5.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),

                // Description Paragraph
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    cert["description"] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 6.2,
                      color: const Color(0xFF334155),
                      height: 1.3,
                    ),
                  ),
                ),

                // 3 Boxes: Grade, Score, Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDocMetaBox(cert["box1Label"] as String, cert["box1Value"] as String),
                    const SizedBox(width: 4),
                    _buildDocMetaBox(cert["box2Label"] as String, cert["box2Value"] as String),
                    const SizedBox(width: 4),
                    _buildDocMetaBox(cert["box3Label"] as String, cert["box3Value"] as String),
                  ],
                ),

                // Bottom Row: Security QR, Rosette Seal, Signature Block
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // QR Code
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF0F172A), width: 0.8),
                          ),
                          child: const Icon(Icons.qr_code_2, size: 22, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SECURITY VERIFY",
                              style: GoogleFonts.poppins(
                                fontSize: 4.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              (cert["id"] as String).substring(0, 12),
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 4,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Golden Rosette Seal
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFD97706),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFB45309).withValues(alpha: 0.4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.workspace_premium, size: 14, color: Colors.white),
                        ),
                        Text(
                          "AIT",
                          style: GoogleFonts.cinzel(fontSize: 4.5, fontWeight: FontWeight.w800, color: const Color(0xFFB45309)),
                        ),
                      ],
                    ),

                    // Signature block
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Dr. Lakshmi Sundaram",
                          style: GoogleFonts.tangerine(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E3A8A),
                          ),
                        ),
                        Container(width: 60, height: 0.6, color: const Color(0xFF64748B)),
                        const SizedBox(height: 1),
                        Text(
                          "Dr. Lakshmi Sundaram",
                          style: GoogleFonts.poppins(
                            fontSize: 5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "Principal, Anna Institute of Technology",
                          style: GoogleFonts.poppins(
                            fontSize: 4,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
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

  Widget _buildDocMetaBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCBD5E1), width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$label : ",
            style: GoogleFonts.poppins(fontSize: 5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  // --- RIGHT SIDEBAR: CERTIFICATE GRADES ---
  Widget _buildCertificateGradesSidebar() {
    final grades = [
      {"grade": "O", "name": "Outstanding", "range": "90 - 100%", "isFail": false},
      {"grade": "A+", "name": "Distinction", "range": "80 - 89%", "isFail": false},
      {"grade": "A", "name": "First Class", "range": "70 - 79%", "isFail": false},
      {"grade": "B", "name": "Second Class", "range": "60 - 69%", "isFail": false},
      {"grade": "C", "name": "Pass", "range": "Pass mark - 59%", "isFail": false},
      {"grade": "RA", "name": "Re-appear (no certificate)", "range": "Below pass mark", "isFail": true},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certificate grades",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Based on your marks in the quiz",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          ...grades.map((g) {
            final isFail = g["isFail"] as bool;
            final bg = isFail ? const Color(0xFFFEE2E2) : const Color(0xFFFEF3C7);
            final textCol = isFail ? const Color(0xFFB91C1C) : const Color(0xFFB45309);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      g["grade"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: textCol,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          g["name"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          g["range"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 8),
          Divider(color: const Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 12),
          Text(
            "3 attempts per quiz. Your best mark counts, and a higher mark re-issues the certificate.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // --- ACTIONS ---
  void _copyVerificationLink(String certId) {
    Clipboard.setData(ClipboardData(text: "https://portal.colossusiq.edu/verify/$certId"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Verification link for $certId copied to clipboard!"),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFullCertificateModal(Map<String, dynamic> cert) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 680),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cert["headerTitle"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildCertificateVisualDocument(cert),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        _copyVerificationLink(cert["id"] as String);
                      },
                      icon: const Icon(Icons.link, size: 16),
                      label: const Text("Copy Link"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Preparing certificate for printing / PDF export..."),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.print, size: 16),
                      label: const Text("Print / Save PDF"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
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
}
