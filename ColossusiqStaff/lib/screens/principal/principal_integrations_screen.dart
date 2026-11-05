import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalIntegrationsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalIntegrationsScreen({super.key, this.onBack});

  @override
  State<PrincipalIntegrationsScreen> createState() => _PrincipalIntegrationsScreenState();
}

class _PrincipalIntegrationsScreenState extends State<PrincipalIntegrationsScreen> {
  int _selectedServiceIndex = 0;

  final List<Map<String, dynamic>> _services = [
    {
      "category": "STORAGE",
      "name": "Cloud storage",
      "icon": Icons.cloud_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Where uploaded files are kept: website images, certificate seals and signatures, Knowledge Base PDFs and handwritten answer scripts.",
      "tags": [
        "College Website",
        "Photo Gallery",
        "Certificate Authority",
        "Knowledge Base",
        "Handwritten Evaluation",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "MESSAGING",
      "name": "Email",
      "icon": Icons.mail_outline_rounded,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Where transactional & notification emails are routed: fee receipts, hall tickets, login OTPs, and statutory reports.",
      "tags": [
        "Admissions",
        "Student Fees",
        "Exam Prep",
        "Notification Rules",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "MESSAGING",
      "name": "WhatsApp",
      "icon": Icons.chat_bubble_outline_rounded,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Automated parent & student messaging for urgent attendance alerts, fee reminders, and timetable shifts.",
      "tags": [
        "Parent Communication",
        "Attendance Warnings",
        "Emergency Desk",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "MESSAGING",
      "name": "SMS",
      "icon": Icons.sms_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Telecom DLT-registered transactional SMS gateway for student verification and off-line critical broadcasts.",
      "tags": [
        "Single Sign-On",
        "Exam Alerts",
        "DLT Compliance",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "PAYMENTS",
      "name": "Razorpay",
      "icon": Icons.credit_card_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "UPI, debit/credit cards, and net-banking checkout bridge for autonomous fee collections and instant receipts.",
      "tags": [
        "Student Fees",
        "Exam Registration",
        "Hostel & Transport",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "PAYMENTS",
      "name": "PayU",
      "icon": Icons.credit_card_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Secondary payment gateway failover for peak semester registration fee transactions.",
      "tags": [
        "Student Fees",
        "Admissions",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "PAYMENTS",
      "name": "CCAvenue",
      "icon": Icons.credit_card_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Enterprise university banking multi-merchant aggregator for government & trust disbursements.",
      "tags": [
        "Finance Desk",
        "Tuition Accounts",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "PAYMENTS",
      "name": "PayPal",
      "icon": Icons.credit_card_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "International student registration and foreign currency research conference registrations.",
      "tags": [
        "International Cell",
        "Conferences",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "IDENTITY",
      "name": "Single sign-on",
      "icon": Icons.vpn_key_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Centralized Microsoft 365, Google Workspace, and SAML 2.0 institutional student & staff login broker.",
      "tags": [
        "Student Portal",
        "Faculty Portal",
        "DigiLocker NAD",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "TEACHING",
      "name": "Online classes",
      "icon": Icons.videocam_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Direct integration with Zoom, Google Meet & Microsoft Teams for hybrid class schedules and live vivas.",
      "tags": [
        "Curriculum Studio",
        "AI Course Studio",
        "Viva Simulator",
      ],
      "body": "Not set up yet.",
    },
    {
      "category": "DATA EXCHANGE",
      "name": "ERP / SIS webhook",
      "icon": Icons.cable_outlined,
      "status": "Not set up",
      "statusSub": "Not configured yet.",
      "desc": "Bidirectional real-time webhook endpoints syncing students, faculty profiles, marks, and attendance with master ERP.",
      "tags": [
        "Student Admissions",
        "Staff Management",
        "NAAC Compliance",
      ],
      "body": "Not set up yet.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeService = _services[_selectedServiceIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Image 3)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 3. Connected Services Summary Card (Matches Image 3)
              _buildSummaryCard(),
              const SizedBox(height: 14),

              // 4. Lock Notice Banner (Matches Image 3)
              _buildLockBanner(),
              const SizedBox(height: 18),

              // 5. Two-Column Master-Detail Layout (Matches Images 3 & 4)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 840;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left categories sidebar
                        SizedBox(
                          width: 270,
                          child: _buildSidebar(),
                        ),
                        const SizedBox(width: 20),
                        // Right detail panel
                        Expanded(
                          child: _buildDetailPanel(activeService),
                        ),
                      ],
                    );
                  }

                  // Mobile / tablet stacked layout
                  return Column(
                    children: [
                      _buildSidebar(),
                      const SizedBox(height: 18),
                      _buildDetailPanel(activeService),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BREADCRUMBS
  // ===========================================================================
  Widget _buildBreadcrumbs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          if (widget.onBack != null) ...[
            InkWell(
              onTap: widget.onBack,
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF64748B)),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            "Home",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
          ),
          Text(
            "Platform",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
          ),
          Text(
            "Integrations & Setup",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. BLUEPRINT HERO BANNER (Matches Image 3)
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1E5C), Color(0xFF1E3A8A), Color(0xFF2E3D85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1E5C).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Blueprint grid overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Background watermark icon
            Positioned(
              right: -10,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.power_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plug Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.power_rounded,
                    color: Color(0xFFFBBF24),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),

                // Title, Badges & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "PLATFORM",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669),
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
                      const SizedBox(height: 6),
                      Text(
                        "Integrations & Setup",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Connect cloud storage, email, WhatsApp, SMS, online payments, single sign-on, online classes and your ERP. Secrets are stored encrypted and never shown again.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFFE2E8F0),
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
    );
  }

  // ===========================================================================
  // 3. CONNECTED SERVICES SUMMARY CARD (Matches Image 3)
  // ===========================================================================
  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connected services",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "0 ",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: "of 11 working",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "11 not set up",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Settings are stored encrypted and tested here. Each module starts sending through a service as it is connected to it; until then it keeps working as it does today.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. LOCK NOTICE BANNER (Matches Image 3)
  // ===========================================================================
  Widget _buildLockBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 16,
              color: Color(0xFFD97706),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Integrations apply to the whole university. The University Super Admin sets them up at \"All colleges\" after confirming the sign-in code; here you can see what is connected.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF78350F),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5A. LEFT CATEGORIES SIDEBAR (Matches Images 3 & 4)
  // ===========================================================================
  Widget _buildSidebar() {
    String? currentCategory;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_services.length, (index) {
          final s = _services[index];
          final cat = s["category"] as String;
          final isSelected = _selectedServiceIndex == index;

          final showCatHeader = currentCategory != cat;
          if (showCatHeader) {
            currentCategory = cat;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showCatHeader) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: index == 0 ? 4 : 14,
                    bottom: 6,
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
              InkWell(
                onTap: () => setState(() => _selectedServiceIndex = index),
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF131B4D) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          s["icon"] as IconData,
                          size: 17,
                          color: isSelected ? Colors.white : const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              s["status"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 5B. RIGHT DETAIL PANEL (Matches Image 3)
  // ===========================================================================
  Widget _buildDetailPanel(Map<String, dynamic> service) {
    final tags = service["tags"] as List<String>;

    return LayoutBuilder(
      builder: (context, panelBox) {
        final isMobile = panelBox.maxWidth < 500;
        final cardPadding = isMobile ? 16.0 : 22.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon + Title on left, Status badge & sub on right
              if (isMobile) ...[
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        service["icon"] as IconData,
                        size: 22,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        service["name"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        service["status"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    Text(
                      service["statusSub"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        service["icon"] as IconData,
                        size: 24,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        service["name"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            service["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          service["statusSub"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],

              // Full-width responsive description text
              const SizedBox(height: 14),
              Text(
                service["desc"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // "For" Tags Row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "For",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  ...tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 24),

              // Content body
              Text(
                service["body"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF334155),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =============================================================================
// GRID PAINTER (Matches Blueprint background in Images 3, 4, 5)
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

typedef PlatformIntegrationsScreen = PrincipalIntegrationsScreen;
