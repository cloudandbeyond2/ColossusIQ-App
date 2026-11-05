import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: CERTIFICATE REQUESTS SCREEN
// Exactly matches screenshots 1 & 2:
// - Blueprint grid gradient hero banner with watermark & badges
// - Certifying authority disclaimer notice banner
// - Two-column responsive split:
//     * Left: "Request a certificate" with 6 certificate types, recipient toggle,
//             student search, "What it is for" text area, event & date picker, and "Send to the Principal" button
//     * Right: Authentic framed certificate live preview (AIT crest, AICTE badge,
//             gold ribbon, calligraphy recipient name, QR verification, embossed gold seal, Dr. Lakshmi Sundaram signature)
// - Bottom: "My requests" card with blueprint graph paper empty state
// =============================================================================

class CertificateRequestsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CertificateRequestsScreen({super.key, this.onBack});

  @override
  State<CertificateRequestsScreen> createState() =>
      _CertificateRequestsScreenState();
}

class _CertificateRequestsScreenState extends State<CertificateRequestsScreen> {
  // Selected certificate type
  String _selectedType = "Appreciation";

  // Recipient toggle: 0 = "A student of this college", 1 = "Someone else (guest, staff, other college)"
  int _recipientIndex = 0;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController(
    text:
        "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.",
  );
  final TextEditingController _eventController = TextEditingController(
    text: "TECHNOVA 2026",
  );
  final TextEditingController _dateController = TextEditingController(
    text: "10/14/2026",
  );

  String _recipientName = "Recipient Name";

  final List<Map<String, dynamic>> _myRequests = [
    {
      'id': 'REQ-2026-081',
      'recipient': 'Karthik Raja',
      'type': 'Participation',
      'event': 'TECHNOVA 2026',
      'date': '10/14/2026',
      'purpose': 'in recognition of active participation in National Level Technical Symposium.',
      'status': 'Pending Approval',
      'statusColor': const Color(0xFFF59E0B),
      'submittedOn': 'Today 11:20 AM',
    },
    {
      'id': 'REQ-2026-079',
      'recipient': 'Aditi Rao',
      'type': 'Excellence',
      'event': 'Hackathon Grand Finale',
      'date': '10/08/2026',
      'purpose': 'for securing 1st prize in AI Innovation Sprint.',
      'status': 'Approved & Issued',
      'statusColor': const Color(0xFF10B981),
      'submittedOn': '12 Oct 2026',
    },
  ];

  final List<Map<String, String>> _certificateTypes = [
    {
      "title": "Appreciation",
      "subtitle": "Certificate of Appreciation",
      "ribbon": "OF APPRECIATION",
    },
    {
      "title": "Merit",
      "subtitle": "Certificate of Merit",
      "ribbon": "OF MERIT",
    },
    {
      "title": "Participation",
      "subtitle": "Certificate of Participation",
      "ribbon": "OF PARTICIPATION",
    },
    {
      "title": "Excellence",
      "subtitle": "Certificate of Excellence",
      "ribbon": "OF EXCELLENCE",
    },
    {
      "title": "Internship completion",
      "subtitle": "Certificate of Internship Completion",
      "ribbon": "OF INTERNSHIP COMPLETION",
    },
    {
      "title": "Workshop / training",
      "subtitle": "Certificate of Completion",
      "ribbon": "OF COMPLETION",
    },
  ];

  @override
  void initState() {
    super.initState();
    _purposeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _purposeController.dispose();
    _eventController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 950;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 16),

              // 2. Certifying Authority Disclaimer Notice
              _buildDisclaimerNotice(),
              const SizedBox(height: 20),

