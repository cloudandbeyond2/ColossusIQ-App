import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalSecuritySettingsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalSecuritySettingsScreen({super.key, this.onBack});

  @override
  State<PrincipalSecuritySettingsScreen> createState() => _PrincipalSecuritySettingsScreenState();
}

class _PrincipalSecuritySettingsScreenState extends State<PrincipalSecuritySettingsScreen> {
  // Authentication & Identity Toggles
  bool _requireMfaStaff = true;
  bool _requireMfaStudents = false;
  bool _enterpriseSso = true;
  String _sessionTimeout = "30 minutes (Standard)";
  String _minPasswordLength = "12 characters (Recommended)";

  // Data Protection & AI Isolation Toggles
  bool _maskPersonalData = true;
  bool _allowTenantDataTraining = false;
  bool _useAttendanceEarlyWarning = false;
  String _aiRetention = "180 days (Semester Standard)";

  // Options
  final List<String> _timeoutOptions = [
    "15 minutes",
    "30 minutes (Standard)",
    "60 minutes",
    "120 minutes",
  ];

  final List<String> _passwordLengthOptions = [
    "8 characters",
    "10 characters",
    "12 characters (Recommended)",
    "16 characters (High Security)",
  ];

  final List<String> _aiRetentionOptions = [
    "30 days (Strict)",
    "90 days",
    "180 days (Semester Standard)",
    "365 days (Full Academic Year)",
    "Zero Retention (Ephemeral)",
  ];

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 18),
            const SizedBox(width: 8),
            Text(
              "Security policies saved and synchronized across all nodes.",
              style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _runDiagnostic() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Running institutional security diagnostic... All 14 security checks passed.",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        backgroundColor: const Color(0xFF0F1E5C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _revokeSessions() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "All active user sessions across campus have been revoked.",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        backgroundColor: const Color(0xFFB45309),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Image 2)
              _buildHeroBanner(),
              const SizedBox(height: 20),

              // 3. Institutional Security Posture KPI Card (Matches Image 2)
              _buildPostureCard(),
              const SizedBox(height: 20),

              // 4. Middle Section: Authentication & Identity + Compliance Frameworks (Matches Image 2)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 900;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Authentication & Identity
                        Expanded(
                          flex: 3,
                          child: _buildAuthCard(),
                        ),
                        const SizedBox(width: 20),
                        // Right: Compliance Frameworks & Live Audit
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildComplianceCard(),
                              const SizedBox(height: 18),
                              _buildLiveAuditCard(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  // Mobile / Tablet Stacked
                  return Column(
                    children: [
                      _buildAuthCard(),
                      const SizedBox(height: 20),
                      _buildComplianceCard(),
                      const SizedBox(height: 18),
                      _buildLiveAuditCard(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // 5. Data Protection & AI Isolation Card (Matches Image 3)
              _buildDataProtectionCard(),
              const SizedBox(height: 24),

              // 6. Bottom Action Bar (Matches Image 3)
              _buildBottomBar(),
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
            "Security Settings",
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
  // 2. BLUEPRINT HERO BANNER (Matches Image 2)
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
                painter: _BlueprintDarkGridPainter(),
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
                  Icons.shield_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shield Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
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
                        "Security Settings",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "MFA, SSO, session, password, data-retention and AI data policies.",
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
  // 3. POSTURE KPI CARD (Matches Image 2)
  // ===========================================================================
  Widget _buildPostureCard() {
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
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 740;

          final scoreWidget = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circular score badge: 80 / 100
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF10B981), width: 3.5),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "80",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                          height: 1.1,
                        ),
                      ),
                      Text(
                        "/ 100",
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title and badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "A Strong",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF047857),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "•  Real-Time Compliance Score",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Institutional Security Posture",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Calculated dynamically from active authentication, session timeout, and AI isolation controls.",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final actionsWidget = Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Run Diagnostic
              OutlinedButton.icon(
                onPressed: _runDiagnostic,
                icon: const Icon(Icons.verified_user_outlined, size: 15, color: Color(0xFF475569)),
                label: Text(
                  "Run Diagnostic",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              // Revoke Sessions
              OutlinedButton.icon(
                onPressed: _revokeSessions,
                icon: const Icon(Icons.sync_rounded, size: 15, color: Color(0xFF475569)),
                label: Text(
                  "Revoke Sessions",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              // Save Changes
              ElevatedButton.icon(
                onPressed: _saveSettings,
                icon: const Icon(Icons.check_rounded, size: 15, color: Colors.white),
                label: Text(
                  "Save changes",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B95A5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ],
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                scoreWidget,
                const SizedBox(height: 16),
                actionsWidget,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: scoreWidget),
              const SizedBox(width: 16),
              actionsWidget,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 4A. LEFT CARD: AUTHENTICATION & IDENTITY (Matches Image 2)
  // ===========================================================================
  Widget _buildAuthCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Authentication & Identity",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Applies to every user in the tenant with multi-factor authentication and session security.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),

          // Toggle 1: Require MFA for staff (Active)
          _buildToggleItem(
            icon: Icons.person_outline_rounded,
            title: "Require MFA for staff",
            desc: "Mandates 2-step verification (authenticator app) for all faculty and administrative accounts.",
            value: _requireMfaStaff,
            onChanged: (val) => setState(() => _requireMfaStaff = val),
          ),
          const SizedBox(height: 12),

          // Toggle 2: Require MFA for students (Inactive)
          _buildToggleItem(
            icon: Icons.school_outlined,
            title: "Require MFA for students",
            desc: "Enforces multi-factor authentication on student portal logins.",
            value: _requireMfaStudents,
            onChanged: (val) => setState(() => _requireMfaStudents = val),
          ),
          const SizedBox(height: 12),

          // Toggle 3: Enterprise SSO (Active)
          _buildToggleItem(
            icon: Icons.vpn_key_outlined,
            title: "Enterprise SSO (SAML / OIDC)",
            desc: "Allows campus Google Workspace, Microsoft 365, or Azure AD single sign-on.",
            value: _enterpriseSso,
            onChanged: (val) => setState(() => _enterpriseSso = val),
          ),
          const SizedBox(height: 20),

          // Dropdowns: Idle session timeout & Minimum password length
          LayoutBuilder(
            builder: (context, constraints) {
              final isStacked = constraints.maxWidth < 480;

              if (isStacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownField(
                      label: "Idle session timeout",
                      value: _sessionTimeout,
                      items: _timeoutOptions,
                      hint: "Automatically logs out inactive users.",
                      onChanged: (val) => setState(() => _sessionTimeout = val!),
                    ),
                    const SizedBox(height: 14),
                    _buildDropdownField(
                      label: "Minimum password length",
                      value: _minPasswordLength,
                      items: _passwordLengthOptions,
                      hint: "Enforces character complexity rules.",
                      onChanged: (val) => setState(() => _minPasswordLength = val!),
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      label: "Idle session timeout",
                      value: _sessionTimeout,
                      items: _timeoutOptions,
                      hint: "Automatically logs out inactive users.",
                      onChanged: (val) => setState(() => _sessionTimeout = val!),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildDropdownField(
                      label: "Minimum password length",
                      value: _minPasswordLength,
                      items: _passwordLengthOptions,
                      hint: "Enforces character complexity rules.",
                      onChanged: (val) => setState(() => _minPasswordLength = val!),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4B. RIGHT CARD 1: COMPLIANCE FRAMEWORKS (Matches Image 2)
  // ===========================================================================
  Widget _buildComplianceCard() {
    final frameworks = [
      {"name": "ISO 27001 / SOC 2", "status": "Compliant"},
      {"name": "FERPA Privacy Shield", "status": "Protected"},
      {"name": "AI Data Isolation", "status": "Zero-Retention"},
      {"name": "Staff Multi-Factor Auth", "status": "Enforced"},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
            "COMPLIANCE FRAMEWORKS",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 14),
          ...frameworks.map((f) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    f["name"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF334155),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      f["status"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF047857),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4C. RIGHT CARD 2: LIVE SECURITY AUDIT (Matches Image 2)
  // ===========================================================================
  Widget _buildLiveAuditCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LIVE SECURITY AUDIT",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.6,
                ),
              ),
              const Icon(
                Icons.access_time_rounded,
                size: 15,
                color: Color(0xFF94A3B8),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "No recent security events.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. DATA PROTECTION & AI ISOLATION CARD (Matches Image 3)
  // ===========================================================================
  Widget _buildDataProtectionCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Protection & AI Isolation",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Data privacy, automated anonymization, and generative AI guardrails.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),

          // Toggle 1: Mask personal data (Active)
          _buildToggleItem(
            icon: Icons.visibility_off_outlined,
            title: "Mask personal data before sending to models",
            desc: "Redacts student names, phone numbers, and roll numbers before LLM processing.",
            value: _maskPersonalData,
            onChanged: (val) => setState(() => _maskPersonalData = val),
          ),
          const SizedBox(height: 12),

          // Toggle 2: Allow tenant data for model training (Inactive)
          _buildToggleItem(
            icon: Icons.lock_outline_rounded,
            title: "Allow tenant data for model training",
            desc: "Off by default. Student and institutional academic data is strictly isolated and never used for model training without consent.",
            value: _allowTenantDataTraining,
            onChanged: (val) => setState(() => _allowTenantDataTraining = val),
          ),
          const SizedBox(height: 12),

          // Toggle 3: Use attendance in early-warning signals (Inactive)
          _buildToggleItem(
            icon: Icons.trending_up_rounded,
            title: "Use attendance in early-warning signals",
            desc: "Allows AI models to correlate attendance trends with academic risk indicators.",
            value: _useAttendanceEarlyWarning,
            onChanged: (val) => setState(() => _useAttendanceEarlyWarning = val),
          ),
          const SizedBox(height: 20),

          // Dropdown: AI conversation retention
          _buildDropdownField(
            label: "AI conversation retention",
            value: _aiRetention,
            items: _aiRetentionOptions,
            hint: "Retention window for chat and generation history.",
            onChanged: (val) => setState(() => _aiRetention = val!),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. BOTTOM ACTION BAR (Matches Image 3)
  // ===========================================================================
  Widget _buildBottomBar() {
    return Wrap(
      spacing: 16,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _saveSettings,
          icon: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
          label: Text(
            "Save changes",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B95A5),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_rounded,
              size: 16,
              color: Color(0xFF059669),
            ),
            const SizedBox(width: 6),
            Text(
              "All policies synchronized",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF059669),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // REUSABLE TOGGLE ITEM (Matches Images 2 & 3)
  // ===========================================================================
  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String desc,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? const Color(0xFFA7F3D0) : const Color(0xFFE2E8F0),
          width: value ? 1.4 : 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 19,
              color: value ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFF059669),
            activeTrackColor: const Color(0xFFA7F3D0),
            inactiveThumbColor: const Color(0xFFCBD5E1),
            inactiveTrackColor: const Color(0xFFF1F5F9),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // REUSABLE DROPDOWN FIELD (Matches Images 2 & 3)
  // ===========================================================================
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
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
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hint,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// GRID PAINTER
// =============================================================================
class _BlueprintDarkGridPainter extends CustomPainter {
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

typedef SecuritySettingsScreen = PrincipalSecuritySettingsScreen;
