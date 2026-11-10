import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_screen.dart';

class StudentProfile {
  final String role;
  final String name;
  final String designation;
  final String email;
  final String password;
  final String college;

  const StudentProfile({
    required this.role,
    required this.name,
    required this.designation,
    required this.email,
    required this.password,
    required this.college,
  });
}

/// Ultra-Modern, Responsive Full-Screen Student Portal Sign In
/// Features a 2-column split on desktop (Image 2 Showcase + Modern Form)
/// and a responsive tabbed/fluid view on mobile and tablet.
class LoginScreen extends StatefulWidget {
  final bool wasSignedOut;

  const LoginScreen({
    super.key,
    this.wasSignedOut = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = true;
  String _selectedCollege = "Anna Institute of Technology";

  final List<String> _colleges = [
    "Anna Institute of Technology",
    "Kaveri Engineering College",
    "Kongu Arts & Science College",
    "CSM Institute of Technology",
    "Vaigai Polytechnic College",
  ];

  static const StudentProfile defaultStudent = StudentProfile(
    role: "Student",
    name: "Anand R",
    designation: "22CS104 · B.E. Computer Science",
    email: "student1@ait.edu.in",
    password: "password123",
    college: "Anna Institute of Technology",
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: defaultStudent.email);
    _passwordController = TextEditingController(text: defaultStudent.password);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => VerifyScreen(
            email: _emailController.text.trim().isNotEmpty
                ? _emailController.text.trim()
                : defaultStudent.email,
            role: "Student",
            name: defaultStudent.name,
            designation: defaultStudent.designation,
            college: _selectedCollege,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    });
  }

