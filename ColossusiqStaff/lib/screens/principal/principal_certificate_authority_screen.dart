import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/certificate_pdf_service.dart';

// =============================================================================
// PRINCIPAL: CERTIFICATE AUTHORITY SCREEN (Matches Images 2, 3, 4, 5)
// - Hero Blueprint Banner: "Home > AI Course & Certification > Certificate Authority"
//   Badges: "AI COURSE & CERTIFICATION", "MVP"
// - Warning Alert Banner: Certifying authority notice
// - 4 Stat KPI Cards: Issued by you (2), Waiting for approval (0), Revoked (0), Course & quiz certificates (6)
// - 4 Sub Tabs:
//     0: Issue certificate
//     1: Requests (Image 5)
//     2: Register (Image 2)
//     3: Certificate design (Image 3 & 4)
// - Fully interactive with live certificate preview, theme customization, search/filters, revocation and PDF generation.
// =============================================================================

class PrincipalCertificateAuthorityScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalCertificateAuthorityScreen({super.key, this.onBack});

  @override
  State<PrincipalCertificateAuthorityScreen> createState() =>
      _PrincipalCertificateAuthorityScreenState();
}

class _PrincipalCertificateAuthorityScreenState
    extends State<PrincipalCertificateAuthorityScreen> {
  int _activeSubTab = 0; // 0: Issue certificate, 1: Requests, 2: Register, 3: Certificate design
  int _selectedCertType = 0; // 0: Appreciation, 1: Merit, 2: Participation, etc.
  int _selectedRecipientType = 0; // 0: Student, 1: Guest/Other

  // Form controllers for "Issue Certificate"
  final TextEditingController _reasonController = TextEditingController(
    text:
        "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.",
  );
  final TextEditingController _recipientNameController =
      TextEditingController(text: "");
  final TextEditingController _guestNameController =
      TextEditingController(text: "");
  final TextEditingController _guestDesignationController =
      TextEditingController(text: "");
  final TextEditingController _eventController =
      TextEditingController(text: "TECHNOVA 2026");
  final TextEditingController _dateController =
      TextEditingController(text: "20 November 2026");

  // Form controllers for "Certificate Design" (Image 3 & 4)
  final TextEditingController _collegeNameController =
      TextEditingController(text: "Anna Institute of Technology");
  final TextEditingController _affiliationController =
      TextEditingController(text: "Affiliated to Tamil Nadu Technical University");
  final TextEditingController _addressController =
      TextEditingController(text: "Chennai, Tamil Nadu");
  final TextEditingController _contactController =
      TextEditingController(text: "Phone 9840012345 · office@ait.edu.in");
  final TextEditingController _accreditationController =
      TextEditingController(text: "NAAC accredited");
  final TextEditingController _mottoController =
      TextEditingController(text: "");
  final TextEditingController _principalNameController =
      TextEditingController(text: "Dr. Lakshmi Sundaram");
  final TextEditingController _designationController =
      TextEditingController(text: "Principal");

  // Selected Color Theme for Certificate:
  // 0: Classic navy & gold, 1: Royal blue, 2: Emerald, 3: Heritage maroon
  int _selectedThemeIndex = 0;
  final List<Map<String, dynamic>> _themeOptions = [
    {
      "name": "Classic navy & gold",
      "primary": Color(0xFF1E2865),
      "gold": Color(0xFFB45309),
      "ribbon": Color(0xFFD97706),
      "bullet": Color(0xFF1E2865),
    },
    {
      "name": "Royal blue",
      "primary": Color(0xFF1D4ED8),
      "gold": Color(0xFF2563EB),
      "ribbon": Color(0xFF2563EB),
      "bullet": Color(0xFF2563EB),
    },
    {
      "name": "Emerald",
      "primary": Color(0xFF065F46),
      "gold": Color(0xFF059669),
      "ribbon": Color(0xFF10B981),
      "bullet": Color(0xFF059669),
    },
    {
      "name": "Heritage maroon",
      "primary": Color(0xFF881337),
      "gold": Color(0xFF9F1239),
      "ribbon": Color(0xFFBE123C),
      "bullet": Color(0xFF9F1239),
    },
  ];

  // Register Search & Filter (Image 2)
  final TextEditingController _registerSearchController = TextEditingController();
  String _registerFilter = "All"; // "All", "Issued", "Revoked", "Rejected"

  // Registered Certificates Data (Image 2)
  late List<Map<String, dynamic>> _registeredCertificates;

  final List<Map<String, String>> _certTypes = [
    {"title": "Appreciation", "subtitle": "Certificate of Appreciation"},
    {"title": "Merit", "subtitle": "Certificate of Merit"},
    {"title": "Participation", "subtitle": "Certificate of Participation"},
    {"title": "Excellence", "subtitle": "Certificate of Excellence"},
    {"title": "Internship completion", "subtitle": "Certificate of Internship Completion"},
    {"title": "Workshop / training", "subtitle": "Certificate of Completion"},
  ];

  @override
  void initState() {
    super.initState();
    _registeredCertificates = [
      {
        "id": "CIQ-2026-031207A0",
        "recipient": "Anand Kumar",
        "sub": "110124001 · Computer Science & Engineering",
        "type": "Merit",
        "issued": "8 Oct 2026",
        "status": "Issued",
      },
      {
        "id": "CIQ-2026-FDD7F0F5",
        "recipient": "Anand Kumar",
        "sub": "110124001 · Computer Science & Engineering",
        "type": "Appreciation",
        "issued": "7 Oct 2026",
        "status": "Issued",
      },
    ];
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _recipientNameController.dispose();
    _guestNameController.dispose();
    _guestDesignationController.dispose();
    _eventController.dispose();
    _dateController.dispose();

    _collegeNameController.dispose();
    _affiliationController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _accreditationController.dispose();
    _mottoController.dispose();
    _principalNameController.dispose();
    _designationController.dispose();
    _registerSearchController.dispose();
    super.dispose();
  }

  int get _issuedByYouCount =>
      _registeredCertificates.where((c) => c["status"] == "Issued").length;

  int get _revokedCount =>
      _registeredCertificates.where((c) => c["status"] == "Revoked").length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1050;
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Images 4 & 5)
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. WARNING ALERT BANNER (Image 4)
                _buildWarningBanner(),
                const SizedBox(height: 18),

                // 3. 4 STAT KPI CARDS (Image 5: 2, 0, 0, 6)
                _buildKpiCards(constraints.maxWidth >= 850),
                const SizedBox(height: 18),

                // 4. SUB TABS: Issue certificate, Requests, Register, Certificate design
                _buildSubTabs(),
                const SizedBox(height: 20),

                // 5. ACTIVE TAB VIEW CONTENT
                _buildActiveTabContent(isWide),
              ],
            ),
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
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
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
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.verified_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (Scrollable on small devices)
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
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text("Home",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("AI Course & Certification",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Certificate Authority",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges: AI COURSE & CERTIFICATION, MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "AI COURSE & CERTIFICATION",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "MVP",
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

                  // Title + Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.settings_suggest_rounded,
                            color: Color(0xFFFBBF24), // Yellow Gear/Seal
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Certificate Authority",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Design the college certificate (header, seal, signature), issue appreciation, merit, participation and other certificates, approve requests from faculty, and keep the register. Every certificate is QR-verifiable.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
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
  // 2. WARNING ALERT BANNER (Image 4)
  // ===========================================================================
  Widget _buildWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 16, color: Color(0xFFC2410C)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "You are the college's certifying authority: every certificate is signed under your name and can be revoked only by you.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF9A3412),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. 4 STAT KPI CARDS (Image 5: 2, 0, 0, 6)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      _buildSingleKpi("Issued by you", "$_issuedByYouCount",
          Icons.article_outlined, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Waiting for approval", "0",
          Icons.access_time_rounded, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Revoked", "$_revokedCount",
          Icons.highlight_off_rounded, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Course & quiz certificates", "6",
          Icons.school_outlined, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: c,
                  ),
                ))
            .toList(),
      );
    } else {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: cards
            .map((c) => SizedBox(
                  width: 170,
                  child: c,
                ))
            .toList(),
      );
    }
  }

  Widget _buildSingleKpi(String label, String value, IconData icon, Color iconColor, Color iconBg) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. SUB TABS: Issue certificate, Requests, Register, Certificate design
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      "Issue certificate",
      "Requests",
      "Register",
      "Certificate design",
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3EFE8), // Warm beige pill background from Image 1
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(tabs.length, (index) {
            final isSelected = _activeSubTab == index;
            return InkWell(
              onTap: () => setState(() => _activeSubTab = index),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 7.5),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(color: const Color(0xFFE2E8F0))
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  tabs[index],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. ACTIVE TAB VIEW CONTENT
  // ===========================================================================
  Widget _buildActiveTabContent(bool isWide) {
    switch (_activeSubTab) {
      case 0:
        // Issue Certificate
        return _buildIssueTabContent(isWide);
      case 1:
        // Requests (Image 5)
        return _buildRequestsTabContent();
      case 2:
        // Register (Image 2)
        return _buildRegisterTabContent();
      case 3:
        // Certificate Design (Image 3 & 4)
        return _buildCertificateDesignTabContent(isWide);
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // TAB 0: ISSUE CERTIFICATE
  // ---------------------------------------------------------------------------
  Widget _buildIssueTabContent(bool isWide) {
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _buildIssueForm(),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 7,
            child: _buildLiveCertificatePreview(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildLiveCertificatePreview(),
          const SizedBox(height: 20),
          _buildIssueForm(),
        ],
      );
    }
  }

  Widget _buildIssueForm() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            "Issue a certificate",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Signed under your authority as Principal. It is verifiable online the moment you issue it.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // Certificate type
          Text(
            "Certificate type",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 10),

          // 2-column grid of 6 certificate types
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_certTypes.length, (index) {
                  final isSelected = _selectedCertType == index;
                  final item = _certTypes[index];
                  final width = (constraints.maxWidth - 20) / 2;
                  return InkWell(
                    onTap: () => setState(() => _selectedCertType = index),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: width.clamp(130, 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFEFF6FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF1E40AF)
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item["subtitle"]!,
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
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 18),

          // Recipient Section (Exact to Image 2 & Image 3)
          Text(
            "Recipient",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // Recipient segmented bar (Image 2 & 3)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1EDE6), // Warm neutral beige
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedRecipientType = 0),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _selectedRecipientType == 0 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: _selectedRecipientType == 0
                            ? Border.all(color: const Color(0xFFE2E8F0))
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "A student of this college",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: _selectedRecipientType == 0 ? FontWeight.w600 : FontWeight.w500,
                          color: _selectedRecipientType == 0 ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedRecipientType = 1),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _selectedRecipientType == 1 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: _selectedRecipientType == 1
                            ? Border.all(color: const Color(0xFFB45309), width: 1.5)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Someone else (guest,\nstaff, other college)",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: _selectedRecipientType == 1 ? FontWeight.w600 : FontWeight.w500,
                          color: _selectedRecipientType == 1 ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Conditional Input Fields based on recipient type (Image 2 vs Image 3)
          if (_selectedRecipientType == 0) ...[
            // Student Search (Image 2)
            Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _recipientNameController,
                onChanged: (_) => setState(() {}),
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: const InputDecoration(
                  hintText: "Search by name or roll number...",
                  hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
          ] else ...[
            // Full name & Designation (Image 3)
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 360;
                final fullNameField = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full name",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _guestNameController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: const InputDecoration(
                          hintText: "",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                );

                final designationField = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Designation / institution (optional)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _guestDesignationController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: const InputDecoration(
                          hintText: "e.g. Resource person, In",
                          hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    children: [
                      fullNameField,
                      const SizedBox(height: 10),
                      designationField,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: fullNameField),
                    const SizedBox(width: 12),
                    Expanded(child: designationField),
                  ],
                );
              },
            ),
          ],
          const SizedBox(height: 18),

          // What it is for (0/400)
          Text(
            "What it is for (${_reasonController.text.length}/400)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _reasonController,
              maxLines: 4,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 12, height: 1.4),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Printed after the recipient's name. Start in lower case, e.g. \"in recognition of ...\", \"has secured ...\".",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              setState(() {
                _reasonController.text =
                    "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.";
              });
            },
            child: Text(
              "Use the example wording",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Event & Held on (optional)
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 360;
              final eventField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event / programme (optional)",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _eventController,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: "e.g. TECHNOVA 2026",
                        hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ),
                ],
              );

              final dateField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Held on (optional)",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _dateController,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: "mm/dd/yyyy",
                        suffixIcon: Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF94A3B8)),
                        hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ),
                ],
              );

              if (isSmall) {
                return Column(
                  children: [
                    eventField,
                    const SizedBox(height: 12),
                    dateField,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: eventField),
                  const SizedBox(width: 12),
                  Expanded(child: dateField),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Sign & issue certificate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final newId =
                    "CIQ-2026-${DateTime.now().millisecondsSinceEpoch.toRadixString(16).toUpperCase()}";
                setState(() {
                  _registeredCertificates.insert(0, {
                    "id": newId,
                    "recipient": _recipientNameController.text.trim().isEmpty
                        ? "Recipient Name"
                        : _recipientNameController.text.trim(),
                    "sub": "110124001 · Computer Science & Engineering",
                    "type": _certTypes[_selectedCertType]["title"]!,
                    "issued": _dateController.text.trim(),
                    "status": "Issued",
                  });
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Certificate digitally signed and issued to ${_recipientNameController.text}! Certificate ID: $newId",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.assignment_turned_in_outlined, size: 16, color: Colors.white),
              label: Text(
                "Sign & issue certificate",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3880), // Deep royal navy
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }



  // ---------------------------------------------------------------------------
  // TAB 1: REQUESTS (Exact to Image 5)
  // ---------------------------------------------------------------------------
  Widget _buildRequestsTabContent() {
    return Container(
      width: double.infinity,
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
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFCBD5E1).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightGridPainter(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "No requests waiting",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "When faculty or HODs request a certificate, it waits here for your approval.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                          height: 1.45,
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
  }

  // ---------------------------------------------------------------------------
  // TAB 2: REGISTER (Exact to Image 2)
  // ---------------------------------------------------------------------------
  Widget _buildRegisterTabContent() {
    final query = _registerSearchController.text.trim().toLowerCase();
    final filtered = _registeredCertificates.where((cert) {
      final matchesSearch = query.isEmpty ||
          cert["id"]!.toLowerCase().contains(query) ||
          cert["recipient"]!.toLowerCase().contains(query) ||
          cert["type"]!.toLowerCase().contains(query);

      final matchesStatus = _registerFilter == "All" ||
          cert["status"]!.toLowerCase() == _registerFilter.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header & Filters
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Certificate register",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Every certificate issued, rejected or revoked under your authority.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Search & Filter Pills Row (Image 2)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      Container(
                        width: 240,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: TextField(
                          controller: _registerSearchController,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(fontSize: 12.5),
                          decoration: const InputDecoration(
                            hintText: "Search name, ID or event",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Status Pills: All, Issued, Revoked, Rejected
                      Row(
                        children: ["All", "Issued", "Revoked", "Rejected"]
                            .map((filter) {
                          final isSelected = _registerFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () =>
                                  setState(() => _registerFilter = filter),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1E293B) // Dark Navy pill
                                      : const Color(0xFFF1F5F9), // Light gray pill
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  filter,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Registered Certificates Data Table
          filtered.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      "No certificates in this filter",
                      style: GoogleFonts.poppins(color: const Color(0xFF94A3B8)),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 800),
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                      headingTextStyle: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                      dataRowMinHeight: 52,
                      dataRowMaxHeight: 64,
                      horizontalMargin: 20,
                      columnSpacing: 24,
                      columns: const [
                        DataColumn(label: Text("CERTIFICATE")),
                        DataColumn(label: Text("RECIPIENT")),
                        DataColumn(label: Text("TYPE")),
                        DataColumn(label: Text("ISSUED")),
                        DataColumn(label: Text("STATUS")),
                        DataColumn(label: Text("ACTION")),
                      ],
                      rows: filtered.map((cert) {
                        final isRevoked = cert["status"] == "Revoked";
                        return DataRow(
                          cells: [
                            // 1. Certificate ID (Image 2)
                            DataCell(
                              Text(
                                cert["id"]!,
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                            ),

                            // 2. Recipient + Department Subtitle
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cert["recipient"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Text(
                                    cert["sub"]!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 3. Type
                            DataCell(
                              Text(
                                cert["type"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),

                            // 4. Issued Date
                            DataCell(
                              Text(
                                cert["issued"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),

                            // 5. Status Pill
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isRevoked
                                      ? const Color(0xFFFEF2F2)
                                      : const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  cert["status"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isRevoked
                                        ? const Color(0xFFDC2626)
                                        : const Color(0xFF059669),
                                  ),
                                ),
                              ),
                            ),

                            // 6. Action: Revoke Button with Red Icon (Image 2)
                            DataCell(
                              isRevoked
                                  ? Text(
                                      "Revoked",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () => _confirmRevoke(cert),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.do_not_disturb_on_outlined,
                                              size: 15, color: Color(0xFFDC2626)),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Revoke",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFDC2626),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _confirmRevoke(Map<String, dynamic> cert) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Revoke Certificate", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text(
          "Are you sure you want to revoke certificate ${cert["id"]} issued to ${cert["recipient"]}? Once revoked, QR scans will report this certificate as invalid.",
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                cert["status"] = "Revoked";
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Certificate ${cert["id"]} revoked under Principal authority."),
                  backgroundColor: const Color(0xFFDC2626),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
            child: const Text("Revoke Certificate", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 3: CERTIFICATE DESIGN (Exact to Images 3 & 4)
  // ---------------------------------------------------------------------------
  Widget _buildCertificateDesignTabContent(bool isWide) {
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Design Settings Form (Images 3 & 4)
          Expanded(
            flex: 5,
            child: _buildDesignSettingsForm(),
          ),
          const SizedBox(width: 20),
          // Right: Live Preview (Image 3)
          Expanded(
            flex: 7,
            child: _buildLiveCertificatePreview(titlePrefix: "Live preview (sample certificate)"),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildLiveCertificatePreview(titlePrefix: "Live preview (sample certificate)"),
          const SizedBox(height: 20),
          _buildDesignSettingsForm(),
        ],
      );
    }
  }

  Widget _buildDesignSettingsForm() {
    return Container(
      padding: const EdgeInsets.all(22),
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
            "Certificate design",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Applies to every certificate your college issues: course, quiz and those you sign.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // Section 1: HEADER
          Text(
            "HEADER",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "College name",
            controller: _collegeNameController,
            hint: "Anna Institute of Technology",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Affiliation / university line",
            controller: _affiliationController,
            hint: "Affiliated to Tamil Nadu Technical University",
            helper: "e.g. Affiliated to .. Approved by AICTE, New Delhi",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Address",
            controller: _addressController,
            hint: "Chennai, Tamil Nadu",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Contact line (optional)",
            controller: _contactController,
            hint: "Phone 9840012345 · office@ait.edu.in",
            helper: "Phone, e-mail or website",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Accreditation badge (optional)",
            controller: _accreditationController,
            hint: "NAAC accredited",
            helper: "e.g. NAAC A++ · NBA Accredited",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Motto (optional)",
            controller: _mottoController,
            hint: "",
          ),
          const SizedBox(height: 22),

          // Section 2: SEAL & SIGNATURE (Image 4)
          Text(
            "SEAL & SIGNATURE",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14),

          _buildUploadRow(
            label: "College logo",
            helper: "Square PNG with a transparent background works best.",
          ),
          const SizedBox(height: 14),

          _buildUploadRow(
            label: "College seal",
            helper:
                "A scan of the round seal. Without one, a seal is drawn from the college name.",
          ),
          const SizedBox(height: 14),

          _buildUploadRow(
            label: "Principal's signature",
            helper:
                "Sign on white paper, scan, and crop tightly. Without one, your name is set in script.",
          ),
          const SizedBox(height: 14),

          _buildDesignField(
            label: "Principal's name (printed under the signature)",
            controller: _principalNameController,
            hint: "Dr. Lakshmi Sundaram",
          ),
          const SizedBox(height: 12),

          _buildDesignField(
            label: "Designation",
            controller: _designationController,
            hint: "Principal",
          ),
          const SizedBox(height: 18),

          // Colour theme (Image 4)
          Text(
            "Colour theme",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // 2x2 grid of themes (Image 4)
          LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 10,
                children: List.generate(_themeOptions.length, (idx) {
                  final isSelected = _selectedThemeIndex == idx;
                  final theme = _themeOptions[idx];
                  return InkWell(
                    onTap: () => setState(() => _selectedThemeIndex = idx),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: width.clamp(140, 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: theme["bullet"] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              theme["name"] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 24),

          // Save design button (Image 4)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Certificate design saved successfully! All newly issued and previewed certificates will reflect these styles.",
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: const Color(0xFF1E2865),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF283685), // Rich indigo/navy
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Save design",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? helper,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 3),
          Text(
            helper,
            style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8)),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadRow({
    required String label,
    required String helper,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail placeholder (Image 4)
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined,
                    size: 24, color: Color(0xFF94A3B8)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Selected file for $label"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.upload_rounded,
                        size: 15, color: Color(0xFF0F172A)),
                    label: Text(
                      "Upload",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    helper,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // Right Column: Live Certificate Preview (Exact to Images 3, 4 & 5)
  // ===========================================================================
  Widget _buildLiveCertificatePreview({String titlePrefix = "Live preview"}) {
    final certTypeLabel = _certTypes[_selectedCertType]["title"]!.toUpperCase();
    final theme = _themeOptions[_selectedThemeIndex];
    final Color primaryColor = theme["primary"] as Color;
    final Color ribbonColor = theme["ribbon"] as Color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titlePrefix,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  await CertificatePdfService.printOrSavePdf(
                    recipient: _recipientNameController.text.trim().isEmpty
                        ? "Anand Kumar"
                        : _recipientNameController.text.trim(),
                    type: _certTypes[_selectedCertType]["title"]!,
                    event: _eventController.text.trim(),
                    date: _dateController.text.trim(),
                    certId: "CIQ-2026-PREVIEW",
                    citation: _reasonController.text.trim(),
                  );
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error generating PDF: $e")),
                    );
                  }
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.print_outlined, size: 14, color: Color(0xFF2563EB)),
                  const SizedBox(width: 4),
                  Text(
                    "Print PDF",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // The Certificate Canvas (Scaled down gracefully on mobile to eliminate overflow)
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 580,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFBF7), // Warm Parchment Ivory
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5), // Gold outline
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 2), // Themed ornate frame
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        // Header Row: AIT Seal, College Title, NAAC Accredited Badge (Image 3)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // AIT Gold Seal
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFB45309), width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "AIT",
                                  style: GoogleFonts.cinzel(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ),

                            // College Heading & Affiliation
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    _collegeNameController.text.trim().toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cinzel(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _affiliationController.text.trim(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 9.5, color: const Color(0xFF64748B)),
                                  ),
                                  Text(
                                    "${_addressController.text.trim()}\n${_contactController.text.trim()}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 8.5, color: const Color(0xFF94A3B8)),
                                  ),
                                ],
                              ),
                            ),

                            // NAAC Accredited badge (Image 3)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFB45309)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _accreditationController.text.trim().toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 7.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),

                        // CERTIFICATE Title (Image 3)
                        Text(
                          "CERTIFICATE",
                          style: GoogleFonts.cinzel(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // OF APPRECIATION (Amber/Theme Ribbon Banner, Image 3)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: ribbonColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "OF $certTypeLabel",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Presented To Subtext
                        Text(
                          "This certificate is proudly presented to",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Recipient Name (Exact to Image 1 & 2: "Recipient Name" by default)
                        Builder(
                          builder: (context) {
                            String displayName = "Recipient Name";
                            String? displaySub;

                            if (_selectedRecipientType == 0) {
                              if (_recipientNameController.text.trim().isNotEmpty) {
                                displayName = _recipientNameController.text.trim();
                                displaySub = "21CS1014 · B.E. Computer Science & Engineering";
                              }
                            } else {
                              if (_guestNameController.text.trim().isNotEmpty) {
                                displayName = _guestNameController.text.trim();
                              }
                              if (_guestDesignationController.text.trim().isNotEmpty) {
                                displaySub = _guestDesignationController.text.trim();
                              }
                            }

                            return Column(
                              children: [
                                Text(
                                  displayName,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xFFB45309), // Bronze Gold
                                  ),
                                ),
                                if (displaySub != null) ...[
                                  const SizedBox(height: 3),
                                  Text(
                                    displaySub,
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // Body reason (Image 1 & 2)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            _reasonController.text.trim(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF334155),
                              height: 1.45,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // DATE BADGE (Exact to Image 1 & 2)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 3.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFD97706)),
                          ),
                          child: Text(
                            "DATE OF ISSUE ${_dateController.text.trim()}",
                            style: GoogleFonts.poppins(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Bottom Row: QR Code, Gold Certified Ribbon Seal, Principal Signature (Image 3)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 520,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // QR Code (Image 3)
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xFFCBD5E1)),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.qr_code_2_rounded,
                                            size: 44, color: Color(0xFF0F172A)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "SCAN TO VERIFY",
                                          style: GoogleFonts.poppins(
                                            fontSize: 7.5,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF64748B),
                                          ),
                                        ),
                                        Text(
                                          "CIQ-0000-PREVIEW",
                                          style: GoogleFonts.poppins(
                                            fontSize: 7.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                        Text(
                                          "localhost:3000/verify",
                                          style: GoogleFonts.poppins(
                                              fontSize: 7,
                                              color: const Color(0xFF94A3B8)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Center Authentic Gold Ribbon Stamp (Image 3)
                                Column(
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFBBF24),
                                            Color(0xFFB45309)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.verified_rounded,
                                            color: Colors.white, size: 24),
                                      ),
                                    ),
                                  ],
                                ),

                                // Principal Signature & Stamp (Image 3)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // AIT Stamp Icon
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color(0xFF94A3B8)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "AIT",
                                          style: GoogleFonts.cinzel(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF64748B),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Script Signature
                                    Text(
                                      _principalNameController.text.trim().isEmpty
                                          ? "Dr. Lakshmi Sundaram"
                                          : _principalNameController.text.trim(),
                                      style: GoogleFonts.dancingScript(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),

                                    // Printed Name
                                    Text(
                                      _principalNameController.text.trim().isEmpty
                                          ? "Dr. Lakshmi Sundaram"
                                          : _principalNameController.text.trim(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      "${_designationController.text.trim()}, ${_collegeNameController.text.trim()}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 7.5,
                                          color: const Color(0xFF64748B)),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// GRID PAINTERS
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

class _LightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.5)
      ..strokeWidth = 0.8;

    const double step = 26.0;

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
