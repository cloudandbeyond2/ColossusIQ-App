import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/certificate_pdf_service.dart';

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
  final TextEditingController _guestNameController = TextEditingController();
  final TextEditingController _guestDesignationController =
      TextEditingController();
  final TextEditingController _purposeController = TextEditingController(
    text:
        "in recognition of the outstanding contribution as a student coordinator of the National Level Technical Symposium.",
  );
  final TextEditingController _eventController = TextEditingController(
    text: "TECHNOVA 2026",
  );
  final TextEditingController _dateController = TextEditingController(
    text: "11/12/2026",
  );

  String _recipientName = "Recipient Name";

  final List<Map<String, dynamic>> _myRequests = [
    {
      'id': 'REQ-2026-088',
      'recipient': 'Anand Kumar',
      'type': 'Merit',
      'event': 'Annual Academic Honors & Merit Awards 2026',
      'date': '12 November 2026',
      'purpose':
          'in recognition of outstanding academic performance and merit in Annual Academic Honors.',
      'status': 'Issued',
      'statusColor': const Color(0xFF0369A1),
      'submittedOn': 'Today',
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
    _guestNameController.dispose();
    _guestDesignationController.dispose();
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

          if (_recipientIndex == 0)
            TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _recipientName =
                      val.trim().isNotEmpty ? val : "Recipient Name";
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
            )
          else
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full name",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _guestNameController,
                        onChanged: (val) {
                          setState(() {
                            _recipientName =
                                val.trim().isNotEmpty ? val : "Recipient Name";
                          });
                        },
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
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
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Designation / institution (optional)",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _guestDesignationController,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "e.g. Resource person, In...",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF94A3B8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
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
                                "Anna Institute of Technology, Chennai, Tamil Nadu\nPhone 9840012345 · office@ait.edu.in",
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

                        // Right Badge: NAAC ACCREDITED
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
                                "NAAC",
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              Text(
                                "ACCREDITED",
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
    final String recipient = (req['recipient'] as String?) ?? "Anand Kumar";
    final String type = (req['type'] as String?) ?? "Merit";
    final String event = (req['event'] as String?) ?? "Annual Academic Honors & Merit Awards 2026";
    final String date = (req['date'] as String?) ?? "8 October 2026";
    final String certId = (req['id'] != null && (req['id'] as String).startsWith('CIQ'))
        ? req['id'] as String
        : "CIQ-2026-031207A0";

    String ribbon = "OF MERIT";
    for (final item in _certificateTypes) {
      if (item['title'] == type) {
        ribbon = item['ribbon'] ?? "OF MERIT";
        break;
      }
    }

    final String citation = (req['purpose'] != null &&
            (req['purpose'] as String).trim().isNotEmpty &&
            !(req['purpose'] as String).contains('recognition of outstanding'))
        ? req['purpose'] as String
        : "has secured the First Rank in the Department of Computer Science and Engineering for the academic year 2025–26.";

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: const Color(0xFFFBFBFD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Close Button Row
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded, size: 22, color: Color(0xFF64748B)),
                      splashRadius: 18,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 1. TOP VERIFICATION HEADER & ACTIONS (Matching Screenshot 2)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 700;

                      final verifiedBanner = Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: Color(0xFF047857),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Verified: this certificate is genuine",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF065F46),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF064E3B),
                                        height: 1.35,
                                      ),
                                      children: [
                                        TextSpan(text: "Certificate of ${type.toLowerCase()} issued to "),
                                        TextSpan(
                                          text: recipient,
                                          style: const TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text:
                                              " by Anna Institute of Technology on $date. Signed under the authority of Dr. Lakshmi Sundaram, Principal.",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "ID $certId · digital signature checked",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF047857),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );

                      final actionButtons = Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.end,
                        children: [
                          // 1. Print / Save PDF (Opens native print preview)
                          ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await CertificatePdfService.printOrSavePdf(
                                  recipient: recipient,
                                  type: type,
                                  event: event,
                                  date: date,
                                  certId: certId,
                                  citation: citation,
                                );
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error opening print dialog: $e"),
                                      backgroundColor: const Color(0xFFDC2626),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.print_outlined, size: 15),
                            label: const Text("Print / save PDF"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),

                          // 2. Download PDF directly
                          ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Generating certificate PDF for $recipient..."),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                                await CertificatePdfService.downloadPdfDirectly(
                                  recipient: recipient,
                                  type: type,
                                  event: event,
                                  date: date,
                                  certId: certId,
                                  citation: citation,
                                );
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Download error: $e"),
                                      backgroundColor: const Color(0xFFDC2626),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.download_rounded, size: 15),
                            label: const Text("Download PDF"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F766E),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),

                          // 3. Copy Verification Link
                          OutlinedButton.icon(
                            onPressed: () {
                              final link = "https://colossus-iq-new.vercel.app/verify/$certId";
                              Clipboard.setData(ClipboardData(text: link));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Verification link copied to clipboard:\n$link",
                                          style: GoogleFonts.poppins(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: const Color(0xFF1E2865),
                                  duration: const Duration(seconds: 4),
                                ),
                              );
                            },
                            icon: const Icon(Icons.link_rounded, size: 15),
                            label: const Text("Copy verification link"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1E293B),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),

                          // 4. Add to LinkedIn Dialog
                          OutlinedButton.icon(
                            onPressed: () {
                              _showLinkedInDialog(
                                context: context,
                                recipient: recipient,
                                type: type,
                                certId: certId,
                                event: event,
                              );
                            },
                            icon: const Icon(Icons.share_outlined, size: 15),
                            label: const Text("Add to LinkedIn"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0A66C2),
                              side: const BorderSide(color: Color(0xFF0A66C2)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            verifiedBanner,
                            const SizedBox(height: 12),
                            actionButtons,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 11, child: verifiedBanner),
                          const SizedBox(width: 14),
                          Flexible(flex: 9, child: Align(alignment: Alignment.centerRight, child: actionButtons)),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  // 2. THE AUTHENTIC CERTIFICATE DOCUMENT (Matching Screenshot 2 & 3)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF8), // Ivory parchment
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF1E2865), width: 2.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD4AF37), width: 1.2), // Gold inner border
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Top Header Row: Crest, Institute Name, NAAC Badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: AIT Gold Seal Crest
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "AIT",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF1E2865),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Center: Institute Details
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "ANNA INSTITUTE OF TECHNOLOGY",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.2,
                                        color: const Color(0xFF1E2865),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Affiliated to Tamil Nadu Technical University",
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF475569),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Chennai, Tamil Nadu\nPhone 9840012345 · office@ait.edu.in",
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        color: const Color(0xFF64748B),
                                        height: 1.25,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // Right: NAAC ACCREDITED Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "NAAC",
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      "ACCREDITED",
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
                          const SizedBox(height: 20),

                          // CERTIFICATE Main Title
                          Text(
                            "CERTIFICATE",
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4.0,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Golden Ribbon Banner
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFCA8A04), Color(0xFFB45309)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFB45309).withValues(alpha: 0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              ribbon,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Subtitle
                          Text(
                            "This is to certify that",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Recipient Name
                          Text(
                            recipient,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF78350F),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Roll & Department Line
                          Text(
                            "110124001 · Computer Science & Engineering",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Citation / Achievement Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              citation,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF334155),
                                height: 1.45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Three Info Pill Boxes: EVENT, HELD ON, DATE OF ISSUE
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "EVENT ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: event,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "HELD ON ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: date,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "DATE OF ISSUE ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: date,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Bottom Signatures, Gold Seal & QR Code Row (Screenshot 3)
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 650,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left: QR Code Box + Verify URL
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFFCBD5E1)),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.qr_code_2_rounded,
                                          size: 44,
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
                                              fontSize: 8,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF92400E),
                                            ),
                                          ),
                                          Text(
                                            certId,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          Text(
                                            "localhost:3000/verify",
                                            style: GoogleFonts.poppins(
                                              fontSize: 7.5,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Center: Scalloped Embossed Gold Seal Medallion with Ribbon Tails
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 58,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const RadialGradient(
                                            colors: [
                                              Color(0xFFFEF3C7),
                                              Color(0xFFF59E0B),
                                              Color(0xFFB45309),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFB45309).withValues(alpha: 0.35),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: const Color(0xFF78350F), width: 0.8),
                                            ),
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
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.w900,
                                                    color: const Color(0xFF78350F),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Ribbon tails below seal
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Transform.rotate(
                                            angle: -0.2,
                                            child: Container(
                                              width: 9,
                                              height: 14,
                                              color: const Color(0xFFB45309),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Transform.rotate(
                                            angle: 0.2,
                                            child: Container(
                                              width: 9,
                                              height: 14,
                                              color: const Color(0xFFB45309),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Right: Official Seal Stamp + Signature of Dr. Lakshmi Sundaram
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Circular AIT Seal Stamp
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF334155), width: 1.2),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: const Color(0xFF334155), width: 0.6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "AIT\nSEAL",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 7.5,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(0xFF334155),
                                                  height: 1.1,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Signature Column
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Dr. Lakshmi Sundaram",
                                            style: GoogleFonts.greatVibes(
                                              fontSize: 22,
                                              color: const Color(0xFF1E2865),
                                            ),
                                          ),
                                          Container(
                                            width: 130,
                                            height: 1,
                                            color: const Color(0xFFCBD5E1),
                                            margin: const EdgeInsets.symmetric(vertical: 2),
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. EXPLANATORY FOOTER NOTE (Screenshot 3)
                  Text(
                    "Scan the QR code on a printed copy, or open this page, to confirm a certificate at any time. Anyone presenting an altered copy will see it fail here.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Certificates are signed by the university and can be checked here at any time.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Bottom Close Button
                  Align(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1E2865),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
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

  void _showLinkedInDialog({
    required BuildContext context,
    required String recipient,
    required String type,
    required String certId,
    required String event,
  }) {
    final certName = "Certificate of $type · $event";
    const org = "Anna Institute of Technology";
    final url = "https://colossus-iq-new.vercel.app/verify/$certId";
    final linkedInAddUrl =
        "https://www.linkedin.com/profile/add?startTask=CERTIFICATION_NAME&name=${Uri.encodeComponent(certName)}&organizationName=${Uri.encodeComponent(org)}&issueYear=2026&issueMonth=10&certUrl=${Uri.encodeComponent(url)}&certId=$certId";

    showDialog(
      context: context,
      builder: (lCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0A66C2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              "Add to LinkedIn Profile",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The following verified credential details are ready for $recipient's LinkedIn profile:",
                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
              ),
              const SizedBox(height: 14),
              _buildLinkedInField("Certification Name", certName),
              const SizedBox(height: 8),
              _buildLinkedInField("Issuing Organization", org),
              const SizedBox(height: 8),
              _buildLinkedInField("Issue Date", "October 2026"),
              const SizedBox(height: 8),
              _buildLinkedInField("Credential ID", certId),
              const SizedBox(height: 8),
              _buildLinkedInField("Credential URL", url),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(lCtx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: linkedInAddUrl));
              Navigator.pop(lCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("LinkedIn 1-Click certification link copied to clipboard!"),
                  backgroundColor: Color(0xFF0A66C2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 15),
            label: const Text("Copy LinkedIn 1-Click Link"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A66C2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedInField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 10, color: const Color(0xFF64748B), fontWeight: FontWeight.w600)),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF0F172A), fontWeight: FontWeight.w600)),
        ],
      ),
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
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final req = _myRequests[i];
                final isIssued = req['status'] == 'Issued';

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req['recipient'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${req['type']} · ${req['event']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isIssued ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          req['status'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isIssued ? const Color(0xFF15803D) : const Color(0xFFB45309),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      InkWell(
                        onTap: () => _showPreviewRequestCertificateDialog(req),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            'View',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4338CA),
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert_rounded, size: 18, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'More actions',
                        onSelected: (val) {
                          if (val == 'edit') {
                            _showEditRequestDialog(req);
                          } else if (val == 'withdraw') {
                            _withdrawRequest(req);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined, size: 16, color: Color(0xFF334155)),
                                SizedBox(width: 8),
                                Text('Edit request'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'withdraw',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                                SizedBox(width: 8),
                                Text('Withdraw', style: TextStyle(color: Color(0xFFEF4444))),
                              ],
                            ),
                          ),
                        ],
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