  void _showCollegePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Campus / Institution",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._colleges.map((col) {
                  final isSelected = col == _selectedCollege;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedCollege = col);
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF93C5FD) : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: 18,
                            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              col,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF334155),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: Color(0xFF2563EB),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 980;

          if (isDesktop) {
            return Row(
              children: [
                // 1. LEFT: FULL-SCREEN SHOWCASE (MATCHING IMAGE 2)
                Expanded(
                  flex: 52,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Top bar inside showcase
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildBrandLogo(),
                              _buildAyBadge(),
                            ],
                          ),
                          const SizedBox(height: 36),

                          // Center Hero with 3D Cap Icon
                          _buildCenterHeroContent(),
                          const SizedBox(height: 32),

                          // Interactive Browser Mockup Window
                          AnimatedBuilder(
                            animation: _floatAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _floatAnimation.value),
                                child: _buildBrowserMockup(),
                              );
                            },
                          ),
                          const SizedBox(height: 28),

                          // Compliance Footer
                          _buildSecurityBadge(),
                        ],
                      ),
                    ),
                  ),
                ),

                // 2. RIGHT: CLEAN, MODERN FULL-SCREEN LOGIN FORM
                Expanded(
                  flex: 48,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 36),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: _buildLoginFormCard(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Mobile & Tablet Responsive Full Screen View (Centered with Equal Top & Bottom Gaps)
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 32 ? constraints.maxHeight - 32 : 0,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Top Row Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBrandLogo(),
                          _buildAyBadge(),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Spacer(),

                      // Centered Sign In Card with Equal Gaps
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: _buildLoginFormCard(),
                          ),
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // TOP BRAND LOGO & AY BADGE (MATCHING IMAGE 2)
  // ===========================================================================
  Widget _buildBrandLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.school_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Colossus",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.4,
                ),
              ),
              TextSpan(
                text: "IQ",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2563EB),
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAyBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            "AY 26-27",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D4ED8),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CENTER HERO ICON & TYPOGRAPHY (MATCHING IMAGE 2)
  // ===========================================================================
  Widget _buildCenterHeroContent() {
    return Column(
      children: [
        // 3D Graduation Cap Icon with Glow
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Brand Name
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Colossus",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.6,
                ),
              ),
              TextSpan(
                text: "IQ",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2563EB),
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // ACADEMIC OPERATING SYSTEM Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4.5),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Text(
            "ACADEMIC OPERATING SYSTEM",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D4ED8),
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            "Unified intelligence and workflow automation for students, faculty, and administration.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // BROWSER MOCKUP WITH 3 FEATURE CARDS (MATCHING IMAGE 2)
  // ===========================================================================
  Widget _buildBrowserMockup() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 460),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Browser Top Control Strip
          Row(
            children: [
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_rounded, size: 10, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Text(
                      "secure.colossusiq.ait.edu",
                      style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Feature Card 1: Institutional Pulse
          _mockFeatureCard(
            icon: Icons.bar_chart_rounded,
            iconBg: const Color(0xFFDCFCE7),
            iconColor: const Color(0xFF15803D),
            title: "Institutional Pulse · 94.2% Attendance",
            desc: "CSE, ECE, Mech & Civil data synced in real-time.",
            badgeText: "Optimal",
            badgeBg: const Color(0xFFD1FAE5),
            badgeColor: const Color(0xFF047857),
          ),
          const SizedBox(height: 12),

          // Feature Card 2: AI Exam & Question Vault
          _mockFeatureCard(
            icon: Icons.auto_awesome_rounded,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
            title: "AI Exam & Question Vault",
            desc: "Bloom's taxonomy balanced with AICTE compliance.",
            badgeText: "Verified",
            badgeBg: const Color(0xFFDBEAFE),
            badgeColor: const Color(0xFF1D4ED8),
          ),
          const SizedBox(height: 12),

          // Feature Card 3: Tamper-proof Certificate Authority
          _mockFeatureCard(
            icon: Icons.verified_rounded,
            iconBg: const Color(0xFFFEF3C7),
            iconColor: const Color(0xFFB45309),
            title: "Tamper-proof Certificate Authority",
            desc: "HSM signed QR seals with instant public verification.",
            badgeText: "Signed",
            badgeBg: const Color(0xFFFEF3C7),
            badgeColor: const Color(0xFFB45309),
          ),
        ],
      ),
    );
  }

  Widget _mockFeatureCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String desc,
    required String badgeText,
    required Color badgeBg,
    required Color badgeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badgeText,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF059669)),
        const SizedBox(width: 6),
        Text(
          "Zero-Trust TLS 1.3 • AICTE & NEP 2020 Compliant",
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // MAIN LOGIN FORM CARD (CLEAN & MODERN)
  // ===========================================================================
  Widget _buildLoginFormCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Badge: Student Access & Version
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "STUDENT ACCESS",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1D4ED8),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "v2.4",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Card Title & Subtitle
            Text(
              "Student Portal Sign In",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Sign in with your student register number or college email.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF64748B),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),

            // Campus Selector Dropdown
            _buildCampusSelector(),
            const SizedBox(height: 16),

            // Student Email / Register No. Field
            _buildEmailField(),
            const SizedBox(height: 16),

            // Password Field
            _buildPasswordField(),
            const SizedBox(height: 14),

            // Remember Me & Forgot Password Row
            _buildRememberForgotRow(),
            const SizedBox(height: 20),

            // Primary Sign In Button
            _buildSignInButton(),
            const SizedBox(height: 12),

            // SSO Button
            _buildSsoButton(),
            const SizedBox(height: 24),

            // Footer
            Center(
              child: Text(
                "© 2026 ColossusIQ · Secure Student Portal Access",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- CAMPUS SELECTOR (MATCHING IMAGE 1) ---
  Widget _buildCampusSelector() {
    return InkWell(
      onTap: _showCollegePicker,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFDE68A)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD97706),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Campus: ",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFB45309),
              ),
            ),
            Expanded(
              child: Text(
                _selectedCollege,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF78350F),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.unfold_more_rounded,
              size: 18,
              color: Color(0xFFB45309),
            ),
          ],
        ),
      ),
    );
  }

  // --- EMAIL FIELD ---
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student Email / Register No.",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _emailController,
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.alternate_email_rounded, size: 18, color: Color(0xFF64748B)),
            hintText: "student1@ait.edu.in",
            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) return "Please enter your student email or register number.";
            return null;
          },
        ),
      ],
    );
  }

  // --- PASSWORD FIELD ---
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: Color(0xFF64748B)),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 18,
                color: const Color(0xFF64748B),
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            hintText: "••••••••••",
            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) return "Please enter your password.";
            return null;
          },
        ),
      ],
    );
  }

  // --- REMEMBER ME & FORGOT PASSWORD ---
  Widget _buildRememberForgotRow() {
    return Row(
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (val) => setState(() => _rememberMe = val ?? true),
            activeColor: const Color(0xFF2563EB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: Text(
            "Remember me",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Contact your campus administrative office or student cell to reset password."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Text(
            "Forgot password?",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB),
            ),
          ),
        ),
      ],
    );
  }

  // --- SIGN IN BUTTON ---
  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "Sign in to StudentApp",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // --- SSO BUTTON ---
  Widget _buildSsoButton() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: OutlinedButton(
        onPressed: () {
          _handleSignIn();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security_rounded, size: 16, color: Color(0xFF475569)),
            const SizedBox(width: 8),
            Text(
              "Sign in with Student SSO",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