              // 3. Two-Column Split (Request Form + Live Preview)
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRequestFormCard(),
                    const SizedBox(height: 24),
                    _buildPreviewCard(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 9,
                      child: _buildRequestFormCard(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 12,
                      child: _buildPreviewCard(),
                    ),
                  ],
                ),
              const SizedBox(height: 24),

              // 4. "My requests" Card with graph paper empty state
              _buildMyRequestsCard(),
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
                  // Breadcrumbs (clean, no leading arrow)
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
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "AI Course & Certification",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Certificate Requests",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "AI COURSE & CERTIFICATION",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "MVP",
                        const Color(0xFF0F766E),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.military_tech_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Certificate Requests",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Ask the Principal to issue a certificate of appreciation, merit, participation, internship or workshop completion to a student or guest.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. DISCLAIMER NOTICE CARD
  // ===========================================================================
  Widget _buildDisclaimerNotice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.verified_user_outlined,
              color: Color(0xFF1E293B),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "The Principal is the college's certifying authority. Requests you send here are checked and signed by Dr. Lakshmi Sundaram; once approved, the certificate reaches the student's portal and can be verified online.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF334155),
                height: 1.45,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. LEFT: REQUEST FORM CARD
  // ===========================================================================
  Widget _buildRequestFormCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Request a certificate",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // Certificate type label
          Text(
            "Certificate type",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 10),

          // 6 Selectable cards (2 columns x 3 rows)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 74,
            ),
            itemCount: _certificateTypes.length,
            itemBuilder: (context, index) {
              final item = _certificateTypes[index];
              final isSelected = _selectedType == item["title"];
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedType = item["title"]!;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEEF2FF)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4F46E5)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item["title"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFF312E81)
                              : const Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Expanded(
                        child: Text(
                          item["subtitle"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isSelected
                                ? const Color(0xFF4338CA)
                                : const Color(0xFF64748B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),

          // Recipient Section
          Text(
            "Recipient",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // Segmented selector pill
          LayoutBuilder(
            builder: (context, constraints) {
              final isVeryNarrow = constraints.maxWidth < 360;
              final child1 = _buildRecipientOption(
                title: "A student of this college",
                isSelected: _recipientIndex == 0,
                onTap: () {
                  setState(() {
                    _recipientIndex = 0;
                    _recipientName = "Recipient Name";
                  });
                },
              );
              final child2 = _buildRecipientOption(
                title: "Someone else (guest, staff, other college)",
                isSelected: _recipientIndex == 1,
                onTap: () {
                  setState(() {
                    _recipientIndex = 1;
                    _recipientName = "Guest / External Delegate";
                  });
                },
              );

              if (isVeryNarrow) {
                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      child1,
                      const SizedBox(height: 4),
                      child2,
                    ],
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: child1),
                      const SizedBox(width: 4),
                      Expanded(child: child2),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // Search input field
          TextField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                _recipientName = val.trim().isNotEmpty ? val : "Recipient Name";
              });
            },
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Search by name or roll number...",
              hintStyle: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF94A3B8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // What it is for
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "What it is for (${_purposeController.text.length}/400)",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          TextField(
            controller: _purposeController,
            maxLines: 4,
            maxLength: 400,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    maxLength}) =>
                null,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF1E293B),
              height: 1.4,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5)),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Printed after the recipient's name. Start in lower case, e.g. \"in recognition of ...\", \"has secured ...\".",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              setState(() {
                _purposeController.text =
                    "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.";
              });
            },
            child: Text(
              "Use the example wording",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Event & Held on (optional)
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event / programme (optional)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _eventController,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "e.g. TECHNOVA 2026",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF4F46E5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Held on (optional)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: _pickDate,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "mm/dd/yyyy",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF4F46E5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Action Button: Send to the Principal
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitCertificateRequest,
              icon: const Icon(Icons.near_me_rounded, size: 16),
              label: Text(
                "Send to the Principal",
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4338CA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. RIGHT: LIVE CERTIFICATE PREVIEW
  // ===========================================================================
  Widget _buildPreviewCard() {
    final currentItem = _certificateTypes.firstWhere(
      (element) => element["title"] == _selectedType,
      orElse: () => _certificateTypes.first,
    );
    final ribbonText = currentItem["ribbon"] ?? "OF APPRECIATION";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preview",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),

        // Framed Canvas Container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFCFDF9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF1E293B), width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF8),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFD97706).withValues(alpha: 0.75),
                width: 1.2,
              ),
            ),
            child: Stack(
              children: [
                // Faint Watermark Seal
                Positioned.fill(
                  child: Center(
                    child: Opacity(
                      opacity: 0.045,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF1E293B),
                            width: 8,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.school_rounded,
                            size: 130,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Corner Accents
                const Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(
                    Icons.filter_vintage_rounded,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.filter_vintage_rounded,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: 14,
                    color: Color(0xFFD97706),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: 14,
                    color: Color(0xFFD97706),
                  ),
                ),

                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Header Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Logo: AIT
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD97706),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "AIT",
                              style: GoogleFonts.cinzel(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Center Details
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "ANNA INSTITUTE OF TECHNOLOGY",
                                style: GoogleFonts.cinzel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: const Color(0xFF0F172A),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Affiliated to Tamil Nadu Technical University",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Anna Institute of Technology, Chennai, Tamil Nadu\nPhone 9888876285 · office@ait.edu.in",
                                style: GoogleFonts.poppins(
                                  fontSize: 8.5,
                                  color: const Color(0xFF64748B),
                                  height: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Right Badge: AICTE APPROVED
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFFD97706),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "AICTE",
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              Text(
                                "APPROVED",
                                style: GoogleFonts.poppins(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Gold Diamond Divider
                    const Icon(
                      Icons.diamond_rounded,
                      size: 10,
                      color: Color(0xFFD97706),
                    ),
                    const SizedBox(height: 6),

                    // CERTIFICATE Title
                    Text(
                      "CERTIFICATE",
                      style: GoogleFonts.cinzel(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.5,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Ribbon Banner: OF APPRECIATION
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB45309),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFFB45309).withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        ribbonText,
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Sub-line
                    Text(
                      "This certificate is proudly presented to",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Recipient Name
                    Text(
                      _recipientName,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF854D0E),
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    // Purpose Text
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Text(
                        _purposeController.text.trim().isNotEmpty
                            ? _purposeController.text.trim()
                            : "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF1E293B),
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color:
                              const Color(0xFFD97706).withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "DATE OF ISSUE ",
                            style: GoogleFonts.poppins(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            _dateController.text.isNotEmpty
                                ? _dateController.text
                                : "14 October 2026",
                            style: GoogleFonts.poppins(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bottom Signatures & Seal Row
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 480,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left: QR Code box
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xFFCBD5E1)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.qr_code_2_rounded,
                                    size: 40,
                                    color: Color(0xFF0F172A),
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
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      "CIQ-0000-PREVIEW",
                                      style: GoogleFonts.poppins(
                                        fontSize: 7,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    Text(
                                      "colossus-iq-new.vercel.app/verify",
                                      style: GoogleFonts.poppins(
                                        fontSize: 6.5,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Center: Gold Seal Medallion
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const RadialGradient(
                                  colors: [
                                    Color(0xFFFDE68A),
                                    Color(0xFFD97706),
                                    Color(0xFFB45309),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD97706)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_rounded,
                                      size: 16,
                                      color: Color(0xFF78350F),
                                    ),
                                    Text(
                                      "VERIFIED",
                                      style: GoogleFonts.cinzel(
                                        fontSize: 5.5,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF78350F),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Right: Principal Signature
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Dr. Lakshmi Sundaram",
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E3A8A),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 1,
                                  color: const Color(0xFFCBD5E1),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. BOTTOM: "MY REQUESTS" CARD WITH GRAPH PAPER EMPTY STATE
  // ===========================================================================
  Widget _buildRecipientOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF0F172A)
                : const Color(0xFF64748B),
            height: 1.25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _submitCertificateRequest() {
    final name = _recipientName.trim();
    if (name.isEmpty || name == "Recipient Name") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a recipient name or select a student before submitting.",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newReq = {
      'id': 'REQ-2026-0${100 + _myRequests.length + 1}',
      'recipient': name,
      'type': _selectedType,
      'event': _eventController.text.trim().isNotEmpty ? _eventController.text.trim() : 'TECHNOVA 2026',
      'date': _dateController.text.trim().isNotEmpty ? _dateController.text.trim() : '10/14/2026',
      'purpose': _purposeController.text.trim(),
      'status': 'Pending Approval',
      'statusColor': const Color(0xFFF59E0B),
      'submittedOn': 'Just now',
    };

    setState(() {
      _myRequests.insert(0, newReq);
      _searchController.clear();
      _recipientName = "Recipient Name";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Certificate request for $name sent to Dr. Lakshmi Sundaram!",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _myRequests.remove(newReq);
            });
          },
        ),
      ),
    );
  }

  void _showPreviewRequestCertificateDialog(Map<String, dynamic> req) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFF4338CA), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Certificate Preview',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                              ),
                              Text(
                                '${req['id']} · ${req['type']}',
                                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Parchment preview box
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEFDF9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2D9C8), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ACHARYA INSTITUTE OF TECHNOLOGY',
                          style: GoogleFonts.cinzel(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: const Color(0xFF1E293B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Accredited by NAAC with \'A+\' Grade · Approved by AICTE',
                          style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF64748B)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Text(
                            'CERTIFICATE OF ${(req['type'] as String).toUpperCase()}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              color: const Color(0xFF92400E),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'This certificate is proudly presented to',
                          style: GoogleFonts.playfairDisplay(fontSize: 12, fontStyle: FontStyle.italic, color: const Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          req['recipient'] as String,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            req['purpose'] as String,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569), height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date: ${req['date']}', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                                Text('Event: ${req['event']}', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Dr. Lakshmi Sundaram', style: GoogleFonts.greatVibes(fontSize: 16, color: const Color(0xFF1E293B))),
                                Text('Principal & Certifying Authority', style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF64748B))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4338CA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Close Preview', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
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

  void _showEditRequestDialog(Map<String, dynamic> req) {
    final purposeCtrl = TextEditingController(text: req['purpose']);
    final eventCtrl = TextEditingController(text: req['event']);

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit_note_rounded, color: Color(0xFF4338CA), size: 22),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Edit Certificate Request',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text('Event Name', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: eventCtrl,
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text('What it is for (Citation)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: purposeCtrl,
                    maxLines: 3,
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            req['event'] = eventCtrl.text.trim();
                            req['purpose'] = purposeCtrl.text.trim();
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Updated request for ${req['recipient']}', style: GoogleFonts.poppins()),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4338CA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Save Changes', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
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

  void _withdrawRequest(Map<String, dynamic> req) {
    final idx = _myRequests.indexOf(req);
    setState(() {
      _myRequests.remove(req);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request ${req['id']} for ${req['recipient']} withdrawn.', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF475569),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              if (idx >= 0 && idx <= _myRequests.length) {
                _myRequests.insert(idx, req);
              } else {
                _myRequests.add(req);
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildMyRequestsCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                "My requests (${_myRequests.length})",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (_myRequests.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Live Sync Active',
                    style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFF4338CA)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          if (_myRequests.isEmpty)
            // Blueprint Graph Paper Box Empty State
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPaperPainter(
                          gridColor:
                              const Color(0xFF6366F1).withValues(alpha: 0.07),
                          step: 22.0,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No requests yet",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Requests you send to the Principal appear here with their status.",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myRequests.length,
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final req = _myRequests[i];
                final isPending = req['status'] == 'Pending Approval';

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  req['id'] as String,
                                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF4338CA)),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  req['type'] as String,
                                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF92400E)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (req['statusColor'] as Color).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              req['status'] as String,
                              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: req['statusColor'] as Color),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Text(
                        req['recipient'] as String,
                        style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Event: ${req['event']} · Date: ${req['date']} · Submitted: ${req['submittedOn']}',
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        req['purpose'] as String,
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.35),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      // Actions
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _showPreviewRequestCertificateDialog(req),
                              icon: const Icon(Icons.visibility_outlined, size: 14),
                              label: Text('Preview Certificate', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4338CA),
                                side: const BorderSide(color: Color(0xFFC7D2FE)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                            if (isPending) ...[
                              OutlinedButton.icon(
                                onPressed: () => _showEditRequestDialog(req),
                                icon: const Icon(Icons.edit_outlined, size: 14),
                                label: Text('Edit', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF334155),
                                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () => _withdrawRequest(req),
                                icon: const Icon(Icons.delete_outline_rounded, size: 14, color: Color(0xFFEF4444)),
                                label: Text('Withdraw', style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFFEF4444))),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

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
