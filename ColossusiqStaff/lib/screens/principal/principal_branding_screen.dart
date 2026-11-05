import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalBrandingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalBrandingScreen({super.key, this.onBack});

  @override
  State<PrincipalBrandingScreen> createState() => _PrincipalBrandingScreenState();
}

class _PrincipalBrandingScreenState extends State<PrincipalBrandingScreen> {
  // Main Sub-Tabs
  int _selectedTab = 0;

  // Real-Time Preview Sub-Tabs (0: Student Portal, 1: Login Screen, 2: Degree Certificate, 3: Email Alert)
  int _previewTab = 0;
  bool _isMobilePreview = false;
  bool _isDarkModePreview = false;

  // Selected Palette Index
  int _selectedPalette = 0;

  final List<Map<String, dynamic>> _palettes = [
    {
      "name": "Imperial Navy & Gold",
      "desc": "Prestigious engineering & academic institutions",
      "colors": [const Color(0xFF1E2A5A), const Color(0xFFC9962B), const Color(0xFF0F766E)],
      "hexes": ["#1E2A5A", "#C9962B", "#0F766E"],
    },
    {
      "name": "Oxford Royal & Cyan",
      "desc": "Contemporary tech universities & autonomous...",
      "colors": [const Color(0xFF1E40AF), const Color(0xFF0284C7), const Color(0xFF06B6D4)],
      "hexes": ["#1E40AF", "#0284C7", "#06B6D4"],
    },
    {
      "name": "Emerald Tech & Mint",
      "desc": "Polytechnic, applied science & research centers",
      "colors": [const Color(0xFF047857), const Color(0xFF10B981), const Color(0xFF6EE7B7)],
      "hexes": ["#047857", "#10B981", "#6EE7B7"],
    },
    {
      "name": "Crimson Academic & Ruby",
      "desc": "Heritage universities & arts and science colleges",
      "colors": [const Color(0xFF991B1B), const Color(0xFFDC2626), const Color(0xFFF87171)],
      "hexes": ["#991B1B", "#DC2626", "#F87171"],
    },
    {
      "name": "Midnight Violet & Amber",
      "desc": "Innovative management & design schools",
      "colors": [const Color(0xFF4C1D95), const Color(0xFF7C3AED), const Color(0xFFF59E0B)],
      "hexes": ["#4C1D95", "#7C3AED", "#F59E0B"],
    },
    {
      "name": "Slate Minimalist",
      "desc": "Clean, ultra-modern corporate white-labeling",
      "colors": [const Color(0xFF1E293B), const Color(0xFF3B82F6), const Color(0xFF94A3B8)],
      "hexes": ["#1E293B", "#3B82F6", "#94A3B8"],
    },
  ];

  // Colors & Aesthetics Controllers
  late TextEditingController _primaryColorController;
  late TextEditingController _accentGoldController;
  late TextEditingController _secondaryTintController;
  late TextEditingController _emailBannerColorController;

  bool _darkExecutiveNav = true;
  String _interfaceRoundness = "Modern (16px)";

  // Institution Identity
  late TextEditingController _displayNameController;
  late TextEditingController _acronymController;
  late TextEditingController _taglineController;
  late TextEditingController _yearEstablishedController;
  late TextEditingController _customLogoUrlController;
  int _emblemStyle = 0; // 0: Academic Shield, 1: Classical Pillars, 2: Atom & Circuit, 3: Geometric Laurel

  // Domain & White-Label
  late TextEditingController _subdomainController;
  late TextEditingController _customDomainController;
  bool _enforceHttps = true;
  bool _pureWhiteLabel = true;
  late TextEditingController _browserTitleController;

  // Academic Terms
  String _instDesignation = "Institute";
  String _hodTitle = "Head of Department (HOD)";
  String _staffDesignation = "Faculty";
  String _studentIdLabel = "Roll Number";
  String _termCycle = "Semester";
  String _academicYear = "2026–2027";
  String _gradingScale = "10-Point CGPA Scale (UGC / AICTE Standard)";
  bool _naacBadge = true;
  bool _nbaBadge = true;
  bool _aicteDisplay = true;
  late TextEditingController _eoaRefController;

  // Emails & Alerts
  late TextEditingController _emailSenderNameController;
  late TextEditingController _fromEmailController;
  late TextEditingController _replyToEmailController;
  late TextEditingController _footerDisclaimerController;
  late TextEditingController _smsSenderIdController;
  bool _whatsappDelivery = true;

  // Certificates & AI Localization (from User Reference Images 1 & 2)
  late TextEditingController _certHeaderController;
  late TextEditingController _certAffiliationController;
  String _certBorderStyle = "Classic Gold Guilloche (Heritage Seal)";
  late TextEditingController _primarySignatoryController;
  late TextEditingController _secondarySignatoryController;
  bool _antiFraudQr = true;
  bool _backgroundWatermark = true;
  String _defaultInterfaceLanguage = "English";
  String _aiTutorVoice = "English";

