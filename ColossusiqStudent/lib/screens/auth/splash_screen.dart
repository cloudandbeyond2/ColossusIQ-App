import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import '../main_navigation_screen.dart';
import '../../core/services/auth_session_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  Timer? _sessionTimer;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    _entranceController.forward();
    _checkExistingSession();
  }

  Future<void> _checkExistingSession() async {
    final bool loggedIn = await AuthSessionService.isLoggedIn();
    if (loggedIn && mounted) {
      _sessionTimer = Timer(const Duration(milliseconds: 2200), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigationScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      });
    }
  }

  void _navigateToLogin() {
    _sessionTimer?.cancel();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _entranceController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Ambient Background Light Mesh & Subtle Grid Dots
          _buildAmbientBackground(),

          // Full-Screen Layout
          Positioned.fill(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxHeight < 80 || constraints.maxWidth < 80) {
                    return const SizedBox.shrink();
                  }
                  final isDesktop = constraints.maxWidth >= 960;

                  return Column(
                    children: [
                      // 1. Top Modern Navigation Bar
                      _buildTopNavBar(isDesktop),

                      // 2. Full-Screen Main Hero Body
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 48 : 24,
                            vertical: isDesktop ? 20 : 16,
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: isDesktop
                                  ? _buildDesktopHero(constraints)
                                  : _buildMobileHero(),
                            ),
                          ),
                        ),
                      ),

                      // 3. Bottom Action Bar with Get Started Button
                      _buildBottomSection(isDesktop),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. TOP MODERN NAVIGATION BAR
  // ===========================================================================
  Widget _buildTopNavBar(bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 28, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.90),
            border: const Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Institution Brand
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.25),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                              letterSpacing: -0.4,
                            ),
                          ),
                          TextSpan(
                            text: "IQ",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF2563EB),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isNarrow) ...[
                      const SizedBox(width: 12),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            "Anna Institute of Technology",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (constraints.maxWidth >= 340) ...[
                const SizedBox(width: 8),

                // Academic Year Live Badge
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x6610B981),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            isNarrow ? "AY 26-27" : "Academic Year 2026-27 · Live",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1D4ED8),
                              letterSpacing: 0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // 2. DESKTOP FULL-SCREEN HERO (2-COLUMN SPLIT SHOWCASE)
  // ===========================================================================
  Widget _buildDesktopHero(BoxConstraints constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Headline, Description & CTAs
        Expanded(
          flex: 11,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Live Status Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Academic Session 2026-2027 Live · Ver 2.6",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D4ED8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Giant Hero Headline
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    height: 1.15,
                    letterSpacing: -1.0,
                  ),
                  children: const [
                    TextSpan(text: "The Intelligent\nOperating System for\n"),
                    TextSpan(
                      text: "Higher Education.",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Description
              Text(
                "Unifying student academic journeys, faculty evaluations, departmental intelligence, and institutional leadership with zero-trust security and generative AI.",
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  color: const Color(0xFF475569),
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons Row
              Row(
                children: [
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _navigateToLogin,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                      label: Text(
                        "Get Started",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: _navigateToLogin,
                    icon: const Icon(Icons.login_rounded, size: 18, color: Color(0xFF1D4ED8)),
                    label: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D4ED8),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFBFDBFE), width: 1.5),
                      backgroundColor: const Color(0xFFEFF6FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 38),

              // Live Campus Stats Ticker
              Row(
                children: [
                  _buildMetricItem("12,450+", "Active Students"),
                  _buildVerticalDivider(),
                  _buildMetricItem("99.98%", "Platform Uptime"),
                  _buildVerticalDivider(),
                  _buildMetricItem("100%", "Tamper-proof Certs"),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right Column: Floating Interactive Mockup Cards
        Expanded(
          flex: 10,
          child: AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: _buildShowcaseMockup(),
              );
            },
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. RIGHT SHOWCASE MOCKUP (INTERACTIVE DASHBOARD PREVIEWS)
  // ===========================================================================
  Widget _buildShowcaseMockup() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mock Window Header
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
                    const Icon(Icons.lock_rounded, size: 11, color: Color(0xFF64748B)),
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
          const SizedBox(height: 20),

          // Card 1: Live Institutional Pulse
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.analytics_rounded, color: Color(0xFF15803D), size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Institutional Pulse · 94.2% Attendance",
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        "CSE, ECE, Mech & Civil data synced in real-time.",
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Optimal",
                    style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF047857)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Card 2: AI Curriculum & Exam Engine
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF2563EB), size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI Exam & Question Vault",
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        "Bloom's taxonomy balanced with AICTE compliance.",
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Verified",
                    style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF1D4ED8)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Card 3: Cryptographic Credentials
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.verified_rounded, color: Color(0xFFB45309), size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tamper-proof Certificate Authority",
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        "HSM signed QR seals with instant public verification.",
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Signed",
                    style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFFB45309)),
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
  // 4. MOBILE HERO LAYOUT
  // ===========================================================================
  Widget _buildMobileHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 12),
        // Logo & Emblem
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.school_rounded, color: Colors.white, size: 38),
        ),
        const SizedBox(height: 20),

        // Brand
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Colossus",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              TextSpan(
                text: "IQ",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
        const SizedBox(height: 16),

        Text(
          "Unified intelligence and workflow automation for students, faculty, and administration.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF475569),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 22),

        // Live preview card for mobile
        _buildShowcaseMockup(),
        const SizedBox(height: 16),
      ],
    );
  }

  // ===========================================================================
  // 5. METRIC WIDGET HELPER
  // ===========================================================================
  Widget _buildMetricItem(String val, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 36,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: const Color(0xFFE2E8F0),
    );
  }

  // ===========================================================================
  // 6. BOTTOM ACTION BAR (GET STARTED BUTTON ONLY)
  // ===========================================================================
  Widget _buildBottomSection(bool isDesktop) {
    if (isDesktop) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: _navigateToLogin,
            icon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
            label: Text(
              "Get Started",
              style: GoogleFonts.poppins(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              elevation: 2,
              shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.35),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 7. AMBIENT BACKGROUND
  // ===========================================================================
  Widget _buildAmbientBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _LightDotsPainter())),
              Positioned(
                top: -80 + (15 * _pulseAnimation.value),
                right: 60,
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.10),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: 40,
                child: Container(
                  width: 380,
                  height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// SUBTLE LIGHT BACKGROUND DOTS PAINTER
// =============================================================================
class _LightDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1).withValues(alpha: 0.35)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.4;

    const double step = 28.0;

    for (double x = 14; x < size.width; x += step) {
      for (double y = 14; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
