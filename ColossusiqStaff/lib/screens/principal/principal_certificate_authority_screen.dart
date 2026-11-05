import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: CERTIFICATE AUTHORITY SCREEN (Matches Images 4 & 5)
// - Hero Blueprint Banner: "Home > AI Course & Certification > Certificate Authority", badges AI COURSE & CERTIFICATION, MVP
// - Warning Alert Banner: Certifying authority notice
// - 4 Stat KPI Cards: Issued by you (0), Waiting for approval (0), Revoked (0), Course & quiz certificates (0)
// - Sub Tabs: Issue certificate, Requests, Register, Certificate design
// - Form & Live Certificate Preview split layout (Fully Responsive)
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

  final TextEditingController _reasonController = TextEditingController(
    text:
        "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.",
  );
  final TextEditingController _recipientNameController =
      TextEditingController(text: "Recipient Name");
  final TextEditingController _eventController =
      TextEditingController(text: "TECHNOVA 2026");
  final TextEditingController _dateController =
      TextEditingController(text: "20 October 2026");

  final List<Map<String, String>> _certTypes = [
    {"title": "Appreciation", "subtitle": "Certificate of Appreciation"},
    {"title": "Merit", "subtitle": "Certificate of Merit"},
    {"title": "Participation", "subtitle": "Certificate of Participation"},
    {"title": "Excellence", "subtitle": "Certificate of Excellence"},
    {"title": "Internship completion", "subtitle": "Certificate of Internship Completion"},
    {"title": "Workshop / training", "subtitle": "Certificate of Completion"},
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    _recipientNameController.dispose();
    _eventController.dispose();
    _dateController.dispose();
    super.dispose();
  }

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

                // 3. 4 STAT KPI CARDS (Image 4)
                _buildKpiCards(constraints.maxWidth >= 850),
                const SizedBox(height: 18),

                // 4. SUB TABS: Issue certificate, Requests, Register, Certificate design
                _buildSubTabs(),
                const SizedBox(height: 20),

                // 5. MAIN SPLIT: ISSUE FORM & LIVE CERTIFICATE PREVIEW (Images 4 & 5)
                _buildMainContent(isWide),
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
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
  // 3. 4 STAT KPI CARDS (Image 4)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      _buildSingleKpi("Issued by you", "0", Icons.article_outlined, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Waiting for approval", "0", Icons.access_time_rounded, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Revoked", "0", Icons.highlight_off_rounded, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
      _buildSingleKpi("Course & quiz certificates", "0", Icons.school_outlined, const Color(0xFFD97706), const Color(0xFFFEF3C7)),
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
  // 4. SUB TABS (Image 4)
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
        color: const Color(0xFFF1F5F9).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(3),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(tabs.length, (index) {
            final isSelected = _activeSubTab == index;
            return InkWell(
              onTap: () => setState(() => _activeSubTab = index),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
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
  // 5. MAIN CONTENT: FORM (LEFT) + LIVE PREVIEW (RIGHT)
  // ===========================================================================
  Widget _buildMainContent(bool isWide) {
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Issue Form
          Expanded(
            flex: 5,
            child: _buildIssueForm(),
          ),
          const SizedBox(width: 20),
          // Right: Live Preview
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

  // Form Section
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

          // Recipient
          Text(
            "Recipient",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // Recipient tabs
          Row(
            children: [
              _buildRecipientTypeBtn(0, "A student of this"),
              const SizedBox(width: 8),
              _buildRecipientTypeBtn(1, "Someone else (guest, ..."),
            ],
          ),
          const SizedBox(height: 10),

          // Search student or recipient name
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
          const SizedBox(height: 18),

          // What it is for (0/400)
          Text(
            "What it is for (0/400)",
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Certificate digitally signed and issued to ${_recipientNameController.text}!",
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

  Widget _buildRecipientTypeBtn(int index, String label) {
    final isSelected = _selectedRecipientType == index;
    return InkWell(
      onTap: () => setState(() => _selectedRecipientType = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F5F9) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // Right Column: Live Certificate Preview (Images 4 & 5)
  // ===========================================================================
  Widget _buildLiveCertificatePreview() {
    final certTypeLabel = _certTypes[_selectedCertType]["title"]!.toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Live preview",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
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
                border: Border.all(color: const Color(0xFF1E2865), width: 2), // Navy ornate frame
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  // Header Row: AIT Seal, College Title, AICTE Stamp
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

                      // College Heading
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "ANNA INSTITUTE OF TECHNOLOGY",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Affiliated to Tamil Nadu Technical University",
                              style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF64748B)),
                            ),
                            Text(
                              "Anna Institute of Technology, Chennai, Tamil Nadu\nPhone: 9888876285 · office@ait.edu.in",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 8.5, color: const Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                      ),

                      // AICTE Approved
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFD97706)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "AICTE",
                              style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w700, color: const Color(0xFFD97706)),
                            ),
                            Text(
                              "APPROVED",
                              style: GoogleFonts.poppins(fontSize: 7, fontWeight: FontWeight.w600, color: const Color(0xFFD97706)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // CERTIFICATE Title
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

                  // OF APPRECIATION (Amber Ribbon Banner)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD97706),
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
                  const SizedBox(height: 10),

                  // Recipient Name (Italic script font)
                  Text(
                    _recipientNameController.text.trim().isEmpty
                        ? "Recipient Name"
                        : _recipientNameController.text.trim(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFFB45309), // Bronze/Gold
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Body reason
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _reasonController.text.trim(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Text(
                      "DATE OF ISSUE: ${_dateController.text.trim()}",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bottom Row: QR Code, Gold Certified Ribbon Seal, Principal Signature
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // QR Code
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF0F172A)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SCAN TO VERIFY",
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "CIQ-0000-PREVIEW",
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                "colossus-iq-new.vercel.app/verify",
                                style: GoogleFonts.poppins(fontSize: 7, color: const Color(0xFF94A3B8)),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Center Authentic Gold Ribbon Stamp
                      Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFFBBF24), Color(0xFFB45309)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.check_rounded, color: Colors.white, size: 24),
                            ),
                          ),
                        ],
                      ),

                      // Principal Signature
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Dr. Lakshmi Sundaram",
                            style: GoogleFonts.dancingScript(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                          Container(width: 110, height: 1, color: const Color(0xFFCBD5E1)),
                          const SizedBox(height: 2),
                          Text(
                            "Dr. Lakshmi Sundaram",
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "Principal, Anna Institute of Technology",
                            style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF64748B)),
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
      ),
    ),
  ),
],
);
}
}

// =============================================================================
// GRID PAINTER
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