  @override
  void initState() {
    super.initState();
    _primaryColorController = TextEditingController(text: "#1E2A5A");
    _accentGoldController = TextEditingController(text: "#C9962B");
    _secondaryTintController = TextEditingController(text: "#0F766E");
    _emailBannerColorController = TextEditingController(text: "#1E2A5A");

    _displayNameController = TextEditingController(text: "Anna Institute of Technology");
    _acronymController = TextEditingController(text: "AIOT");
    _taglineController = TextEditingController(text: "Excellence in Engineering, Research & Human Values");
    _yearEstablishedController = TextEditingController(text: "2001");
    _customLogoUrlController = TextEditingController(text: "https://yourcollege.edu/assets/logo.png");

    _subdomainController = TextEditingController(text: "aiot");
    _customDomainController = TextEditingController(text: "portal.ait.edu.in");
    _browserTitleController = TextEditingController(text: "{page} | Anna Institute of Technology");

    _eoaRefController = TextEditingController(text: "F.No. Southern/1-9321458921/2026/EOA (1101)");

    _emailSenderNameController = TextEditingController(text: "Anna Institute of Technology Academic Office");
    _fromEmailController = TextEditingController(text: "notifications@ait.edu.in");
    _replyToEmailController = TextEditingController(text: "office@ait.edu.in");
    _footerDisclaimerController = TextEditingController(
      text: "Anna Institute of Technology, Sardar Patel Road, Guindy, Chennai 600025. Approved by AICTE, Affiliated to TNTU.",
    );
    _smsSenderIdController = TextEditingController(text: "AIOTXX");

    _certHeaderController = TextEditingController(text: "ANNA INSTITUTE OF TECHNOLOGY");
    _certAffiliationController = TextEditingController(
      text: "Autonomous Institution Affiliated to Tamil Nadu Technical University (TNTU)",
    );
    _primarySignatoryController = TextEditingController(text: "Dr. Lakshmi Sundaram, Principal");
    _secondarySignatoryController = TextEditingController(text: "Prof. K. Venkatesh, Controller of Examinations");
  }

  @override
  void dispose() {
    _primaryColorController.dispose();
    _accentGoldController.dispose();
    _secondaryTintController.dispose();
    _emailBannerColorController.dispose();
    _displayNameController.dispose();
    _acronymController.dispose();
    _taglineController.dispose();
    _yearEstablishedController.dispose();
    _customLogoUrlController.dispose();
    _subdomainController.dispose();
    _customDomainController.dispose();
    _browserTitleController.dispose();
    _eoaRefController.dispose();
    _emailSenderNameController.dispose();
    _fromEmailController.dispose();
    _replyToEmailController.dispose();
    _footerDisclaimerController.dispose();
    _smsSenderIdController.dispose();
    _certHeaderController.dispose();
    _certAffiliationController.dispose();
    _primarySignatoryController.dispose();
    _secondarySignatoryController.dispose();
    super.dispose();
  }

  Color _parseHex(String hex, Color fallback) {
    try {
      final clean = hex.replaceAll("#", "").trim();
      if (clean.length == 6) {
        return Color(int.parse("0xFF$clean"));
      } else if (clean.length == 8) {
        return Color(int.parse("0x$clean"));
      }
    } catch (_) {}
    return fallback;
  }

  void _applyPalette(int index) {
    final p = _palettes[index];
    setState(() {
      _selectedPalette = index;
      final hexes = p["hexes"] as List<String>;
      _primaryColorController.text = hexes[0];
      _accentGoldController.text = hexes[1];
      _secondaryTintController.text = hexes[2];
      _emailBannerColorController.text = hexes[0];
    });
  }

  @override
  Widget build(BuildContext context) {
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

              // 2. Blueprint Banner
              _buildBlueprintBanner(),
              const SizedBox(height: 18),

              // 3. Institution Summary Card
              _buildInstitutionSummaryCard(),
              const SizedBox(height: 18),

              // 4. Sub-Tabs Navigation
              _buildSubTabs(),
              const SizedBox(height: 20),

              // 5. Main 2-Column Responsive Layout (Settings Form + Real-Time Preview)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 1060;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Settings Column
                        Expanded(
                          flex: 6,
                          child: _buildActiveTabContent(constraints.maxWidth * 0.6),
                        ),
                        const SizedBox(width: 20),
                        // Right Live Preview Column (fixed 380px or flex: 4)
                        SizedBox(
                          width: 380,
                          child: _buildRealTimePreviewCard(),
                        ),
                      ],
                    );
                  }

                  // Stack vertically on mobile / tablet
                  return Column(
                    children: [
                      _buildActiveTabContent(constraints.maxWidth),
                      const SizedBox(height: 24),
                      _buildRealTimePreviewCard(),
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
    return Row(
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
          "Institution",
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
        ),
        Text(
          "Branding & White Label",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildBlueprintBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1E2A5A), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background blueprint grid / watermark icon
          Positioned(
            right: -10,
            bottom: -20,
            child: Icon(
              Icons.tune_rounded,
              size: 150,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Settings Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.settings_rounded,
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "INSTITUTION",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD97706),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Phase 3",
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
                      "Branding & White Label",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Logo, colours, subdomain, academic structure and notification templates.",
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
    );
  }

  // ===========================================================================
  // 3. INSTITUTION SUMMARY CARD
  // ===========================================================================
  Widget _buildInstitutionSummaryCard() {
    return Container(
      width: double.infinity,
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
      child: LayoutBuilder(
        builder: (context, box) {
          final isCompact = box.maxWidth < 800;

          final leftInfo = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Shield avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2A5A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Color(0xFFC9962B),
                  size: 26,
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
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _displayNameController.text,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _acronymController.text,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_outline_rounded, size: 12, color: Color(0xFF16A34A)),
                              const SizedBox(width: 4),
                              Text(
                                "White-Label Active",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF16A34A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "🌐 ${_customDomainController.text}  ·  SSL: TLS 1.3 Active  ·  Subdomain: ${_subdomainController.text}.colossusiq.ai",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );

          final rightControls = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Brand Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "BRAND SCORE",
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        "100% Complete",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 70,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F766E),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 14),

              // Export CSS Tokens button
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Exporting institutional CSS tokens..."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.description_outlined, size: 14),
                label: Text(
                  "Export CSS Tokens",
                  style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),

              // Reset button
              TextButton.icon(
                onPressed: () {
                  _applyPalette(0);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Reset to default Imperial Navy & Gold"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.replay_rounded, size: 14),
                label: Text(
                  "Reset",
                  style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF64748B),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                ),
              ),
              const SizedBox(width: 8),

              // Saved button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All branding settings successfully saved!"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                label: Text(
                  "Saved",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B95BD),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leftInfo,
                const Divider(height: 24, color: Color(0xFFF1F5F9)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: rightControls,
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: leftInfo),
              const SizedBox(width: 16),
              rightControls,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 4. SUB-TABS NAVIGATION
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"icon": Icons.palette_outlined, "title": "Visual Identity"},
      {"icon": Icons.language_rounded, "title": "Domain & White-Label"},
      {"icon": Icons.account_balance_outlined, "title": "Academic Terms"},
      {"icon": Icons.email_outlined, "title": "Emails & Alerts"},
      {"icon": Icons.workspace_premium_outlined, "title": "Certificates"},
      {"icon": Icons.translate_rounded, "title": "Language & AI"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final t = tabs[index];
          final isSelected = _selectedTab == index;
          final isAiTab = index == 5;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                  if (index == 0) _previewTab = 0;
                  if (index == 1) _previewTab = 1;
                  if (index == 2) _previewTab = 2;
                  if (index == 3) _previewTab = 3;
                  if (index == 4) _previewTab = 2; // Certificate preview
                  if (index == 5) _previewTab = 0; // Portal preview
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF131B4D) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isSelected
                      ? Border.all(
                          color: isAiTab ? const Color(0xFFC9962B) : const Color(0xFF131B4D),
                          width: isAiTab ? 1.5 : 1.0,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      t["icon"] as IconData,
                      size: 16,
                      color: isSelected ? Colors.white : const Color(0xFF334155),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 5. ACTIVE TAB CONTENT DISPATCHER
  // ===========================================================================
  Widget _buildActiveTabContent(double maxWidth) {
    switch (_selectedTab) {
      case 0:
        return _buildVisualIdentityTab();
      case 1:
        return _buildDomainWhiteLabelTab();
      case 2:
        return _buildAcademicTermsTab();
      case 3:
        return _buildEmailsAlertsTab();
      case 4:
        return _buildCertificatesTab();
      case 5:
        return _buildLanguageAiTab();
      default:
        return _buildVisualIdentityTab();
    }
  }

  // ===========================================================================
  // 5A. TAB 0: VISUAL IDENTITY (Images 1 & 2)
  // ===========================================================================
  Widget _buildVisualIdentityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card 1: One-Click Enterprise Palettes
        Container(
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
              Text(
                "One-Click Enterprise Palettes",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Instantly apply accredited university color harmonies",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // 6 Palettes Grid
              LayoutBuilder(
                builder: (context, box) {
                  final colCount = box.maxWidth >= 720
                      ? 3
                      : box.maxWidth >= 480
                          ? 2
                          : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: colCount == 1 ? 2.8 : 1.9,
                    ),
                    itemCount: _palettes.length,
                    itemBuilder: (ctx, idx) {
                      final p = _palettes[idx];
                      final isSel = _selectedPalette == idx;
                      final colors = p["colors"] as List<Color>;

                      return InkWell(
                        onTap: () => _applyPalette(idx),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSel ? const Color(0xFF1E2A5A) : const Color(0xFFE2E8F0),
                              width: isSel ? 1.8 : 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      p["name"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (isSel)
                                    const Icon(
                                      Icons.check_rounded,
                                      size: 16,
                                      color: Color(0xFF1E2A5A),
                                    ),
                                ],
                              ),
                              Row(
                                children: colors.map((c) {
                                  return Container(
                                    width: 14,
                                    height: 14,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                      color: c,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }).toList(),
                              ),
                              Text(
                                p["desc"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Card 2: Core Brand Colors & Aesthetics (Image 1 bottom & Image 2 top)
        Container(
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
              Text(
                "Core Brand Colors & Aesthetics",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Primary colors used across the navigation bar, buttons, badges and charts",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // 3 Color Pickers Row
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;

                  final c1 = _buildColorInputField(
                    "Primary Brand Color",
                    _primaryColorController,
                    const Color(0xFF1E2A5A),
                  );
                  final c2 = _buildColorInputField(
                    "Accent Gold / Highlight",
                    _accentGoldController,
                    const Color(0xFFC9962B),
                  );
                  final c3 = _buildColorInputField(
                    "Secondary / Surface Tint",
                    _secondaryTintController,
                    const Color(0xFF0F766E),
                  );

                  if (isCompact) {
                    return Column(
                      children: [
                        c1,
                        const SizedBox(height: 12),
                        c2,
                        const SizedBox(height: 12),
                        c3,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: c1),
                      const SizedBox(width: 14),
                      Expanded(child: c2),
                      const SizedBox(width: 14),
                      Expanded(child: c3),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Navigation Bar Tint & Interface Roundness Row
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;

                  final navBarTint = Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dark Executive Navigation",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                "Render the main portal navbar in deep brand tint",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: _darkExecutiveNav,
                          activeColor: const Color(0xFF131B4D),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) => setState(() => _darkExecutiveNav = val ?? true),
                        ),
                      ],
                    ),
                  );

                  final roundnessDropdown = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interface Roundness",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _interfaceRoundness,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                            items: const [
                              DropdownMenuItem(value: "Sharp (4px)", child: Text("Sharp (4px)")),
                              DropdownMenuItem(value: "Smooth (8px)", child: Text("Smooth (8px)")),
                              DropdownMenuItem(value: "Modern (16px)", child: Text("Modern (16px)")),
                              DropdownMenuItem(value: "Pill (24px)", child: Text("Pill (24px)")),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _interfaceRoundness = val);
                            },
                          ),
                        ),
                      ),
                    ],
                  );

                  if (isCompact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navBarTint,
                        const SizedBox(height: 12),
                        roundnessDropdown,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: navBarTint),
                      const SizedBox(width: 14),
                      Expanded(child: roundnessDropdown),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Card 3: Official Institution Identity (Image 2)
        Container(
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
              Text(
                "Official Institution Identity",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Institutional name, acronym and heraldic crest displayed to students and recruiters",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // Official Display Name & Acronym
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final f1 = _buildTextInput("Official Display Name", _displayNameController);
                  final f2 = _buildTextInput("Acronym / Short Code", _acronymController);

                  if (isCompact) {
                    return Column(children: [f1, const SizedBox(height: 12), f2]);
                  }
                  return Row(
                    children: [
                      Expanded(flex: 3, child: f1),
                      const SizedBox(width: 14),
                      Expanded(flex: 2, child: f2),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),

              // Motto & Year Established
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final f1 = _buildTextInput("Motto / Institutional Tagline", _taglineController);
                  final f2 = _buildTextInput("Year Established", _yearEstablishedController);

                  if (isCompact) {
                    return Column(children: [f1, const SizedBox(height: 12), f2]);
                  }
                  return Row(
                    children: [
                      Expanded(flex: 3, child: f1),
                      const SizedBox(width: 14),
                      Expanded(flex: 2, child: f2),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),

              // Select Heraldic Emblem Style
              Text(
                "Select Heraldic Emblem Style",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 10),

              LayoutBuilder(
                builder: (context, box) {
                  final emblems = [
                    {"icon": Icons.shield_rounded, "label": "Academic Shield"},
                    {"icon": Icons.account_balance_rounded, "label": "Classical Pillars"},
                    {"icon": Icons.bubble_chart_rounded, "label": "Atom & Circuit"},
                    {"icon": Icons.military_tech_rounded, "label": "Geometric Laurel"},
                  ];

                  final colCount = box.maxWidth >= 650 ? 4 : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: colCount == 4 ? 1.6 : 1.8,
                    ),
                    itemCount: emblems.length,
                    itemBuilder: (ctx, idx) {
                      final e = emblems[idx];
                      final isSel = _emblemStyle == idx;

                      return InkWell(
                        onTap: () => setState(() => _emblemStyle = idx),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSel ? const Color(0xFF1E2A5A) : const Color(0xFFE2E8F0),
                              width: isSel ? 1.8 : 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                e["icon"] as IconData,
                                size: 24,
                                color: isSel ? const Color(0xFF1E2A5A) : const Color(0xFF475569),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                e["label"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 18),

              // Custom Logo Image URL (Optional)
              _buildTextInput(
                "Custom Logo Image URL (Optional)",
                _customLogoUrlController,
                helperText: "PNG or SVG with transparent background",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5B. TAB 1: DOMAIN & WHITE-LABEL (Image 3)
  // ===========================================================================
  Widget _buildDomainWhiteLabelTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              Text(
                "White-Label Domains & Subdomains",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Configure your institution's branded domain with automated DNS & TLS encryption",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // Assigned Subdomain & Dedicated Custom Domain
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;

                  final subDomain = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Assigned Subdomain",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _subdomainController,
                                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                              ),
                              child: Text(
                                ".colossusiq.ai",
                                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Provided ColossusIQ Cloud endpoint",
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                      ),
                    ],
                  );

                  final customDomain = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dedicated Custom Domain",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: TextField(
                          controller: _customDomainController,
                          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Your college official domain",
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                      ),
                    ],
                  );

                  if (isCompact) {
                    return Column(children: [subDomain, const SizedBox(height: 12), customDomain]);
                  }
                  return Row(
                    children: [
                      Expanded(child: subDomain),
                      const SizedBox(width: 14),
                      Expanded(child: customDomain),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),

              // DNS CNAME SETUP Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.verified_outlined, size: 16, color: Color(0xFF0F766E)),
                            const SizedBox(width: 6),
                            Text(
                              "DNS CNAME SETUP",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Checking CNAME records and TLS 1.3 certificate status..."),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.sync_rounded, size: 13),
                          label: Text(
                            "Verify DNS & SSL",
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0F172A),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Add this CNAME record in your domain registrar (GoDaddy, Cloudflare, Route53, etc.)",
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 14),

                    // CNAME Table Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: LayoutBuilder(
                        builder: (context, b) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDnsCol("TYPE", "CNAME", isBold: true),
                              _buildDnsCol("HOST", "portal", isCode: true),
                              _buildDnsCol("TARGET VALUE", "cname.colossusiq.ai", isGreen: true),
                              _buildDnsCol("STATUS", "✔ Active", isGreenBadge: true),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Enforce Strict HTTPS
              _buildCheckboxTile(
                "Enforce Strict HTTPS & HSTS",
                "Always redirect unencrypted traffic and require modern TLS 1.3",
                _enforceHttps,
                (val) => setState(() => _enforceHttps = val),
              ),
              const SizedBox(height: 12),

              // Pure White-Label
              _buildCheckboxTile(
                "Pure White-Label (Hide 'Powered by ColossusIQ')",
                "Remove all platform watermarks, vendor links and footer badges",
                _pureWhiteLabel,
                (val) => setState(() => _pureWhiteLabel = val),
              ),
              const SizedBox(height: 16),

              // Browser Tab Title Format
              _buildTextInput(
                "Browser Tab Title Format",
                _browserTitleController,
                helperText: "Supported placeholder: {page}",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDnsCol(String header, String val, {bool isBold = false, bool isCode = false, bool isGreen = false, bool isGreenBadge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isBold || isGreenBadge ? FontWeight.w700 : FontWeight.w600,
            color: isGreenBadge || isGreen ? const Color(0xFF0F766E) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5C. TAB 2: ACADEMIC TERMS (Image 4)
  // ===========================================================================
  Widget _buildAcademicTermsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              Text(
                "Academic Structure & System Terminology",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Custom nomenclature aligned with your university's statutory governance",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // Row 1: Institution Designation & Department Head Title
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final d1 = _buildDropdown(
                    "Institution Designation",
                    _instDesignation,
                    ["Institute", "College", "University", "Autonomous Institution", "Academy"],
                    (v) => setState(() => _instDesignation = v),
                  );
                  final d2 = _buildDropdown(
                    "Department Head Title",
                    _hodTitle,
                    ["Head of Department (HOD)", "Department Chair", "Program Director", "Dean"],
                    (v) => setState(() => _hodTitle = v),
                  );

                  if (isCompact) return Column(children: [d1, const SizedBox(height: 12), d2]);
                  return Row(children: [Expanded(child: d1), const SizedBox(width: 14), Expanded(child: d2)]);
                },
              ),
              const SizedBox(height: 12),

              // Row 2: Teaching Staff Designation & Student Identifier Label
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final d1 = _buildDropdown(
                    "Teaching Staff Designation",
                    _staffDesignation,
                    ["Faculty", "Professor", "Teacher", "Teaching Staff", "Instructor"],
                    (v) => setState(() => _staffDesignation = v),
                  );
                  final d2 = _buildDropdown(
                    "Student Identifier Label",
                    _studentIdLabel,
                    ["Roll Number", "Register Number", "Student ID", "USN", "Matriculation No."],
                    (v) => setState(() => _studentIdLabel = v),
                  );

                  if (isCompact) return Column(children: [d1, const SizedBox(height: 12), d2]);
                  return Row(children: [Expanded(child: d1), const SizedBox(width: 14), Expanded(child: d2)]);
                },
              ),
              const SizedBox(height: 12),

              // Row 3: Academic Term Cycle & Active Academic Year
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final d1 = _buildDropdown(
                    "Academic Term Cycle",
                    _termCycle,
                    ["Semester", "Trimester", "Annual / Year", "Quarter"],
                    (v) => setState(() => _termCycle = v),
                  );
                  final d2 = _buildDropdown(
                    "Active Academic Year",
                    _academicYear,
                    ["2026–2027", "2025–2026", "2024–2025"],
                    (v) => setState(() => _academicYear = v),
                  );

                  if (isCompact) return Column(children: [d1, const SizedBox(height: 12), d2]);
                  return Row(children: [Expanded(child: d1), const SizedBox(width: 14), Expanded(child: d2)]);
                },
              ),
              const SizedBox(height: 14),

              // Primary Grading Scale
              _buildDropdown(
                "Primary Grading Scale",
                _gradingScale,
                [
                  "10-Point CGPA Scale (UGC / AICTE Standard)",
                  "4.0 GPA Scale",
                  "Percentage (0-100%)",
                  "Letter Grades (O, A+, A, B+, B, C, F)",
                ],
                (v) => setState(() => _gradingScale = v),
              ),
              const SizedBox(height: 18),

              // STATUTORY BADGES ON STUDENT PORTAL
              Text(
                "STATUTORY BADGES ON STUDENT PORTAL",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),

              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;

                  final b1 = _buildSimpleCheckboxTile("NAAC A++ Badge", _naacBadge, (v) => setState(() => _naacBadge = v));
                  final b2 = _buildSimpleCheckboxTile("NBA Accredited", _nbaBadge, (v) => setState(() => _nbaBadge = v));
                  final b3 = _buildSimpleCheckboxTile("AICTE ID Display", _aicteDisplay, (v) => setState(() => _aicteDisplay = v));

                  if (isCompact) {
                    return Column(children: [b1, const SizedBox(height: 8), b2, const SizedBox(height: 8), b3]);
                  }
                  return Row(
                    children: [
                      Expanded(child: b1),
                      const SizedBox(width: 10),
                      Expanded(child: b2),
                      const SizedBox(width: 10),
                      Expanded(child: b3),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // AICTE Approval EOA Reference
              _buildTextInput("AICTE Approval EOA Reference", _eoaRefController),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5D. TAB 3: EMAILS & ALERTS (Image 5)
  // ===========================================================================
  Widget _buildEmailsAlertsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              Text(
                "White-Label Communication & Alerts",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Branded headers, sender addresses and footers for transactional emails, SMS and WhatsApp",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),

              // Row 1: Email Sender Display Name & From Email Address
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final f1 = _buildTextInput("Email Sender Display Name", _emailSenderNameController);
                  final f2 = _buildTextInput("From Email Address", _fromEmailController);

                  if (isCompact) return Column(children: [f1, const SizedBox(height: 12), f2]);
                  return Row(children: [Expanded(child: f1), const SizedBox(width: 14), Expanded(child: f2)]);
                },
              ),
              const SizedBox(height: 14),

              // Row 2: Reply-To Address & Email Banner Header Color
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;
                  final f1 = _buildTextInput("Reply-To Address", _replyToEmailController);
                  final f2 = _buildColorInputField("Email Banner Header Color", _emailBannerColorController, const Color(0xFF1E2A5A));

                  if (isCompact) return Column(children: [f1, const SizedBox(height: 12), f2]);
                  return Row(children: [Expanded(child: f1), const SizedBox(width: 14), Expanded(child: f2)]);
                },
              ),
              const SizedBox(height: 14),

              // Official Campus Footer & Statutory Disclaimer (Multi-line)
              Text(
                "Official Campus Footer & Statutory Disclaimer",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  controller: _footerDisclaimerController,
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A), height: 1.4),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Row 3: SMS DLT Sender ID & WhatsApp Business Delivery
              LayoutBuilder(
                builder: (context, box) {
                  final isCompact = box.maxWidth < 650;

                  final smsField = _buildTextInput(
                    "SMS DLT Sender ID (6 Characters)",
                    _smsSenderIdController,
                    helperText: "Registered with Telecom Authority",
                  );

                  final whatsAppTile = Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enable Branded WhatsApp Sender",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                "Deliver timetable and exam alerts with green tick",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: _whatsappDelivery,
                          activeColor: const Color(0xFF131B4D),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) => setState(() => _whatsappDelivery = val ?? true),
                        ),
                      ],
                    ),
                  );

                  if (isCompact) {
                    return Column(children: [smsField, const SizedBox(height: 12), whatsAppTile]);
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: smsField),
                      const SizedBox(width: 14),
                      Expanded(child: whatsAppTile),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),

              // Send Test Verification Email button
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sending test white-label verification email to ${_fromEmailController.text}..."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded, size: 14),
                label: Text(
                  "Send Test Verification Email",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5E. TAB 4: CERTIFICATES (Matches Image 1)
  // ===========================================================================
  Widget _buildCertificatesTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Official Degree & Certificate Branding",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Custom crests, borders, signatures and cryptographic anti-tamper verification",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Official Certificate Header
          Text(
            "Official Certificate Header",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _certHeaderController,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          // Affiliation & Autonomy Subtitle
          Text(
            "Affiliation & Autonomy Subtitle",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _certAffiliationController,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF1E293B),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          // Border Ornamentation Style
          Text(
            "Border Ornamentation Style",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _certBorderStyle,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF1E293B),
            ),
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: "Classic Gold Guilloche (Heritage Seal)",
                child: Text("Classic Gold Guilloche (Heritage Seal)"),
              ),
              DropdownMenuItem(
                value: "Prestige Silver Filigree",
                child: Text("Prestige Silver Filigree"),
              ),
              DropdownMenuItem(
                value: "Royal Academic Double-Border",
                child: Text("Royal Academic Double-Border"),
              ),
              DropdownMenuItem(
                value: "Modern Minimalist Line",
                child: Text("Modern Minimalist Line"),
              ),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _certBorderStyle = val);
            },
          ),
          const SizedBox(height: 16),

          // Two Column Signatories
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth >= 540;
              final leftField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Primary Signatory (Left)",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _primarySignatoryController,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              );

              final rightField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Secondary Signatory (Right)",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _secondarySignatoryController,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              );

              if (isTwoCol) {
                return Row(
                  children: [
                    Expanded(child: leftField),
                    const SizedBox(width: 16),
                    Expanded(child: rightField),
                  ],
                );
              }
              return Column(
                children: [
                  leftField,
                  const SizedBox(height: 16),
                  rightField,
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Two Checkbox Cards (Image 1 bottom cards)
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth >= 540;

              final qrCard = Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
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
                            "Anti-Fraud QR Verification",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Print verifiable instant validation code on each PDF",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Checkbox(
                      value: _antiFraudQr,
                      activeColor: const Color(0xFF131B4D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) => setState(() => _antiFraudQr = val ?? true),
                    ),
                  ],
                ),
              );

              final watermarkCard = Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
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
                            "Background Security Watermark",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Subtle heraldic watermark to deter photocopies",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Checkbox(
                      value: _backgroundWatermark,
                      activeColor: const Color(0xFF131B4D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) => setState(() => _backgroundWatermark = val ?? true),
                    ),
                  ],
                ),
              );

              if (isTwoCol) {
                return Row(
                  children: [
                    Expanded(child: qrCard),
                    const SizedBox(width: 16),
                    Expanded(child: watermarkCard),
                  ],
                );
              }
              return Column(
                children: [
                  qrCard,
                  const SizedBox(height: 12),
                  watermarkCard,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5F. TAB 5: LANGUAGE & AI (Matches Image 2)
  // ===========================================================================
  Widget _buildLanguageAiTab() {
    final languageOptions = [
      "English",
      "Tamil",
      "Hindi",
      "Telugu",
      "Kannada",
      "Malayalam",
      "Bengali",
      "Marathi",
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Interface Language & AI Voice Localization",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Configure default regional languages for course delivery, study bot and portal UI",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Two Column Dropdowns (Image 2)
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth >= 540;

              final leftDropdown = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Default Interface Language",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _defaultInterfaceLanguage,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
                      ),
                    ),
                    items: languageOptions.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _defaultInterfaceLanguage = val);
                    },
                  ),
                ],
              );

              final rightDropdown = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Tutor Explanation Voice",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _aiTutorVoice,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF1E293B),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF131B4D), width: 1.5),
                      ),
                    ),
                    items: languageOptions.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _aiTutorVoice = val);
                    },
                  ),
                ],
              );

              if (isTwoCol) {
                return Row(
                  children: [
                    Expanded(child: leftDropdown),
                    const SizedBox(width: 16),
                    Expanded(child: rightDropdown),
                  ],
                );
              }
              return Column(
                children: [
                  leftDropdown,
                  const SizedBox(height: 16),
                  rightDropdown,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. REAL-TIME WHITE-LABEL PREVIEW CARD (Right Column)
  // ===========================================================================
  Widget _buildRealTimePreviewCard() {
    final previewTabs = [
      {"icon": Icons.dashboard_outlined, "title": "Student\nPortal"},
      {"icon": Icons.lock_outline_rounded, "title": "Login\nScreen"},
      {"icon": Icons.workspace_premium_outlined, "title": "Degree\nCertificate"},
      {"icon": Icons.mail_outline_rounded, "title": "Email\nAlert"},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & Device Toggles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF0F172A)),
                  const SizedBox(width: 6),
                  Text(
                    "Real-Time White-Label Preview",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _isMobilePreview = !_isMobilePreview),
                    icon: Icon(
                      _isMobilePreview ? Icons.laptop_mac_rounded : Icons.phone_android_rounded,
                      size: 16,
                      color: _isMobilePreview ? const Color(0xFF1E2A5A) : const Color(0xFF64748B),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: "Toggle Viewport",
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => setState(() => _isDarkModePreview = !_isDarkModePreview),
                    icon: Icon(
                      _isDarkModePreview ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      size: 16,
                      color: _isDarkModePreview ? const Color(0xFFF59E0B) : const Color(0xFF64748B),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: "Toggle Dark Preview",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Updates instantly as you customize colors, logos and branding",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // 4 Preview Selector Tabs
          Row(
            children: List.generate(previewTabs.length, (idx) {
              final pt = previewTabs[idx];
              final isSel = _previewTab == idx;

              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _previewTab = idx),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSel ? const Color(0xFF131B4D) : const Color(0xFFE2E8F0),
                          width: isSel ? 2.2 : 1.0,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          pt["icon"] as IconData,
                          size: 14,
                          color: isSel ? const Color(0xFF131B4D) : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pt["title"] as String,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                            color: isSel ? const Color(0xFF131B4D) : const Color(0xFF64748B),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Selected Preview Window
          _buildActivePreviewWindow(),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6A. ACTIVE PREVIEW CONTENT
  // ===========================================================================
  Widget _buildActivePreviewWindow() {
    switch (_previewTab) {
      case 0:
        return _buildStudentPortalPreview();
      case 1:
        return _buildLoginScreenPreview();
      case 2:
        return _buildDegreeCertificatePreview();
      case 3:
        return _buildEmailAlertPreview();
      default:
        return _buildStudentPortalPreview();
    }
  }

  // PREVIEW 1: Student Portal (Image 1)
  Widget _buildStudentPortalPreview() {
    final primaryColor = _parseHex(_primaryColorController.text, const Color(0xFF1E2A5A));
    final accentGold = _parseHex(_accentGoldController.text, const Color(0xFFC9962B));
    final secondaryTint = _parseHex(_secondaryTintController.text, const Color(0xFF0F766E));

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          // Nav Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.shield_rounded, size: 14, color: accentGold),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayNameController.text,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Student Academic Portal",
                          style: GoogleFonts.poppins(fontSize: 7.5, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: accentGold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _acronymController.text,
                        style: GoogleFonts.poppins(fontSize: 8.5, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      child: Text(
                        "SK",
                        style: GoogleFonts.poppins(fontSize: 7.5, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Welcome Card
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondaryTint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_termCycle.toUpperCase()} 6 • ACADEMIC YEAR $_academicYear",
                        style: GoogleFonts.poppins(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          letterSpacing: 0.4,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: accentGold,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "CGPA 8.94",
                          style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Welcome back, Saravanan K",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Text(
                    "$_studentIdLabel: 2026CS1101 • CSE Dept",
                    style: GoogleFonts.poppins(fontSize: 8.5, color: Colors.white.withValues(alpha: 0.85)),
                  ),
                  const SizedBox(height: 8),

                  // Statutory Badges
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      if (_naacBadge)
                        _buildSmallPill("★ NAAC A++", Colors.white.withValues(alpha: 0.2)),
                      if (_nbaBadge)
                        _buildSmallPill("NBA Accredited", Colors.white.withValues(alpha: 0.2)),
                      if (_aicteDisplay)
                        _buildSmallPill("AICTE EOA Approved", Colors.white.withValues(alpha: 0.2)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Two Stat Cards (Attendance & Upcoming Exam)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Attendance", style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF64748B))),
                        Text("94.2%", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        const SizedBox(height: 4),
                        Container(height: 3, width: 60, decoration: BoxDecoration(color: accentGold, borderRadius: BorderRadius.circular(2))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Upcoming Exam", style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF64748B))),
                        Text("Operating Systems", style: GoogleFonts.poppins(fontSize: 9.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)), maxLines: 1),
                        Text("Tomorrow, 09:30 AM", style: GoogleFonts.poppins(fontSize: 7.5, color: const Color(0xFF0F766E))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Footer
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "${_displayNameController.text} • Affiliated to TNTU",
              style: GoogleFonts.poppins(fontSize: 7.5, color: const Color(0xFF94A3B8)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // PREVIEW 2: Login Screen (Image 3)
  Widget _buildLoginScreenPreview() {
    final primaryColor = _parseHex(_primaryColorController.text, const Color(0xFF1E2A5A));
    final accentGold = _parseHex(_accentGoldController.text, const Color(0xFFC9962B));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.shield_rounded, color: accentGold, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                _displayNameController.text,
                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                textAlign: TextAlign.center,
              ),
              Text(
                "Official Single Sign-On Portal",
                style: GoogleFonts.poppins(fontSize: 8.5, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),

              // Inputs
              Align(
                alignment: Alignment.centerLeft,
                child: Text("$_studentIdLabel / Email", style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF475569))),
              ),
              const SizedBox(height: 3),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text("2026CS1101", style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF0F172A))),
              ),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF475569))),
              ),
              const SizedBox(height: 3),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text("••••••••••••", style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF0F172A))),
              ),
              const SizedBox(height: 12),

              // Sign in button
              Container(
                width: double.infinity,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Sign In to Portal",
                  style: GoogleFonts.poppins(fontSize: 9.5, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Domain: ${_customDomainController.text}",
                style: GoogleFonts.poppins(fontSize: 7.5, color: const Color(0xFF94A3B8)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PREVIEW 3: Degree Certificate (Image 4)
  Widget _buildDegreeCertificatePreview() {
    final accentGold = _parseHex(_accentGoldController.text, const Color(0xFFC9962B));

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentGold, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.shield_rounded, size: 24, color: accentGold),
          const SizedBox(height: 4),
          Text(
            _certHeaderController.text.isNotEmpty ? _certHeaderController.text.toUpperCase() : _displayNameController.text.toUpperCase(),
            style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A), letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ),
          Text(
            _certAffiliationController.text,
            style: GoogleFonts.poppins(fontSize: 6.5, fontStyle: FontStyle.italic, color: const Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          Text(
            "CERTIFICATE OF ACADEMIC ACHIEVEMENT",
            style: GoogleFonts.poppins(fontSize: 7.5, fontWeight: FontWeight.w800, color: const Color(0xFFB45309)),
          ),
          const SizedBox(height: 4),
          Text("This is to certify that", style: GoogleFonts.poppins(fontSize: 7, fontStyle: FontStyle.italic, color: const Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text("SARAVANAN K", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A))),
          const SizedBox(height: 2),
          Text(
            "has successfully completed all requirements for the\nBachelor of Technology in Computer Science & Artificial Intelligence",
            style: GoogleFonts.poppins(fontSize: 6.5, color: const Color(0xFF475569)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Signatures row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lakshmi S.", style: GoogleFonts.dancingScript(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
                  Text(_primarySignatoryController.text, style: GoogleFonts.poppins(fontSize: 5.5, color: const Color(0xFF64748B))),
                ],
              ),
              if (_antiFraudQr)
                Column(
                  children: [
                    Icon(Icons.qr_code_2_rounded, size: 22, color: const Color(0xFF0F172A)),
                    Text("VERIFY", style: GoogleFonts.poppins(fontSize: 5.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("K. Venkatesh", style: GoogleFonts.dancingScript(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
                  Text(_secondarySignatoryController.text, style: GoogleFonts.poppins(fontSize: 5.5, color: const Color(0xFF64748B)), textAlign: TextAlign.right),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // PREVIEW 4: Email Alert (Image 5)
  Widget _buildEmailAlertPreview() {
    final emailBanner = _parseHex(_emailBannerColorController.text, const Color(0xFF1E2A5A));
    final accentGold = _parseHex(_accentGoldController.text, const Color(0xFFC9962B));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: emailBanner,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: [
                Icon(Icons.shield_rounded, size: 16, color: accentGold),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_displayNameController.text, style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text(_emailSenderNameController.text, style: GoogleFonts.poppins(fontSize: 7, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),

          // Email Content Body
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("From: ${_fromEmailController.text}", style: GoogleFonts.poppins(fontSize: 7.5, color: const Color(0xFF64748B))),
                const SizedBox(height: 6),
                Text("Dear Saravanan K,", style: GoogleFonts.poppins(fontSize: 9.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                const SizedBox(height: 4),
                Text(
                  "Your course registration for $_termCycle 6 is confirmed. Please review your personalized timetable and syllabus units on the portal.",
                  style: GoogleFonts.poppins(fontSize: 8, color: const Color(0xFF475569), height: 1.35),
                ),
                const SizedBox(height: 10),

                // Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: emailBanner,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Access ${_acronymController.text} Portal →",
                    style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 8),

                Text(
                  _footerDisclaimerController.text,
                  style: GoogleFonts.poppins(fontSize: 6.5, color: const Color(0xFF94A3B8), height: 1.3),
                ),
                const SizedBox(height: 2),
                Text(
                  "Automated notification. Please do not reply directly to this email.",
                  style: GoogleFonts.poppins(fontSize: 6.5, color: const Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallPill(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 7.5, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  // ===========================================================================
  // 7. COMMON FORM WIDGETS
  // ===========================================================================
  Widget _buildColorInputField(String label, TextEditingController controller, Color defaultColor) {
    final currentColor = _parseHex(controller.text, defaultColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller, {String? helperText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
              items: items.map((it) {
                return DropdownMenuItem(value: it, child: Text(it));
              }).toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: value,
            activeColor: const Color(0xFF131B4D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (v) => onChanged(v ?? false),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleCheckboxTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Checkbox(
            value: value,
            activeColor: const Color(0xFF131B4D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (v) => onChanged(v ?? false),
          ),
        ],
      ),
    );
  }
}

typedef BrandingWhiteLabelScreen = PrincipalBrandingScreen;
